Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50DBCC04EBC
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 08:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23CDA20817
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 08:18:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23CDA20817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbeKRSiR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 13:38:17 -0500
Received: from mga17.intel.com ([192.55.52.151]:48756 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725875AbeKRSiR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 13:38:17 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Nov 2018 00:18:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,247,1539673200"; 
   d="scan'208";a="105560184"
Received: from kaczmarx-mobl.ger.corp.intel.com (HELO localhost) ([10.249.254.89])
  by fmsmga002.fm.intel.com with ESMTP; 18 Nov 2018 00:18:37 -0800
Date:   Sun, 18 Nov 2018 10:18:33 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Michael =?iso-8859-1?Q?Niew=F6hner?= <linux@mniewoehner.de>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        peterhuewe@gmx.de, jgg@ziepe.ca, arnd@arndb.de,
        linux-integrity@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Nayna Jain <nayna@linux.ibm.com>
Subject: Re: [BUG] Nuvoton NCPT650 TPM 2.0 mode not working
Message-ID: <20181118081833.GH5897@linux.intel.com>
References: <1541960689.3190.4.camel@HansenPartnership.com>
 <e8eb56fdab618770917fbe5b174328dc1240f934.camel@mniewoehner.de>
 <1541962653.3190.7.camel@HansenPartnership.com>
 <7d8cc5ad4bb7548d283f363de6f24c90d5d0a2b2.camel@mniewoehner.de>
 <1541968191.3190.12.camel@HansenPartnership.com>
 <3243d0325b3ea5878d3f86b0ee4fec1498f21dc1.camel@mniewoehner.de>
 <660b0934bc16c8d195a2724f8be4ba8dfbe71134.camel@mniewoehner.de>
 <1541972556.3734.90.camel@linux.ibm.com>
 <4f7cc7152f2266d8d0782889db2375d4c1c71987.camel@mniewoehner.de>
 <b89c95a496a1512ee3069b6a69cf915906fe697a.camel@mniewoehner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b89c95a496a1512ee3069b6a69cf915906fe697a.camel@mniewoehner.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 10:06:28PM +0100, Michael Niewöhner wrote:
> On Wed, 2018-11-14 at 21:46 +0100, Michael Niewöhner wrote:
> > Hi all,
> > 
> > I tried that patch mentioned by Mimi but it does not change anything for me.
> > 
> > Then I did some more tests with different kernel configs and finally got TPM
> > working by
> > a) compiling TPM as modules and rmmod tpm* and re-modprobe tpm_tis.
> > 
> > (initramfs) dmesg | grep -i tpm
> > [    0.000000] efi:  ACPI 2.0=0x9ea7e000 ACPI=0x9ea7e000 SMBIOS=0x9f5eb000
> > SMBIOS 3.0=0x9f5ea000 ESRT=0x9c07d918 MEMATTR=0x9bea3018
> > TPMEventLog=0x97cbb018
> > [    0.003793] ACPI: TPM2 0x000000009EAB7F70 000034 (v03 LENOVO TC-
> > S06   00001260 AMI 00000000)
> > (initramfs) rmmod tpm_crb tpm_tis tpm_tis_core tpm
> > (initramfs) modprobe tpm_tis
> > [   44.956905] tpm_tis MSFT0101:00: 2.0 TPM (device-id 0xFE, rev-id 2)
> > 
> > b) compiling TPM-support in-kernel and manually bind the ACPI device
> > 
> > (initramfs) dmesg | grep -i tpm
> > [    0.000000] efi: ACPI 2.0=0x9ea7e000 ACPI=0x9ea7e000 SMBIOS=0x9f5eb000
> > SMBIOS
> > 3.0=0x9f5ea000 ESRT=0x9c07d918 MEMATTR=0x9bea3018 TPMEventLog=0x97cbb018
> > [    0.003546] ACPI: TPM2 0x000000009EAB7F70 000034 (v03 LENOVO TC-S06
> > 00001260
> > AMI 00000000)
> > (initramfs) echo MSFT0101:00 >/sys/bus/platform/drivers/tpm_tis/bind
> > [  233.076079] tpm_tis MSFT0101:00: 2.0 TPM (device-id 0xFE, rev-id 2)
> > 
> > 
> > It seems to me, the kernel tries to enable the TPM to early...
> > 
> > 
> > Michael
> 
> Looks like the manual driver bind works more or less but e.g reading hwrng does
> not work...
> 
> # echo MSFT0101:00 >/sys/bus/platform/drivers/tpm_tis/bind
> [  148.293302] tpm_tis MSFT0101:00: 2.0 TPM (device-id 0xFE, rev-id 2)
> # cat /sys/devices/virtual/misc/hw_random/rng_current
> tpm-rng-0
> # cat /dev/hwrng >/dev/null 
> cat: /dev/hwrng: Operation not permitted

Can you check with trace-cmd start -p function -l 'tpm*'?

/Jarkko
