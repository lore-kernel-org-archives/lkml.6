Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A3AECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 15:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0163520883
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 15:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="NQghwJjE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0163520883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbeIQVRN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 17:17:13 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:37243 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727833AbeIQVRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 17:17:13 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20180917154917euoutp01d63eff05c1363cc71394cfe17e015ee1~VOqvIgSKm1123411234euoutp01s
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 15:49:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180917154917euoutp01d63eff05c1363cc71394cfe17e015ee1~VOqvIgSKm1123411234euoutp01s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1537199357;
        bh=tah42o+xDB4cZVjpjfZLivmqAJQthQhh90v9gB/0iyk=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=NQghwJjEKlCdevZebXjou9hPBgerQEpnyIfDe4ny8j1ca2rOj197MnNHg74myAPDv
         IOfGnq1qjg4wkAIuFvb9qi6SnYIlNwH3kKdR7WJe4rDs9UG+dZ7QikPeUHKB3yuBWN
         q1p4BqA0AgAc1r/StZkSwHP97phQ7+5BfTbFvc8E=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180917154916eucas1p1ccd2099075a55cb3ab98d8e23e3d7e73~VOqueptMq0999009990eucas1p1S;
        Mon, 17 Sep 2018 15:49:16 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id C0.88.04294.CFCCF9B5; Mon, 17
        Sep 2018 16:49:16 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20180917154915eucas1p138e4193dc80c976f356e94589f6e4a40~VOqtgu4ye0974509745eucas1p1R;
        Mon, 17 Sep 2018 15:49:15 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20180917154915eusmtrp27e221f816b3848d538b1566a936ac6ba~VOqtPYmDz0405204052eusmtrp20;
        Mon, 17 Sep 2018 15:49:15 +0000 (GMT)
X-AuditID: cbfec7f4-835ff700000010c6-50-5b9fccfcfd65
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 59.7A.04128.BFCCF9B5; Mon, 17
        Sep 2018 16:49:15 +0100 (BST)
