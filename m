Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F451C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 09:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5885021741
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 09:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bFAHfm3f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbeLZJUN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 04:20:13 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39047 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbeLZJUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 04:20:13 -0500
Received: by mail-wr1-f65.google.com with SMTP id t27so15162074wra.6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 01:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cPkYBpJFj3rRgobWvv5/Zg1QLJiRxRLFFuoVIzu1RGU=;
        b=bFAHfm3fwnWQGByGvmlEfB71fCHzpTOnC9nkLhBcM1T+/KTzeBLQzOx1ScmHEV/7Gk
         qZDLgdJ5Z+RdREt3RYgQVHnMuyZUhesoZ1bBhcpS/L+yx7RDXmN0oX5auh6v/p4NLsXf
         bNwq2AX5jFa3VKu6RDyKEjP9id9XnQgJwrSH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cPkYBpJFj3rRgobWvv5/Zg1QLJiRxRLFFuoVIzu1RGU=;
        b=D/ZWFBVSED8ZIBRRvn+tLxx+z9x7dKyy3kyaYZdCDjWY9rIJTYVtyHgW1VhSLPN0R6
         SQtyqufiPUjrVz5UyLA+Yrtqc469Ru9ALhIkPlKc3A836Z4e9qV0+oPy7xZylb1U9SyI
         HGfINbRwg8ytqa+6zxyDa0CuctkwgHCCjCFJdHcJLRCaGsBnE3i1uLPpwNvvjj/sb5Sn
         P71ZcClfM8ewXaMO8bM2cUOIcf53UJ8m4dIs+EI0NbF5GqW2YrlSnEjdpJk4Ub/hNnGn
         G5Y/f4n0AnIU8F+pdMu4Nzu71CHrZsQX2utt6/WXDmqKZB7usPXIs/30v44UEKy2OTqr
         1EdA==
X-Gm-Message-State: AJcUukelg+bTV7pEqnyc63UfxsNN1yykDYQ3oESwfwpJL7COUk8gIhqH
        xkUelyZuAbktnuLj3r99Pp0fVg==
X-Google-Smtp-Source: ALg8bN59NDUN0Zy2q3OY46DeuLXssPI9QfG1WmFMkF6m8tOgLANQL2H/y8tc4z9eRY7dYpOzVRYSeQ==
X-Received: by 2002:adf:91a3:: with SMTP id 32mr16217113wri.99.1545816010832;
        Wed, 26 Dec 2018 01:20:10 -0800 (PST)
Received: from [192.168.1.2] (227.red-79-146-82.dynamicip.rima-tde.net. [79.146.82.227])
        by smtp.gmail.com with ESMTPSA id l37sm49776483wre.69.2018.12.26.01.20.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Dec 2018 01:20:10 -0800 (PST)
Subject: Re: [PATCH 05/13] clk: qcom: apcs-msm8916: get parent clock names
 from DT
To:     Niklas Cassel <niklas.cassel@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     andy.gross@linaro.org, david.brown@linaro.org,
        jassisinghbrar@gmail.com, mark.rutland@arm.com,
        mturquette@baylibre.com, robh+dt@kernel.org, will.deacon@arm.com,
        bjorn.andersson@linaro.org, vkoul@kernel.org, sibis@codeaurora.org,
        georgi.djakov@linaro.org, arnd@arndb.de,
        horms+renesas@verge.net.au, heiko@sntech.de,
        enric.balletbo@collabora.com, jagan@amarulasolutions.com,
        olof@lixom.net, amit.kucheria@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
References: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1545039990-19984-6-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <154508986359.19322.1555129141976726505@swboyd.mtv.corp.google.com>
 <20181218143503.GA32562@centauri.ideon.se>
From:   Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
Message-ID: <72bc192f-b60a-1209-7818-78a2fed07831@linaro.org>
Date:   Wed, 26 Dec 2018 10:20:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181218143503.GA32562@centauri.ideon.se>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/18/18 15:35, Niklas Cassel wrote:
> On Mon, Dec 17, 2018 at 03:37:43PM -0800, Stephen Boyd wrote:
>> Quoting Jorge Ramirez-Ortiz (2018-12-17 01:46:22)
>>> Allow accessing the parent clock names required for the driver
>>> operation by using the device tree node.
>>>
>>> This permits extending the driver to other platforms without having to
>>> modify its source code.
>>>
>>> For backwards compatibility leave previous values as default.
>>
>> Why do we need to maintain backwards compatibility? Isn't is required
>> that the nodes have clocks properties?
>>
> 
> Hello Stephen,
> 
> 
> This is the existing DT nodes for msm8916:
> 
>                 a53pll: clock@b016000 {
>                          compatible = "qcom,msm8916-a53pll";
>                          reg = <0xb016000 0x40>;
>                          #clock-cells = <0>;
>                  };
> 
>                  apcs: mailbox@b011000 {
>                          compatible = "qcom,msm8916-apcs-kpss-global", "syscon";
>                          reg = <0xb011000 0x1000>;
>                          #mbox-cells = <1>;
>                          clocks = <&a53pll>;
>                          #clock-cells = <0>;
>                  };
> 
> 
> This is the (suggested) DT nodes for qcs404:
> 
>                  apcs_hfpll: clock-controller@0b016000 {
>                          compatible = "qcom,hfpll";
>                          reg = <0x0b016000 0x30>;
>                          #clock-cells = <0>;
>                          clock-output-names = "apcs_hfpll";
>                          clocks = <&xo_board>;
>                          clock-names = "xo";
>                  };
> 
>                  apcs_glb: mailbox@b011000 {
>                          compatible = "qcom,qcs404-apcs-apps-global", "syscon";
>                          reg = <0x0b011000 0x1000>;
>                          #mbox-cells = <1>;
>                          clocks = <&gcc GCC_GPLL0_AO_OUT_MAIN>, <&apcs_hfpll>;
>                          clock-names = "aux", "pll";
>                          #clock-cells = <0>;
>                  };
> 
> qcs404 specifies two clocks, with an accompanied clock-name for each clock.
> 
> msm8916 specifies a single clock, without an accompanied clock-name.
> 
> It is possible to append clock-names = "pll" for the existing clock,
> as well as to define the aux clock in the apcs node in the msm8916 DT:
> clocks = <&gcc GPLL0_VOTE>;
> clock-names = "aux";
> 
> However, since the DT is treated as an ABI, the existing DT for msm8916 must
> still work, so I don't think that it is possible to ignore having backwards
> compability in the apcs clock driver.


so where are we with this?

do we remove backwards compatibility (see below] for v2 or is the DT 
really an ABI and therefore the patch under review is good as is?


diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi 
b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index c5348c3..729c117 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -425,7 +425,8 @@
                         compatible = "qcom,msm8916-apcs-kpss-global", 
"syscon";
                         reg = <0xb011000 0x1000>;
                         #mbox-cells = <1>;
-                   clocks = <&a53pll>;
+                 clocks = <&gcc GPLL0_VOTE>, <&a53pll>;
+                 clock-names = "aux", "pll";
                         #clock-cells = <0>;
                 };



> 
> 
> Kind regards,
> Niklas
> 

