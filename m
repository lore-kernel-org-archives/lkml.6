Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8575FC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4927120834
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:17:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MTCsC24s";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Eoth7C+E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4927120834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbeLAF1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 00:27:54 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:35808 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbeLAF1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 00:27:53 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id EF95260BE8; Fri, 30 Nov 2018 18:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543601866;
        bh=CB/MbCwOy0SasSzHqLli3TQdsb100tpLqBqRcoSFjmk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=MTCsC24sfmoQIShzo4WwNu6YIN3MRySRD3NNpoFJ8BjkrF8ZAqrANlh0amaqcf+Fz
         c78dHj4odTvv7IQpls71XcBlwBavLZlLUDPSRiFJ78YBikITDCKn1ZCkZw99rL2nGs
         HVkbMRUMgSyMe0LiIhFdsx1QJqvdhiqxxeohniFo=
Received: from [192.168.225.247] (unknown [49.33.181.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 35F4A60B19;
        Fri, 30 Nov 2018 18:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543601864;
        bh=CB/MbCwOy0SasSzHqLli3TQdsb100tpLqBqRcoSFjmk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Eoth7C+EDgfRjvmJ4wrAxLEz1F2A24q64VYdaybOm0ZONKdIXKJEe1ODH5DE2q+YK
         TXLQxjdJUhM8HuStRthlB7Gu6UyfjIbxJrdqt5OdJ1KuL0edxGAT8GTkcrtoR+KrWx
         wDK0a9+87s6eeJRcjbmLxxuqb34m/KMFrvTeFJmg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 35F4A60B19
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH v10 3/3] clk: qcom: Add lpass clock controller driver for
 SDM845
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org
References: <1542873221-13693-1-git-send-email-tdas@codeaurora.org>
 <1542873221-13693-4-git-send-email-tdas@codeaurora.org>
 <154331006901.88331.9760589510991406736@swboyd.mtv.corp.google.com>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <0691834a-e2bf-20bb-fa5c-081ee6668250@codeaurora.org>
Date:   Fri, 30 Nov 2018 23:47:17 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <154331006901.88331.9760589510991406736@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Stephen,

On 11/27/2018 2:44 PM, Stephen Boyd wrote:
> Quoting Taniya Das (2018-11-21 23:53:41)
>> +
>> +static struct clk_branch lpass_qdsp6ss_core_clk = {
>> +       .halt_reg = 0x20,
>> +       /* CLK_OFF would not toggle until LPASS is not out of reset */
> 
> Is this really "CLK_OFF won't toggle until LPASS it out of reset"?
> 

Would take care of it, in the next series.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
