Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53AB5C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0356420894
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="WfT6BsD1";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="WfT6BsD1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0356420894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730907AbeG0LSo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:18:44 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38982 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730314AbeG0LSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:18:44 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D116960594; Fri, 27 Jul 2018 09:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532685454;
        bh=TodzFO91/xWF1gGw5AZ+BEelejB0aLLPeqShYL+UesY=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=WfT6BsD1y2DPvQLlXtbvoFkeU/o71kuBSTT8rgRGxXqv+d01ESTNOYADoHbZCO1Y+
         +CJshM2z2Alsd5uRBGKXL1aXT5zBHbFYf829xlzMhxF9iafcN3hEjkLdDTXA6+6PmU
         GeYrcZh5N5RsJMwxtdWyy72/mluNAsJYToQcWH7Y=
Received: from mail-qk0-f180.google.com (mail-qk0-f180.google.com [209.85.220.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4B839607B9;
        Fri, 27 Jul 2018 09:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532685454;
        bh=TodzFO91/xWF1gGw5AZ+BEelejB0aLLPeqShYL+UesY=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=WfT6BsD1y2DPvQLlXtbvoFkeU/o71kuBSTT8rgRGxXqv+d01ESTNOYADoHbZCO1Y+
         +CJshM2z2Alsd5uRBGKXL1aXT5zBHbFYf829xlzMhxF9iafcN3hEjkLdDTXA6+6PmU
         GeYrcZh5N5RsJMwxtdWyy72/mluNAsJYToQcWH7Y=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4B839607B9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-qk0-f180.google.com with SMTP id t79-v6so2881485qke.4;
        Fri, 27 Jul 2018 02:57:34 -0700 (PDT)
X-Gm-Message-State: AOUpUlGAhmc4+6eYHq3OSGSl555tF9YX2nvgrN6gpkge1S2r1gEnxym2
        g2Zb43fBZ5/uAz7SKAWTF7BGWc8Z8gP2Hx21Fps=
X-Google-Smtp-Source: AAOMgpcQI9KPWsCk/JV92J67B26KEZT748da0Uq8p6f71QNIXE7k1E2cxdPeKFist5hhg0NDQDXt6F2F1RgKTaLUKQ8=
X-Received: by 2002:a37:5942:: with SMTP id n63-v6mr5172737qkb.28.1532685453580;
 Fri, 27 Jul 2018 02:57:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:f25:0:0:0:0:0 with HTTP; Fri, 27 Jul 2018 02:57:33 -0700 (PDT)
In-Reply-To: <20180725115729.GA31576@arm.com>
References: <20180719175356.14753-1-vivek.gautam@codeaurora.org>
 <20180719175356.14753-4-vivek.gautam@codeaurora.org> <20180724083633.GA19324@arm.com>
 <d6796a00-17da-c03e-ca7f-7a67139ad99a@codeaurora.org> <20180725115729.GA31576@arm.com>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Date:   Fri, 27 Jul 2018 15:27:33 +0530
X-Gmail-Original-Message-ID: <CAFp+6iEwS1xHYz2eptO1p2hzw+cb6WOvohDkx1SGmthzV0SbyA@mail.gmail.com>
Message-ID: <CAFp+6iEwS1xHYz2eptO1p2hzw+cb6WOvohDkx1SGmthzV0SbyA@mail.gmail.com>
Subject: Re: [PATCH 3/3] iommu/arm-smmu: Error out only if not enough context interrupts
To:     Will Deacon <will.deacon@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        David Brown <david.brown@linaro.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        "robh+dt" <robh+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 5:27 PM, Will Deacon <will.deacon@arm.com> wrote:
> On Tue, Jul 24, 2018 at 03:09:41PM +0530, Vivek Gautam wrote:
>> On 7/24/2018 2:06 PM, Will Deacon wrote:
>> >On Thu, Jul 19, 2018 at 11:23:56PM +0530, Vivek Gautam wrote:
>> >>diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>> >>index 7c69736a30f8..4cb53bf4f423 100644
>> >>--- a/drivers/iommu/arm-smmu.c
>> >>+++ b/drivers/iommu/arm-smmu.c
>> >>@@ -2229,12 +2229,19 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>> >>    if (err)
>> >>            return err;
>> >>-   if (smmu->version == ARM_SMMU_V2 &&
>> >>-       smmu->num_context_banks != smmu->num_context_irqs) {
>> >>-           dev_err(dev,
>> >>-                   "found only %d context interrupt(s) but %d required\n",
>> >>-                   smmu->num_context_irqs, smmu->num_context_banks);
>> >>-           return -ENODEV;
>> >>+   if (smmu->version == ARM_SMMU_V2) {
>> >>+           if (smmu->num_context_banks > smmu->num_context_irqs) {
>> >>+                   dev_err(dev,
>> >>+                         "found only %d context irq(s) but %d required\n",
>> >>+                         smmu->num_context_irqs, smmu->num_context_banks);
>> >>+                   return -ENODEV;
>> >>+           } else if (smmu->num_context_banks < smmu->num_context_irqs) {
>> >>+                   /* loose extra context interrupts */
>> >>+                   dev_notice(dev,
>> >>+                         "found %d context irq(s) but only %d required\n",
>> >>+                         smmu->num_context_irqs, smmu->num_context_banks);
>> >>+                   smmu->num_context_irqs = smmu->num_context_banks;
>> >>+           }
>> >I don't see the utility in the new message. Can you simplify with the patch
>> >below on top? It's a bit weird that we only decide to ignore the extra irqs
>> >after calling platform_get_irq() on them, but that seems to be harmless.
>>
>> Thanks. I will modify as suggested below and respin.
>
> It's ok, I can make the change locally.

Thanks Will for making the changes, and picking this.

Best regards
Vivek

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
