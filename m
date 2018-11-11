Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_ADSP_ALL,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B6A0C0044C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 21:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDA1320871
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 21:11:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDA1320871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mniewoehner.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729781AbeKLHBe convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 02:01:34 -0500
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21736 "EHLO
        sender-of-o53.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbeKLHBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 02:01:33 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1541970698; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=XA7z90HlHGSkC+rbZcswguT/brPJWmfEV3cxgj8V1zX3k1qdXNx2XmQEkUvZ3uBVyrxKs5aFzD9NLXir4sZEdF3VdV583DU57sXK4obLiLTso54i4Y9iviOFlF7wYp928h97R12WiDjCCwW7YCKo1QXoZwQpkJ5VWVX2AOKKffw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1541970698; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=uoQLqrc7JyZVkQ4croNqw75X/t5M+q2u5QDVTtEw74o=; 
        b=AxMU35l/mo0b5gl1IQCNtiWpZH7IECCHrMSxSLmx4CBUgF10+SqsRRjKJlfjPwp6R9qFWgoLivFnS5/hd58ctsAWzuLyVj21G7vheMNUw4KwQq6M0jnuBnkRFOdDMWSDBRXJQXUQ2XqXz4lrY2qScU6Se5a4eXmzZRfQDyHHOb8=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=mniewoehner.de;
        spf=pass  smtp.mailfrom=linux@mniewoehner.de;
        dmarc=pass header.from=<linux@mniewoehner.de> header.from=<linux@mniewoehner.de>
Received: from z3r0 (31.187.91.78 [31.187.91.78]) by mx.zohomail.com
        with SMTPS id 15419706971211009.9617419457797; Sun, 11 Nov 2018 13:11:37 -0800 (PST)
Message-ID: <660b0934bc16c8d195a2724f8be4ba8dfbe71134.camel@mniewoehner.de>
Subject: Re: [BUG] Nuvoton NCPT650 TPM 2.0 mode not working
From:   Michael =?ISO-8859-1?Q?Niew=F6hner?= <linux@mniewoehner.de>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        arnd@arndb.de, linux-integrity@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3243d0325b3ea5878d3f86b0ee4fec1498f21dc1.camel@mniewoehner.de>
References: <776f384a81466642472beb4a34b10f26f1de88e9.camel@mniewoehner.de>
         <1541960689.3190.4.camel@HansenPartnership.com>
         <e8eb56fdab618770917fbe5b174328dc1240f934.camel@mniewoehner.de>
         <1541962653.3190.7.camel@HansenPartnership.com>
         <7d8cc5ad4bb7548d283f363de6f24c90d5d0a2b2.camel@mniewoehner.de>
         <1541968191.3190.12.camel@HansenPartnership.com>
         <3243d0325b3ea5878d3f86b0ee4fec1498f21dc1.camel@mniewoehner.de>
Content-Type: text/plain; charset="UTF-8"
Date:   Sun, 11 Nov 2018 22:11:33 +0100
Mime-Version: 1.0
X-Mailer: Evolution 3.28.5 
Content-Transfer-Encoding: 8BIT
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-11-11 at 21:34 +0100, Michael Niewöhner wrote:
> On Sun, 2018-11-11 at 12:29 -0800, James Bottomley wrote:
> > On Sun, 2018-11-11 at 21:09 +0100, Michael Niewöhner wrote:
> > > On Sun, 2018-11-11 at 10:57 -0800, James Bottomley wrote:
> > 
> > [...]
> > > > Well, I still think the ACPI setup is incorrect.  What's in
> > > > /sys/class/platform (should be directories of ACPI devices)?  The
> > > > TPM is supposed to show up as MSFT0101.  If it doesn't is there any
> > > > other device string in there that might be a TPM?
> > > 
> > > Nope. I'm not sure if it should show up in ACPI... isn't TPM 2.0 I2C?
> > 
> > Your ACPI parser identifies it here:
> > 
> > > [    0.003517] ACPI: TPM2 0x000000009E490ED8 000034 (v03 LENOVO TC-
> > > S06   00001300 AMI  00000000)
> > 
> > So it has to be a device in the platform directory.  What is in this
> > directory?  To find the TPM it probably has something TPM like in the
> > firmware_node description:
> > 
> > /sys/devices/platform/<dev>/firmware_node/description
> > 
> > Mine says
> > 
> > jejb@jarvis:~/git/linux/drivers> cat
> > /sys/devices/platform/MSFT0101\:00/firmware_node/description
> > TPM 2.0 Device
> > 
> 
> Ah, yep. There is indeed a MSFT0101:
> (initramfs) cat /sys/devices/platform/MSFT0101\:00/firmware_node/description 
> TPM 2.0 Device
> (initramfs) cat /sys/devices/platform/MSFT0101\:00/firmware_node/hid 
> MSFT0101
> (in
> itramfs) cat /sys/devices/platform/MSFT0101\:00/firmware_node/path 
> \_SB_.TPM_
> (in
> itramfs) cat /sys/devices/platform/MSFT0101\:00/firmware_node/status 
> 15
> (initramf
> s) cat /sys/devices/platform/MSFT0101\:00/firmware_node/uid 
> 1
> 
> > James

Very strange... When I pull the power cord, then replug and boot, I get these
dmesg messages:
[    0.000000] efi:  ACPI
2.0=0x9ea78000  ACPI=0x9ea78000  SMBIOS=0x9f5e5000  SMBIOS
3.0=0x9f5e4000  MPS=0xfca00  ESRT=0x9c06e918  MEMATTR=0x99cb9018  TPMEventLog=0x
98d0c018 
[    0.001794] ACPI: TPM2 0x000000009EAB1F70 000034 (v03 LENOVO TC-
S06   00001260 AMI  00000000)
[    3.096587] tpm_tis MSFT0101:00: 2.0 TPM (device-id 0xFE, rev-id 2)
[    3.105684] tpm tpm0: A TPM error (2314) occurred attempting the self test

After a reboot I get those "ima: ..." message again. Pulling the plug seems to
reset anything (the TPM).

The PTT TPM 2.0 shows exactly the same behaviour.


