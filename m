Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78BE4C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 05:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EA9C21872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 05:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="X+EkbOMo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbfAXFx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 00:53:29 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:35718 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbfAXFx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 00:53:28 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190124055324epoutp0235d8b6407347eed4ebbd24f0be151c8c~8swSuHsya0556605566epoutp02Q
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 05:53:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190124055324epoutp0235d8b6407347eed4ebbd24f0be151c8c~8swSuHsya0556605566epoutp02Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1548309204;
        bh=f59kY+0fGmAWVVQQHo2ewJS3XTCZ4zKdROZwXBjwwOw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=X+EkbOMou/vsdj9k0axxTiu4Nxr+/4GdfO4kuS/A9RcQy9HQbPfp+LbLHG2b1zKJW
         LIpcan7LIxpms4LCO7pnd3L6K0PN+AIKbnb+YtWuqS1knf8pQChfC06qtj5R2br+a9
         0cAiHeIxKtz+WwpKakqlsQYqEB0JQFP9zur8RN2E=
Received: from epsmges1p3.samsung.com (unknown [182.195.40.155]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190124055316epcas1p1e7cf78c33e85562ea6e8c9045a1b462e~8swLJm5jo1022810228epcas1p14;
        Thu, 24 Jan 2019 05:53:16 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        44.BB.04069.7C2594C5; Thu, 24 Jan 2019 14:53:11 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20190124055310epcas1p4fd68081d1dc863a53d2be6017b0c2d2a~8swFqOYXk1469414694epcas1p4J;
        Thu, 24 Jan 2019 05:53:10 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190124055310epsmtrp16818b84be6feda0aa5b57425926b48bf~8swFpehNw2913129131epsmtrp15;
        Thu, 24 Jan 2019 05:53:10 +0000 (GMT)
X-AuditID: b6c32a37-989ff70000000fe5-2b-5c4952c73c00
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        8E.11.03601.6C2594C5; Thu, 24 Jan 2019 14:53:10 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190124055310epsmtip28e5688612c352ecb5708b6aca93d3653~8swFc8y8k1958219582epsmtip2Z;
        Thu, 24 Jan 2019 05:53:10 +0000 (GMT)
Subject: Re: linux-next: build warning after merge of the extcon tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <fc9bc070-dfc1-8708-8c8d-56e6838b6c7a@samsung.com>
Date:   Thu, 24 Jan 2019 14:53:09 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190124144713.4330ec34@canb.auug.org.au>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupik+LIzCtJLcpLzFFi42LZdlhTT/d4kGeMQVsXh8XlXXPYLA4ubGO0
        2Lr3KrvFy/3TWR1YPBpv3GDz2DnrLrvH501yAcxR2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7x
        pmYGhrqGlhbmSgp5ibmptkouPgG6bpk5QNuUFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnFJbZK
        qQUpOQWWBXrFibnFpXnpesn5uVaGBgZGpkCFCdkZ7T3T2QvmslS8+XeOsYFxHXMXIyeHhICJ
        xOxpSxm7GLk4hAR2MEpMurqNCcL5xCgx9etCsCohgW+MEpN/SsJ0LPq6A6poL6PEk31roJz3
        jBIndr4C6xAWcJW4030fyObgEBHQljjwWwCkhllgBaPE1a/7mEBq2AS0JPa/uMEGYvMLKEpc
        /fGYEcTmFbCTeNe1lQXEZhFQlTh2dRk7iC0qECHRcX81G0SNoMTJmU9YQOZzCphLrL6jABJm
        FhCXuPVkPhOELS/RvHU21Jtn2CS2PBGEsF0ktk17xARhC0u8Or6FHcKWknjZ3wZlV0usPHmE
        DeRmCYEORokt+y+wQiSMJfYvncwEspdZQFNi/S59iF18Eu++9rCChCUEeCU62oQgqpUlLj+4
        C7VKUmJxeycbhO0hsXrOK9YJjIqzkDwzC8kHs5B8MAth2QJGllWMYqkFxbnpqcWGBcbIcb2J
        EZwOtcx3MG4453OIUYCDUYmHl6PQI0aINbGsuDL3EKMEB7OSCK/rRbcYId6UxMqq1KL8+KLS
        nNTiQ4ymwLCeyCwlmpwPTNV5JfGGpkbGxsYWJoZmpoaGSuK86x2cY4QE0hNLUrNTUwtSi2D6
        mDg4pRoYme1vXFzc/+BJovql6SVTnkWqzH8+51ZvtIW9+yvPhKf+ymKTf6ioSDPtclGZGuvx
        o+vStwotoUMb5XNa5lm/jHkZNXu2y7oop4/dU59WPz0Wq2rjzmW28L7p+3WaMsXfd345t/a2
        2cyz1m5+1tt4rd3/Xs238HVz3XTd/H3ivbsXWiU65rPUKbEUZyQaajEXFScCALEn+vadAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMLMWRmVeSWpSXmKPExsWy7bCSvO6xIM8Ygwsr5Swu75rDZnFwYRuj
        xda9V9ktXu6fzurA4tF44wabx85Zd9k9Pm+SC2CO4rJJSc3JLEst0rdL4Mpo75nOXjCXpeLN
        v3OMDYzrmLsYOTkkBEwkFn3dwQRiCwnsZpT4e7cEIi4pMe3iUaAaDiBbWOLw4eIuRi6gkreM
        Ekd6T7KB1AgLuErc6b4PViMioC1x4LcASA2zwApGid4zJ9ghGroYJVYte8QC0sAmoCWx/8UN
        sGZ+AUWJqz8eM4LYvAJ2Eu+6toLVsAioShy7uowdxBYViJA4+3IdVI2gxMmZT1hAlnEKmEus
        vqMAYjILqEusnycEUsEsIC5x68l8JghbXqJ562zmCYzCs5A0z0LomIWkYxaSjgWMLKsYJVML
        inPTc4sNC4zyUsv1ihNzi0vz0vWS83M3MYKjQktrB+OJE/GHGAU4GJV4eDkKPWKEWBPLiitz
        DzFKcDArifC6XnSLEeJNSaysSi3Kjy8qzUktPsQozcGiJM4rn38sUkggPbEkNTs1tSC1CCbL
        xMEp1cC42rJLL8VO7OHq3o6LrbH5C/KW5bEW3F3DmHPnVL7jisb1/wsuW/fpFTH3Nzf1ux/U
        ufNG0tPP/KPyPc3HHAsUUouDpvRxOYrp3RL6+junIaY9Q3/9zx0fi50vrrq4Rbo0TX7aiW9v
        y2Ns+GQ2NX5cFJI0zSThQaHE4qeL0zvN1LVzWNfPdVNiKc5INNRiLipOBADvk5qzhgIAAA==
X-CMS-MailID: 20190124055310epcas1p4fd68081d1dc863a53d2be6017b0c2d2a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190124034729epcas5p4a890f486e03e78432e58a773d7d20633
References: <CGME20190124034729epcas5p4a890f486e03e78432e58a773d7d20633@epcas5p4.samsung.com>
        <20190124144713.4330ec34@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

Thanks for the test and report. I'll fix it.

On 19. 1. 24. 오후 12:47, Stephen Rothwell wrote:
> Hi Chanwoo,
> 
> After merging the extcon tree, today's linux-next build (x86_64
> allmodconfig) produced this warning:
> 
> WARNING: modpost: missing MODULE_LICENSE() in drivers/extcon/extcon-ptn5150.o
> see include/linux/module.h for more information
> 
> Introduced by commit
> 
>   58963276749e ("extcon: Add support for ptn5150 extcon driver")
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
