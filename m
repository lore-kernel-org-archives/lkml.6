Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_ADSP_ALL,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D29D1C43612
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 13:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A93AF2073D
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 13:38:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730576AbfACNii convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 08:38:38 -0500
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21757 "EHLO
        sender-of-o53.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730102AbfACNii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 08:38:38 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1546522697; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=dR0+n8WIwuNQ7WzdfP1eTsWVgGEv8YzIT2x3jiyCAcRM5imd2zYi138IVczv26cSOEs5KLBCXsFItjfYGCVRl3u68+QxLUZMp6T3duCzfQCv7Bq43Ceq1ZvaFu3r6nVlzkHd1OuevYMRXXXfj/DUHbviv8gL6OdZUOzOVaRG2KQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1546522697; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=dvuEDzWO0WXxXzRD9kR72QfwNmGN+ZF5CdWEgJMFAHs=; 
        b=oCSdRitnYXw9n0RpV0BIb8rm957OE3ArO/sUziX/eKPKupzK+nG+ryUAIj6u99erKF6LWHZy9FqaIwFSdJCpdJNO8kSHsaKWg56BEmCixQS1saAp+hjVL882hsCO+vr/J+JE6wmcy81hgWVg2uL3/MPbFL031uaPI8Tu7uEyaDo=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=mniewoehner.de;
        spf=pass  smtp.mailfrom=linux@mniewoehner.de;
        dmarc=pass header.from=<linux@mniewoehner.de> header.from=<linux@mniewoehner.de>
Received: from z3r0 (31.187.91.78 [31.187.91.78]) by mx.zohomail.com
        with SMTPS id 1546522696206674.9908771612716; Thu, 3 Jan 2019 05:38:16 -0800 (PST)
Message-ID: <6c1bf9815bfcb5d2bc0cfedfc49c7feda0173dc9.camel@mniewoehner.de>
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
In-Reply-To: <20190103132737.GD10491@linux.intel.com>
References: <ef7e773b01a5e6153b84628f74fc67092a2f9b0e.camel@gmail.com>
         <1f281756bb1f041e55be8dd090670a1a7b1d1c94.camel@mniewoehner.de>
         <1545519232.3940.115.camel@linux.ibm.com>
         <e7ec38d7cade9aa76384aa2781eab307d2cd5a7b.camel@mniewoehner.de>
         <20190103132737.GD10491@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Date:   Thu, 03 Jan 2019 14:38:11 +0100
Mime-Version: 1.0
User-Agent: Evolution 3.30.3 
Content-Transfer-Encoding: 8BIT
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-01-03 at 15:27 +0200, Jarkko Sakkinen wrote:
> On Sun, Dec 23, 2018 at 12:55:12PM +0100, Michael Niewöhner wrote:
> > There is another issue but I don't know if both are related. Maybe that's
> > just a
> > timing issue...
> > 
> > root@debian:~# dd if=/dev/hwrng bs=1 count=1
> > dd: error reading '/dev/hwrng': Operation not permitted
> > 0+0 records in
> > 0+0 records out
> > 0 bytes copied, 0.755958 s, 0.0 kB/s
> > root@debian:~# dd if=/dev/hwrng bs=1 count=1 | xxd; dd if=/dev/hwrng bs=1
> > count=1 | xxd
> > dd: error reading '/dev/hwrng': Operation not permitted
> > 0+0 records in
> > 0+0 records out
> > 0 bytes copied, 0.755697 s, 0.0 kB/s
> > 1+0 records in
> > 1+0 records out
> > 00000000: 52                                       R
> > 1 byte copied, 0.0106268 s, 0.1 kB/s
> > 
> > 
> > Michael
> 
> What does /sys/devices/virtual/misc/hw_random/rng_current show?
> 
> Did run commands as a sanity check on my laptop and seem to work.
> 
> /Jarkko

rng_current says "tpm-rng-0", which should be correct


Michael