Received: from [106.120.51.18] (unknown [106.120.51.18]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20180917154914eusmtip160a95e129de05c39be98ad28c6e59726~VOqsyCsXj0114201142eusmtip1Q;
        Mon, 17 Sep 2018 15:49:14 +0000 (GMT)
Subject: Re: [PATCH v2 3/4] crypto: s5p-sss: Minor code cleanup
To:     Christoph Manszewski <c.manszewski@samsung.com>,
        linux-crypto@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
From:   Kamil Konieczny <k.konieczny@partner.samsung.com>
Date:   Mon, 17 Sep 2018 17:49:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180917151009eucas1p145fdde4a56241418a49a1da14c5bdb02~VOIkhD_S60202502025eucas1p1F@eucas1p1.samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHe3fOzs6WG69T2YO3aqDVSK2IOmBlkeG+FEoE0hBderykTtmm
        pp8EtWxeEA3yfinsoqSlpqYiqekYSjO1i0ZaIRXaiNQQw1w7Hiu//Z7n//7/z/PASxPyTqE7
        naAzsnqdNklJScjOkTWr3/pYnebgZI6MeVzeKmTMvY2IqbbmkkzBgidjtT4SMXOzawJmsqea
        Ysqt/QLG/iuHOCVWdzyYFqg7n/mo25puUOqNhpukurijCamX27xDqUuS4zFsUkI6qw84GSWJ
        H63qp1JfEFcLvo5T2SiPMCExDfgI9FdVi0xIQsvxfQRT3W0UX6wgqF16RfLFskP50vjPklfT
        h3jhHoLcmXnECXJsQzDXHMmxCw6Ch6/fizh2xRcgb3l0cwaBawVQODxNcQKFj8GnrjEBxyT2
        gcKJ4U2DGw6H5x8aNkOl2BksFfMkx2KcAT8sfZvvCayAmfm6Ld4FXbZqghsAeEQEC0VzDgPt
        MKeDqeUsv3UwjNy9jnh2gQVzh4hnT7A/5XPAkd/75LOIz8lFUFN2e0sIhCHzSyGXSeD90NoT
        wCHg01AxmsmjDN7anPltZFDaeYvg21LIvybnM/yg1j4m5NkDTPYWYQlSVm67sXLbXZXb7qr8
        P7YekU1IwaYZkuNYw2Edm+Fv0CYb0nRx/tEpyW3I8ZtGN8wr3ahn/fIgwjRSOknr6+s0cqE2
        3ZCZPIiAJpSuUkLmaEljtJlZrD4lUp+WxBoGkQdNKhVSmSpWI8dxWiObyLKprP6vKqDF7tlI
        P9B8vrRk9acq5DdyC/l+Tq5gfbMnmvdQGpXvqqXANWNf6vziTIR3VtjqCao7zFgcMHBAthQ1
        3vQt1im8LDRfO+nV3rpo0yS2/4o8E2zp+ijtsBUIo81BQ5FFbya9rlzc2f5OErA31x5oChK7
        HF0yTY/fUQmms3bM6owRU/W7laQhXntIRegN2j9sup29SQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsVy+t/xu7q/z8yPNujdzWmxccZ6Vovju5cy
        Wsw538Ji0f1KxuL8+Q3sFvfv/WSyuLxrDpvFjPP7mCz+/2pmduD02LLyJpPHtgOqHptWdbJ5
        /Fs4hcWjb8sqRo/Pm+QC2KL0bIryS0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1jrYxMlfTt
        bFJSczLLUov07RL0Mk7P3sdWcI65ovvFBbYGxlbmLkZODgkBE4nWuXsYuxi5OIQEljJKfLq8
        mBUiIS3ReHo1E4QtLPHnWhcbRNFrRomL3x6DJYQF7CXWXrvLDmKLCARLPHgwgwWkiFlgHpPE
        wSNvmCA6OpgkNnxeygJSxSZgLvFo+xmwbl4BN4lzd6+DrWMRUJXouXQUbJKoQITE6uUvWCFq
        BCVOznwC1sspUC7x8eQesF5mAXWJP/MuMUPY4hK3nsyHistLbH87h3kCo9AsJO2zkLTMQtIy
        C0nLAkaWVYwiqaXFuem5xUZ6xYm5xaV56XrJ+bmbGIExue3Yzy07GLveBR9iFOBgVOLh/bFo
        frQQa2JZcWXuIUYJDmYlEV5mPqAQb0piZVVqUX58UWlOavEhRlOg5yYyS4km5wPTRV5JvKGp
        obmFpaG5sbmxmYWSOO95g8ooIYH0xJLU7NTUgtQimD4mDk6pBkYF4Y0bdG5u9+y9NvdM2tSp
        91avlp9gdNcvfvYcF4MjqZMSamf+el6wN1LLf5Vga409y4udG3I+Ws498+R0wIVn0TccTBe9
        1DggoFHdOmXlxLg3ThMvsZlcORiWut8pl4XlspXgxONzdc2nqE4tUlXOnsqx/UXJzCBP3cq0
        +dXrdrRd8FdoyOxRYinOSDTUYi4qTgQAgYbDUN8CAAA=
Message-Id: <20180917154915eucas1p138e4193dc80c976f356e94589f6e4a40~VOqtgu4ye0974509745eucas1p1R@eucas1p1.samsung.com>
X-CMS-MailID: 20180917154915eucas1p138e4193dc80c976f356e94589f6e4a40
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180917151009eucas1p145fdde4a56241418a49a1da14c5bdb02
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180917151009eucas1p145fdde4a56241418a49a1da14c5bdb02
References: <1537196970-5987-1-git-send-email-c.manszewski@samsung.com>
        <CGME20180917151009eucas1p145fdde4a56241418a49a1da14c5bdb02@eucas1p1.samsung.com>
        <20180917151009eucas1p145fdde4a56241418a49a1da14c5bdb02~VOIkhD_S60202502025eucas1p1F@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17.09.2018 17:09, Christoph Manszewski wrote:
> Modifications in s5p-sss.c:
> - remove unnecessary 'goto' statements (making code shorter),
> - change uint_8 and uint_32 to u8 and u32 types (for consistency in the
> driver and making code shorter),
> 
> Signed-off-by: Christoph Manszewski <c.manszewski@samsung.com>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Acked-by: Kamil Konieczny <k.konieczny@partner.samsung.com>

Thanks!
Kamil
