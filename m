Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3853AC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 17:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2BFC2085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 17:24:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GOhzERav";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kDc449KX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2BFC2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389606AbeKGCuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 21:50:15 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:48084 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389260AbeKGCuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 21:50:15 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 565BE601D7; Tue,  6 Nov 2018 17:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541525041;
        bh=x2FNUB3OdLDs5lX8AsbgykOvtDELNUM6xIPZJ9FKuTQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=GOhzERavPPDe5ZG98vlrWjFeIgM0QeAMyN6RdF1OVStAdq3gevPdsCcE1C5LAGi+L
         NZd/4JPFCP0PxGFUhHhnQGsCYLI8UbP6YSvFhCl5LxuaGYDk4mOom9Qal8egx51M21
         frpjdkpZS4uj6RrUA0kbNRMH2RPHz8JEVEAgZTxw=
Received: from [10.79.161.21] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 18B08601DA;
        Tue,  6 Nov 2018 17:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541525040;
        bh=x2FNUB3OdLDs5lX8AsbgykOvtDELNUM6xIPZJ9FKuTQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=kDc449KXBah3dI9GrJNPod3KQtZCTdKTAfrGkyGQOv7Q0wK1nf+2sCQWeH0hEGiF2
         e9STeYV5JWiHmWd7plKgAXLZ2YTBliIq7G1t/1wY6bTAVou5FQxogAhJqrLbPcoV7P
         kUlXoU9Cf74gJA+p+CtqmdbNv3oXVrZf9BldaCLw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 18B08601DA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH] arm64: dts: sdm845: Add videocc node
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org
References: <1541414117-27864-1-git-send-email-tdas@codeaurora.org>
 <154146009460.88331.6359450184767946173@swboyd.mtv.corp.google.com>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <7c1f3b1f-c60c-7bb6-f2c7-cf279c96e4b2@codeaurora.org>
Date:   Tue, 6 Nov 2018 22:53:52 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <154146009460.88331.6359450184767946173@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Stephen for adding Andy.

On 11/6/2018 4:51 AM, Stephen Boyd wrote:
> Quoting Taniya Das (2018-11-05 02:35:17)
>> This adds the video clock controller node to sdm845 based on the examples
>> in the bindings.
>>
>> Signed-off-by: Taniya Das <tdas@codeaurora.org>
>> ---
> 
> Did you mean to send "To:" Andy? Clk tree doesn't take these sorts of
> dts patches.
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
