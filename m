Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45938C04EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 01:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A53B2089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 01:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="AGV1XvNq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A53B2089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbeJPJPC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 05:15:02 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:50348 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726051AbeJPJPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 05:15:01 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20181016012705epoutp0225888379ac6c61e63115bb53c9f28c6c~d8nOGHMNV1116611166epoutp02f;
        Tue, 16 Oct 2018 01:27:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20181016012705epoutp0225888379ac6c61e63115bb53c9f28c6c~d8nOGHMNV1116611166epoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539653225;
        bh=bXxRE/I7x6z+yjfyKZKvxQow6zgfe2J+B7T+aiUaG+8=;
        h=Date:From:To:Cc:Subject:In-reply-to:References:From;
        b=AGV1XvNqxvyAVei/eObf28dRZvE/2DTUW8DjwdEt6XruTzmnro/5Lkdt+6o4gws+x
         v9o+VzRMMgihXkxQrzDw+HSd9aZz47Nt7iUzr2Dr8IsWfO5lYKpOBF0uqcsHEr1BQw
         K5VVRKnbweXhLEuq2rNcE54rhcKgYyOod0Ntct84=
Received: from epsmges2p1.samsung.com (unknown [182.195.40.156]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20181016012702epcas1p3c3959b89bc86ce908960b10cc30ba1a7~d8nLDipv30246402464epcas1p32;
        Tue, 16 Oct 2018 01:27:02 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        9E.05.04015.66E35CB5; Tue, 16 Oct 2018 10:27:02 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20181016012701epcas2p2e294d37d3346c4b47338566d784813ed~d8nKZlvyQ3023030230epcas2p2v;
        Tue, 16 Oct 2018 01:27:01 +0000 (GMT)
X-AuditID: b6c32a45-6a9ff70000000faf-a2-5bc53e6662be
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        12.8E.03633.56E35CB5; Tue, 16 Oct 2018 10:27:01 +0900 (KST)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Received: from [10.113.63.77] by mmp1.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PGO00G4K4119M40@mmp1.samsung.com>; Tue, 16 Oct 2018 10:27:01 +0900 (KST)
Message-id: <5BC53E65.7050500@samsung.com>
Date:   Tue, 16 Oct 2018 10:27:01 +0900
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Inki Dae <inki.dae@samsung.com>
Subject: Re: [PATCH v2 2/6] clocksource: exynos_mct: Fix error path in timer
 resources initialization
In-reply-to: <20181015123112.9379-3-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRju29nOjubsdLz0pVjrgIWGtjmnZ+Wki8kgISmi0EAPepribuxs
        kUHkBbqM0FVUa1iplT/WYjq7qVm0GdrNUaFd1Aots6y0kgrC1rZD5L/nfXie73vf530xhLCh
        cVi5zsQYdbSGRMP517xJmSm7su8WSk4/m0+12VwCaqrlCKDOfk+gjr228imfr1VIuccGBdTT
        zgaUsvlu8ajLPSNCanb4D0q1u08g1Ievffy1ESrnWSdQuR2HUdXw4E1U9aW/X6hqv7BfVXfF
        AVTf3UvyhQUVWWUMXcoYxYyuRF9arlMryU1bizYUyTMk0hSpgsokxTpayyjJnLz8lNxyTaBP
        Uryb1pgDVD7NsuSq7Cyj3mxixGV61qQkGUOpxqAwpLK0ljXr1Kkleu1qqUSSJg8IiyvKpobq
        eIaqiD0jzY94VWAqzALCMIinw96+U4gFhGMEfgPA6he1fK74CaDrXZ/AArCQ6vzTfRzfBeCx
        5m9I0C3CF8Jfx1/xgxoEXwp7nlQEaQRPgle7XEJOPwKgv/skn9MnQ6evhhfEfDwRDnb8EAQx
        GuBvTzxHg3gBvgwO/BoDQRyD74Ad536EHorG7QDWfz4OggWCP+LBV90DIUcUroa+5wOhjsJw
        JbzorQs5IO5Hoc8xjXKD5sDrM60Ih6Pgx94rQg7Hw3FHG+AMBwGcmagVcIUVwOn77TxOJYPj
        TRYeN10kPOSdFXLBiOChAwQnUUHrpabQBwTuBdA2KrGCBPucmOz/Y7LPiakRIA4QyxhYrZph
        0wzSuftzg9BVJm+8AWz9eR6AY4CMEDUO9BQSAno3W6n1AIghZLSoeChAiUrpyr2MUV9kNGsY
        1gPkgZSPInExJfrAjetMRVJ5mkwmo+SZCplEQS4SjcafKSRwNW1iKhjGwBj/+XhYWFwVGG/u
        rt/+7KolN+phrbWho1O4uT96Yvp980xjxt5IQ+yoeY0zg3AeSFTEpFbuvPcmd3Y02y8V31nR
        tAEr+PJWUxNzpm050fhYTmwfWnftQapn62u7zFUw+XKLNDy9qvrTkgWrW7xK8frhedt+L46c
        nvQbh0SudWqTozca+j22lZtIPltGS5MRI0v/BRj0bKyrAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPLMWRmVeSWpSXmKPExsVy+t9jAd1Uu6PRBvNmq1psnLGe1eL9sh5G
        i3mfZS0m3Z/AYnH+/AZ2i02Pr7FaXN41h81ixvl9TBZrj9xlt/h75x+bxeZNU5ktXn48weLA
        47Fm3hpGj02rOtk87lzbw+bx7tw5do/NS+o9+rasYvT4vEkugD2KyyYlNSezLLVI3y6BK+P9
        7T6mggaeiruLzjI1ML7n7GLk4JAQMJFYfLm2i5GLQ0hgJ6PE47VNbF2MnBy8AoISPybfYwGp
        YRaQlzhyKRskzCygLjFp3iJmiPr7jBJLtxxjgajXklhzvokJxGYRUJW4tvMbK4jNBhTf/+IG
        2Ex+AUWJqz8eM4LMFBWIkOg+UQkyR0RgFqPE894VbBALLjJJ/LjPDGILC6RLnL9xFWrZYUaJ
        Wf1tYAlOAVuJpYf72CcwArUi3DoL4dZZSG5dwMi8ilEytaA4Nz232KjAKC+1XK84Mbe4NC9d
        Lzk/dxMjMFq2Hdbq38H4eEn8IUYBDkYlHt4FV49EC7EmlhVX5h5ilOBgVhLhTbgNFOJNSays
        Si3Kjy8qzUktPsQozcGiJM7Ln38sUkggPbEkNTs1tSC1CCbLxMEp1cBYZv12h9Lq3eIbZ56b
        /bj1UXDxjQNpxe82rxL155zxImb/Vcf7B/4k3RM9H1F4+5ZdxLkpOybkLnVae93wUaBvzQFm
        q7Qge+dzWu4FkU3v11279WhaqfLl13WhEg11Yd9iXGo+HVoWK6RyoWhvqkijpm6axrK6GC77
        t4wzhVY4fHQ8d9sn7LyCEktxRqKhFnNRcSIAbFlbJ5ICAAA=
X-CMS-MailID: 20181016012701epcas2p2e294d37d3346c4b47338566d784813ed
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20181015123135eucas1p18df135504c9476cead8da6463226cdec
References: <20181015123112.9379-1-m.szyprowski@samsung.com>
        <CGME20181015123135eucas1p18df135504c9476cead8da6463226cdec@eucas1p1.samsung.com>
        <20181015123112.9379-3-m.szyprowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Marek,

On 2018년 10월 15일 21:31, Marek Szyprowski wrote:
> While freeing interrupt handlers in error path, don't assume that all
> requested interrupts are per-processor interrupts and properly release
> standard interrupts too.
> 
> Suggested-by: Krzysztof Kozlowski <krzk@kernel.org>
> Fixes: 56a94f13919c ("clocksource: exynos_mct: Avoid blocking calls in the cpu hotplug notifier")
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/clocksource/exynos_mct.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
> index 43b335ff4a96..a379f11fad2d 100644
> --- a/drivers/clocksource/exynos_mct.c
> +++ b/drivers/clocksource/exynos_mct.c
> @@ -562,7 +562,19 @@ static int __init exynos4_timer_resources(struct device_node *np, void __iomem *
>  	return 0;
>  
>  out_irq:
> -	free_percpu_irq(mct_irqs[MCT_L0_IRQ], &percpu_mct_tick);
> +	if (mct_int_type == MCT_INT_PPI) {
> +		free_percpu_irq(mct_irqs[MCT_L0_IRQ], &percpu_mct_tick);
> +	} else {
> +		for_each_possible_cpu(cpu) {
> +			struct mct_clock_event_device *pcpu_mevt =
> +				per_cpu_ptr(&percpu_mct_tick, cpu);
> +
> +			if (pcpu_mevt->evt.irq != -1) {
> +				free_irq(pcpu_mevt->evt.irq, pcpu_mevt);
> +				pcpu_mevt->evt.irq = -1;
> +			}
> +		}
> +	}
>  	return err;
>  }
>  
> 

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
