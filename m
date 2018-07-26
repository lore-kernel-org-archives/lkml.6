Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 377BBC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 09:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC9C320846
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 09:58:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="NIWakeVe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC9C320846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbeGZLOK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 07:14:10 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:47555 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728899AbeGZLOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 07:14:10 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180726095802euoutp026b9626da10b656f638ba28320f7404f7~E4r7UdyaU2013820138euoutp02D;
        Thu, 26 Jul 2018 09:58:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180726095802euoutp026b9626da10b656f638ba28320f7404f7~E4r7UdyaU2013820138euoutp02D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1532599082;
        bh=ct1PzPbf2h+Amzu5t6JaSGBdg/OJuSLLaXottk4TWas=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=NIWakeVeyonco1n1g89SEsVyO9mtqgrE2K01G1/jIiwFolAxp7nfIF2eAyiPo3F2A
         TQCen+1MQm+FPe2oAtKduPHGhm2fyBVijVXejJRu6ixwxJa9mZO0GsNYwMTU571cUF
         DOWv2l0drax3jL0Zco8FhqAoQJuh2CUB6bb9UiHM=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180726095801eucas1p1557f2567c74278b9989c24dc8b3cc139~E4r6fZFjU2066020660eucas1p1D;
        Thu, 26 Jul 2018 09:58:01 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 63.79.04627.92B995B5; Thu, 26
        Jul 2018 10:58:01 +0100 (BST)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180726095800eucas1p150965e374734236f81450395edf5f163~E4r5n66JE1941419414eucas1p1U;
        Thu, 26 Jul 2018 09:58:00 +0000 (GMT)
X-AuditID: cbfec7f2-0edff70000021213-e6-5b599b2910b8
Received: from eusync1.samsung.com ( [203.254.199.211]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id E2.FE.04183.82B995B5; Thu, 26
        Jul 2018 10:58:00 +0100 (BST)
Received: from amdc3058.localnet ([106.120.53.102]) by eusync1.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PCG00MA4X0OKU90@eusync1.samsung.com>; Thu, 26 Jul
        2018 10:58:00 +0100 (BST)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Pankaj Dubey <pankaj.dubey@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Inki Dae <inki.dae@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v2] Documentation: dt-bindings: Explicitly mark Samsung
 Exynos SoC bindings as unstable
