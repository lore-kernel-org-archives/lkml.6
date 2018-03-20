Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753439AbeCTNWS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 09:22:18 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:35415 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753328AbeCTNWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 09:22:15 -0400
From: Amelie DELAUNAY <amelie.delaunay@st.com>
To: Wei Yongjun <weiyongjun1@huawei.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "Alexandre TORGUE" <alexandre.torgue@st.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH -next] phy: stm32: fix using 0 as NULL pointer warnings
Thread-Topic: [PATCH -next] phy: stm32: fix using 0 as NULL pointer warnings
Thread-Index: AQHTwE1T9yxYqAvzE0W136BfJWtbMqPZC24A
Date: Tue, 20 Mar 2018 13:21:48 +0000
Message-ID: <3d799714-6e2c-658e-b1f2-def58584c356@st.com>
References: <1521551982-154471-1-git-send-email-weiyongjun1@huawei.com>
In-Reply-To: <1521551982-154471-1-git-send-email-weiyongjun1@huawei.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.47]
Content-Type: text/plain; charset="utf-8"
Content-ID: <CC214E7B1144D74BA445EB99CD1545CE@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-20_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2KDMOpW013045



On 03/20/2018 02:19 PM, Wei Yongjun wrote:
> Fixes the following sparse warnings:
> 
> drivers/phy/st/phy-stm32-usbphyc.c:331:42: warning:
>   Using plain integer as NULL pointer
> drivers/phy/st/phy-stm32-usbphyc.c:344:52: warning:
>   Using plain integer as NULL pointer
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>   drivers/phy/st/phy-stm32-usbphyc.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/phy/st/phy-stm32-usbphyc.c b/drivers/phy/st/phy-stm32-usbphyc.c
> index bc4e78a..48d4086 100644
> --- a/drivers/phy/st/phy-stm32-usbphyc.c
> +++ b/drivers/phy/st/phy-stm32-usbphyc.c
> @@ -328,7 +328,7 @@ static int stm32_usbphyc_probe(struct platform_device *pdev)
>   	if (IS_ERR(usbphyc->base))
>   		return PTR_ERR(usbphyc->base);
>   
> -	usbphyc->clk = devm_clk_get(dev, 0);
> +	usbphyc->clk = devm_clk_get(dev, NULL);
>   	if (IS_ERR(usbphyc->clk)) {
>   		ret = PTR_ERR(usbphyc->clk);
>   		dev_err(dev, "clk get failed: %d\n", ret);
> @@ -341,7 +341,7 @@ static int stm32_usbphyc_probe(struct platform_device *pdev)
>   		return ret;
>   	}
>   
> -	usbphyc->rst = devm_reset_control_get(dev, 0);
> +	usbphyc->rst = devm_reset_control_get(dev, NULL);
>   	if (!IS_ERR(usbphyc->rst)) {
>   		reset_control_assert(usbphyc->rst);
>   		udelay(2);
> 

Reviewed-by: Amelie Delaunay <amelie.delaunay@st.com>

Thanks,
Amelie
