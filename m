Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF2DC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 04:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DC7320859
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 04:41:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NqzmbTg8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727766AbfAOElf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 23:41:35 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37584 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727300AbfAOEle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 23:41:34 -0500
Received: by mail-wm1-f66.google.com with SMTP id g67so1814672wmd.2;
        Mon, 14 Jan 2019 20:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nkWbQeeZZqOQHoiCzF2orNqjxrcoTi6C42m9bZwQHQs=;
        b=NqzmbTg8Ga8JSRfjctmuGTorGceM4hkXE65okF/LlYidngSBgyyu0qIIL1L4PiKK9T
         3fnpVDe+N5eCJEDiK5LbHe3ugblRbXGRox05j8ZU9veoN08o8MM96YWAqIcO+JPpPXGW
         iCKWA3UeO9eWPn2qOLb+bk1uFFXfEgTdJ00RR1HtCEmGGuEetXmBd0/ATS+QTYe/68pS
         N0zJSTQR8zM2jJpvWm0CsPcuzSZe4KOM85S1VZnLBmctaHiNnRmdDp1fblvhCg/A+KeU
         MDxZ9vYTtoW6rtlKPOJPLKqOEvwJ1g5p504++prDDPgfDeKCmX/Si4fw/PFEeE+WJiqM
         LT0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nkWbQeeZZqOQHoiCzF2orNqjxrcoTi6C42m9bZwQHQs=;
        b=MEXNbrcdup20OeF2D9lLi36if21kCdWosNrW2Eqh3TidwCElt6XR/ZVMUwehpcIOBs
         AEq5aRjGJclZvwENt+HBwUjFAFBk2hb45gM5sjSSydYrzNqW8REW++/pEQA3MMrSvl+J
         TMW+1DXYQ/Y7jKWymh13onv289+RmxGoonU2HfH4khtFkrPFjupm4C+gvJfs04hshCU6
         aMJyjFnS1N2MgpG9N09DeJi4Anyp8+yKFX7e7HObGZxQxGt6yjAbe4pushYhQei2zq/T
         TI5+tbKtLU7DAEyomUL68KalI9HJvHQOje0sE4aIc5sq/8HDUSLLBLWZClvIGcwwGkeA
         EYBQ==
X-Gm-Message-State: AJcUukeZ27yTnQJtOLikwKJDBNNfRqp8yQ2bzbycei2JGJ34Ly70rh4N
        WWxYm8TYPq5wDr0EiYceFbTmU+IaOHeuzyBmToU=
X-Google-Smtp-Source: ALg8bN4jSL6VkIjQd8K94ljKxhwYMjZ0GYciB7UhEtpjV38WRfWenm0gUd7vI4CxVsnzSn1cUlr7843W0xEwYJoY3Bk=
X-Received: by 2002:a1c:c10f:: with SMTP id r15mr1639313wmf.27.1547527292713;
 Mon, 14 Jan 2019 20:41:32 -0800 (PST)
MIME-Version: 1.0
References: <20181220010700.8598-1-andrew.smirnov@gmail.com>
In-Reply-To: <20181220010700.8598-1-andrew.smirnov@gmail.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Mon, 14 Jan 2019 20:41:21 -0800
Message-ID: <CAHQ1cqExs8MVoYUXE9tR3SBrKwG6+Los+DM6AgBTx8OGpvB6rA@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] Reset controller support for i.MX8MQ
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Rob Herring <robh@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2018 at 5:07 PM Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
>
> Everyone:
>
> This patch contains changes I made in order to add support for i.MX8MQ
> to reset-imx7.c in order to enable support of PCIE IP block on i.MX8MQ
> SoCs.
>
> Feedback is welcome!
>
> Thanks,
> Andrey Smirnov
>

Philipp, are there any changes that needs to be made to this series,
or is it good enough to be accepted?

Thanks,
Andrey Smirnov
