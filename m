Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92255C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 07:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 227F221924
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 07:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="GpA+hhFe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389284AbfBOHId (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 02:08:33 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:62931 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732147AbfBOHId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 02:08:33 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190215070829epoutp039e3e0f502b926950f05b2f7a82e77605~Dd_H3rWc21719617196epoutp034
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 07:08:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190215070829epoutp039e3e0f502b926950f05b2f7a82e77605~Dd_H3rWc21719617196epoutp034
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550214509;
        bh=9FUwyFin8jb+Ed76pKOqHnlMPCkK1rpq39UPBY/a8RY=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=GpA+hhFeosnBbqDswrNpjeESLXwhdb4nGH+8SoEWMo7ddW6pL3qFftH/E+t42MNyX
         HaPmNe4Yjbcwczp2ZzwtRdBzlRFcTDrN7yIlBEkp9ONEIalmotfSKz+n0CE2xUQnEC
         PRvg4AfKv6V/XIBTf0BZz5mwuxB0iBKuq3URl4so=
Received: from epsmges1p2.samsung.com (unknown [182.195.40.158]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190215070827epcas1p20afb74e76c339aff2d73e328be0e0502~Dd_GTE39W1870318703epcas1p2D;
        Fri, 15 Feb 2019 07:08:27 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        14.65.04173.865666C5; Fri, 15 Feb 2019 16:08:24 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190215070824epcas1p24974787cc1beda0e9a866febb1ca8027~Dd_DbLOU40963209632epcas1p2l;
        Fri, 15 Feb 2019 07:08:24 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190215070824epsmtrp1b88f96ab7437a7b52462a8bce7096fa5~Dd_DXOtO31677516775epsmtrp1M;
        Fri, 15 Feb 2019 07:08:24 +0000 (GMT)
X-AuditID: b6c32a36-5d9ff7000000104d-15-5c6665682c17
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        CC.07.03971.865666C5; Fri, 15 Feb 2019 16:08:24 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190215070824epsmtip1bac1f59e03d7247cfd47be55f6e3981b~Dd_DLwhQg1943819438epsmtip1D;
        Fri, 15 Feb 2019 07:08:24 +0000 (GMT)
Subject: Re: [PATCH 0/2] extcon: Intel Cherry Trail Whiskey Cove PMIC and
 external charger tweaks
To:     Yauhen Kharuzhy <jekhor@gmail.com>, linux-kernel@vger.kernel.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <19198931-9283-7572-f9d9-9cc95bf6ba43@samsung.com>
Date:   Fri, 15 Feb 2019 16:08:23 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190210203649.21691-1-jekhor@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDJsWRmVeSWpSXmKPExsWy7bCmnm5GalqMwfNv1ha9TdOZLN4cBxIH
        1y1ltbi8aw6bxe3GFWwOrB47Z91l95h3MtDj/b6rbB59W1YxenzeJBfAGpVtk5GamJJapJCa
        l5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQO0W0mhLDGnFCgUkFhcrKRv
        Z1OUX1qSqpCRX1xiq5RakJJTYFmgV5yYW1yal66XnJ9rZWhgYGQKVJiQnbFo5QO2gh+8Fe9P
        HGJsYDzN3cXIySEhYCKx5HQrWxcjF4eQwA5GiQX7/jNDOJ8YJc7evATlfGOUeD25nQ2mpfXy
        KlaIxF5GiX3Lz0NVvWeU+LVmNjtIlbBAssShn09YQGwRAReJ07Nng3UwC7QzSuyc1QeWYBPQ
        ktj/4gbYWH4BRYmrPx4zgti8AnYScy6fYAWxWQRUJfZ+esIMYosKREgc7n0HVSMocXImxAJO
        ATOJKU/+gMWZBcQlbj2ZzwRhy0s0b50Ndp2EwH02iVUzzrND/OAi0d74G+ofYYlXx7dAxaUk
        Xva3QdnVEitPHmGDaO5glNiy/wIrRMJYYv/SyUAbOIA2aEqs36UPsYxP4t3XHlaQsIQAr0RH
        mxBEtbLE5Qd3mSBsSYnF7Z1Qaz0kzl+cwDaBUXEWkndmIXlhFpIXZiEsW8DIsopRLLWgODc9
        tdiwwAg5vjcxglOmltkOxkXnfA4xCnAwKvHwrshIjRFiTSwrrsw9xCjBwawkwsuVmBYjxJuS
        WFmVWpQfX1Sak1p8iNEUGNoTmaVEk/OB6TyvJN7Q1MjY2NjCxNDM1NBQSZx3vYNzjJBAemJJ
        anZqakFqEUwfEwenVAMjn8+U1x8PC+44H6N1Sne6Uld18m+RmysTWA8f378p+JmsOl8Nr8iF
        FaFmj9UszhbIb+J+J2dqbHLp2UTl117nru5yvs3/umt/5F7G+Yuev2w90rt7exDj61+HRFf7
        /mFIEago0Lijwemp8mXtu9gtnM+8EusTHzpk8tifbLgc+iQqikEqU3qREktxRqKhFnNRcSIA
        gbpNYa8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjkeLIzCtJLcpLzFFi42LZdlhJTjcjNS3G4O8zAYvepulMFm+OA4mD
        65ayWlzeNYfN4nbjCjYHVo+ds+6ye8w7Gejxft9VNo++LasYPT5vkgtgjeKySUnNySxLLdK3
        S+DKWLTyAVvBD96K9ycOMTYwnubuYuTkkBAwkWi9vIq1i5GLQ0hgN6PE2VN32CASkhLTLh5l
        7mLkALKFJQ4fLoaoecsosXFmB1iNsECyxKGfT1hAbBEBF4nTs2eDDWIW6GSUOHd2NzNEB5Az
        6/MaVpAqNgEtif0vboB18wsoSlz98ZgRxOYVsJOYc/kEWA2LgKrE3k9PmEFsUYEIiY9P9zFB
        1AhKnJwJsY1TwExiypM/YL3MAuoSf+ZdYoawxSVuPZnPBGHLSzRvnc08gVF4FpL2WUhaZiFp
        mYWkZQEjyypGydSC4tz03GLDAsO81HK94sTc4tK8dL3k/NxNjODY0dLcwXh5SfwhRgEORiUe
        3hUZqTFCrIllxZW5hxglOJiVRHi5EtNihHhTEiurUovy44tKc1KLDzFKc7AoifM+zTsWKSSQ
        nliSmp2aWpBaBJNl4uCUamAUjWiT5Ny5ae+Z51OMix/Ii386vPJNmHal/MeLt/gqaqU/389m
        Lvo27U77jcADXao/eU7LVybkJfz7qnO8LYv5c3PUbtWN++qTXu3lXhh8z1zvmkLatQiP95qM
        n76FBszVCFeKCPCOXSRuWnu3keP/FPfb62rnrncTzP9+QydIVPPcCtffsx4osRRnJBpqMRcV
        JwIADjUr1pkCAAA=
X-CMS-MailID: 20190215070824epcas1p24974787cc1beda0e9a866febb1ca8027
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190210204024epcas3p36ea277b499e647b870d538c5680309bd
References: <CGME20190210204024epcas3p36ea277b499e647b870d538c5680309bd@epcas3p3.samsung.com>
        <20190210203649.21691-1-jekhor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yauhen,

You are missing me on cc list. I didn't know this patchset.
On next, please use the get_maintainer script in order to
send the correct list.

On 19. 2. 11. 오전 5:36, Yauhen Kharuzhy wrote:
> At implementation of charging support for Lenovo Yoga Book (Intel Cherry Trail
> based with Whiskey Cove PMIC), two pitfalls were found:
> 
> - for detection of charger type by PMIC, bit 6 in the CHGRCTRL1 register
>   should be set in 0 (and set to 1 for Host mode). Pick up its definition
>   and logic from from Intel code drop[1];
> 
> - "#CHARGE ENABLE" signal of external charger (bq25892) in Yoga Book is
>   connected to one of PMIC outputs controlled by CHGDISCTRL register.
>   Enable charging at driver initialization. Pick up this from Lenovo's code
>   drop[2,3].
> 
> Please keep in mind that I have no docs for Whiskey Cove PMIC, so this patches
> are based on some kind of reverse engineering and suppositions, correct me if
> this semantic is wrong for common case.
> 
> [1]. https://github.com/01org/ProductionKernelQuilts/uefi/cht-m1stable/patches/0001-power_supply-intel-pmic-ccsm-driver.patch
> [2]. https://github.com/jekhor/yogabook-linux-android-kernel/blob/b7aa015ab794b516da7b6cb76e5e2d427e3b8b0c/drivers/power/bq2589x_charger.c#L2257
> [3]. https://github.com/01org/ProductionKernelQuilts/uefi/cht-m1stable/patches/EM-Charger-Disable-battery-charging-in-S3-and-enable.patch
> 
> Yauhen Kharuzhy (2):
>   extcon-intel-cht-wc: Make charger detection co-existed with OTG host mode
>   extcon intel-cht-wc: Enable external charger
> 
>  drivers/extcon/extcon-intel-cht-wc.c | 71 +++++++++++++++++++++++++++-
>  1 file changed, 70 insertions(+), 1 deletion(-)
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
