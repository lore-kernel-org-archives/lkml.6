Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DBCCC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 05:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4D2C20883
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 05:59:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="aDR59JV1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4D2C20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753995AbeFUF7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 01:59:31 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:36542 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751211AbeFUF72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 01:59:28 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180621055925euoutp025d81e47b60dcd70e6227ed86f6e340ac~6F2mieZro2326923269euoutp026
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 05:59:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180621055925euoutp025d81e47b60dcd70e6227ed86f6e340ac~6F2mieZro2326923269euoutp026
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1529560765;
        bh=nuxUSL1Hzye9Ch0ys/qi6Y09yk3g6nzl3WTdJ4y/WpY=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=aDR59JV1o8BnTGkq4piV5SEfy90uIbiu3OU41zKj4qIDGHV1HcvFhnPpztqZohf/W
         SMwB7FKUCKfanN+q8b7wV8R8/45/3wi0sU1Fr6m1JiJIOnEQsj+/ppXz207dS1HrBP
         nGNlIFKNQsN0I1iCs0sT0I0PCA0DKDEHQF+Ty26I=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180621055923eucas1p15d6a14eaf572cd8e08dc6fbfb3640d60~6F2krP1Ed2975129751eucas1p1A;
        Thu, 21 Jun 2018 05:59:23 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id ED.6D.05700.BBE3B2B5; Thu, 21
        Jun 2018 06:59:23 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20180621055923eucas1p190f716475dcd44f72b24abfa4d948c82~6F2j2EPNk0295402954eucas1p1v;
        Thu, 21 Jun 2018 05:59:23 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20180621055922eusmtrp2228a2c377cd5c13455fbcb54e9f8c748~6F2jnLa6i1918719187eusmtrp2b;
        Thu, 21 Jun 2018 05:59:22 +0000 (GMT)
X-AuditID: cbfec7f2-1c1ff70000011644-20-5b2b3ebb8f28
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 90.B2.04178.ABE3B2B5; Thu, 21
        Jun 2018 06:59:22 +0100 (BST)
