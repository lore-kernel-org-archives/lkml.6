Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E3CC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 17:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C97820840
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 17:54:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C97820840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbeKKDki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 22:40:38 -0500
Received: from smtp05.smtpout.orange.fr ([80.12.242.127]:33531 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbeKKDkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 22:40:37 -0500
Received: from belgarion ([90.89.234.36])
        by mwinf5d10 with ME
        id yHui1y0020nnJME03Huia9; Sat, 10 Nov 2018 18:54:45 +0100
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Sat, 10 Nov 2018 18:54:45 +0100
X-ME-IP: 90.89.234.36
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        David Binderman <dcb314@hotmail.com>
Cc:     "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel\@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Julien Thierry <julien.thierry@arm.com>
Subject: Re: linux-4.20-rc1/arch/arm/vfp/vfpmodule.c:576: possible cut'n'paste error
References: <VI1PR08MB3342D4ADBFBC43F2BE2FD34D9CCA0@VI1PR08MB3342.eurprd08.prod.outlook.com>
        <VI1PR08MB33420789A2AA1096D3F5FC9D9CCA0@VI1PR08MB3342.eurprd08.prod.outlook.com>
        <20181106162014.GH30658@n2100.armlinux.org.uk>
        <VI1PR08MB33427CD1C653245DBB979B9B9CCB0@VI1PR08MB3342.eurprd08.prod.outlook.com>
        <20181106163724.GK30658@n2100.armlinux.org.uk>
X-URL:  http://belgarath.falguerolles.org/
Date:   Sat, 10 Nov 2018 18:54:42 +0100
In-Reply-To: <20181106163724.GK30658@n2100.armlinux.org.uk> (Russell King's
        message of "Tue, 6 Nov 2018 16:37:24 +0000")
Message-ID: <87r2fslswt.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King - ARM Linux <linux@armlinux.org.uk> writes:

>> Interestingly, more of the same in file linux-4.20-rc1/arch/arm/mach-pxa/pxa3xx.c
>> 
>> [linux-4.20-rc1/arch/arm/mach-pxa/pxa3xx.c:84]: (warning) Redundant assignment of 'ASCR' to itself.
>> [linux-4.20-rc1/arch/arm/mach-pxa/pxa3xx.c:85]: (warning) Redundant assignment of 'ARSR' to itself.
>> [linux-4.20-rc1/arch/arm/mach-pxa/pxa3xx.c:120]: (warning) Redundant assignment of 'ASCR' to itself.
>> [linux-4.20-rc1/arch/arm/mach-pxa/pxa3xx.c:121]: (warning) Redundant assignment of 'ARSR' to itself.
>> 
>> I don't know if these four are also worth fixing.
>
> There are cases where this can be false positives.  In the case of a
> status register with write-1-to-clear bits for example.  These ones
> look very much like that.
And indeed they are, for bits 2,1,0 for ASCR and 3,2,1,0 for ARSR, and you
guessed correctly they are partly status registers.

If only your checker could filter out __iomem tagged pointers, you could have
far less of these false positives ...

Cheers.

-- 
Robert
