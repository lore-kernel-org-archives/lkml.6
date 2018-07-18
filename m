Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F57ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 23:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9BFE2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 23:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="jMJEIw52"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9BFE2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731043AbeGSA0D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 20:26:03 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:56332 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729863AbeGSA0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 20:26:03 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20180718234544epoutp034e8bfbe1d2d6c6415a4ba155c66b9bef~Cm0UQi0Di1618716187epoutp03F;
        Wed, 18 Jul 2018 23:45:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180718234544epoutp034e8bfbe1d2d6c6415a4ba155c66b9bef~Cm0UQi0Di1618716187epoutp03F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1531957544;
        bh=l8JpzewUmIG2YSTTG3byF0AXYHqcBCAW1oW+GbX0MQQ=;
        h=Date:From:To:Cc:Subject:In-reply-to:References:From;
        b=jMJEIw52oL9PATn5RFvvPk8CAe9fbiyD0jz7gYlP2wau8E71ESYzDCdOsr2bj3ikE
         11VLvlzv3b2p82Wl6WBd5ebEgQo++CUU/9PI6Quc+dch7tzpk1DxLXADpJUqUlavJf
         Trr0K6ANITTEncbT80J0RPLSNvKodfDS3yob16AA=
Received: from epsmges1p4.samsung.com (unknown [182.195.40.152]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20180718234540epcas1p42e2355f5d36e6c6e0435f82a54514fa7~Cm0QvYo7_1311113111epcas1p4S;
        Wed, 18 Jul 2018 23:45:40 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        3B.53.04343.321DF4B5; Thu, 19 Jul 2018 08:45:39 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20180718234539epcas1p317b2cd8e59ac8576e6e6a8f28bc27cf3~Cm0QAoFyK1510215102epcas1p3n;
        Wed, 18 Jul 2018 23:45:39 +0000 (GMT)
X-AuditID: b6c32a38-78bff700000010f7-39-5b4fd1230fb9
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p1new.samsung.com
        (Symantec Messaging Gateway) with SMTP id 15.59.03915.321DF4B5; Thu, 19 Jul
        2018 08:45:39 +0900 (KST)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Received: from [10.113.63.77] by mmp2.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PC300DJ2603IS80@mmp2.samsung.com>; Thu, 19 Jul 2018 08:45:39 +0900 (KST)
Message-id: <5B4FD122.3070403@samsung.com>
Date:   Thu, 19 Jul 2018 08:45:38 +0900
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] dt-bindings: clock: samsung: Add SPDX license
 identifiers
