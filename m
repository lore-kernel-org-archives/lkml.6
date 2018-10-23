Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91123C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 11:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37742204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 11:53:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VECYP3Kq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37742204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbeJWUQ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 16:16:57 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36126 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727746AbeJWUQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 16:16:56 -0400
Received: by mail-qk1-f195.google.com with SMTP id q184-v6so576733qkd.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 04:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3sgOlby35CiK6aTgF9nqTA5esH0BG51XgwIRvIPA544=;
        b=VECYP3KqLxYs75R5hj90C1owb7SOj9HPnGbT2oLUjzasIuiiVWuu1SK+G7mHRNqA0J
         5S8zcxWtyTT57OYxHPj1BlPx6ZFxgn1mrFuc6ot1nq6DqY35m9Iufmw+bD1b7bkbf+iO
         6fxgkKO2GGLW9bYMp/gwVpdwfppJSV1IFbigM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3sgOlby35CiK6aTgF9nqTA5esH0BG51XgwIRvIPA544=;
        b=b878k2DoqyUpCPwVLv57bO4GYBbE2V+0JeiK2znCSXwjeiDL1t1BuTPl9SELkY3KEi
         hHOW1awpclN8C3wsxTF7fyUlHdWuBG/Tdn4HpTeX3nE8Sg8t40EWcvDw8e87gYlc6zLg
         C0gvN9REhtdt5ma795t45GRaNaDtyIkkyteeF36IHTVzGmc6NKGkUQwthMJf28civ+RH
         tVdNBg6ERO4kYSlKD1lPdDy7UzJWRZgYAUccx6PX7gJFU7E0VKgaza5Nh5DJqQaH84g3
         ofrku0wWpLtELNt5qEsYhZ+eOr30/6V1o5vobbR1i+0/tP/35yzDkdHjVDdJgGTV6U9z
         agfQ==
X-Gm-Message-State: AGRZ1gJ2vwUYpfj19pYflmqxsrCH4F4S1JapXzADHcfZOZgU0rDcsEgB
        SI89HSCW0oPmsYw4T6Ej8QlJGmROmU3yj+gg05JzDQ==
X-Google-Smtp-Source: AJdET5dgS0cshfvJHQVx8k4+2yhnxAbA49G7/V41lwxi+5nSx2QJd6zHXCyCU96ZtgKiUQdY9IBTkZqs4AMBcFwvowE=
X-Received: by 2002:ae9:f00f:: with SMTP id l15-v6mr335312qkg.64.1540295626220;
 Tue, 23 Oct 2018 04:53:46 -0700 (PDT)
MIME-Version: 1.0
References: <1539257761-23023-1-git-send-email-tdas@codeaurora.org> <1539257761-23023-2-git-send-email-tdas@codeaurora.org>
In-Reply-To: <1539257761-23023-2-git-send-email-tdas@codeaurora.org>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Tue, 23 Oct 2018 17:23:34 +0530
Message-ID: <CAP245DV4yK2u2tS_Jjgb1PBx+qkXPXBOs3w4THNDaBEw7WGDLg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: cpufreq: Introduce QCOM CPUFREQ Firmware bindings
To:     Taniya Das <tdas@codeaurora.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        DTML <devicetree@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <skannan@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>, evgreen@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Taniya,

Both the patches are missing v9 in their subject line - this threw off
patchwork when trying to download the patches.

On Thu, Oct 11, 2018 at 5:06 PM Taniya Das <tdas@codeaurora.org> wrote:
>
> Add QCOM cpufreq firmware device bindings for Qualcomm Technology Inc's
> SoCs. This is required for managing the cpu frequency transitions which are
> controlled by the hardware engine.

I tested these patches on the sdm845-mtp against 4.19 and found that
the frequency gets stuck at the highest opp (the boost frequency)
after running a couple of 'yes > /dev/null &' instances. Have you
tested these against a mainline kernel?

See cpufreq statistics below:

linaro-test [rc=0]# cat policy?/scaling_cur_freq
300000
2803200

linaro-test [rc=0]# cat policy?/stats/time_in_state
300000 100840
403200 388
480000 71
576000 54
652800 22
748800 11
825600 5
902400 5
979200 9
1056000 3
1132800 2
1228800 5
1324800 8
1420800 2
1516800 1
1612800 0
1689600 0
1766400 392
825600 22048
902400 21
979200 4
1056000 15
1209600 6
1286400 0
1363200 1
1459200 0
1536000 0
1612800 1
1689600 0
1766400 0
1843200 2
1920000 2
1996800 0
2092800 0
2169600 0
2246400 0
2323200 0
2400000 0
2476800 0
2553600 0
2649600 0
2707200 0
2764800 0
2784000 0
2803200 79718


> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---
>  .../bindings/cpufreq/cpufreq-qcom-hw.txt           | 173 +++++++++++++++++++++
>  1 file changed, 173 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
>
> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
> new file mode 100644
> index 0000000..712643f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
> @@ -0,0 +1,173 @@
> +Qualcomm Technologies, Inc. CPUFREQ Bindings
> +
> +CPUFREQ HW is a hardware engine used by some Qualcomm Technologies, Inc. (QTI)
> +SoCs to manage frequency in hardware. It is capable of controlling frequency
> +for multiple clusters.
> +
> +Properties:
> +- compatible
> +       Usage:          required
> +       Value type:     <string>
> +       Definition:     must be "qcom,cpufreq-hw".
> +
> +- clocks
> +       Usage:          required
> +       Value type:     <phandle> From common clock binding.
> +       Definition:     clock handle for XO clock and GPLL0 clock.
> +
> +- clock-names
> +       Usage:          required
> +       Value type:     <string> From common clock binding.
> +       Definition:     must be "xo", "cpu_clk".
> +
> +- reg
> +       Usage:          required
> +       Value type:     <prop-encoded-array>
> +       Definition:     Addresses and sizes for the memory of the HW bases in
> +                       each frequency domain.
> +- reg-names
> +       Usage:          Optional
> +       Value type:     <string>
> +       Definition:     Frequency domain name i.e.
> +                       "freq-domain0", "freq-domain1".
> +
> +- freq-domain-cells:
> +       Usage:          required.
> +       Definition:     Number of cells in a freqency domain specifier.
> +
> +* Property qcom,freq-domain
> +Devices supporting freq-domain must set their "qcom,freq-domain" property with
> +phandle to a cpufreq_hw followed by the Domain ID(0/1) in the CPU DT node.
> +
> +
> +Example:
> +
> +Example 1: Dual-cluster, Quad-core per cluster. CPUs within a cluster switch
> +DCVS state together.
> +
> +/ {
> +       cpus {
> +               #address-cells = <2>;
> +               #size-cells = <0>;
> +
> +               CPU0: cpu@0 {
> +                       device_type = "cpu";
> +                       compatible = "qcom,kryo385";
> +                       reg = <0x0 0x0>;
> +                       enable-method = "psci";
> +                       next-level-cache = <&L2_0>;
> +                       qcom,freq-domain = <&cpufreq_hw 0>;
> +                       L2_0: l2-cache {
> +                               compatible = "cache";
> +                               next-level-cache = <&L3_0>;
> +                               L3_0: l3-cache {
> +                                     compatible = "cache";
> +                               };
> +                       };
> +               };
> +
> +               CPU1: cpu@100 {
> +                       device_type = "cpu";
> +                       compatible = "qcom,kryo385";
> +                       reg = <0x0 0x100>;
> +                       enable-method = "psci";
> +                       next-level-cache = <&L2_100>;
> +                       qcom,freq-domain = <&cpufreq_hw 0>;
> +                       L2_100: l2-cache {
> +                               compatible = "cache";
> +                               next-level-cache = <&L3_0>;
> +                       };
> +               };
> +
> +               CPU2: cpu@200 {
> +                       device_type = "cpu";
> +                       compatible = "qcom,kryo385";
> +                       reg = <0x0 0x200>;
> +                       enable-method = "psci";
> +                       next-level-cache = <&L2_200>;
> +                       qcom,freq-domain = <&cpufreq_hw 0>;
> +                       L2_200: l2-cache {
> +                               compatible = "cache";
> +                               next-level-cache = <&L3_0>;
> +                       };
> +               };
> +
> +               CPU3: cpu@300 {
> +                       device_type = "cpu";
> +                       compatible = "qcom,kryo385";
> +                       reg = <0x0 0x300>;
> +                       enable-method = "psci";
> +                       next-level-cache = <&L2_300>;
> +                       qcom,freq-domain = <&cpufreq_hw 0>;
> +                       L2_300: l2-cache {
> +                               compatible = "cache";
> +                               next-level-cache = <&L3_0>;
> +                       };
> +               };
> +
> +               CPU4: cpu@400 {
> +                       device_type = "cpu";
> +                       compatible = "qcom,kryo385";
> +                       reg = <0x0 0x400>;
> +                       enable-method = "psci";
> +                       next-level-cache = <&L2_400>;
> +                       qcom,freq-domain = <&cpufreq_hw 1>;
> +                       L2_400: l2-cache {
> +                               compatible = "cache";
> +                               next-level-cache = <&L3_0>;
> +                       };
> +               };
> +
> +               CPU5: cpu@500 {
> +                       device_type = "cpu";
> +                       compatible = "qcom,kryo385";
> +                       reg = <0x0 0x500>;
> +                       enable-method = "psci";
> +                       next-level-cache = <&L2_500>;
> +                       qcom,freq-domain = <&cpufreq_hw 1>;
> +                       L2_500: l2-cache {
> +                               compatible = "cache";
> +                               next-level-cache = <&L3_0>;
> +                       };
> +               };
> +
> +               CPU6: cpu@600 {
> +                       device_type = "cpu";
> +                       compatible = "qcom,kryo385";
> +                       reg = <0x0 0x600>;
> +                       enable-method = "psci";
> +                       next-level-cache = <&L2_600>;
> +                       qcom,freq-domain = <&cpufreq_hw 1>;
> +                       L2_600: l2-cache {
> +                               compatible = "cache";
> +                               next-level-cache = <&L3_0>;
> +                       };
> +               };
> +
> +               CPU7: cpu@700 {
> +                       device_type = "cpu";
> +                       compatible = "qcom,kryo385";
> +                       reg = <0x0 0x700>;
> +                       enable-method = "psci";
> +                       next-level-cache = <&L2_700>;
> +                       qcom,freq-domain = <&cpufreq_hw 1>;
> +                       L2_700: l2-cache {
> +                               compatible = "cache";
> +                               next-level-cache = <&L3_0>;
> +                       };
> +               };
> +       };
> +
> + soc {
> +       cpufreq_hw: cpufreq@17d43000 {
> +               compatible = "qcom,cpufreq-hw";
> +               reg = <0x17d43000 0x1400>, <0x17d45800 0x1400>;
> +               reg-names = "freq-domain0", "freq-domain1";
> +
> +               clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
> +               clock-names = "xo", "cpu_clk";
> +
> +               #freq-domain-cells = <1>
> +
> +       };
> +}
> --
> Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
> of the Code Aurora Forum, hosted by the  Linux Foundation.
>
