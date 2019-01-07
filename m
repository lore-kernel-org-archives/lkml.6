Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE9FFC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D6992070B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:39:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hvtuNZOR";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZUnRJNS5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbfAGSjR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 13:39:17 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:47896 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbfAGSjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 13:39:17 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 773BE60593; Mon,  7 Jan 2019 18:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546886355;
        bh=gm5wkfqtQwaBMjQQUqKqTN4PUt+rit6xLabKa+KWRPE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=hvtuNZOR1XzCLSrw8upzt0w65ShQoOC2iV2orxJIGKV2iLdX0M8GUdDkBlUXi4i4c
         136FoeHim+znYxUGMfHQ8Eh7rDQWdnSxIZL3bUUPSMRqJwMibmj1JOVt7ANtcjH8jv
         3uZXAdmRv4frhjtDOIw5aygrOE2ruOgNx/hNkLhw=
Received: from [10.226.60.81] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 69D4A60303;
        Mon,  7 Jan 2019 18:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546886354;
        bh=gm5wkfqtQwaBMjQQUqKqTN4PUt+rit6xLabKa+KWRPE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ZUnRJNS5ucGCakvGScDdpD2aJ56ZLLWv0N6lPJGyUNVoicDSyOQo3bZpZ5RUeEQ5Z
         bjS78q+NcepRBgTrwfCG88k9x13V1/DNZ74urhERcPSGihYCUp2PVeiysC1P0XYIhn
         kxW89gg/rfLU2gJSZZBBaV5dShoakY2vQhKBW6LU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 69D4A60303
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [PATCH v1 3/6] phy: qcom-qusb2: Add QUSB2 PHY support for msm8998
To:     Jack Pham <jackp@codeaurora.org>
Cc:     kishon@ti.com, robh+dt@kernel.org, bjorn.andersson@linaro.org,
        andy.gross@linaro.org, david.brown@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
        balbi@kernel.org, linux-usb@vger.kernel.org
References: <1546620629-2426-1-git-send-email-jhugo@codeaurora.org>
 <20190107181749.GA23243@jackp-linux.qualcomm.com>
From:   Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <c01ae71b-1d4e-b336-9cab-9aa6c70e2e8c@codeaurora.org>
Date:   Mon, 7 Jan 2019 11:39:13 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190107181749.GA23243@jackp-linux.qualcomm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/7/2019 11:18 AM, Jack Pham wrote:
> Hi Jeff,
> 
> Spotted a typo below:
> 
> On Fri, Jan 04, 2019 at 09:50:29AM -0700, Jeffrey Hugo wrote:
>> MSM8998 contains one QUSB2 PHY which is very similar to the existing
>> sdm845 support.
>>
>> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
>> ---
>>   .../devicetree/bindings/phy/qcom-qusb2-phy.txt     |  1 +
>>   drivers/phy/qualcomm/phy-qcom-qusb2.c              | 41 ++++++++++++++++++++++
>>   2 files changed, 42 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/phy/qcom-qusb2-phy.txt b/Documentation/devicetree/bindings/phy/qcom-qusb2-phy.txt
>> index 03025d9..3976847 100644
>> --- a/Documentation/devicetree/bindings/phy/qcom-qusb2-phy.txt
>> +++ b/Documentation/devicetree/bindings/phy/qcom-qusb2-phy.txt
>> @@ -6,6 +6,7 @@ QUSB2 controller supports LS/FS/HS usb connectivity on Qualcomm chipsets.
>>   Required properties:
>>    - compatible: compatible list, contains
>>   	       "qcom,msm8996-qusb2-phy" for 14nm PHY on msm8996,
>> +	       "qcom,msm8998-qusb2-phy" for 10nm PHY on msm8996,
>                                                             ^^^^
> should be 8998.

Yes it should.  Thanks for noticing.


-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
