Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E234C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 00:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF49420B1F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 00:46:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QxwTQ6S+";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="aKrQjLIm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbfBAAqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 19:46:08 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:42324 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbfBAAqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 19:46:08 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9EF486089D; Fri,  1 Feb 2019 00:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548981967;
        bh=miBLSlMaBLtGMpZR1O7WbW8mvC2/v3vOdB5emXj1j8M=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=QxwTQ6S+g80cSPsuKHDVhoXM8XZ7yzF2ErsNR7UUbO8ht4gf1XsptZVeFOR740yws
         Nz0S/SbDmm/MUe1jpCnyrvt/qi06Hjx/BYRQkvVyCVS5S4QavO1bGhS2w9MkBfTyxn
         sMvqTk6NU1TBhIQ2rOUrZPSzMHWL3wfYY9qHQXjg=
Received: from [192.168.43.47] (unknown [223.186.125.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 81533601D1;
        Fri,  1 Feb 2019 00:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548981966;
        bh=miBLSlMaBLtGMpZR1O7WbW8mvC2/v3vOdB5emXj1j8M=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=aKrQjLImDchC6nEqmy2bqdGZGjfDqY3d4029niKCn8BvN12aLPi3fy26Z29hyoGR0
         3ZEFhQgoQ2Bc831nId6BDpVmAJNk4nZJLFmatE4ORN+2drWxkh6IA/oduo84Rxx9Cu
         iXH9ET8z5Wd+TQrMDBK7NsvhE8iFSKGojW9nkUjc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 81533601D1
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCHv6 6/6] coresight: debug: Add Unique Component Identifier
 (UCI) table
To:     Stephen Boyd <sboyd@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Gross <andy.gross@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Doug Anderson <dianders@chromium.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Leo Yan <leo.yan@linaro.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        devicetree@vger.kernel.org
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Tingwei Zhang <tingwei@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <cover.1548943727.git.saiprakash.ranjan@codeaurora.org>
 <f724b28e5bfd7bca062aa5380cfd9328289559bf.1548943727.git.saiprakash.ranjan@codeaurora.org>
 <154895230081.169292.7994428901781990604@swboyd.mtv.corp.google.com>
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <0edc38bd-44ac-4100-8042-3538e3eb74e8@codeaurora.org>
Date:   Fri, 1 Feb 2019 06:15:54 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <154895230081.169292.7994428901781990604@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/31/2019 10:01 PM, Stephen Boyd wrote:
> Quoting Sai Prakash Ranjan (2019-01-31 06:22:24)
>> diff --git a/drivers/hwtracing/coresight/coresight-cpu-debug.c b/drivers/hwtracing/coresight/coresight-cpu-debug.c
>> index e8819d750938..915d86a39cee 100644
>> --- a/drivers/hwtracing/coresight/coresight-cpu-debug.c
>> +++ b/drivers/hwtracing/coresight/coresight-cpu-debug.c
>> @@ -655,24 +655,23 @@ static int debug_remove(struct amba_device *adev)
>>          return 0;
>>   }
>>   
>> +static struct amba_cs_uci_id uci_id_debug[] = {
> 
> Can this be const?
> 
>> +       {
>> +               /*  CPU Debug UCI data */
>> +               .devarch        = 0x47706a15,
>> +               .devarch_mask   = 0xfff0ffff,
>> +               .devtype        = 0x00000015,
>> +       }
>> +};

Yes and done in next version, thanks.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
