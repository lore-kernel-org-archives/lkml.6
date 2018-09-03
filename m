Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B0EC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 19:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9807F20867
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 19:59:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fTlHjzD3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9807F20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728908AbeIDAVV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 20:21:21 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37126 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728621AbeIDAVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 20:21:21 -0400
Received: by mail-pl1-f193.google.com with SMTP id f1-v6so565703plt.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 12:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mey9dpvfUUmR43Enqhh6Cl2t3LY6zegTdet2pYORf8s=;
        b=fTlHjzD36V/guoPJth72db3QZ+vCsgF1hG84z2sgHG4LWR2HhJjEikVQSVBgWiZRUs
         Dzw6B1xdUYK8ZBhv0D2SZvFenN9YZiy1qfEr/E9x8AYGL+p6iPmeyL7uw9JC76h1aYYq
         T62pjJMs6y8u7BsK748PGRRWRM4oUs7/U6zY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mey9dpvfUUmR43Enqhh6Cl2t3LY6zegTdet2pYORf8s=;
        b=gjFtN2FwyVHc81R9q7swZkEPnBZTgydY/N8uK3gxzXL/jb2UtC0KcafBf54AGqRvD1
         yAdK6J73MC0nYKN07JmHbJ3XEaXDKOwcKv5OzL1MBv9TwdF4bD3tZP3zzNHmDXeHibDA
         ab01AzbB6CBq2uwClukeM0tU9uKIHqP5HmTe/I5fxAOA0AM1hs+G+W8JO5fEVmvdPslt
         1pV35Gfct27OV9GFDnKU07N9pjx/4U4/KOA8KiCKkjUrUdIb3XQMOfJoh3QPGhBHlWgi
         WBmEOgcgMkVSbzP+n3q43STDBDlYRN+5wHWKEcIlr29USm7mERc6rOTtAaIfgW8e72Xb
         X1lA==
X-Gm-Message-State: APzg51C6ooKITYhlZXiodx7C4cHtgF/zCFmRZLFVLvXNopKBWKRl3Sui
        +qUtLvIvx3qyu9OGNBy8IXp9EQ==
X-Google-Smtp-Source: ANB0VdYDwxkIt0aovXtJeCk1wf9vKeFM8kcsIxo5QgfNO2Z0fRakqPCY+8Z8A8NDsLMIbc7SLql19Q==
X-Received: by 2002:a17:902:d808:: with SMTP id a8-v6mr30034018plz.68.1536004777090;
        Mon, 03 Sep 2018 12:59:37 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id i25-v6sm22541750pgi.31.2018.09.03.12.59.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Sep 2018 12:59:36 -0700 (PDT)
Date:   Mon, 3 Sep 2018 13:03:30 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, rnayak@codeaurora.org,
        linux-arm-msm@vger.kernel.org, edubezval@gmail.com,
        smohanad@codeaurora.org, andy.gross@linaro.org,
        dianders@chromium.org, mka@chromium.org,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 02/11] arm/arm64: dts: msm8974/msm8916: thermal: Add
 "qcom,sensors" property
Message-ID: <20180903200330.GM3456@tuxbook-pro>
References: <cover.1535462942.git.amit.kucheria@linaro.org>
 <e894c837385b6a2e120eddb779a359bb08b7c847.1535462942.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e894c837385b6a2e120eddb779a359bb08b7c847.1535462942.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 28 Aug 06:38 PDT 2018, Amit Kucheria wrote:

> This new property allows the number of sensors to be configured from DT
> instead of being hardcoded in platform data. Use it.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>

Please split in arm and arm64.

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  arch/arm/boot/dts/qcom-msm8974.dtsi   | 1 +
>  arch/arm64/boot/dts/qcom/msm8916.dtsi | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
> index 56dbbf788d15..3c4b81c29798 100644
> --- a/arch/arm/boot/dts/qcom-msm8974.dtsi
> +++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
> @@ -433,6 +433,7 @@
>  			      <0xfc4a8000 0x1000>; /* SROT */
>  			nvmem-cells = <&tsens_calib>, <&tsens_backup>;
>  			nvmem-cell-names = "calib", "calib_backup";
> +			#qcom,sensors = <11>;
>  			#thermal-sensor-cells = <1>;
>  		};
>  
> diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> index 6a277fce3333..be27d8dc9e6b 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> @@ -767,6 +767,7 @@
>  			      <0x4a8000 0x1000>; /* SROT */
>  			nvmem-cells = <&tsens_caldata>, <&tsens_calsel>;
>  			nvmem-cell-names = "calib", "calib_sel";
> +			#qcom,sensors = <5>;
>  			#thermal-sensor-cells = <1>;
>  		};
>  
> -- 
> 2.17.1
> 
