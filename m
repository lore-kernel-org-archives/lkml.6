Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C401C43444
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 487072184E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="tLxWo5EI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbeLRLZA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 06:25:00 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:53425 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbeLRLY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 06:24:59 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181218112457euoutp017a4101780afdcb3fb540ef337bc8b5ed~xaaNyYQe80259602596euoutp01W
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 11:24:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181218112457euoutp017a4101780afdcb3fb540ef337bc8b5ed~xaaNyYQe80259602596euoutp01W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1545132297;
        bh=Fn2lPujTaFWPaBPTiAGvyln8G1YyYThIpI0wJbDCuyw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=tLxWo5EIDRBqnRDh7xjmvJ7kULVpTJoj2KCdVB7JQspn6cSrNb20oKVsxC1DKLjkp
         5U2fULvdtv/vzGXPGGfScaO6TLSDQjceremlxB/BviKb+fkLRhDtEsC8lMbFqtS4oO
         VbDt+vpvC3YKl7tQZ+7pxgxBzl/bsNFYYvvfK8q4=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181218112457eucas1p1591ca5aa0a3e3cdea6268224ca7adbca~xaaNJJ-Ms1106911069eucas1p1N;
        Tue, 18 Dec 2018 11:24:57 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 2E.E2.04441.809D81C5; Tue, 18
        Dec 2018 11:24:56 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181218112456eucas1p20bf31d210625499084754ad815be677c~xaaMaXtIb2617226172eucas1p2M;
        Tue, 18 Dec 2018 11:24:56 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181218112456eusmtrp2dc76df3486418d3280e6832867527508~xaaMLvBx90147001470eusmtrp2I;
        Tue, 18 Dec 2018 11:24:56 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-9b-5c18d9087ef2
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 39.C0.04128.809D81C5; Tue, 18
        Dec 2018 11:24:56 +0000 (GMT)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181218112455eusmtip265670bd80d3afdcde1d5c36ecfb2a929~xaaLshy1A3126131261eusmtip21;
        Tue, 18 Dec 2018 11:24:55 +0000 (GMT)
Subject: Re: [RFC/RFT 09/10] i2c: s3c2410: use core helper to mark adapter
 suspended
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-i2c@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <2b73c71b-2b73-7132-3629-cf700b251fdb@samsung.com>
Date:   Tue, 18 Dec 2018 12:24:56 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181210210310.12677-10-wsa+renesas@sang-engineering.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKKsWRmVeSWpSXmKPExsWy7djPc7ocNyViDF4ds7R4c3w6k0X/49fM
        FufPb2C32PT4GqtFx98vjBaXd81hs/jce4TRYuvLd0wWM87vY7LoO+fuwOWxaVUnm8fmJfUe
        7/ddZfN4tnA9i8fnTXIBrFFcNimpOZllqUX6dglcGWuOxhfs5au4tOUtUwPjLe4uRk4OCQET
        ieddmxlBbCGBFYwSK5eoQ9hfGCVa1nh2MXIB2Z8ZJSa1NDHBNNxYOIUZIrGcUWLumy/sEB3v
        GSWmT5QFsYUFwiSWHP4JFhcRCJCY8H8hK0gDs8B0Jonmt6vAJrEJGEp0ve1iA7F5BewkDi45
        wApiswioSkxbMBksLioQI/G0YR8LRI2gxMmZT4BsDg5OAXeJCzvtQcLMAvIS29/OYYawxSVu
        PZnPBLJLQuAQu8TshmPsEFe7SGxY94kNwhaWeHV8C1RcRuL/TpiGZkaJ9hmz2CGcHkaJrXN2
        QHVYSxw+fpEVZDOzgKbE+l36EGFHiUezFzCDhCUE+CRuvBWEOIJPYtK26VBhXomONiGIajWJ
        WcfXwa09eOES8wRGpVlIPpuF5J1ZSN6ZhbB3ASPLKkbx1NLi3PTUYsO81HK94sTc4tK8dL3k
        /NxNjMDEdPrf8U87GL9eSjrEKMDBqMTDy3BCPEaINbGsuDL3EKMEB7OSCO+tUokYId6UxMqq
        1KL8+KLSnNTiQ4zSHCxK4rzVDA+ihQTSE0tSs1NTC1KLYLJMHJxSDYyBP81FZ6YeLqhZukv5
        Ie/DHd81p3jI28W1z9m4fV56n7tjyLraxcrP8mJFd/w6p3NAcW21cxXPCfcGzg1O0mc3pa5f
        JOj0+JHn48Zlk3e4GL8+4uq49d37W+FpblukAve0mm/f+lOQTeLpvurox1WbMie6h2ronRAP
        uzFpSaLdj4PeipNXW2YqsRRnJBpqMRcVJwIA+moES0gDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsVy+t/xe7ocNyViDF4/Z7Z4c3w6k0X/49fM
        FufPb2C32PT4GqtFx98vjBaXd81hs/jce4TRYuvLd0wWM87vY7LoO+fuwOWxaVUnm8fmJfUe
        7/ddZfN4tnA9i8fnTXIBrFF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2
        NimpOZllqUX6dgl6GWuOxhfs5au4tOUtUwPjLe4uRk4OCQETiRsLpzB3MXJxCAksZZRo2nmJ
        ESIhI3FyWgMrhC0s8edaFxtE0VtGiTMXIYqEBcIklhz+yQ5iiwj4SRxa9o4ZxGYWmM4kcekH
        H4gtJHCNUWL1XXkQm03AUKLrLcggTg5eATuJg0sOgC1gEVCVmLZgMlCcg0NUIEbi2YJqiBJB
        iZMzn7CAhDkF3CUu7LSHmK4u8WfeJahN8hLb386BssUlbj2ZzzSBUWgWku5ZSFpmIWmZhaRl
        ASPLKkaR1NLi3PTcYiO94sTc4tK8dL3k/NxNjMBI3Hbs55YdjF3vgg8xCnAwKvHwMpwQjxFi
        TSwrrsw9xCjBwawkwnurVCJGiDclsbIqtSg/vqg0J7X4EKMp0GsTmaVEk/OBSSKvJN7Q1NDc
        wtLQ3Njc2MxCSZz3vEFllJBAemJJanZqakFqEUwfEwenVAMj0/27906duHZnxhyLbUfzW4R/
        yGuuWHTq65aIlAkzq+a1b1h3xGDx6zrfrYeljKb1XLjVt33LIdbKxnebdKIfvtyTZbV5pnT3
        dlkvH/PDnjxd1ezsK1RYvmgIzjqwpIbppW3rSctrt0x9oxTuHDiVvOecYu+f/rvbPPZPt/DW
        k3jzmdU7807+bSWW4oxEQy3mouJEAKQ1mpjaAgAA
