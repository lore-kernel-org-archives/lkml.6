Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C24ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 08:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72678206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 08:26:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="aG21FVI0";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="aG21FVI0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72678206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbeGTJNa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 05:13:30 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53840 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727204AbeGTJN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 05:13:29 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id DDF7A60B22; Fri, 20 Jul 2018 08:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532075180;
        bh=eU+zTjvt3FHhMcz4PlcatAKQan8PIGuCdkEemHPRGs4=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=aG21FVI0mkugqutLa1G5uhPWwgva1uxQzk85rU017I1FoU63U1nrEKcsFRNTC1OB8
         VdGFwJnNuzBZem9iG2XVREADbhAU5YihteAeP2KImmht078mh8NWrqII5bqOn6pSlx
         VPHo4O+56385l4HEZvThs8NZCyq/afMLVsRS+YOg=
Received: from mail-qt0-f171.google.com (mail-qt0-f171.google.com [209.85.216.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E11AD60B72;
        Fri, 20 Jul 2018 08:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532075180;
        bh=eU+zTjvt3FHhMcz4PlcatAKQan8PIGuCdkEemHPRGs4=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=aG21FVI0mkugqutLa1G5uhPWwgva1uxQzk85rU017I1FoU63U1nrEKcsFRNTC1OB8
         VdGFwJnNuzBZem9iG2XVREADbhAU5YihteAeP2KImmht078mh8NWrqII5bqOn6pSlx
         VPHo4O+56385l4HEZvThs8NZCyq/afMLVsRS+YOg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E11AD60B72
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-qt0-f171.google.com with SMTP id m13-v6so9595141qth.1;
        Fri, 20 Jul 2018 01:26:19 -0700 (PDT)
X-Gm-Message-State: AOUpUlHm8cPmihemZrHWxb1gp1cBj61gXnAfiYXIruQntZ4wymLbasRk
        /yVNb6J5Zjue4fy/C5yM38ltlDr1XQ1SwRWTvN8=
X-Google-Smtp-Source: AAOMgpfzemAFnzeAPMBM9qXGGwYh5jONnxEoJQzZkJV2NnPZ0TaO0Mkq0iEm9EVtfPk/7T9a9YGhS2jnB7pmHKiEEwE=
X-Received: by 2002:aed:2a33:: with SMTP id c48-v6mr962135qtd.147.1532075179115;
 Fri, 20 Jul 2018 01:26:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:f25:0:0:0:0:0 with HTTP; Fri, 20 Jul 2018 01:26:18 -0700 (PDT)
In-Reply-To: <CAL_JsqKQgZq23F7gqNoEDzpWj3zVR7Tsok3cZZCpCL=Br_+BeA@mail.gmail.com>
References: <20180719175356.14753-1-vivek.gautam@codeaurora.org>
 <20180719175356.14753-2-vivek.gautam@codeaurora.org> <CAL_JsqKQgZq23F7gqNoEDzpWj3zVR7Tsok3cZZCpCL=Br_+BeA@mail.gmail.com>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Date:   Fri, 20 Jul 2018 13:56:18 +0530
X-Gmail-Original-Message-ID: <CAFp+6iGg=6Hhxj9-995ZzP=_09Y3kZoXthcyNpUqikHsn97uyg@mail.gmail.com>
Message-ID: <CAFp+6iGg=6Hhxj9-995ZzP=_09Y3kZoXthcyNpUqikHsn97uyg@mail.gmail.com>
Subject: Re: [PATCH 1/3] dts: arm64/sdm845: Add node for arm,mmu-500
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Brown <david.brown@linaro.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Fri, Jul 20, 2018 at 4:38 AM, Rob Herring <robh+dt@kernel.org> wrote:
> On Thu, Jul 19, 2018 at 11:54 AM Vivek Gautam
> <vivek.gautam@codeaurora.org> wrote:
>>
>> Add device node for arm,mmu-500 available on sdm845.
>> This MMU-500 with single TCU and multiple TBU architecture
>> is shared among all the peripherals except gpu on sdm845.
>>
>> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
>> ---
>>  arch/arm64/boot/dts/qcom/sdm845-mtp.dts |  4 ++
>>  arch/arm64/boot/dts/qcom/sdm845.dtsi    | 73 +++++++++++++++++++++++++++++++++
>>  2 files changed, 77 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
>> index 6d651f314193..13b50dff440f 100644
>> --- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
>> +++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
>> @@ -58,3 +58,7 @@
>>                 bias-pull-up;
>>         };
>>  };
>> +
>> +&apps_smmu {
>> +       status = "okay";
>> +};
>> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> index 00722b533a92..70ca18ae6cb3 100644
>> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> @@ -980,6 +980,79 @@
>>                         cell-index = <0>;
>>                 };
>>
>> +               apps_smmu: arm,smmu@15000000 {
>
> iommu@...

Thanks for the review.
Sure, will modify this.

>
>> +                       compatible = "arm,mmu-500";
>
> Really unmodified by QCom? Would be better to have SoC specific compatible.

Yes, at this point we are able to use the driver as is on 845.
But, will add a SoC specific compatible as suggested to make bindings
future proof.

Best regards
Vivek

>
> Rob
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu



-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
