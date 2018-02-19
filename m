Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752249AbeBSDIX (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 22:08:23 -0500
Received: from mail-oi0-f66.google.com ([209.85.218.66]:39065 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752173AbeBSDIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 22:08:20 -0500
X-Google-Smtp-Source: AH8x2273d8htoPsJqTZY2JlIs0Bb7PkK7WgebLkQHYRVmJhRL8ad7Ix7BZpRNcwYMdhI02Va30q8Iw==
Date: Sun, 18 Feb 2018 21:08:19 -0600
From: Rob Herring <robh@kernel.org>
To: srinivas.kandagatla@linaro.org
Cc: andy.gross@linaro.org, broonie@kernel.org,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        david.brown@linaro.org, mark.rutland@arm.com, lgirdwood@gmail.com,
        plai@codeaurora.org, bgoswami@codeaurora.org, perex@perex.cz,
        tiwai@suse.com, linux-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        rohkumar@qti.qualcomm.com, spatakok@qti.qualcomm.com
Subject: Re: [PATCH v3 02/25] soc: qcom: add support to APR bus driver
Message-ID: <20180219030819.qovj4swuvged6c24@rob-hp-laptop>
References: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
 <20180213165837.1620-3-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180213165837.1620-3-srinivas.kandagatla@linaro.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 04:58:14PM +0000, srinivas.kandagatla@linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> This patch adds support toi APR bus (Asynchronous Packet Router) driver.
> ARP driver is made as a bus driver so that the apr devices can added removed
> more dynamically depending on the state of the services on the dsp.
> APR is used for communication between application processor and QDSP to
> use services on QDSP like Audio and others.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  drivers/soc/qcom/Kconfig           |   9 +
>  drivers/soc/qcom/Makefile          |   1 +
>  drivers/soc/qcom/apr.c             | 381 +++++++++++++++++++++++++++++++++++++
>  include/dt-bindings/soc/qcom,apr.h |  27 +++

This belongs in the binding patch.

>  include/linux/mod_devicetable.h    |  11 ++
>  include/linux/soc/qcom/apr.h       | 131 +++++++++++++
>  6 files changed, 560 insertions(+)
>  create mode 100644 drivers/soc/qcom/apr.c
>  create mode 100644 include/dt-bindings/soc/qcom,apr.h
>  create mode 100644 include/linux/soc/qcom/apr.h


> diff --git a/include/dt-bindings/soc/qcom,apr.h b/include/dt-bindings/soc/qcom,apr.h
> new file mode 100644
> index 000000000000..fb162ac4ca0e
> --- /dev/null
> +++ b/include/dt-bindings/soc/qcom,apr.h
> @@ -0,0 +1,27 @@

SPDX tag

> +#ifndef __DT_BINDINGS_QCOM_APR_H
> +#define __DT_BINDINGS_QCOM_APR_H
> +
> +/* Domain IDs */
> +#define APR_DOMAIN_SIM	0x1
> +#define APR_DOMAIN_PC	0x2
> +#define APR_DOMAIN_MODEM 0x3
> +#define APR_DOMAIN_ADSP	0x4
> +#define APR_DOMAIN_APPS	0x5
> +#define APR_DOMAIN_MAX	0x6
> +
> +/* ADSP service IDs */
> +#define APR_SVC_ADSP_CORE	0x3
> +#define APR_SVC_AFE		0x4
> +#define APR_SVC_VSM		0x5
> +#define APR_SVC_VPM		0x6
> +#define APR_SVC_ASM		0x7
> +#define APR_SVC_ADM		0x8
> +#define APR_SVC_ADSP_MVM	0x09
> +#define APR_SVC_ADSP_CVS	0x0A
> +#define APR_SVC_ADSP_CVP	0x0B
> +#define APR_SVC_USM		0x0C
> +#define APR_SVC_LSM		0x0D
> +#define APR_SVC_VIDC		0x16
> +#define APR_SVC_MAX		0x17
> +
> +#endif /* __DT_BINDINGS_QCOM_APR_H */
