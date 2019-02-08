Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC6ECC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 05:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94EB62085A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 05:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Vppfh5i+";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ABPU29/E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfBHFNq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 00:13:46 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:38298 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfBHFNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 00:13:45 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 07DA46085F; Fri,  8 Feb 2019 05:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1549602825;
        bh=Epxg5oMx7p948rTTtVmM7t1VQNKZYq/qvGPZ3nQFngg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Vppfh5i+CTt+WaoKIAd2fOhg/KHNytYh5GZHvzM5oKTpCQalohWfqPUoCST4ihYzG
         bL/MR+PrQTva1ANgNQMaY3+t2Yh+1OoLD1YlNg0ntE3Y8+3GDDfiW5e+9jQp1JKF1w
         5CtbILTl5NHKLfloHhT2oRUqbRFoSg3RVx2JgJ8E=
Received: from [192.168.43.47] (unknown [106.206.90.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9BF7560791;
        Fri,  8 Feb 2019 05:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1549602824;
        bh=Epxg5oMx7p948rTTtVmM7t1VQNKZYq/qvGPZ3nQFngg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ABPU29/EKhMnBUJ6mC7vcDB/24Umg1D9FGQPfGz9AdPl0AnYCSKHBmsLMp4m8HPVp
         n3Wobc83C/IJS2jccVpFFLl7Cfdn7OpT91EGzftM/sSHS3OGqMGVZW7+r9h+ERonxd
         NCTGbnljOtBmOO02VdAAotW/NNq8VB/ue0Ge34I8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9BF7560791
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCHv7 5/6] coresight: etm4x: Add ETM PIDs for SDM845 and
 MSM8996
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Doug Anderson <dianders@chromium.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Tingwei Zhang <tingwei@codeaurora.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
References: <cover.1548981329.git.saiprakash.ranjan@codeaurora.org>
 <c050252dc8eb3fea03119cd5efc422ed6e48834e.1548981329.git.saiprakash.ranjan@codeaurora.org>
 <CANLsYkwoqOhtENkhhSY5Tv23-vgUst4oakWrmQsB97=gDTVQLA@mail.gmail.com>
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <cdef693d-1e8b-304d-cd62-d2fad3256580@codeaurora.org>
Date:   Fri, 8 Feb 2019 10:43:33 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <CANLsYkwoqOhtENkhhSY5Tv23-vgUst4oakWrmQsB97=gDTVQLA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/8/2019 1:56 AM, Mathieu Poirier wrote:
> On Thu, 31 Jan 2019 at 17:54, Sai Prakash Ranjan
> <saiprakash.ranjan@codeaurora.org> wrote:
>>
> 
> I am good with this patch but there isn't much I can do with it until
> Mike's patchset has been merged.  Please submit again when that has
> been done.
> 

Sure, thanks.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
