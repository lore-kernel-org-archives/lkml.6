Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D93C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 07:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C04B720836
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 07:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="UJTLquNW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbfBKHOJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 02:14:09 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:51391 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfBKHOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 02:14:08 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190211071406euoutp02f5b00d7d9d534f609270f4f3084f7528~CPd4q0zpg1549015490euoutp02L
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 07:14:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190211071406euoutp02f5b00d7d9d534f609270f4f3084f7528~CPd4q0zpg1549015490euoutp02L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549869246;
        bh=RkXi9YezkbID3MO4NwJ2pFWG22B7fNBAMm5Y52Zx9LA=;
        h=Subject:To:From:Date:In-Reply-To:References:From;
        b=UJTLquNWVQtag0Z+ZYkra0wfknJqIerGMxHpAR0OEFEDi6Qyu4MMsvzypbM5ewDFs
         Q1DSib7/fXk8CmZHArtWTNPxWhtBylcuCxu5W41FRyg8p8ctZ9bZkYIavJVLfn9wX7
         +SfosRe55pC6VZ+k+R+OqTlvcQLUgMqEV1+VWmO0=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190211071405eucas1p1886924ba2a7ba23d19379e3d38ec7c36~CPd4FvxIS0441604416eucas1p1E;
        Mon, 11 Feb 2019 07:14:05 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id EA.3D.04294.DB0216C5; Mon, 11
        Feb 2019 07:14:05 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190211071404eucas1p27b5d9aea5772f38bd543102f740d0ac5~CPd3SiJnW0295702957eucas1p2w;
        Mon, 11 Feb 2019 07:14:04 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190211071404eusmtrp1fefb66b5dcff8a2f9b9e8fcc9a3875d1~CPd3EFhqf0939009390eusmtrp1k;
        Mon, 11 Feb 2019 07:14:04 +0000 (GMT)
X-AuditID: cbfec7f4-84fff700000010c6-55-5c6120bd2843
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 97.07.04128.CB0216C5; Mon, 11
        Feb 2019 07:14:04 +0000 (GMT)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190211071404eusmtip1e7e201228c6a767456b91fc3aea30874~CPd2pPUc_1366613666eusmtip1K;
        Mon, 11 Feb 2019 07:14:03 +0000 (GMT)
Subject: Re: [PATCH 0/2] Subject: [PATCH 0/2] clocksource: exynos_mct: Clear
 timer interrupt when shutting down
To:     Stuart Menefy <stuart.menefy@mathembedded.com>,
        linux-samsung-soc@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <e22c175a-d88a-81a7-9faa-42bb4fe09a22@samsung.com>
