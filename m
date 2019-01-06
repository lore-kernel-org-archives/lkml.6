Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F1DC43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 14:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B77C82070B
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 14:58:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbfAFO6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 09:58:47 -0500
Received: from mout.gmx.net ([212.227.17.20]:40781 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726408AbfAFO6q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 09:58:46 -0500
Received: from [192.168.123.38] ([84.118.159.3]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lo3IS-1hDHlL2Jp2-00fxiV; Sun, 06
 Jan 2019 15:58:03 +0100
Subject: Re: [RFC net-next 11/15] net: lora: Add IMST WiMOD
To:     =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        netdev@vger.kernel.org
Cc:     Matthias Brugger <mbrugger@suse.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Marcel Holtmann <marcel@holtmann.org>,
        Dollar Chen <dollar.chen@wtmec.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Michael_R=c3=b6der?= <michael.roeder@avnet.eu>,
        Janus Piwek <jpiwek@arroweurope.com>,
        Jon Ortego <Jon.Ortego@imst.de>,
        Jian-Hong Pan <starnight@g.ncu.edu.tw>,
        Ken Yu <ken.yu@rakwireless.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-arm-kernel@lists.infradead.org
References: <20180701110804.32415-1-afaerber@suse.de>
 <20180701110804.32415-12-afaerber@suse.de>
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
Openpgp: preference=signencrypt
Autocrypt: addr=xypron.glpk@gmx.de; prefer-encrypt=mutual; keydata=
 mQINBE2g3goBEACaikqtClH8OarLlauqv9d9CPndgghjEmi3vvPZJi4jvgrhmIUKwl7q79wG
 IATxJ1UOXIGgriwoBwoHdooOK33QNy4hkjiNFNrtcaNT7uig+BG0g40AxSwVZ/OLmSFyEioO
 BmRqz1Zdo+AQ5RzHpu49ULlppgdSUYMYote8VPsRcE4Z8My/LLKmd7lvCn1kvcTGcOS1hyUC
 4tMvfuloIehHX3tbcbw5UcQkg4IDh4l8XUc7lt2mdiyJwJoouyqezO3TJpkmkayS3L7o7dB5
 AkUwntyY82tE6BU4quRVF6WJ8GH5gNn4y5m3TMDl135w27IIDd9Hv4Y5ycK5sEL3N+mjaWlk
 2Sf6j1AOy3KNMHusXLgivPO8YKcL9GqtKRENpy7n+qWrvyHA9xV2QQiUDF13z85Sgy4Xi307
 ex0GGrIo54EJXZBvwIDkufRyN9y0Ql7AdPyefOTDsGq5U4XTxh6xfsEXLESMDKQMiVMI74Ec
 cPYL8blzdkQc1MZJccU+zAr6yERkUwo1or14GC2WPGJh0y/Ym9L0FhXVkq9e1gnXjpF3QIJh
 wqVkPm4Two93mAL+929ypFr48OIsN7j1NaNAy6TkteIoNUi09winG0tqU5+U944cBMleRQOa
 dw+zQK0DahH4MGQIU0EVos7lVjFetxPjoKJE9SPl/TCSc+e0RwARAQABtChIZWlucmljaCBT
 Y2h1Y2hhcmR0IDx4eXByb24uZ2xwa0BnbXguZGU+iQI4BBMBAgAiAhsDBgsJCAcDAgYVCAIJ
 CgsEFgIDAQIeAQIXgAUCVAqnzgAKCRDEgdu8LAUaxP7AD/9Zwx3SnmrLLc3CqEIcOJP3FMrW
 gLNi5flG4A/WD9mnQAX+6DEpY6AxIagz6Yx8sZF7HUcn1ByDyZPBn8lHk1+ZaWNAD0LDScGi
 Ch5nopbJrpFGDSVnMWUNJJBiVZW7reERpzCJy+8dAxhxCQJLgHHAqPaspGtO7XjRBF6oBQZk
 oJlqbBRFkTcgOI8sDsSpnsfSItZptoaqqm+lZpMCrB5s8x7dsuMEFaRR/4bq1efh8lSq3Kbf
 eSY59MWh49zExRgAb0pwON5SE1X9C84T2hx51QDiWW/G/HvJF2vxF8hCS7RSx0fn/EbPWkM6
 m+O1SncMaA43lx1TvRfPmYhxryncIWcez+YbvH/VqoLtxvz3r3OTH/WEA5J7mu5U1m2lUGNC
 cFN1bDsNoGhdlFZvG/LJJlBClWBWYHqHnnGEqEQJrlie9goBcS8YFUcfqKYpdmp5/F03qigY
 PmrE3ndBFnaOlOT7REEi8t3gmxpriTtGpKytFuwXNty1yK2kMiLRnQKWN7WgK70pbFFO4tyB
 vIhDeXhFmx6pyZHlXjsgbV3H4QbqazqxYOQlfHbkRpUJczuyPGosFe5zH+9eFvqDWYw2qdH+
 b0Nt1r12vFC4Mmj5szi40z3rQrt+bFSfhT+wvW9kZuBB5xEFkTTzWSFZbDTUrdPpn2DjYePS
 sEHKTUhgl7kCDQRNoN4KARAA6WWIVTqFecZHTUXeOfeKYugUwysKBOp8E3WTksnv0zDyLS5T
 ImLI3y9XgAFkiGuKxrJRarDbw8AjLn6SCJSQr4JN+zMu0MSJJ+88v5sreQO/KRzkti+GCQBK
 YR5bpqY520C7EkKr77KHvto9MDvPVMKdfyFHDslloLEYY1HxdFPjOuiMs656pKr2d5P4C8+V
 iAeQlUOFlISaenNe9XRDaO4vMdNy65Xrvdbm3cW2OWCx/LDzMI6abR6qCJFAH9aXoat1voAc
 uoZ5F5NSaXul3RxRE9K+oWv4UbXhVD242iPnPMqdml6hAPYiNW0dlF3f68tFSVbpqusMXfiY
 cxkNECkhGwNlh/XcRDdb+AfpVfhYtRseZ0jEYdXLpUbq1SyYxxkDEvquncz2J9urvTyyXwsO
 QCNZ0oV7UFXf/3pTB7sAcCiAiZPycF4KFS4b7gYo9wBROu82B9aYSCQZnJFxX1tlbvvzTgc+
 ecdQZui+LF/VsDPYdj2ggpgxVsZX5JU+5KGDObBZC7ahOi8Jdy0ondqSRwSczGXYzMsnFkDH
 hKGJaxDcUUw4q+QQuzuAIZZ197lnKJJv3Vd4N0zfxrB0krOcMqyMstvjqCnK/Vn4iOHUiBgA
 OmtIhygAsO4TkFwqVwIpC+cj2uw/ptN6EiKWzXOWsLfHkAE+D24WCtVw9r8AEQEAAYkCHwQY
 AQIACQIbDAUCVAqoNwAKCRDEgdu8LAUaxIkbD/wMTA8n8wgthSkPvhTeL13cO5/C3/EbejQU
 IJOS68I2stnC1ty1FyXwAygixxt3GE+3BlBVNN61dVS9SA498iO0ApxPsy4Q7vvQsF7DuJsC
 PdZzP/LZRySUMif3qAmIvom8fkq/BnyHhfyZ4XOl1HMr8pMIf6/eCBdgIvxfdOz79BeBBJzr
 qFlNpxVP8xrHiEjZxU965sNtDSD/1/9w82Wn3VkVisNP2MpUhowyHqdeOv2uoG6sUftmkXZ8
 RMo+PY/iEIFjNXw1ufHDLRaHihWLkXW3+bS7agEkXo0T3u1qlFTI6xn8maR9Z0eUAjxtO6qV
 lGF58XeVhfunbQH8Kn+UlWgqcMJwBYgM69c65Dp2RCV7Tql+vMsuk4MT65+Lwm88Adnn6ppQ
 S2YmNgDtlNem1Sx3JgCvjq1NowW7q3B+28Onyy2fF0Xq6Kyjx7msPj3XtDZQnhknBwA7mqSZ
 DDw0aNy1mlCv6KmJBRENfOIZBFUqXCtODPvO5TcduJV/5XuxbTR/33Zj7ez2uZkOEuTs/pPN
 oKMATC28qfg0qM59YjDrrkdXi/+iDe7qCX93XxdIxpA5YM/ZiqgwziJX8ZOKV7UDV+Ph5KwF
 lTPJMPdQZYXDOt5DjG5l5j0cQWqE05QtYR/V6g8un6V2PqOs9WzaT/RB12YFcaeWlusa8Iqs Eg==
Message-ID: <53180657-d3f7-21ea-cbb5-cf591ee4755e@gmx.de>
Date:   Sun, 6 Jan 2019 15:57:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20180701110804.32415-12-afaerber@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:TBPLn1Mj0jJMH8Zv8YLZ9EvN/EecJLQ/+NuoLN5G2ZdAQgu1uia
 dcSoZdOXLPehQ9Ff9GL3RcV8l+Ffqf2dKWUORY6a8nCocNJQ3i1jvnex1Nrgy6QoPDqYGWw
 yot2Pjl7UkP27Nut4nnxv9nBgmg3+jpmP0ZwYSRXsos/tmCDgUrf5cbGeSGJlLOsb5+6Xwz
 Nbf4Uleyrobrk0PvhGASw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:J2hbhKnO8RI=:3o9Ncem7hDOa4tKOa1myJ6
 vdty9C0q1eLs2I4oIzrFZZ6bBV2fYsoZPdZF390gyxbhrtv/PQ3oErqn5rNNcPJT9webwg/7z
 DbJfF7xmcwadcvJOutoaA9B4AEP1eMVYatuMA3r4F6bmQ37rKE1uDuc50xNjdoxwGfwNFJRgU
 TZIsSg4/Lk36Td+2+T4aRym5MZ00glVc4HJ945oZx+8vX3JO0zz3cXr3/TCXC082Wu2XtsX3I
 ysaXFHswCG9zlHp7+OwAq/2/mIgp8mTTaf2MP1xB7y28nejBUzbrmROt9fYorsuKCEZEiwlkJ
 Z7Zu4TCj72MGC22KLguHORuOl4S1kXfqRWlkRyJ/exNnH3SYQdXe5bMTDX90VH2vMzKuhFu9e
 W94TSYc/xZkmYNkeXHWe0XvcDV2+5XJdCyWv3SFnhroAWU9hZPW1HmxqCXiOfMi9NuN3R7DQo
 nyUcs1USuYlRSW4hn/Olo1A00mbPz23FDCp7Oky2+FVv6q4gev8JxWOD242FdjvQZBeL7JfJ4
 hC93VkCJcJ7fG5anOWMDsqEX92ppXGVOWRGD+19gsNVO7sWlTBxuIKBeJ9MKXkZNb7pJYFalL
 7Tf/Kwsqx+yNIYJfetRLR3fu2BE0ZQLJBNmOmBfHlLYgvR9ADU3yPSgKbnO8ebsnUexOAp2Mm
 TXsVZVFDV3E2fTrvOYTQmxFT99KoNyrVOjkr/oaUtPnzIDT28I2iX9ChzgZI3EuVZDqRy+mFx
 KlmRb1gIhXohHLIjTdQXIdkUqt0TtgSGXR/Ku+eHPxFhBpF9q6plxRbs2IJqd4Ysw7hN2JkxH
 nEBI4a9PpL/RpmSMK0BAUr9u8z98Nlw1oi+dTd0fUT0Q59lrMz4o8ZkfWx19H1j/Z2XqY02dK
 kt9VjXzvBz4V1ijFTy+DgwL/vkJEpfcUGWCS7WF4Q8XCtamlW8P7mSQUWeNgJX
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/1/18 1:08 PM, Andreas Färber wrote:
> The IMST WiMOD uses a SLIP based binary UART protocol. Two separate
> firmwares are available. By default it ships with a LoRaWAN firmware.
> The alternative firmware is a custom P2P addressing mode based on LoRa.
> 
> Cc: Jon Ortego <Jon.Ortego@imst.de>
> Signed-off-by: Andreas Färber <afaerber@suse.de>
> ---
>  drivers/net/lora/Kconfig  |   8 +
>  drivers/net/lora/Makefile |   3 +
>  drivers/net/lora/wimod.c  | 597 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 608 insertions(+)
>  create mode 100644 drivers/net/lora/wimod.c
> 
> diff --git a/drivers/net/lora/Kconfig b/drivers/net/lora/Kconfig
> index 940bd2cbe106..2e05caef8645 100644
> --- a/drivers/net/lora/Kconfig
> +++ b/drivers/net/lora/Kconfig
> @@ -31,6 +31,14 @@ config LORA_SX1276
>  	help
>  	  Semtech SX1272/1276/1278
>  
> +config LORA_WIMOD
> +	tristate "IMST WiMOD driver"

scripts/checkpatch.pl throws this warning:
WARNING: please write a paragraph that describes the config symbol fully

IMST has multiple products related to "WiMOD":
* WiMOD iC880A
* WiMOD module iM871A
* WSA01-iM880B - WiMOD Shield for Arduino
* iM880B-L - Long Range Radio Module

And IMST is not very consistent about what is called "WiMOD". So this
leaves me clueless concerning what this Kconfig option is about. Please,
provide a description.

There are dozens of warnings given by scripts/checkpatch. Please, have a
look at them.

Best regards

Heinrich
