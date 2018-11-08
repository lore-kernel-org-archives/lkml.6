Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78741ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40F3F20827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:13:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="J/5FZhLk";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="a5wy+erY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40F3F20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbeKHXst (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 18:48:49 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:40742 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbeKHXss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 18:48:48 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id CB64F6085F; Thu,  8 Nov 2018 14:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541686387;
        bh=KJrobRvNC0ilusqCcNR86cuKng5zWP5P2zl58uHUXEQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=J/5FZhLkXjiRFxuJcgwuP3aMwGYJfnva164t8UJX5kCPGV6cd9/5IP7MmnJ1TNavw
         YymJuvCapjt/y1239E+BuhAkE/2qM0nFFsDG4XTcSMdTkNmUXdSoYCsMOQlTMcKue8
         BBpSgk38SFARWYTpbW+00+sGeYqMmHzm90FT/JJU=
Received: from [10.206.25.187] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vbadigan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9B17C60240;
        Thu,  8 Nov 2018 14:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541686386;
        bh=KJrobRvNC0ilusqCcNR86cuKng5zWP5P2zl58uHUXEQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=a5wy+erYdbQf19Q12ag9tpZM4LtKCQMRu7q30qUnv5WkV6W8vqqWqzURWMBxVh8A0
         sSHMSq7nShNFSFeGoD1NMJtN1Sqeak1O10eBR1gn7auuB2UeRDjjxg+EtaO1WkzXCb
         XiH4654qN4tu2vistrEb4rUV7QDUKiNipBmcDg4U=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9B17C60240
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vbadigan@codeaurora.org
Subject: Re: [PATCH V3 2/3] dt-bindings: mmc: sdhci-msm: Add entries for
 passing load values
To:     Rob Herring <robh@kernel.org>
Cc:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        evgreen@chromium.org, dianders@google.com, asutoshd@codeaurora.org,
        riteshh@codeaurora.org, stummala@codeaurora.org,
        sayalil@codeaurora.org, linux-mmc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Vijay Viswanath <vviswana@codeaurora.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1539004739-32060-1-git-send-email-vbadigan@codeaurora.org>
 <1539004739-32060-3-git-send-email-vbadigan@codeaurora.org>
 <20181012145516.GA10205@bogus>
From:   Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Message-ID: <a0781e8c-2448-eecf-2736-150fa5ea8d4f@codeaurora.org>
Date:   Thu, 8 Nov 2018 19:43:00 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181012145516.GA10205@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/12/2018 8:25 PM, Rob Herring wrote:
> On Mon, Oct 08, 2018 at 06:48:58PM +0530, Veerabhadrarao Badiganti wrote:
>> From: Vijay Viswanath <vviswana@codeaurora.org>
>>
>> The load a particular sdhc controller should request from a regulator
>> is device specific and hence each device should individually vote for
>> the required load.
>>
>> Signed-off-by: Vijay Viswanath <vviswana@codeaurora.org>
>> Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
>> ---
>>   Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
>> index 502b3b8..cb22178 100644
>> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
>> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
>> @@ -25,6 +25,10 @@ Required properties:
>>   	"xo"	- TCXO clock (optional)
>>   	"cal"	- reference clock for RCLK delay calibration (optional)
>>   	"sleep"	- sleep clock for RCLK delay calibration (optional)
>> +- qcom,<supply>-current-level-microamp - specifies load levels for supply during BUS_ON and
>> +					BUS_OFF states in power irq. Should be specified in
>> +					pairs (lpm, hpm), for BUS_OFF and BUS_ON respectively.
>> +					Units uA.
> Seems like something that should be common?

Hi Rob,
Can you please little elaborate your comment?
Do mean this should be common for all vendors, not specific to qcom-mmc?


Thanks,
Veera