Received: from [106.120.43.17] (unknown [106.120.43.17]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20180621055922eusmtip12e4bcdbbdfabf9db97d6590d89168964~6F2jGXqeP2473624736eusmtip1q;
        Thu, 21 Jun 2018 05:59:22 +0000 (GMT)
Subject: Re: [PATCH 2/2] arm64: dts: exynos: Remove unneeded DSI and DECON
 address/size cells in Exynos5433
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-kernel@vger.kernel.org
From:   Andrzej Hajda <a.hajda@samsung.com>
Date:   Thu, 21 Jun 2018 07:59:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180620193407.gk5e5ecolo5bel3c@kozik-lap>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNKsWRmVeSWpSXmKPExsWy7djP87q77bSjDS6dU7F4v6yH0WL+kXOs
        Fv2PXzNbnD+/gd1i0+NrrBaXd81hs5hxfh+Txdojd9ktll6/yGTRuvcIu8XLjydYHLg91sxb
        w+ixaVUnm8fmJfUefVtWMXp83iQXwBrFZZOSmpNZllqkb5fAlbH1ZBtTwTShijWf17I3ML7i
        62Lk5JAQMJFof7GfrYuRi0NIYAWjxOfuSawgCSGBL4wSM07aQCQ+M0oseriUBabj5qIpjBCJ
        5YwSr+8fgnLeMkqsv/GBCaRKWCBX4lLfcaBRHBwiAhES21eyg9QwC7xkkviybRszSA2bgKbE
        38032UBqWARUJfY+AtssClS+ccInsBJeAUGJkzOfsICUcApYSBycmwgSZhaQl9j+dg4zhC0u
        cevJfCaQ8RIC59glGk6/ZoXoLZN4uBPiHAkBF4nuOQ2MELawxKvjW9ghbBmJ/zvnQ9XUSzTN
        vMIMMaiDUeLE4uVsEAlricPHL4L9wgx08/pd+hBhR4n1C2+BnS8hwCdx460gxD18EpO2TWeG
        CPNKdLQJQVQrStw/u5UZwhaXWHrhK9sERqVZSJ6cheSzWUg+m4WwdwEjyypG8dTS4tz01GLD
        vNRyveLE3OLSvHS95PzcTYzAJHX63/FPOxi/Xko6xCjAwajEw3sjTCtaiDWxrLgy9xCjBAez
        kgjvORPtaCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8cRp1UUIC6YklqdmpqQWpRTBZJg5OqQbG
        vdP3HXzcOanrfULtHLP1CSu4QpjYni/Vu9SdkHrlZKRTmW99xcnf9cp8s1Qk03+lHsuSZzYW
        at+ut+xlx7cNQQ/y2zQWyVVvf8opyRPz+9A/lndVu9ZvePLrEs/lHF7+VaxxX98fmPv63vK9
        irXufA0/3vzVsVfgmVnh9uHs43ePxTRnyl0QVmIpzkg01GIuKk4EABgCcQZOAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsVy+t/xu7q77LSjDd6e17V4v6yH0WL+kXOs
        Fv2PXzNbnD+/gd1i0+NrrBaXd81hs5hxfh+Txdojd9ktll6/yGTRuvcIu8XLjydYHLg91sxb
        w+ixaVUnm8fmJfUefVtWMXp83iQXwBqlZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwe
        a2VkqqRvZ5OSmpNZllqkb5egl7H1ZBtTwTShijWf17I3ML7i62Lk5JAQMJG4uWgKYxcjF4eQ
        wFJGiT1XpjNBJMQlds9/ywxhC0v8udbFBlH0mlFizrzvrCAJYYFciUt9x8FsEYEIidd37rGA
        FDELvGSSuDl1KRNEx1RmiW/3/4GNYhPQlPi7+SYbiM0rYCfRvOclUDcHB4uAqsTeR2CDRIEG
        Nc1bww5RIihxcuYTFpASTgELiYNzE0HCzALqEn/mXWKGsOUltr+dA2WLS9x6Mp9pAqPQLCTd
        s5C0zELSMgtJywJGllWMIqmlxbnpucWGesWJucWleel6yfm5mxiBsbnt2M/NOxgvbQw+xCjA
        wajEw3sjTCtaiDWxrLgy9xCjBAezkgjvORPtaCHelMTKqtSi/Pii0pzU4kOMpkCvTWSWEk3O
        B6aNvJJ4Q1NDcwtLQ3Njc2MzCyVx3vMGlVFCAumJJanZqakFqUUwfUwcnFINjHE3Z+9l4l6y
        fUvQ6u6e1L27togfl7y1ZfXhiGfWnbNcRAzFJ1d41m3jNRbJFtnDyfD3fhRnYVz2N0PLHR9+
        n5h87rfpMwb5mHMGM/YsPutky+Gu0DW1c47e1BS+kNP7uJ8EnYuvMPx+scnmZNq2i+utH7AL
        J3QsOXtUbEuh+syCB8nBvSHFm5RYijMSDbWYi4oTAVzfekXjAgAA
Message-Id: <20180621055923eucas1p190f716475dcd44f72b24abfa4d948c82~6F2j2EPNk0295402954eucas1p1v@eucas1p1.samsung.com>
X-CMS-MailID: 20180621055923eucas1p190f716475dcd44f72b24abfa4d948c82
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180618174316epcas1p397b66c8e4e8479fce8655941a4d4279f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180618174316epcas1p397b66c8e4e8479fce8655941a4d4279f
References: <20180618174216.24801-1-krzk@kernel.org>
        <CGME20180618174316epcas1p397b66c8e4e8479fce8655941a4d4279f@epcas1p3.samsung.com>
        <20180618174216.24801-2-krzk@kernel.org>
        <20180619072652eucas1p1943deb1b158eda52980448e41f83e5e9~5fwX6lI2o2633926339eucas1p1Q@eucas1p1.samsung.com>
        <CAJKOXPeCT3CkqqNowEZaeTw7goJd6=Nbd2S61QzTFW-nGr5AKg@mail.gmail.com>
        <20180620193407.gk5e5ecolo5bel3c@kozik-lap>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.06.2018 21:34, Krzysztof Kozlowski wrote:
> On Tue, Jun 19, 2018 at 09:59:04AM +0200, Krzysztof Kozlowski wrote:
>> On 19 June 2018 at 09:26, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>>> Hi Krzysztof,
>>>
>>> On 2018-06-18 19:42, Krzysztof Kozlowski wrote:
>>>> The decon, decon_tv and dsi nodes have only one child port so
>>>> address/size mappings are not necessary.  This fixes DTC warnings like:
>>>>
>>>>      Warning (graph_child_address): /soc/decon@13800000/ports:
>>>>          graph node has single child node 'port@0', #address-cells/#size-cells are not necessary
>>>>
>>>> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>>> Works fine with current Exynos DRM Decon/MIC/DSI drivers.
>>>
>>> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> Thanks for review and testing!
> I have second thoughs whether this patch is correct. AFAIU, the drivers
> get the remote endpoints by reg==0 (for example the
> of_graph_get_remote_node() in exynos_dsi_parse_dt()). If the port shall
> be ignored, then reg==-1 should be passed.

All this is about purity, DECON bindings says explicitly that there
should be a port with reg=0.
So your patch and DTC warnings are incorrect from bindings PoV.
On the other side graph bindings are too bloated ( so many lines to
describe one connection ) so I am happy if there are shrinking attempts :)
Functionally nothing changes, of graph helpers assume reg=0 if it is not
present in port/endpoint node.

And regarding real issues, DECON could have more ports, possible candidates:
- GSCALER0/1/2,
- GSD/DSD - interconnect between GSCALERs and DECONs,
- SMIES - image enhancer (not implemented),
- MIC0/1 - image enhancers,
- DSIM0/1 - DSI encoders,
- HDMI - HDMI encoder.

But since all these connections can be configured dynamically, and more
importantly are inside specific SoC I dont think they need of_graphs. In
fact I think current of graph is also not necessary, but this is
different story, removal is on my long TODO list :)

Regards
Andrzej

>
> Best regards,
> Krzysztof
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>

