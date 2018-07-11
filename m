Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A388CC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 18:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AC7820C0E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 18:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="usGy0SxV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JgFoejrY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AC7820C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388236AbeGKSr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 14:47:58 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:43978 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732527AbeGKSr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 14:47:57 -0400
Received: by mail-ua0-f195.google.com with SMTP id x24-v6so16832415ual.10
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 11:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=QDCedcDfTXtzAQugp9IF0RrqYebpPAG5ciG6SMiGIPo=;
        b=usGy0SxVcOoP6tD2c8zaOKwbVX5IIvwS/pJ7gdYzcURhaakbKyOFXUJ24B/EkseBtC
         k6geLXFrLtNLts1ArynHpltn6gsH+kXKewv1Af6/uQsTQ6xFQUyhYV4y0o3VGFoWK1x4
         OCqLIuwqfmzrHUtG7610TFQpADi5M0GlXvsnuPROvZLqpQ6lLpgI55ireCKntxP1CiGo
         Yp0krNAtyerzMQ7ZlyithZc2dAmzkJ0XyMQl34gWHa2majTzQLiWGZsWQ7Rie6cM0jDl
         rWCM1VPYhLDl3JuYNjVYRBv4ycIrpXFyMBz1Olh7NdkKkV8gj2wCDMqKg/3qcg3k+FZz
         m5qQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=QDCedcDfTXtzAQugp9IF0RrqYebpPAG5ciG6SMiGIPo=;
        b=JgFoejrY3NVzCDtZYdb9L4lVNUoDw9v/EhID0pQG/USd5fWszOutYcMjxCu0IM3Uqt
         WGrPpRI3Ha4g4zjjuji30W3EKjw244dtv4Lr3MS6zBcKmaQfD0zuN1YisqgjKHyWyqDD
         nG/wXhYS2xAsG46/qeB2QAfKGPZLnH8bitOmo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=QDCedcDfTXtzAQugp9IF0RrqYebpPAG5ciG6SMiGIPo=;
        b=TXfS1nxhq4P60ZVCqIKMgEIw2wKlYNxZo2ehahVvSRI+kBLqbH5iE2tQryozBN/mHk
         9TON6mTistrChDLQiWDiGboq/hcVCSiPI8cPeIhiKVWlKyPOkNp9VgE9iwIPCXrCYTh8
         x1tXgpTbivDvqAjbROqtavMcgtN/8oWq8Tl4qLymhAVoCLU341OHOtIqcgclGlrY7NAP
         s11EtN7CVNPDMOBEhO9YwTjFBfVf0iTiBSZWFtAFU2scgqzf3fVosktXW6eeBjsPQtOl
         GptlR7faIlNJQaNuDqy/OgSqKCVUinYdc3z7ZTuajKbWcpVrXihdtST7osHBYGz2kji+
         qhTg==
X-Gm-Message-State: APt69E3s0S+NoQSN9/O6KcdEcsG9eSLgwrbyfiIoEjHlhCQZAJb7yc/z
        292RhEDyYJcUUhvq+HrbQj5fhmNuevDoN/8kJlfdqy2BERI=
X-Google-Smtp-Source: AAOMgpdu/1aHvGszboJNS/wFnelMEfxmNDezqdT9UPoZaZj0cllqImoueMheVo44ol8u0U4fiEq4y8Z5tia67+DHD6M=
X-Received: by 2002:ab0:3308:: with SMTP id r8-v6mr17732915uao.121.1531334540568;
 Wed, 11 Jul 2018 11:42:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:9495:0:0:0:0:0 with HTTP; Wed, 11 Jul 2018 11:42:19
 -0700 (PDT)
