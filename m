Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48FD2C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 06:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A7FC2086A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 06:07:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="D9eoaiBt";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="D9eoaiBt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A7FC2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbeJLNic (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 09:38:32 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41354 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727056AbeJLNib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 09:38:31 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id DD06B60C6A; Fri, 12 Oct 2018 06:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539324460;
        bh=3b0meCj3XlYBkhWX0XtIsEzInhfOA2xbV21WuZRKqSc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=D9eoaiBtt0dJPZEqK582xIERgI9daVzlnEBYpUf1CtfPaIvDMvkqwpQO1qzU6flAv
         /ugmSVSc4XIIAV8TIZmi3i27zT9GKgjeTu8GewPB5G6448FnvMxrUbzArpSBaZ6/+9
         4OPGeJsNDf9iK9hSHCId6HvgrBS3oTHZUfFox4Bc=
Received: from [10.79.40.129] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 653CE6072E;
        Fri, 12 Oct 2018 06:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539324460;
        bh=3b0meCj3XlYBkhWX0XtIsEzInhfOA2xbV21WuZRKqSc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=D9eoaiBtt0dJPZEqK582xIERgI9daVzlnEBYpUf1CtfPaIvDMvkqwpQO1qzU6flAv
         /ugmSVSc4XIIAV8TIZmi3i27zT9GKgjeTu8GewPB5G6448FnvMxrUbzArpSBaZ6/+9
         4OPGeJsNDf9iK9hSHCId6HvgrBS3oTHZUfFox4Bc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 653CE6072E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Subject: Re: [PATCH v4 1/2] dt-bindings: arm-smmu: Add binding doc for Qcom
 smmu-500
To:     Rob Herring <robh@kernel.org>
Cc:     joro@8bytes.org, robh+dt@kernel.org, andy.gross@linaro.org,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, mark.rutland@arm.com,
        david.brown@linaro.org, linux-kernel@vger.kernel.org,
        robin.murphy@arm.com, will.deacon@arm.com, dianders@chromium.org
References: <20181011094930.17010-1-vivek.gautam@codeaurora.org>
 <20181011094930.17010-2-vivek.gautam@codeaurora.org>
 <20181011221630.GA5841@bogus>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Message-ID: <9ca4bb4f-3e6e-21cc-819e-80b979b934d0@codeaurora.org>
Date:   Fri, 12 Oct 2018 11:37:33 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181011221630.GA5841@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/12/2018 3:46 AM, Rob Herring wrote:
> On Thu, 11 Oct 2018 15:19:29 +0530, Vivek Gautam wrote:
>> Qcom's implementation of arm,mmu-500 works well with current
>> arm-smmu driver implementation. Adding a soc specific compatible
>> along with arm,mmu-500 makes the bindings future safe.
>>
>> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
>> ---
>>
>> Changes since v3:
>>   - Refined language more to state things directly for the bindings
>>     description.
>>
>>   Documentation/devicetree/bindings/iommu/arm,smmu.txt | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
> Reviewed-by: Rob Herring <robh@kernel.org>

Thank you Rob.

Best regards
Vivek
