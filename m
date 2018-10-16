Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D894C04EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 00:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3615920866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 00:45:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="u0VSrlpB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3615920866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbeJPIct (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 04:32:49 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:16151 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbeJPIcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 04:32:48 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20181016004502epoutp03ca3314e1c5bd8d640372afc93a2852c4~d8Cgauzzw1633616336epoutp03V;
        Tue, 16 Oct 2018 00:45:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20181016004502epoutp03ca3314e1c5bd8d640372afc93a2852c4~d8Cgauzzw1633616336epoutp03V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539650702;
        bh=tStSWTFHuYyi/vq/7w3PE3Rx1ZbrgC5QxtbyhihW98E=;
        h=Date:From:To:Cc:Subject:In-reply-to:References:From;
        b=u0VSrlpBYzNQBVfUofWbbM+hQe3vYgsu8UV+I3mbY/dIFKzXzQly/sqPCh+Cq7EyM
         wGcF10cMFJ127IFMWeQ3/PWFGyfrFq1zYSG3+3yNUfawpd02VeclgtNy2425ye1Yft
         OhpxyiwGI6QycnlGnNh8Vnu+RDqFNcflKFqnLIZ0=
Received: from epsmges2p1.samsung.com (unknown [182.195.40.156]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181016004459epcas1p2c4045f60797dc832313f1fe3cfd157e6~d8CdUBTc93214832148epcas1p2y;
        Tue, 16 Oct 2018 00:44:59 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        51.5D.04015.A8435CB5; Tue, 16 Oct 2018 09:44:58 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20181016004458epcas2p3409b730a1d5d62c6a33cfe94c06aa279~d8Ccp7Ih-2483924839epcas2p33;
        Tue, 16 Oct 2018 00:44:58 +0000 (GMT)
X-AuditID: b6c32a45-6a9ff70000000faf-1b-5bc5348a121a
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        13.CB.03633.A8435CB5; Tue, 16 Oct 2018 09:44:58 +0900 (KST)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Received: from [10.113.63.77] by mmp1.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PGO00IME22YGT10@mmp1.samsung.com>; Tue, 16 Oct 2018 09:44:58 +0900 (KST)
Message-id: <5BC5348A.7010308@samsung.com>
Date:   Tue, 16 Oct 2018 09:44:58 +0900
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
Subject: Re: [PATCH v2 1/6] clocksource: exynos_mct: Remove dead code
In-reply-to: <20181015123112.9379-2-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGJsWRmVeSWpSXmKPExsWy7bCmhW63ydFogwmTOS02zljPavF+WQ+j
        xbzPshaT7k9gsTh/fgO7xabH11gtLu+aw2Yx4/w+Jou1R+6yW/y984/NYvOmqcwWLz+eYHHg
        8Vgzbw2jx6ZVnWwed67tYfN4d+4cu8fmJfUefVtWMXp83iQXwB6VbZORmpiSWqSQmpecn5KZ
        l26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6DrlpkDdKeSQlliTilQKCCxuFhJ386mKL+0
        JFUhI7+4xFYptSAlp8CyQK84Mbe4NC9dLzk/18rQwMDIFKgwITvjz5obLAVPOSt2v1/K0sD4
        h72LkYNDQsBE4ujj4i5GLg4hgR2MEq2LJ7NCON8ZJV7+ecLcxcgJVjTnSwMzRGI3o8SStWcY
        QRK8AoISPybfYwGZxCwgL3HkUjZImFlAU2Lr7vXsEPV3GSWmTJ8IVa8lcensZ7B6FgFVif+7
        mEDCbEDh/S9usIHY/AKKEld/PAYrFxWIkNg5/xvYHBGBWYwS/W8nM4I4zAJnmSTu7b0K1iEs
        4CrxvX06WAengK3ExBfP2SCu/s8m8fCUDoTtIvF37Tx2CFtY4tXxLVC2tMSzVRvBhkoItDNK
        fHnRzArhTGCU+HBqMxNElbHEs4VdTBC/8Ul0HP4LDTxeiY42IYgSD4mGlqng4BISOMwo0XTY
        aAKj7CykQJqFCKRZSIG0gJF5FaNYakFxbnpqsVGBIXLsbWIEp0kt1x2MM875HGIU4GBU4uFd
        cPVItBBrYllxZe4hRgkOZiUR3oTbQCHelMTKqtSi/Pii0pzU4kOMpsAwnsgsJZqcD0zheSXx
        hqZGxsbGFqbmlsYGlkrivI+k50YLCaQnlqRmp6YWpBbB9DFxcEo1MLpxX5TLfPPy9P7Zyz4+
        OxicIHNp89sD0/oPFj9iMDB5yX3w79dt355K6d45IMd67Brn1EnH58puLOFYcZr1oG1o5BfZ
        dzUHrSU7PVpOXS9fsqAztCRCff5Bd82O7qmGrcHrdxbm7zGqdc1uVpf7OZf/18yr29rM58w7
        zfl8+gHtT/d/nfycZq+jxFKckWioxVxUnAgA5lmvIqkDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPLMWRmVeSWpSXmKPExsVy+t9jAd0uk6PRBpefKlhsnLGe1eL9sh5G
        i3mfZS0m3Z/AYnH+/AZ2i02Pr7FaXN41h81ixvl9TBZrj9xlt/h75x+bxeZNU5ktXn48weLA
        47Fm3hpGj02rOtk87lzbw+bx7tw5do/NS+o9+rasYvT4vEkugD2KyyYlNSezLLVI3y6BK+PP
        mhssBU85K3a/X8rSwPiHvYuRk0NCwERizpcG5i5GLg4hgZ2MEi13NzODJHgFBCV+TL7H0sXI
        wcEsIC9x5FI2SJhZQF1i0rxFUPX3GSW+tLYzQdRrSVw6+xmsnkVAVeL/LrAwG1B4/4sbbCA2
        v4CixNUfjxlBSkQFIiS6T1SCjBERmMUo8bx3BRvE/ItMEj/ug50gLOAq8b19OiPErsOMEhte
        L2MESXAK2EpMfPGcbQIjUCvCqbMQTp2F5NQFjMyrGCVTC4pz03OLjQqM8lLL9YoTc4tL89L1
        kvNzNzECo2XbYa3+HYyPl8QfYhTgYFTi4V1w9Ui0EGtiWXFl7iFGCQ5mJRHehNtAId6UxMqq
        1KL8+KLSnNTiQ4zSHCxK4rz8+ccihQTSE0tSs1NTC1KLYLJMHJxSDYya7OmPCr01+DKXbJ3+
        411yvyn344Yqk+Pyyx2uT1YuTMjceTNWJXbRxK6AjRUmqZ/+beCZ358wz5NRfdnMtYoXj6xP
        ehAhI/yf+3zPlS2XG0Uk9ut4Oxvn1v0/q9//v0/yow5XVJim5kn52HablHfcXfGSNV+es2zX
        /rhH/vvD3mvzRLe5aymxFGckGmoxFxUnAgCnbrqCkgIAAA==
X-CMS-MailID: 20181016004458epcas2p3409b730a1d5d62c6a33cfe94c06aa279
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20181015123134eucas1p2bca15d1e0f54c0a580c04d9af7411f68
References: <20181015123112.9379-1-m.szyprowski@samsung.com>
        <CGME20181015123134eucas1p2bca15d1e0f54c0a580c04d9af7411f68@eucas1p2.samsung.com>
        <20181015123112.9379-2-m.szyprowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018년 10월 15일 21:31, Marek Szyprowski wrote:
> Exynos Multi-Core Timer driver is used only on device-tree based
> systems, so remove non-dt related code. In case of !CONFIG_OF
> the code is anyway equal because of_irq_count() has a stub
> returning 0.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/clocksource/exynos_mct.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
> index 7a244b681876..43b335ff4a96 100644
> --- a/drivers/clocksource/exynos_mct.c
> +++ b/drivers/clocksource/exynos_mct.c
> @@ -581,11 +581,7 @@ static int __init mct_init_dt(struct device_node *np, unsigned int int_type)
>  	 * timer irqs are specified after the four global timer
>  	 * irqs are specified.
>  	 */
> -#ifdef CONFIG_OF
>  	nr_irqs = of_irq_count(np);
> -#else
> -	nr_irqs = 0;
> -#endif
>  	for (i = MCT_L0_IRQ; i < nr_irqs; i++)
>  		mct_irqs[i] = irq_of_parse_and_map(np, i);
>  
> 

I agree that Exynos MCT timer is only used by device-tree.
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
