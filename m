Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E6BECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 05:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E7E0206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 05:35:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="mWEdekJ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E7E0206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbeGSGQs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 02:16:48 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:44819 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbeGSGQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 02:16:47 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180719053526euoutp02c2ef51d9081a7f8952288f5759a79eca~Crlpyphm03040430404euoutp028
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 05:35:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180719053526euoutp02c2ef51d9081a7f8952288f5759a79eca~Crlpyphm03040430404euoutp028
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1531978526;
        bh=b6skn4A3sgM1PISM05txzhxdy//QwMDvAQTHtqLL/hE=;
        h=Subject:To:From:Date:In-Reply-To:References:From;
        b=mWEdekJ81xWq0bsTOj+F3iSf27ifPwpNEVIBGEuepPCJ8+OtJ25EDEZ/SBAckdf8A
         fYIUDUwYcv634GNPSB5BKrzTlo1O85mcV6hPHQObhRUF/r//ch/3CgZhsEZAIOaxxU
         j1301Dxh3KtxUrvlb5icS47fbNEWztI4C0UBvr5g=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180719053525eucas1p2e95ad3327a0fd97e2e52e5995dd405c4~Crloa-d9W1529415294eucas1p2x;
        Thu, 19 Jul 2018 05:35:25 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id B8.D7.05751.C13205B5; Thu, 19
        Jul 2018 06:35:24 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20180719053524eucas1p255845c6da0e22ce8916f5855904655db~CrlnlC3eH2515425154eucas1p2a;
        Thu, 19 Jul 2018 05:35:24 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20180719053524eusmtrp26a0e330eee98bf38df8e3bfb74128c51~CrlnWTQ2S1932719327eusmtrp2n;
        Thu, 19 Jul 2018 05:35:24 +0000 (GMT)
X-AuditID: cbfec7f4-c47ff70000001677-58-5b50231c071e
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id E3.54.04183.B13205B5; Thu, 19
        Jul 2018 06:35:24 +0100 (BST)
