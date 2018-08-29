Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D318C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CC1120897
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:35:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NfDnJOV9";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LS0v1ViO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CC1120897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbeH2MbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 08:31:09 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49906 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727204AbeH2MbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 08:31:09 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E7AD16071B; Wed, 29 Aug 2018 08:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535531720;
        bh=j/qj48xNDElECOmB2vLrd8W3kcs7j2hjUJwKOwYJ/oI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=NfDnJOV9WkVALwVEsb/el2vshPJoAYLZKPvgEbAKYPWPgaDVYaxma1v7AhmhH50ZB
         +07pejUSopkY7EqkksehOfuNLSSAjXQe6ShcV58aaDjJq2wUM31NiHcQR21zFHjcpl
         VES+Be6ckblIOmY7EZotCXKLWsMMvjn2iox6V0wY=
Received: from [10.79.40.134] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 09B75607B5;
        Wed, 29 Aug 2018 08:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535531719;
        bh=j/qj48xNDElECOmB2vLrd8W3kcs7j2hjUJwKOwYJ/oI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=LS0v1ViOxnFBRhHu/ijgYBR+Nk4okTiiAfJFcp19vNVf0e16nFHz+42P9HiuprHLb
         zgKGSNqPSQw3V+HPx5oyKH/MHFQDNJ3TuNOh/nthBOFim82L6hoFhombUdxBnTPJvE
         OG1+1y3niNarp34dYzwxmrUSqvCoN2NsPhzKXoEw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 09B75607B5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Subject: Re: [Patch v15 4/5] dt-bindings: arm-smmu: Add bindings for
 qcom,smmu-v2
To:     Rob Herring <robh@kernel.org>
Cc:     joro@8bytes.org, robin.murphy@arm.com, will.deacon@arm.com,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, freedreno@lists.freedesktop.org,
        alex.williamson@redhat.com, mark.rutland@arm.com,
        rjw@rjwysocki.net, robdclark@gmail.com, andy.gross@linaro.org,
        linux-pm@vger.kernel.org, sboyd@kernel.org, tfiga@chromium.org,
        jcrouse@codeaurora.org, sricharan@codeaurora.org,
        m.szyprowski@samsung.com, architt@codeaurora.org,
        linux-arm-msm@vger.kernel.org
References: <20180827105551.16346-1-vivek.gautam@codeaurora.org>
 <20180827105551.16346-5-vivek.gautam@codeaurora.org>
 <20180828203418.GA18366@bogus>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Message-ID: <a1e31d1e-aaa4-5951-2261-3169033c636a@codeaurora.org>
Date:   Wed, 29 Aug 2018 14:05:10 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180828203418.GA18366@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,


On 8/29/2018 2:04 AM, Rob Herring wrote:
> On Mon, Aug 27, 2018 at 04:25:50PM +0530, Vivek Gautam wrote:
>> Add bindings doc for Qcom's smmu-v2 implementation.
>>
>> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
>> Reviewed-by: Tomasz Figa <tfiga@chromium.org>
>> Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>
>> Changes since v14:
>>   - This is a new patch added in v15 after noticing the new
>>     checkpatch warning for separate dt-bindings doc.
>>   - This patch also addresses comments given by Rob and Robin to add
>>     a list of valid values of '<soc>' in "qcom,<soc>-smmu-v2"
>>     compatible string.
>>
>>   .../devicetree/bindings/iommu/arm,smmu.txt         | 47 ++++++++++++++++++++++
>>   1 file changed, 47 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
>> index 8a6ffce12af5..52198a539606 100644
>> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
>> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
>> @@ -17,10 +17,24 @@ conditions.
>>                           "arm,mmu-401"
>>                           "arm,mmu-500"
>>                           "cavium,smmu-v2"
>> +                        "qcom,<soc>-smmu-v2", "qcom,smmu-v2"
> The v2 in the compatible string is kind of redundant unless the SoC has
> other SMMU types.

sdm845 has smmu-v2, and smmu-500 [1].

>>   
>>                     depending on the particular implementation and/or the
>>                     version of the architecture implemented.
>>   
>> +                  A number of Qcom SoCs use qcom,smmu-v2 version of the IP.
>> +                  "qcom,<soc>-smmu-v2" represents a soc specific compatible
>> +                  string that should be present along with the "qcom,smmu-v2"
>> +                  to facilitate SoC specific clocks/power connections and to
>> +                  address specific bug fixes.
>> +                  '<soc>' string in "qcom,<soc>-smmu-v2" should be one of the
>> +                  following:
>> +                  msm8996 - for msm8996 Qcom SoC.
>> +                  sdm845 - for sdm845 Qcom Soc.
> Rather than all this prose, it would be simpler to just add 2 lines with
> the full compatibles rather than <soc>. The <soc> thing is not going to
> work when/if we move bindings to json-schema also.

then we keep adding
          "qcom,msm8996-smmu-v2", "qcom,smmu-v2"
          "qcom,msm8998-smmu-v2", "qcom,smmu-v2"
          "qcom,sdm845-smmu-v2", "qcom,smmu-v2",
and from [1]
          "qcom,sdm845-smmu-500", "arm,mmu-500", etc.
for each SoCs?

>
>> +
>> +                  An example string would be -
>> +                  "qcom,msm8996-smmu-v2", "qcom,smmu-v2".
>> +
>>   - reg           : Base address and size of the SMMU.
>>   
>>   - #global-interrupts : The number of global interrupts exposed by the
>> @@ -71,6 +85,22 @@ conditions.
>>                     or using stream matching with #iommu-cells = <2>, and
>>                     may be ignored if present in such cases.
>>   
>> +- clock-names:    List of the names of clocks input to the device. The
>> +                  required list depends on particular implementation and
>> +                  is as follows:
>> +                  - for "qcom,smmu-v2":
>> +                    - "bus": clock required for downstream bus access and
>> +                             for the smmu ptw,
>> +                    - "iface": clock required to access smmu's registers
>> +                               through the TCU's programming interface.
>> +                  - unspecified for other implementations.
>> +
>> +- clocks:         Specifiers for all clocks listed in the clock-names property,
>> +                  as per generic clock bindings.
>> +
>> +- power-domains:  Specifiers for power domains required to be powered on for
>> +                  the SMMU to operate, as per generic power domain bindings.
>> +
>>   ** Deprecated properties:
>>   
>>   - mmu-masters (deprecated in favour of the generic "iommus" binding) :
>> @@ -137,3 +167,20 @@ conditions.
>>                   iommu-map = <0 &smmu3 0 0x400>;
>>                   ...
>>           };
>> +
>> +	/* Qcom's arm,smmu-v2 implementation */
>> +	smmu4: iommu {
> Needs a unit-address.

I went in symmetry with another example in this file for 'smmu1'. I will 
add the address here.
And if you would like, I can squash a change for 'smmu1' too in this 
patch, although that will be trivial.

[1] https://patchwork.kernel.org/patch/10565291/

Best regards
Vivek

[snip]
