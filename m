Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752594AbeCMOMj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 10:12:39 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:45718 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752202AbeCMOMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 10:12:38 -0400
From: Patrice CHOTARD <patrice.chotard@st.com>
To: Yannick FERTRE <yannick.fertre@st.com>,
        Vikas MANOCHA <vikas.manocha@st.com>, Tom Rini <trini@konsulko.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Philippe CORNU <philippe.cornu@st.com>,
        Patrick DELAUNAY <patrick.delaunay@st.com>,
        Christophe KERELLO <christophe.kerello@st.com>,
        Archit Taneja <architt@codeaurora.org>,
        "Andrzej Hajda" <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        "Brian Norris" <briannorris@chromium.org>,
        Bhumika Goyal <bhumirks@gmail.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Albert Aribaud <albert.u.boot@aribaud.net>,
        Simon Glass <sjg@chromium.org>, Anatolij Gustschin <agust@denx.de>,
        Thierry Reding <thierry.reding@gmail.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 04/10] otm
Thread-Topic: [PATCH v3 04/10] otm
Thread-Index: AQHTutJIGdqIKiNUrUiEl2XLTYzuaqPOJCwA
Date: Tue, 13 Mar 2018 14:12:17 +0000
Message-ID: <34cdaaf5-7d9b-f8af-bdc2-3c022778d7f4@st.com>
References: <1520949014-21468-1-git-send-email-yannick.fertre@st.com>
 <1520949014-21468-8-git-send-email-yannick.fertre@st.com>
In-Reply-To: <1520949014-21468-8-git-send-email-yannick.fertre@st.com>
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
Content-ID: <F92E731C5554BF42BA29535FD9730295@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-13_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2DEChTN011109

Hi Yannick

There is a problem with patch 4. I received two patches 04/10, this one 
and [PATCH v3 04/10] video: add support of panel OTM8009A.

Patrice

On 03/13/2018 02:50 PM, yannick fertre wrote:
> ---
>   drivers/video/orisetech_otm8009a.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/video/orisetech_otm8009a.c b/drivers/video/orisetech_otm8009a.c
> index 81b11d7..aa8139a 100644
> --- a/drivers/video/orisetech_otm8009a.c
> +++ b/drivers/video/orisetech_otm8009a.c
> @@ -289,9 +289,11 @@ static int otm8009a_panel_probe(struct udevice *dev)
>   	struct otm8009a_panel_priv *priv = dev_get_priv(dev);
>   	int ret;
>   
> -	/* reset panel must be done before probe */
> +	/* reset panel */
>   	dm_gpio_set_value(&priv->reset, true);
>   
> +	mdelay(1);
> +
>   	if (IS_ENABLED(CONFIG_DM_REGULATOR) && priv->reg) {
>   		dev_err(dev, "enable regulator '%s'\n", priv->reg->name);
>   		ret = regulator_set_enable(priv->reg, true);
> 