Date:   Thu, 26 Jul 2018 11:57:59 +0200
Message-id: <9466376.zSd3pI8yRi@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <20180528191327.23772-1-krzk@kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLKsWRmVeSWpSXmKPExsWy7djPc7qasyOjDbZsF7B4MG8bm8XfScfY
        La5/ec5qMf/IOVaLSfcnsFj0P37NbHH+/AZ2i02Pr7FaXN41h81ixvl9TBZrj9xlt1h6/SKT
        xanrn9ksFm39wm7RuvcIu8XhN+2sFjMmv2RzEPRYM28No8fvX5MYPTat6mTz2Lyk3uPKiSZW
        j74tqxg9Pm+SC2CP4rJJSc3JLEst0rdL4Mo4v2klS8EX7orer2+ZGxifcHYxcnJICJhIrJrx
        nrWLkYtDSGAFo8S5ho/MEM5nRon1J7+yw1Q9unaWBSKxjFHi/ZFtUC2/GSVeHdvAClLFJmAl
        MbF9FSOILSKgKXH973ewImaBKywSjRvamEASwgK5Eiu3rmABsVkEVCWOPpwBFucFarj2eRXY
        IFEBL4kt+9rB4pwCphITV69nhKgRlPgx+R5YL7OAvMS+/VNZIWwdibPH1jFCnNrPLnH9XWkX
        IweQ7SKxs0MNIiws8er4FqhvZCQuT+4G+0ZCYDqjxJtfS6Gc9YwSa84cY4KospY4fPwi1AI+
        iUnbpjNDDOWV6GgTgijxkFg+/SE0WDoYJS73NzBNYJSZheTWWUhunYXk1gWMzKsYxVNLi3PT
        U4sN81LL9YoTc4tL89L1kvNzNzECE9Hpf8c/7WD8einpEKMAB6MSD6/GnIhoIdbEsuLK3EOM
        EhzMSiK8y9Mio4V4UxIrq1KL8uOLSnNSiw8xSnOwKInzSvsAVQukJ5akZqemFqQWwWSZODil
        GhiX+8uuPPnL0I/3cnL29S39m9fdyjFeBuSlK/TKpN/bVrtcoXaZZbTSmZ4AoZDWNe8lDx5O
        LnuUMfNf6MZVoj+dfv+Yptj72i9R4kSJ2f4jjr909wslBGrP/3/VqGr9tsPro2Vldaa+jVSt
        yGfqPCOY2ZK48u610rvPUgUV1tWJBf6p3x1/TImlOCPRUIu5qDgRAEIy2blAAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmkeLIzCtJLcpLzFFi42I5/e/4ZV2N2ZHRBgffqVg8mLeNzeLvpGPs
        Fte/PGe1mH/kHKvFpPsTWCz6H79mtjh/fgO7xabH11gtLu+aw2Yx4/w+Jou1R+6yWyy9fpHJ
        4tT1z2wWi7Z+Ybdo3XuE3eLwm3ZWixmTX7I5CHqsmbeG0eP3r0mMHptWdbJ5bF5S73HlRBOr
        R9+WVYwenzfJBbBHcdmkpOZklqUW6dslcGWc37SSpeALd0Xv17fMDYxPOLsYOTkkBEwkHl07
        ywJiCwksYZSYdtCri5ELyP7LKPFy+XRWkASbgJXExPZVjCC2iICmxPW/31lBipgFrrBIbLu6
        hA0kISyQK7Fy6wqwSSwCqhJHH85gArF5gRqufV4FNkhUwEtiy752sDingKnExNXrGSG2dTFK
        XOzrYoZoEJT4Mfke2CBmAXmJffunskLYWhLrdx5nmsDIPwtJ2SwkZbOQlC1gZF7FKJJaWpyb
        nltspFecmFtcmpeul5yfu4kRGEXbjv3csoOx613wIUYBDkYlHt4LMyOihVgTy4orcw8xSnAw
        K4nwLk+LjBbiTUmsrEotyo8vKs1JLT7EKM3BoiTOe96gMkpIID2xJDU7NbUgtQgmy8TBKdXA
        GBq9I3ThjE0PrZeHZgi5L/0y4UoNn+ivRY86H09/MkdkllvfabYL0gpZ+t9zOx63Xa79YFQq
        ZL0h+o3AfmYp9QMxB255GaXct7/wa74RJ4vxVdW+2Ml6ElPX/3FJunFE50evUZTkgykqr3Ye
        eCbyoY3fLYDTsD5tiVPdurkbr6rVWGttfrVwvxJLcUaioRZzUXEiAFKFHKieAgAA
X-CMS-MailID: 20180726095800eucas1p150965e374734236f81450395edf5f163
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180528191404epcas3p241196d099756ea7e310cff70d298c4c9
References: <CGME20180528191404epcas3p241196d099756ea7e310cff70d298c4c9@epcas3p2.samsung.com>
        <20180528191327.23772-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, May 28, 2018 09:13:27 PM Krzysztof Kozlowski wrote:
> From: Marek Szyprowski <m.szyprowski@samsung.com>
> 
> Samsung Exynos SoCs and boards related bindings evolved since the initial
> introduction, but initially the bindings were minimal and a bit incomplete
> (they never described all the hardware modules available in the SoCs).
> Since then some significant (not fully compatible) changes have been
> already committed a few times (like gpio replaced by pinctrl, display ddc,
> mfc reserved memory, some core clocks added to various hardware modules,
> added more required nodes).
> 
> On the other side there are no boards which have device tree embedded in
> the bootloader. Device tree blob is always compiled from the kernel tree
> and updated together with the kernel image.
> 
> Thus to avoid further adding a bunch of workarounds for old/missing
> bindings, make development of new platforms easier and allow to make
> cleanup of the existing code and device tree files, lets mark some
> Samsung Exynos SoC platform bindings as unstable. This means that
> bindings can may change at any time and users should use the dtb file
> compiled from the same kernel source tree as the kernel image.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

