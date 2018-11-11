Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AED0C43610
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 18:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38CA120871
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 18:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="iX52asNx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38CA120871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729456AbeKLEOH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 23:14:07 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:48998 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726827AbeKLEOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 23:14:06 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 9D8128EE12F;
        Sun, 11 Nov 2018 10:24:51 -0800 (PST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id sRHXc2ooIewI; Sun, 11 Nov 2018 10:24:51 -0800 (PST)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id DD3948EE0A4;
        Sun, 11 Nov 2018 10:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1541960691;
        bh=I9/BiyczoT2XcDSKy15gvgIRtzA296LJokk7X+nT730=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=iX52asNxW650W3KAbqErOBSrInpdXVuFKgmy2sZq+wP+EkUx0Zh3bBRQAviu6FGo8
         7PQpXgMMMbyRaWYFIFfSdRhHY0VzRvqi65EgtXuTiiCmhV7nA5gP/26fg4MuPvj32z
         6oXe3292xHof2noByQBntIUBbZX3pAiTakCQCjCE=
Message-ID: <1541960689.3190.4.camel@HansenPartnership.com>
Subject: Re: [BUG] Nuvoton NCPT650 TPM 2.0 mode not working
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Michael =?ISO-8859-1?Q?Niew=F6hner?= <linux@mniewoehner.de>,
        peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        arnd@arndb.de, linux-integrity@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Sun, 11 Nov 2018 10:24:49 -0800
In-Reply-To: <776f384a81466642472beb4a34b10f26f1de88e9.camel@mniewoehner.de>
References: <776f384a81466642472beb4a34b10f26f1de88e9.camel@mniewoehner.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-11-11 at 18:55 +0100, Michael Niewöhner wrote:
> Hi all,
> 
> Nuvoton NCPT650 does not work in TPM 2.0 mode with tpm_tis /
> tpm_i2c_nuvoton while it works in TPM 1.2 mode (I can reflash it via
> UEFI setup). Kernel version is 4.19.1

Not that this helps you, but mine definitely works.  I've got an older
Dell XPS-13 with a Nuvoton 650 which is software switchable between 1.2
and 2.0.  This is what mine says

jejb@jarvis:~> dmesg|egrep -i tis\|tpm\|crb
[    0.000000] efi:  ACPI=0x79419000  ACPI 2.0=0x79419000  SMBIOS=0xf0000  TPMEventLog=0x69db3018 
[    0.012797] ACPI: TPM2 0x0000000079446CC0 000034 (v03        Tpm2Tabl 00000001 AMI  00000000)
[    2.035242] tpm_tis MSFT0101:00: 2.0 TPM (device-id 0xFE, rev-id 2)

However, this makes me wonder about yours:

> [    0.003517] ACPI: TPM2 0x000000009E490ED8 000034 (v03 LENOVO TC-
> S06   00001300 AMI  00000000)

I thought the Lenovo "upgrade to 2.0" in fact disabled the external TPM
in favour of the Intel PTT (software TPM in the management engine). 
Since you apparently have the tpm_crb driver that should find the PTT
TPM, this might be one of the attachment bugs in the CRB driver ...
from your ACPI output it looks to be not specifying the Tpm2Tabl.

James

