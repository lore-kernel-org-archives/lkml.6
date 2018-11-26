Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 760B2C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AD1F20660
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ossystems-com-br.20150623.gappssmtp.com header.i=@ossystems-com-br.20150623.gappssmtp.com header.b="pkk20jab"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AD1F20660
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ossystems.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbeKZWw7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 17:52:59 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34522 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbeKZWw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 17:52:59 -0500
Received: by mail-oi1-f196.google.com with SMTP id h25so15563968oig.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 03:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ossystems-com-br.20150623.gappssmtp.com; s=20150623;
        h=from:mime-version:references:in-reply-to:date:message-id:subject:to
         :cc;
        bh=U4fWpuyq/k38XZmUuDsKJlXblVWtlWPpXb00xjYs2ZI=;
        b=pkk20jabk405B12aacnGgvBt4w436H0TzIejUCX4iwlW6kvYNVAd4I8jTOKKF1j9Th
         0urm2h0jxsBc1Cb37vvK27ojcOjrqqSEhVnvCt5iZeOmT4NRxkMcXALRxxe97/XVvXLq
         09DcKO40P70W5QxBtPT8s0IIY4bG22bL1yrJhd8GR/U6uCUDbVD1COod+vM8oQfOKkvN
         bCKmTxKNyxIMPmkZcuq/pUtJjhijIpmSCUEEqIrdpXfKVY3im/JlBCQ0UgLKOZj+xOVC
         LHg+9dJ4G21mAIbA7b58E4WWToPWfSbZ0n56V70oAst/Flw1FiFzEv198V6wy4CEiuM/
         aqUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:mime-version:references:in-reply-to:date
         :message-id:subject:to:cc;
        bh=U4fWpuyq/k38XZmUuDsKJlXblVWtlWPpXb00xjYs2ZI=;
        b=ZsmYDmBbhp7vZJSuUujF0eDUu5BhcIs13zVNjCzeF5/rzQQfU+srk9o6i0dRly4RI9
         ymP7Ncq8LTNuYjmm8W8fpz1a7EmloZyKeDhNHT4HYsyZ5BXM5Bgq7FZqr4SsLd8OCRz8
         DVen4Ej0X2xhI62TYq/J41Oit9qYyZRO2dis0DjofCGXGhNneIz9zizQB6ig5zmnud8k
         XhRFc6Slq9HJE+MW5Fde+cXq9TB36s4Ro0pgSuIY5ZdAYlxFW5gHnGlPhngbOUEO369E
         YAjz9aT4HgTVkLGm/48XiekEdYHrepz81VIVIA7rGFmsz/9qVwfeQ7qcVqdBmau3KPif
         BGYw==
X-Gm-Message-State: AA+aEWblVUtclpTi1Aywq7nop6OwYkfQXBYtpG06AsiHk89oiIDy/1px
        19kiEeSm0scrWw+P+EFcDsKSUQ==
X-Google-Smtp-Source: AFSGD/XUq31dmMa8Fzl0rvySIGYjubdKn6fFCLG8XKmtCL6/aMHUc/GGlO6cS0ycgz2t8VIDebFe8Q==
X-Received: by 2002:aca:3541:: with SMTP id c62mr4690726oia.330.1543233543718;
        Mon, 26 Nov 2018 03:59:03 -0800 (PST)
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com. [209.85.210.46])
        by smtp.gmail.com with ESMTPSA id v141sm34683oia.25.2018.11.26.03.59.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 03:59:02 -0800 (PST)
From:   Otavio Salvador <otavio.salvador@ossystems.com.br>
X-Google-Original-From: Otavio Salvador <otavio@ossystems.com.br>
Received: by mail-ot1-f46.google.com with SMTP id g27so16288043oth.6;
        Mon, 26 Nov 2018 03:59:01 -0800 (PST)
X-Received: by 2002:a9d:3095:: with SMTP id s21mr15748808otc.359.1543233541440;
 Mon, 26 Nov 2018 03:59:01 -0800 (PST)
MIME-Version: 1.0
References: <20181125211427.4926-1-otavio@ossystems.com.br> <2374110.cSv9E7W1qs@phil>
In-Reply-To: <2374110.cSv9E7W1qs@phil>
Date:   Mon, 26 Nov 2018 09:58:49 -0200
X-Gmail-Original-Message-ID: <CAP9ODKoVG0ceSdRdpMz705=a9Wh0vubE6=ja=bwSF35ORzVOwA@mail.gmail.com>
Message-ID: <CAP9ODKoVG0ceSdRdpMz705=a9Wh0vubE6=ja=bwSF35ORzVOwA@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: dts: rv1108: enable eMMC support
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Otavio Salvador <otavio@ossystems.com.br>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Kernel development list <linux-kernel@vger.kernel.org>,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 7:03 AM Heiko Stuebner <heiko@sntech.de> wrote:
> Am Sonntag, 25. November 2018, 22:14:27 CET schrieb Otavio Salvador:
> > Enable eMMC support for rv1108.dtsi as it can be used across multiple
> > boards.
> >
> > Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
>
> applied for 4.21 after reordering the emmc pinctrl nodes a bit
> and modifying the suject + commit message to be a bit more specific
> in that we only add the common pin settings.

Which tree is it applied? I'd like to rebase the patches on top of it.

-- 
Otavio Salvador                             O.S. Systems
http://www.ossystems.com.br        http://code.ossystems.com.br
Mobile: +55 (53) 9 9981-7854          Mobile: +1 (347) 903-9750
