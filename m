Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92602C43444
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 13:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6122421479
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 13:41:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730798AbfACNly (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 08:41:54 -0500
Received: from mga04.intel.com ([192.55.52.120]:24787 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728233AbfACNlx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 08:41:53 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jan 2019 05:41:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,435,1539673200"; 
   d="scan'208";a="288553679"
Received: from tmuluk-mobl4.ger.corp.intel.com (HELO localhost) ([10.249.254.238])
  by orsmga005.jf.intel.com with ESMTP; 03 Jan 2019 05:41:48 -0800
Date:   Thu, 3 Jan 2019 15:41:47 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Michael =?iso-8859-1?Q?Niew=F6hner?= 
        <niewoehner.michael@gmail.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        peterhuewe@gmx.de, jgg@ziepe.ca, arnd@arndb.de,
        linux-integrity@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Nayna Jain <nayna@linux.ibm.com>,
        Ken Goldman <kgold@linux.ibm.com>
Subject: Re: tpm_tis TPM2.0 not detected on cold boot
Message-ID: <20190103134147.GE10491@linux.intel.com>
References: <ef7e773b01a5e6153b84628f74fc67092a2f9b0e.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ef7e773b01a5e6153b84628f74fc67092a2f9b0e.camel@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 16, 2018 at 02:32:38PM +0100, Michael Niewöhner wrote:
 
> dmesg cold boot with tpm_tis.interrupts=0 tpm_tis.force=1:
> ----------------------------------------------------------
> > dmesg | grep -i tpm
> [    0.000000] Command line: initrd=\initrd-test console=ttyS0,115200n8
> break=premount tpm_tis.interrupts=0 tpm_tis.force=1
> [    0.000000] efi:  ACPI
> 2.0=0x9e07e000  ACPI=0x9e07e000  SMBIOS=0x9ebeb000  SMBIOS
> 3.0=0x9ebea000  MEMATTR=0x98fb2018  TPMEventLog=0x972bb018 
> [    0.003531] ACPI: TPM2 0x000000009E0B7F70 000034 (v03 LENOVO TC-
> S06   00001260 AMI  00000000)
> [    0.162005] Kernel command line: initrd=\initrd-test console=ttyS0,115200n8
> break=premount tpm_tis.interrupts=0 tpm_tis.force=1
> [    3.616806] tpm_tis MSFT0101:00: 2.0 TPM (device-id 0xFE, rev-id 2)
> [    3.683117] tpm_tis tpm_tis: can't request region for resource [mem
> 0xfed40000-0xfed44fff]
> [    3.691378] tpm_tis: probe of tpm_tis failed with error -16
> [    4.572539] ima: Error Communicating to TPM chip

Wonder why this happens. What does /proc/iomem show?

/Jarkko
