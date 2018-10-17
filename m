Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD3CC5ACC6
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 05:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18F49214AB
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 05:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="q7YsnM0C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18F49214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbeJQM5R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 08:57:17 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:34685 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbeJQM5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 08:57:16 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20181017050326epoutp03ff78223e6d034a637d0b53708ae74f92~eTNZYKcho1054110541epoutp03Z;
        Wed, 17 Oct 2018 05:03:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20181017050326epoutp03ff78223e6d034a637d0b53708ae74f92~eTNZYKcho1054110541epoutp03Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539752606;
        bh=swZJ/GWio+pJvHovOglBz7FjQEaTjWmgSQv0RtMmsno=;
        h=Date:From:To:Cc:Subject:In-reply-to:References:From;
        b=q7YsnM0CUQY3eSGbR/KbeQrW3Zx/HCc0zcRw72Hd3lKY96J1PLARZH4QgVHHRKWOF
         1/Jo9kEmhtKcF9+L0rT9VevEeh0m+hYU/NL5cD66ph53asWHK1JEIkPdgJ4XzMvhXU
         mcRIxiJLZd6dTXA3rkPOPgm8mUeyEnXV8r8vgnzc=
Received: from epsmges1p4.samsung.com (unknown [182.195.40.158]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20181017050322epcas1p48e9d7ae74240bafda6e5a5f4a2fd5dc1~eTNWZ8yEJ2029720297epcas1p4f;
        Wed, 17 Oct 2018 05:03:22 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        7E.7F.04220.A92C6CB5; Wed, 17 Oct 2018 14:03:22 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20181017050322epcas1p433dd4010fc4ce778e6fbee625166a675~eTNWFHrxw2029720297epcas1p4e;
        Wed, 17 Oct 2018 05:03:22 +0000 (GMT)
X-AuditID: b6c32a38-839ff7000000107c-c4-5bc6c29a2d7a
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        9D.D3.03743.A92C6CB5; Wed, 17 Oct 2018 14:03:22 +0900 (KST)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Received: from [10.113.63.77] by mmp1.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PGQ009MO8PHAX20@mmp1.samsung.com>; Wed, 17 Oct 2018 14:03:22 +0900 (KST)
Message-id: <5BC6C295.9060502@samsung.com>
Date:   Wed, 17 Oct 2018 14:03:17 +0900
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
Subject: Re: [PATCH v2 6/6] arm64: platform: Add enable Exynos Multi-Core
 Timer driver
In-reply-to: <20181015123112.9379-7-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sb0hTURjGO7vb3VVanWbWybLsQh+StF3n7FpOhaxGRQkSVH7Qi95Utt2N
        ezezSBQqK7G0TKlpZn+wMMOaVv4PZlmUOVEUzUxKKYvS0pp+KGvbJfLb+z7n9x6e9zmHwJSl
        eACRwVlYnmMMJO4rfdi+PiTE5uhIVJ11qOn7l2pl9GRVAaArpgPpCyNFUtrpvCen7aP9Mrq3
        qRynLznbJPTdJ8Ny+vebOZyus5dg9Kfvz6WxC3U1FTVAZ68+g+ve9LfguomuLrmu7maO7lx9
        NdBN21fHyw/qo9JZJpXlg1guxZSawaVpyV0JSVuTNBEqKoSKpDeRQRxjZLVk3O74kO0ZBrdP
        MiiTMVjdUjwjCOTG6CjeZLWwQekmwaIlWXOqwRxpDhUYo2Dl0kJTTMbNlEoVpnGDyfr03tdT
        mLmeyHL1tMtygQvPBz4EguHI2W2T5wNfQgkbABrNK5R5DpRwBqDS8bB/UO3QIC5CzQDd6j/l
        hRRwCZotfivNBwSBwTXoSY/eI2NwPXrQXCsX7xkG6P1UnAdRwGBka9N6ZClch9oma70ecLf8
        eHzAWy+Ga1Hf7Cjw1P5wP2q86vJ6WwptABV+LQaeBoOvJOhta593ws9NXZ6u8vrxgVpUfHIC
        80AI/sGRc7gREzeIQ5OzZUCs/dDnZ/VyjyMEV6Kep1qRPwXQj/HjMrEpAujbizqJOKBGH67l
        S8TVFqGJnwUycViBTucpRUSHmjvapWJC7QA1XJ6TFYFA27yQbP9Dss0LqRJg1WAZaxaMaaxA
        mcPnv54deP9kMN0AWrp2OwAkALlQ0bCsI1EpYzKFI0YHQARGLlVk3HBLilTmyFGWNyXxVgMr
        OIDGnfJ5LMA/xeT+4ZwlidKEqdVqOpyK0FAUuVwxFnAlUQnTGAurZ1kzy/+bkxA+Ablgy+H6
        i1jrPmXJSNmOGGlw+ALb+Q/J2YWu+NiY8q2leTtjViV0W0v2XOcezW1KjB5c7Rs7ZJmKbDmg
        IQeK3pXPVL/kv4dmx4yhwknVyK+UE5qznWO/+YINvqcTqr6gk01cVtTHmhWuQ9yCO2RnU+AZ
        xbas4WhtjvNYWOXe7OIZ/W1SKqQzVDDGC8xfmN+Ty6kDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPLMWRmVeSWpSXmKPExsVy+t9jAd1Zh45FG5y+KW6xccZ6Vov3y3oY
        LeZ9lrWYdH8Ci8X58xvYLTY9vsZqcXnXHDaLGef3MVmsPXKX3eLvnX9sFps3TWW2ePnxBIsD
        j8eaeWsYPTat6mTzuHNtD5vHu3Pn2D02L6n36NuyitHj8ya5APYoLpuU1JzMstQifbsErozL
        tz4xF2zhqPh26TBrA+M3ti5GTg4JAROJ9bdvAtlcHEICOxklni37xQqS4BUQlPgx+R5LFyMH
        B7OAvMSRS9kgYWYBdYlJ8xYxQ9TfZ5T4u/YoK0gNr4CWxKx9tiA1LAKqEvverwebzwYU3v/i
        BpjNL6AocfXHY0aQclGBCInuE5UgY0QEZjFKPO9dwQYx/yKTxI/7zCC2MFDN14mbWSF2HWaU
        aJ5ymhEkwSlgKzG59R3zBEagVoRTZyGcOgvJqQsYmVcxSqYWFOem5xYbFRjmpZbrFSfmFpfm
        pesl5+duYgRGy7bDWn07GO8viT/EKMDBqMTDu0PsWLQQa2JZcWXuIUYJDmYlEd7MxUAh3pTE
        yqrUovz4otKc1OJDjNIcLErivLfzjkUKCaQnlqRmp6YWpBbBZJk4OKUaGGUFjq48b12aNoXP
        bf6HSqbOa/1eHTI2uoFTN+fMsxDo+XX5WGBF9pyHi9s5vode2T2hZ3WmvuvP6Tpz6zPerpph
        Od0oyHzuPjedFX+EvG92Xm9hqHfbcKe8t4TlpMGmzqhTjfqFKtKHm7Pt7rXynJqUIjHzqZ2h
        uenLI4+39wStiDlSaD79mhJLcUaioRZzUXEiAL3i+5aSAgAA
X-CMS-MailID: 20181017050322epcas1p433dd4010fc4ce778e6fbee625166a675
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20181015123137eucas1p1cf043644b9b40e15c9d2f221f26bef51
References: <20181015123112.9379-1-m.szyprowski@samsung.com>
        <CGME20181015123137eucas1p1cf043644b9b40e15c9d2f221f26bef51@eucas1p1.samsung.com>
        <20181015123112.9379-7-m.szyprowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marek,

On 2018년 10월 15일 21:31, Marek Szyprowski wrote:
> On Exynos SoCs enabling MCT driver is required even if ARM Architected
> Timer driver is used to for managing timer hardware and clock source
> events.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  arch/arm64/Kconfig.platforms | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> index 51bc479334a4..7cc687580fad 100644
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -62,6 +62,7 @@ config ARCH_BRCMSTB
>  config ARCH_EXYNOS
>  	bool "ARMv8 based Samsung Exynos SoC family"
>  	select COMMON_CLK_SAMSUNG
> +	select CLKSRC_EXYNOS_MCT
>  	select EXYNOS_PM_DOMAINS if PM_GENERIC_DOMAINS
>  	select EXYNOS_PMU
>  	select HAVE_S3C2410_WATCHDOG if WATCHDOG
> 

I tested it on Exynos5433-based TM2 board.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Tested-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
