Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1057C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 09:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C35920866
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 09:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="BLoGsc4p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C35920866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbeIMOJS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 10:09:18 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:52019 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727566AbeIMOJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 10:09:18 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20180913090045euoutp01275585d0e66f5325dd5b791b1ae9fec2~T6g5XFFNm0356803568euoutp01Q
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 09:00:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180913090045euoutp01275585d0e66f5325dd5b791b1ae9fec2~T6g5XFFNm0356803568euoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1536829245;
        bh=xeyvc/Tl4a4wQIdyv+WBSP2HWMNt3U+U8x0LZrWAlX8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=BLoGsc4puS8ElkZCy6KS3wlZXid0CFwP1RQhhaWI0brkZRZsH8Cj2G3D0f67fuTIJ
         sUD1/8SVB/7doAS5jx4aIXmTdLuNeXQhbiQjxZ6mmahFhYMMYPdulBsftwGjY+wYvh
         9k4aCs0FvNoM0BY6o7F2w5Wgcm4n8pEhPAqhLBI8=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180913090044eucas1p2e598bb05e5c8076034681246b6d7dbe3~T6g47eQyq3080230802eucas1p2z;
        Thu, 13 Sep 2018 09:00:44 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 3A.88.04806.C372A9B5; Thu, 13
        Sep 2018 10:00:44 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20180913090043eucas1p140e345f3f7c149e62d4cc43d6f9271dd~T6g4BlH6r2141921419eucas1p1F;
        Thu, 13 Sep 2018 09:00:43 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20180913090043eusmtrp13accb1a15c9c5ad6e4bdbe4a64f23884~T6g38DaCr1904319043eusmtrp1z;
        Thu, 13 Sep 2018 09:00:43 +0000 (GMT)
X-AuditID: cbfec7f5-367ff700000012c6-a8-5b9a273cc419
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 62.62.04128.B372A9B5; Thu, 13
        Sep 2018 10:00:43 +0100 (BST)
