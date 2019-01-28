Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53000C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 13:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 181852087F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 13:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XWWjD84E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbfA1Nnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 08:43:55 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:47093 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbfA1Nny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 08:43:54 -0500
Received: by mail-lf1-f68.google.com with SMTP id f5so11833728lfc.13
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 05:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KSSQy5S6QE7RDBm3NS+S4YIXbwfX8BbfMaGVRtuBv0E=;
        b=XWWjD84Epz7vnqMkXSHZVCUq/sjp/B6pTtUdidS/5oy24oLuLFTUDYjFSyvcpccNQN
         R78w2Y2yixr2F2QRXssOo3isRniZswRW+G9MMRg1sTXKA/QQE/5/71Gd45Tts1CFhrfL
         uE2JGRMhls3fGI5CfFoaym4r9Pz1j8EwJ5Id8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KSSQy5S6QE7RDBm3NS+S4YIXbwfX8BbfMaGVRtuBv0E=;
        b=CaCXDse+NzmmonnDzvTLK65hd+YbRGIuuiTImoLksYDznpT7OvZeerPUDno1I4dnGC
         CU35DvKjEicEGIGmT9krI9ug35f05oug/nL+svN9FASSARtKfr7LuS0wbKmitr99MMr4
         E7vtNT3EikBrstPXxdhaxv5iE4FaXmF2wQxWw7j2AAJgXV3zA/QrbcSX6hq1X6aGfvU8
         RVhK/qoxz51tPHp5tI3Qq9GDiQKB2cRlnmG/Pqqh2Zdc9QehIa5ZwBOSbv1mXrcWwLQC
         yzN4vbOpdi2U8y6nQ8jOAGUfzovcgHAPLitkgFxy3aMzV2Uxfq2rOFh0EkSTRWDqfVTC
         5h2w==
X-Gm-Message-State: AJcUukdYX6MR9pOxreCX3YIiMKRtGES9FCT/4qbIkvecp14319ETX3Ud
        xUYV98DpOF5t3+S+omJFSWOc2J2qWJlFp3qflmVLrA==
X-Google-Smtp-Source: ALg8bN6jhe7J5o0PZRdUP/xOMN6ZHj21qHLi7KUc3yGZo1mvObn/9lPcX5QETWqo41Lqs46p28KfdyrleyM0jtlA0fg=
X-Received: by 2002:a19:db82:: with SMTP id t2mr16334927lfi.130.1548683032916;
 Mon, 28 Jan 2019 05:43:52 -0800 (PST)
MIME-Version: 1.0
References: <20190123084140.16524-1-yuehaibing@huawei.com>
In-Reply-To: <20190123084140.16524-1-yuehaibing@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 28 Jan 2019 14:43:41 +0100
Message-ID: <CACRpkdb0V5e5=OgaFe=jPubEV-JaDNpEGNjE24SjZAAuEtMweQ@mail.gmail.com>
Subject: Re: [PATCH -next] pinctrl: sirf: drop pointless static qualifier in sirfsoc_gpio_probe
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Barry Song <baohua@kernel.org>, Kees Cook <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 9:42 AM YueHaibing <yuehaibing@huawei.com> wrote:

> There is no need to have the 'sgpio' variable static since new
> value always be assigned before use it.
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Patch applied.

I haven't heard from the SirfSoC people in some time, I wonder
if they still actively maintain this file?

Yours,
Linus Walleij
