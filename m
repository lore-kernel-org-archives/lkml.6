Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_ADSP_ALL,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B2EDC43612
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 16:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1309A218AE
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 16:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728863AbfAAQQI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 11:16:08 -0500
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21848 "EHLO
        sender-of-o53.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfAAQQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 11:16:07 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1546359346; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=M2SvHFeyehJTBGsQVDYruuJp3KnKU5sQRiSNgteJQ/SnwxjIW3OEOui/ukrDO80DHNgTs4ansX2pnvKVC9fBLdWtYf5CkZ+VXHlhw/JRVKT977AXTxX+nafM3vxjlDEQALqIBevvxWzI9udeym6Ze+xmVCofoOmJFFov5/vpGPY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1546359346; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=QwPyCcfpi76YeoNHUj5YVKVltz1QRDQpOn8356tJ4+w=; 
        b=M/y2UwFNXXvyLcQxw18G66qV0g0IJStgMgn7MzEhMBhDrE9Q9iHZIX3DhoIDTQuX7wfDWCYXrdNAQvDEilUuDzzMGKJcq2vstb3oFzqS3Q84SVRjEIj1A4boyHiVBb+rY/o1dG/Ib5XnBlfE3e7JhvmKd4C6o5zYgg4kT82YoF8=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=mniewoehner.de;
        spf=pass  smtp.mailfrom=linux@mniewoehner.de;
        dmarc=pass header.from=<linux@mniewoehner.de> header.from=<linux@mniewoehner.de>
Received: from z3r0 (31.187.91.78 [31.187.91.78]) by mx.zohomail.com
        with SMTPS id 1546359345156561.599932662492; Tue, 1 Jan 2019 08:15:45 -0800 (PST)
Message-ID: <0902784697eea3fc522e21a89cdecb745f12c83c.camel@mniewoehner.de>
Subject: Re: tpm_tis TPM2.0 not detected on cold boot
From:   Michael =?ISO-8859-1?Q?Niew=F6hner?= <linux@mniewoehner.de>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        peterhuewe@gmx.de, jgg@ziepe.ca, arnd@arndb.de,
        linux-integrity@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Nayna Jain <nayna@linux.ibm.com>,
        Ken Goldman <kgold@linux.ibm.com>
In-Reply-To: <1546291059.4069.158.camel@linux.ibm.com>
References: <ef7e773b01a5e6153b84628f74fc67092a2f9b0e.camel@gmail.com>
         <1f281756bb1f041e55be8dd090670a1a7b1d1c94.camel@mniewoehner.de>
         <1545519232.3940.115.camel@linux.ibm.com>
         <e7ec38d7cade9aa76384aa2781eab307d2cd5a7b.camel@mniewoehner.de>
         <b75fd04643daf5aab5a1fc115e8fbfca9a381f8d.camel@mniewoehner.de>
         <1546140837.4069.81.camel@linux.ibm.com>
         <912668ea1d74f526f78f03f562fdaf17fc06f62c.camel@mniewoehner.de>
         <1546291059.4069.158.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date:   Tue, 01 Jan 2019 17:15:40 +0100
Mime-Version: 1.0
User-Agent: Evolution 3.30.3 
Content-Transfer-Encoding: 8BIT
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-12-31 at 16:17 -0500, Mimi Zohar wrote:
> On Sun, 2018-12-30 at 14:22 +0100, Michael Niewöhner wrote:
> 
> > > difference is that on a cold boot, the TPM takes longer to initialize.
> > 
> > Well, as I said. Waiting for 10, 20 or even 60 seconds in the boot manager
> > does
> > not solve the problem. So the problem is NOT that the TPM takes longer to
> > initialize. Even adding a delay of 20 seconds before TPM init does not solve
> > that while that should be more than enough time.
> 
> The purpose of commenting out the TPM2 selftest was to minimize the
> TPM initialization delay, so that the TPM is ready before IMA.  After
> James' patch that wasn't needed anymore.
> 
> Looking back at this thread, I see you're using systemd-boot, not
> grub2.  When you commented out the systemd-boot timeout, IMA found the
> TPM.  The question is why isn't the TPM ready with the timeout before
> IMA (like above)?  Has systemd-boot done the selftest?

I am not sure wether systemd-boot touches TPM at all but I get the same
behaviour with syslinux-efi.

> 
> Mimi
> 


