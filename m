Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_ADSP_ALL,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B9CBC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 19:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1B8B20664
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 19:16:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1B8B20664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mniewoehner.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbeK0GLE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 01:11:04 -0500
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21729 "EHLO
        sender-of-o53.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbeK0GLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 01:11:04 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1543259743; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=eXZTEmv3Bg6ItBDSzvBut5Sea5g/JQsFGC7zIf2oFg4IwFfx2HwYsP9v2tnZUN8KjMLSzFwxJYUv/I9S3BIpEHw+fYHBogATBChypExfgCWnzeixEd+zQtZeQ4qUY2S26UafGeLVPWosN9wa4fq/Qn9JurD8zUrQV8/Eg/PBKe4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1543259743; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=NXUfmg6T6R7QXiYDCCrKuqomD8dCXuyJnEHVcyBQiqE=; 
        b=ftbub+mjLyi3WfrnJmbXL/V6Eznyoarjs8FFpFCZlj7wa4tLj5gaiUU6zw1Ov0QTI55PMMhL7mm6e7oxiw5I7Cf8HF8CtzD1PasGSPANpUaeiIrUUcFGe2UfUkhPWI4zFNJKRoysenMs8NSvEoXUjxAb4rkD/BA/nNwmrwBsIP8=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=mniewoehner.de;
        spf=pass  smtp.mailfrom=linux@mniewoehner.de;
        dmarc=pass header.from=<linux@mniewoehner.de> header.from=<linux@mniewoehner.de>
Received: from z3r0 (31.187.91.78 [31.187.91.78]) by mx.zohomail.com
        with SMTPS id 154325974190643.82636583836552; Mon, 26 Nov 2018 11:15:41 -0800 (PST)
Message-ID: <a4b30f21571d620db8d4ce311df5856f38b3d1a7.camel@mniewoehner.de>
Subject: Re: [BUG] Nuvoton NCPT650 TPM 2.0 mode not working
From:   Michael =?ISO-8859-1?Q?Niew=F6hner?= <linux@mniewoehner.de>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        peterhuewe@gmx.de, jgg@ziepe.ca, arnd@arndb.de,
        linux-integrity@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Nayna Jain <nayna@linux.ibm.com>
In-Reply-To: <49ec628f42fa7833f6a75d4a8b15d64789c70bf7.camel@mniewoehner.de>
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
         <49ec628f42fa7833f6a75d4a8b15d64789c70bf7.camel@mniewoehner.de>
Content-Type: text/plain; charset="UTF-8"
Date:   Mon, 26 Nov 2018 20:15:38 +0100
Mime-Version: 1.0
X-Mailer: Evolution 3.28.5 
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again,

after some experiments I finally found a solution...
There seems to be a bug in TPM2.0 firmware version (1.3.1.0) included in Lenovos
UEFI image but they do not provide an update.

I have extracted the firmware version 1.3.2.8 from Dell's XPS15 TPM2.0 firmware
update and used this to replace the firmware in my Lenovo UEFI image.
After flashing this version via UEFI Setup the TPM2.0 gets detected and now is
fully working. WTF.

For anyone having the same problem: binwalk, uefi-firmware-parser, uefipatch and
flashrom are your friends ;-)

Best regards
Michael


