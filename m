Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62316C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 07:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D3C82083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 07:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kGCkSKQW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D3C82083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756293AbeFSH7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 03:59:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:33550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755674AbeFSH7H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 03:59:07 -0400
Received: from mail-wm0-f54.google.com (mail-wm0-f54.google.com [74.125.82.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A4B720883;
        Tue, 19 Jun 2018 07:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529395146;
        bh=2jC0XDP4OpZZTSoeZQHXm5wNExqZ5npuceFpz7UO57s=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=kGCkSKQWBVYp9OsLi6O/sSsd5RlKbtQRiOFCOJEeU/A/ShrpVakmjtlbydKR6cvFo
         oeoy5QQily/KZ3wDCfu8A7pV/V9NgdyGvJdlwF8Z7th6ESjwJ5hEx4dhtAS99Lu6KV
         km2BymXR1AD1iuyK3/NfIJRQ0SAUpI/gMZZxT6co=
Received: by mail-wm0-f54.google.com with SMTP id l15-v6so17811278wmc.1;
        Tue, 19 Jun 2018 00:59:06 -0700 (PDT)
X-Gm-Message-State: APt69E1xWr8w/2xX/FmZdRSWx9XcBlWzZypvuYi0PEl+Xcoi64PVWRT3
        Xwpk9y84WLVSZlBdSy9AYT4zqC7wsGKNtWZ+VgY=
X-Google-Smtp-Source: ADUXVKK/iw64gcJ+T1ncCXp42iH3BsPnE+DA3U5S5Ljkcqv38ktHSf0NShREIxGHwibcqZjNc4tYVZ0+MncC8+DT00o=
X-Received: by 2002:a1c:58d5:: with SMTP id m204-v6mr10373131wmb.118.1529395145005;
 Tue, 19 Jun 2018 00:59:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9166:0:0:0:0:0 with HTTP; Tue, 19 Jun 2018 00:59:04
 -0700 (PDT)
In-Reply-To: <20180619072652eucas1p1943deb1b158eda52980448e41f83e5e9~5fwX6lI2o2633926339eucas1p1Q@eucas1p1.samsung.com>
References: <20180618174216.24801-1-krzk@kernel.org> <CGME20180618174316epcas1p397b66c8e4e8479fce8655941a4d4279f@epcas1p3.samsung.com>
 <20180618174216.24801-2-krzk@kernel.org> <20180619072652eucas1p1943deb1b158eda52980448e41f83e5e9~5fwX6lI2o2633926339eucas1p1Q@eucas1p1.samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 19 Jun 2018 09:59:04 +0200
X-Gmail-Original-Message-ID: <CAJKOXPeCT3CkqqNowEZaeTw7goJd6=Nbd2S61QzTFW-nGr5AKg@mail.gmail.com>
Message-ID: <CAJKOXPeCT3CkqqNowEZaeTw7goJd6=Nbd2S61QzTFW-nGr5AKg@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: exynos: Remove unneeded DSI and DECON
 address/size cells in Exynos5433
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 June 2018 at 09:26, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
> Hi Krzysztof,
>
> On 2018-06-18 19:42, Krzysztof Kozlowski wrote:
>> The decon, decon_tv and dsi nodes have only one child port so
>> address/size mappings are not necessary.  This fixes DTC warnings like:
>>
>>      Warning (graph_child_address): /soc/decon@13800000/ports:
>>          graph node has single child node 'port@0', #address-cells/#size-cells are not necessary
>>
>> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>
> Works fine with current Exynos DRM Decon/MIC/DSI drivers.
>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Thanks for review and testing!

Best regards,
Krzysztof
