Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C03C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49C8F21908
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:27:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ThXe6xWi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbfBHR1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:27:31 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:46783 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727689AbfBHR1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 12:27:31 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190208172729euoutp01b1c5e9cb5bcf259d199d55ed899f9f7d~Bc5mFbaTZ2287522875euoutp01j
        for <linux-kernel@vger.kernel.org>; Fri,  8 Feb 2019 17:27:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190208172729euoutp01b1c5e9cb5bcf259d199d55ed899f9f7d~Bc5mFbaTZ2287522875euoutp01j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549646850;
        bh=Znhp/LJksnAJsDWcHO6R7iJGDoj8DDEsrPiBQVqwXBM=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=ThXe6xWizut3xHJ/ntfw5b1BHU82N9HH3hGQlh8p684OCvHoat6Xq9XHuaSUpMQPv
         OW/mqox/7SC8nltLNa76YrDyDtmpmHNd1ahYuTD3kViRWuOIWnqskcMwlO/sB7ElIe
         1VJQ97fRbka4nzAmWJ3Wut+VV31YmSvZvL7n5GoM=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190208172729eucas1p128f9e68ca71a334b4fafa97ec05a47b6~Bc5lorLbP2285622856eucas1p1w;
        Fri,  8 Feb 2019 17:27:29 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id BA.AD.04294.10CBD5C5; Fri,  8
        Feb 2019 17:27:29 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190208172728eucas1p1338278135ccc468e5bd828359dc225e6~Bc5k5wXRG0806808068eucas1p1M;
        Fri,  8 Feb 2019 17:27:28 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190208172728eusmtrp2ebcbb0f706b672def082757eab26abcb~Bc5krrkDR0972409724eusmtrp2W;
        Fri,  8 Feb 2019 17:27:28 +0000 (GMT)
X-AuditID: cbfec7f4-84fff700000010c6-43-5c5dbc01fba9
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id F5.05.04284.00CBD5C5; Fri,  8
        Feb 2019 17:27:28 +0000 (GMT)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190208172728eusmtip1c565dcd47a6917896d7f825f8bf5f1a2~Bc5kdGOse1677016770eusmtip1g;
        Fri,  8 Feb 2019 17:27:28 +0000 (GMT)
Subject: Re: [PATCH] fbdev: mbx: fix up debugfs file creation
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <0d953f69-f112-6e1b-0ba3-02ce56e8d1c5@samsung.com>
Date:   Fri, 8 Feb 2019 18:27:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190122152151.16139-16-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplleLIzCtJLcpLzFFi42LZduznOV3GPbExBgtv8ltc+fqezaJ58Xo2
        ixN9H1gtLu+aw+bA4rF/7hp2j/vdx5k8Pm+SC2CO4rJJSc3JLEst0rdL4Mr4cPAcU8Fj1orO
        tswGxvssXYycHBICJhJrjm8Csrk4hARWMEqsnnOMHcL5wigx+e09VgjnM6PEnh972WBa/nZ3
        QrUsZ5S4efAfG4TznlFietc3VpAqYQFbie0Lj7OD2CICxhL9Z2cB2RwczAIJErsXmYGE2QSs
        JCa2r2IEsXkF7CSedzxmArFZBFQkHi+czQJSLioQIdF/Rh2iRFDi5MwnYGFOAUeJvbuVQMLM
        AgYSRxbNYYWw5SW2v53DDHKNhMBvNompkzqhbnaRuLLqD9TLwhKvjm9hh7BlJP7vnM8E0TCd
        UeLNr6UsEM56Rok1Z44xQVRZSxw+fpEVwnaUuNx2lQ3kCgkBPokbbwUhNvNJTNo2nRkizCvR
        0SYEUa0msWHZBjaYXV07VzJD2B4S81f8YZ/AqDgLyWuzkPwzC8k/CxiZVzGKp5YW56anFhvl
        pZbrFSfmFpfmpesl5+duYgQmjtP/jn/ZwbjrT9IhRgEORiUe3oiW2Bgh1sSy4srcQ4wSHMxK
        IrwHtwOFeFMSK6tSi/Lji0pzUosPMUpzsCiJ81YzPIgWEkhPLEnNTk0tSC2CyTJxcEo1MHbp
        aJw5dc0lpaD3SGBhe3Lziq8tybGvZq1T9Dd4f+nsni62kNM/j3nPjRXdwO+wcNGNrlu3fCLD
        inPCtut9bL6rdV5V0XZBa3+7b1dpm11gy3Nu41e5ZvUX9zadvDDpjaAWR0MJf3flB47/LV5F
        J20/xGye90z180Lvm55bjZdq3Cx7WGD/Q4mlOCPRUIu5qDgRAJIINZsYAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupikeLIzCtJLcpLzFFi42I5/e/4XV2GPbExBl/ny1hc+fqezaJ58Xo2
        ixN9H1gtLu+aw+bA4rF/7hp2j/vdx5k8Pm+SC2CO0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAz
        MrHUMzQ2j7UyMlXSt7NJSc3JLEst0rdL0Mv4cPAcU8Fj1orOtswGxvssXYycHBICJhJ/uzuB
        bC4OIYGljBJ/pnUwdjFyACVkJI6vL4OoEZb4c62LDaLmLaPE2o6NYM3CArYS2xceZwexRQSM
        JfrPzmKHKJrCKPG59w8jSIJZIEFixdt2VhCbTcBKYmL7KrA4r4CdxPOOx0wgNouAisTjhbPB
        hooKREjcetjBAlEjKHFy5hMWkIM4BRwl9u5WghipJ7Hj+i9WCFteYvvbOcwTGAVnIemYhaRs
        FpKyBYzMqxhFUkuLc9Nziw31ihNzi0vz0vWS83M3MQLjYduxn5t3MF7aGHyIUYCDUYmHl6Ep
        NkaINbGsuDL3EKMEB7OSCO/B7UAh3pTEyqrUovz4otKc1OJDjKZAP0xklhJNzgfGal5JvKGp
        obmFpaG5sbmxmYWSOO95g8ooIYH0xJLU7NTUgtQimD4mDk6pBsaZL+uNXc7yet/dnc7qq7Og
        JKL2+mfHmR9uP4j/xmhwJGZFYISN5ARLC8afVhNVLlw//iS2Xuj2rVy5D7NTWSZ+jzfTaV+8
        0D22ouWb5wy7LqEH/Z1+pts8Fsy6vG/hc6Vl3es+HYrddkRMIufFyQyeyh9LFHe/X55/9fgc
        1o1sH2d/2/7ttyOvEktxRqKhFnNRcSIAUeDS/Z0CAAA=
X-CMS-MailID: 20190208172728eucas1p1338278135ccc468e5bd828359dc225e6
X-Msg-Generator: CA
X-RootMTR: 20190122152306epcas1p4b57a2364aab23e4963f8c578ca73a197
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190122152306epcas1p4b57a2364aab23e4963f8c578ca73a197
References: <CGME20190122152306epcas1p4b57a2364aab23e4963f8c578ca73a197@epcas1p4.samsung.com>
        <20190122152151.16139-16-gregkh@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 01/22/2019 04:21 PM, Greg Kroah-Hartman wrote:
> There is no need to keep the dentries around for the individual debugfs
> files, just delete the whole directory all at once at shutdown instead.
> 
> This also fixes a tiny memory leak where the memory for the pointers to
> the file dentries was never freed when the device shut down, as well as
> making the logic of the code a lot simpler.
> 
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-fbdev@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Patch queued for v5.1, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