Received: from [106.120.43.17] (unknown [106.120.43.17]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20180913090043eusmtip101c3686d07cad99bd8ccb989ea3e6e52~T6g3rvi100065400654eusmtip1H;
        Thu, 13 Sep 2018 09:00:43 +0000 (GMT)
Subject: Re: [PATCH] drm/bridge: analogix_dp: Downgrade "Link Training"
 messages to dev_dbg
To:     Marc Zyngier <marc.zyngier@arm.com>,
        dri-devel@lists.freedesktop.org
Cc:     Archit Taneja <architt@codeaurora.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org
From:   Andrzej Hajda <a.hajda@samsung.com>
Date:   Thu, 13 Sep 2018 11:00:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180805172857.2517-1-marc.zyngier@arm.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEKsWRmVeSWpSXmKPExsWy7djP87o26rOiDdYdlbBo6njLanHl63s2
        i86JS9gtLu+aw2bx984/NgdWjzXz1jB6XO7rZfKY3TGT1eN+93Emj8+b5AJYo7hsUlJzMstS
        i/TtErgy7r19w1LwkbXiyN8HjA2M91i6GDk5JARMJPrPrGXqYuTiEBJYwSjx4PpnRgjnC5Cz
        ZT8LhPOZUeLI4idsMC0Nb/uYIRLLGSWubv3LBuG8ZZQ43T6JFaRKWCBW4tPGV2C2iICHxKGP
        3WBzmQUaGCWmbukA284moCnxd/NNsLEsAqoSyy/PZQSxRQUiJI48WAhm8woISpyc+QSsnlPA
        UuJh62qwOLOAvMT2t3OYIWxxiVtP5oN9ISGwjF3i/NaFTBDNZRIXbnxnhrjbRWLGyW+sELaw
        xKvjW9ghbBmJ05N7oMFRL9E08wozxKAORokTi5dDPW0tcfj4RaBmDqBtmhLrd+lDhB0lXnX2
        g4UlBPgkbrwVhLiHT2LStunMEGFeiY42IYhqRYn7Z7dCXSMusfTCV7YJjEqzkHw5C8lns5B8
        Ngth7wJGllWM4qmlxbnpqcXGeanlesWJucWleel6yfm5mxiBKef0v+NfdzDu+5N0iFGAg1GJ
        h/eD5sxoIdbEsuLK3EOMEhzMSiK8r9mBQrwpiZVVqUX58UWlOanFhxilOViUxHn5tNKihQTS
        E0tSs1NTC1KLYLJMHJxSDYzKdjm8czfNNL/91a6hJH1F6G53pf21zx/LhjEb7tnRvvnE19CJ
        8Y9KVczP8XLsDr+arLJgkohQ9OOKxZVl1Tez6m502mQUqFteqV8Zr76v3Ndu8ss3W9bUnfvy
        bNIesV/fJs4Tlqq/YiTtNvXc9uBdv/bG7U75Nm3xnqSMGVqOH7g/fRBebxuqxFKckWioxVxU
        nAgAxpAf9jUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKIsWRmVeSWpSXmKPExsVy+t/xu7rW6rOiDSbNVLNo6njLanHl63s2
        i86JS9gtLu+aw2bx984/NgdWjzXz1jB6XO7rZfKY3TGT1eN+93Emj8+b5AJYo/RsivJLS1IV
        MvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/TtEvQy7r19w1LwkbXiyN8H
        jA2M91i6GDk5JARMJBre9jF3MXJxCAksZZRYtu0dI0RCXGL3/LfMELawxJ9rXWwQRa8ZJSZv
        PsMOkhAWiJX4tPEVK4gtIuAhcehjNyNIEbNAE6NEy+orrBAdPYwS+y9NBxvLJqAp8XfzTTYQ
        m1fATqLn+hsmEJtFQFVi+eW5YDWiAhESq5e/YIWoEZQ4OfMJ2K2cApYSD1tXg9UwC6hL/Jl3
        iRnClpfY/nYOlC0ucevJfKYJjEKzkLTPQtIyC0nLLCQtCxhZVjGKpJYW56bnFhvpFSfmFpfm
        pesl5+duYgRG2bZjP7fsYOx6F3yIUYCDUYmH94XSzGgh1sSy4srcQ4wSHMxKIryv2YFCvCmJ
        lVWpRfnxRaU5qcWHGE2BnpvILCWanA9MAHkl8YamhuYWlobmxubGZhZK4rznDSqjhATSE0tS
        s1NTC1KLYPqYODilGhj5/iuwLrXP5fn8fUZhnWzygl288Utf8QVssv0unHrXVuBLoN1lQcGV
        8i8TKmO2e5t5v/rxxizeuX1qkfafS8lLGZQf7I/fdnLStPwtvjar/mdb9D2JqUmYeqf7ve3r
        KGuHMt199ee0TFduv2bWdHhr5GLm+Poog/Otj7rVFCIUH54rjL/1NlWJpTgj0VCLuag4EQBo
        1KKeyAIAAA==
Message-Id: <20180913090043eucas1p140e345f3f7c149e62d4cc43d6f9271dd~T6g4BlH6r2141921419eucas1p1F@eucas1p1.samsung.com>
X-CMS-MailID: 20180913090043eucas1p140e345f3f7c149e62d4cc43d6f9271dd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180805172917epcas4p1635a7c069cb57b08bbd6891a29195d26
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180805172917epcas4p1635a7c069cb57b08bbd6891a29195d26
References: <CGME20180805172917epcas4p1635a7c069cb57b08bbd6891a29195d26@epcas4p1.samsung.com>
        <20180805172857.2517-1-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.08.2018 19:28, Marc Zyngier wrote:
> The Analogix DP bridge driver is pretty verbose, and outputs
> things like
>
> [  619.414067] rockchip-dp ff970000.edp: Link Training Clock Recovery success
> [  619.429233] rockchip-dp ff970000.edp: Link Training success!
>
> each time the display gets unblanked. While it is good to know
> that the device is behaving correctly, users already know that
> because they can see some video output.
>
> Let's keep these messages for cases where we need to actually
> debug the driver (we have dynamic debug to enable them at runtime
> if need be), and let's keep the kernel quiet otherwise.
>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Queued to drm-misc-next.

Regards
Andrzej

