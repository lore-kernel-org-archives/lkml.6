Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIM_ADSP_ALL,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA4BEC43612
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 15:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B074B21872
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 15:29:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbfADP26 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 10:28:58 -0500
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21812 "EHLO
        sender-of-o53.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfADP26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 10:28:58 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1546615713; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=Qm4fQ9iehurKHb+4Iugw+Rw0w5XTBPdrAdUekqKP1xrnNVV4FkxdR9NrkAoAlnNnOxiZoku/Z98VO9ZviDnYW3lsev2QtwP/NjrOrve7qx7m/aICbpdOFVd7p2ZqqhkhPAZdVDoqVlZKWwUY+GT+wGQ92+VwzBwfCWIRI0tD7/c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1546615713; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=bLK48qKyjF5EgCddFBpN6JZnbFWOG0HBXb7DnW33j4Q=; 
        b=aIAk/trQks9iJiskDu6SzEGxvw1gHcJz04wQGKt4BLesJVY2zkPcaltCsvqG07dQLZ0JqWkUQKGUOWpv+Bhrg0TFKLDxVHr1Z5jjz9c+p+ehFRVxF3zbnTr3xmmwbJx7wBx7NjZDIAX78c7XNNCN1aZmB//b3Dl8c1BApPwd6Is=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=mniewoehner.de;
        spf=pass  smtp.mailfrom=linux@mniewoehner.de;
        dmarc=pass header.from=<linux@mniewoehner.de> header.from=<linux@mniewoehner.de>
Received: from z3r0 (31.187.91.78 [31.187.91.78]) by mx.zohomail.com
        with SMTPS id 15466157088771015.2099884845039; Fri, 4 Jan 2019 07:28:28 -0800 (PST)
Message-ID: <5ee514be264361a8f1ed4a4ad823ad72dd7dce23.camel@mniewoehner.de>
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
In-Reply-To: <c1f5f53cdaaaad6cc80c2b10172a69f0301d3e0e.camel@mniewoehner.de>
References: <ef7e773b01a5e6153b84628f74fc67092a2f9b0e.camel@gmail.com>
         <1f281756bb1f041e55be8dd090670a1a7b1d1c94.camel@mniewoehner.de>
         <1545519232.3940.115.camel@linux.ibm.com>
         <e7ec38d7cade9aa76384aa2781eab307d2cd5a7b.camel@mniewoehner.de>
         <20190103132737.GD10491@linux.intel.com>
         <6c1bf9815bfcb5d2bc0cfedfc49c7feda0173dc9.camel@mniewoehner.de>
         <20190103150434.GC17015@linux.intel.com>
         <5aa2fc082b6b0657574918b025005ad569da6412.camel@mniewoehner.de>
         <c1f5f53cdaaaad6cc80c2b10172a69f0301d3e0e.camel@mniewoehner.de>
