Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752334AbeCMRpY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 13:45:24 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:32776 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751719AbeCMRpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 13:45:21 -0400
X-Google-Smtp-Source: AG47ELuR42/j+rDyEtEIq2GEPkTBHa1XFTVLqJEN/pMC8/UM8MSAoRVTm4/61XMl17of8mMiyGhvWQ==
Date: Tue, 13 Mar 2018 10:45:18 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Thierry Escande <thierry.escande@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Andy Gross <andy.gross@linaro.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] Bluetooth: hci_qca: Add serdev support
Message-ID: <20180313174518.GU18510@minitux>
References: <20180313164444.19881-1-thierry.escande@linaro.org>
 <20180313164444.19881-4-thierry.escande@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180313164444.19881-4-thierry.escande@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 13 Mar 09:44 PDT 2018, Thierry Escande wrote:
> @@ -50,6 +54,9 @@
>  #define IBS_TX_IDLE_TIMEOUT_MS		2000
>  #define BAUDRATE_SETTLE_TIMEOUT_MS	300
>  
> +/* divclk4 rate */

The clock is called "susclk" in the BT chip, "divclk4" is the board
specific name for the clock source.

> +#define DIVCLK4_RATE_32KHZ	32768
> +
>  /* HCI_IBS transmit side sleep protocol states */
>  enum tx_ibs_states {
>  	HCI_IBS_TX_ASLEEP,
> @@ -111,6 +118,12 @@ struct qca_data {
>  	u64 votes_off;
>  };
>  
> +struct qca_serdev {
> +	struct hci_uart	 serdev_hu;
> +	struct gpio_desc *bt_en;
> +	struct clk	 *divclk4;

Rename this to "susclk", or simply "clk".

> +};

Apart from this and Andy's comments this looks good.

Regards,
Bjorn
