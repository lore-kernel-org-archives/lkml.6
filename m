Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70018C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1827213A2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bpCoeWbM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1827213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbeJIXYO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 19:24:14 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:34124 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbeJIXYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 19:24:14 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181009160635euoutp02fc92bf516019f08055f4021693e19fc4~b-GIKoqU41669016690euoutp02h
        for <linux-kernel@vger.kernel.org>; Tue,  9 Oct 2018 16:06:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181009160635euoutp02fc92bf516019f08055f4021693e19fc4~b-GIKoqU41669016690euoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539101195;
        bh=qfxSvaIZKXk74aSKxv2FdHPR4jgn7gOPCI21EmzfN6Y=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=bpCoeWbMBCYa2czs9ZTo3lSH1WUUUaAwSN4x4dB+Ci/Wgde0eeWVjnXIC73iw6bkh
         oOe2S/tM1qDOdBD6H8dxTJLQcq9+1FY+1+Alkb8aKuaFI7SYb1gai6jKBVK4bp4ttR
         FVpbMOS0ThoV4kv+J2k2KmUi5qU8PcXxi/NECSDw=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181009160634eucas1p1f7a6ce1e2c7f1c7ad3ae0a1355b937bb~b-GHbGejO2660526605eucas1p1R;
        Tue,  9 Oct 2018 16:06:34 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id FE.E4.04441.A02DCBB5; Tue,  9
        Oct 2018 17:06:34 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181009160633eucas1p1a597c95256e64bf01de32366afdc59dd~b-GGjOUFN2705527055eucas1p1b;
        Tue,  9 Oct 2018 16:06:33 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181009160633eusmtrp1a0edac6d8c9fe477ba05125cfa0448de~b-GGSgyLO1335813358eusmtrp1-;
        Tue,  9 Oct 2018 16:06:33 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-5b-5bbcd20a203f
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id B7.B6.04284.902DCBB5; Tue,  9
        Oct 2018 17:06:33 +0100 (BST)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181009160633eusmtip186da2c5d513a4633537dda57c94e61d6~b-GF6nam01919619196eusmtip14;
        Tue,  9 Oct 2018 16:06:33 +0000 (GMT)
Subject: Re: [PATCH] Doc: lockdep: add information about performance impact
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com, mingo@redhat.com, will.deacon@arm.com,
        corbet@lwn.net
