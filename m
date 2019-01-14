Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C2D0C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6A8E20657
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UCip00fT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbfANNmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 08:42:50 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:45152 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbfANNmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 08:42:49 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0EDgdgx025608;
        Mon, 14 Jan 2019 07:42:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547473359;
        bh=q/Jei6rT+ZDcSWlH6Zqw6iD1MFlpHsinovfIpAYGoQs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=UCip00fTzEWlm95TlA/2uEtzUp+eS5JwuUWk35GDjGVgIx0Og3JWqdufk4phXUbd/
         kLDWrASV564skGEXHbtPETeSVHb2y2euzVifz1U7kp4MNsnvQqXtUUfn8kpsT9g2/T
         upz35hur4DQJ2d1QPO0exbbhA155jm0VNyyy8ER0=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0EDgd6Y113086
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 14 Jan 2019 07:42:39 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 14
 Jan 2019 07:42:38 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 14 Jan 2019 07:42:38 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0EDgZ2N028966;
        Mon, 14 Jan 2019 07:42:35 -0600
Subject: Re: [PATCH 1/1] phy: fix build breakage: add PHY_MODE_SATA
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Olof Johansson <olof@lixom.net>
CC:     Jens Axboe <axboe@kernel.dk>, <john.hubbard@gmail.com>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Rob Herring <robh@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Grzegorz Jaszczyk <jaz@semihalf.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20190113012909.11986-1-jhubbard@nvidia.com>
 <20190113012909.11986-2-jhubbard@nvidia.com>
 <9518922c-ab17-ba06-0670-f0202b436a8c@kernel.dk>
 <CAOesGMjiYkThVa5BQo0w3B1wC3NJpmsrYFwXVCN0VQqYqF_MWg@mail.gmail.com>
 <20190114095745.04027f37@xps13>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <db6acfd5-645c-1231-aaac-c4ec0dda8e5e@ti.com>
Date:   Mon, 14 Jan 2019 19:12:13 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190114095745.04027f37@xps13>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/01/19 2:27 PM, Miquel Raynal wrote:
> Hi Olof,
> 
> Olof Johansson <olof@lixom.net> wrote on Sat, 12 Jan 2019 19:57:12
> -0800:
> 
>> On Sat, Jan 12, 2019 at 6:05 PM Jens Axboe <axboe@kernel.dk> wrote:
>>>
>>> On 1/12/19 6:29 PM, john.hubbard@gmail.com wrote:  
>>>> From: John Hubbard <jhubbard@nvidia.com>
>>>>
>>>> Commit 49e54187ae0b ("ata: libahci_platform: comply to PHY framework") uses
>>>> the PHY_MODE_SATA, but that enum had not yet been added. This caused a
>>>> build failure for me, with today's linux.git.
>>>>
>>>> Also, there is a potentially conflicting (mis-named) PHY_MODE_SATA, hiding
>>>> in the Marvell Berlin SATA PHY driver.
>>>>
>>>> Fix the build by:
>>>>
>>>>     1) Renaming Marvell's defined value to a more scoped name,
>>>>        in order to avoid any potential conflicts: PHY_BERLIN_MODE_SATA.
>>>>
>>>>     2) Adding the missing enum, which was going to be added anyway as part
>>>>        of [1].
>>>>
>>>> [1] https://lkml.kernel.org/r/20190108163124.6409-3-miquel.raynal@bootlin.com
>>>>
>>>> Fixes: 49e54187ae0b ("ata: libahci_platform: comply to PHY framework")  
>>>
>>> Linus, this is probably a better option in terms of what should go in to
>>> fix that commit.  
>>
>> I'm OK with this, but it does beg the question how the patch was
>> tested before submitting, if it didn't build.
>>
>> Is there functional breakage behind it? I currently lack online
>> hardware to test myself, unfortunately.
> 
> This is my mistake, I forgot to tell Jens about this dependency,
> I am very sorry about that. As reported by John, this patch depends on
> the addition of PHY_MODE_SATA in the PHY type enumeration. This series
> ([1]) has been delayed and I should have warned Jens about it. I'm fine
> with the above fix though.
> 
> Kishon, will you be able to base phy-next on top of this fix? It will
> be needed for the addition of the COMPHY driver.

Sure, I'll include this in my tree.

Thanks
Kishon
