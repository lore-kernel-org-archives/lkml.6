Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1EA2C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 11:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6356F2077C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 11:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="fEYQJrcS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6356F2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbeJKShO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 14:37:14 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:34322 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728157AbeJKShO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 14:37:14 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181011111027euoutp012a436255ee5b808b690ccead1edf449e~ciWJPwZ7C0673806738euoutp012
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 11:10:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181011111027euoutp012a436255ee5b808b690ccead1edf449e~ciWJPwZ7C0673806738euoutp012
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539256228;
        bh=XFdmI5YLGi7mP3s0wDYIXucFaVHe4KRgXUiWFSTEDz0=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=fEYQJrcSfPiotk6WGsDPPSFgtmoL27MterFjgbGtC9gjcbw6K4/sKQ2bBOQRUg+Cf
         s5IMqnSXqyCq44boWVSuHpdP2iHaMXEU8Nf5HTJyU59umd9efdXpBASPwGhIYkmVds
         T/7ZKaPa1nQXOT/1ionlcN3SZchVOIZLnzhSm00w=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181011111026eucas1p100ab213d45c44b50046ed439687e95dc~ciWIFBvhW1042910429eucas1p1g;
        Thu, 11 Oct 2018 11:10:26 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id CB.29.04441.2AF2FBB5; Thu, 11
        Oct 2018 12:10:26 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181011111025eucas1p2125db99d798a60a8e38da97c2a1c7436~ciWHHd0YW0102601026eucas1p2b;
        Thu, 11 Oct 2018 11:10:25 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181011111025eusmtrp1ad505d87ad99c63c5eee3ecb666a103f~ciWG11UC-1406414064eusmtrp1K;
        Thu, 11 Oct 2018 11:10:25 +0000 (GMT)
X-AuditID: cbfec7f2-a1ae89c000001159-93-5bbf2fa26512
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id D1.33.04284.1AF2FBB5; Thu, 11
        Oct 2018 12:10:25 +0100 (BST)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181011111024eusmtip13404cb3d33fdb22e243b7a8bdacb719f~ciWGJPXFo0144101441eusmtip1R;
        Thu, 11 Oct 2018 11:10:24 +0000 (GMT)
Subject: Re: [RFC PATCH 0/7] Introduce thermal pressure
To:     Thara Gopinath <thara.gopinath@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, rui.zhang@intel.com,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        amit.kachhap@gmail.com, viresh.kumar@linaro.org,
        javi.merino@kernel.org, edubezval@gmail.com,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        quentin.perret@arm.com, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
From:   Lukasz Luba <l.luba@partner.samsung.com>
Date:   Thu, 11 Oct 2018 13:10:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <5BBE3751.7000908@linaro.org>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTYRTHeXZfdl1N75bpIbVgEaShpgQ9pERBwc2iok/poFp50cpN3XWW
        0QcrquUboU3dymUKaUMbLqlpsnKao+xFK63EoGRhmhqlBkpoXm+R337/c/7n7eFhCPUEtYo5
        bsjhjQZdhoZWkPe7Zl5G18Q+0m4cLgzDsxNWOW6qdFLYPhmBb77tp/CFWieNLe3FMjznqKLx
        m9YbNJ4s7kT49eNqGfYVP5bhLy4niaumLAT2fy6hcY/FSmBz5y8CN01z21Rcg70BcS22j3Lu
        Xn0UV9s2IuNcjis0N9jfRnOPqhrk3HdPH82VNDsQN+lavV+RokhM5TOO5/LG2K1HFOmlllmU
        5Qo6PV8zQ+aj5uUFiGGA3QSD3/MKkIJRs/UIZrxdMklMIagYebsgAhbEJII2b4rIYsHlnh4k
        meoQ5Pt9tCTGETT2zVGiawW7GZ59rEQiB7N7YPhhmVw0EWwJARWXuuXibJqNAbcjW0SSXQfm
        8zmifSV7EDo/3VosVbIqeGr1kyIHsFEwP9+9yAQbCgP+mzKJ18CD8RuE2B7YKgZ+l7Qvtley
        uTA9kCktvQPyPVZK4hUw6muWSxwO3WVFpMQCvDA7aInPwuWn7r+eBOjw9VJiS4KNBGdrrBTe
        Dt+s1ynpEQPh/bhK2iYQSu9XEFJYCeZLasm9HpqLemQSh0BdQ7n8KtLYltxoW3KXbcldtv9z
        qxHpQKG8SdCn8UKcgT8VI+j0gsmQFnMsU+9CC7+we873042mXx/1IpZBmuXK/REerZrS5Qp5
        ei8ChtAEK2MrF0LKVF3eGd6YedhoyuAFLwpjSE2o8ra9Satm03Q5/Emez+KN/7IyJmBVPgr8
        1PV8pI8bPvE80WsTgrODppKfmLSR4YqR/mrd0dZQ99pzMeSQo1CV4N6QRB1I9pVzYxbP170f
        OutVy5xjg2PE3qECQ0hSwb6O5FeNlD1ozaF30fFhKXbT3V2RmRfjr7Xs1o8mmOd6f1Tw5jzl
        Tv9Yv3HjnWKtJUCl3vLrmUdDCum6uCjCKOj+AFv4uISBAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTURzGObvb3VU2vZuaR+lFRkII3Xl92zFM6ovcD0KhUKGILr040Tnb
        3UQLQRLLFCU1Q4dObYRrDsRpvmVqQzI1yNQsyhGC2ouoH1aSL7k2R+C3H8/z/OAc+BOYtFIQ
        SuQV6lhtobJAhvvyZw+nHOc75ePpkTsVAWhvq0WIept7BMjoPIXaF5cEqMLUg6OmV7U8dGhp
        w9HCSCuOnLWTAM1PdPDQVO0ED63Zevio7VcThlZX6nA019SCoarJHQz1/mYuSRir0QqYYYND
        yPSZIxjT6A8eY7M8wJnlpVGcGW+zCpntsQ84U9dvAYzTdvqqbxqVoNXodWyYSsPpLsrSaRRF
        0fGIioqJp+hoRcaFqFiZPDEhhy3IK2a18sQsStXQtAeKbP4lrie7/HLQL6oGPgQkY+D9uTlQ
        DXwJKfkUwOl9J99bnIANY4NCLwfAg6Vq3DvaAHDftXFUBJAKOONoBh4OJJPhtxeNQs8II+sw
        uP72vcBrPOPBrz873A1B4CQFhyy3PIKYTIJ/TY8FnphPhsOquzpPHETegN1d3wXeiQROt6we
        PciHjIAu1+wRY2QcNPatYF4Ohp9X23lePgMHN1uxh0BqOKYbjimGY4rhmNIB+BYQyOo5da6a
        oylOqeb0hblUtkZtA+4TGHi92zcE5ntT7YAkgEwk/hM6li4VKIu5UrUdQAKTBYrlze5InKMs
        vc1qNZlafQHL2UGs+2/1WGhQtsZ9UIW6TDqWVqB4WhGtiI5DsmDxu8jSNCmZq9Sx+SxbxGr/
        ezzCJ7QcxEjbs0Tlk2XWbbZRNGKv+fJSgt+5nhG2mMMkPIddNmygz+9K/Zok5MDUvMnKY/W5
        N5P8rvsnX0sarhR11YyPbj4KASo+rRpdvpyoM2ZQW42HPuvmLIvpU+Yb9b38kyHb63UpM2dT
        OwfNZbhfyscSc4ThXFTQhCJwIdzRTcj4nEpJR2BaTvkPFtwS4xgDAAA=
