Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE49C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 07:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD9B22084D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 07:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="n4ArLINE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731536AbeLQH4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 02:56:20 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:42861 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbeLQH4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 02:56:19 -0500
Received: by mail-ua1-f65.google.com with SMTP id d21so4097902uap.9
        for <linux-kernel@vger.kernel.org>; Sun, 16 Dec 2018 23:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=guaaEgX8Iocv0fqjxPzxlpLywwiMHn5P7BspHXdJw4s=;
        b=n4ArLINE56WXhrhOEnFBySDb968o76jLlrny1QuuvpzPCxQR0kbaEAlKVJB5z616jz
         GAokCpIL6kvcFd3TISzyI1WL+OzaX93flAQuxJuHEsJYXwrmMxs1lCqPX6ODjJ29sMA1
         2kr7B86TiTeEu4pdBsYNmLWGtXFCCsQNGPcs/4HWtwKPoICj6MjPSTP4m/RO6rAi1zLB
         lQoRuuPpN/RVlhvoeIakkP/SyPFraE73Sdhmaqf+oL6BhjEtdWTVtPgoNTL3hYSucG+w
         Tfwh/UKhYD2ludHmWfaQ1FnKmuPpONrcS/WjdIme+IxPQkf1DMhkYt8mvOyJZtOSClPN
         Xlzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=guaaEgX8Iocv0fqjxPzxlpLywwiMHn5P7BspHXdJw4s=;
        b=D3bri6ogOB6hVTjRTmvTbqUqzMZjX9LEfVYGKQzkqDjqYqLVwMnq73R86FTm8G6dvG
         FxQIN8aYgqsUvs6oD0ay9mVIlT+4jgB6Wc7MTtrM+WBqjKO+x3Itx3zoPBcAj/NPbq8B
         RfpRU5/A1OdYHvwQTgKoi1PVY/6OHOgioEdulNyrBfCtgRLUe5TaKdyb8MhtZeAAw8RZ
         e18DPV0TiBTzX+axNO2V6ju0ZNEz3x+iZgweVjaVXaOGPsDXXLBu0qGNfhaPIRmAdKc4
         p/nqNoZvbVhUp80Jl9E6LlWe5osxk4ivifzNsxwZNCAWoAyu8MSwgftzg7RDIVPd39jo
         GsRg==
X-Gm-Message-State: AA+aEWZyxba5HHratwFAJQge5wS4dzElovruFT8ny0WaU8fX8RtfJMFk
        4b8GNyCVIN1ud/JbVRyp6FIh5wDlbZl+mOyrZMZ1tQ==
X-Google-Smtp-Source: AFSGD/Vne0Ax8f77zIyO7NN621G7wbH8TcCTQquuFgNxAcJRqgSb0JTxmfvqz+xaHC8IVrGxbfc8XLXLgud9ekP7nl8=
X-Received: by 2002:ab0:2417:: with SMTP id f23mr5902317uan.129.1545033377792;
 Sun, 16 Dec 2018 23:56:17 -0800 (PST)
MIME-Version: 1.0
References: <1544760624-12874-1-git-send-email-tdas@codeaurora.org> <1544760624-12874-2-git-send-email-tdas@codeaurora.org>
In-Reply-To: <1544760624-12874-2-git-send-email-tdas@codeaurora.org>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Mon, 17 Dec 2018 13:26:04 +0530
Message-ID: <CAHLCerNZawU4Qexi5gdYLHDY90HNO5Tox0EVPWyy2L2QtUOX0g@mail.gmail.com>
Subject: Re: [PATCH v13 1/2] dt-bindings: cpufreq: Introduce QCOM CPUFREQ
 Firmware bindings
To:     Taniya Das <tdas@codeaurora.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <skannan@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        evgreen@google.com, Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 9:40 AM Taniya Das <tdas@codeaurora.org> wrote:
>
> Add QCOM cpufreq firmware device bindings for Qualcomm Technology Inc's
> SoCs. This is required for managing the cpu frequency transitions which are
> controlled by the hardware engine.
>
> Signed-off-by: Taniya Das <tdas@codeaurora.org>

Tested-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
>  .../bindings/cpufreq/cpufreq-qcom-hw.txt           | 172 +++++++++++++++++++++
>  1 file changed, 172 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
>
> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
> new file mode 100644
> index 0000000..33856947
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
> @@ -0,0 +1,172 @@
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
> +       Definition:     must be "xo", "alternate".
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
> +- #freq-domain-cells:
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
> +               clock-names = "xo", "alternate";
> +
> +               #freq-domain-cells = <1>;
> +       };
> +}
> --
> Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
> of the Code Aurora Forum, hosted by the  Linux Foundation.
>
