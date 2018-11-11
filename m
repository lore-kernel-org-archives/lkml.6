Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2192FC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C014820818
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="po48kL6A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C014820818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730846AbeKLGTZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:19:25 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:49796 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730488AbeKLGTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 01:19:24 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 883FC8EE12F;
        Sun, 11 Nov 2018 12:29:53 -0800 (PST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id g5doqlLg7xH9; Sun, 11 Nov 2018 12:29:53 -0800 (PST)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id E59588EE0A4;
        Sun, 11 Nov 2018 12:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1541968193;
        bh=IVT55bWKe6cGhRi9r8LJpxNd5rWYnmikRfGRFITafPE=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=po48kL6ALD4PTcSJvx+6DkMnxvScD16zZSzzGmfs61SAqnimlm6Ur4Yud5zktaXxY
         Jb5+qEOWJPFw5BcdBOfsh/khIrM4dlaSaGHM7/q1pv3eGJWiSsCwK/s/D7wPLUdAXI
         fCOgUjmcLRxCi2Qf5Q01j8HGgPohzobj0ustONos=
Message-ID: <1541968191.3190.12.camel@HansenPartnership.com>
Subject: Re: [BUG] Nuvoton NCPT650 TPM 2.0 mode not working
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Michael =?ISO-8859-1?Q?Niew=F6hner?= <linux@mniewoehner.de>,
        peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        arnd@arndb.de, linux-integrity@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Sun, 11 Nov 2018 12:29:51 -0800
In-Reply-To: <7d8cc5ad4bb7548d283f363de6f24c90d5d0a2b2.camel@mniewoehner.de>
References: <776f384a81466642472beb4a34b10f26f1de88e9.camel@mniewoehner.de>
         <1541960689.3190.4.camel@HansenPartnership.com>
         <e8eb56fdab618770917fbe5b174328dc1240f934.camel@mniewoehner.de>
         <1541962653.3190.7.camel@HansenPartnership.com>
         <7d8cc5ad4bb7548d283f363de6f24c90d5d0a2b2.camel@mniewoehner.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-11-11 at 21:09 +0100, Michael Niewöhner wrote:
> On Sun, 2018-11-11 at 10:57 -0800, James Bottomley wrote:
[...]
> > Well, I still think the ACPI setup is incorrect.  What's in
> > /sys/class/platform (should be directories of ACPI devices)?  The
> > TPM is supposed to show up as MSFT0101.  If it doesn't is there any
> > other device string in there that might be a TPM?
> 
> Nope. I'm not sure if it should show up in ACPI... isn't TPM 2.0 I2C?

Your ACPI parser identifies it here:

> [    0.003517] ACPI: TPM2 0x000000009E490ED8 000034 (v03 LENOVO TC-S06   00001300 AMI  00000000)

So it has to be a device in the platform directory.  What is in this
directory?  To find the TPM it probably has something TPM like in the
firmware_node description:

/sys/devices/platform/<dev>/firmware_node/description

Mine says

jejb@jarvis:~/git/linux/drivers> cat /sys/devices/platform/MSFT0101\:00/firmware_node/description
TPM 2.0 Device

James
