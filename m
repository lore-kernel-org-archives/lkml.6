Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030933AbeCANvQ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 08:51:16 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:58336 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1030462AbeCANvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 08:51:14 -0500
From: Fabien DESSENNE <fabien.dessenne@st.com>
To: Jassi Brar <jassisinghbrar@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Loic PALLARDY <loic.pallardy@st.com>,
        Arnaud POULIQUEN <arnaud.pouliquen@st.com>,
        "Ludovic BARRE" <ludovic.barre@st.com>
Subject: Re: mailbox: return error in mbox_request_channel_byname
Thread-Topic: mailbox: return error in mbox_request_channel_byname
Thread-Index: AQHTsWRbRTLaSOWjkUavH29cKnAvWw==
Date: Thu, 1 Mar 2018 13:51:10 +0000
Message-ID: <58e2326d-e940-bae5-99e3-5b316caac297@st.com>
References: <1519899374-21297-1-git-send-email-fabien.dessenne@st.com>
In-Reply-To: <1519899374-21297-1-git-send-email-fabien.dessenne@st.com>
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
Content-ID: <7AF2958C9591D246968974ED1A47A7C9@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-01_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w21DpOqI028105

oops! you can forget this patch, the original implementation is correct

BR

Fabien


On 01/03/18 11:16, Fabien DESSENNE wrote:
> If 'name' is not found in the "mbox-names" list, return an error
>
> Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
> ---
>   drivers/mailbox/mailbox.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
> index 674b35f..a31970a 100644
> --- a/drivers/mailbox/mailbox.c
> +++ b/drivers/mailbox/mailbox.c
> @@ -391,11 +391,12 @@ struct mbox_chan *mbox_request_channel_byname(struct mbox_client *cl,
>   
>   	of_property_for_each_string(np, "mbox-names", prop, mbox_name) {
>   		if (!strncmp(name, mbox_name, strlen(name)))
> -			break;
> +			return mbox_request_channel(cl, index);
>   		index++;
>   	}
>   
> -	return mbox_request_channel(cl, index);
> +	dev_err(cl->dev, "%s() mbox %s not found\n", __func__, name);
> +	return ERR_PTR(-EINVAL);
>   }
>   EXPORT_SYMBOL_GPL(mbox_request_channel_byname);
>   
