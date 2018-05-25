Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968152AbeEYTan (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 15:30:43 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:38187 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967879AbeEYTak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 15:30:40 -0400
X-Google-Smtp-Source: AB8JxZr9frjeQIZi7qS/kWAGQLGNfcdQUE3kH8QVOCJm5j9rhpmSh5IsylH/tQnF+4eQA5AX1OaMvw==
Date: Fri, 25 May 2018 12:32:19 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Niklas Cassel <niklas.cassel@linaro.org>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: fix regulator property name for wlan pcie
 endpoint
Message-ID: <20180525193219.GY2259@tuxbook-pro>
References: <20180522195758.24607-1-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180522195758.24607-1-niklas.cassel@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 22 May 12:57 PDT 2018, Niklas Cassel wrote:

> The property name vddpe-supply is not included in
> Documentation/devicetree/bindings/pci/qcom,pcie.txt
> nor in the pcie-qcom PCIe Root Complex driver.
> 
> This property name was used in an initial patchset for pcie-qcom,
> but was renamed in a later revision.
> 
> Therefore, the regulator is currently never enabled, leaving us with
> unoperational wlan.
> 
> Fix this by using the correct regulator property name, so that wlan
> comes up correctly.
> 
> Fixes: 1c8ca74a2ea1 ("arm64: dts: apq8096-db820c: Enable wlan and bt en pins")
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
> Bluetooth needs a similar patch, but since bluetooth needs some more
> work, submit this right now, so we at least have working wlan.
> 
>  arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
> index 818bf0efd501..804268f54f37 100644
> --- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
> +++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
> @@ -203,7 +203,7 @@
>  			pcie@600000 {
>  				status = "okay";
>  				perst-gpio = <&msmgpio 35 GPIO_ACTIVE_LOW>;
> -				vddpe-supply = <&wlan_en>;
> +				vddpe-3v3-supply = <&wlan_en>;
>  				vddpe1-supply = <&bt_en>;
>  			};
>  
> -- 
> 2.17.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