Content-Type: text/plain; charset="UTF-8"
Date:   Fri, 04 Jan 2019 16:28:24 +0100
Mime-Version: 1.0
User-Agent: Evolution 3.30.3 
Content-Transfer-Encoding: 8BIT
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-01-04 at 12:58 +0100, Michael Niewöhner wrote:
> On Thu, 2019-01-03 at 16:47 +0100, Michael Niewöhner wrote:
> > On Thu, 2019-01-03 at 17:04 +0200, Jarkko Sakkinen wrote:
> > > On Thu, Jan 03, 2019 at 02:38:11PM +0100, Michael Niewöhner wrote:
> > > > On Thu, 2019-01-03 at 15:27 +0200, Jarkko Sakkinen wrote:
> > > > > On Sun, Dec 23, 2018 at 12:55:12PM +0100, Michael Niewöhner wrote:
> > > > > > There is another issue but I don't know if both are related. Maybe
> > > > > > that's
> > > > > > just a
> > > > > > timing issue...
> > > > > > 
> > > > > > root@debian:~# dd if=/dev/hwrng bs=1 count=1
> > > > > > dd: error reading '/dev/hwrng': Operation not permitted
> > > > > > 0+0 records in
> > > > > > 0+0 records out
> > > > > > 0 bytes copied, 0.755958 s, 0.0 kB/s
> > > > > > root@debian:~# dd if=/dev/hwrng bs=1 count=1 | xxd; dd if=/dev/hwrng
> > > > > > bs=1
> > > > > > count=1 | xxd
> > > > > > dd: error reading '/dev/hwrng': Operation not permitted
> > > > > > 0+0 records in
> > > > > > 0+0 records out
> > > > > > 0 bytes copied, 0.755697 s, 0.0 kB/s
> > > > > > 1+0 records in
> > > > > > 1+0 records out
> > > > > > 00000000: 52                                       R
> > > > > > 1 byte copied, 0.0106268 s, 0.1 kB/s
> > > > > > 
> > > > > > 
> > > > > > Michael
> > > > > 
> > > > > What does /sys/devices/virtual/misc/hw_random/rng_current show?
> > > > > 
> > > > > Did run commands as a sanity check on my laptop and seem to work.
> > > > > 
> > > > > /Jarkko
> > > > 
> > > > rng_current says "tpm-rng-0", which should be correct
> > > 
> > > Is /dev/tpm0 accessible and usable?
> > > 
> > > /Jarkko
> > 
> > No, it does not seem to work:
> > 
> > root@debian:~# tpm_version                                     
> > Tspi_Context_Connect failed: 0x00003011 - layer=tsp, code=0011 (17),
> > Communication failure
> > root@debian:~# tcsd -f
> > TCSD TDDL ioctl: (25) Inappropriate ioctl for device
> > TCSD TDDL Falling back to Read/Write device support.
> > TCSD TDDL ERROR: write to device /dev/tpm0 failed: Operation not permitted
> > TCSD TCS ERROR: TCS GetCapability failed with result = 0x1087
> > root@debian:~# stat /dev/tpm0
> >   File: /dev/tpm0
> >   Size: 0         	Blocks: 0          IO Block: 4096   character special
> > file
> > Device: 6h/6d	Inode: 1114        Links: 1     Device type: a,e0
> > Access: (0600/crw-------)  Uid: (  104/     tss)   Gid: (  112/     tss)
> > Access: 2019-01-03 16:39:20.627635333 +0100
> > Modify: 2019-01-03 16:39:20.627635333 +0100
> > Change: 2019-01-03 16:39:20.627635333 +0100
> >  Birth: -
> > 
> > Michael
> 
> I have done some more tests with tpm2-tests from 
> https://github.com/jethrogb/tpm2-utils.
> These are my results:
> 
> 
> (initramfs) ./tpm2-test /dev/tpm0 vendor_tpm_type
> Error on write(fd,(char*)&tpm_cmd,sizeof(tpm_cmd)): Operation not permitted
> 
> (initramfs) ./tpm2-test /dev/tpm0 vendor_tpm_type; ./tpm2-test /dev/tpm0
> vendor_
> tpm_type
> Error on write(fd,(char*)&tpm_cmd,sizeof(tpm_cmd)): Operation not permitted
> �   
> nitramfs) 
> 
> -> Same symptom like with dd if=/dev/tpm....
> 
> 
> Trying to read the firmware version:
> 
> (initramfs) (./tpm2-test /dev/tpm0 vendor_string_1; ./tpm2-test /dev/tpm0
> firmwa
> re_version_1;) 2>/dev/null | hexdump -C
> 00000000  80 01 00 00 00 1b 00 00  00 00 01 00 00 00 06 00  |................|
> 00000010  00 00 01 00 00 01 0b 00  01 00 03                 |...........|
> 0000001b
> 
> (initramfs) (./tpm2-test /dev/tpm0 vendor_string_1; ./tpm2-test /dev/tpm0
> firmwa
> re_version_2;) 2>/dev/null | hexdump -C
> 00000000  80 01 00 00 00 1b 00 00  00 00 01 00 00 00 06 00  |................|
> 00000010  00 00 01 00 00 01 0c 00  02 00 08                 |...........|
> 0000001b
> 
> -> This version numbers are correct, 1.3.2.8 indeed is the current flashed
> firmware.
> 
> 
> Get the vendor strings:
> 
> (initramfs) (./tpm2-test /dev/tpm0 vendor_string_1; ./tpm2-test /dev/tpm0
> vendor
> _string_1;) 2>/dev/null | xxd
> 00000000: 8001 0000 001b 0000 0000 0100 0000 0600  ................
> 00000010: 0000 0100 0001 0672 6c73 00              .......rls.
> (initramfs) (./tpm2-test /dev/tpm0 vendor_string_1; ./tpm2-test /dev/tpm0
> vendor
> _string_2;) 2>/dev/null | xxd
> 00000000: 8001 0000 001b 0000 0000 0100 0000 0600  ................
> 00000010: 0000 0100 0001 074e 5043 54              .......NPCT
> (initramfs) (./tpm2-test /dev/tpm0 vendor_string_1; ./tpm2-test /dev/tpm0
> vendor
> _string_3;) 2>/dev/null | xxd
> 00000000: 8001 0000 001b 0000 0000 0100 0000 0600  ................
> 00000010: 0000 0100 0001 0820 0000 00              ....... ...
> (initramfs) (./tpm2-test /dev/tpm0 vendor_string_1; ./tpm2-test /dev/tpm0
> vendor
> _string_4;) 2>/dev/null | xxd
> 00000000: 8001 0000 001b 0000 0000 0100 0000 0600  ................
> 00000010: 0000 0100 0001 0920 0000 00              ....... ...
> 
> Well, NPCT is correct...
> 
> 
> 
> Michael

