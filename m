Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 035F0ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 08:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A66C9208FC
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 08:53:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fx2GBp20"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A66C9208FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731175AbeGPJTj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 05:19:39 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36801 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729595AbeGPJTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 05:19:38 -0400
Received: by mail-lj1-f196.google.com with SMTP id u7-v6so26602334lji.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 01:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=EVUmlH6FS+z/wMuyx+xgPEK2M7zLF9DNYLfx4Gt3oAo=;
        b=fx2GBp20YHA7DnrVBn0tlh+Jgw435cq40qcpnvIN8yIIwHwxARwjnV6HsieFMHpXZL
         KueQd3jrKJlHaWqoILPu7ewsnYFEuJxeQfXfH+lMRP9DLVWAbRqjqvcIckvrFa8PxWtP
         5qXrDCcH8rof8+XRD87osjrn5gNAsVzbormao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=EVUmlH6FS+z/wMuyx+xgPEK2M7zLF9DNYLfx4Gt3oAo=;
        b=DJJjEgz2Zx0Nu9+oAFrTrERqOUySpf9xItMIWYI7e3XvU/bTYNowkskvnKc2KF+W1c
         ZZvk/h+zvPJWalvpu10h1O58lf9sKzP3W32+s15Ah+eoDnsX/qfWqfj9dBrEXzvjwDut
         gOVIMSxhzWC6B9K+badnLOB0DsKVEWd/5X4XJX2bDiI9M4ujZ6hIX9TmZSowd8Dd0B7A
         LPjA1mb4m4LmUZx5YacayLiNgMoA6UzIL8Ka/uxY7SxabfsVRSaE7Z8nlWKNCIqeTS6E
         1uT0yBK/yGjUAbgpwhs/o8mSjigi8WIwy9hqC6Xe7UG0qMdq3hlMF13V3a1LC9mJHUs3
         PsSg==
X-Gm-Message-State: AOUpUlHlGLAZaIn1sW4hXiWyM3BZgcUICF3H8kDD+OBp27b1c9xPoyRI
        QjzZ7QNpjBpC6BbBwOlJhhY5h0JQw2uj9lLH5KLZ2A==
X-Google-Smtp-Source: AAOMgpfHINjPI5ad6kFuQ6MYKdx5RL+vEcBGnrKM4Xy6KXarzBP1e1p7dA+YU1trw0woeWTf6jgtdjhBJnHj9UO6mec=
X-Received: by 2002:a2e:2b0e:: with SMTP id q14-v6mr9322441lje.147.1531731194201;
 Mon, 16 Jul 2018 01:53:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:d3cd:0:0:0:0:0 with HTTP; Mon, 16 Jul 2018 01:53:13
 -0700 (PDT)
In-Reply-To: <20180711160713.GA29354@rob-hp-laptop>
References: <1530797585-8555-1-git-send-email-todor.tomov@linaro.org>
 <1530797585-8555-9-git-send-email-todor.tomov@linaro.org> <20180711160713.GA29354@rob-hp-laptop>
From:   Todor Tomov <todor.tomov@linaro.org>
Date:   Mon, 16 Jul 2018 11:53:13 +0300
Message-ID: <CAA3CUABj_udpu1yAGGd070_uLNYLbTYEHb_sbHLheUErkPnYtQ@mail.gmail.com>
Subject: Re: [PATCH v2 08/34] media: camss: Unify the clock names
To:     Rob Herring <robh@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thank you for review.

On 11 July 2018 at 19:07, Rob Herring <robh@kernel.org> wrote:
> On Thu, Jul 05, 2018 at 04:32:39PM +0300, Todor Tomov wrote:
>> Unify the clock names - use names closer to the clock
>> definitions.
>
> Why? You can't just change names. You are breaking an ABI.

Main reason is that this change allows more logical names and
handling in the driver when support for 8996 is added.
To clarify by example:
- we used to have "camss_vfe_vfe" in 8916;
- now we will have "vfe0" in 8916 and "vfe0" and "vfe1" in 8996.

To achieve this I have changed the names to match more closely
the definitions in the clock driver, which are based on the
documentation. Yes, I should have done this the first time...

I have used to update the dt and kernel code together. Yes, the
change breaks the ABI but does this cause difficulties in practice?

>
>>
>> CC: Rob Herring <robh+dt@kernel.org>
>> CC: Mark Rutland <mark.rutland@arm.com>
>> CC: devicetree@vger.kernel.org
>> Signed-off-by: Todor Tomov <todor.tomov@linaro.org>
>> ---
>>  .../devicetree/bindings/media/qcom,camss.txt       | 24 +++++++++++-----------
>
> Bindings should be a separate patch.

I can do that in the next version.

Best regards,
Todor

