Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 576C9C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2994E218EA
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="V1Udsm1I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388545AbeLTSG2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:06:28 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:49826 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730541AbeLTSG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 13:06:28 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181220180626euoutp018c67f3fb83dea36ca31bc7e24f74274c~yHLU_0Jeg0257402574euoutp01D
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 18:06:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181220180626euoutp018c67f3fb83dea36ca31bc7e24f74274c~yHLU_0Jeg0257402574euoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1545329186;
        bh=syGe9JQqjDEj9rUt2M+PXUDbcfwedeapHev3lopgfLY=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=V1Udsm1IVaJLtALUzAwrOBKMpzna8Mx4J/ZqC81+oDw91O7Bh+7PrOQh/UqGp/VYH
         0V23pxZNSfUVSRRUZ3lk1oiJf6dsfEThDwCl89KDAlAGgXHNGmK2j6KXX4Sho3XICW
         UtODNlgFscx2YiC8HbCKtpHmG69B9P8IDYpaGBxY=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181220180626eucas1p27b15d170182ff262a568050dfade308b~yHLUr1s730120501205eucas1p22;
        Thu, 20 Dec 2018 18:06:26 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 6E.06.04294.22ADB1C5; Thu, 20
        Dec 2018 18:06:26 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181220180625eucas1p2f7c99078b6bb7d2665af92012e2422cf~yHLTwNHZ80119401194eucas1p21;
        Thu, 20 Dec 2018 18:06:25 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181220180625eusmtrp24cfa4e32b5b0ec52b1db06694031aee9~yHLTiArji2041620416eusmtrp2C;
        Thu, 20 Dec 2018 18:06:25 +0000 (GMT)
X-AuditID: cbfec7f4-835ff700000010c6-d0-5c1bda22afcf
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 1F.2B.04284.12ADB1C5; Thu, 20
        Dec 2018 18:06:25 +0000 (GMT)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181220180625eusmtip1c6aae2e98a6fd403fe34ceb659f678ac~yHLTTX-G83055630556eusmtip1P;
        Thu, 20 Dec 2018 18:06:25 +0000 (GMT)
