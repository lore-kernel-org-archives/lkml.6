Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D03C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 07:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C11B245A7
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 07:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ch+bRXgT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C11B245A7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965279AbeF1Hnp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 03:43:45 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:40002 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964955AbeF1Hnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 03:43:43 -0400
Received: by mail-io0-f196.google.com with SMTP id t135-v6so4320302iof.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 00:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bSjOueripNnsfJcnpIcMV9YUXy6UELbY+jjx55EWVnU=;
        b=ch+bRXgTfbyQd5VMVCyn3mEQ6QFibvGZMkpdiCaUG8/oiqZFmzPYy9GY63l84OeoQK
         +xrgGMR9P+LA3tuHOQf+UrmwUlH4yn1u542Nr7HKBd3QUd+GyxabXw49Uch/+fQD62Z9
         BHULJLi2BuvGH1vrF3qKWxfVr4p31SHiA5D/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bSjOueripNnsfJcnpIcMV9YUXy6UELbY+jjx55EWVnU=;
        b=CRXKHf7/UVcYpWrBur1e/c6/cF19zA4RvlRwM8D+sTxsjy1tFih1bE3Iq3X8U6QG8k
         ZozU/MrFvAZbrwku5gDV+YUj0Nfk/PEpksS7tur4y8zg+SCevyA4aKP9J/ZPS2hpyBoA
         jkyWGgjYMPHDiHuE4D+7aEwm5yyCTkhsaLiR/nXljmQPXXTwHyUJBg1324qmnfXlfTsI
         P1z/slrrYo660VWeba80CmdZs1+g3fU9TMxb5vcdjwkvOvBcPBCvxJKOM9gDjaxcDxF/
         NpoiTMych9RyhJUYzAt5vloJe2OVxoM3V8U08WP40c+nMYWTF56/KJb4rKaC6SZBBi4y
         QrDw==
X-Gm-Message-State: APt69E1vtS/+D9CaM9wyxWaG9gbacw+PXO+HwNBasgupuOKPDKS8kjLW
        F9OryCk5EDAhfIo10xZW5v90jdLn/Fu/BAd3+zAPtQ==
X-Google-Smtp-Source: AAOMgpf9MtWnIPlfJpW3aQPsINnNmVtjMJKRD499vsidyMoqj6l/inVNMuNJYh2GwYRqQlHljED6HAtxNYTUd7nCBAs=
X-Received: by 2002:a6b:6c0b:: with SMTP id a11-v6mr7567265ioh.175.1530171822851;
 Thu, 28 Jun 2018 00:43:42 -0700 (PDT)
MIME-Version: 1.0
References: <1529563351-2241-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
 <1529563351-2241-5-git-send-email-naga.sureshkumar.relli@xilinx.com>
In-Reply-To: <1529563351-2241-5-git-send-email-naga.sureshkumar.relli@xilinx.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 28 Jun 2018 09:43:30 +0200
Message-ID: <CACRpkdaEsEAiGpieJK1AA8HHLzZc7Tdc932rhdayg06rFU1hNA@mail.gmail.com>
Subject: Re: [[LINUX PATCH v10] 4/4] mtd: rawnand: pl353: Add basic driver for
 arm pl353 smc nand interface
To:     naga.sureshkumar.relli@xilinx.com
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

On Thu, Jun 21, 2018 at 8:43 AM Naga Sureshkumar Relli
<naga.sureshkumar.relli@xilinx.com> wrote:

Thank you for your patch!

> Add driver for arm pl353 static memory controller nand interface with HW ECC
> support. This controller is used in Xilinx Zynq SoC for interfacing the NAND
> flash memory.
>
> Signed-off-by: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>

This driver has the same problem as the other patches:
use the ARM_AMBA primecell magic numbers detection, and
the PrimeCell bus.

Otherwise it looks good to me!

Yours,
Linus Walleij