Received: from [180.236.133.244] (unknown [180.236.133.244]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20180719053520eusmtip126acd89003f17184303b88b234320529~CrlkXIRCC1607516075eusmtip1Q;
        Thu, 19 Jul 2018 05:35:20 +0000 (GMT)
Subject: Re: [PATCH] i2c: exynos5: Describe the hardware variant for
 readability
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Andi Shyti <andi@etezian.org>, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Andrzej Hajda <a.hajda@samsung.com>
Date:   Thu, 19 Jul 2018 14:35:18 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
        Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180718195404.5095-1-krzk@kernel.org>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLKsWRmVeSWpSXmKPExsWy7djP87oyygHRBjcfW1gs/vGcyaL/8Wtm
        i/PnN7BbbHp8jdWi4+8XRovLu+awWcw4v4/JYuWJWcwOHB7Xl3xi9ti0qpPNY/OSeo+Tp56w
        eHzeJBfAGsVlk5Kak1mWWqRvl8CVMWHBU/aCDvmK/Y8qGhjXSXQxcnJICJhIdF76ywxiCwms
        YJS4tMCgi5ELyP7CKLF31mNGCOczo8S1+/tZYTp2PP4IlVjOKPF8331WCOcjo8S0C1sZQaqE
        BYIkTjRMZQFJiAhMZJK4/PcuWIJNQFPi7+abbCA2i4CqxNWbq4DiHByiAjESv3dZg4R5BQQl
        Ts58wgJicwJtm7vtE9hmZgF5ie1v5zBD2OISt57MZwKZLyGwil1iSt9pVojmMonnt48xQ5zq
        InGmvR3qbGGJV8e3sEPYMhL/d4I0g9j1Ek0zrzBDDOpglDixeDkbRMJa4vDxi6wgxzEDHb1+
        lz5E2FGia8ciFpCwhACfxI23ghD38ElM2jadGSLMK9HRJgRRrShx/+xWqGvEJZZe+Ao13EPi
        9I8upgmMirOQfDwLyZezkHw5C+GGBYwsqxjFU0uLc9NTi43yUsv1ihNzi0vz0vWS83M3MQIT
        0el/x7/sYNz1J+kQowAHoxIP74H/vtFCrIllxZW5hxglOJiVRHj3nvSPFuJNSaysSi3Kjy8q
        zUktPsQozcGiJM4bp1EXJSSQnliSmp2aWpBaBJNl4uCUamDkqvvotKLkhfBprqI/LFMlQip7
        Gr1d/H3MNQ6uTl49YxUrQ8i5gtyVumzfJP7MYOhSvP2ieQ6zzafvOp/nr823KDAqX7vzaMnW
        I40P5mp6tnqYvWdoM3sarVczv2hCoOKx2UySwbMdDKadeZfwXzTbSDY5ZI3fa473Ooc/T9L1
        CZfNi7jm76HEUpyRaKjFXFScCAACHR53QAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKIsWRmVeSWpSXmKPExsVy+t/xu7oyygHRBvvPMFks/vGcyaL/8Wtm
        i/PnN7BbbHp8jdWi4+8XRovLu+awWcw4v4/JYuWJWcwOHB7Xl3xi9ti0qpPNY/OSeo+Tp56w
        eHzeJBfAGqVnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9nk5Kak1mWWqRv
        l6CXMWHBU/aCDvmK/Y8qGhjXSXQxcnJICJhI7Hj8kbGLkYtDSGApo0TLm4fsEAlxid3z3zJD
        2MISf651sUEUvWeUmHNlOiNIQlggSOJEw1QWkISIwEQmidUXJ4IlhATaGSXuPS8AsdkENCX+
        br7JBmLzCthJrF66H2wqi4CqxNWbq8DqRQViJI5OboGqEZQ4OfMJC4jNCXTe3G2fWEFsZgEz
        iXmbHzJD2PIS29/OgbLFJW49mc80gVFwFpL2WUhaZiFpmYWkZQEjyypGkdTS4tz03GIjveLE
        3OLSvHS95PzcTYzAKNt27OeWHYxd74IPMQpwMCrx8B747xstxJpYVlyZe4hRgoNZSYR370n/
        aCHelMTKqtSi/Pii0pzU4kOMpkDPTWSWEk3OByaAvJJ4Q1NDcwtLQ3Njc2MzCyVx3vMGlVFC
        AumJJanZqakFqUUwfUwcnFINjAvd990XKF5uwJH01O/o6kShmNzGs/WyC4NVrpp6vJHLubw3
        p6TipM2FdMcHyzTdRfK2pRQk7zT4u8ZJ+oEm4+u59vKb2nmc3rRsu/LQPWXPDinOeWezllkr
        MPxirFntV3Pto6TU7K+uv7q/mvP518tVr35QUf1hxyv+cvZZ6X0S7f++11/bqsRSnJFoqMVc
        VJwIAN+i9ZHIAgAA
Message-Id: <20180719053524eucas1p255845c6da0e22ce8916f5855904655db~CrlnlC3eH2515425154eucas1p2a@eucas1p2.samsung.com>
X-CMS-MailID: 20180719053524eucas1p255845c6da0e22ce8916f5855904655db
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180718195434epcas1p1bdabd6d634861e862ef035c57bf32122
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180718195434epcas1p1bdabd6d634861e862ef035c57bf32122
References: <CGME20180718195434epcas1p1bdabd6d634861e862ef035c57bf32122@epcas1p1.samsung.com>
        <20180718195404.5095-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-Jul-18 04:54, Krzysztof Kozlowski wrote:

> The driver supports multiple hardware variants of Exynos I2C controller
> which differ in FIFO depth, handling of interrupts and bus recovery in
> HSI2C_MASTER_ST_LOSE state.
>
> The difference in variant was a single bit set for Exynos7 variants and
> implicit lack of this bit for other variants.
>
> Make each variant explicit which also fixes the GCC warning about
> documentation:
>
>      drivers/i2c/busses/i2c-exynos5.c:223: warning: Function parameter or member 'hw' not described in 'exynos_hsi2c_variant'
>
> No change in functionality.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Maybe changing it to "bool is_exynos7" or sth like that would make it 
little more readable, matter of taste. Anyway:

Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

Regards
Andrzej
> ---
>   drivers/i2c/busses/i2c-exynos5.c | 22 ++++++++++++++--------
>   1 file changed, 14 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-exynos5.c b/drivers/i2c/busses/i2c-exynos5.c
> index de82ad8ff534..c1ce2299a76e 100644
> --- a/drivers/i2c/busses/i2c-exynos5.c
> +++ b/drivers/i2c/busses/i2c-exynos5.c
> @@ -176,7 +176,10 @@
>   
>   #define EXYNOS5_I2C_TIMEOUT (msecs_to_jiffies(100))
>   
> -#define HSI2C_EXYNOS7	BIT(0)
> +enum i2c_type_exynos {
> +	I2C_TYPE_EXYNOS5,
> +	I2C_TYPE_EXYNOS7,
> +};
>   
>   struct exynos5_i2c {
>   	struct i2c_adapter	adap;
> @@ -212,27 +215,30 @@ struct exynos5_i2c {
>   /**
>    * struct exynos_hsi2c_variant - platform specific HSI2C driver data
>    * @fifo_depth: the fifo depth supported by the HSI2C module
> + * @hw: the hardware variant of Exynos I2C controller
>    *
>    * Specifies platform specific configuration of HSI2C module.
>    * Note: A structure for driver specific platform data is used for future
>    * expansion of its usage.
>    */
>   struct exynos_hsi2c_variant {
> -	unsigned int	fifo_depth;
> -	unsigned int	hw;
> +	unsigned int		fifo_depth;
> +	enum i2c_type_exynos	hw;
>   };
>   
>   static const struct exynos_hsi2c_variant exynos5250_hsi2c_data = {
>   	.fifo_depth	= 64,
> +	.hw		= I2C_TYPE_EXYNOS5,
>   };
>   
>   static const struct exynos_hsi2c_variant exynos5260_hsi2c_data = {
>   	.fifo_depth	= 16,
> +	.hw		= I2C_TYPE_EXYNOS5,
>   };
>   
>   static const struct exynos_hsi2c_variant exynos7_hsi2c_data = {
>   	.fifo_depth	= 16,
> -	.hw		= HSI2C_EXYNOS7,
> +	.hw		= I2C_TYPE_EXYNOS7,
>   };
>   
>   static const struct of_device_id exynos5_i2c_match[] = {
> @@ -300,7 +306,7 @@ static int exynos5_i2c_set_timing(struct exynos5_i2c *i2c, bool hs_timings)
>   	 */
>   	t_ftl_cycle = (readl(i2c->regs + HSI2C_CONF) >> 16) & 0x7;
>   	temp = clkin / op_clk - 8 - t_ftl_cycle;
> -	if (i2c->variant->hw != HSI2C_EXYNOS7)
> +	if (i2c->variant->hw != I2C_TYPE_EXYNOS7)
>   		temp -= t_ftl_cycle;
>   	div = temp / 512;
>   	clk_cycle = temp / (div + 1) - 2;
> @@ -424,7 +430,7 @@ static irqreturn_t exynos5_i2c_irq(int irqno, void *dev_id)
>   	writel(int_status, i2c->regs + HSI2C_INT_STATUS);
>   
>   	/* handle interrupt related to the transfer status */
> -	if (i2c->variant->hw == HSI2C_EXYNOS7) {
> +	if (i2c->variant->hw == I2C_TYPE_EXYNOS7) {
>   		if (int_status & HSI2C_INT_TRANS_DONE) {
>   			i2c->trans_done = 1;
>   			i2c->state = 0;
> @@ -571,7 +577,7 @@ static void exynos5_i2c_bus_check(struct exynos5_i2c *i2c)
>   {
>   	unsigned long timeout;
>   
> -	if (i2c->variant->hw != HSI2C_EXYNOS7)
> +	if (i2c->variant->hw != I2C_TYPE_EXYNOS7)
>   		return;
>   
>   	/*
> @@ -612,7 +618,7 @@ static void exynos5_i2c_message_start(struct exynos5_i2c *i2c, int stop)
>   	unsigned long flags;
>   	unsigned short trig_lvl;
>   
> -	if (i2c->variant->hw == HSI2C_EXYNOS7)
> +	if (i2c->variant->hw == I2C_TYPE_EXYNOS7)
>   		int_en |= HSI2C_INT_I2C_TRANS;
>   	else
>   		int_en |= HSI2C_INT_I2C;

