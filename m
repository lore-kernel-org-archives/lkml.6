Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23399C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 08:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D02F920883
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 08:08:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="EYO/uxMi";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mayIpF/J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D02F920883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbeHJKhR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 06:37:17 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40214 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbeHJKhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 06:37:15 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 257CE60CA2; Fri, 10 Aug 2018 08:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533888510;
        bh=UWraBiG2/6eyurwWDYPh/iSnwcHlbiFyhdPXWi6YZWI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=EYO/uxMiS7PDG/ZkwW3SPnNmMxu9S9uJ4YiQ6TnC/gliHZGfx3HPYRjHIrGaBnEr9
         myp7TrSQ9jv/xMxOEKjbU3IzGQS313fsmOCHV9w/phi2fwewdoaRzpeEJMe4fJO3N2
         28jwii42ppZr4dlti1xA3AD49sZ386Y7+Mh2urfA=
Received: from [10.4.34.47] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9374D60B19;
        Fri, 10 Aug 2018 08:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533888507;
        bh=UWraBiG2/6eyurwWDYPh/iSnwcHlbiFyhdPXWi6YZWI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=mayIpF/J6zdj8mUFp2cgg6E+Vqft5221v4eyrFa2Mexsd/jVfQGIfELhezKPFo/tT
         LKD5ENHWkwGDA2F3oWNrCpsnJoqaGlAKaqBw+RKxvMO+MQLHhwKdmga7brxbuLoRSX
         Vt83xQlMdfMGaqC7LDxFA+hwRDFpBUUrkC6IT0jA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9374D60B19
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH v3 1/2] clk: qcom: Add qspi (Quad SPI) clock defines for
 sdm845 to header
To:     Rob Herring <robh@kernel.org>,
        Douglas Anderson <dianders@chromium.org>
Cc:     sboyd@kernel.org, andy.gross@linaro.org, girishm@codeaurora.org,
        linux-arm-msm@vger.kernel.org, anischal@codeaurora.org,
        bjorn.andersson@linaro.org, grahamr@codeaurora.org,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>
References: <20180724174513.174018-1-dianders@chromium.org>
 <20180724174513.174018-2-dianders@chromium.org>
 <20180725160102.GA18545@rob-hp-laptop>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <a081f764-ae7d-e92a-fb15-370768f4fe5c@codeaurora.org>
Date:   Fri, 10 Aug 2018 13:38:18 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180725160102.GA18545@rob-hp-laptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/25/2018 9:31 PM, Rob Herring wrote:
> On Tue, Jul 24, 2018 at 10:45:12AM -0700, Douglas Anderson wrote:
>> These clocks will need to be defined in the clock driver and
>> referenced in device tree files.
>>
>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
>> ---
>>
>> Changes in v3: None
>> Changes in v2: None
>>
>>   include/dt-bindings/clock/qcom,gcc-sdm845.h | 3 +++
>>   1 file changed, 3 insertions(+)
> 
> Acked-by: Rob Herring <robh@kernel.org>
   Reviewed-by: Taniya Das <tdas@codeaurora.org>

> --
> To unsubscribe from this list: send the line "unsubscribe linux-clk" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
