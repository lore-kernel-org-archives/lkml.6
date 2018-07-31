Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F887C46462
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 11:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0BBA208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 11:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="K9PuuNts"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0BBA208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732024AbeGaMoF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 08:44:05 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:49074 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731395AbeGaMoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 08:44:05 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180731110416euoutp02093732e3aa3bca469f2de11e2a34389b~Gb0MJqEL00273902739euoutp02M;
        Tue, 31 Jul 2018 11:04:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180731110416euoutp02093732e3aa3bca469f2de11e2a34389b~Gb0MJqEL00273902739euoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1533035056;
        bh=bJpXlrNHKF7+PPhiUzffTCOH/eSTaGeDq/DC531a2PM=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=K9PuuNtsJZgk+5C9I8rsmuFk8NVnjB6JArAXjiVUCowDQ1oGUtspDseVbbFW6Mck5
         QNC3G+FpUbdyiNZYL7A81P65JXtCX/nFeaIXwmr6COYHL9MtnQyuWr18wK0M1ubVLP
         Ygxuv0aEbCM0T8ji4Rkyof022NGFz/K7SOaLBWcs=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180731110416eucas1p190442208bf14c4acda0fb084a5aa755d~Gb0Lse-Zy1323213232eucas1p1Y;
        Tue, 31 Jul 2018 11:04:16 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 6E.C5.04627.032406B5; Tue, 31
        Jul 2018 12:04:16 +0100 (BST)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180731110415eucas1p1ae2d8e50b2583a4367f9cc47375ffef4~Gb0LC-jFf1167511675eucas1p1i;
        Tue, 31 Jul 2018 11:04:15 +0000 (GMT)
