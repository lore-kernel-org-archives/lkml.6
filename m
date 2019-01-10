Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7101BC43612
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47BBE20675
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729905AbfAJR2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 12:28:13 -0500
Received: from mga07.intel.com ([134.134.136.100]:8928 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729519AbfAJR2N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 12:28:13 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jan 2019 09:28:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,462,1539673200"; 
   d="scan'208";a="115795203"
Received: from vanderss-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.254.152])
  by fmsmga008.fm.intel.com with ESMTP; 10 Jan 2019 09:28:08 -0800
Date:   Thu, 10 Jan 2019 19:28:06 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Michael =?iso-8859-1?Q?Niew=F6hner?= <linux@mniewoehner.de>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        peterhuewe@gmx.de, jgg@ziepe.ca, arnd@arndb.de,
        linux-integrity@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Nayna Jain <nayna@linux.ibm.com>,
        Ken Goldman <kgold@linux.ibm.com>
Subject: Re: tpm_tis TPM2.0 not detected on cold boot
Message-ID: <20190110172806.GD6589@linux.intel.com>
References: <ef7e773b01a5e6153b84628f74fc67092a2f9b0e.camel@gmail.com>
 <1f281756bb1f041e55be8dd090670a1a7b1d1c94.camel@mniewoehner.de>
 <1545519232.3940.115.camel@linux.ibm.com>
 <e7ec38d7cade9aa76384aa2781eab307d2cd5a7b.camel@mniewoehner.de>
 <20190103132737.GD10491@linux.intel.com>
 <6c1bf9815bfcb5d2bc0cfedfc49c7feda0173dc9.camel@mniewoehner.de>
 <20190103150434.GC17015@linux.intel.com>
 <5aa2fc082b6b0657574918b025005ad569da6412.camel@mniewoehner.de>
 <c1f5f53cdaaaad6cc80c2b10172a69f0301d3e0e.camel@mniewoehner.de>
 <5ee514be264361a8f1ed4a4ad823ad72dd7dce23.camel@mniewoehner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5ee514be264361a8f1ed4a4ad823ad72dd7dce23.camel@mniewoehner.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 04, 2019 at 04:28:24PM +0100, Michael Niewöhner wrote:
> root@debian:~# tpm2_pcrlist
> ERROR:tcti:src/util/io.c:102:write_all() failed to write to fd 3: Operation not
> permitted 
> ERROR:tcti:src/tss2-tcti/tcti-device.c:86:tcti_device_transmit() wrong number of
> bytes written. Expected 22, wrote 0. 
> ERROR: GetCapability: Get PCR allocation status Error. TPM Error:0xa000a......
> ERROR: Unable to run tpm2_pcrlist
> root@debian:~# tpm2_pcrlist; tpm2_pcrlist 
> sha1 :
>   0  : 1ebb2be3b7103a09b5caeeb5827c1242cd6632ec
>   1  : 425e833da73cb511150d6ffcf6fac64e9a6feb58
>   2  : b2a83b0ebf2f8374299a5b2bdfc31ea955ad7236
>   3  : b2a83b0ebf2f8374299a5b2bdfc31ea955ad7236
>   4  : d13c141b174afbb568773adf1f39940a2df47c7d
>   5  : 756a3647403ab141ec2c1ac7325854f4a93f6efd
> ......

So the sympton is that it from time to time works and time to time
fails.

Can't recall whether you had interrupts enabled or disabled for the
TPM chip (depending on whether you use IRQs or polling you'd have
to tweak the code from a different place), but you could tweak
directly the TPM2_DURATION_* constants in drivers/char/tpm/tpm.h:

enum tpm2_timeouts {
	TPM2_TIMEOUT_A          =    750,
	TPM2_TIMEOUT_B          =   2000,
	TPM2_TIMEOUT_C          =    200,
	TPM2_TIMEOUT_D          =     30,
	TPM2_DURATION_SHORT     =     20,
	TPM2_DURATION_MEDIUM    =    750,
	TPM2_DURATION_LONG      =   2000,
	TPM2_DURATION_LONG_LONG = 300000,
	TPM2_DURATION_DEFAULT   = 120000,
};

Set SHORT, LONG and MEDIUM to lets say 3000 and lets see if that
makes a difference or not.

/Jarkko
