Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A798AC04EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 00:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41283208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 00:59:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="cFUw7s/a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41283208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbeJPIrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 04:47:16 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:16638 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbeJPIrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 04:47:16 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20181016005927epoutp049b04ad356f86f9bd4b3d4960445dd1e0~d8PF3Ynjd2593625936epoutp04K;
        Tue, 16 Oct 2018 00:59:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20181016005927epoutp049b04ad356f86f9bd4b3d4960445dd1e0~d8PF3Ynjd2593625936epoutp04K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539651567;
        bh=rYsH4EJWxyrAoKOKgind43v17vRu5CnLkmgllDQAdcI=;
        h=Date:From:To:Cc:Subject:In-reply-to:References:From;
        b=cFUw7s/arPvSo5jI299pVH7hIZ9pqQm2NIY01A/uw70fuxJVgE5mlGPuF8N35ZPib
         +XuQm/qgPsKkWVkJjaVhUh5YjOePQuqSm7Zfu4HspPNHI7x1nCtND/Se2RThXe+8qs
         pewBv0KjMvcCOv73Zg51BPeeUICUbQuMn7XxLmWw=
Received: from epsmges2p4.samsung.com (unknown [182.195.40.157]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20181016005923epcas1p376a2bbd77271f89b11c9e0efe4276182~d8PCAbfLT1733917339epcas1p3a;
        Tue, 16 Oct 2018 00:59:23 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        13.FE.04069.BE735CB5; Tue, 16 Oct 2018 09:59:23 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20181016005923epcas2p290b02823a00f6dc4539ecb2e0ebbba8b~d8PBvIgzM0664806648epcas2p2V;
        Tue, 16 Oct 2018 00:59:23 +0000 (GMT)
X-AuditID: b6c32a48-e59ff70000000fe5-ce-5bc537ebef78
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        63.4C.03633.AE735CB5; Tue, 16 Oct 2018 09:59:22 +0900 (KST)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Received: from [10.113.63.77] by mmp1.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PGO004X82QY5V80@mmp1.samsung.com>; Tue, 16 Oct 2018 09:59:22 +0900 (KST)
Message-id: <5BC537EA.9000700@samsung.com>
Date:   Tue, 16 Oct 2018 09:59:22 +0900
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
Subject: Re: [PATCH v2 4/6] clocksource: Change CPU hotplug priority of
 exynos_mct driver
In-reply-to: <20181015123112.9379-5-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTcRTmt7vdXa3lbWn9UCy74B8K1uZa3kWWkMUNIyR7kZRe3K9N9mR3
        62WQEZlJ1MoetsqUHoQV6dQyrZRN02o5Wk3sob0sqmUvKwvS2naL/O873/nO4ZzvHAKTOvBY
        otBoRRYjq6fwSOFld1JaSiCtI1dWfFhK11VcEtEfz+4BdOVQPH3gqV1Ie721Ytr5skdE328+
        jtMV3hsC+mJ7n5geeTKK0/XOQxj99nOXMGM8c6HyAmCcNbtx5knPNZz50N0tZupPb2P2NtQA
        Zsg5NVu8RjdXi1g1siQgY4FJXWjUpFNZOXkL8pSzZfIUuYpOoxKMrAGlU5lLslMWFeqDc1IJ
        G1i9LUhlsxxHzZw312KyWVGC1sRZ0ylkVuvNKvMMjjVwNqNmRoHJMEcuk6Uqg8J8nXa7pwmY
        z4zbVPmiHysG7ogyEEFAchZ0P3CKy0AkISWbACz++UvAB8MA1p9rxP6pvj5rF/GJFgB7z1cI
        QwkJORH+KO8PYoLAyGmw3acL0RiZBBtbLv3t2gegPbAT8PpkeNPbGMZCMhG27DgdxniQb33T
        i4dwFDkd+n+8DPMx5Gp49eT3cKNo0gHgvsFyEAow8q4A9l/3hysmkbkwMNARHjWCTIeu8lt4
        SATJ3zgM/BrF+R0yYe87j5DHk+C7zgYxj+Pg65o6wBfsAvDrmx0iPrAD+Ol2vYBXKeDr6jIB
        v90EWOoeEYeWhqQElpZIeQkDjxyq/WuSG8C+e2WYHcQ7xvjk+O+TY4xPVQCrAZORmTNoEJdq
        njX2gk4Q/stkpgm0dS9xAZIA1HhJlb89VypiN3CbDS4ACYyKluQ/DlISNbt5C7KY8iw2PeJc
        QBm0eT8WG1NgCn650ZonV6YqFApamaZSyFTUFMnzuBO5UlLDWpEOITOy/KsTEBGxxaDBl3XK
        48r8fiwwuHJ94qqWF4t9BlTUeaxn7YCztdS/bH5nka9oxcYrmoW+yuWaqNVfHNIbuu2Lba+O
        fnNloNpVw8ZA88dqz2fBOoFrzmCJO7PxctL7mep4VdYjz5DUG/nFudSxdatde+dc23D8lpyu
        hwe3+bInFrSO9Efdj/Z7d1JCTsvKkzELx/4Bh3wAlq0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgkeLIzCtJLcpLzFFi42I5/e+xgO4r86PRBhN+2VhsnLGe1eL9sh5G
        i3mfZS0m3Z/AYnH+/AZ2i02Pr7FaXN41h81ixvl9TBZrj9xlt/h75x+bxeZNU5ktXn48weLA
        47Fm3hpGj02rOtk87lzbw+bx7tw5do/NS+o9+rasYvT4vEkugD2KyyYlNSezLLVI3y6BK6Px
        zA7GgqXcFfMe3WNuYDzM2cXIySEhYCLx5cER1i5GLg4hgZ2MEi+mTGYGSfAKCEr8mHyPpYuR
        g4NZQF7iyKVskDCzgLrEpHmLmCHq7zNKHNxxmQWiXkvi2PmtjCA2i4CqxO7mJWA2G1B8/4sb
        bCA2v4CixNUfjxlBZooKREh0n6gEmSMiMItR4nnvCjaIBReZJH7cB7tBWCBa4vWTo1DLDjNK
        fFreD7aMU8BW4tDkk2wTGIFaEW6dhXDrLCS3LmBkXsUomVpQnJueW2xUYJSXWq5XnJhbXJqX
        rpecn7uJERgv2w5r9e9gfLwk/hCjAAejEg/vgqtHooVYE8uKK3MPMUpwMCuJ8CbcBgrxpiRW
        VqUW5ccXleakFh9ilOZgURLn5c8/FikkkJ5YkpqdmlqQWgSTZeLglGpgzPpuyphYwWM2X/9R
        66e6t0VsSokJWyRz7pvL/Ik20ErJ7v1Uxy5qtGqr4Tnt5ap/D6To2xmpWTz4qPpmzowrfAYH
        mq9GtuU3L/U8/2Fu/4qPrsdS/zJtYlt37J3k5nd2hj8nWsxkd7p/0q8jl/dd2lHjSQGuL4++
        47oseHKbnrTJqxk/H2ktUGIpzkg01GIuKk4EAEwf2mGTAgAA
X-CMS-MailID: 20181016005923epcas2p290b02823a00f6dc4539ecb2e0ebbba8b
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20181015123136eucas1p2f7d4ae86ba3547b891749b01514cd335
References: <20181015123112.9379-1-m.szyprowski@samsung.com>
        <CGME20181015123136eucas1p2f7d4ae86ba3547b891749b01514cd335@eucas1p2.samsung.com>
        <20181015123112.9379-5-m.szyprowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018년 10월 15일 21:31, Marek Szyprowski wrote:
> Exynos Multi-Core Timer driver (exynos_mct) must be started before
> ARM Architected Timers (arch_timer), because both timers share common
> hardware block and turning on MCT is needed to get ARM Architected
> Timer working properly.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  include/linux/cpuhotplug.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> index caf40ad0bbc6..5d9e4a6ea299 100644
> --- a/include/linux/cpuhotplug.h
> +++ b/include/linux/cpuhotplug.h
> @@ -115,10 +115,10 @@ enum cpuhp_state {
>  	CPUHP_AP_PERF_ARM_ACPI_STARTING,
>  	CPUHP_AP_PERF_ARM_STARTING,
>  	CPUHP_AP_ARM_L2X0_STARTING,
> +	CPUHP_AP_EXYNOS4_MCT_TIMER_STARTING,
>  	CPUHP_AP_ARM_ARCH_TIMER_STARTING,
>  	CPUHP_AP_ARM_GLOBAL_TIMER_STARTING,
>  	CPUHP_AP_JCORE_TIMER_STARTING,
> -	CPUHP_AP_EXYNOS4_MCT_TIMER_STARTING,
>  	CPUHP_AP_ARM_TWD_STARTING,
>  	CPUHP_AP_QCOM_TIMER_STARTING,
>  	CPUHP_AP_ARMADA_TIMER_STARTING,
> 

On Exynos SoC, ARM architecture timer shares the block of Exynos MCT timer.
For using arch_timer, Exynos MCT timer should be initialized before arch_timer.
I agree about this.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
