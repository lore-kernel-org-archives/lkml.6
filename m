Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5ED4C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 18:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90F27270BC
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 18:13:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZJXP+bgT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90F27270BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967741AbeF1SNv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 14:13:51 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:37486 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965459AbeF1SNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 14:13:48 -0400
Received: by mail-it0-f68.google.com with SMTP id p17-v6so8942549itc.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 11:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iijcQkCVoVXsqrRqKTvNawFaBQrDEKhwo1aCgbsJGcM=;
        b=ZJXP+bgTVwVL1b/2BxXOrseivqpQqcX3+KP//02PKG6CtHtlRLOS8DeOiebc6BeWv9
         jg3JmOx+8aD0QxUO+Py7L43j37ANpts22bVR6Nvizq5VwXTu4V5jLSIVCaE4yy2N++O1
         XsH/+kJDIgeCCyQ8dz/XP+bGTPUzgh+N65ET0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iijcQkCVoVXsqrRqKTvNawFaBQrDEKhwo1aCgbsJGcM=;
        b=Gj9VAts2cCBToTgWhhxe+7DfpjteLTSJG7ekLSBbx01vqWbtvO6WXNUMwMqdyrmWaa
         Jbr2cgUIU9+to+QkcO3qa6kuJCXWQ9UXBax3nVpZ4ppapqBfN+JnJTnHQnHMmQMarV49
         9OpSrGdjbaGoYVlDoPveocz3b7ugOSBVjkvZ/KuJPQE7qL5nVzWwmpkPcdjTpnIkhmhC
         Dg7NVc+y/7MYq2cla6/OeKPBezHtcfFrXEkPAApj6f21jXRSAUZi6GIwiXsU7974hAHu
         rVRPJyh6aBVzg4W2CTgCnkbmzp1xEyulQyMwCa/YL7BwC5jF/rCkY7MqIMauMSonAuIy
         wXpA==
X-Gm-Message-State: APt69E2ipCDwjlJlCsL84ueTShDzbmvlid6lW5YWPqTlWuqEOCyvyUsV
        Bmo84BEp/KLmwMxNiZ7ZY/g4DrrDi2VSPY6VLd6k6A==
X-Google-Smtp-Source: AAOMgpcM3kJg4FpRbzH42r+Mf1J4jJguN55EeBTUHRFkEuACQQfiWRjCh8sB+7lLvYenSQYL+GyKRWJ7YxCtNWXWKgg=
X-Received: by 2002:a24:8989:: with SMTP id s131-v6mr9225055itd.70.1530209627902;
 Thu, 28 Jun 2018 11:13:47 -0700 (PDT)
MIME-Version: 1.0
References: <1529563351-2241-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
 <1529563351-2241-5-git-send-email-naga.sureshkumar.relli@xilinx.com>
 <CACRpkdaEsEAiGpieJK1AA8HHLzZc7Tdc932rhdayg06rFU1hNA@mail.gmail.com> <MWHPR02MB26232270DED605627B2CF22FAF4F0@MWHPR02MB2623.namprd02.prod.outlook.com>
In-Reply-To: <MWHPR02MB26232270DED605627B2CF22FAF4F0@MWHPR02MB2623.namprd02.prod.outlook.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 28 Jun 2018 20:13:35 +0200
Message-ID: <CACRpkdZb6NMHtai1DBa+7m2ieZJZiAB7d1vSuP376rHQKpOf+A@mail.gmail.com>
Subject: Re: [[LINUX PATCH v10] 4/4] mtd: rawnand: pl353: Add basic driver for
 arm pl353 smc nand interface
To:     nagasure@xilinx.com
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Mark Vasut <marek.vasut@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Markus Mayer <mmayer@broadcom.com>,
        Roger Quadros <rogerq@ti.com>,
        Ladislav Michl <ladis@linux-mips.org>, ada@thorsis.com,
        honghui.zhang@mediatek.com,
        =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
        linux-mtd@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nagasureshkumarrelli@gmail.com, michals@xilinx.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 2:13 PM Naga Sureshkumar Relli
<nagasure@xilinx.com> wrote:


> > This driver has the same problem as the other patches:
> > use the ARM_AMBA primecell magic numbers detection, and the PrimeCell bus.
>
> Here the child is NAND controller and the parent is PL353 SMC,
> so do we need to update this also as AMBA driver?

No, sorry. The parent is spawning another device and you
should indeed use a platform device for that.

Forget this comment.

Yours,
Linus Walleij