X-AuditID: cbfec7f2-51b7d9c000021213-64-5b604230262a
Received: from eusync1.samsung.com ( [203.254.199.211]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 26.29.04178.F22406B5; Tue, 31
        Jul 2018 12:04:15 +0100 (BST)
Received: from amdc3058.localnet ([106.120.53.102]) by eusync1.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PCQ003EZ9F3T860@eusync1.samsung.com>; Tue, 31 Jul
        2018 12:04:15 +0100 (BST)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     kbuild test robot <fengguang.wu@intel.com>
Cc:     Mauro Carvalho Chehab <m.chehab@samsung.com>, kbuild-all@01.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] media: omap2: omapfb: fix bugon.cocci warnings
Date:   Tue, 31 Jul 2018 13:04:14 +0200
Message-id: <1852918.sFt5Xj4oDG@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <20180725175700.GA82595@lkp-sb05.lkp.intel.com>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHIsWRmVeSWpSXmKPExsWy7djPc7oGTgnRBkubOC2ufH3PZvH++Xpm
        i2PXJzJbnOj7wGpxedccNoueDVtZLWYv6WexuLhO3mL9/FtsDpwe9/eyeyze85LJ4373cSaP
        vi2rGD2O39jO5PF5k1wAWxSXTUpqTmZZapG+XQJXxsub+5gLtnBU/Lm7jLWB8TtbFyMnh4SA
        icTrRVvYuxi5OIQEVjBKTFz2mRHC+cwo8Wb5fWaYqiWLFzBDJJYxSizrOM4E4fxmlGhZf4gR
        pIpNwEpiYvsqMFtEQE9ixcI2sFHMAm1MEiu/bQBbKCzgLHFy2kQgm4ODRUBV4vD6WJAwr4Cm
        xI4Z7ewgtqiAl8SWfe1MIDangI3Et1+nGSFqBCV+TL7HAmIzC8hL7Ns/lRXC1pE4e2wd2C4J
        gTNsEifWvmAHmS8h4CJx40caxAfCEq+Ob2GHsGUkOjsOMkHUTwd689dSFghnPaPEmjPHmCCq
        rCUOH78ItYFPYtK26cwQQ3klOtqEIEwPiT0fyyEBcYBRYsu8SUwTGGVmIbl1FpJbZyG5dQEj
        8ypG8dTS4tz01GLDvNRyveLE3OLSvHS95PzcTYzAVHH63/FPOxi/Xko6xCjAwajEw/tBPT5a
        iDWxrLgy9xCjBAezkgivjQxQiDclsbIqtSg/vqg0J7X4EKM0B4uSOO+d/rhoIYH0xJLU7NTU
        gtQimCwTB6dUA+Pu8JVOCZ/XGDye6Nwa2FWR7nNUPENIacsRdZUntyLPzeret51DhOuMLWdw
        e9rfhGsn8jpm3JCc299dNPP7nEmT9JemL/5ovPj33+KF85ukboYmsjhwZy42yV96OdjDZe2B
        NKeN0XPnCeS/Z7xtd0bT8eP2y4sz9EPvOsT2mGyy8nnKpXjc+6MSS3FGoqEWc1FxIgBmx6CO
        EQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLLMWRmVeSWpSXmKPExsVy+t/xy7r6TgnRBleXa1hc+fqezeL98/XM
        FseuT2S2ONH3gdXi8q45bBY9G7ayWsxe0s9icXGdvMX6+bfYHDg97u9l91i85yWTx/3u40we
        fVtWMXocv7GdyePzJrkAtigum5TUnMyy1CJ9uwSujJc39zEXbOGo+HN3GWsD43e2LkZODgkB
        E4klixcwdzFycQgJLGGUmLrpPJTzl1Fi1ct1jCBVbAJWEhPbV4HZIgJ6EisWtjGCFDELtDFJ
        3FuxFGyUsICzxMlpE4FsDg4WAVWJw+tjQcK8ApoSO2a0s4PYogJeElv2tTOB2JwCNhLffp1m
        hFh2gFHi7sorrBANghI/Jt9jAbGZBeQl9u2fygpha0ms33mcaQIj/ywkZbOQlM1CUraAkXkV
        o0hqaXFuem6xoV5xYm5xaV66XnJ+7iZGYKBvO/Zz8w7GSxuDDzEKcDAq8fB6aMVHC7EmlhVX
        5h5ilOBgVhLhtZEBCvGmJFZWpRblxxeV5qQWH2KU5mBREuc9b1AZJSSQnliSmp2aWpBaBJNl
        4uCUamDUbDbysDnzOeHUiv3SEg933sy7I3rkUMTNtx98nFRvXfi0Za+duUmTlFvdLSMe0Qr+
        lLvS0+TXlZS39ZxVVjncPmlOSYCG1oINssznbPd7VebZym/YkPF1ReWVIIslfyTm3r7yt8RD
        Lbgtw/XZ3KCrE8pbt3w+lxT996A/H2sRk963320TnzcqsRRnJBpqMRcVJwIApGQfznACAAA=
X-CMS-MailID: 20180731110415eucas1p1ae2d8e50b2583a4367f9cc47375ffef4
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180725180009epcas4p4a1bb08f2e2c763ae043a6dd107887721
References: <201807260144.q4WK2PMA%fengguang.wu@intel.com>
        <CGME20180725180009epcas4p4a1bb08f2e2c763ae043a6dd107887721@epcas4p4.samsung.com>
        <20180725175700.GA82595@lkp-sb05.lkp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, July 26, 2018 01:57:00 AM kbuild test robot wrote:
> From: kbuild test robot <fengguang.wu@intel.com>
> 
> drivers/video/fbdev/omap2/omapfb/dss/dss_features.c:895:2-5: WARNING: Use BUG_ON instead of if condition followed by BUG.
> Please make sure the condition has no side effects (see conditional BUG_ON definition in include/asm-generic/bug.h)
> 
>  Use BUG_ON instead of a if condition followed by BUG.
> 
> Semantic patch information:
>  This makes an effort to find cases where BUG() follows an if
>  condition on an expression and replaces the if condition and BUG()
>  with a BUG_ON having the conditional expression of the if statement
>  as argument.
> 
> Generated by: scripts/coccinelle/misc/bugon.cocci
> 
> Fixes: 7378f1149884 ("media: omap2: omapfb: allow building it with COMPILE_TEST")
> Signed-off-by: kbuild test robot <fengguang.wu@intel.com>

Patch queued for 4.19 (w/ "media"->"fbdev" fixup in the patch title), thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

