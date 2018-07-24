Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 407B4C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0E5120874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:46:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="B/wYF+rY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0E5120874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388454AbeGXRx7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 13:53:59 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:44775 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388393AbeGXRx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 13:53:59 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20180724164638euoutp01c93b0b3a3a8293b804522817f7d3cb07~EW_GwV-xm0632206322euoutp01e;
        Tue, 24 Jul 2018 16:46:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180724164638euoutp01c93b0b3a3a8293b804522817f7d3cb07~EW_GwV-xm0632206322euoutp01e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1532450798;
        bh=oTf1fp35ARp3WjIU6MUfq8QBxq+aw94UauzYApDUKGw=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=B/wYF+rY5Q8J+wAedeCwj0G+yPjiGp1CnKWuCxxHKlPgDIchB++7rYYHnf4d8ad1G
         i6zb3DYsPnLiZ1FhgGE5EoXM0eU4iUVupx+Q15mgm8x8EPQHFbopfb+sLat25xeGXW
         DLO4JUZkd3DezWT+Vkjk1MshLB61DZnU7PUF+SU4=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180724164637eucas1p208cf56428e124299d024e642827f2197~EW_GNTMG-3060930609eucas1p2x;
        Tue, 24 Jul 2018 16:46:37 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 73.AB.61560.DE7575B5; Tue, 24
        Jul 2018 17:46:37 +0100 (BST)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180724164636eucas1p2e7075066269c718fda82f64308be9540~EW_FbXzKi0613106131eucas1p2t;
        Tue, 24 Jul 2018 16:46:36 +0000 (GMT)
