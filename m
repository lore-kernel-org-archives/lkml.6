Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0EE2ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A80320856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="IKE3aJLl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A80320856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388436AbeGXQwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 12:52:03 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:33188 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388300AbeGXQwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 12:52:03 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20180724154456euoutp01a80a465bc8a0e10707c98681aad5e4a6~EWIPeD9qT1373613736euoutp01b;
        Tue, 24 Jul 2018 15:44:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180724154456euoutp01a80a465bc8a0e10707c98681aad5e4a6~EWIPeD9qT1373613736euoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1532447096;
        bh=iuR+ZP27f/t1mCAp4BkiFnO5/td0/1/0pZsxe2UzkaU=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=IKE3aJLl+G/NxdTfIX9W5bT0sJXMhxkyt0z2c+Ch9XeLpywmZA7lUGzfvbjcCmxs4
         /NWsM7iQSy7EEdl+RTI9IXBK4kF9LHosVzuwnriB3nZ64zH1LpD9l+s80xsIdqmvhR
         ClKXjP/n5DCnrOAaYBzfUEhutEMvPZCFPCSuGTvA=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180724154456eucas1p2921e1774890ac79503579c614fc6babc~EWIPJYO_M0032800328eucas1p2h;
        Tue, 24 Jul 2018 15:44:56 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 37.E9.04627.779475B5; Tue, 24
        Jul 2018 16:44:55 +0100 (BST)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180724154453eucas1p2304aa13314abbaedfaff921638553bef~EWIMpIZu40032800328eucas1p2g;
        Tue, 24 Jul 2018 15:44:53 +0000 (GMT)
X-AuditID: cbfec7f2-0edff70000021213-3b-5b574977fe0e
Received: from eusync1.samsung.com ( [203.254.199.211]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 70.89.04178.579475B5; Tue, 24
        Jul 2018 16:44:53 +0100 (BST)
Received: from amdc3058.localnet ([106.120.53.102]) by eusync1.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PCD008BRNQTLZ90@eusync1.samsung.com>; Tue, 24 Jul
        2018 16:44:53 +0100 (BST)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Tony Lindgren <tony@atomide.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] omapfb: rename omap2 module to omap2fb.ko
