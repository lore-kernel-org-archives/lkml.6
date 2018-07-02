Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1462AC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C37D124153
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:59:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="liJegVJ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C37D124153
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752582AbeGBN67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 09:58:59 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:46016 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752040AbeGBN64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 09:58:56 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20180702135854euoutp01845dfc828c29886edd58c2a38ed166d0~9kfYXnTJu1828118281euoutp01k
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jul 2018 13:58:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180702135854euoutp01845dfc828c29886edd58c2a38ed166d0~9kfYXnTJu1828118281euoutp01k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1530539934;
        bh=rywO0BY6omXfh80MIKwwQ/MlE2s4jrCG2lix2o7hp7U=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=liJegVJ9RPzZSb5zZ2daGE0TyHMg0WBcJJHKOYWg/3nK+mtpgFmnlWemYCxohzvLV
         sg0hC3NCF9IJZQXIyc5ZkA8WKGuslflvS4repmm4qRk8yd9E5+YVea3zqHrX4svu0i
         wmaw9NchByBBDZNB2D1NQlF2sgstY6DR1+X/n5Fo=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180702135853eucas1p29b1e8b694ef156fe4670499217b5bed7~9kfXXIlF02077620776eucas1p24;
        Mon,  2 Jul 2018 13:58:53 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 65.92.10409.D9F2A3B5; Mon,  2
        Jul 2018 14:58:53 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20180702135852eucas1p21c0de19bcd68cec1eba09b919d253859~9kfWkOk4o2496824968eucas1p2F;
        Mon,  2 Jul 2018 13:58:52 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20180702135852eusmtrp17b11a1a76639d51200738e63621062cb~9kfWT8lBi2144421444eusmtrp1M;
        Mon,  2 Jul 2018 13:58:52 +0000 (GMT)
X-AuditID: cbfec7f5-f95739c0000028a9-e6-5b3a2f9d1c53
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id DF.9B.04178.C9F2A3B5; Mon,  2
        Jul 2018 14:58:52 +0100 (BST)
