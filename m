Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF4EEC43142
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 14:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D51C24C16
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 14:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jfJZf6Oj";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VxWN4D8m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D51C24C16
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751610AbeFWOYO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 10:24:14 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35600 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751385AbeFWOYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 10:24:12 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2790D60B13; Sat, 23 Jun 2018 14:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529763852;
        bh=8pcLhh0gZ/EF9iTOFT0ofhsQS6vyoMgNjesfde82d6w=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=jfJZf6Oj7MHNBgvKmzjlcm21JIEpPU/z0o6PtpZkqkHMngHty6nCrxmuU8S+Gku1M
         HPLL53ZOQLKkvZNFDCVXmMHa8k8htV48PPbnqz8RroQBQYpoICZdIvKwdIuyGtrkQE
         nTJqKcJvwiYPuzYyQrlITNcFH2KGR7WISG/f5WYw=
Received: from [10.79.167.205] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5B66A606FA;
        Sat, 23 Jun 2018 14:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529763851;
        bh=8pcLhh0gZ/EF9iTOFT0ofhsQS6vyoMgNjesfde82d6w=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=VxWN4D8mnSa9Slz+8+bAnwjLfh3rZQm+zf7aUxOwAoHjGh2rJIHeVvd5F36u8q/38
         Wl8YcjFPjDtY73pP+m9iLY4uti4m4GpJ9rOCMQ6K7XzeRXcXX5/YW1u5d59m2e6TEa
         vmG/8GfVjOhvzJ11yZfzah1kdkXpxLM9XX5uQAgM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5B66A606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH v2 0/2] Add display clock controller driver for SDM845
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1528885997-10311-1-git-send-email-tdas@codeaurora.org>
 <152942182329.16708.17615552184746348831@swboyd.mtv.corp.google.com>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <88b6cfa5-27fd-7fd0-e306-ae9580a39775@codeaurora.org>
Date:   Sat, 23 Jun 2018 19:54:03 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <152942182329.16708.17615552184746348831@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Stephen,

Thanks for the comments.

On 6/19/2018 8:53 PM, Stephen Boyd wrote:
> Quoting Taniya Das (2018-06-13 03:33:15)
>>   [v2]
>>    * Removed unused header file includes.
>>    * Moved the frequency table macro to a common file [1].
>>    * Move to pll config to probe.
>>    * Update SoC name in device tree binding and
>>      also update the Kconfig.
>>
>> Add support for the display clock controller found on SDM845
>> based devices. This would allow display drivers to probe and
>> control their clocks.
>>
>> The Display clock driver depends on the frequency table macro
>> movement to a common file [1].
> 
> Please send that patch along with these patches so the dependency is
> clear.
> 

Please check the latest patch series :
  https://lkml.org/lkml/2018/6/23/109

>>
>>   [1]:  https://lkml.org/lkml/2018/6/13/216
>>

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