Date:   Tue, 24 Jul 2018 17:44:52 +0200
Message-id: <7035461.Acm8y0QBsZ@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <20180709070216.GE112168@atomide.com>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHIsWRmVeSWpSXmKPExsWy7djPc7rlnuHRBrcu2lj8nXSM3eLK1/ds
        Fif6PrBaXN41h81i9pJ+Fov7Swot9l/xcmD3+P1rEqPHt6+TWDzudx9n8tj06S6rx+dNcgGs
        UVw2Kak5mWWpRfp2CVwZd/v2shc0cVRsOXeZtYFxD1sXIyeHhICJxM1vr9i7GLk4hARWMEoc
        nnSHGSQhJPCZUWJmk2IXIwdY0fEvaRDhZYwS377XQNT/ZpRov93EApJgE7CSmNi+ihGkXkTA
        WWLeylCQGmaBDYwSW+bvZQepERawkzj/ci8TiM0ioCpx58YJMJtXQFOiZ+pbVhBbVMBLYsu+
        drA4p4CRxKnP25khagQlfky+B7aLWUBeYt/+qawQto7E2WPrGEGWSQhsYZM49voqI8RnLhJ9
        s08yQdjCEq+Ob2GHsGUkOjsOMkE0TGeUePNrKQuEs55RYs2ZY1Ad1hKHj1+EWsEnMWnbdGZI
        UPBKdLQJQZR4SEz+cZwREhRAb36adoplAqPMLCTXzkJy7Swk1y5gZF7FKJ5aWpybnlpsmJda
        rlecmFtcmpeul5yfu4kRmApO/zv+aQfj10tJhxgFOBiVeHg/2IVHC7EmlhVX5h5ilOBgVhLh
        XSQKFOJNSaysSi3Kjy8qzUktPsQozcGiJM4bp1EXJSSQnliSmp2aWpBaBJNl4uCUamDkZf2t
        OLnr4LF9uS32IjdqD4gUrurbHrFFXtDof56J5YJ71lV7r9t8u5nx6r2a9bpzjb1nc/ZEG89d
        27q/vqJneeQ8x+cs6+bu1DilXtzydVFVcdqG/3yBrK0fhMW31JTYVuhtlvopua/N46XXhadr
        KzcucmZPulakp7kyPETZM8d83fPi7zOVWIozEg21mIuKEwEW7XDqAQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLLMWRmVeSWpSXmKPExsVy+t/xy7qlnuHRBn8WCFn8nXSM3eLK1/ds
        Fif6PrBaXN41h81i9pJ+Fov7Swot9l/xcmD3+P1rEqPHt6+TWDzudx9n8tj06S6rx+dNcgGs
        UVw2Kak5mWWpRfp2CVwZd/v2shc0cVRsOXeZtYFxD1sXIweHhICJxPEvaV2MXBxCAksYJb7O
        WMwI4fxllHg1/RRQEScHm4CVxMT2VYwgDSICzhLzVoaC1DALbGCUmHWrgwmkRljATuL8y71g
        NouAqsSdGyfAbF4BTYmeqW9ZQWxRAS+JLfvaweKcAkYSpz5vZ4ZYBjRo98KDLBANghI/Jt8D
        s5kF5CX27Z/KCmFrSazfeZxpAiP/LCRls5CUzUJStoCReRWjSGppcW56brGhXnFibnFpXrpe
        cn7uJkZgIG879nPzDsZLG4MPMQpwMCrx8Ho4hkcLsSaWFVfmHmKU4GBWEuFdJAoU4k1JrKxK
        LcqPLyrNSS0+xCjNwaIkznveoDJKSCA9sSQ1OzW1ILUIJsvEwSnVwDjrp6TqM7ame4X9SwXv
        evsc9M7oWKD6cnf6Sm39OYxSV/Inf+2web9rzi/pCM/y/sh87pys3NNeUya1pM4tEVX1/PqJ
        j/N6rxNHq/ZyVXuf22lS69bW/XmVtm4TA8OVjGP7l2qeefGt+xSr3i/tvOp/YWwHMrdY1v1c
        lH1pQsGMsNsOr//lvlBiKc5INNRiLipOBAB+exdhYAIAAA==
X-CMS-MailID: 20180724154453eucas1p2304aa13314abbaedfaff921638553bef
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180709070222epcas2p23ff1e3707fcad5eb9270aafd3081a63e
References: <20180706123528.2729378-1-arnd@arndb.de>
        <CGME20180709070222epcas2p23ff1e3707fcad5eb9270aafd3081a63e@epcas2p2.samsung.com>
        <20180709070216.GE112168@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, July 09, 2018 12:02:16 AM Tony Lindgren wrote:
> * Arnd Bergmann <arnd@arndb.de> [180706 12:39]:
> > In a kernel configuration with both CONFIG_FB_OMAP=m and CONFIG_FB_OMAP2=m,
> > Kbuild fails to point out that we have two modules with the same name (omapfb.ko),
> > but instead fails with a cryptic error message like:
> > 
> > ERROR: "omapfb_register_panel" [drivers/video/fbdev/omap/lcd_osk.ko] undefined!
> > 
> > This can now happen when building a randconfig kernel with CONFIG_ARCH_OMAP1,
> > as the omap1 fbdev driver depends on that, whiel the omap2 fbdev driver can
> > now be built anywhere with CONFIG_COMPILE_TEST.
> > 
> > The solution is to rename one of the two modules, so for consistency with
> > the directory naming I decided to rename the omap2 version to omap2fb.ko.
> 
> Sounds good to me:
> 
> Acked-by: Tony Lindgren <tony@atomide.com>

Patch queued for 4.19, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

