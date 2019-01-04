Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIM_ADSP_ALL,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B068BC43613
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 11:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CAE2218D2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 11:58:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbfADL61 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 06:58:27 -0500
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21833 "EHLO
        sender-of-o53.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbfADL61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 06:58:27 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1546603087; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=A+OtUU7dMPSMMawQ4BHkwQ7Ez7b5p0cWM37qIPJqMmyXp79NDUTMMKD1AX3rTzGuJ2QS1KNWYEkAXNsfMhskGa0Ry9kZrHTfbuWMvgin9Sr9uSzRSM6N197rzlQU/Uow8ja8xlkozqgZBEVj7ZUTD/MGzlQF+BcXF/m+k7METzA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1546603087; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=GWI9oG4e7XL1INJ/QGGbB9uycQHnhx01HWHk5nsFgqU=; 
        b=RhCB8/K5cKawTExgKnB3MWk21msdr3MyE8cEzJJnE5jij549cS8clizRdYEMSMnCDFtPOmx3t/REmX4/bSq2g5++oJTNFE5mKS0prUlbEMzrKX0vMV1t2fMlgleVaImq+xPaVD5OIQwRb/BUl13Z9YznQfHzFRftR+AMfwDegFU=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=mniewoehner.de;
        spf=pass  smtp.mailfrom=linux@mniewoehner.de;
        dmarc=pass header.from=<linux@mniewoehner.de> header.from=<linux@mniewoehner.de>
Received: from z3r0 (31.187.91.78 [31.187.91.78]) by mx.zohomail.com
        with SMTPS id 1546603084888666.6001938298234; Fri, 4 Jan 2019 03:58:04 -0800 (PST)
Message-ID: <c1f5f53cdaaaad6cc80c2b10172a69f0301d3e0e.camel@mniewoehner.de>
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
In-Reply-To: <5aa2fc082b6b0657574918b025005ad569da6412.camel@mniewoehner.de>
References: <ef7e773b01a5e6153b84628f74fc67092a2f9b0e.camel@gmail.com>
         <1f281756bb1f041e55be8dd090670a1a7b1d1c94.camel@mniewoehner.de>
         <1545519232.3940.115.camel@linux.ibm.com>
         <e7ec38d7cade9aa76384aa2781eab307d2cd5a7b.camel@mniewoehner.de>
         <20190103132737.GD10491@linux.intel.com>
         <6c1bf9815bfcb5d2bc0cfedfc49c7feda0173dc9.camel@mniewoehner.de>
         <20190103150434.GC17015@linux.intel.com>
         <5aa2fc082b6b0657574918b025005ad569da6412.camel@mniewoehner.de>
Content-Type: text/plain; charset="UTF-8"
Date:   Fri, 04 Jan 2019 12:58:00 +0100
Mime-Version: 1.0
User-Agent: Evolution 3.30.3 
Content-Transfer-Encoding: 8BIT
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-01-03 at 16:47 +0100, Michael Niewöhner wrote:
> On Thu, 2019-01-03 at 17:04 +0200, Jarkko Sakkinen wrote:
> > On Thu, Jan 03, 2019 at 02:38:11PM +0100, Michael Niewöhner wrote:
> > > On Thu, 2019-01-03 at 15:27 +0200, Jarkko Sakkinen wrote:
> > > > On Sun, Dec 23, 2018 at 12:55:12PM +0100, Michael Niewöhner wrote:
> > > > > There is another issue but I don't know if both are related. Maybe
> > > > > that's
> > > > > just a
> > > > > timing issue...
> > > > > 
> > > > > root@debian:~# dd if=/dev/hwrng bs=1 count=1
> > > > > dd: error reading '/dev/hwrng': Operation not permitted
> > > > > 0+0 records in
> > > > > 0+0 records out
> > > > > 0 bytes copied, 0.755958 s, 0.0 kB/s
> > > > > root@debian:~# dd if=/dev/hwrng bs=1 count=1 | xxd; dd if=/dev/hwrng
> > > > > bs=1
> > > > > count=1 | xxd
> > > > > dd: error reading '/dev/hwrng': Operation not permitted
> > > > > 0+0 records in
> > > > > 0+0 records out
> > > > > 0 bytes copied, 0.755697 s, 0.0 kB/s
> > > > > 1+0 records in
> > > > > 1+0 records out
> > > > > 00000000: 52                                       R
> > > > > 1 byte copied, 0.0106268 s, 0.1 kB/s
> > > > > 
> > > > > 
> > > > > Michael
> > > > 
> > > > What does /sys/devices/virtual/misc/hw_random/rng_current show?
> > > > 
> > > > Did run commands as a sanity check on my laptop and seem to work.
> > > > 
> > > > /Jarkko
> > > 
> > > rng_current says "tpm-rng-0", which should be correct
> > 
> > Is /dev/tpm0 accessible and usable?
> > 
> > /Jarkko
> 
> No, it does not seem to work:
> 
> root@debian:~# tpm_version                                     
> Tspi_Context_Connect failed: 0x00003011 - layer=tsp, code=0011 (17),
> Communication failure
> root@debian:~# tcsd -f
> TCSD TDDL ioctl: (25) Inappropriate ioctl for device
> TCSD TDDL Falling back to Read/Write device support.
> TCSD TDDL ERROR: write to device /dev/tpm0 failed: Operation not permitted
> TCSD TCS ERROR: TCS GetCapability failed with result = 0x1087
> root@debian:~# stat /dev/tpm0
>   File: /dev/tpm0
>   Size: 0         	Blocks: 0          IO Block: 4096   character special
> file
> Device: 6h/6d	Inode: 1114        Links: 1     Device type: a,e0
> Access: (0600/crw-------)  Uid: (  104/     tss)   Gid: (  112/     tss)
> Access: 2019-01-03 16:39:20.627635333 +0100
> Modify: 2019-01-03 16:39:20.627635333 +0100
> Change: 2019-01-03 16:39:20.627635333 +0100
>  Birth: -
> 
> Michael


