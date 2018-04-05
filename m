Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751779AbeDEKuE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 06:50:04 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:54921 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751363AbeDEKuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 06:50:03 -0400
From: Amelie DELAUNAY <amelie.delaunay@st.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "Alexandre TORGUE" <alexandre.torgue@st.com>
CC: "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] phy: stm32: Fix printing of wrong uninitialized port
 number
Thread-Topic: [PATCH] phy: stm32: Fix printing of wrong uninitialized port
 number
Thread-Index: AQHTzMMQP2C5d1N8iEiUiCFUh5f97qPx/ZJw
Date: Thu, 5 Apr 2018 10:49:38 +0000
Message-ID: <3d3bad02a48f4d5cb1d6f0db1d108cbf@SFHDAG3NODE2.st.com>
References: <1522921619-5790-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1522921619-5790-1-git-send-email-geert@linux-m68k.org>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.45]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-04-05_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w35AoAna015912

Hi Geert,

Just to let you know, this warning is already fixed by a pending patch I've sent two weeks ago: https://lkml.org/lkml/2018/3/20/424.

Thanks,
Amelie

> -----Original Message-----
> From: Geert Uytterhoeven [mailto:geert@linux-m68k.org]
> Sent: jeudi 5 avril 2018 11:47
> To: Kishon Vijay Abraham I <kishon@ti.com>; Maxime Coquelin
> <mcoquelin.stm32@gmail.com>; Alexandre TORGUE
> <alexandre.torgue@st.com>; Amelie DELAUNAY <amelie.delaunay@st.com>
> Cc: linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> Geert Uytterhoeven <geert@linux-m68k.org>
> Subject: [PATCH] phy: stm32: Fix printing of wrong uninitialized port number
> 
> drivers/phy/st/phy-stm32-usbphyc.c: In function ‘stm32_usbphyc_probe’:
> drivers/phy/st/phy-stm32-usbphyc.c:364: warning: ‘i’ may be used
> uninitialized in this function
> 
> Indeed, during the first loop iteration, "i" is uninitialized.
> However, "i" does not represent the intended PHY instance number to print.
> 
> Fix this by printing the correct variable instead.
> 
> Fixes: 94c358da3a054520 ("phy: stm32: add support for STM32 USB PHY
> Controller (USBPHYC)")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>  drivers/phy/st/phy-stm32-usbphyc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/phy/st/phy-stm32-usbphyc.c b/drivers/phy/st/phy-
> stm32-usbphyc.c
> index bc4e78a19c913dc9..1f682c176fd6239e 100644
> --- a/drivers/phy/st/phy-stm32-usbphyc.c
> +++ b/drivers/phy/st/phy-stm32-usbphyc.c
> @@ -367,8 +367,8 @@ static int stm32_usbphyc_probe(struct
> platform_device *pdev)
>  		if (IS_ERR(phy)) {
>  			ret = PTR_ERR(phy);
>  			if (ret != -EPROBE_DEFER)
> -				dev_err(dev,
> -					"failed to create phy%d: %d\n", i, ret);
> +				dev_err(dev, "failed to create phy%d: %d\n",
> +					port, ret);
>  			goto put_child;
>  		}
> 
> --
> 2.7.4