X-CMS-MailID: 20181218112456eucas1p20bf31d210625499084754ad815be677c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181210210451epcas5p2f186c09d2e89f30cdb7106272e5e4709
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181210210451epcas5p2f186c09d2e89f30cdb7106272e5e4709
References: <20181210210310.12677-1-wsa+renesas@sang-engineering.com>
        <CGME20181210210451epcas5p2f186c09d2e89f30cdb7106272e5e4709@epcas5p2.samsung.com>
        <20181210210310.12677-10-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2018-12-10 22:03, Wolfram Sang wrote:
> Rejecting transfers should be handled by the core. Also, this will
> ensure proper locking which was forgotten in this open coded version.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Works fine on Odroid U3.

> ---
>  drivers/i2c/busses/i2c-s3c2410.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
> index 2f2e28d60ef5..7c76edb25514 100644
> --- a/drivers/i2c/busses/i2c-s3c2410.c
> +++ b/drivers/i2c/busses/i2c-s3c2410.c
> @@ -104,7 +104,6 @@ enum s3c24xx_i2c_state {
>  struct s3c24xx_i2c {
>  	wait_queue_head_t	wait;
>  	kernel_ulong_t		quirks;
> -	unsigned int		suspended:1;
>  
>  	struct i2c_msg		*msg;
>  	unsigned int		msg_num;
> @@ -703,9 +702,6 @@ static int s3c24xx_i2c_doxfer(struct s3c24xx_i2c *i2c,
>  	unsigned long timeout;
>  	int ret;
>  
> -	if (i2c->suspended)
> -		return -EIO;
> -
>  	ret = s3c24xx_i2c_set_master(i2c);
>  	if (ret != 0) {
>  		dev_err(i2c->dev, "cannot get bus (error %d)\n", ret);
> @@ -1246,7 +1242,7 @@ static int s3c24xx_i2c_suspend_noirq(struct device *dev)
>  {
>  	struct s3c24xx_i2c *i2c = dev_get_drvdata(dev);
>  
> -	i2c->suspended = 1;
> +	i2c_mark_adapter_suspended(&i2c->adap, true);
>  
>  	if (!IS_ERR(i2c->sysreg))
>  		regmap_read(i2c->sysreg, EXYNOS5_SYS_I2C_CFG, &i2c->sys_i2c_cfg);
> @@ -1267,7 +1263,7 @@ static int s3c24xx_i2c_resume_noirq(struct device *dev)
>  		return ret;
>  	s3c24xx_i2c_init(i2c);
>  	clk_disable(i2c->clk);
> -	i2c->suspended = 0;
> +	i2c_mark_adapter_suspended(&i2c->adap, false);
>  
>  	return 0;
>  }

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