Date:   Mon, 11 Feb 2019 08:14:01 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190210225114.20110-1-stuart.menefy@mathembedded.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRju29m5bDg7bsrezKxWBgVpRsKJQhKMRvRDKEnUyNM8XshN3Zw1
        o5IK0yVlqWjDSsVuEqbztoZWzmxNy6XGiFKylCBLM7whqaQ7Vv57bu/3XvgoTFqP+1LJmgxO
        q2FTFIRY2PRytnt76wY2doflh4S5PbGOuTb0HWOczlqSMQ+5cKbPWkYwpc6nAubd+FWCqTcX
        Y/sopbk6j1D2u1oI5Vh3N6msrzqvtH2zCZQTZv8IIlq8N55LSc7ktEGhceKkmVdjRFqNx+nC
        +cPZKEdsRBQF9C54VBBmRGJKSj9A8Ku2Q8iTSQRTJZUETyYQFM23LDoid0VP5XOSN+4jmLlb
        ifPkJwLnw2F8KSWj0+GKsdH9ljf9RAAf6/qIJYOgg8E4anRjCR0KtopJ97NCOgBsVZ1u7EPH
        QlH3C5LPeIHj5rBbF9Hh0Hrrk7sWo9dD82gZxmM5fBi+I1hqBrSZhIW+UpKfNRzKW6aX55bB
        iL1hWfeDrsJ8IV9wEcHlUhPJk3wEjWUWgk/tgXZ7D750J4zeCo+tQbwcBp8rCkj+fJ7wftSL
        H8ITbjSVYLwsgdwcKZ/eAiZ7zb+2bW97MR4rocvsJAvQRtOKNU0rVjOtWM30f4ZyJKxGck6v
        Uydyup0a7lSgjlXr9JrEQFWq2owWv1LXgn3SgqxzJ2yIppDCQzLOxsVKcTZTZ1DbEFCYwlvS
        7s/GSiXxrCGL06Ye1+pTOJ0NraWECrnkzKrBGCmdyGZwJzkujdP+dQWUyDcb4Y6DDfqjbd7j
        cmvCHBGQMfRMFrIhKtLXOO1QCy6U7WcRoxKdbbCofEJkLkdzSZa+arUzeW4g+tjUbsu94k3Z
        g3POrwm9pYVJ/b8Hojr9VTGK64c8RlQlR74YfDqypZYK7cKbPFdIeV1E5szmc5dy1X5rItu0
        r/F8A34gcjZdIdQlscHbMK2O/QNO9RWhRgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBIsWRmVeSWpSXmKPExsVy+t/xu7p7FBJjDM4skLSY91nWov/xa2aL
        8+c3sFtsenyN1eLyrjlsFjPO72OyuPKhj81i86apzA4cHptWdbJ53Lm2h83j3blz7B6bl9R7
        HHp5iMnj8ya5ALYoPZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzM
        stQifbsEvYzvJ96xFazjqZj8N7iBsY2ri5GTQ0LAROLiogPsILaQwFJGie9vcyHiMhInpzWw
        QtjCEn+udbF1MXIB1bxllJi9/DIzSEJYoFCiu2srC0hCRGAnk0T3/+fMEFXTGSVWvboB1s4m
        YCjR9RaknZODV8BO4tDCLywgNouAqsShJaeAbA4OUYEYiavnGCFKBCVOznwCVsIp4CKxd+59
        sFZmAXWJP/MuMUPY8hLb386BssUlbj2ZzzSBUXAWkvZZSFpmIWmZhaRlASPLKkaR1NLi3PTc
        YiO94sTc4tK8dL3k/NxNjMBY23bs55YdjF3vgg8xCnAwKvHwfkhMiBFiTSwrrsw9xCjBwawk
        wntYLjFGiDclsbIqtSg/vqg0J7X4EKMp0G8TmaVEk/OBaSCvJN7Q1NDcwtLQ3Njc2MxCSZz3
        vEFllJBAemJJanZqakFqEUwfEwenVANjZZremR7ln7HMIibbjNnKtYSYnv+9suXV5KmMb5im
        e5lMPqPMVtl03zFwhZzZ7Fmbkws/P/kt/v1b1NL8E/vLrUSYdy0V6HH1/sRZ1HW+4tdlnjVR
        l5YXL1rhcUbUSs+Qa6Ps3SV8karP/pq6b75RWmr18mnnKRYRS/d3i10nN9xj6TbK2jtPiaU4
        I9FQi7moOBEAWwGdc8sCAAA=
X-CMS-MailID: 20190211071404eucas1p27b5d9aea5772f38bd543102f740d0ac5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190210225147epcas3p4cedebfc5692274bc6135ceabbcf2642d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190210225147epcas3p4cedebfc5692274bc6135ceabbcf2642d
References: <CGME20190210225147epcas3p4cedebfc5692274bc6135ceabbcf2642d@epcas3p4.samsung.com>
        <20190210225114.20110-1-stuart.menefy@mathembedded.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stuart

On 2019-02-10 23:51, Stuart Menefy wrote:
> When debugging suspend problems on Exynos 5260, I had a large number
> of debugging prints going to the serial port after interrupts
> had been disabled but before the timer interrupt was shutdown. This
> was long enough for a timer tick to occur, but as interrupts were
> disabled the ISR didn't run, and so the interrupt wasn't cleared.
> Later when the timer was shutdown the interrupt was left asserted and
> so the wfi at the heart of the suspend code didn't wait, causing
> the suspend to fail.
>
> Currently the code which stops the timer when it is on one-shot mode
> and the interrupt occurs is in exynos4_mct_tick_clear(), meaning if we
> called this from the shutdown code exynos4_mct_tick_stop() could be
> called twice. So first restructure the existing code, so the check for
> one-shot mode and stopping the timer is moved to the ISR, leaving
> exynos4_mct_tick_clear() just clearing the interrupt flag.
>
> Once this has been done simply call exynos4_mct_tick_clear() from
> set_state_shutdown().

This also fixes mysterious suspend failures on Odroid XU3/XU4/HC1 :)

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

> Stuart Menefy (2):
>   clocksource: exynos_mct: Move one-shot check from tick clear to ISR
>   clocksource: exynos_mct: Clear timer interrupt when shutdown
>
>  drivers/clocksource/exynos_mct.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

