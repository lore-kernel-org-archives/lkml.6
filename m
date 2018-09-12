Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA94CC070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 19:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F54F213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 19:00:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cesnet.cz header.i=@cesnet.cz header.b="h9ux78zp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F54F213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cesnet.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbeIMAGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 20:06:31 -0400
Received: from office2.cesnet.cz ([195.113.144.244]:51358 "EHLO
        office2.cesnet.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727626AbeIMAGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 20:06:31 -0400
Received: from localhost (unknown [IPv6:2001:718:1:2c:7d03:949b:de91:81b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by office2.cesnet.cz (Postfix) with ESMTPSA id CCD51400066;
        Wed, 12 Sep 2018 21:00:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
        s=office2; t=1536778837;
        bh=6y8htXY33o48KvH0N4okbs3tt5c/yVnz+kLDMnWd7zM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=h9ux78zp8jXhzoXAtFp+dT0dFNORAM3TOOEVrT9DY212XoWg/IEhfrOwgdFfHVkzY
         VfKGB7eeyqRu2HH8tcCdqAXR9XOIOofjmh880ptIq86uT8kisjVRDIqHncurHWBmhg
         qi8Hb2PCz1dYTkMJPk7Txex4FnIy7Ckqxw+T5IFc=
From:   =?iso-8859-1?Q?Jan_Kundr=E1t?= <jan.kundrat@cesnet.cz>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Baruch Siach <baruch@tkos.co.il>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Russell King <linux@armlinux.org.uk>
Subject: Re: [BISECTED] Regression: Solidrun Clearfog Base won't boot since =?iso-8859-1?Q?"PCI:_mvebu:_Only_remap_I/O_space_if_configured"?=
Date:   Wed, 12 Sep 2018 21:00:35 +0200
MIME-Version: 1.0
Message-ID: <7745d264-5d11-42a1-b491-95887a807894@cesnet.cz>
In-Reply-To: <20180912205052.19de01a0@windsurf>
References: <61fdfd69-2bb6-478c-b0d5-69d8744adae3@cesnet.cz>
 <87zhwm4kl6.fsf@tkos.co.il> <20180912205052.19de01a0@windsurf>
Organization: CESNET
User-Agent: Trojita/v0.7-361-gfee56b6f-dirty; Qt/5.11.0; xcb; Linux; Gentoo Base System release 2.4.1
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> You mean '4.19-rc3', right?

Right, sorry.

>>>> [    1.741458] Internal error: Oops - undefined instruction:=20
>>>> 0 [#1] SMP ARM
>>>> [    1.748182] CPU: 1 PID: 72 Comm: kworker/1:2 Tainted: G  =20
>>>>      W         4.19.0-rc3 #1 =20
>>=20
>> The 'W' taint means that there was a kernel warning before. Which
>> warning was that?

I have "spidev" listed in my DT, and the kernel complains about that;=20
that's a harmelss warning. (I sent a patch which adds my particular device=20=

into the spidev driver some time ago.)=20

With kind regards,
Jan
