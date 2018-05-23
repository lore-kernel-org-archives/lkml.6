Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754321AbeEWHYf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 03:24:35 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:42114 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754024AbeEWHYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 03:24:32 -0400
From: Patrice CHOTARD <patrice.chotard@st.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2] rtc: st-lpc: add range
Thread-Topic: [PATCH v2] rtc: st-lpc: add range
Thread-Index: AQHT8UUrpcb9JL/gmk+CeRCVXHDUVKQ8ygeA
Date: Wed, 23 May 2018 07:24:14 +0000
Message-ID: <8d2f6057-4d33-6b75-f01e-df06e9426d07@st.com>
References: <20180521204905.7113-1-alexandre.belloni@bootlin.com>
In-Reply-To: <20180521204905.7113-1-alexandre.belloni@bootlin.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.45]
Content-Type: text/plain; charset="utf-8"
Content-ID: <7D736B85E8CE624CB6623264F5C95BE7@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-23_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4N7Ofgm007103

Hi Alexandre

On 05/21/2018 10:49 PM, Alexandre Belloni wrote:
> The RTC has a 64 bit counter.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>   drivers/rtc/rtc-st-lpc.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/rtc/rtc-st-lpc.c b/drivers/rtc/rtc-st-lpc.c
> index 2f1ef2c28740..bee75ca7ff79 100644
> --- a/drivers/rtc/rtc-st-lpc.c
> +++ b/drivers/rtc/rtc-st-lpc.c
> @@ -258,6 +258,8 @@ static int st_rtc_probe(struct platform_device *pdev)
>   	platform_set_drvdata(pdev, rtc);
>   
>   	rtc->rtc_dev->ops = &st_rtc_ops;
> +	rtc->rtc_dev->range_max = U64_MAX;
> +	do_div(rtc->rtc_dev->range_max, rtc->clkrate);
>   
>   	ret = rtc_register_device(rtc->rtc_dev);
>   	if (ret) {
> 

Acked-by: Patrice Chotard <patrice.chotard@st.com>

Patrice
