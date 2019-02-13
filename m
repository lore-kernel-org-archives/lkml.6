Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4717BC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D3A0222B5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="DVs7Uvwr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391399AbfBMKff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 05:35:35 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:22969 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390178AbfBMKfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 05:35:34 -0500
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190213103530epoutp0320acdfbbc8e38f5766e551ae01a77ef0~C5gT9-Pdh0500305003epoutp03G;
        Wed, 13 Feb 2019 10:35:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190213103530epoutp0320acdfbbc8e38f5766e551ae01a77ef0~C5gT9-Pdh0500305003epoutp03G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550054130;
        bh=mM4OHkpgnbFM/GHHF5eKKRYuHG+McuF4Oe01rzxE/eQ=;
        h=Subject:To:Cc:From:Date:In-reply-to:References:From;
        b=DVs7UvwrRm8jVUt9b3taaMuVLhnqF5y49/TUYCpaPgFasimSid+uGQEHtTd0mx7cg
         AfA9LiALXmNycn4UDAAHIHFA9bnsubg/bu4BGOiV6TUZXsZLOsEq7dCQsv9V+7EYHw
         VJ8Uob/y135qR8nxuggsWfO5AaqXs1SRrw2ZVmQc=
Received: from epsmges2p1.samsung.com (unknown [182.195.42.69]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20190213103530epcas2p2c0dcd24280fe9f6edc48a0f43d6b263b~C5gTs49Rm0246702467epcas2p2Y;
        Wed, 13 Feb 2019 10:35:30 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        82.1F.04138.2F2F36C5; Wed, 13 Feb 2019 19:35:30 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20190213103529epcas2p2a8c84b4cd75027c429b91bce22aa9d73~C5gSdWEDL0246702467epcas2p2X;
        Wed, 13 Feb 2019 10:35:29 +0000 (GMT)
X-AuditID: b6c32a45-60bff7000000102a-26-5c63f2f2cf02
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        81.29.03689.1F2F36C5; Wed, 13 Feb 2019 19:35:29 +0900 (KST)
Received: from [106.116.147.40] by mmp1.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PMV0065C1F21D90@mmp1.samsung.com>; Wed, 13 Feb 2019 19:35:29 +0900 (KST)
Subject: Re: linux-next: build warning after merge of the sound-asoc tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-id: <d5c9f73e-8a60-c268-87b2-1ca98e86bfb1@samsung.com>
Date:   Wed, 13 Feb 2019 11:35:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-version: 1.0
In-reply-to: <20190213123129.2961c236@canb.auug.org.au>
Content-type: text/plain; charset="windows-1252"
Content-language: en-GB
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDIsWRmVeSWpSXmKPExsWy7bCmue6nT8kxBh+3K1pMffiEzeLblQ4m
        i8u75rBZHFzYxmixde9VdgdWj8YbN9g8ds66y+6xaVUnm8fnTXIBLFFcNimpOZllqUX6dglc
        GUfXFBQcYKv4uLCBrYFxEmsXIyeHhICJxJzvu5m6GLk4hAR2MEoc+bSRDcL5zijxbOVaJpiq
        2aumsUMkdjNKbN32jBHCuc8o8fL4HqBZHBzCAp4SDdcTQBpEBHwktu9/xQxSwywwm1Hi9NOf
        jCAJNgFDid6jfWA2r4CdxL4rZ8E2sAioSryatJAFxBYViJA43PsOqkZQ4sfkeywg8zkFzCU2
        HAMrZxYwkJgx5TCULS5x7P5NRghbXmLzmrdgeyUE9rBJdDRsZYf4wEXifPdpFghbWuLZqo2M
        EHa1xK7t3VANHYwSLRe2M0MkrCUOH7/ICjGVT6Lj8F92kCMkBHglOtqEIEo8JObM6oYGVxej
        xPbfFxknMMrMQnL3LCTHzkJy7Cwkxy5gZFnFKJZaUJybnlpsVGCoV5yYW1yal66XnJ+7iRGc
        BrRcdzDOOOdziFGAg1GJh3fF0aQYIdbEsuLK3EOMEhzMSiK8O18mxwjxpiRWVqUW5ccXleak
        Fh9ilOZgURLnfSQ9N1pIID2xJDU7NbUgtQgmy8TBKdXA6DH5K2PxgkM1/b7FtXM10j9LFVUc
        mWb7pvlhsaruj4sPYn89Uigz+bjt99PJv5isg3ll/8fc+n/nh53kkWDjXK1u7im8nst75vXN
        XvUzvbNpcfAOtmqp1iC5VJ4Z0tveX3JPaRa/fWHVniOzrNtfOS5bWPxWxHNqqXnkl8WusQVf
        XBWnf+MsU2Ipzkg01GIuKk4EABydpdf/AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFLMWRmVeSWpSXmKPExsVy+t9jAd2Pn5JjDH5v4LSY+vAJm8W3Kx1M
        Fpd3zWGzOLiwjdFi696r7A6sHo03brB57Jx1l91j06pONo/Pm+QCWKK4bFJSczLLUov07RK4
        Mo6uKSg4wFbxcWEDWwPjJNYuRk4OCQETidmrprF3MXJxCAnsZJRoWDeZGcJ5yCjxb9dkoCoO
        DmEBT4mG6wkgDSICPhLb978Cq2EWmM0osfTLLajuHkaJjy8PMYJUsQkYSvQe7QOzeQXsJPZd
        OcsEYrMIqEq8mrSQBcQWFYiQ+Ph0HxNEjaDEj8n3WECWcQqYS2w4xgRiMgvoSdy/qAVSwSwg
        LnHs/k1GCFteYvOat8wTGAVmIWmehdAxC0nHLCQdCxhZVjFKphYU56bnFhsVGOWllusVJ+YW
        l+al6yXn525iBIb4tsNa/TsYHy+JP8QowMGoxMO74mhSjBBrYllxZe4hRgkOZiUR3p0vk2OE
        eFMSK6tSi/Lji0pzUosPMUpzsCiJ8/LnH4sUEkhPLEnNTk0tSC2CyTJxcEo1MDblVprM8ndx
        dZbmb1w25Wz4/K6msxYcstnZZgmrfrt8jE7fFc5XdNI4aupj7jNJLhP/9c28M9PF6cfEr+k/
        Ltr+i9ZQUlzsdSzX5TnHx42HJDboPHVZtn/2o4UZcZ2vvV+/LXi96f/7X0u29gXE+f12tJv/
        wfqMf39pd1276Nq2ubvO3nR8d1SJpTgj0VCLuag4EQBAXsmtbQIAAA==
X-CMS-MailID: 20190213103529epcas2p2a8c84b4cd75027c429b91bce22aa9d73
CMS-TYPE: 102P
X-CMS-RootMailID: 20190213013212epcas5p436da6762dea86287ed3aea31ef2bb830
References: <CGME20190213013212epcas5p436da6762dea86287ed3aea31ef2bb830@epcas5p4.samsung.com>
        <20190213123129.2961c236@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On 2/13/19 02:31, Stephen Rothwell wrote:
> After merging the sound-asoc tree, today's linux-next build (arm
> multi_v7_defconfig) produced this warning:
> 
> sound/soc/samsung/i2s.c: In function 'samsung_i2s_remove':
> sound/soc/samsung/i2s.c:1469:27: warning: unused variable 'priv' [-Wunused-variable]
>   struct samsung_i2s_priv *priv = dev_get_drvdata(&pdev->dev);
                            ^~~~
> 
> Introduced by commit
> 
>   a404b72d2bdd ("ASoC: samsung: i2s: Convert to single component with multiple DAIs")

Thanks for the information. Due to my messed up rebase the line
quoted above ended up in the above mentioned commit instead of 
in the next on in the series, which has not yet been applied:

"ASoC: samsung: i2s: Restore support for the secondary PCM"

-- 
Regards
Sylwester