I have done some more tests with tpm2-tests from 
https://github.com/jethrogb/tpm2-utils.
These are my results:


(initramfs) ./tpm2-test /dev/tpm0 vendor_tpm_type
Error on write(fd,(char*)&tpm_cmd,sizeof(tpm_cmd)): Operation not permitted

(initramfs) ./tpm2-test /dev/tpm0 vendor_tpm_type; ./tpm2-test /dev/tpm0 vendor_
tpm_type
Error on write(fd,(char*)&tpm_cmd,sizeof(tpm_cmd)): Operation not permitted
�   
nitramfs) 

-> Same symptom like with dd if=/dev/tpm....


Trying to read the firmware version:

(initramfs) (./tpm2-test /dev/tpm0 vendor_string_1; ./tpm2-test /dev/tpm0 firmwa
re_version_1;) 2>/dev/null | hexdump -C
00000000  80 01 00 00 00 1b 00 00  00 00 01 00 00 00 06 00  |................|
00000010  00 00 01 00 00 01 0b 00  01 00 03                 |...........|
0000001b

(initramfs) (./tpm2-test /dev/tpm0 vendor_string_1; ./tpm2-test /dev/tpm0 firmwa
re_version_2;) 2>/dev/null | hexdump -C
00000000  80 01 00 00 00 1b 00 00  00 00 01 00 00 00 06 00  |................|
00000010  00 00 01 00 00 01 0c 00  02 00 08                 |...........|
0000001b

-> This version numbers are correct, 1.3.2.8 indeed is the current flashed
firmware.


Get the vendor strings:

(initramfs) (./tpm2-test /dev/tpm0 vendor_string_1; ./tpm2-test /dev/tpm0 vendor
_string_1;) 2>/dev/null | xxd
00000000: 8001 0000 001b 0000 0000 0100 0000 0600  ................
00000010: 0000 0100 0001 0672 6c73 00              .......rls.
(initramfs) (./tpm2-test /dev/tpm0 vendor_string_1; ./tpm2-test /dev/tpm0 vendor
_string_2;) 2>/dev/null | xxd
00000000: 8001 0000 001b 0000 0000 0100 0000 0600  ................
00000010: 0000 0100 0001 074e 5043 54              .......NPCT
(initramfs) (./tpm2-test /dev/tpm0 vendor_string_1; ./tpm2-test /dev/tpm0 vendor
_string_3;) 2>/dev/null | xxd
00000000: 8001 0000 001b 0000 0000 0100 0000 0600  ................
00000010: 0000 0100 0001 0820 0000 00              ....... ...
(initramfs) (./tpm2-test /dev/tpm0 vendor_string_1; ./tpm2-test /dev/tpm0 vendor
_string_4;) 2>/dev/null | xxd
00000000: 8001 0000 001b 0000 0000 0100 0000 0600  ................
00000010: 0000 0100 0001 0920 0000 00              ....... ...

Well, NPCT is correct...



Michael


