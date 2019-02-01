Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BBECC282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D101218AF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:19:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="sLoibvHO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730023AbfBAOTm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 09:19:42 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:24746 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbfBAOTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 09:19:41 -0500
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190201141938epoutp04543245b3980c8ec99cd23bf18c113d1a~-Q0kcntSt1988219882epoutp04X;
        Fri,  1 Feb 2019 14:19:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190201141938epoutp04543245b3980c8ec99cd23bf18c113d1a~-Q0kcntSt1988219882epoutp04X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549030778;
        bh=MrYW9SGeXPqzNlO8fzNlXVd4D3gzWxke3OV7sQG8G1Y=;
        h=Subject:To:Cc:From:Date:In-reply-to:References:From;
        b=sLoibvHOJ925aDj95BE+6RVOKmyYQr4Ffu1G/RJ//CrV6I3j5aG2xcrsjRNJnfVKL
         P3rkhZ3edsfxhxpId4f5Zr3k8NbWNw1joJc1LL4/4ZbAOiQKxA8jcc4/r+SJdlsDN6
         gpYHpUd6pexbKpXWukfhATyfmJDmce5SQXPF1uec=
Received: from epsmges2p1.samsung.com (unknown [182.195.42.69]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20190201141937epcas2p2c6953795561ef4161e7953b079ff9d36~-Q0kQNmsI2593325933epcas2p29;
        Fri,  1 Feb 2019 14:19:37 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        5D.D7.04138.975545C5; Fri,  1 Feb 2019 23:19:37 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20190201141937epcas2p110a50912ef48b17f7bd27350fabcc608~-Q0j42TDm2547825478epcas2p1l;
        Fri,  1 Feb 2019 14:19:37 +0000 (GMT)
X-AuditID: b6c32a45-5f3ff7000000102a-7b-5c545579aa09
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C8.D3.03689.975545C5; Fri,  1 Feb 2019 23:19:37 +0900 (KST)
Received: from [106.116.147.40] by mmp1.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PM900M283SJVW20@mmp1.samsung.com>; Fri, 01 Feb 2019 23:19:37 +0900 (KST)
Subject: Re: [PATCH v3 3/8] clk: samsung: add BPLL rate table for Exynos
 5422 SoC
To:     Lukasz Luba <l.luba@partner.samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        myungjoo.ham@samsung.com,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-id: <08850f80-0cc1-8e0d-6a8a-286a750d3a8c@samsung.com>
Date:   Fri, 01 Feb 2019 15:19:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-version: 1.0
In-reply-to: <0ca15b4c-ddaa-1be5-35be-e76b008b28a8@partner.samsung.com>
Content-type: text/plain; charset="utf-8"
Content-language: en-GB
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNKsWRmVeSWpSXmKPExsWy7bCmuW5laEiMwdErhhYbZ6xntbj+5Tmr
        xfwj51gt+h+/ZrY4f34Du8XZpjfsFrcaZCw2Pb7GavGx5x6rxeVdc9gsPvceYbSYcX4fk8Xa
        I3fZLS6ecrW43biCzeLftY0sDgIe72+0sntsWtXJ5rF5Sb3HwXd7mDz6tqxi9Pi8SS6ALYrL
        JiU1J7MstUjfLoErY8GXioJ9LBXXbqxnbmA8ydzFyMkhIWAisfLoBvYuRi4OIYEdjBJ/Lm5i
        g3C+M0pcmrGVFabq3qznrBCJ3YwSa35NZIRw7jNKbPjXBDZLWCBYYu6xm2wgtohAiMSfNdfA
        bGaBBcwSp77rg9hsAoYSvUf7GEFsXgE7iYbj28B6WQRUJZY0fmAHsUUFIiQO976DqhGU+DH5
        HguIzSngLrHk+0GomZoSL75MYoGwxSWO3b/JCGHLS2xe85YZ5DgJgensElu//WaHeMFF4mf/
        BUYIW1ri2aqNUHa1xK7t3VANHYwSLRe2Q0PGWuLw8YusEFP5JDoO/wUaxAEU55XoaBOCKPGQ
        mDR3EjS8LjJJbH61nmkCo8wsJIfPQnLsLCTHzkJy7AJGllWMYqkFxbnpqcVGBYZ6xYm5xaV5
        6XrJ+bmbGMFJSMt1B+OMcz6HGAU4GJV4eDf8CooRYk0sK67MPcQowcGsJMK7wiUkRog3JbGy
        KrUoP76oNCe1+BCjNAeLkjjvI+m50UIC6YklqdmpqQWpRTBZJg5OqQbGy4scH3w9Gi2UyXRu
        vVfrisazr28WzMm+t2ar4JnwBgv7TR6f6xe7Lt1Uaf56/+2VVdFNMSrTwji3fpbSTV5YLWTV
        8HmOMkds3d9olV2WP7cqLtovPO3xYf8MMc2XMx8nsCw57ctUN+nb9iUlv3UZ6+KOHv9wUNrq
        4rmIefM6K31434dsimfpVWIpzkg01GIuKk4EACX7Ha8+AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsVy+t9jAd3K0JAYg48d0hYbZ6xntbj+5Tmr
        xfwj51gt+h+/ZrY4f34Du8XZpjfsFrcaZCw2Pb7GavGx5x6rxeVdc9gsPvceYbSYcX4fk8Xa
        I3fZLS6ecrW43biCzeLftY0sDgIe72+0sntsWtXJ5rF5Sb3HwXd7mDz6tqxi9Pi8SS6ALYrL
        JiU1J7MstUjfLoErY8GXioJ9LBXXbqxnbmA8ydzFyMkhIWAicW/Wc9YuRi4OIYGdjBId0xYx
        QzgPGSVeHVnKAlIlLBAs8aX1HSOILSIQInH++DUmkCJmgXnMEhNO/oXquMgk8fhnJ1gHm4Ch
        RO/RPrAOXgE7iYbj28D2sQioSixp/MAOYosKREh8fLqPCaJGUOLH5HtgvZwC7hJLvh9k62Lk
        ANqgLjFlSi5ImFlAXOLY/ZuMELa8xOY1b5knMArMQtI9C6FjFpKOWUg6FjCyrGKUTC0ozk3P
        LTYqMMpLLdcrTswtLs1L10vOz93ECIyxbYe1+ncwPl4Sf4hRgINRiYd3w6+gGCHWxLLiytxD
        jBIczEoivCtcQmKEeFMSK6tSi/Lji0pzUosPMUpzsCiJ8/LnH4sUEkhPLEnNTk0tSC2CyTJx
        cEo1MB75rdvCuGkv/+4qndeOTgJbLi3/MJ1ZpPHWvp72O/tXWjr8cd2i/+RlwkFN+bjJnN1K
        P7g2tDIdmX9nsm5DjPaX1RGXr/8+s+z3tIv2Nqr2i3prOFLsJO/+2/Xa75CGhc+s6wv5/pg4
        Jfqp3knPebBqmmht2t3W8FBZx60b7dbFPHzJ2HTfpkuJpTgj0VCLuag4EQDZOOXErQIAAA==
X-CMS-MailID: 20190201141937epcas2p110a50912ef48b17f7bd27350fabcc608
CMS-TYPE: 102P
X-CMS-RootMailID: 20190131085007eucas1p2f16107042b8ce5638811840618bcf017
References: <1548924594-19084-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190131085007eucas1p2f16107042b8ce5638811840618bcf017@eucas1p2.samsung.com>
        <1548924594-19084-4-git-send-email-l.luba@partner.samsung.com>
        <d5b8d165-564e-b776-77de-31a069118067@samsung.com>
        <0ca15b4c-ddaa-1be5-35be-e76b008b28a8@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/1/19 14:56, Lukasz Luba wrote:
>> Exynos5422 used the same PLL table for apll, kpll, bpll and so on.
>> You don't need to make the separate pll table. Just add new entries
>> to exynos5420_pll2550x_24mhz_tbl table.
> OK, I will extend the exynos5420_pll2550x_24mhz_tbl table.
> 
> In v4 patch set, it will be fixed.

I would prefer to keep the rate table separate for BPLL, until correctness
of new rates introduced in the patch and their applicability to the other PLLs
is confirmed by the hardware team and verified in tests.


-- 
Regards,
Sylwester
