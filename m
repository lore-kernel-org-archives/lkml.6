Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753252AbeDLWHu (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 18:07:50 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:32860 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752283AbeDLWHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 18:07:48 -0400
X-Google-Smtp-Source: AIpwx48GVzJRfMadZicUdfCSTl7QyiZuQpEzbZTXpQtepJd08+uUDdSGjb2vXqLoyrIQjQwfpv2ZdA==
MIME-Version: 1.0
References: <1523390893-10904-1-git-send-email-rishabhb@codeaurora.org> <1523390893-10904-2-git-send-email-rishabhb@codeaurora.org>
In-Reply-To: <1523390893-10904-2-git-send-email-rishabhb@codeaurora.org>
From: Evan Green <evgreen@chromium.org>
Date: Thu, 12 Apr 2018 22:07:10 +0000
X-Gmail-Original-Message-ID: <CAE=gft5Ks7rXOB9=oaaKjh65HY2_3-iXOh6Q01Rtpx_nJ-H1FQ@mail.gmail.com>
Message-ID: <CAE=gft5Ks7rXOB9=oaaKjh65HY2_3-iXOh6Q01Rtpx_nJ-H1FQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] Documentation: Documentation for qcom, llcc
To: rishabhb@codeaurora.org
Cc: linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm@lists.infradead.org,
        linux-kernel@vger.kernel.org, tsoni@codeaurora.org,
        kyan@codeaurora.org, ckadabi@codeaurora.org,
        stanimir.varbanov@linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2018 at 1:09 PM Rishabh Bhatnagar <rishabhb@codeaurora.org>
wrote:

> Documentation for last level cache controller device tree bindings,
> client bindings usage examples.

> Signed-off-by: Channagoud Kadabi <ckadabi@codeaurora.org>
> Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
> ---
>   .../devicetree/bindings/arm/msm/qcom,llcc.txt      | 58
++++++++++++++++++++++
>   1 file changed, 58 insertions(+)
>   create mode 100644
Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt

> diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt
b/Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt
> new file mode 100644
> index 0000000..497cf0f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt
> @@ -0,0 +1,58 @@
> +== Introduction==
> +
> +LLCC (Last Level Cache Controller) provides last level of cache memory
in SOC,
> +that can be shared by multiple clients. Clients here are different cores
in the
> +SOC, the idea is to minimize the local caches at the clients and migrate
to
> +common pool of memory
> +
> +Properties:
> +- compatible:
> +        Usage: required
> +        Value type: <string>
> +        Definition: must be "qcom,sdm845-llcc"
> +
> +- reg:
> +        Usage: required
> +        Value Type: <prop-encoded-array>
> +        Definition: must be addresses and sizes of the LLCC registers
> +
> +- #cache-cells:
> +        Usage: required
> +        Value Type: <u32>
> +        Definition: Number of cache cells, must be 1
> +
> +- max-slices:
> +        usage: required
> +        Value Type: <u32>
> +        Definition: Number of cache slices supported by hardware
> +
> +Example:
> +
> +       llcc: qcom,llcc@1100000 {
> +               compatible = "qcom,sdm845-llcc";
> +               reg = <0x1100000 0x250000>;
> +               #cache-cells = <1>;
> +               max-slices = <32>;
> +       };
> +
> +== Client ==
> +
> +Properties:
> +- cache-slice-names:
> +        Usage: required
> +        Value type: <stringlist>
> +        Definition: A set of names that identify the usecase names of a
> +                       client that uses cache slice. These strings are
> +                       used to look up the cache slice entries by name.
> +
> +- cache-slices:
> +        Usage: required
> +        Value type: <prop-encoded-array>
> +        Definition: The tuple has phandle to llcc device as the first
> +                       argument and the second argument is the usecase
> +                       id of the client.
> +For Example:
> +       venus {
> +               cache-slice-names = "vidsc0", "vidsc1";
> +               cache-slices = <&llcc VIDSC0_ID>, <&llcc VIDSC1_ID>;

My git complains about some whitespace weirdness on the line above. Other
than that:

Reviewed-by: Evan Green <evgreen@chromium.org>

-Evan