In-Reply-To: <bf1147fa417314b2fbf5c0cfb682445587fe39bb.1531136000.git.amit.kucheria@linaro.org>
References: <cover.1531135999.git.amit.kucheria@linaro.org> <bf1147fa417314b2fbf5c0cfb682445587fe39bb.1531136000.git.amit.kucheria@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 11 Jul 2018 11:42:19 -0700
X-Google-Sender-Auth: 5XCq0PnEXTrX03fF6ai-mW2HBHg
Message-ID: <CAD=FV=W-snhM9L9Ez-ypAJwn2NhNJ1X=s5wDvu-gbQvmLZY9Qg@mail.gmail.com>
Subject: Re: [PATCH v6 6/7] dt: thermal: tsens: Document the fallback DT
 property for v2 of TSENS IP
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        smohanad@codeaurora.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jul 9, 2018 at 4:43 AM, Amit Kucheria <amit.kucheria@linaro.org> wrote:
> We want to create common code for v2 of the TSENS IP block that is used in
> a large number of Qualcomm SoCs. "qcom,tsens-v2" should be able to handle
> most of the common functionality start with a common get_temp() function.
>
> It is also necessary to split out the memory regions for the TM and SROT
> register banks because their offsets are not constant across SoC families.

nit that bindings should be earlier in the patch series than the code
implementing the bindings.


> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  .../devicetree/bindings/thermal/qcom-tsens.txt     | 25 +++++++++++++++++-----
>  1 file changed, 20 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.txt b/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
> index 06195e8..8f963b1 100644
> --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
> +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
> @@ -1,10 +1,16 @@
>  * QCOM SoC Temperature Sensor (TSENS)
>
>  Required properties:
> -- compatible :
> - - "qcom,msm8916-tsens" : For 8916 Family of SoCs
> - - "qcom,msm8974-tsens" : For 8974 Family of SoCs
> - - "qcom,msm8996-tsens" : For 8996 Family of SoCs
> +- compatible:
> +  Must be one of the following:
> +    - "qcom,msm8916-tsens" (MSM8916)
> +    - "qcom,msm8974-tsens" (MSM8974)
> +    - "qcom,msm8996-tsens" (MSM8996)
> +    - "qcom,msm8998-tsens", "qcom,tsens-v2" (MSM8998)
> +    - "qcom,sdm845-tsens", "qcom,tsens-v2" (SDM845)
> +  The generic "qcom,tsens-v2" property must be used as a fallback for any SoC with
> +  version 2 of the TSENS IP. MSM8996 is the only exception beacause the generic
> +  property did not exist when support was added.
>
>  - reg: Address range of the thermal registers

You need to document that for old SoCs where TM / SROT were 0x1000
apart (SROT first) that one "reg" field was OK.  ...and that for new
SoCs you specify two reg ranges: the first for TM and the second for
SROT.


>  - #thermal-sensor-cells : Should be 1. See ./thermal.txt for a description.
> @@ -12,7 +18,7 @@ Required properties:
>  - Refer to Documentation/devicetree/bindings/nvmem/nvmem.txt to know how to specify
>  nvmem cells
>
> -Example:
> +Example 1 (legacy support before a fallback tsens-v2 propoerty was introduced):
>  tsens: thermal-sensor@900000 {
>                 compatible = "qcom,msm8916-tsens";
>                 reg = <0x4a8000 0x2000>;
> @@ -20,3 +26,12 @@ tsens: thermal-sensor@900000 {
>                 nvmem-cell-names = "caldata", "calsel";
>                 #thermal-sensor-cells = <1>;
>         };
> +
> +Example 2 (for any platform containing v2 of the TSENS IP):
> +tsens0: tsens@c222000 {

A) Use a generic name for the node, not a specific one.  Thus the node
should be "thermal-sensor", not "tsens".

B) This unit address needs to match the _first_ reg address listed.
Give your reg below, this should be @c263000

Thus your node name should be:

tsens0: thermal-sensor@c263000 {

> +               compatible = "qcom,sdm845-tsens", "qcom,tsens-v2";
> +               reg = <0xc263000 0x1ff>, /* TM */
> +                       <0xc222000 0x1ff>; /* SROT */
> +               #qcom,sensors = <13>;

The "#qcom,sensors" property seems wrong in a few ways:

A) I wouldn't have expected it to start with a "#".  I only expect to
see that on things specifying sizes / lengths.  Rob can feel free to
override me, though.

B) It's not documented above.  Just putting something in an example
doesn't document it--it needs to be listed in the "Optional
properties".
