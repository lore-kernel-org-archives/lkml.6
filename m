Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F08BCC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 12:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A63820891
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 12:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="SCvToeCE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A63820891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goldelico.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729091AbeGYNjH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 09:39:07 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.53]:30838 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728791AbeGYNjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 09:39:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1532521656;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=JsntnmaWsubbScLuU7xEocNdIi9CO4sb/iuOcIjCzsQ=;
        b=SCvToeCE31UOcstqwMmBsbbJ3fqxqDHK6RhuoCvOqyEavnq+NWi6epAHQvYhc3ZY/3
        xiWF4difhJzTncZF3V5H0vCh0NJCOGXwcY8ScX/Z062nm+JIq+FePra2O14HJ7FUDgiT
        essaRvaLeloh+jz0FrBuvfQJYGzpnXb7enRGv3bG8iYxb7/ExNIc5zcG1UM5GVDPJuFT
        Aitgo0c8j9O9rUFUdoiOfsGMxs9PM1iSNcJp/NseMvjUuW6yNa4LVeWOmRg5fMdZc1yA
        ckoPeMVQXBVspan+0I+HfpJzVr9K0FYtpsY9+wsiHxytU//hKQ3ZlZngltTdnnyM7Grv
        HWgg==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj4Qpw87Wiuc1qET/2Lw=="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 43.13 DYNA|AUTH)
        with ESMTPSA id 6047f4u6PCRWfPK
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 25 Jul 2018 14:27:32 +0200 (CEST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 09/32] ARM: dts: omap3-gta04: make NAND partitions compatible with recent U-Boot
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20180725083305.GB8303@lenoch>
Date:   Wed, 25 Jul 2018 14:27:31 +0200
Cc:     Marek Belisko <marek@goldelico.com>,
        =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <85BC9F70-2E58-4915-9405-7CC1855975C4@goldelico.com>
References: <cover.1532501910.git.hns@goldelico.com> <8dcf3efd3270451314a663c125841ca87ed2b387.1532501910.git.hns@goldelico.com> <20180725080735.GA7467@lenoch> <EECC7962-DEAB-4C21-98A7-EBAE4AEA312B@goldelico.com> <20180725083305.GB8303@lenoch>
To:     Ladislav Michl <ladis@linux-mips.org>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Am 25.07.2018 um 10:33 schrieb Ladislav Michl <ladis@linux-mips.org>:
>=20
> On Wed, Jul 25, 2018 at 10:18:28AM +0200, H. Nikolaus Schaller wrote:
>>=20
>>> Am 25.07.2018 um 10:07 schrieb Ladislav Michl =
<ladis@linux-mips.org>:
>>>=20
>>> On Wed, Jul 25, 2018 at 08:58:41AM +0200, H. Nikolaus Schaller =
wrote:
>>>> Vendor defined U-Boot has changed the partition scheme a while ago:
>>>>=20
>>>> * kernel partition 6MB
>>>> * file system partition uses the remainder up to end of the NAND
>>>> * increased size of the environment partition (to get an OneNAND =
compatible base address)
>>>> * shrink the U-Boot partition
>>>>=20
>>>> Let's be compatible (e.g. Debian kernel built from upstream).
>>>=20
>>> That, in fact, is breaking compatibility.
>>=20
>> With what? Nobody is using the old u-boot partition scheme any more
>> (it is >5 years old).
>>=20
>>> So once you are touching this
>>> what about relying on partitioning provided by bootloader just to =
prevent
>>> something like this happening again?
>>=20
>> Well, we define what compatible means here (since we are the vendor).
>> And people complain with us. We simply recommend them to upgrade the
>> boot-loader.
>=20
> Fair enough. Suggestion was to remove partitioning scheme from DTB =
alltogether
> and let U-Boot provide one. But you being vendor you decide, of course =
:)
> (I'd use only two partitions: MLO and UBI, latter one with BCH8, and =
store
> everything in UBI volumes. That's a bit more flexible approach)

Yes, that is a good goal for a future setup and would of course be =
better.
Like U-Boot already provides the memory layout for RAM.

Hopefully, someone will work out patches for u-boot plus kernel (which =
is always
painful to keep these two in sync and tested). But I don't want to do =
that now.

BR and thanks,
Nikolaus

