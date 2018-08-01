Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12711C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 14:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B35D20844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 14:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SPXLSkeQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B35D20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389493AbeHAPuz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 11:50:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:55952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389419AbeHAPuz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 11:50:55 -0400
Received: from mail-wm0-f50.google.com (mail-wm0-f50.google.com [74.125.82.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1471C208A4
        for <linux-kernel@vger.kernel.org>; Wed,  1 Aug 2018 14:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533132299;
        bh=LczsrwpC6zaPchS/ehkZZkjemYMMQJtDdBzuvhrdooA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SPXLSkeQYrOBnbsKvg5S6C5CnPxjkyMuB+6sNaBIg3DEGgQ4P8MxMPxkVeRRYD2vZ
         wY8e7bkL92vnC6VEnLu5Xr3L8UWGAk2VcdfaCx5RCqqVSN/lFjuuAphcY4J16f1lUT
         Y3m/erRTfVbeTzyQrmQXGuWXQ+4H4klWNLGO+ivM=
Received: by mail-wm0-f50.google.com with SMTP id s12-v6so7166266wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 07:04:59 -0700 (PDT)
X-Gm-Message-State: AOUpUlE0ChRjfbQkOyslGdU0yWlFnzfF+a4rAb7ONDKaO6g4fRpftFKn
        ZtWrLlmHh+75bd26grxIL+LLtvRByxw40ERVb7RBbQ==
X-Google-Smtp-Source: AAOMgpfjDqYY8shTWucL3pKvQ7yLPjd7uWl2Rd8MtJk1/MEo7UO25m0be06fKC6bc0xSH1UFesYSdcyPEB9SUF8s3Vk=
X-Received: by 2002:a1c:c241:: with SMTP id s62-v6mr2990122wmf.146.1533132297549;
 Wed, 01 Aug 2018 07:04:57 -0700 (PDT)
MIME-Version: 1.0
References: <1533061333-7680-1-git-send-email-pheragu@codeaurora.org> <1533061333-7680-2-git-send-email-pheragu@codeaurora.org>
In-Reply-To: <1533061333-7680-2-git-send-email-pheragu@codeaurora.org>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 1 Aug 2018 08:04:46 -0600
X-Gmail-Original-Message-ID: <CABGGiswcMicPypOz2eW01NosuAHUw2B3KVxzrOfanEfT=Srf9A@mail.gmail.com>
Message-ID: <CABGGiswcMicPypOz2eW01NosuAHUw2B3KVxzrOfanEfT=Srf9A@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: Documentation for qcom,eud
To:     pheragu@codeaurora.org
Cc:     linux-arm-msm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        tsoni@codeaurora.org, ckadabi@codeaurora.org,
        bryanh@codeaurora.org, psodagud@codeaurora.org,
        satyap@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 12:22 PM Prakruthi Deepak Heragu
<pheragu@codeaurora.org> wrote:
>
> Documentation for Embedded USB Debugger (EUD) device tree bindings.

If you want bindings reviewed, send them to the correct list and
people (hint: run get_maintainers.pl).

New bindings should not use extcon.

>
> Signed-off-by: Satya Durga Srinivasu Prabhala <satyap@codeaurora.org>
> Signed-off-by: Prakruthi Deepak Heragu <pheragu@codeaurora.org>
> ---
>  .../devicetree/bindings/soc/qcom/qcom,msm-eud.txt  | 28 ++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,msm-eud.txt
>
> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,msm-eud.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,msm-eud.txt
> new file mode 100644
> index 0000000..ea63f1c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,msm-eud.txt
> @@ -0,0 +1,28 @@
> +* Qualcomm Technologies Inc Embedded USB Debugger (EUD)
> +
> +The EUD (Embedded USB Debugger) is a mini-USB hub implemented
> +on chip to support the USB-based debug and trace capabilities.
> +
> +Required properties:
> +
> + - compatible:  Should be "qcom,msm-eud"
> + - interrupts:  Interrupt number
> + - reg: Should be address and size of EUD register space
> +
> +Driver notifies clients via extcon for VBUS attach/detach
> +and charger enable/disable events. Clients registered for these
> +notifications should have extcon property set to eud.
> +
> +An example for EUD device node:
> +
> +       eud: qcom,msm-eud@88e0000 {
> +               compatible = "qcom,msm-eud";
> +               interrupts = <GIC_SPI 492 IRQ_TYPE_LEVEL_HIGH>;
> +               reg = <0x88e0000 0x4000>;
> +       };
> +
> +An example for EUD extcon client:
> +
> +       usb3 {
> +               extcon = <&eud>;
> +       };
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>
