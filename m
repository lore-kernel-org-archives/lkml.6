Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIM_ADSP_ALL,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45413C43610
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 20:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11B8120855
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 20:06:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11B8120855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mniewoehner.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbeKZG6b convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 01:58:31 -0500
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21751 "EHLO
        sender-of-o53.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbeKZG6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 01:58:30 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1543176383; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=WllhGbaVZI2Z3zs255mkJ94SaRHsnC+C+lGa1k1aH5wcAb1ykVJVRrjPBsQSLKKph8pSig4IVJeMM3y553BSLpKtJ/2GEfjWikOUXzk9BIVlAtBiTV66bggYQTN1moseDDd56aECchB3aUyIVfgxvXjNeymHuC6JOJ+J6lbUOB4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1543176383; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=oUoNsm0EYUsCbh/dvEkZPqMsdrgQT8RgvuXhyLc59os=; 
        b=OTLWWtPwWYH6oaPMHeGMClVgnoqRkidBOMqWV4O0ewH0u25PgkSoKLxnha7OvGUGn11YPKVGOn/umbqvXmY0R2uxbNCoU91pjDn+fX3q7M+ylgwgo2VdeRcbs68n3vRN9vL6P+/YmOCiJ0iZIsxaPr+kWHe34Qs0v4s3lYOkauw=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=mniewoehner.de;
        spf=pass  smtp.mailfrom=linux@mniewoehner.de;
        dmarc=pass header.from=<linux@mniewoehner.de> header.from=<linux@mniewoehner.de>
Received: from z3r0 (31.187.91.78 [31.187.91.78]) by mx.zohomail.com
        with SMTPS id 1543176378443176.67474882861723; Sun, 25 Nov 2018 12:06:18 -0800 (PST)
Message-ID: <49ec628f42fa7833f6a75d4a8b15d64789c70bf7.camel@mniewoehner.de>
Subject: Re: [BUG] Nuvoton NCPT650 TPM 2.0 mode not working
From:   Michael =?ISO-8859-1?Q?Niew=F6hner?= <linux@mniewoehner.de>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        peterhuewe@gmx.de, jgg@ziepe.ca, arnd@arndb.de,
        linux-integrity@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Nayna Jain <nayna@linux.ibm.com>
In-Reply-To: <20181119134956.GD8755@linux.intel.com>
References: <1541962653.3190.7.camel@HansenPartnership.com>
         <7d8cc5ad4bb7548d283f363de6f24c90d5d0a2b2.camel@mniewoehner.de>
         <1541968191.3190.12.camel@HansenPartnership.com>
         <3243d0325b3ea5878d3f86b0ee4fec1498f21dc1.camel@mniewoehner.de>
         <660b0934bc16c8d195a2724f8be4ba8dfbe71134.camel@mniewoehner.de>
         <1541972556.3734.90.camel@linux.ibm.com>
         <4f7cc7152f2266d8d0782889db2375d4c1c71987.camel@mniewoehner.de>
         <b89c95a496a1512ee3069b6a69cf915906fe697a.camel@mniewoehner.de>
         <20181118081833.GH5897@linux.intel.com>
         <467833cc47247a55595d72426f46eeac1406eb04.camel@mniewoehner.de>
         <20181119134956.GD8755@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Date:   Sun, 25 Nov 2018 21:06:14 +0100