From:   Lukasz Luba <l.luba@partner.samsung.com>
Date:   Tue, 9 Oct 2018 18:06:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181009154359.GB5728@hirez.programming.kicks-ass.net>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPKsWRmVeSWpSXmKPExsWy7djPc7pcl/ZEGxw8pWKxccZ6VosnB9oZ
        LTY9vsZqcXnXHDaLSwcWMFkc7z3AZPHy4wkWB3aPNfPWMHpsXqHlsXlJvcfivsmsHu/3XWXz
        6NuyitHj8ya5APYoLpuU1JzMstQifbsErozt73qZC36zVrQenMvawHidpYuRk0NCwERi07uz
        QDYXh5DACkaJi3v3soMkhAS+MEpsOOIOkfjMKPH9+QdWmI6N754zQySWAxVNPc4C0fGWUeL+
        vswuRg4OYQFviQnPmUDCIgKaEivb7rOB1DMLzGaUmHBgEyNIDZuAnsSOVYUgNSwCKhK39p4A
        GyMqECFx5MFCRhCbV0BQ4uTMJ2BxTgEXia7n85lBbGYBcYlbT+YzQdjyEtvfzgG7R0JgH7vE
        zRPnoJrLJDZvnQP1povEkfv3mCFsYYlXx7ewQ9gyEqcn90DVFEuc7VjFBmHXSLSf3AFVYy1x
        +PhFVpCbmYGeWb9LHyLsKLHs9VsmkLCEAJ/EjbeCEOfwSUzaNp0ZIswr0dEmBFGtIbGl5wIT
        hC0msXzNNPYJjEqzkDw5C8ljs5A8Ngth7wJGllWM4qmlxbnpqcWGeanlesWJucWleel6yfm5
        mxiByej0v+OfdjB+vZR0iFGAg1GJh7fhwp5oIdbEsuLK3EOMEhzMSiK8ott3RQvxpiRWVqUW
        5ccXleakFh9ilOZgURLnXTZvY7SQQHpiSWp2ampBahFMlomDU6qBkSfT89JLhvKE8CqzGzbH
        jP+HvLy6aeviD+f2Pa9pXho79X1U1PaIRfrWS75vfXOB+c2eMDGl/2b8XcGCvGFNd3Xr7pXm
        r17NaHvIxyw9qzvGtD1Wo/fIVo11y5L+MMy6J53d97h9At9hq6aODyuS7rG/3H9Y2fL60WCN
        xfsuvI78O3/BrMOZW5VYijMSDbWYi4oTAULZGyFCAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRmVeSWpSXmKPExsVy+t/xu7qcl/ZEG7Q+VLbYOGM9q8WTA+2M
        FpseX2O1uLxrDpvFpQMLmCyO9x5gsnj58QSLA7vHmnlrGD02r9Dy2Lyk3mNx32RWj/f7rrJ5
        9G1ZxejxeZNcAHuUnk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5rJWRqZK+nU1Kak5m
        WWqRvl2CXsb2d73MBb9ZK1oPzmVtYLzO0sXIySEhYCKx8d1z5i5GLg4hgaWMEv87JjNDJMQk
        Ju3bzg5hC0v8udbFBlH0mlHi6O1+oG4ODmEBb4kJz5lAakQENCVWtt0Hq2EWmM0o0X5tLlRD
        C5PE+r8dzCANbAJ6EjtWFYI08Aq4SdzdtIURxGYRUJG4tfcE2EWiAhESq5e/YIWoEZQ4OfMJ
        WJxTwEWi6/l8sOOYBcwk5m1+CGWLS9x6Mp8JwpaX2P52DvMERqFZSNpnIWmZhaRlFpKWBYws
        qxhFUkuLc9Nziw31ihNzi0vz0vWS83M3MQKjcNuxn5t3MF7aGHyIUYCDUYmHt+HCnmgh1sSy
        4srcQ4wSHMxKIryi23dFC/GmJFZWpRblxxeV5qQWH2I0BXpuIrOUaHI+MEHklcQbmhqaW1ga
        mhubG5tZKInznjeojBISSE8sSc1OTS1ILYLpY+LglGpgTA9OuPL9rdvGh+/WGPkvjdlm0vgk
        +s29jJi7G7syV1kvmB/JGX1YO2frs/S6T7c+7OeRUFpY4fEleo6Cq/W89VbSp2V67TdvWn/W
        v63p1FHvOeWsS/8kcdYkro9Ilrwwr7an/9nr6s6ORNXPTsl9u1OStSx+7xZs6Kn6V/yvYkVA
        +q0jO/p2K7EUZyQaajEXFScCANfo5R7YAgAA
Message-Id: <20181009160633eucas1p1a597c95256e64bf01de32366afdc59dd~b-GGjOUFN2705527055eucas1p1b@eucas1p1.samsung.com>
X-CMS-MailID: 20181009160633eucas1p1a597c95256e64bf01de32366afdc59dd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181009153935eucas1p2dec146575ed5fefd4a0b2b6cb9bac056
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181009153935eucas1p2dec146575ed5fefd4a0b2b6cb9bac056
References: <CGME20181009153935eucas1p2dec146575ed5fefd4a0b2b6cb9bac056@eucas1p2.samsung.com>
        <20181009153935eucas1p2dec146575ed5fefd4a0b2b6cb9bac056~b_ujkjRd31303013030eucas1p2C@eucas1p2.samsung.com>
        <20181009154359.GB5728@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 10/09/2018 05:43 PM, Peter Zijlstra wrote:
> On Tue, Oct 09, 2018 at 05:39:27PM +0200, Lukasz Luba wrote:
>> This patch add some warning related to performance drop.
>> It should be mentioned that this is not for free
>> and the platfrom resources (cache, bus interconnect, etc.)
>> will be used more frequently.
> 
> To me this reads a bit like: water is wet.
> 
> Is this really needed?
> 
> 
Well, it would be good to know what is the performance drop
(10% or 20% or x3 times) when you are enabling different debug options.
I have spent some time analyzing these cache and bus strange behavior.
Now the developers would know that LOCKDEP might cause constant trashing 
of your cache in some use cases.

Regards,
Lukasz Luba
