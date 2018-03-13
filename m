Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933623AbeCMQuo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 12:50:44 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:34930 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933368AbeCMQul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 12:50:41 -0400
X-Google-Smtp-Source: AG47ELsw1sWk6Yccwbw4SNOy0rpq3Ta3AHXPYC2P09kgK97/LE6PPPGOBN7mH+VEBOQe5dcDI6vlxRFVK4uN+pPhaiM=
MIME-Version: 1.0
In-Reply-To: <20180313164444.19881-4-thierry.escande@linaro.org>
References: <20180313164444.19881-1-thierry.escande@linaro.org> <20180313164444.19881-4-thierry.escande@linaro.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 13 Mar 2018 18:50:39 +0200
Message-ID: <CAHp75Vc0hgh89JABVPHJO+RaNqkY_RpsytkDWf=F+Dh=XtZprg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] Bluetooth: hci_qca: Add serdev support
To: Thierry Escande <thierry.escande@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Andy Gross <andy.gross@linaro.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 13, 2018 at 6:44 PM, Thierry Escande
<thierry.escande@linaro.org> wrote:
> Add support for Qualcomm serial slave devices. Probe the serial device,
> retrieve its maximum speed and register a new hci uart device.

> +#include <linux/of.h>

What exactly this is used for?

> +       qcadev->bt_en = devm_gpiod_get(&serdev->dev, "bt-disable-n",
> +                                      GPIOD_OUT_LOW);
> +       if (IS_ERR(qcadev->bt_en)) {
> +               dev_err(&serdev->dev, "failed to acquire bt-disable-n gpio\n");
> +               return PTR_ERR(qcadev->bt_en);
> +       }

> +       gpiod_set_value(qcadev->bt_en, 0);

Redundant.

> +       clk_set_rate(qcadev->divclk4, DIVCLK4_RATE_32KHZ);

> +       clk_prepare_enable(qcadev->divclk4);

This may fail.

> +       return hci_uart_register_device(&qcadev->serdev_hu, &qca_proto);
> +}

> +       clk_disable(qcadev->divclk4);
> +       clk_unprepare(qcadev->divclk4);

One call.

> +}

> +static const struct of_device_id qca_bluetooth_of_match[] = {
> +       { .compatible = "qcom,qca6174-bt" },

> +       { },

No comma.

> +};

-- 
With Best Regards,
Andy Shevchenko