In-reply-to: <20180718200216.6389-1-krzk@kernel.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfUyMcRzf73nunudJLo9DfjI5D5qy0nPX8WjlZRmPqdUWY26WRz3umu7F
        PXcp/zBUpIi05ZhibFyoXYnK286hvFwrcwzHH8ZaYc0lTXl57h6Nv36f32ef78vnsy+BKiux
        KCLfZOOtJq6AwibIWu/FxsfP7cnUJR4do5k6j1fOdHc34YzrvU/OPGs/jTG13bcR5orHjzMX
        XvQgTMktD87c+1QmZ5pdNSjjbB8DK8LZy2cuA7bN4cdZl/MQxn7xenG2+fwe9kiLE7ABV3QW
        vplPMfBcHm9V8aZcc16+SZ9KrcvOScvRLk6k4+mlzBJKZeKMfCq1Kj0rfnV+gbgjpSrkCuwi
        lcUJArVoWYrVbLfxKoNZsKVSOppWJ9CJSxLUavHVbElWa0XJVt7g//VdbhkIK/LddiJ7QTte
        DsIISCZBn6cTKwcTCCV5A8Cq/kYgfb4D+KbSj46rAg/qZEGsJJsADFTHBLGCnAxHqt+KPEGg
        5Gzo6d0RpFEyFl7raMSlPn4AT13yIpI+Dnae/BnCMnI+HKo6CYIYE/k7fS+xIJ5EzoHPR96H
        +GnkJthWNxxqNJUcQ2BTw1dcmrAAvvtQE8JTyCw4+LohVBwmLlpf6wnZgeQoBg+dCMgkB6tg
        TeDHXzdTYP/DFjy4NSRnwt77qZK+DMChvv1y6VMF4OCjZkQq0MCPZ8sRaXIE/PKtQi4VK+DB
        UqUkYeG7kkeIZFls9HC4FKsCsxz/peT4l5Ljv5TqAeoEkbxFMOp5gbYkJQicUbCb9Am5ZqML
        hE4xjrkBbnrT3YAkADVRYfiZoVPKuUKh2OgGkECpqYpbXZk6pSKPK97NW805VnsBL7iBVgz5
        GBo1LdcsHrbJlkNr1RqNhkmiF2tpmpquuK5gdUpSz9n4HTxv4a3jdQgRFrUXxFiusm0+w8K+
        tyW4w9mRvfNVxIzm4qVD1HLGqz3WYd7gSItmI31Pe9LCSwPdT86ZhrqOJ1cUT294vnZScnjP
        53p2dCC7d/nr6vRt7a13fa32AxVdA2539nDp+lMr5x7+rT+nKnLM26jbtaZ2X66yP6IQDFBH
        KiIfD17q3G7OoC5SMsHA0XGoVeD+AFkBPt6gAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNLMWRmVeSWpSXmKPExsVy+t9jQV3li/7RBguPyVjMP3KO1eL8+Q3s
        FpseX2O1uLxrDpvFjPP7mCzWHrnLbrH0+kUmi9a9R9gtDr9pZ7XYvGkqs8WqXX8YHbg91sxb
        w+ixc9Zddo9NqzrZPN6dO8fusXlJvUffllWMHp83yQWwR3HZpKTmZJalFunbJXBl3P33nbXg
        NWfFtX2rmBoYd7F3MXJySAiYSHw+Np+li5GLQ0hgHaNE8+77zCAJXgFBiR+T7wElODiYBeQl
        jlzKBgkzC6hLTJq3iBmi/j6jRHfTZSaIei2JEzP/gtksAqoSXybMZASx2YDi+1/cYAOx+QUU
        Ja7+eMwIMlNUIEKi+0QlyBwRgX9MEj37trBCLNCQuP90KthxwgJ+En1vj4DNERLoZJTY9sAW
        xOYEOnrBjCNsExgFZiE5dRbCqbOQnLqAkXkVo2RqQXFuem6xUYFhXmq5XnFibnFpXrpecn7u
        JkZglGw7rNW3g/H+kvhDjAIcjEo8vBl/faOFWBPLiitzDzFKcDArifDuPekfLcSbklhZlVqU
        H19UmpNafIhRmoNFSZz3dt6xSCGB9MSS1OzU1ILUIpgsEwenVAPjxHP/qkN32P10vHHq8i8v
        FwXRP1k8M7a+f3Ij0dT5zz7vb9KqZiJSs3YxLTuRYVdknfpkl7OFhmHtE6e/E5qS/qbOVvGL
        0rnwZWrr9zjLr5dNN6S+fSny5D5bqtHzjNj7BYq+e06167P/C+35EGEXnrO74/xtY0aNc7vW
        zGDkVeNs4dFgEzBXYinOSDTUYi4qTgQA7aP9HI4CAAA=
X-CMS-MailID: 20180718234539epcas1p317b2cd8e59ac8576e6e6a8f28bc27cf3
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180718200247epcas1p33ff6e502031498802741a0dc37400ca9
References: <CGME20180718200247epcas1p33ff6e502031498802741a0dc37400ca9@epcas1p3.samsung.com>
        <20180718200216.6389-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 2018년 07월 19일 05:02, Krzysztof Kozlowski wrote:
> Replace GPL license statements with SPDX license identifiers (GPL-2.0).
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  include/dt-bindings/clock/exynos3250.h            | 5 +----
>  include/dt-bindings/clock/exynos4.h               | 7 ++-----
>  include/dt-bindings/clock/exynos5250.h            | 7 ++-----
>  include/dt-bindings/clock/exynos5260-clk.h        | 7 ++-----
>  include/dt-bindings/clock/exynos5410.h            | 7 ++-----
>  include/dt-bindings/clock/exynos5420.h            | 7 ++-----
>  include/dt-bindings/clock/exynos5433.h            | 5 +----
>  include/dt-bindings/clock/exynos7-clk.h           | 7 ++-----
>  include/dt-bindings/clock/s3c2410.h               | 5 +----
>  include/dt-bindings/clock/s3c2412.h               | 5 +----
>  include/dt-bindings/clock/s3c2443.h               | 5 +----
>  include/dt-bindings/clock/samsung,s2mps11.h       | 5 +----
>  include/dt-bindings/clock/samsung,s3c64xx-clock.h | 7 ++-----
>  13 files changed, 20 insertions(+), 59 deletions(-)
> 

Looks good to me.
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

(snip)

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
