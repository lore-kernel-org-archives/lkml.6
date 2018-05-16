Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752009AbeEPRDi (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 13:03:38 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:40750 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750835AbeEPRDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 13:03:35 -0400
X-Google-Smtp-Source: AB8JxZpLnYJTeU+6rCbsWFdPCpsNxtmLhUsePmUxIFjyR59KPPmhl/Q/NU5Q/8uXkfayn5oTfYwcnw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org
From: Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <1525810921-15878-2-git-send-email-rishabhb@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-arm@lists.infradead.org,
        tsoni@codeaurora.org, ckadabi@codeaurora.org, evgreen@chromium.org,
        robh@kernel.org, Rishabh Bhatnagar <rishabhb@codeaurora.org>
References: <1525810921-15878-1-git-send-email-rishabhb@codeaurora.org>
 <1525810921-15878-2-git-send-email-rishabhb@codeaurora.org>
Message-ID: <152649021310.210890.14841324536807182632@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v6 1/2] dt-bindings: Documentation for qcom, llcc
Date: Wed, 16 May 2018 10:03:33 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4GH3h3O020736

Quoting Rishabh Bhatnagar (2018-05-08 13:22:00)
> diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt b/Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt
> new file mode 100644
> index 0000000..a586a17
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt
> @@ -0,0 +1,32 @@
> +== Introduction==
> +
> +LLCC (Last Level Cache Controller) provides last level of cache memory in SOC,
> +that can be shared by multiple clients. Clients here are different cores in the
> +SOC, the idea is to minimize the local caches at the clients and migrate to
> +common pool of memory. Cache memory is divided into partitions called slices
> +which are assigned to clients. Clients can query the slice details, activate
> +and deactivate them.
> +
> +Properties:
> +- compatible:
> +       Usage: required
> +       Value type: <string>
> +       Definition: must be "qcom,sdm845-llcc"
> +
> +- reg:
> +       Usage: required
> +       Value Type: <prop-encoded-array>
> +       Definition: Start address and the range of the LLCC registers.

Start address and size?

> +
> +- max-slices:
> +       usage: required
> +       Value Type: <u32>
> +       Definition: Number of cache slices supported by hardware
> +
> +Example:
> +
> +       llcc: qcom,llcc@1100000 {

cache-controller@1100000 ?

> +               compatible = "qcom,sdm845-llcc";
> +               reg = <0x1100000 0x250000>;
> +               max-slices = <32>;
> +       };
> -- 
