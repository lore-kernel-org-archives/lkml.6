Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 720A4C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 23:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1504D21567
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 23:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h78VwbZS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1504D21567
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbeHYDEq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 23:04:46 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45253 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbeHYDEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 23:04:45 -0400
Received: by mail-pg1-f196.google.com with SMTP id m4-v6so4414480pgv.12;
        Fri, 24 Aug 2018 16:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8dxZb7xvxnfgLudzJXRXJ07ne2ExAArG518THSh9nq0=;
        b=h78VwbZSS8jXAS3TKOjpJDXvrwpBxtnh4aItvxE8vYRazax8WnkITRXYPu4XXxRnm7
         INP+qJrKARRI2jsiX2wYD5ZWkLg2nJlRJGohAzBi7fNhYBSkj3XKpSexHm0LqabPkdVf
         zyyzaVhj66Uz8LKcc8usB32L81IgiI/VmdGJPc2RBHqZKJykq11qs90tzMNP+TlnNann
         d6z49Ly9EKSfhTl7zUlUYMxvyKhTroQk/abE11rTeyUYEGo+aUuC7kTK3e4rNSyrUbrE
         jCNDsaKvOVi9H65YFWpO1f7AwstlXeruvP9GOdpJnCWnysMjszwNuhUaKMWBO3l2PeVb
         WYOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8dxZb7xvxnfgLudzJXRXJ07ne2ExAArG518THSh9nq0=;
        b=MrMGqpFH01+pse7Um+Bf2qpyYz+vRGflAJS/FfT0rCFatAw0JZ8BWByLWnz9qj2GZB
         JvAzJVy+9tHX6z/bUZw2ds/KG4OsjxXXJhZ9UWR8L4HJi/SHWItYzn803RDEXi6YAxvy
         OsL/eaiAP5DcclsLszUMrGb+ecGo3jv8/2uEnKVTC5lc9rYLHKMNSAInDSIwMTiACxDt
         P1H+RYGBUrMHNpXjIQbwsEVARx2sunc21YYV0DenNSaxs666JkUpXvfoWO2KRiftOis9
         wEXkaXIK9nTiDUvRvx1jZIwSNOHW6NqULCU7XF4iT3Q5GkniqbHZCB8KCf6UiVYX7Afx
         U/kg==
X-Gm-Message-State: APzg51AZQSeZ8uO1z41z86EmNDvZp7/7jpIQPh3H/+/CHmOpKhp9FdDH
        u+ifWbuW2CSYa8HGM/1xBqw=
X-Google-Smtp-Source: ANB0Vdaq6q98qeKlzuk5Z5tn+VzaV0WHli/L3ZatqKk9/jfhwejwWWPbTeJMgMwbUL/ufc3OsXVY7w==
X-Received: by 2002:a63:6283:: with SMTP id w125-v6mr3398902pgb.83.1535153279825;
        Fri, 24 Aug 2018 16:27:59 -0700 (PDT)
Received: from localhost.localdomain ([2601:644:8201:32e0:7256:81ff:febd:926d])
        by smtp.gmail.com with ESMTPSA id k64-v6sm13033902pfg.141.2018.08.24.16.27.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Aug 2018 16:27:59 -0700 (PDT)
Date:   Fri, 24 Aug 2018 16:27:49 -0700
From:   Eduardo Valentin <edubezval@gmail.com>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, rnayak@codeaurora.org,
        linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        smohanad@codeaurora.org, andy.gross@linaro.org,
        dianders@chromium.org, mka@chromium.org,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v1 01/10] arm/arm64: dts: msm8974/msm8916: thermal: Split
 address space into two
Message-ID: <20180824232747.GE25163@localhost.localdomain>
References: <cover.1533815718.git.amit.kucheria@linaro.org>
 <d01f560abed221b536b27bfaa42a530257642974.1533815718.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d01f560abed221b536b27bfaa42a530257642974.1533815718.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 09, 2018 at 06:02:33PM +0530, Amit Kucheria wrote:
> We've earlier added support to split the register address space into TM
> and SROT regions.
> 
> Split up the regmap address space into two for the remaining platforms that
> have a similar register layout and make corresponding changes to the
> get_temp_common() function used by these platforms.
> 
> Since tsens-common.c/init_common() currently only registers one address
> space, the order is important (TM before SROT).  This is OK since the code
> doesn't really use the SROT functionality yet.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  arch/arm/boot/dts/qcom-msm8974.dtsi   | 6 ++++--
>  arch/arm64/boot/dts/qcom/msm8916.dtsi | 6 ++++--
>  drivers/thermal/qcom/tsens-common.c   | 5 +++--
>  3 files changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
> index d9019a49b292..3c4b81c29798 100644
> --- a/arch/arm/boot/dts/qcom-msm8974.dtsi
> +++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
> @@ -427,11 +427,13 @@
>  			};
>  		};
>  
> -		tsens: thermal-sensor@fc4a8000 {
> +		tsens: thermal-sensor@fc4a9000 {
>  			compatible = "qcom,msm8974-tsens";
> -			reg = <0xfc4a8000 0x2000>;
> +			reg = <0xfc4a9000 0x1000>, /* TM */
> +			      <0xfc4a8000 0x1000>; /* SROT */
>  			nvmem-cells = <&tsens_calib>, <&tsens_backup>;
>  			nvmem-cell-names = "calib", "calib_backup";
> +			#qcom,sensors = <11>;
>  			#thermal-sensor-cells = <1>;
>  		};
>  
> diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> index cc1040eacdf5..abf84df5a7bc 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> @@ -774,11 +774,13 @@
>  			};
>  		};
>  
> -		tsens: thermal-sensor@4a8000 {
> +		tsens: thermal-sensor@4a9000 {
>  			compatible = "qcom,msm8916-tsens";
> -			reg = <0x4a8000 0x2000>;
> +			reg = <0x4a9000 0x1000>, /* TM */
> +			      <0x4a8000 0x1000>; /* SROT */
>  			nvmem-cells = <&tsens_caldata>, <&tsens_calsel>;
>  			nvmem-cell-names = "calib", "calib_sel";
> +			#qcom,sensors = <5>;
>  			#thermal-sensor-cells = <1>;

Looking closer to this, I fail to remember the reasoning why
#qcom,sensors property was needed.

>  		};
>  
> diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
> index 6207d8d92351..478739543bbc 100644
> --- a/drivers/thermal/qcom/tsens-common.c
> +++ b/drivers/thermal/qcom/tsens-common.c
> @@ -21,7 +21,7 @@
>  #include <linux/regmap.h>
>  #include "tsens.h"
>  
> -#define S0_ST_ADDR		0x1030
> +#define STATUS_OFFSET		0x30
>  #define SN_ADDR_OFFSET		0x4
>  #define SN_ST_TEMP_MASK		0x3ff
>  #define CAL_DEGC_PT1		30
> @@ -107,8 +107,9 @@ int get_temp_common(struct tsens_device *tmdev, int id, int *temp)
>  	unsigned int status_reg;
>  	int last_temp = 0, ret;
>  
> -	status_reg = S0_ST_ADDR + s->hw_id * SN_ADDR_OFFSET;
> +	status_reg = tmdev->tm_offset + STATUS_OFFSET + s->hw_id * SN_ADDR_OFFSET;
>  	ret = regmap_read(tmdev->map, status_reg, &code);
> +
>  	if (ret)
>  		return ret;
>  	last_temp = code & SN_ST_TEMP_MASK;
> -- 
> 2.17.1
> 