Received: from [127.0.0.1] (unknown [106.210.244.197]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20180702135851eusmtip15e7f2ac21ff0508012ed688ca2c41dbb~9kfVSKgg92519425194eusmtip1p;
        Mon,  2 Jul 2018 13:58:51 +0000 (GMT)
Subject: Re: [PATCH] ieee802154: add rx LQI from userspace
To:     =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Romuald Cari <romuald.cari@devialet.com>,
        linux-wpan@vger.kernel.org
Cc:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@osg.samsung.com>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Cl=c3=a9ment_Peron?= <clement.peron@devialet.com>
From:   Stefan Schmidt <s.schmidt@samsung.com>
Date:   Mon, 2 Jul 2018 15:58:40 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:52.0) Gecko/20100101
        Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAJiuCcdCE42FvWc0svNpQDD0rczYi7Xz-RW5PbbjAuvZe9dgwg@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMKsWRmVeSWpSXmKPExsWy7djP87pz9a2iDY6dYbc41GBu0b7wPqvF
        nPMtLBaXd81hs7gzeRmLxbEFYha3511msThy9hSLxYXmf6wOnB5bVt5k8tj6LcJj56y77B5b
        +oHE501yAaxRXDYpqTmZZalF+nYJXBkn5/ayFExnrjjXOY2lgXErUxcjB4eEgInEjDe8XYxc
        HEICKxglvn5dyA7hfGGU+Pj5ADOE85lRYu/3d0AdnGAdhzcehqpazijxet5lqKrXjBLdy5+z
        glQJC1hJnL/wmRUkISLQzCjR27+SBcRhFvjGKHGncxvYLDYBHYn3excygtgsAioS7S/fg9mi
        AqESGy5vZAaxeQUEJU7OfMICYnMKBEosWXYbzGYWkJdo3jqbGcIWl2j6shJsm4TAPnaJTQ2P
        oJrLJN7e2soKcbiLxMS+NSwQtrDEq+Nb2CFsGYnTk3tYIJonM0pMbD3NBuGsZpS413KQHRJQ
        1hIv37OAmMwCmhLrd+lD9DpKfDj2iBGigk/ixltBiHv4JCZtm84MEeaV6GgTgqhWlnhw5hMb
        hC0pca6rn3kCo9IsJF/OQvLZLCSfzULYu4CRZRWjeGppcW56arFxXmq5XnFibnFpXrpecn7u
        JkZgUjr97/jXHYz7/iQdYhTgYFTi4a2Qt4oWYk0sK67MPcQowcGsJMK7TRUoxJuSWFmVWpQf
        X1Sak1p8iFGag0VJnDdOoy5KSCA9sSQ1OzW1ILUIJsvEwSnVwJgZaDzvp/rXqd5dD7mP9Co/
        nLVp/Y57jIrnDs7zUZt+0ydK+O3+r+LiG5QKf9wRuLkosSfBPldWW+tQxHbh8NdRx557161O
        eFPPEXpROj3p+e6Xn4+EZbE/WLHKxiDxGVfxtoiG5r9hDxczecRNjbh3vmgTw8dte74ukzX8
        E3DunJrQnEempg+UWIozEg21mIuKEwHw+7wvRgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCIsWRmVeSWpSXmKPExsVy+t/xu7pz9K2iDXb847E41GBu0b7wPqvF
        nPMtLBaXd81hs7gzeRmLxbEFYha3511msThy9hSLxYXmf6wOnB5bVt5k8tj6LcJj56y77B5b
        +oHE501yAaxRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF
        +nYJehkn5/ayFExnrjjXOY2lgXErUxcjJ4eEgInE4Y2H2bsYuTiEBJYySkx52sXcxcgBlJCU
        +PovG6JGWOLPtS42iJqXjBJPLm9lA0kIC1hJnL/wmRXEFhFoZpR4fACsiFngB6PEvmPXWSE6
        rjBKbNz0D6yDTUBH4v3ehYwgG3gF7CT624NBwiwCKhLtL98zgtiiAqESO9ZtBruOV0BQ4uTM
        JywgNqdAoMSSZbfBbGYBM4l5mx8yQ9jyEs1bZ0PZ4hJNX1ayTmAUmoWkfRaSlllIWmYhaVnA
        yLKKUSS1tDg3PbfYUK84Mbe4NC9dLzk/dxMjMAa3Hfu5eQfjpY3BhxgFOBiVeHgr5K2ihVgT
        y4orcw8xSnAwK4nwblMFCvGmJFZWpRblxxeV5qQWH2I0BXpuIrOUaHI+MD3klcQbmhqaW1ga
        mhubG5tZKInznjeojBISSE8sSc1OTS1ILYLpY+LglGpgtHTnDtzvuarsUeO9yqW5STfZck8e
        tT3pP2/+tQi2y1tlLwfsyw+v3dJ5WCBi5R+BwiP+jpdKlVbp2XhP9p9e7DL12oaO57INdV0V
        9p8C2taKsPPMezCLcT6XwU3PDWoWf167a9UsK1lnxdjOXfZDr7Wk7KXfU/NVsX8dHJlUCn1Y
        1s7O/citxFKckWioxVxUnAgAJYtWedcCAAA=
Message-Id: <20180702135852eucas1p21c0de19bcd68cec1eba09b919d253859~9kfWkOk4o2496824968eucas1p2F@eucas1p2.samsung.com>
X-CMS-MailID: 20180702135852eucas1p21c0de19bcd68cec1eba09b919d253859
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180702132818epcas5p3c957729b84dc7cb6c779ef8468f14ef8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180702132818epcas5p3c957729b84dc7cb6c779ef8468f14ef8
References: <20180607140802.22666-1-peron.clem@gmail.com>
        <CGME20180702132818epcas5p3c957729b84dc7cb6c779ef8468f14ef8@epcas5p3.samsung.com>
        <CAJiuCcdCE42FvWc0svNpQDD0rczYi7Xz-RW5PbbjAuvZe9dgwg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.


On 02/07/2018 15:28, Clément Péron wrote:
> Could you review it please ?
>
Yes, I will. Sorry for the delay, I am just back from 4 weeks parental 
leave. A few thousand mails top go through in total.

If you could bare with me for a few more days that would be appreciated. 
I have all the patches I need to review here marked in my local inbox 
already.

regards
Stefan Schmidt