X-AuditID: cbfec7f5-1edff7000002f078-5a-5b5757edcbfe
Received: from eusync4.samsung.com ( [203.254.199.214]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 0C.CA.04183.CE7575B5; Tue, 24
        Jul 2018 17:46:36 +0100 (BST)
Received: from amdc3058.localnet ([106.120.53.102]) by eusync4.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PCD00DECQLOG300@eusync4.samsung.com>; Tue, 24 Jul
        2018 17:46:36 +0100 (BST)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: thermal: samsung: Add SPDX license
 identifier
Date:   Tue, 24 Jul 2018 18:46:35 +0200
Message-id: <2442216.oppRSGRAaL@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <20180718200250.6478-1-krzk@kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupileLIzCtJLcpLzFFi42LZduzned234eHRBu/6uSzmHznHajH/yjVW
        i/7Hr5ktzp/fwG6x6TGQe3nXHDaLz71HGC1mnN/HZLH0+kUmi9a9R9gtnjzsY3Pg9lgzbw2j
        x85Zd9k9Fu95yeSxaVUnm8fmJfUenzfJBbBFcdmkpOZklqUW6dslcGVMPvKPreAJb8XSyb9Y
        GhincXcxcnJICJhIvLp8mKmLkYtDSGAFo8T3h4vZIJzPjBI3z31l6WLkAKs6/68OIr6MUaL/
        2xRWkG4hgd+MEm/aikFsNgEriYntqxhBbBEBTYnrf7+zgjQwC1xjkuh+to0NJCEsECjxavYN
        dhCbRUBVYmv3OiYQmxeoofNTH1hcVMBLYsu+drA4J9Dip69WMkLUCEr8mHyPBcRmFpCX2Ld/
        KiuErSNx9tg6RpBlEgK32SSuTt/FAvGbi8TsqY/YIWxhiVfHt0DZMhKXJ3ezQDRMB/rg11Io
        Zz2jxJozx5ggqqwlDh+/CLWCT2LStunMkLDglehoE4Io8ZA4eP0IOyRc2hklXs34xjyBUWYW
        kmtnIbl2FpJrFzAyr2IUTy0tzk1PLTbOSy3XK07MLS7NS9dLzs/dxAhMIaf/Hf+6g3Hfn6RD
        jAIcjEo8vB/swqOFWBPLiitzDzFKcDArifCaBgKFeFMSK6tSi/Lji0pzUosPMUpzsCiJ88Zp
        1EUJCaQnlqRmp6YWpBbBZJk4OKUaGHcebZ/IwZ77M/Tz55QQO9HLbe9eL+adHq+2xTPwhb9d
        W3yfSt7G38qcPuZn56f8UnZ6MHtSk7Gm9/Xoo67XM2YqhP09f5PHzO77V1atrvbzBk4cL0yW
        3OGS2TJRW3ejE6f+NknT/MyIlRNMI5SmfxKJ/nD6ybsN6Vw/ZZLWLgyUKrAt43p8T4mlOCPR
        UIu5qDgRADe7nEUdAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBLMWRmVeSWpSXmKPExsVy+t/xa7pvwsOjDfpPiVrMP3KO1WL+lWus
        Fv2PXzNbnD+/gd1i02Mg9/KuOWwWn3uPMFrMOL+PyWLp9YtMFq17j7BbPHnYx+bA7bFm3hpG
        j52z7rJ7LN7zkslj06pONo/NS+o9Pm+SC2CL4rJJSc3JLEst0rdL4MqYfOQfW8ET3oqlk3+x
        NDBO4+5i5OCQEDCROP+vrouRi0NIYAmjxPwvXSwQzl9GiZbp/xi7GDk52ASsJCa2rwKzRQQ0
        Ja7//c4KUsQscI1J4vGO92wgCWEBf4mOPe/AilgEVCW2dq9jArF5gRo6P/Wxg9iiAl4SW/a1
        g8U5gTY/fbWSEWJbJ6PE66dz2CEaBCV+TL7HAmIzC8hL7Ns/lRXC1pJYv/M40wRG/llIymYh
        KZuFpGwBI/MqRpHU0uLc9NxiI73ixNzi0rx0veT83E2MwPDfduznlh2MXe+CDzEKcDAq8fB6
        OIZHC7EmlhVX5h5ilOBgVhLhNQ0ECvGmJFZWpRblxxeV5qQWH2KU5mBREuc9b1AZJSSQnliS
        mp2aWpBaBJNl4uCUamD0TbWvUsp/vHCKgWRQz+rFNp/3yDq3qj8T4N7TsYejj6lMkt17n5Bf
        qtOpLkfv799OXT4vr7R7YZ5cQMer3W7TnoTOm3FeuYP79H/5CUpr7x+S9ZuQsCN+3rk1yzwU
        3yTpSdY86evx1Fyq8Ndn61n7kKn19UICtWIz3Y/nbKq503z7oOVrl+9KLMUZiYZazEXFiQCI
        ePLFewIAAA==
X-CMS-MailID: 20180724164636eucas1p2e7075066269c718fda82f64308be9540
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180718200318epcas3p16aed6c1725d6c1e63ea6b1ad209c5756
References: <CGME20180718200318epcas3p16aed6c1725d6c1e63ea6b1ad209c5756@epcas3p1.samsung.com>
        <20180718200250.6478-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On Wednesday, July 18, 2018 10:02:50 PM Krzysztof Kozlowski wrote:
> Replace GPL license statement with SPDX license identifier (GPL-2.0+).
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  include/dt-bindings/thermal/thermal_exynos.h | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/include/dt-bindings/thermal/thermal_exynos.h b/include/dt-bindings/thermal/thermal_exynos.h
> index 0646500bca69..642e4e7f4084 100644
> --- a/include/dt-bindings/thermal/thermal_exynos.h
> +++ b/include/dt-bindings/thermal/thermal_exynos.h
> @@ -1,19 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */

This code should be GPL-2.0 only, original license statement is most
likely result of using wrong file as the source of copy-paste. So I
would like to have the license fixed first before doing conversion to
SPDX.

>  /*
>   * thermal_exynos.h - Samsung EXYNOS TMU device tree definitions
>   *
>   *  Copyright (C) 2014 Samsung Electronics
>   *  Lukasz Majewski <l.majewski@samsung.com>
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
>   */
>  
>  #ifndef _EXYNOS_THERMAL_TMU_DT_H

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

