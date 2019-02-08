Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F3EC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF9D02146E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:07:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="tdqe7jkm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbfBHRHo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:07:44 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:43885 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbfBHRHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 12:07:43 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190208170742euoutp01b3d511b3a5324cb7d4197ffe90e4fb98~BcoTxkw5f1566715667euoutp01J
        for <linux-kernel@vger.kernel.org>; Fri,  8 Feb 2019 17:07:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190208170742euoutp01b3d511b3a5324cb7d4197ffe90e4fb98~BcoTxkw5f1566715667euoutp01J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549645662;
        bh=tf7jF++VINv3+HBDvYPtOmc9dRJJcb+9HDKK47IITT8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=tdqe7jkmYy9rlGVv1IE+IdV5w7zUwBZRIh8QQRDHfke4/eE2IjBhZdwUYFDF0BdjJ
         FfrT/jtqkuS4Sotu7bC/neLN8Bczy5XTLYs2lDXPhTv4FXb52K9mTVU2OESBdKJOQC
         t2UbUxO+Lz+Br4pw6NeYujipvKnTYGqToXrceB+Q=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190208170741eucas1p2943281584bfc813ec3b01786910d178a~BcoTbCLAW2001120011eucas1p2i;
        Fri,  8 Feb 2019 17:07:41 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 6D.2C.04441.D57BD5C5; Fri,  8
        Feb 2019 17:07:41 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190208170740eucas1p20e5e86f4a41ff3de14c5affbe9a6e7ba~BcoSnX2RI0534105341eucas1p2L;
        Fri,  8 Feb 2019 17:07:40 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190208170740eusmtrp1c1f5e62da590acba940273fa4bd9a9c3~BcoSZQRTg0369203692eusmtrp1V;
        Fri,  8 Feb 2019 17:07:40 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-a2-5c5db75d920d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id E1.24.04284.C57BD5C5; Fri,  8
        Feb 2019 17:07:40 +0000 (GMT)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190208170740eusmtip1940fd241538b7d0ae412174d8b0e8790~BcoSGtFok1366713667eusmtip1A;
        Fri,  8 Feb 2019 17:07:40 +0000 (GMT)
Subject: Re: [PATCH] video: fbdev: geode: remove ifdef OLPC noise
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     linux-geode@lists.infradead.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <e15a710e-2dc6-8470-2f9a-ecb3124a86a4@samsung.com>
Date:   Fri, 8 Feb 2019 18:07:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190116151453.1971999-1-lkundrak@v3.sk>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphleLIzCtJLcpLzFFi42LZduzned3Y7bExBn9my1ic6PvAatF/7jSL
        xeVdc9gs7r2czeLA4rF5Sb3HkoPLGT0+b5ILYI7isklJzcksSy3St0vgylgxKbfgCVPFwf/3
        GBsYlzN1MXJySAiYSMy728fexcjFISSwglFi5qZZUM4XRomHL7oZIZzPjBKPNk5ghGnZ8WQW
        M0RiOaPEza4+sFlCAu8ZJVomFYHYwgKOElO397OC2CICyhITTy0Eq2EWSJBY3dgJFmcTsJKY
        2L4KbCivgJ3E/4azzCA2i4CKxLfpB4DiHByiAhES/WfUIUoEJU7OfMICEuYUMJN4tE0FYqKB
        xJFFc1ghbHmJ7W/ngJ0mIfCdTWLV5/lsEDe7SCyY0M0MYQtLvDq+hR3ClpE4PbmHBaJhOqPE
        m19LoZz1jBJrzhyDBpK1xOHjF1khbEeJiWcesoFcISHAJ3HjrSDEZj6JSdumM0OEeSU62oQg
        qtUkNizbwAazq2vnSqgbPCTWfG5lm8CoOAvJa7OQ/DMLyT8LGJlXMYqnlhbnpqcWG+allusV
        J+YWl+al6yXn525iBKaN0/+Of9rB+PVS0iFGAQ5GJR7eiJbYGCHWxLLiytxDjBIczEoivGmb
        gEK8KYmVValF+fFFpTmpxYcYpTlYlMR5qxkeRAsJpCeWpGanphakFsFkmTg4pRoYM45bub/4
        U1evGXYtrcqhzuxCFstrr8tRe17U/9RL1bvFM/WCP5PtW4OdV38895icsPrKyf/BLV97jhu5
        Hdz+1l3Y+Gnca+XSeMalBk/9FWUXz0w8kjevSlCt5nOz1KmCu3mmmvHTI7LNb92N23tP8uTh
        rNd3MrRF9VpbVk3scFG7WLYhcRKnEktxRqKhFnNRcSIAwIDOhhcDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkkeLIzCtJLcpLzFFi42I5/e/4Xd2Y7bExBjOnKFic6PvAatF/7jSL
        xeVdc9gs7r2czeLA4rF5Sb3HkoPLGT0+b5ILYI7SsynKLy1JVcjILy6xVYo2tDDSM7S00DMy
        sdQzNDaPtTIyVdK3s0lJzcksSy3St0vQy1gxKbfgCVPFwf/3GBsYlzN1MXJySAiYSOx4Mou5
        i5GLQ0hgKaPEx7nb2boYOYASMhLH15dB1AhL/LnWxQZR85ZR4tTV64wgCWEBR4mp2/tZQWwR
        AWWJiacWMkEUdQIVnVgAlmAWSJCYeWc7C4jNJmAlMbF9FVgzr4CdxP+Gs8wgNouAisS36QfA
        4qICERK3HnawQNQISpyc+YQF5CBOATOJR9tUIEbqSey4/gtqvLzE9rdzmCcwCs5C0jELSdks
        JGULGJlXMYqklhbnpucWG+oVJ+YWl+al6yXn525iBEbDtmM/N+9gvLQx+BCjAAejEg8vQ1Ns
        jBBrYllxZe4hRgkOZiUR3rRNQCHelMTKqtSi/Pii0pzU4kOMpkA/TGSWEk3OB0ZqXkm8oamh
        uYWlobmxubGZhZI473mDyighgfTEktTs1NSC1CKYPiYOTqkGxgniobaGD4wM3Byfxmx0al4j
        LsuqbSi1YoWfo8b7w/nfUhc92T3vsfPZC75Ra54ucsh3Nm98zV/PWVl5/pSLoveLRQXyFRwz
        cpn+HpKbNDOdN7UvqDJwXVz6pu7Weu4DoQtdzq1e8Erg54/G55P716au/MN5S0soN7jw3J3j
        GYphdk9+nrvsoMRSnJFoqMVcVJwIAFX0jL6cAgAA
X-CMS-MailID: 20190208170740eucas1p20e5e86f4a41ff3de14c5affbe9a6e7ba
X-Msg-Generator: CA
X-RootMTR: 20190116151558epcas4p11c6468321ddbc3a8b32f03bb627cd560
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190116151558epcas4p11c6468321ddbc3a8b32f03bb627cd560
References: <CGME20190116151558epcas4p11c6468321ddbc3a8b32f03bb627cd560@epcas4p1.samsung.com>
        <20190116151453.1971999-1-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 01/16/2019 04:14 PM, Lubomir Rintel wrote:
> <asm/olpc.h> provides olpc_has_dcon() stub for CONFIG_OLPC=n, compiler
> should just optimize the unneeded bits away.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Patch queued for v5.1, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
