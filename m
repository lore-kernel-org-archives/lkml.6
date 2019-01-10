Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_ADSP_ALL,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D393C43612
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 18:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E9BE206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 18:03:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730782AbfAJSDs convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 13:03:48 -0500
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21844 "EHLO
        sender-of-o53.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729882AbfAJSDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 13:03:48 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1547143414; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=DVtAxO5WSBtmXzJLx4Eojn1xzilIxH4TitwMkjRjLT9uOoBLDxaAUdPbGnSod+toWJKTsugi+4nYudWDyPcdvuH11ngtExXAWzO/j1ZEbFSPeISd6EL8del/jlCq1C1LLaW/JP9ENuZFzDrgJ4yVznRjYRNFNvBVcEk5wN/df+o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1547143414; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=I4sIXm4byiLK7cWi4d+oOqh3fjuUZRa2fzgEc/PopCI=; 
        b=CBG2acyGQ0v2zHfvw47I08p0xk9I/DYsT0OyPf0sM2k2Z1r3Nf7IizE29TEKZDCNUmDwmGGRCbafpQy0jX5SoCqTaPAxr+xD6CUNjIC4cCjtgzarxJTBOHQJOlr3fy6sTZWgSy6Y4YzGDLAmNju8CrImORel2WPX1XibJA98gI0=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=mniewoehner.de;
        spf=pass  smtp.mailfrom=linux@mniewoehner.de;
        dmarc=pass header.from=<linux@mniewoehner.de> header.from=<linux@mniewoehner.de>
Received: from z3r0 (31.187.91.78 [31.187.91.78]) by mx.zohomail.com
        with SMTPS id 1547143412184265.1848318416826; Thu, 10 Jan 2019 10:03:32 -0800 (PST)
Message-ID: <6a7c871bc6aeaa780114a937741f46223ca7e961.camel@mniewoehner.de>
Subject: Re: tpm_tis TPM2.0 not detected on cold boot
From:   Michael =?ISO-8859-1?Q?Niew=F6hner?= <linux@mniewoehner.de>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        peterhuewe@gmx.de, jgg@ziepe.ca, arnd@arndb.de,
        linux-integrity@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Nayna Jain <nayna@linux.ibm.com>,
        Ken Goldman <kgold@linux.ibm.com>
In-Reply-To: <20190110172806.GD6589@linux.intel.com>
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
         <20190110172806.GD6589@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Date:   Thu, 10 Jan 2019 19:03:28 +0100
Mime-Version: 1.0
User-Agent: Evolution 3.30.3 
Content-Transfer-Encoding: 8BIT
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-01-10 at 19:28 +0200, Jarkko Sakkinen wrote:
> On Fri, Jan 04, 2019 at 04:28:24PM +0100, Michael Niewöhner wrote:
> > root@debian:~# tpm2_pcrlist
> > ERROR:tcti:src/util/io.c:102:write_all() failed to write to fd 3: Operation
> > not
> > permitted 
> > ERROR:tcti:src/tss2-tcti/tcti-device.c:86:tcti_device_transmit() wrong
> > number of
> > bytes written. Expected 22, wrote 0. 
> > ERROR: GetCapability: Get PCR allocation status Error. TPM
> > Error:0xa000a......
> > ERROR: Unable to run tpm2_pcrlist
> > root@debian:~# tpm2_pcrlist; tpm2_pcrlist 
> > sha1 :
> >   0  : 1ebb2be3b7103a09b5caeeb5827c1242cd6632ec
> >   1  : 425e833da73cb511150d6ffcf6fac64e9a6feb58
> >   2  : b2a83b0ebf2f8374299a5b2bdfc31ea955ad7236
> >   3  : b2a83b0ebf2f8374299a5b2bdfc31ea955ad7236
> >   4  : d13c141b174afbb568773adf1f39940a2df47c7d
> >   5  : 756a3647403ab141ec2c1ac7325854f4a93f6efd
> > ......
> 
> So the sympton is that it from time to time works and time to time
> fails.

Not exactly. It only works on the second of two directly consecutive calls. 

> 
> Can't recall whether you had interrupts enabled or disabled for the
> TPM chip (depending on whether you use IRQs or polling you'd have
> to tweak the code from a different place), but you could tweak
> directly the TPM2_DURATION_* constants in drivers/char/tpm/tpm.h:
> 
> enum tpm2_timeouts {
> 	TPM2_TIMEOUT_A          =    750,
> 	TPM2_TIMEOUT_B          =   2000,
> 	TPM2_TIMEOUT_C          =    200,
> 	TPM2_TIMEOUT_D          =     30,
> 	TPM2_DURATION_SHORT     =     20,
> 	TPM2_DURATION_MEDIUM    =    750,
> 	TPM2_DURATION_LONG      =   2000,
> 	TPM2_DURATION_LONG_LONG = 300000,
> 	TPM2_DURATION_DEFAULT   = 120000,
> };
> 
> Set SHORT, LONG and MEDIUM to lets say 3000 and lets see if that
> makes a difference or not.
> /Jarkko


I have already tried this but there was not any difference.

Michael


