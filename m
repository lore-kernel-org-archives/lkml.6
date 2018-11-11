Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_ADSP_ALL,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA91C04EB9
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 18:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDA8A214F1
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 18:50:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDA8A214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mniewoehner.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729481AbeKLEjh convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 23:39:37 -0500
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21781 "EHLO
        sender-of-o53.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729413AbeKLEjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 23:39:37 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1541962208; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=YtyMnd0letGd52Ni0tD5x76/h0e7f8/H5wsp9Z/VwzwNfLZQuh4ZFNQgwNVYueThQ0b8a8Kkw2ZsQw4IBngqpOJAaBcfEyURTJ+QDRaCkxBidypzPoIWabnM6kO1meaXUygONkEef4ZY+58fAysdP+PR3SW9Vb+GLfJUA66OuoE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1541962208; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=sAz7EJdTyRSsvQVPqXZuOgcvzMBL2HR4Upqo6kqrPAQ=; 
        b=oWUsZTqRjFflTfceKrQCYKnINw4BT3kuFGVzLRE4pjf/KY1hYH/+bDUAJ2zL6u5vNQlKLfBwFmrFAI1U8VhJyknehKWK5skW+/0ATqFcx9y1ThgnRAhSbLq4RqeRHIAtPmFwGKLzGXK/9/leNupeyJnmJ7ZkjQhlV3Dz9o2kjwQ=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=mniewoehner.de;
        spf=pass  smtp.mailfrom=linux@mniewoehner.de;
        dmarc=pass header.from=<linux@mniewoehner.de> header.from=<linux@mniewoehner.de>
Received: from z3r0 (31.187.91.78 [31.187.91.78]) by mx.zohomail.com
        with SMTPS id 1541962206767736.60132244995; Sun, 11 Nov 2018 10:50:06 -0800 (PST)
Message-ID: <e8eb56fdab618770917fbe5b174328dc1240f934.camel@mniewoehner.de>
Subject: Re: [BUG] Nuvoton NCPT650 TPM 2.0 mode not working
From:   Michael =?ISO-8859-1?Q?Niew=F6hner?= <linux@mniewoehner.de>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        arnd@arndb.de, linux-integrity@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1541960689.3190.4.camel@HansenPartnership.com>
References: <776f384a81466642472beb4a34b10f26f1de88e9.camel@mniewoehner.de>
         <1541960689.3190.4.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
Date:   Sun, 11 Nov 2018 19:50:03 +0100
Mime-Version: 1.0
X-Mailer: Evolution 3.28.5 
Content-Transfer-Encoding: 8BIT
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On Sun, 2018-11-11 at 10:24 -0800, James Bottomley wrote:
> On Sun, 2018-11-11 at 18:55 +0100, Michael Niewöhner wrote:
> > Hi all,
> > 
> > Nuvoton NCPT650 does not work in TPM 2.0 mode with tpm_tis /
> > tpm_i2c_nuvoton while it works in TPM 1.2 mode (I can reflash it via
> > UEFI setup). Kernel version is 4.19.1
> 
> Not that this helps you, but mine definitely works.  I've got an older
> Dell XPS-13 with a Nuvoton 650 which is software switchable between 1.2
> and 2.0.  This is what mine says
> 
> jejb@jarvis:~> dmesg|egrep -i tis\|tpm\|crb
> [    0.000000] efi:  ACPI=0x79419000  ACPI
> 2.0=0x79419000  SMBIOS=0xf0000  TPMEventLog=0x69db3018 
> [    0.012797] ACPI: TPM2 0x0000000079446CC0 000034 (v03        Tpm2Tabl
> 00000001 AMI  00000000)
> [    2.035242] tpm_tis MSFT0101:00: 2.0 TPM (device-id 0xFE, rev-id 2)
> 
> However, this makes me wonder about yours:
> 
> > [    0.003517] ACPI: TPM2 0x000000009E490ED8 000034 (v03 LENOVO TC-
> > S06   00001300 AMI  00000000)
> 
> I thought the Lenovo "upgrade to 2.0" in fact disabled the external TPM
> in favour of the Intel PTT (software TPM in the management engine). 
> Since you apparently have the tpm_crb driver that should find the PTT
> TPM, this might be one of the attachment bugs in the CRB driver ...
> from your ACPI output it looks to be not specifying the Tpm2Tabl.

Well, there are at least two implementations I know of:
For my Lenovo X260 I can choose between Infineon TPM 1.2 or Intel PTT TPM 2.0
This here is my ThinkStation P320 which can choose between PTT 1.2, PTT 2.0,
Nuvoton 1.2 and 2.0. When switchting between 1.2 and 2.0 the Nuvoton gets
reflashed with the appropriate firmware.

> 
> James
> 