Mime-Version: 1.0
X-Mailer: Evolution 3.28.5 
Content-Transfer-Encoding: 8BIT
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 2018-11-19 at 15:49 +0200, Jarkko Sakkinen wrote:
> On Sun, Nov 18, 2018 at 03:10:06PM +0100, Michael Niewöhner wrote:
> > On Sun, 2018-11-18 at 10:18 +0200, Jarkko Sakkinen wrote:
> > > On Fri, Nov 16, 2018 at 10:06:28PM +0100, Michael Niewöhner wrote:
> > > > On Wed, 2018-11-14 at 21:46 +0100, Michael Niewöhner wrote:
> > > > > Hi all,
> > > > > 
> > > > > I tried that patch mentioned by Mimi but it does not change anything
> > > > > for
> > > > > me.
> > > > > 
> > > > > Then I did some more tests with different kernel configs and finally
> > > > > got
> > > > > TPM
> > > > > working by
> > > > > a) compiling TPM as modules and rmmod tpm* and re-modprobe tpm_tis.
> > > > > 
> > > > > (initramfs) dmesg | grep -i tpm
> > > > > [    0.000000] efi:  ACPI 2.0=0x9ea7e000 ACPI=0x9ea7e000
> > > > > SMBIOS=0x9f5eb000
> > > > > SMBIOS 3.0=0x9f5ea000 ESRT=0x9c07d918 MEMATTR=0x9bea3018
> > > > > TPMEventLog=0x97cbb018
> > > > > [    0.003793] ACPI: TPM2 0x000000009EAB7F70 000034 (v03 LENOVO TC-
> > > > > S06   00001260 AMI 00000000)
> > > > > (initramfs) rmmod tpm_crb tpm_tis tpm_tis_core tpm
> > > > > (initramfs) modprobe tpm_tis
> > > > > [   44.956905] tpm_tis MSFT0101:00: 2.0 TPM (device-id 0xFE, rev-id 2)
> > > > > 
> > > > > b) compiling TPM-support in-kernel and manually bind the ACPI device
> > > > > 
> > > > > (initramfs) dmesg | grep -i tpm
> > > > > [    0.000000] efi: ACPI 2.0=0x9ea7e000 ACPI=0x9ea7e000
> > > > > SMBIOS=0x9f5eb000
> > > > > SMBIOS
> > > > > 3.0=0x9f5ea000 ESRT=0x9c07d918 MEMATTR=0x9bea3018
> > > > > TPMEventLog=0x97cbb018
> > > > > [    0.003546] ACPI: TPM2 0x000000009EAB7F70 000034 (v03 LENOVO TC-S06
> > > > > 00001260
> > > > > AMI 00000000)
> > > > > (initramfs) echo MSFT0101:00 >/sys/bus/platform/drivers/tpm_tis/bind
> > > > > [  233.076079] tpm_tis MSFT0101:00: 2.0 TPM (device-id 0xFE, rev-id 2)
> > > > > 
> > > > > 
> > > > > It seems to me, the kernel tries to enable the TPM to early...
> > > > > 
> > > > > 
> > > > > Michael
> > > > 
> > > > Looks like the manual driver bind works more or less but e.g reading
> > > > hwrng
> > > > does
> > > > not work...
> > > > 
> > > > # echo MSFT0101:00 >/sys/bus/platform/drivers/tpm_tis/bind
> > > > [  148.293302] tpm_tis MSFT0101:00: 2.0 TPM (device-id 0xFE, rev-id 2)
> > > > # cat /sys/devices/virtual/misc/hw_random/rng_current
> > > > tpm-rng-0
> > > > # cat /dev/hwrng >/dev/null 
> > > > cat: /dev/hwrng: Operation not permitted
> > > 
> > > Can you check with trace-cmd start -p function -l 'tpm*'?
> > > 
> > > /Jarkko
> > 
> > 
> > Hi Jarko,
> > 
> > what output do you need exactly?
> 
> TPM gets added with tpm_add_hwrng() and the callback that is called by
> hwrng subsystem is tpm_hwrng_read().
> 
> Obviously the former gets called (can be seen from the sysfs file). Just
> wondering if it ever reaches tpm_hwrng_read().
> 
> /Jarkko

I wanted to be sure that there is no hardware failure so I tested the TPM in
UEFI Shell using the tpm tools from github.com/fpmurphy/UEFI-Utilities-2016

I can confirm that it is working there in both modes 1.2 and 2.0.


FS0:\> ShowTPM2.efi

           Signature : TPM2
              Length : 52
            Revision : 3
            Checksum : 167
              Oem ID : LENOVO
        Oem Table ID : TC-S06  
        Oem Revision : 4704
          Creator ID : AMI 
    Creator Revision : 0
      Platform Class : 0
Control Area Address : 0
        Start Method : 6 (Memory mapped I/O)
  Platform S.P. Size : 0

FS0:\> ShowTCM20.efi
          Structure Version: 1.1
           Protocol Version: 1.1
  Supported Hash Algorithms: SHA1 SHA256 
Supported Event Log Formats: TCG_1.2 TCG_2 
           TPM Present Flag: True
       Maximum Command Size: 2048
      Maximum Response Size: 2048
             Manufactuer ID: NTC
       Number of PCR Banks: 2

FS0:\> ShowPCR20.efi

Bank (Algorithm): TPM_ALG_SHA1 (0x0004)

[00]  1E BB 2B E3 B7 10 3A 09 B5 CA EE B5 82 7C 12 42 CD 66 32 EC
[01]  80 4E 8E 47 19 9D C7 31 4E B4 3C 4D C9 58 EF 6F 0B 6B 49 62
[02]  B2 A8 3B 0E BF 2F 83 74 29 9A 5B 2B DF C3 1E A9 55 AD 72 36
[03]  B2 A8 3B 0E BF 2F 83 74 29 9A 5B 2B DF C3 1E A9 55 AD 72 36
....
......



Michael