>
>>  drivers/media/platform/qcom/camss/camss.c          | 20 ++++++++----------
>>  2 files changed, 20 insertions(+), 24 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/media/qcom,camss.txt b/Documentation/devicetree/bindings/media/qcom,camss.txt
>> index cadeceb..032e8ed 100644
>> --- a/Documentation/devicetree/bindings/media/qcom,camss.txt
>> +++ b/Documentation/devicetree/bindings/media/qcom,camss.txt
>> @@ -53,7 +53,7 @@ Qualcomm Camera Subsystem
>>       Usage: required
>>       Value type: <stringlist>
>>       Definition: Should contain the following entries:
>> -                - "camss_top_ahb"
>> +                - "top_ahb"
>>                  - "ispif_ahb"
>>                  - "csiphy0_timer"
>>                  - "csiphy1_timer"
>> @@ -67,11 +67,11 @@ Qualcomm Camera Subsystem
>>                  - "csi1_phy"
>>                  - "csi1_pix"
>>                  - "csi1_rdi"
>> -                - "camss_ahb"
>> -                - "camss_vfe_vfe"
>> -                - "camss_csi_vfe"
>> -                - "iface"
>> -                - "bus"
>> +                - "ahb"
>> +                - "vfe0"
>> +                - "csi_vfe0"
>> +                - "vfe_ahb"
>> +                - "vfe_axi"
>>  - vdda-supply:
>>       Usage: required
>>       Value type: <phandle>
>> @@ -161,7 +161,7 @@ Qualcomm Camera Subsystem
>>                       <&gcc GCC_CAMSS_CSI_VFE0_CLK>,
>>                       <&gcc GCC_CAMSS_VFE_AHB_CLK>,
>>                       <&gcc GCC_CAMSS_VFE_AXI_CLK>;
>> -                clock-names = "camss_top_ahb",
>> +                clock-names = "top_ahb",
>>                          "ispif_ahb",
>>                          "csiphy0_timer",
>>                          "csiphy1_timer",
>> @@ -175,11 +175,11 @@ Qualcomm Camera Subsystem
>>                          "csi1_phy",
>>                          "csi1_pix",
>>                          "csi1_rdi",
>> -                        "camss_ahb",
>> -                        "camss_vfe_vfe",
>> -                        "camss_csi_vfe",
>> -                        "iface",
>> -                        "bus";
>> +                        "ahb",
>> +                        "vfe0",
>> +                        "csi_vfe0",
>> +                        "vfe_ahb",
>> +                        "vfe_axi";
>>               vdda-supply = <&pm8916_l2>;
>>               iommus = <&apps_iommu 3>;
>>               ports {
>> diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
>> index abf6184..0b663e0 100644
>> --- a/drivers/media/platform/qcom/camss/camss.c
>> +++ b/drivers/media/platform/qcom/camss/camss.c
>> @@ -32,8 +32,7 @@ static const struct resources csiphy_res[] = {
>>       /* CSIPHY0 */
>>       {
>>               .regulator = { NULL },
>> -             .clock = { "camss_top_ahb", "ispif_ahb",
>> -                        "camss_ahb", "csiphy0_timer" },
>> +             .clock = { "top_ahb", "ispif_ahb", "ahb", "csiphy0_timer" },
>>               .clock_rate = { { 0 },
>>                               { 0 },
>>                               { 0 },
>> @@ -45,8 +44,7 @@ static const struct resources csiphy_res[] = {
>>       /* CSIPHY1 */
>>       {
>>               .regulator = { NULL },
>> -             .clock = { "camss_top_ahb", "ispif_ahb",
>> -                        "camss_ahb", "csiphy1_timer" },
>> +             .clock = { "top_ahb", "ispif_ahb", "ahb", "csiphy1_timer" },
>>               .clock_rate = { { 0 },
>>                               { 0 },
>>                               { 0 },
>> @@ -60,8 +58,7 @@ static const struct resources csid_res[] = {
>>       /* CSID0 */
>>       {
>>               .regulator = { "vdda" },
>> -             .clock = { "camss_top_ahb", "ispif_ahb",
>> -                        "csi0_ahb", "camss_ahb",
>> +             .clock = { "top_ahb", "ispif_ahb", "csi0_ahb", "ahb",
>>                          "csi0", "csi0_phy", "csi0_pix", "csi0_rdi" },
>>               .clock_rate = { { 0 },
>>                               { 0 },
>> @@ -78,8 +75,7 @@ static const struct resources csid_res[] = {
>>       /* CSID1 */
>>       {
>>               .regulator = { "vdda" },
>> -             .clock = { "camss_top_ahb", "ispif_ahb",
>> -                        "csi1_ahb", "camss_ahb",
>> +             .clock = { "top_ahb", "ispif_ahb", "csi1_ahb", "ahb",
>>                          "csi1", "csi1_phy", "csi1_pix", "csi1_rdi" },
>>               .clock_rate = { { 0 },
>>                               { 0 },
>> @@ -96,10 +92,10 @@ static const struct resources csid_res[] = {
>>
>>  static const struct resources_ispif ispif_res = {
>>       /* ISPIF */
>> -     .clock = { "camss_top_ahb", "camss_ahb", "ispif_ahb",
>> +     .clock = { "top_ahb", "ahb", "ispif_ahb",
>>                  "csi0", "csi0_pix", "csi0_rdi",
>>                  "csi1", "csi1_pix", "csi1_rdi" },
>> -     .clock_for_reset = { "camss_vfe_vfe", "camss_csi_vfe" },
>> +     .clock_for_reset = { "vfe0", "csi_vfe0" },
>>       .reg = { "ispif", "csi_clk_mux" },
>>       .interrupt = "ispif"
>>
>> @@ -108,8 +104,8 @@ static const struct resources_ispif ispif_res = {
>>  static const struct resources vfe_res = {
>>       /* VFE0 */
>>       .regulator = { NULL },
>> -     .clock = { "camss_top_ahb", "camss_vfe_vfe", "camss_csi_vfe",
>> -                "iface", "bus", "camss_ahb" },
>> +     .clock = { "top_ahb", "vfe0", "csi_vfe0",
>> +                "vfe_ahb", "vfe_axi", "ahb" },
>>       .clock_rate = { { 0 },
>>                       { 50000000, 80000000, 100000000, 160000000,
>>                         177780000, 200000000, 266670000, 320000000,
>> --
>> 2.7.4
>>
