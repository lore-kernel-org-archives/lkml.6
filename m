Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 194F5C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 09:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2F772083A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 09:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="h38SK7jn";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SzS57QtD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2F772083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbeHaN6o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 09:58:44 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45222 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726493AbeHaN6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 09:58:39 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5270E606DD; Fri, 31 Aug 2018 09:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535709117;
        bh=N94aYgFn1nbWOGffm7md4/2cublFKiqxroH+kfXPorg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=h38SK7jnM9LcOGvqf5g9VnLt/jQU990wOIzJEeJIDu7AtSN5gzIuXvo15YvaPQki9
         WfIwZDjIUCz+6ky1cbUk8ypi4nY+dHCCBSEOK8mo3klAPslDYSK/nlgUqVVYUg0IJx
         rvTtL2GCpEwIlwhUs+mBr7XIExBh6voygGAd/grY=
Received: from [10.79.40.134] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9CE7C6038E;
        Fri, 31 Aug 2018 09:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535709115;
        bh=N94aYgFn1nbWOGffm7md4/2cublFKiqxroH+kfXPorg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=SzS57QtDh4DDjqSUJ7wBhDQlgXT+Tfdku0AalTgcX0WNrmkDLL31bFtjkEIZ7+VXu
         5olKA4al9s8gvi9jK361VQye9UjmoHWSJrbCP+ju1UWoOXehicINOxwaFrCPQ52zgY
         eqgb3EQCc36XQhYbrtqNI7XpXVU6fZo3V2cqlIj0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9CE7C6038E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Subject: Re: [Patch v15 4/5] dt-bindings: arm-smmu: Add bindings for
 qcom,smmu-v2
To:     Rob Herring <robh@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        alex.williamson@redhat.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>
References: <20180827105551.16346-1-vivek.gautam@codeaurora.org>
 <20180827105551.16346-5-vivek.gautam@codeaurora.org>
 <20180828203418.GA18366@bogus>
 <a1e31d1e-aaa4-5951-2261-3169033c636a@codeaurora.org>
 <CAFp+6iGHus-kZv+Zr5aiYRLct07NCFBL3k44bX=c4eW7J24kZg@mail.gmail.com>
 <CAL_JsqKGHC9wCy583CTvAz8-A_M6zyrAX69yN5RUjv7Kbs1wFQ@mail.gmail.com>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Message-ID: <e5c72d2d-a1a1-40dd-103b-da7147b4e7ae@codeaurora.org>
Date:   Fri, 31 Aug 2018 15:21:49 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKGHC9wCy583CTvAz8-A_M6zyrAX69yN5RUjv7Kbs1wFQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,


