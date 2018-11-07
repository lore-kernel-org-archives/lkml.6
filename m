Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D9BAC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 14:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B619F20827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 14:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DxaTOyz1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B619F20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731100AbeKHAaF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 19:30:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:44088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727840AbeKHAaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 19:30:05 -0500
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C15F21104
        for <linux-kernel@vger.kernel.org>; Wed,  7 Nov 2018 14:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541602762;
        bh=J05Gf3oXF515I55SaO0wqzK37cYgIEcfQA/U60AcjdA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DxaTOyz1iGFs306KxnYQeR7XEhPS0attKClqM/27ta0xqjz3ZnEdBYuB8w3bNfhsy
         NSbb+oEYgaqy+WCI4hRgR5MSDH0fPzFVLmaPY3Hhyln72mTtzsvUZrcgUespBJgshj
         229xp1DO3XSV4rSTAJBacAcO6qtUlow2Lndmisv8=
Received: by mail-wr1-f50.google.com with SMTP id y15-v6so17730283wru.9
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 06:59:22 -0800 (PST)
X-Gm-Message-State: AGRZ1gJtEs7EFLO9RTBvrGdEVYOhao4Ed4EXZuDJvkaCEAUo7CfIdG3z
        hSQpDpd4HGRn1gps8QSWh4IFnxJpC5iMjC1YrfqGuA==
X-Google-Smtp-Source: AJdET5dYFL9bASNN9YDrnna2WcqkwidtoAy2w3V2NrNTWw7saeEzAQ9V9Ho3+6pZ4XOXQOB54E5Mryl8OeV4qECD/O0=
X-Received: by 2002:a5d:410d:: with SMTP id l13-v6mr515907wrp.61.1541602760402;
 Wed, 07 Nov 2018 06:59:20 -0800 (PST)
MIME-Version: 1.0
References: <20181107003250.5832-1-elder@linaro.org> <20181107003250.5832-2-elder@linaro.org>
In-Reply-To: <20181107003250.5832-2-elder@linaro.org>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 7 Nov 2018 08:59:08 -0600
X-Gmail-Original-Message-ID: <CABGGiswmpmSUmg9jEW7GnNtL2uXAN7jJOqFO5kG8adq71GuZpw@mail.gmail.com>
Message-ID: <CABGGiswmpmSUmg9jEW7GnNtL2uXAN7jJOqFO5kG8adq71GuZpw@mail.gmail.com>
Subject: Re: [RFC PATCH 01/12] dt-bindings: soc: qcom: add IPA bindings
To:     Alex Elder <elder@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, davem@davemloft.net,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        ilias.apalodimas@linaro.org, netdev <netdev@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syadagir@codeaurora.org, mjavid@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 6, 2018 at 6:33 PM Alex Elder <elder@linaro.org> wrote:
>
> Add the binding definitions for the "qcom,ipa" and "qcom,rmnet-ipa"
> device tree nodes.
>
> Signed-off-by: Alex Elder <elder@linaro.org>
> ---
>  .../devicetree/bindings/soc/qcom/qcom,ipa.txt | 136 ++++++++++++++++++
>  .../bindings/soc/qcom/qcom,rmnet-ipa.txt      |  15 ++
>  2 files changed, 151 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,ipa.txt
>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,rmnet-ipa.txt
>
> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,ipa.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,ipa.txt
> new file mode 100644
> index 000000000000..d4d3d37df029
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,ipa.txt
> @@ -0,0 +1,136 @@
> +Qualcomm IPA (IP Accelerator) Driver

Bindings are for h/w not drivers.

> +
> +This binding describes the Qualcomm IPA.  The IPA is capable of offloading
> +certain network processing tasks (e.g. filtering, routing, and NAT) from
> +the main processor.  The IPA currently serves only as a network interface,
> +providing access to an LTE network available via a modem.
> +
> +The IPA sits between multiple independent "execution environments,"
> +including the AP subsystem (APSS) and the modem.  The IPA presents
> +a Generic Software Interface (GSI) to each execution environment.
> +The GSI is an integral part of the IPA, but it is logically isolated
> +and has a distinct interrupt and a separately-defined address space.
> +
> +    ----------   -------------   ---------
> +    |        |   |G|       |G|   |       |
> +    |  APSS  |===|S|  IPA  |S|===| Modem |
> +    |        |   |I|       |I|   |       |
> +    ----------   -------------   ---------
> +
> +See also:
> +  bindings/interrupt-controller/interrupts.txt
> +  bindings/interconnect/interconnect.txt
> +  bindings/soc/qcom/qcom,smp2p.txt
> +  bindings/reserved-memory/reserved-memory.txt
> +  bindings/clock/clock-bindings.txt
> +
> +All properties defined below are required.
> +
> +- compatible:
> +       Must be one of the following compatible strings:
> +               "qcom,ipa-sdm845-modem_init"
> +               "qcom,ipa-sdm845-tz_init"

Normal order is <vendor>,<soc>-<ipblock>.

Don't use '_'.

What's the difference between these 2? It can't be detected somehow?
This might be better expressed as a property. Then if Trustzone
initializes things, it can just add a property.

