Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751584AbeBBLVH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 06:21:07 -0500
Received: from mail-wm0-f50.google.com ([74.125.82.50]:37110 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751129AbeBBLU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 06:20:59 -0500
X-Google-Smtp-Source: AH8x225dd1pQTG9wQDkPoCeN0CI3pL99X90G/ib+Mzemo6KIVpvxBZrNgs0M3badVai1GPfZocDIFQ==
Subject: Re: [PATCH v3 2/5] crypto: caam: Fix endless loop when RNG is already
 initialized
To: =?UTF-8?Q?Horia_Geant=c4=83?= <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Fabio Estevam <fabio.estevam@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "lukas.auer@aisec.fraunhofer.de" <lukas.auer@aisec.fraunhofer.de>,
        "rui.silva@linaro.org" <rui.silva@linaro.org>,
        "ryan.harkin@linaro.org" <ryan.harkin@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
References: <1517364040-27607-1-git-send-email-pure.logic@nexus-software.ie>
 <1517364040-27607-3-git-send-email-pure.logic@nexus-software.ie>
 <VI1PR0402MB334297558BB1984131546B1D98FA0@VI1PR0402MB3342.eurprd04.prod.outlook.com>
From: "Bryan O'Donoghue" <pure.logic@nexus-software.ie>
Message-ID: <78ad6a62-190c-e4fe-dd23-e1d058f9bbb2@nexus-software.ie>
Date: Fri, 2 Feb 2018 11:20:56 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <VI1PR0402MB334297558BB1984131546B1D98FA0@VI1PR0402MB3342.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/02/18 12:16, Horia Geantã wrote:
> If the loop cannot exit based on value of "ret" != -EAGAIN, then it means
> caam_probe() will eventually fail due to ret == -EAGAIN:
> 	if (ret) {
> 		dev_err(dev, "failed to instantiate RNG");
> 		goto caam_remove;
> 	}

For me it's an endless loop applying the first two

https://patchwork.ozlabs.org/patch/866460/
https://patchwork.ozlabs.org/patch/866462/

but not this one

https://patchwork.ozlabs.org/patch/865890/

> Please provide more details, so that the root cause is found and fixed.

np

---
bod
