Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75405C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 11:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC00D20858
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 11:49:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ucyggiGc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC00D20858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbeJJTLU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 15:11:20 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:50959 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbeJJTLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 15:11:20 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181010114931euoutp01f941ee22643830c8e434633727efadc9~cPO9rDTlu1453214532euoutp010
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 11:49:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181010114931euoutp01f941ee22643830c8e434633727efadc9~cPO9rDTlu1453214532euoutp010
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539172171;
        bh=HsqM0qUGvaeZ9T+gCAIiszI0JgSnwkudUxbvRVEKruY=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=ucyggiGc2xLupDfNATiHur8uC/LdluRtar5Mdb+2ibarnoVOMytBMh3/0UQMfDRY9
         FLiS7l8waOk4XSjt5IvIktIfjB84zog0AeD40aEN59R/dATFLdp4eVjDpBHWn2fIWb
         Hjq4GWjCVBC0lECm4ctnWXPdH3mF5o6RQPRCvpXA=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181010114930eucas1p2bc4a871fafbfd4d80f0fa8656c9e7c79~cPO8ut1y72074420744eucas1p22;
        Wed, 10 Oct 2018 11:49:30 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id AC.E7.04441.A47EDBB5; Wed, 10
        Oct 2018 12:49:30 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181010114929eucas1p26afb68895372532acd98a5fa641c6ab4~cPO77YHJM2672826728eucas1p2V;
        Wed, 10 Oct 2018 11:49:29 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181010114929eusmtrp2c21500bd0097058e56dec151830c71ec~cPO7qepWh1467214672eusmtrp2F;
        Wed, 10 Oct 2018 11:49:29 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-8e-5bbde74a6c93
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id C1.B6.04128.947EDBB5; Wed, 10
        Oct 2018 12:49:29 +0100 (BST)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181010114929eusmtip1c937b40e62e53c4296c2c5635a0e2282~cPO7SHfT03113931139eusmtip1V;
        Wed, 10 Oct 2018 11:49:29 +0000 (GMT)
Subject: Re: [PATCH] Doc: lockdep: add information about performance impact
To:     Robin Murphy <robin.murphy@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     corbet@lwn.net, b.zolnierkie@samsung.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        linux-arm-kernel@lists.infradead.org
From:   Lukasz Luba <l.luba@partner.samsung.com>
Date:   Wed, 10 Oct 2018 13:49:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <8a6bed3c-dac5-7031-eedd-2eb5bcc18478@arm.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHe3d2tuNo43VqPmgYjooS0gQ/HCgkoWCZhB8CpQW28qDinLbj
        JWXlErwwykylcppTvOa8NG+ppJlK0yIxRUmTCpuIyjBvRYqa80zy2+/5P9c/PBQhbSM9qBh1
        IqNRK1UygYjf/v7v8JnguW7F2Y0xV9r8vImkrb3ZiG7+OUHSY10lAnq0t4xHWx718uh3v6wk
        Pb88yL9AyetL65G8pdZH3lKZLq/ILSDlSz3jAnluax2SrzZ7hQqvi85HMqqYZEbjF3hTFD2k
        M5EJq/huVe2GQIemxXrkRAEOgLcNWzw9ElFSXItAP9Au5II1BCWdC47MKoK8jE3hfktmrYHP
        JWoQVBXsIC6wIRh4sLkbUJQLvgJ5czw7uuJQMK6n20sIXIygcXOOtOsC7AsddXfsM/n4BCxM
        ZJB2dsPhMPCjHNlZjJ1hqMjKt7MTPgf9ZS17TGB3mLIaeRwfg9e2EsI+H/CwEL491gm45mRY
        mjc7jr4IW5OzBMcusGBpdehHYaeTGwSYhU85dQKOtZA91OGo2V1s+bx3M4FPQ1OXHycHQfWi
        bc8iYAl8sTlz50ggv/0ZwcliyMmSctWnoPXhiGPREaipfyrMQzLDAZOGA8YMB4wZ/u8tQ/w6
        5M4ksXFRDOuvZlJ8WWUcm6SO8r0dH9eMdp/p47ZlpQOtj97qQ5hCssNi3cgbhZRUJrOpcX0I
        KELmKp7q71ZIxZHK1DRGEx+hSVIxbB/ypPgyd3F1qVkhxVHKRCaWYRIYzX6WRzl56FCYv1W1
        Mf5C5n8pIuRrStiicdZkrjikDrL1kt6zCu8BrZfW1OgSeHxF77lluTzo0zZeXpxVGNzwqshZ
        Mt0ZOOiuTftTOBOwHc4zTVxNi1Wf/N0ZYm4zrcVPVxpnvAJHdmxu929A4ktR/vdrSZErqp6g
        uSfL8bRkKvPDZNg90YqMz0Yr/X0IDav8B+f5n/hIAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJIsWRmVeSWpSXmKPExsVy+t/xu7qez/dGG6w/Jm2xccZ6VosnB9oZ
        LTY9vsZqcXnXHDaLSwcWMFkc7z3AZHHwwxNWi5cfT7A4cHismbeG0WPzCi2PzUvqPRb3TWb1
        eL/vKptH35ZVjB6fN8kFsEfp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb
        2aSk5mSWpRbp2yXoZZxsWM1a8FmgYumKX2wNjHd4uxg5OSQETCRaV8xi6WLk4hASWMoo8ebG
        O3aIhJjEpH3boWxhiT/XuthAbCGB14wSfxqCuhg5OIQFvCUmPGcCCYsI+Ekc2bqcCWQOs8Bs
        RolPd/4wQQxdxCxx7FEnE0gDm4CexI5VhSANvAJuEveWtrGC2CwCqhKvrjWB2aICERKrl79g
        hagRlDg58wkLiM0pYC1xeMFmMJtZwExi3uaHzBC2uMStJ/OZIGx5ie1v5zBPYBSahaR9FpKW
        WUhaZiFpWcDIsopRJLW0ODc9t9hIrzgxt7g0L10vOT93EyMwGrcd+7llB2PXu+BDjAIcjEo8
        vDcu7YkWYk0sK67MPcQowcGsJMJ76/DeaCHelMTKqtSi/Pii0pzU4kOMpkDPTWSWEk3OByaK
        vJJ4Q1NDcwtLQ3Njc2MzCyVx3vMGlVFCAumJJanZqakFqUUwfUwcnFINjCz7TfIm2f7JV/+3
        P+f08Zszyz7Yp1bc4VR/0jJjQYyR4oF252fHfpz47zurf5qaxGp1u3MVM19V/U41M7tU5T51
        lZAWQ7rinDdn59w5MvOV87yUwnSBf1+nRcxdu3wlT/euF/8n+VpufXS090jANTbmGT28X/jS
        Kt87ites4ph6eefKEtaHVbJKLMUZiYZazEXFiQBL8Jat3AIAAA==
