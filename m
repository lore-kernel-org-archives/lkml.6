Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EFE2C46465
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 06:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 179712081D
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 06:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NTan8Eet";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NztbZo/R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 179712081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbeKHQRy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 11:17:54 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:37712 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725724AbeKHQRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 11:17:51 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 590A360AD8; Thu,  8 Nov 2018 06:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541659432;
        bh=3inbthz8hOoH85wJGGAIHX3K/WUArUfXN+jv7SNV4QY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=NTan8Eetx82HCACzXsvrIpo5AQwvWxsXSnt1yxbZXzpiL43MayvkhZpOhfU1b2O7O
         NAiUmnbSwGfv+cUJW/BR1vCkZV9tG+Yp96ieNGcoKyVwgsyIZ4Ry+C6Dmmg3oRW/ys
         Bb9t9vzKn03oNbqrNfeK1YJIBa7eHAtuQgi1EjZc=
Received: from [10.79.174.12] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B23A360131;
        Thu,  8 Nov 2018 06:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541659431;
        bh=3inbthz8hOoH85wJGGAIHX3K/WUArUfXN+jv7SNV4QY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=NztbZo/RhxeDVfDYGeXhqnLIC2qsWxrReSPH3ajGDFQoepB0rq+DCHdZvuEbPxsjU
         KV8YvB1vNGY+sAGKVA2ugk48OsM9o1EHcG56//8mYGe1vkqDEufpLgOgJfMG/10pUH
         7cKe2jOt4YT0EwPzCwsjNMoSEZ3nDZaChqfIHVEc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B23A360131
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH v8] clk: qcom: Add lpass clock controller driver for
 SDM845
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
References: <1540712140-26913-1-git-send-email-tdas@codeaurora.org>
 <1540712140-26913-2-git-send-email-tdas@codeaurora.org>
 <154117671164.88331.752297297364277275@swboyd.mtv.corp.google.com>
 <8d495713-d601-dcc8-23ee-dc31185e6a7c@codeaurora.org>
 <154152457264.88331.5152287370260040686@swboyd.mtv.corp.google.com>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <32c2e69a-2070-5b6d-257a-627e2ad063e3@codeaurora.org>
Date:   Thu, 8 Nov 2018 12:13:43 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <154152457264.88331.5152287370260040686@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Stephen.

On 11/6/2018 10:46 PM, Stephen Boyd wrote:
> Quoting Taniya Das (2018-11-02 20:16:20)
>> On 11/2/2018 10:08 PM, Stephen Boyd wrote:
>>> Quoting Taniya Das (2018-10-28 00:35:40)
>>>
>>
>> How about moving the QSPI clocks too under this qcom property? Later
>> could add the support?
> 
> Yes the plan would be to have QSPI clks there too. Bjorn has sent the
> patch now.
> 
>   https://lkml.kernel.org/r/20181106055013.11271-1-bjorn.andersson@linaro.org
> 
Would you be merging the code soon and then I should submit the cleaned 
up LPASS next series?

Please suggest.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
