Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752008AbeC0Vh5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 17:37:57 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:41016 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751020AbeC0Vhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 17:37:55 -0400
X-Google-Smtp-Source: AIpwx4+X3bGzzRTgkpTWOnKs5qofP2DvfUuBbbKM4l4ZO1p+iOckrs0AhqYqx3Zbsv9nzfGv3unFokG9HcGOjjZRaa0=
MIME-Version: 1.0
In-Reply-To: <1521785487-29866-4-git-send-email-mgautam@codeaurora.org>
References: <1521785487-29866-1-git-send-email-mgautam@codeaurora.org> <1521785487-29866-4-git-send-email-mgautam@codeaurora.org>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 27 Mar 2018 14:37:53 -0700
X-Google-Sender-Auth: SOzlhwjTurgvU0WMa8tq5eX3YY0
Message-ID: <CAD=FV=Vwx2nW=pwEzJJSVXLctxOU5uGormBn=t_P6_xyfrrLAw@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] dt-bindings: phy-qcom-qmp: Update bindings for sdm845
To: Manu Gautam <mgautam@codeaurora.org>, Rob Herring <robh+dt@kernel.org>
Cc: Kishon Vijay Abraham I <kishon@ti.com>,
        LKML <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Varadarajan Narayanan <varada@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Mar 22, 2018 at 11:11 PM, Manu Gautam <mgautam@codeaurora.org> wrote:
> Update compatible strings for USB3 PHYs on SDM845.
> One is QMPv3 DisplayPort-USB combo PHY and other one
> is USB UNI PHY which is single lane USB3 PHY without
> DP capability.
>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Manu Gautam <mgautam@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
> index dcf1b8f..cef8765 100644
> --- a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
> +++ b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
> @@ -9,7 +9,9 @@ Required properties:
>                "qcom,ipq8074-qmp-pcie-phy" for PCIe phy on IPQ8074
>                "qcom,msm8996-qmp-pcie-phy" for 14nm PCIe phy on msm8996,
>                "qcom,msm8996-qmp-usb3-phy" for 14nm USB3 phy on msm8996,
> -              "qcom,qmp-v3-usb3-phy" for USB3 QMP V3 phy.
> +              "qcom,qmp-v3-usb3-phy" for USB3 QMP V3 phy,
> +              "qcom,sdm845-qmp-usb3-phy" for USB3 QMP V3 phy on sdm845,
> +              "qcom,sdm845-qmp-usb3-uni-phy" for USB3 QMP V3 UNI phy on sdm845.

I'm confused.  What value does "qcom,qmp-v3-usb3-phy" have as a
separate entry from "qcom,sdm845-qmp-usb3-phy"?  Is
"qcom,qmp-v3-usb3-phy" expected to work on some non-SDM845 based
device?

Personally I think you should remove "qcom,qmp-v3-usb3-phy" from the
bindings as part of this patch (replacing it with the new string
qcom,sdm845-qmp-usb3-phy)".  Yeah, yeah bindings are forever.  ...but
that particular string was added about a month ago and (I believe) it
was intended for SDM845 anyway.  As per
<https://patchwork.kernel.org/patch/10302759/> match to the exact same
PHY data which leads extra credence to my belief.

If later on you find that some future chip can use the exact same
driver / settings as the SDM845 you can always list the
"qcom,sdm845-qmp-usb3-phy" string as a secondary compatible anyway.


-Doug
