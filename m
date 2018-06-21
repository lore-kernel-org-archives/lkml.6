Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4032C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 07:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BA5C208A1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 07:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sup4Dmz+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BA5C208A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754326AbeFUHVL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 03:21:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:51154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753960AbeFUHVJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 03:21:09 -0400
Received: from mail-wm0-f53.google.com (mail-wm0-f53.google.com [74.125.82.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7726E208A4;
        Thu, 21 Jun 2018 07:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529565668;
        bh=22rHz4xJb4286BJZrlnFXA/tzS4CAeI+NPaH04eGwvY=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=sup4Dmz+l/WEVku6eGAuWwnSLhL8HP+FYxmcCbz7Bp0MbXtcfS+64Cb5UfiCjfREK
         uHtsoZgNYn+WZewu/lY5m3QHdHPe8C5XIbs71/jt00HSzTlCT++/vn1NMl5Ev0vhO/
         yMnkko37ErafB1v4BfqOe3lw5pUO0Q8FgxT0tBJM=
Received: by mail-wm0-f53.google.com with SMTP id 69-v6so3878250wmf.3;
        Thu, 21 Jun 2018 00:21:08 -0700 (PDT)
X-Gm-Message-State: APt69E2w7pI0S0a6zwSr/xrg/PxMh5PfTYomRrWb1ULmbf5Jkrnytb16
        dU722kmQP+5ZvGsleZ5elotwzIsbwxqZiJYXwYs=
X-Google-Smtp-Source: ADUXVKJnhdq09v8enlYWu773sRS87mzyeCOiPD53Az0xW1qHE0eMfRN7h/hnexImgR54SKxHZFoGKDGnhB9ljzm6K0A=
X-Received: by 2002:a1c:1815:: with SMTP id 21-v6mr4187334wmy.72.1529565666942;
 Thu, 21 Jun 2018 00:21:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9166:0:0:0:0:0 with HTTP; Thu, 21 Jun 2018 00:21:06
 -0700 (PDT)
In-Reply-To: <20180621055923eucas1p190f716475dcd44f72b24abfa4d948c82~6F2j2EPNk0295402954eucas1p1v@eucas1p1.samsung.com>
References: <20180618174216.24801-1-krzk@kernel.org> <CGME20180618174316epcas1p397b66c8e4e8479fce8655941a4d4279f@epcas1p3.samsung.com>
 <20180618174216.24801-2-krzk@kernel.org> <20180619072652eucas1p1943deb1b158eda52980448e41f83e5e9~5fwX6lI2o2633926339eucas1p1Q@eucas1p1.samsung.com>
 <CAJKOXPeCT3CkqqNowEZaeTw7goJd6=Nbd2S61QzTFW-nGr5AKg@mail.gmail.com>
 <20180620193407.gk5e5ecolo5bel3c@kozik-lap> <20180621055923eucas1p190f716475dcd44f72b24abfa4d948c82~6F2j2EPNk0295402954eucas1p1v@eucas1p1.samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Thu, 21 Jun 2018 09:21:06 +0200
X-Gmail-Original-Message-ID: <CAJKOXPeCnRCR6q_QPAxxEA7Ej7qPfEm+n-SD6+81okhomj4MuA@mail.gmail.com>
Message-ID: <CAJKOXPeCnRCR6q_QPAxxEA7Ej7qPfEm+n-SD6+81okhomj4MuA@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: exynos: Remove unneeded DSI and DECON
 address/size cells in Exynos5433
To:     Andrzej Hajda <a.hajda@samsung.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 June 2018 at 07:59, Andrzej Hajda <a.hajda@samsung.com> wrote:
> On 20.06.2018 21:34, Krzysztof Kozlowski wrote:
>> On Tue, Jun 19, 2018 at 09:59:04AM +0200, Krzysztof Kozlowski wrote:
>>> On 19 June 2018 at 09:26, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>>>> Hi Krzysztof,
>>>>
>>>> On 2018-06-18 19:42, Krzysztof Kozlowski wrote:
>>>>> The decon, decon_tv and dsi nodes have only one child port so
>>>>> address/size mappings are not necessary.  This fixes DTC warnings like:
>>>>>
>>>>>      Warning (graph_child_address): /soc/decon@13800000/ports:
>>>>>          graph node has single child node 'port@0', #address-cells/#size-cells are not necessary
>>>>>
>>>>> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>>>> Works fine with current Exynos DRM Decon/MIC/DSI drivers.
>>>>
>>>> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
>>> Thanks for review and testing!
>> I have second thoughs whether this patch is correct. AFAIU, the drivers
>> get the remote endpoints by reg==0 (for example the
>> of_graph_get_remote_node() in exynos_dsi_parse_dt()). If the port shall
>> be ignored, then reg==-1 should be passed.
>
> All this is about purity, DECON bindings says explicitly that there
> should be a port with reg=0.

The warnings themself are indeed about purity.... but not having
warnings is quite useful. When you have already warnings either in C
code or in DTC, it is quite easy to skip new ones.

We successfully get rid of all DTC warnings from ARM part. It would be
nice to have the same for ARM64... but not with a cost of making bogus
changes.

> So your patch and DTC warnings are incorrect from bindings PoV.

Good point so this patch should come along with changing of bindings
(and maybe the code as well to use -1 as port/reg).

> On the other side graph bindings are too bloated ( so many lines to
> describe one connection ) so I am happy if there are shrinking attempts :)
> Functionally nothing changes, of graph helpers assume reg=0 if it is not
> present in port/endpoint node.
>
> And regarding real issues, DECON could have more ports, possible candidates:
> - GSCALER0/1/2,
> - GSD/DSD - interconnect between GSCALERs and DECONs,
> - SMIES - image enhancer (not implemented),
> - MIC0/1 - image enhancers,
> - DSIM0/1 - DSI encoders,
> - HDMI - HDMI encoder.
>
> But since all these connections can be configured dynamically, and more
> importantly are inside specific SoC I dont think they need of_graphs. In
> fact I think current of graph is also not necessary, but this is
> different story, removal is on my long TODO list :)

I keep my fingers crossed for this :)

Best regards,
Krzysztof
