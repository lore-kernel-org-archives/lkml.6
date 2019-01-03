Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_ADSP_ALL,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B801CC43444
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 15:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BB0C20815
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 15:47:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730842AbfACPr6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 10:47:58 -0500
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21742 "EHLO
        sender-of-o53.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729100AbfACPr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 10:47:58 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1546530457; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=S//bdRVFZul+6mnRkQPlmgLs4jQyDNwyXnQI/BWkrQELG/BBiRr63AELUDR8zEBoA0/SbGqDSrinXD7LfnVgUYZ6Cby3NixWAnWKuFL9V0sDT2oefDvblueFutC1kWl6gLIbZh8IkfxWS3wwF/gfUdqtdf0Myx6gWNsp2oOzlTc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1546530457; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=j1kLDDepcKPfCX2pdf2MGoaXSa4LbtUzGFxq628iouE=; 
        b=jOAgPngkhoLfzzDLkf9cGZOSSskfu47vPRrmyUFj2tVR/UxNDnQEVfh0fLpgEjbNSP0nY9u933JE1NwuBFFABPKt51mT0uauWKgrErloxobZ4W0MbPAv4iq/2XnpG4Bk/bu9DHxm1smKailFNUIvLzG+ha1PJNGzUZ+NLVpK880=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=mniewoehner.de;
        spf=pass  smtp.mailfrom=linux@mniewoehner.de;
        dmarc=pass header.from=<linux@mniewoehner.de> header.from=<linux@mniewoehner.de>
Received: from z3r0 (31.187.91.78 [31.187.91.78]) by mx.zohomail.com
        with SMTPS id 1546530456006322.5619608903529; Thu, 3 Jan 2019 07:47:36 -0800 (PST)
Message-ID: <5aa2fc082b6b0657574918b025005ad569da6412.camel@mniewoehner.de>
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
In-Reply-To: <20190103150434.GC17015@linux.intel.com>
References: <ef7e773b01a5e6153b84628f74fc67092a2f9b0e.camel@gmail.com>
         <1f281756bb1f041e55be8dd090670a1a7b1d1c94.camel@mniewoehner.de>
         <1545519232.3940.115.camel@linux.ibm.com>
         <e7ec38d7cade9aa76384aa2781eab307d2cd5a7b.camel@mniewoehner.de>
         <20190103132737.GD10491@linux.intel.com>
         <6c1bf9815bfcb5d2bc0cfedfc49c7feda0173dc9.camel@mniewoehner.de>
         <20190103150434.GC17015@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Date:   Thu, 03 Jan 2019 16:47:31 +0100
Mime-Version: 1.0
User-Agent: Evolution 3.30.3 
Content-Transfer-Encoding: 8BIT
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-01-03 at 17:04 +0200, Jarkko Sakkinen wrote:
> On Thu, Jan 03, 2019 at 02:38:11PM +0100, Michael Niewöhner wrote:
> > On Thu, 2019-01-03 at 15:27 +0200, Jarkko Sakkinen wrote:
> > > On Sun, Dec 23, 2018 at 12:55:12PM +0100, Michael Niewöhner wrote:
> > > > There is another issue but I don't know if both are related. Maybe
> > > > that's
> > > > just a
> > > > timing issue...
> > > > 
> > > > root@debian:~# dd if=/dev/hwrng bs=1 count=1
> > > > dd: error reading '/dev/hwrng': Operation not permitted
> > > > 0+0 records in
> > > > 0+0 records out
> > > > 0 bytes copied, 0.755958 s, 0.0 kB/s
> > > > root@debian:~# dd if=/dev/hwrng bs=1 count=1 | xxd; dd if=/dev/hwrng
> > > > bs=1
> > > > count=1 | xxd
> > > > dd: error reading '/dev/hwrng': Operation not permitted
> > > > 0+0 records in
> > > > 0+0 records out
> > > > 0 bytes copied, 0.755697 s, 0.0 kB/s
> > > > 1+0 records in
> > > > 1+0 records out
> > > > 00000000: 52                                       R
> > > > 1 byte copied, 0.0106268 s, 0.1 kB/s
> > > > 
> > > > 
> > > > Michael
> > > 
> > > What does /sys/devices/virtual/misc/hw_random/rng_current show?
> > > 
> > > Did run commands as a sanity check on my laptop and seem to work.
> > > 
> > > /Jarkko
> > 
> > rng_current says "tpm-rng-0", which should be correct
> 
> Is /dev/tpm0 accessible and usable?
> 
> /Jarkko

No, it does not seem to work:

root@debian:~# tpm_version                                     
Tspi_Context_Connect failed: 0x00003011 - layer=tsp, code=0011 (17),
Communication failure
root@debian:~# tcsd -f
TCSD TDDL ioctl: (25) Inappropriate ioctl for device
TCSD TDDL Falling back to Read/Write device support.
TCSD TDDL ERROR: write to device /dev/tpm0 failed: Operation not permitted
TCSD TCS ERROR: TCS GetCapability failed with result = 0x1087
root@debian:~# stat /dev/tpm0
  File: /dev/tpm0
  Size: 0         	Blocks: 0          IO Block: 4096   character special
file
Device: 6h/6d	Inode: 1114        Links: 1     Device type: a,e0
Access: (0600/crw-------)  Uid: (  104/     tss)   Gid: (  112/     tss)
Access: 2019-01-03 16:39:20.627635333 +0100
Modify: 2019-01-03 16:39:20.627635333 +0100
Change: 2019-01-03 16:39:20.627635333 +0100
 Birth: -

Michael


