Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49578C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E4FC20815
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="MmNBsQqj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbfBCNBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 08:01:55 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:47756 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726584AbfBCNBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 08:01:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1549198912; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1c/x43u0PHQlx7pSLMIxE9PJPbA0qB96gKkni0aDsOk=;
        b=MmNBsQqj5Yll2H7Je34TCUQxDgkHIBVjpUOIMKm1zClrIpuuOmi0aeuqSCRoNHaKEw3NkK
        k0pWxN13SiLd7ZMNgFBR07i0fj5kBCKwKKhRv/UvTNSkFjQixGLGUq5eStE1luxBQnER1I
        ThvUcWeOKA7yMtD3Lraz7T+vjxfLVso=
Date:   Sun, 03 Feb 2019 10:01:36 -0300
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2 0/9] Ingenic JZ4780 NAND patchset v2
To:     Boris Brezillon <bbrezillon@kernel.org>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        Mathieu Malaterre <malat@debian.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <1549198896.1950.0@crapouillou.net>
In-Reply-To: <20190203082032.6e37c523@bbrezillon>
References: <20190202231926.2444-1-paul@crapouillou.net>
        <20190203082032.6e37c523@bbrezillon>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le dim. 3 f=E9vr. 2019 =E0 4:20, Boris Brezillon <bbrezillon@kernel.org>=20
a =E9crit :
> On Sat,  2 Feb 2019 20:19:17 -0300
> Paul Cercueil <paul@crapouillou.net> wrote:
>=20
>>  Hi,
>>=20
>>  As requested by Boris, I added a patch to move all the Ingenic NAND
>>  drivers to their own directory.
>>=20
>>  In this V2 I added support for the JZ4740 SoC. The combo of the
>>  jz4780-nemc, jz4780-nand and jz4740-bch now obsolete the old and=20
>> dusty
>>  jz4740-nand driver.
>=20
> Any plan to get the old driver removed? I guess you want to migrate=20
> the
> boards to DT first.

Yes, that's the plan - migrate the qi_lb60 board first then drop the old
driver.

>>=20
>>  To support the only upstream JZ4740-based board we have, the Ben
>>  Nanonote, I added an option to specify the OOB layout of that device
>>  from a device property string.
>>=20
>>  Finally, I dropped the last two patches that moved the platform NAND
>>  code to devicetree; I will upstream them as part of a different
>>  patchset.
>>=20
>>  Cheers,
>>  -Paul
>>=20
>=20
=