Subject: Re: [PATCH v5] fbdev: Remove depends on HAS_DMA in case of platform
 dependency
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <17d121db-7afc-faca-10a8-ec55b5429171@samsung.com>
Date:   Thu, 20 Dec 2018 19:06:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20181203122459.12558-1-geert@linux-m68k.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplleLIzCtJLcpLzFFi42LZduznOV2lW9IxBrsf8Flc+fqezeLZrb1M
        Fif6PrBaXN41h82BxePQ4Q5Gj/vdx5k8Pm+SC2CO4rJJSc3JLEst0rdL4MpY8mIvY0E3e8X+
        bdeYGxi/sXYxcnJICJhIXLy/lrmLkYtDSGAFo8SkxduZQRJCAl8YJX5/z4NIfGaUeL7mHztM
        x+/Ox0wQieWMEj+fT2aHcN4zSrxrnckIUiUsECmxecE2oFEcHCICuhJzfjKBhJkFEiS+3PwM
        toFNwEpiYvsqsHJeATuJqd8vg53EIqAqsWbDP1aQVlGBCIn+M+oQJYISJ2c+YQGxOYFat8xb
        wQIx0kDiyKI5rBC2vMT2t3PAvpEQ+M4m0b5nC9SbLhI/3v5jg7CFJV4d3wL1jIzE/53zmSAa
        pjNKvPm1lAXCWc8osebMMSaIKmuJw8cvgl0kIeAoMWmGAYTJJ3HjrSDEYj6JSdumM0OEeSU6
        2oQgGtUkNizbwAazqmvnSmYI20Ni8u1HTBMYFWcheW0WkndmIXlnASPzKkbx1NLi3PTUYqO8
        1HK94sTc4tK8dL3k/NxNjMDEcfrf8S87GHf9STrEKMDBqMTDe2G7dIwQa2JZcWXuIUYJDmYl
        Ed71h4BCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeasZHkQLCaQnlqRmp6YWpBbBZJk4OKUaGNOK
        l1r/cX51Q6vdUEdAz6mapWO+xb6ZO4syvztcuPI678ncSVxK3dyiP7xuNGQcZfpzyHbvwqKt
        ffbeyt3+Yl3NMxPmnN7VIiH555Gw9a3lfms16tmM5poFnu8TO2uy12jCLg+HqHeXufZOWHby
        9ERV0603Ky2WL51d59n/60GBoJTG7Jm8oUosxRmJhlrMRcWJAHpfK9AYAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmkeLIzCtJLcpLzFFi42I5/e/4XV3FW9IxBvdOCVtc+fqezeLZrb1M
        Fif6PrBaXN41h82BxePQ4Q5Gj/vdx5k8Pm+SC2CO0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAz
        MrHUMzQ2j7UyMlXSt7NJSc3JLEst0rdL0MtY8mIvY0E3e8X+bdeYGxi/sXYxcnJICJhI/O58
        zNTFyMUhJLCUUWLj9lvMXYwcQAkZiePryyBqhCX+XOtig6h5yyix/ccTNpCEsECkxOYF28Dq
        RQR0Jeb8hJrTyyix9/UaZpAaZoEEiU33p4LVswlYSUxsX8UIYvMK2ElM/X4Z7AgWAVWJNRv+
        gdmiAhEStx52sEDUCEqcnPkEzOYE6t0ybwULxEw9iR3Xf7FC2PIS29/OYZ7AKDgLScssJGWz
        kJQtYGRexSiSWlqcm55bbKhXnJhbXJqXrpecn7uJERgR24793LyD8dLG4EOMAhyMSjy8Gruk
        Y4RYE8uKK3MPMUpwMCuJ8K4/BBTiTUmsrEotyo8vKs1JLT7EaAr0xERmKdHkfGC05pXEG5oa
        mltYGpobmxubWSiJ8543qIwSEkhPLEnNTk0tSC2C6WPi4JRqYAx5UPs8+dTOadLaAg4H/DcI
        hQmqrlF/bzN9vbRp1AEFe1evLYdfHNtqFf7jk8ZTkU4D78raXbwvi+684b+6c03cdx2HN7l3
        WZaGLkh1mZchHXzec8vjY0I3P5YaFEzSU7udL3G2fMutzeuk1u7kyeSZy93onn8op1PZ1HGP
        cmHMkjkh5nXpfkosxRmJhlrMRcWJAGIV2L+eAgAA
X-CMS-MailID: 20181220180625eucas1p2f7c99078b6bb7d2665af92012e2422cf
X-Msg-Generator: CA
X-RootMTR: 20181203122549epcas4p41d426a4a89a2a4fd74a16924319fa1f9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181203122549epcas4p41d426a4a89a2a4fd74a16924319fa1f9
References: <CGME20181203122549epcas4p41d426a4a89a2a4fd74a16924319fa1f9@epcas4p4.samsung.com>
        <20181203122459.12558-1-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/03/2018 01:24 PM, Geert Uytterhoeven wrote:
> Remove dependencies on HAS_DMA where a Kconfig symbol depends on another
> symbol that implies HAS_DMA, and, optionally, on "|| COMPILE_TEST".
> In most cases this other symbol is an architecture or platform specific
> symbol, or PCI.
> 
> Generic symbols and drivers without platform dependencies keep their
> dependencies on HAS_DMA, to prevent compiling subsystems or drivers that
> cannot work anyway.
> 
> This simplifies the dependencies, and allows to improve compile-testing.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Reviewed-by: Mark Brown <broonie@kernel.org>
> Acked-by: Robin Murphy <robin.murphy@arm.com>
> Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Patch queued for 4.21, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
