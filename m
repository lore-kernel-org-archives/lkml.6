Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752779AbeBEKHi (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 05:07:38 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:45438 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752317AbeBEKH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 05:07:28 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180205100726euoutp0264f21ee923b0e49038a0f526df08741d~QZgUOWqR30466304663euoutp02X
X-AuditID: cbfec7f4-f790c6d0000075d3-58-5a782cddb4ca
MIME-version: 1.0
Content-type: text/plain; charset="utf-8"
Subject: Re: [PATCH] drm/bridge/synopsys: dsi: Add read feature
To: Philippe Cornu <philippe.cornu@st.com>,
        Archit Taneja <architt@codeaurora.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Brian Norris <briannorris@chromium.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Bhumika Goyal <bhumirks@gmail.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Sandy Huang <hjc@rock-chips.com>,
        Heiko Stubner <heiko@sntech.de>, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Cc: Yannick Fertre <yannick.fertre@st.com>,
        Vincent Abriou <vincent.abriou@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
From: Andrzej Hajda <a.hajda@samsung.com>
Message-id: <81cb1f26-96f0-bdc6-28bc-4a7bda5a9459@samsung.com>
Date: Mon, 05 Feb 2018 11:07:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
In-reply-to: <20180204213104.17834-1-philippe.cornu@st.com>
Content-transfer-encoding: 8bit
Content-language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTcRTmt/vY1Vxc5+uUkbEIepgmSVzSnkTc7I+M+qNGYEMvGjmVXZ+B
        OWeWj0wz07xqZa4s/5F8G1k6w6nzmTYR1CSbRmVWalSUtu0a+N93zved851zOBQmnyXWUxei
        YjlNlCpSQTriDR2/+neOeycqd6X3eTA5fV0S5ul7E2J0GbMEozN0k8z3iVySqfk2RzDDi3Mk
        s/zuE8GU5SczmTf1UqZmykwwQ89KrbLJZYyZvPKBYHretOLMtcx08iDNlmgHcXboRo6EbRbG
        pWxJRjHBjpmfk2zjj0mCfZttlLC1+hT2r/ASZxvNdzHW8rMFY+drNgY7KR0Dw7jIC/Gcxnf/
        eceIoi8eMe3rEn9XtEi1aN4lCzlQQPtD9688QsTuMDBRTWYhR0pOP0RgXGonxGAeweLMFPpf
        UdncuEI8QnC9yYLbCBntDD9vTdgxRm+DDwv5uCiaRjBpLrN7uNAHoL81TWIjXGkdDub3pZgt
        wGgtgumyQtKmIq3lf2tHrZiytt0P76ZSbGmc3gIm0yN7Izf6DJTftthHcqADYPaesOLsBW3D
        MyvYA9LSR+1TAN0thVzL25UdjkBhn04iYhf4aKyTingDZGa0ScSCbATfczulYlCAYOnrHUxU
        BUC7cZAQLdZCfkMRZpsUaBlkXJWLEhZ0w+OEmD4EBcty8RQ3EAjZlWQe8hJWnUxYdTJh1RLC
        qiXuI7wKuXJxvDqc4/19eJWaj4sK9wmNVtcg6xOalowLTaiiY68B0RRSOMmYkASlnFDF80lq
        AwIKU7jKDo9YU7IwVdIlThMdoomL5HgD8qRwhYdsn/LqWTkdrorlLnJcDKf5z0ooh/Va5F6g
        qeP1Tn1j1T2eJ/e4G3tvV+yJL9eW1uU8qE8wrKmXdCxUhfYMeJ95nLox8JzmT+IpaV5xQtq+
        F76pxVlBXZ9fNbb0d0YnHeqQWvwDp+s9jyuXTlc8SRtI9k3dujnZWW06+kofnLx7RJV+TM8H
        bfIcYv0uu/WuO/Ea/dBXCl47FDgfofLbjml41T8N1PeBgAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPIsWRmVeSWpSXmKPExsVy+t/xq7p3dCqiDC5/NLHoPXeSyWLjk9OM
        Fk0db1ktmg6dYrP4dK+fzWLTx/esFle+vmez+P/oNavF3Em1Fp0Tl7BbbHp8jdXi8q45QGUP
        /jNbPGh5wWpx5uoBFov2zlY2BwGP2Q0XWTwu9/UyeeycdZfdY3bHTFaPO9f2sHls//aA1eN+
        93Emj81L6j3+ztrP4rH92jxmj6c/9jJ7fN4kF8ATxWWTkpqTWZZapG+XwJUx/Z14wWHJil+L
        97I3MH4W7mLk5JAQMJFYvnM7K4QtJnHh3no2EFtIYAmjxMyz3iA2r4CgxI/J91i6GDk4mAXU
        JaZMye1i5AIqecYoMafxHjtIjbCAvcT5A81MIAkRgRYWib1Pb7KBOMwCTYwSV77uYodomcAo
        serKYmaQFjYBTYm/m0GqOIBW2Ek8elwPEmYRUJU4fXoZ2EWiAhESnSvns4DYnALWEm/nzwKz
        mQXkJQ5eeQ5li0s0t95kmcAoOAvJsbMQjp2FpGMWko4FjCyrGEVSS4tz03OLDfWKE3OLS/PS
        9ZLzczcxAqN127Gfm3cwXtoYfIhRgINRiYfXIr48Sog1say4MvcQowQHs5IIr9N1oBBvSmJl
        VWpRfnxRaU5q8SFGaQ4WJXHe3j2rI4UE0hNLUrNTUwtSi2CyTBycUg2MU0O9xLyl9Y/tlTny
        QqvEvPMz24wrGkxTwu49kl1xo2lhyNTekNaOvHlp66dq7WMuWhj7ITcrXcfu8RKVTu9JRc+C
        5NrZAxc+mpvmx/Tmi8iLKJVrx2z4Jvq2LE82j3iZyWH8UcV5vmGxmFM/05mt35Nd78Ufibhi
        9b49XPaSdcekhd5Wpg1KLMUZiYZazEXFiQCmT1RW0gIAAA==
X-CMS-MailID: 20180205100724eucas1p2d8879483c71424965f76c25d09395268
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180204213219epcas2p429434ba0c87a0544dc5294facd80529b
X-RootMTR: 20180204213219epcas2p429434ba0c87a0544dc5294facd80529b
References: <CGME20180204213219epcas2p429434ba0c87a0544dc5294facd80529b@epcas2p4.samsung.com>
        <20180204213104.17834-1-philippe.cornu@st.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.02.2018 22:31, Philippe Cornu wrote:
> This patch adds the DCS/GENERIC DSI read feature.
>
> Signed-off-by: Philippe Cornu <philippe.cornu@st.com>

Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

If there will be no objections I will merge it at the end of the week.

 --
Regards
Andrzej

> ---
> Extra notes:
> DSI read tests have been performed with DCS & GENERIC, short & long
> commands, on two different panels.
> The maximum fifo size (32*32-bit = 128 bytes on stm32) has been
> verified too.
>
>  drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 58 +++++++++++++++++++++------
>  1 file changed, 45 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> index e9422d05e897..65aeb3f78b48 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> @@ -397,18 +397,46 @@ static int dw_mipi_dsi_write(struct dw_mipi_dsi *dsi,
>  	return dw_mipi_dsi_gen_pkt_hdr_write(dsi, le32_to_cpu(word));
>  }
>  
> +static int dw_mipi_dsi_read(struct dw_mipi_dsi *dsi,
> +			    const struct mipi_dsi_msg *msg)
> +{
> +	int i, j, ret, len = msg->rx_len;
> +	u8 *buf = msg->rx_buf;
> +	u32 val;
> +
> +	/* Wait end of the read operation */
> +	ret = readl_poll_timeout(dsi->base + DSI_CMD_PKT_STATUS,
> +				 val, !(val & GEN_RD_CMD_BUSY),
> +				 1000, CMD_PKT_STATUS_TIMEOUT_US);
> +	if (ret) {
> +		dev_err(dsi->dev, "Timeout during read operation\n");
> +		return ret;
> +	}
> +
> +	for (i = 0; i < len; i += 4) {
> +		/* Read fifo must not be empty before all bytes are read */
> +		ret = readl_poll_timeout(dsi->base + DSI_CMD_PKT_STATUS,
> +					 val, !(val & GEN_PLD_R_EMPTY),
> +					 1000, CMD_PKT_STATUS_TIMEOUT_US);
> +		if (ret) {
> +			dev_err(dsi->dev, "Read payload FIFO is empty\n");
> +			return ret;
> +		}
> +
> +		val = dsi_read(dsi, DSI_GEN_PLD_DATA);
> +		for (j = 0; j < 4 && j + i < len; j++)
> +			buf[i + j] = val >> (8 * j);
> +	}
> +
> +	return ret;
> +}
> +
>  static ssize_t dw_mipi_dsi_host_transfer(struct mipi_dsi_host *host,
>  					 const struct mipi_dsi_msg *msg)
>  {
>  	struct dw_mipi_dsi *dsi = host_to_dsi(host);
>  	struct mipi_dsi_packet packet;
> -	int ret;
> -
> -	if (msg->rx_buf || msg->rx_len) {
> -		/* TODO dw drv improvements: implement read feature */
> -		dev_warn(dsi->dev, "read operations not yet implemented\n");
> -		return -EINVAL;
> -	}
> +	int ret, nb_bytes;
>  
>  	ret = mipi_dsi_create_packet(&packet, msg);
>  	if (ret) {
> @@ -422,12 +450,16 @@ static ssize_t dw_mipi_dsi_host_transfer(struct mipi_dsi_host *host,
>  	if (ret)
>  		return ret;
>  
> -	/*
> -	 * TODO Only transmitted size is returned as actual driver does
> -	 * not support dcs/generic reads. Please update return value when
> -	 * delivering the read feature.
> -	 */
> -	return packet.size;
> +	if (msg->rx_buf && msg->rx_len) {
> +		ret = dw_mipi_dsi_read(dsi, msg);
> +		if (ret)
> +			return ret;
> +		nb_bytes = msg->rx_len;
> +	} else {
> +		nb_bytes = packet.size;
> +	}
> +
> +	return nb_bytes;
>  }
>  
>  static const struct mipi_dsi_host_ops dw_mipi_dsi_host_ops = {
