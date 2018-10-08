Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B87FBC00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B4022075E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:18:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="LaRUIYzF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B4022075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbeJHR3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 13:29:06 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:44188 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbeJHR3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 13:29:05 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181008101805euoutp01d9ec563c77bb1d191abd65279ff161a5~bmsjVItdu0268802688euoutp01E
        for <linux-kernel@vger.kernel.org>; Mon,  8 Oct 2018 10:18:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181008101805euoutp01d9ec563c77bb1d191abd65279ff161a5~bmsjVItdu0268802688euoutp01E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1538993885;
        bh=Sd0bspLALVIth+6jrYTHrw0m9UpZdfogp7KhfV4/7Do=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=LaRUIYzFKEEb2refNmGnViZ+D2VNnKFRaZTj+xnza3Tz8WRLNvnlILARxotwPYpxK
         hwd5jzgZ4BeBKKSe7x96sZcvYTltXRALH8CV3DRk0u9BG7orw+9C9/9NsTMH8pl941
         BUN7ESi5xppOdtPs6YvZj27mzRFWDsQLCFwCRGPo=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181008101804eucas1p2b478416b3e50985682523299f455b3ab~bmsixT0Hs1883918839eucas1p2s;
        Mon,  8 Oct 2018 10:18:04 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 70.C9.04806.CDE2BBB5; Mon,  8
        Oct 2018 11:18:04 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181008101803eucas1p1a349978a3ea9637a7901c465bc5bff9a~bmsh9q_lm1440414404eucas1p1y;
        Mon,  8 Oct 2018 10:18:03 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181008101803eusmtrp1f1d17831694809467818966ba86e58a8~bmshs7HNp1374113741eusmtrp1b;
        Mon,  8 Oct 2018 10:18:03 +0000 (GMT)
X-AuditID: cbfec7f5-367ff700000012c6-89-5bbb2edcc903
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id E5.63.04284.BDE2BBB5; Mon,  8
        Oct 2018 11:18:03 +0100 (BST)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181008101803eusmtip2f24f9137e5f0c8a18790bbb2cac66227~bmshfFyoZ1589615896eusmtip2t;
        Mon,  8 Oct 2018 10:18:03 +0000 (GMT)
Subject: Re: [PATCH] video: fbdev: add the dependency of broadsheetfb in
 Kconfig
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date:   Mon, 8 Oct 2018 12:18:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20180727081257.3571-1-baijiaju1990@gmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUhTYRT23f3wbjh5nYoni8IVGYJmH5BpVFY/RoFISUor3MqLk9wmu2op
        FIKksTSzIHNatIGmQ9yUULfUxMIlW4IklrCU2ReJskBFnCtz3gn+e55zznPO87y8DCGppmKZ
        Ak0xq9MoC6W0iOwZWR1LdCe9kSePVtEpnfVGQcrEspdO+fDwD5Xyyd5MnyZlNsPXUNnMA4dA
        tti9O5O4IjqRxxYWlLK6gycVItXvPi9VVEvcttWOkxVoUKBHQgbwUZgdWaX0SMRIcBuCtZl5
        midLCH4OVBI8WURgN9WRW5K3lTXBxisETW1Pg3ovAuPkHNIjhonEF+FXS0ZAEIXjwdlqpwKY
        wApwmqY3F9E4FeqrzSiASbwPnnssdEAajXOgzhUfKItxBIw2ft8cF+I0mPZaQvk1yfDe1Bxc
        uQd6F5o3/QBeo2H8h5/kxaWwvjJG86bPwbrHR/A4EuYcr0N5vAucT2pIXtyAYN7XEiQWBB2u
        keArpcE7xzjF43ToMPuogFPA4fBlIYJ3EQ6PexoIviyG+1USfno/WFut9NYtva096EEG7voJ
        4hGKM2zLadiWzbAt20tEmFEMW8Kp81nuiIa9lcQp1VyJJj/phlbdjTa+h/OfY7kPDfqvDyPM
        IGmYODPDLpdQylKuTD2MgCGkUeLo3o2SOE9ZVs7qtLm6kkKWG0Y7GVIaI2590SWX4HxlMXuT
        ZYtY3VZXwAhjK1CI+by/+ljnkKqrp/9lf65Qe889YHNlXNOE6A/P+BaWlcPF2sn1BGtcv8Lr
        adz7d5Hc0RBHZM9O5a0WTJkUK23l7ZePnzmQ+s1zocgdfsrllbu8Rq4Mo6WWviYpHrmUdTcx
        O8f/eVZxlpswCp8tq8Lw/MeBsax0y9BVwR2rlORUykMJhI5T/gdeNfQQGgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupikeLIzCtJLcpLzFFi42I5/e/4Pd3berujDRpXCVism7iQyeLK1/ds
        Fif6PrBaXN41h82BxWPnrLvsHve7jzN5fN4kF8AcpWdTlF9akqqQkV9cYqsUbWhhpGdoaaFn
        ZGKpZ2hsHmtlZKqkb2eTkpqTWZZapG+XoJfxcsd71oJe5oqdvRdZGhj3MXUxcnJICJhI7G/u
        Ye5i5OIQEljKKHFmw14ghwMoISNxfH0ZRI2wxJ9rXWwQNW8ZJWbOaGQCqREWCJJ4vtQPpEZE
        QF3i9LJdrBA1fYwSZ2etAqthFkiQeDYvBaSGTcBKYmL7KkYQm1fATuLJ7CWsIDaLgIrE3Ifr
        2UBsUYEIiVsPO1ggagQlTs58AmZzClhL3Hu/nh3EZhbQk9hx/RcrhC0vsf3tHOYJjIKzkLTM
        QlI2C0nZAkbmVYwiqaXFuem5xYZ6xYm5xaV56XrJ+bmbGIHxsO3Yz807GC9tDD7EKMDBqMTD
        G+C3K1qINbGsuDL3EKMEB7OSCK/odqAQb0piZVVqUX58UWlOavEhRlOgJyYyS4km5wNjNa8k
        3tDU0NzC0tDc2NzYzEJJnPe8QWWUkEB6YklqdmpqQWoRTB8TB6dUA2P1iwSlzWwvODyjz8TO
        iDHtcTc+9d3bWffX4rbWy8Iv10l0vhQ/y/OXzYPHW+PbTYbtrYqBp+adbNrExpksHLXZZ11I
        2eRrv5wtp2Vym/94PmtPyGWLDOaTXDcEuJ9mr/qj5ygQJh7LOkHWuKXT4/Jsr9dWha6f9hnO
        fs2zd5f9HclHW/3se5RYijMSDbWYi4oTAb+pKLudAgAA
Message-Id: <20181008101803eucas1p1a349978a3ea9637a7901c465bc5bff9a~bmsh9q_lm1440414404eucas1p1y@eucas1p1.samsung.com>
X-CMS-MailID: 20181008101803eucas1p1a349978a3ea9637a7901c465bc5bff9a
X-Msg-Generator: CA
X-RootMTR: 20180727081315epcas2p42a5d377bdbf3e8e6d2e18c2d1189d9d0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180727081315epcas2p42a5d377bdbf3e8e6d2e18c2d1189d9d0
References: <CGME20180727081315epcas2p42a5d377bdbf3e8e6d2e18c2d1189d9d0@epcas2p4.samsung.com>
        <20180727081257.3571-1-baijiaju1990@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 07/27/2018 10:12 AM, Jia-Ju Bai wrote:
> broadsheetfb is a platform driver and it should not be used on x86.
> It should be used only by single ARM PXA board, so adding the 
> dependency in Kconfig.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>

Patch queued for 4.20, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
