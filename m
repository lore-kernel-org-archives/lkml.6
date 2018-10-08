Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73966C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E39C20652
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="WfwPPnVS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E39C20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbeJHSGC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 14:06:02 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:57551 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbeJHSGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 14:06:02 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181008105452euoutp0106789596a2d3c6e1aae95c4a484e8c9e~bnMrcxwEY2162221622euoutp01n
        for <linux-kernel@vger.kernel.org>; Mon,  8 Oct 2018 10:54:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181008105452euoutp0106789596a2d3c6e1aae95c4a484e8c9e~bnMrcxwEY2162221622euoutp01n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1538996092;
        bh=qFr4F0IGVZAk4S9TuVxApbtGI4qUcaWRlKDqdufBqdA=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=WfwPPnVScSUFt5H68OEzqT+X73FGj8vpoavtg21QuZVEe9YXYicOBQ1iYh2YW9Eq/
         zOW+d4FYk3EKvLlMtIqUcv+XyUmniI7YxJ4K8SqckRA0LnEdRAVbIisier21TrIWMt
         p7m3D63tzcouXt70BxQySg9rerStW4eRVV9zgiiA=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181008105452eucas1p213b18605d3b88e0c4aacb6d88f6802fa~bnMq9sZ-70135801358eucas1p2g;
        Mon,  8 Oct 2018 10:54:52 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 42.5A.04294.B773BBB5; Mon,  8
        Oct 2018 11:54:51 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181008105451eucas1p27537ee0fa142488ae041844919037224~bnMqMgl581320913209eucas1p2d;
        Mon,  8 Oct 2018 10:54:51 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181008105451eusmtrp189c607b279557730a3cff1aed60412e2~bnMp77Nd72442324423eusmtrp1E;
        Mon,  8 Oct 2018 10:54:51 +0000 (GMT)
X-AuditID: cbfec7f4-84fff700000010c6-b1-5bbb377b92d6
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 0C.98.04284.B773BBB5; Mon,  8
        Oct 2018 11:54:51 +0100 (BST)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181008105450eusmtip1881c17ed3064f99809a31d54bf4b2016~bnMpsT4al3026230262eusmtip1M;
        Mon,  8 Oct 2018 10:54:50 +0000 (GMT)
Subject: Re: [PATCH] video: fbdev: arcfb: mark expected switch fall-through
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Jaya Kumar <jayalk@intworks.biz>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date:   Mon, 8 Oct 2018 12:54:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20181003115044.GA10786@embeddedor.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsWy7djP87rV5rujDab9tLS48vU9m8XWPaoW
        0479Y7I40feB1eLyrjlsDqwe6w6qemxr3sfqcb/7OJPH501yASxRXDYpqTmZZalF+nYJXBlt
        DfPYCtYwVyzYtoSpgfERUxcjJ4eEgInEgkO9rF2MXBxCAisYJS5NmsIO4XxhlJj7ZyszhPOZ
        UWL/9x8sMC1/53awgdhCAssZJXYsEoMoeg/U8fQyI0hCWMBb4smnLWC2iICRxOwZ3WA7mAWa
        GCVO3+8FS7AJWElMbF8FZrMIqEh0bbwKZHNwiApESPSfUQcJ8woISpyc+QRsMSfQ4qOfD7CC
        2MwCBhJHFs2BsuUltr+dA3aphEA7u8TNif+YIJrLJB5vvsoMcbWLxKK+RVBPC0u8Or6FHcKW
        kTg9uYcFonk6o8SbX0uhnPWMEmvOHIPqsJY4fPwiK4TtKPF030JmkEslBPgkbrwVhLiCT2LS
        tulQYV6JjjYhiGo1iQ3LNrDB7OrauRLqHg+J7f0NbBMYFWch+XMWkt9mIfltASPzKkbx1NLi
        3PTUYqO81HK94sTc4tK8dL3k/NxNjMB0cvrf8S87GHf9STrEKMDBqMTDuyJgV7QQa2JZcWXu
        IUYJDmYlEV7R7UAh3pTEyqrUovz4otKc1OJDjNIcLErivMvmbYwWEkhPLEnNTk0tSC2CyTJx
        cEo1MK56fMhZ6kTOnsOS0nLPur+d69l5OCj31fKPPUfyXvzud2254aHz9n/Y8f+PxeLffpw6
        yeDdnxkiRZN7DXf1rn7QqFlxRP6Abah1jYR2e8m9HXIOfK879h8xTfr5LMg/gF1A47Df0pvP
        VO79+BOm8fHG5M0bvkxVrPlg/T/HvXRCfMGC+cc4vWKVWIozEg21mIuKEwF6hZbMIwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKIsWRmVeSWpSXmKPExsVy+t/xu7rV5rujDdZd5LC48vU9m8XWPaoW
        0479Y7I40feB1eLyrjlsDqwe6w6qemxr3sfqcb/7OJPH501yASxRejZF+aUlqQoZ+cUltkrR
        hhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehltDfPYCtYwVyzYtoSpgfERUxcj
        J4eEgInE37kdbF2MXBxCAksZJY6vusHexcgBlJCROL6+DKJGWOLPtS6omreMEid3XGMGSQgL
        eEs8+bSFEcQWETCSmD2jmxWiqJ1RovXjN3YQh1mgiVHiwuFFYFVsAlYSE9tXgdm8AnYSffM6
        wCaxCKhIdG28ChYXFYiQuPWwgwWiRlDi5MwnYDYn0KlHPx9gBbGZBfQkdlz/BWXLS2x/O4d5
        AqPgLCQts5CUzUJStoCReRWjSGppcW56brGhXnFibnFpXrpecn7uJkZglGw79nPzDsZLG4MP
        MQpwMCrx8Ab47YoWYk0sK67MPcQowcGsJMIruh0oxJuSWFmVWpQfX1Sak1p8iNEU6ImJzFKi
        yfnACM4riTc0NTS3sDQ0NzY3NrNQEuc9b1AZJSSQnliSmp2aWpBaBNPHxMEp1cBYujh3VuTN
        Qre3Uz5PXWt7Tilb61BLXvF+xqb8QKkGF3bfH53zC60XbLWOrQ0LuzfJ3GnzknU71A4Ynd29
        dXJpygrNUD/pnx3aM8IkDa8Gvvj0L7E8VNR9CW/bC8+Kj8balyI3sm+P2nBIIdTt0m3mA1xX
        ed9kcL28Nzmr6mIMs+DnE4IPPxsqsRRnJBpqMRcVJwIA5gn9cqgCAAA=
Message-Id: <20181008105451eucas1p27537ee0fa142488ae041844919037224~bnMqMgl581320913209eucas1p2d@eucas1p2.samsung.com>
X-CMS-MailID: 20181008105451eucas1p27537ee0fa142488ae041844919037224
X-Msg-Generator: CA
X-RootMTR: 20181003115120epcas1p1e0cbeaddf6b54f8db18abf2b089e13e0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181003115120epcas1p1e0cbeaddf6b54f8db18abf2b089e13e0
References: <CGME20181003115120epcas1p1e0cbeaddf6b54f8db18abf2b089e13e0@epcas1p1.samsung.com>
        <20181003115044.GA10786@embeddedor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/03/2018 01:50 PM, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Addresses-Coverity-ID: 115017 ("Missing break in switch")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Patch queued for 4.20, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
