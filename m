Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC612C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACC392186A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:38:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="QVnlJ8Z7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388046AbeLTRiY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 12:38:24 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:45619 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387798AbeLTRiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 12:38:24 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181220173822euoutp0148c72be7435e10a1eed5237b4ac9b66a~yGy0LIZfg1726017260euoutp01k
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 17:38:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181220173822euoutp0148c72be7435e10a1eed5237b4ac9b66a~yGy0LIZfg1726017260euoutp01k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1545327502;
        bh=Bqaa1MNAMexRGi/8NWIUJjAqBiRpaOWKJbu+S1PmdAM=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=QVnlJ8Z7hH1mTH4bys2RgRGwpmK7SZfv7RjBezcmQ+LLIOx6wCLKCF7Wy0JixvATP
         OR+/CoRFVn7eVJq9gFzR99COmqtw/tn0wH4zPkiES396Hb1wyamBBNVN3/xbnZmuBa
         uwBkspsZ9hc/D3n5mAp7QMHCtpCf3nJrGZrHySK4=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181220173821eucas1p119fb383e43c4e03f33bfead6428c1823~yGyzv3a7b0596605966eucas1p1z;
        Thu, 20 Dec 2018 17:38:21 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id A9.7A.04806.D83DB1C5; Thu, 20
        Dec 2018 17:38:21 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181220173820eucas1p2f2a4454f45afb3ea6ae7bcaba3b1a7dc~yGyyXtdMV0940309403eucas1p2f;
        Thu, 20 Dec 2018 17:38:20 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181220173820eusmtrp183a119cfe6c098f65fb22355f5118b9e~yGyyJnBW10360803608eusmtrp1z;
        Thu, 20 Dec 2018 17:38:20 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-f4-5c1bd38d6672
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id F9.3A.04284.C83DB1C5; Thu, 20
        Dec 2018 17:38:20 +0000 (GMT)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181220173819eusmtip115d846cc983989c453dca6a3876402f1~yGyx43OKM2216222162eusmtip1k;
        Thu, 20 Dec 2018 17:38:19 +0000 (GMT)
Subject: Re: [PATCH 2/2] fbdev: fbmem: add config option to center the
 bootup logo
To:     Peter Rosin <peda@axentia.se>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <b85de0f4-f6a1-bba6-2ca8-6ec8bc55a33f@samsung.com>
Date:   Thu, 20 Dec 2018 18:38:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20181126215725.2548-3-peda@axentia.se>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjleLIzCtJLcpLzFFi42LZduznOd3ey9IxBg8mqltc+fqezeJE3wdW
        i8u75rBZ7D00n9GBxWPagdnsHve7jzN5fN4kF8AcxWWTkpqTWZZapG+XwJUx8+ROxoKfTBWT
        Jrk3MG5l6mLk5JAQMJF4v+cJaxcjF4eQwApGidcLv7FDOF8YJVa9P8UE4XxmlPg4aQ87TMvc
        n59ZQGwhgeWMEuee8kEUvWeU6F66C6xIWCBEYv7bn2A7RAQUJRbsmsUMUsQscJxRYvu8u2wg
        CTYBK4mJ7asYuxg5OHgF7CQe7coGCbMIqEoc3LebDSQsKhAh0X9GHSTMKyAocXLmE7C9nEA3
        dHU8AhvPLGAgcWTRHFYIW15i+9s5YKskBP6zSXzp+Al1tIvEre5nbBC2sMSr41ug4jISpyf3
        sEA0TGeUePNrKZSznlFizZlj0FCyljh8/CIrhO0o8f3SYbDrJAT4JG68FYTYzCcxadt0Zogw
        r0RHmxBEtZrEhmUb2GB2de1cyQxhe0gcOrOebQKj4iwkv81C8s8sJP8sYGRexSieWlqcm55a
        bJyXWq5XnJhbXJqXrpecn7uJEZg6Tv87/nUH474/SYcYBTgYlXh4NXZJxwixJpYVV+YeYpTg
        YFYS4V1/CCjEm5JYWZValB9fVJqTWnyIUZqDRUmct5rhQbSQQHpiSWp2ampBahFMlomDU6qB
        kbUvs+U0G9eDTwejY9q7NZtUMxb+eROxpLM18sXf1ntcBWrTeEMumabcyeUNnnpwZUbVsv0q
        faZ5u0o/G67U0z6y7eSH9Z/fnprBIFe+fwtj8UydKVJabw71hX61ZrpRfkdmbuN+zXyV1+7p
        zCmBCwS1FzPNyq6cmyH+/PTm67ceVcjeeXrzqhJLcUaioRZzUXEiAGNEp3gZAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupikeLIzCtJLcpLzFFi42I5/e/4Xd2ey9IxBpcWcFlc+fqezeJE3wdW
        i8u75rBZ7D00n9GBxWPagdnsHve7jzN5fN4kF8AcpWdTlF9akqqQkV9cYqsUbWhhpGdoaaFn
        ZGKpZ2hsHmtlZKqkb2eTkpqTWZZapG+XoJcx8+ROxoKfTBWTJrk3MG5l6mLk5JAQMJGY+/Mz
        SxcjF4eQwFJGiUWHfwElOIASMhLH15dB1AhL/LnWxQZiCwm8ZZRY/SUFxBYWCJHYs/wWM4gt
        IqAosWDXLGaIORsZJY697wJzmAWOM0p8+TCPBaSKTcBKYmL7KkaQBbwCdhKPdmWDhFkEVCUO
        7tsNtkBUIELi1sMOsHJeAUGJkzOfgNmcQId2dTwCO5pZQE9ix/VfrBC2vMT2t3OYJzAKzkLS
        MgtJ2SwkZQsYmVcxiqSWFuem5xYb6hUn5haX5qXrJefnbmIExsO2Yz8372C8tDH4EKMAB6MS
        D6/GLukYIdbEsuLK3EOMEhzMSiK86w8BhXhTEiurUovy44tKc1KLDzGaAj0xkVlKNDkfGKt5
        JfGGpobmFpaG5sbmxmYWSuK85w0qo4QE0hNLUrNTUwtSi2D6mDg4pRoYRVdsDlok22bKKuEe
        HTnpRo68UMCXJ0ue+OTe7j/BprL/2EbToHQ7vjXq9te9rh4tWnDkqwxLoniRTseLtHsfeI4q
        shUWrZ7zenmp67aZc/+LL7L61KbQVhu34Df7zfd3Fxd1/nGpbnluO7/96akLcVEWxrPubzxl
        lRUYpb1RV6Dlafc226arSizFGYmGWsxFxYkA/FkuCJ0CAAA=
X-CMS-MailID: 20181220173820eucas1p2f2a4454f45afb3ea6ae7bcaba3b1a7dc
X-Msg-Generator: CA
X-RootMTR: 20181126215801epcas4p445359b3d847ebab173d1f5f17b80a22b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181126215801epcas4p445359b3d847ebab173d1f5f17b80a22b
References: <20181126215725.2548-1-peda@axentia.se>
        <CGME20181126215801epcas4p445359b3d847ebab173d1f5f17b80a22b@epcas4p4.samsung.com>
        <20181126215725.2548-3-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/26/2018 10:57 PM, Peter Rosin wrote:
> If there are extra logos (CONFIG_FB_LOGO_EXTRA) the heights of these
> extra logos are not considered when centering the first logo vertically.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>

Patch queued for 4.21, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
