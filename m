Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 235F2C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 11:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3CFB2175D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 11:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="O3X8BkQF";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="O3X8BkQF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3CFB2175D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbeHCNTL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 09:19:11 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37698 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726933AbeHCNTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 09:19:11 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A35936071C; Fri,  3 Aug 2018 11:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533295397;
        bh=HLYIHU7VmyOv/UZOVqD7EpX0HcCI8U8Myv4CgNdgwlE=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=O3X8BkQF2q/VmnapuInlDlfb5Nby8V8J+8u1RezOMGMGz94ZBfwhpTZxHukI6867x
         /Xl6jussxpaUqLtVYz0eU8Ykv5Yc9FImWUBN2zsemfwctNhxOwZF2UyfU0fHx/wkFZ
         jeUySZlypIRMoi3mfNPXylU0a4WxVAiR4WvOWkjw=
Received: from [10.204.110.203] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rohitkr@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3FDDA60264;
        Fri,  3 Aug 2018 11:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533295397;
        bh=HLYIHU7VmyOv/UZOVqD7EpX0HcCI8U8Myv4CgNdgwlE=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=O3X8BkQF2q/VmnapuInlDlfb5Nby8V8J+8u1RezOMGMGz94ZBfwhpTZxHukI6867x
         /Xl6jussxpaUqLtVYz0eU8Ykv5Yc9FImWUBN2zsemfwctNhxOwZF2UyfU0fHx/wkFZ
         jeUySZlypIRMoi3mfNPXylU0a4WxVAiR4WvOWkjw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3FDDA60264
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rohitkr@codeaurora.org
Subject: Re: [PATCH v2] remoteproc: qcom: Introduce Non-PAS ADSP PIL driver
From:   Rohit Kumar <rohitkr@codeaurora.org>
To:     Rob Herring <robh@kernel.org>
Cc:     ohad@wizery.com, bjorn.andersson@linaro.org, mark.rutland@arm.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bgoswami@codeaurora.org,
        sbpata@codeaurora.org
References: <1530264053-8394-1-git-send-email-rohitkr@codeaurora.org>
 <20180706203236.GA24729@rob-hp-laptop>
 <43dcb60b-720f-27ab-3696-dbf0fe0b65fc@codeaurora.org>
Message-ID: <be77dbce-49aa-862f-0192-f0264b5aa588@codeaurora.org>
Date:   Fri, 3 Aug 2018 16:53:05 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <43dcb60b-720f-27ab-3696-dbf0fe0b65fc@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Bjorn,


Can you please let us know the suggest the file name and review the patch.


On 7/9/2018 11:29 AM, Rohit Kumar wrote:
> Thanks Rob for reviewing.
>
>
> On 7/7/2018 2:02 AM, Rob Herring wrote:
>> On Fri, Jun 29, 2018 at 02:50:53PM +0530, Rohit kumar wrote:
>>> This adds APSS based ADSP PIL driver for QCOM SoCs.
>>> Added initial support for SDM845 with ADSP bootup and
>>> shutdown operation handled from Application Processor
>>> SubSystem(APSS).
>>>
>>> Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
>>> ---
>>> Changes since v1:
>>> - Used APIs from qcom_q6v5.c
>>> - Use clock, reset and regmap driver APIs instead of
>>>    directly writing into the LPASS registers.
>>> - Created new file for non PAS ADSP PIL instead of extending
>>>    existing ADSP PIL driver.
>>> - cleanups as suggested by Bjorn and Rob.
>>>
>>>   .../bindings/remoteproc/qcom,non-pas-adsp.txt      | 138 +++++
>> This should be a separate patch.
>
> Ok. Will separate it in next spin.
>>> drivers/remoteproc/Kconfig                         |  18 +
>>>   drivers/remoteproc/Makefile                        |   1 +
>>>   drivers/remoteproc/qcom_nonpas_adsp_pil.c          | 667 
>>> +++++++++++++++++++++
>>>   4 files changed, 824 insertions(+)
>>>   create mode 100644 
>>> Documentation/devicetree/bindings/remoteproc/qcom,non-pas-adsp.txt
>>>   create mode 100644 drivers/remoteproc/qcom_nonpas_adsp_pil.c
>>>
>>> diff --git 
>>> a/Documentation/devicetree/bindings/remoteproc/qcom,non-pas-adsp.txt 
>>> b/Documentation/devicetree/bindings/remoteproc/qcom,non-pas-adsp.txt
>>> new file mode 100644
>>> index 0000000..0581aaa
>>> --- /dev/null
>>> +++ 
>>> b/Documentation/devicetree/bindings/remoteproc/qcom,non-pas-adsp.txt
>>> @@ -0,0 +1,138 @@
>>> +Qualcomm Technology Inc. Non PAS ADSP Peripheral Image Loader
>>> +
>>> +This document defines the binding for a component that loads and 
>>> boots firmware
>>> +on the Qualcomm Technology Inc. ADSP Hexagon core.
>>> +
>>> +- compatible:
>>> +    Usage: required
>>> +    Value type: <string>
>>> +    Definition: must be one of:
>>> +            "qcom,sdm845-apss-adsp-pil"
>> Didn't Bjorn say to drop the 'apss' part?
>
> Yes, he had asked to rename compatible string for  existing PIL driver 
> as "qcom,platform-subsystem-pas"
> and non-pas pil driver as "qcom,platform-subsystem-pil". I wanted to 
> get confirmation from Bjorn whether
> we should rename the filename too.
> @Bjorn, can you please suggest filename and compatible strings for the 
> two drivers.
>>> +
>>> +- reg:
>>> +    Usage: required
>>> +    Value type: <prop-encoded-array>
>>> +    Definition: must specify the base address and size of the qdsp6ss
>>> +
>>> +- reg-names:
>>> +    Usage: required
>>> +    Value type: <stringlist>
>>> +    Definition: must be "qdsp6ss"
>>> +
>>>
>> -- 
>> To unsubscribe from this list: send the line "unsubscribe 
>> linux-remoteproc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>
> Thanks,
> Rohit
>

