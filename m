Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754830AbeDCHaU convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 03:30:20 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:19718 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753267AbeDCHaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 03:30:18 -0400
From: Amelie DELAUNAY <amelie.delaunay@st.com>
To: Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Mark Brown <broonie@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "Alexandre TORGUE" <alexandre.torgue@st.com>
CC: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ldv-project@linuxtesting.org" <ldv-project@linuxtesting.org>
Subject: RE: [PATCH] spi: stm32: Fix error handling in stm32_spi_probe()
Thread-Topic: [PATCH] spi: stm32: Fix error handling in stm32_spi_probe()
Thread-Index: AQHTyGD5P5VwJj4yIEKyiuAgFvxYGKPuqJew
Date: Tue, 3 Apr 2018 07:24:47 +0000
Message-ID: <1c12d20a40384fc78262bcd82c68ba6a@SFHDAG3NODE2.st.com>
References: <1522439684-7510-1-git-send-email-khoroshilov@ispras.ru>
In-Reply-To: <1522439684-7510-1-git-send-email-khoroshilov@ispras.ru>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.44]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-04-03_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> -----Original Message-----
> From: Alexey Khoroshilov [mailto:khoroshilov@ispras.ru]
> Sent: vendredi 30 mars 2018 21:55
> To: Mark Brown <broonie@kernel.org>; Amelie DELAUNAY
> <amelie.delaunay@st.com>; Maxime Coquelin
> <mcoquelin.stm32@gmail.com>; Alexandre TORGUE
> <alexandre.torgue@st.com>
> Cc: Alexey Khoroshilov <khoroshilov@ispras.ru>; linux-spi@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; ldv-
> project@linuxtesting.org
> Subject: [PATCH] spi: stm32: Fix error handling in stm32_spi_probe()
> 
> clk_get_rate() is below clk_prepare_enable(), so its error should lead to goto
> err_clk_disable, not to err_master_put.
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
> ---
>  drivers/spi/spi-stm32.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c index
> ba9743fa2326..ad1e55d3d5d5 100644
> --- a/drivers/spi/spi-stm32.c
> +++ b/drivers/spi/spi-stm32.c
> @@ -1129,7 +1129,7 @@ static int stm32_spi_probe(struct platform_device
> *pdev)
>  	if (!spi->clk_rate) {
>  		dev_err(&pdev->dev, "clk rate = 0\n");
>  		ret = -EINVAL;
> -		goto err_master_put;
> +		goto err_clk_disable;
>  	}
> 
>  	spi->rst = devm_reset_control_get_exclusive(&pdev->dev, NULL);
> --
> 2.7.4

Thanks for the patch!

Reviewed-by: Amelie Delaunay <amelie.delaunay@st.com>

Regards,
Amelie