Oh damn. I wasn not aware that trousers/tcsd does only support TPM<=1.2.
Instead of trousers I now tested tpm2-tools and tss2.
Guess what? Same symptoms... This is definitely some sort of timing issue...


root@debian:~# tpm2_nvlist 
ERROR:tcti:src/util/io.c:102:write_all() failed to write to fd 3: Operation not
permitted 
ERROR:tcti:src/tss2-tcti/tcti-device.c:86:tcti_device_transmit() wrong number of
bytes written. Expected 22, wrote 0. 
ERROR: GetCapability:Get NV Index list Error. TPM Error:0xa000a
ERROR: Unable to run tpm2_nvlist
root@debian:~# tpm2_nvlist; tpm2_nvlist
ERROR:tcti:src/util/io.c:102:write_all() failed to write to fd 3: Operation not
permitted 
ERROR:tcti:src/tss2-tcti/tcti-device.c:86:tcti_device_transmit() wrong number of
bytes written. Expected 22, wrote 0. 
ERROR: GetCapability:Get NV Index list Error. TPM Error:0xa000a
ERROR: Unable to run tpm2_nvlist
0x1800001:
  hash algorithm:
    friendly: sha256
    value: 0xB
  attributes:
    friendly:
authwrite|policydelete|writelocked|writedefine|authread|no_da|written|platformcr
eate
    value: 0x42C0462
  size: 70
........

root@debian:~# tpm2_pcrlist
ERROR:tcti:src/util/io.c:102:write_all() failed to write to fd 3: Operation not
permitted 
ERROR:tcti:src/tss2-tcti/tcti-device.c:86:tcti_device_transmit() wrong number of
bytes written. Expected 22, wrote 0. 
ERROR: GetCapability: Get PCR allocation status Error. TPM Error:0xa000a......
ERROR: Unable to run tpm2_pcrlist
root@debian:~# tpm2_pcrlist; tpm2_pcrlist 
sha1 :
  0  : 1ebb2be3b7103a09b5caeeb5827c1242cd6632ec
  1  : 425e833da73cb511150d6ffcf6fac64e9a6feb58
  2  : b2a83b0ebf2f8374299a5b2bdfc31ea955ad7236
  3  : b2a83b0ebf2f8374299a5b2bdfc31ea955ad7236
  4  : d13c141b174afbb568773adf1f39940a2df47c7d
  5  : 756a3647403ab141ec2c1ac7325854f4a93f6efd
......


Michael


