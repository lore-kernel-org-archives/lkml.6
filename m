Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E3AC43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31DD120874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:34:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31DD120874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754838AbeFTTeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 15:34:13 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55417 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754557AbeFTTeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 15:34:11 -0400
Received: by mail-wm0-f66.google.com with SMTP id v16-v6so1296950wmh.5;
        Wed, 20 Jun 2018 12:34:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CFt+omTgBby9fmUhQG+E/Ze+BajCVCPdsAKMIV+hAeY=;
        b=QFo2U23QASNMvbhkFr673AwdSrZNlo2usBpFk7jxXisijXZa1hCgBUTHPnR0wSNcsw
         zFNuJoH8aHYEcR9GRvAwZC3s6fuQB+GZappQ3nxv4hWaAgFA1G1/rWZp5enzEO6FyI6s
         3TaVe777B3Injr/26g5FF0tdm/NuAE/Iv1ISCyI7dUiSPoaW2WYQWjK+JIQy8Iztu+Ll
         +OiqLqUUX1FrReCHGvqJ+yISY3S3dP4Mx7kw0sVdt/sJ0KIsznzECAgJVI2KPiyINIzy
         I+qgM3JVvl+SDmkq68GrtiIMs3fHMz7aYp3myMMY1+0cl2tSgXvPaE9VHxUslnvwfK8m
         JxBw==
X-Gm-Message-State: APt69E2QIJsEkEVd6FowVgaNyqcOEqm4/4+JejtE6NA96S0A9YRJZsNd
        ADSw748VEvdv3ojENQelxIcN+gMB
X-Google-Smtp-Source: ADUXVKL8/p2dD1TqZmvLq+qK+1aHmTFICDMv2UmHNOD3ITSIZCjN0BE8aQvRme8bjc/baweK37s4Wg==
X-Received: by 2002:a50:b7fc:: with SMTP id i57-v6mr19511456ede.284.1529523249874;
        Wed, 20 Jun 2018 12:34:09 -0700 (PDT)
Received: from kozik-lap (adsl-84-227-236-43.adslplus.ch. [84.227.236.43])
        by smtp.googlemail.com with ESMTPSA id r15-v6sm1331846edp.92.2018.06.20.12.34.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 12:34:09 -0700 (PDT)
Date:   Wed, 20 Jun 2018 21:34:07 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrzej Hajda <a.hajda@samsung.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: exynos: Remove unneeded DSI and DECON
 address/size cells in Exynos5433
Message-ID: <20180620193407.gk5e5ecolo5bel3c@kozik-lap>
References: <20180618174216.24801-1-krzk@kernel.org>
 <CGME20180618174316epcas1p397b66c8e4e8479fce8655941a4d4279f@epcas1p3.samsung.com>
 <20180618174216.24801-2-krzk@kernel.org>
 <20180619072652eucas1p1943deb1b158eda52980448e41f83e5e9~5fwX6lI2o2633926339eucas1p1Q@eucas1p1.samsung.com>
 <CAJKOXPeCT3CkqqNowEZaeTw7goJd6=Nbd2S61QzTFW-nGr5AKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJKOXPeCT3CkqqNowEZaeTw7goJd6=Nbd2S61QzTFW-nGr5AKg@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 09:59:04AM +0200, Krzysztof Kozlowski wrote:
> On 19 June 2018 at 09:26, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
> > Hi Krzysztof,
> >
> > On 2018-06-18 19:42, Krzysztof Kozlowski wrote:
> >> The decon, decon_tv and dsi nodes have only one child port so
> >> address/size mappings are not necessary.  This fixes DTC warnings like:
> >>
> >>      Warning (graph_child_address): /soc/decon@13800000/ports:
> >>          graph node has single child node 'port@0', #address-cells/#size-cells are not necessary
> >>
> >> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> >
> > Works fine with current Exynos DRM Decon/MIC/DSI drivers.
> >
> > Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> 
> Thanks for review and testing!

I have second thoughs whether this patch is correct. AFAIU, the drivers
get the remote endpoints by reg==0 (for example the
of_graph_get_remote_node() in exynos_dsi_parse_dt()). If the port shall
be ignored, then reg==-1 should be passed.

Best regards,
Krzysztof