> +
> +-reg:
> +       Resources specyfing the physical address spaces of the IPA and GSI.

typo

> +
> +-reg-names:
> +       The names of the address space ranges defined by the "reg" property.
> +       Must be "ipa" and "gsi".
> +
> +- interrupts-extended:

Use 'interrupts' here and describe what they are and the order. What
they are connected to (and the need for interrupts-extended) is
outside the scope of this binding.

> +       Specifies the IRQs used by the IPA.  Four cells are required,
> +       specifying: the IPA IRQ; the GSI IRQ; the clock query interrupt
> +       from the modem; and the "ready for stage 2 initialization"
> +       interrupt from the modem.  The first two are hardware IRQs; the
> +       third and fourth are SMP2P input interrupts.
> +
> +- interrupt-names:
> +       The names of the interrupts defined by the "interrupts-extended"
> +       property.  Must be "ipa", "gsi", "ipa-clock-query", and
> +       "ipa-post-init".

Format as one per line.

> +
> +- clocks:
> +       Resource that defines the IPA core clock.
> +
> +- clock-names:
> +       The name used for the IPA core clock.  Must be "core".
> +
> +- interconnects:
> +       Specifies the interconnects used by the IPA.  Three cells are
> +       required, specifying:  the path from the IPA to memory; from
> +       IPA to internal (SoC resident) memory; and between the AP
> +       subsystem and IPA for register access.
> +
> +- interconnect-names:
> +       The names of the interconnects defined by the "interconnects"
> +       property.  Must be "memory", "imem", and "config".
> +
> +- qcom,smem-states
> +       The state bits used for SMP2P output.  Two cells must be specified.
> +       The first indicates whether the value in the second bit is valid
> +       (1 means valid).  The second, if valid, defines whether the IPA
> +       clock is enabled (1 means enabled).
> +
> +- qcom,smem-state-names
> +       The names of the state bits used for SMP2P output.  These must be
> +       "ipa-clock-enabled-valid" and "ipa-clock-enabled".
> +
> +- memory-region
> +       A phandle for a reserved memory area that holds the firmware passed
> +       to Trust Zone for authentication.  (Note, this is required
> +       only for "qcom,ipa-sdm845-tz_init".)
> +
> += EXAMPLE
> +
> +The following example represents the IPA present in the SDM845 SoC.  It
> +shows portions of the "modem-smp2p" node to indicate its relationship
> +with the interrupts and SMEM states used by the IPA.
> +
> +       modem-smp2p {
> +               compatible = "qcom,smp2p";
> +               . . .
> +               ipa_smp2p_out: ipa-ap-to-modem {
> +                       qcom,entry-name = "ipa";
> +                       #qcom,smem-state-cells = <1>;
> +               };
> +
> +               ipa_smp2p_in: ipa-modem-to-ap {
> +                       qcom,entry-name = "ipa";
> +                       interrupt-controller;
> +                       #interrupt-cells = <2>;
> +               };
> +       };
> +
> +       ipa@1e00000 {

ipa@1e40000

> +               compatible = "qcom,ipa-sdm845-modem_init";
> +
> +               reg = <0x1e40000 0x34000>,
> +                     <0x1e04000 0x2c000>;
> +               reg-names = "ipa",
> +                           "gsi";
> +
> +               interrupts-extended = <&intc 0 311 IRQ_TYPE_LEVEL_HIGH>,
> +                                     <&intc 0 432 IRQ_TYPE_LEVEL_HIGH>,
> +                                     <&ipa_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
> +                                     <&ipa_smp2p_in 1 IRQ_TYPE_EDGE_RISING>;
> +               interrupt-names = "ipa",
> +                                 "gsi",
> +                                 "ipa-clock-query",
> +                                 "ipa-post-init";
> +
> +               clocks = <&rpmhcc RPMH_IPA_CLK>;
> +               clock-names = "core";
> +
> +               interconnects = <&qnoc MASTER_IPA &qnoc SLAVE_EBI1>,
> +                               <&qnoc MASTER_IPA &qnoc SLAVE_IMEM>,
> +                               <&qnoc MASTER_APPSS_PROC &qnoc SLAVE_IPA_CFG>;
> +               interconnect-names = "memory",
> +                                    "imem",
> +                                    "config";
> +
> +               qcom,smem-states = <&ipa_smp2p_out 0>,
> +                                  <&ipa_smp2p_out 1>;
> +               qcom,smem-state-names = "ipa-clock-enabled-valid",
> +                                       "ipa-clock-enabled";
> +       };
> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,rmnet-ipa.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,rmnet-ipa.txt
> new file mode 100644
> index 000000000000..3d0b2aabefc7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,rmnet-ipa.txt
> @@ -0,0 +1,15 @@
> +Qualcomm IPA RMNet Driver
> +
> +This binding describes the IPA RMNet driver, which is used to
> +represent virtual interfaces available on the modem accessed via
> +the IPA.  Other than the compatible string there are no properties
> +associated with this device.

Only a compatible string is a sure sign this is not a h/w device and
you are just abusing DT to instantiate drivers. Make the IPA driver
instantiate any sub drivers it needs.

Rob