Message-Id: <20181011111025eucas1p2125db99d798a60a8e38da97c2a1c7436~ciWHHd0YW0102601026eucas1p2b@eucas1p2.samsung.com>
X-CMS-MailID: 20181011111025eucas1p2125db99d798a60a8e38da97c2a1c7436
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181009162509epcas1p4fdd2e23039caa24586a4a52c6d2e7336
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181009162509epcas1p4fdd2e23039caa24586a4a52c6d2e7336
References: <CGME20181009162509epcas1p4fdd2e23039caa24586a4a52c6d2e7336@epcas1p4.samsung.com>
        <1539102302-9057-1-git-send-email-thara.gopinath@linaro.org>
        <20181010153553eucas1p1b8f74f4aa45751ef029805fd118affc1~cSUmU58-F2963929639eucas1p1L@eucas1p1.samsung.com>
        <5BBE3751.7000908@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/10/2018 07:30 PM, Thara Gopinath wrote:
> Hello Lukasz,
> 
> On 10/10/2018 11:35 AM, Lukasz Luba wrote:
>> Hi Thara,
>>
>> I have run it on Exynos5433 mainline.
>> When it is enabled with step_wise thermal governor,
>> some of my tests are showing ~30-50% regression (i.e. hackbench),
>> dhrystone ~10%.
> 
> That is interesting. If I understand correctly, dhrystone spawns 16
> threads or so and floods the system. In "theory", such a test should not
> see any performance improvement and degradation. What is the thermal
> activity like in your system? I will try running one of these tests on
> hikey960.
I use this dhrystone implementation:
https://github.com/Keith-S-Thompson/dhrystone/blob/master/v2.2/dry.c
It does not span new threads/processes and I pinned it to a single cpu.

My thermal setup is probably different than yours.
You have (on hikey960) probably 1 sensor for whole SoC and one thermal
zone (if it is this mainline file:
arch/arm64/boot/dts/hisilicon/hi3660.dtsi).
This thermal zone has two cooling devices - two clusters with dvfs.
Your temperature signal read out from that sensor is probably much
smoother. When you have sensor inside cluster, the rising factor
can be even 20deg/s (for big cores).
In my case, there are 4 thermal zones, each cluster has it's private
sensor and thermal zone. There is no 'SoC sensor' or 'PCB sensor',
which is recommended for IPA.
>>
>> Could you tell me which thermal governor was used in your case?
>> Please also share the name of that benchmark, i will give it a try.
>> Is it single threaded compute-intensive?
> 
> Step-wise governor.
> I use aobench which is part of phoronix-test-suite.
> 
> Regards
> Thara
> 
I have built this aobench and run it pinned to single big cpu:
time taskset -c 4 ./aobench
The results:
3min-5:30min [mainline]
5:15min-5:50min [+patchset]

The idea is definitely worth to investigate further.

Regards,
Lukasz