On 8/30/2018 6:13 AM, Rob Herring wrote:
> On Wed, Aug 29, 2018 at 6:23 AM Vivek Gautam
> <vivek.gautam@codeaurora.org> wrote:
>> On Wed, Aug 29, 2018 at 2:05 PM Vivek Gautam
>> <vivek.gautam@codeaurora.org> wrote:
>>> Hi Rob,
>>>
>>>
>>> On 8/29/2018 2:04 AM, Rob Herring wrote:
>>>> On Mon, Aug 27, 2018 at 04:25:50PM +0530, Vivek Gautam wrote:
>>>>> Add bindings doc for Qcom's smmu-v2 implementation.
>>>>>
>>>>> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
>>>>> Reviewed-by: Tomasz Figa <tfiga@chromium.org>
>>>>> Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>>>> ---
>>>>>
>>>>> Changes since v14:
>>>>>    - This is a new patch added in v15 after noticing the new
>>>>>      checkpatch warning for separate dt-bindings doc.
>>>>>    - This patch also addresses comments given by Rob and Robin to add
>>>>>      a list of valid values of '<soc>' in "qcom,<soc>-smmu-v2"
>>>>>      compatible string.
>>>>>
>>>>>    .../devicetree/bindings/iommu/arm,smmu.txt         | 47 ++++++++++++++++++++++
>>>>>    1 file changed, 47 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
>>>>> index 8a6ffce12af5..52198a539606 100644
>>>>> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
>>>>> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
>>>>> @@ -17,10 +17,24 @@ conditions.
>>>>>                            "arm,mmu-401"
>>>>>                            "arm,mmu-500"
>>>>>                            "cavium,smmu-v2"
>>>>> +                        "qcom,<soc>-smmu-v2", "qcom,smmu-v2"
>>>> The v2 in the compatible string is kind of redundant unless the SoC has
>>>> other SMMU types.
>>> sdm845 has smmu-v2, and smmu-500 [1].
>>>
>>>>>                      depending on the particular implementation and/or the
>>>>>                      version of the architecture implemented.
>>>>>
>>>>> +                  A number of Qcom SoCs use qcom,smmu-v2 version of the IP.
>>>>> +                  "qcom,<soc>-smmu-v2" represents a soc specific compatible
>>>>> +                  string that should be present along with the "qcom,smmu-v2"
>>>>> +                  to facilitate SoC specific clocks/power connections and to
>>>>> +                  address specific bug fixes.
>>>>> +                  '<soc>' string in "qcom,<soc>-smmu-v2" should be one of the
>>>>> +                  following:
>>>>> +                  msm8996 - for msm8996 Qcom SoC.
>>>>> +                  sdm845 - for sdm845 Qcom Soc.
>>>> Rather than all this prose, it would be simpler to just add 2 lines with
>>>> the full compatibles rather than <soc>. The <soc> thing is not going to
>>>> work when/if we move bindings to json-schema also.
>>> then we keep adding
>>>            "qcom,msm8996-smmu-v2", "qcom,smmu-v2"
>>>            "qcom,msm8998-smmu-v2", "qcom,smmu-v2"
>>>            "qcom,sdm845-smmu-v2", "qcom,smmu-v2",
>>> and from [1]
>>>            "qcom,sdm845-smmu-500", "arm,mmu-500", etc.
>>> for each SoCs?
>> How about following diff on top of this patch?
>>
>> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
>> b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
>> index 52198a539606..5e6c04876533 100644
>> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
>> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
>> @@ -17,23 +17,18 @@ conditions.
>>                           "arm,mmu-401"
>>                           "arm,mmu-500"
>>                           "cavium,smmu-v2"
>> -                        "qcom,<soc>-smmu-v2", "qcom,smmu-v2"
>> +                        "qcom,smmu-v2"
>>
>>                     depending on the particular implementation and/or the
>>                     version of the architecture implemented.
>>
>> -                  A number of Qcom SoCs use qcom,smmu-v2 version of the IP.
>> -                  "qcom,<soc>-smmu-v2" represents a soc specific compatible
>> -                  string that should be present along with the "qcom,smmu-v2"
>> -                  to facilitate SoC specific clocks/power connections and to
>> -                  address specific bug fixes.
>> -                  '<soc>' string in "qcom,<soc>-smmu-v2" should be one of the
>> -                  following:
>> -                  msm8996 - for msm8996 Qcom SoC.
>> -                  sdm845 - for sdm845 Qcom Soc.
>> -
>> -                  An example string would be -
>> -                  "qcom,msm8996-smmu-v2", "qcom,smmu-v2".
>> +                  Qcom SoCs using qcom,smmu-v2 must have soc specific
>> +                  compatible string attached to "qcom,smmu-v2" to take care
>> +                  of SoC specific clocks/power connections and to address
>> +                  specific bug fixes.
>> +                  Precisely, it should be one of the following:
>> +                  "qcom,msm8996-smmu-v2", "qcom,smmu-v2",
>> +                  "qcom,sdm845-smmu-v2", "qcom,smmu-v2".
> We don't need an explanation of why we need specific compatibles in
> each binding document (though maybe we need a better explanation
> somewhere). We just need to know what are valid values for compatibles
> and this includes any combinations. Generally, this is just a list of
> combinations.
[snip]

Fixed this in v16. Thanks.

Best regards
Vivek
