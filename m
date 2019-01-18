Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF868C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 02:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DF0420873
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 02:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="BR/2GLE5";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Nb1SWz9z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbfARC6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 21:58:51 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:60818 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfARC6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 21:58:51 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 914726085C; Fri, 18 Jan 2019 02:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547780330;
        bh=CSkykrvA55vjxsZCmu5sLXiMDCi4xY1mk5bDpqWwcMI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=BR/2GLE5kjnm9wr8N9v9a2R+30dlysrr+Xs6LPPi24wlCiaNe3eGVaZkZea620yGX
         cXY4rQmtxBpoO8J0nSRl5E4cglth7YtFl0A6z5eLuV3ZsrpgSXaq3xMTTpS3hb2e4k
         SXdh4feyACzVUZ5I8YUr/o0nEgOo71oDRx4azVKU=
Received: from [10.79.129.0] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7A76D605A0;
        Fri, 18 Jan 2019 02:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547780329;
        bh=CSkykrvA55vjxsZCmu5sLXiMDCi4xY1mk5bDpqWwcMI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Nb1SWz9zMPeWfrb/1qfQjUr/E1V/IifhFw6rMJ8IKG7uO9ydvLXqNTxuilcoodgYS
         rKnzUyHCnoHKzlzRwkAhkJRvLXxX781zv76uMA88P8KAg1RSXEGeb0H/fBW7C+BQla
         bmhW+R/NePvXnxrTXM+CiTyZuOs8s9Sh2yIthAKw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7A76D605A0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCHv2] watchdog: qcom: Add suspend/resume support
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org,
        Guenter Roeck <groeck@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20190117151942.6092-1-saiprakash.ranjan@codeaurora.org>
 <20190117181603.GA14800@roeck-us.net>
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <bae21498-32be-6842-adce-1fc5b9c7e263@codeaurora.org>
Date:   Fri, 18 Jan 2019 08:28:44 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190117181603.GA14800@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/2019 11:46 PM, Guenter Roeck wrote:
> On Thu, Jan 17, 2019 at 08:49:42PM +0530, Sai Prakash Ranjan wrote:
>> This adds the support for qcom watchdog suspend and resume
>> when entering and exiting deep sleep states. Otherwise
>> having watchdog active after suspend would result in unwanted
>> crashes/resets if resume happens after a long time.
>>
>> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> 
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> 

Thanks Guenter. Should I send a v3 with your reviewed-by?

- Sai
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