Message-Id: <20181010114929eucas1p26afb68895372532acd98a5fa641c6ab4~cPO77YHJM2672826728eucas1p2V@eucas1p2.samsung.com>
X-CMS-MailID: 20181010114929eucas1p26afb68895372532acd98a5fa641c6ab4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181009153935eucas1p2dec146575ed5fefd4a0b2b6cb9bac056
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181009153935eucas1p2dec146575ed5fefd4a0b2b6cb9bac056
References: <CGME20181009153935eucas1p2dec146575ed5fefd4a0b2b6cb9bac056@eucas1p2.samsung.com>
        <20181009153935eucas1p2dec146575ed5fefd4a0b2b6cb9bac056~b_ujkjRd31303013030eucas1p2C@eucas1p2.samsung.com>
        <20181009154359.GB5728@hirez.programming.kicks-ass.net>
        <20181009160633eucas1p1a597c95256e64bf01de32366afdc59dd~b-GGjOUFN2705527055eucas1p1b@eucas1p1.samsung.com>
        <8a6bed3c-dac5-7031-eedd-2eb5bcc18478@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On 10/10/2018 12:31 PM, Robin Murphy wrote:
> On 09/10/18 17:06, Lukasz Luba wrote:
>> Hi Peter,
>>
>> On 10/09/2018 05:43 PM, Peter Zijlstra wrote:
>>> On Tue, Oct 09, 2018 at 05:39:27PM +0200, Lukasz Luba wrote:
>>>> This patch add some warning related to performance drop.
>>>> It should be mentioned that this is not for free
>>>> and the platfrom resources (cache, bus interconnect, etc.)
>>>> will be used more frequently.
>>>
>>> To me this reads a bit like: water is wet.
>>>
>>> Is this really needed?
>>>
>>>
>> Well, it would be good to know what is the performance drop
>> (10% or 20% or x3 times) when you are enabling different debug options.
>> I have spent some time analyzing these cache and bus strange behavior.
>> Now the developers would know that LOCKDEP might cause constant trashing
>> of your cache in some use cases.
> 
> Fair enough, but this is the wrong place for that. Anyone who's got as 
> far as reading how the internals of lockdep work can probably already 
> figure out that that brings a non-trivial overhead, whereas Joe 
> Developer wondering why his kernel is slow seems unlikely to happen 
> across this document by chance. And the people shipping devices with 
> PROVE_LOCKING enabled because it happened to mask some tricky bug, well, 
> they know what they did ;)
> 
> If you want to highlight to unwitting users that a tweaking a particular 
> config knob has a significant performance hit, at least put the warning 
> next to said knob, i.e. in the Kconfig help. For an example, DMA debug 
> comes to mind.
> 
> Robin.
> 
> 
Thank for the hint.
I agree, it would not be easy to find in this location.
I've found it during porting EAS where the
PROVE_LOCKING is used for arm and arm64
http://linux-arm.org/git?p=linux-power.git;a=blobdiff;f=arch/arm/configs/multi_v7_defconfig;h=e83c6e5bcfff97f8e9aacc4f2086ed506df63e59;hp=2721877d5a11f7fc41b8eb42d040ccde10eb0f3e;hb=737c15bf13632504e94509f0b9508122c664f3f2;hpb=288ae1d294d314b0aad5e0471605089da0336a77

I just wanted to give some rough performance impact measurements on
a real platform.

Regards,
Lukasz
