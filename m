Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D70C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 03:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F4BF20873
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 03:00:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TbWCtv7E";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hckWqWdg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfARDAY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 22:00:24 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:34294 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfARDAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 22:00:23 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A4EED60854; Fri, 18 Jan 2019 03:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547780422;
        bh=Kmvy6jmyxSGe+B72xwSc13kkWmiV6lSKDp4kebtGVJ4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=TbWCtv7E85S6XtslDss10MqTAO1JDTkZhPWhBHTOcKv5aB/d0Mjbl2XJkHo/b/OlF
         4Z6C3EWwuXera0IcvKTWwEtgfQgEJjCGDbuQ/t9JQAj+foBOA22vpMLbOfQoPOZc6g
         e7X63Hm3zteO438m5DMSG7VDmOHJIaP5I3g/dNMo=
Received: from [10.79.129.0] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8E7D1605A0;
        Fri, 18 Jan 2019 03:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547780421;
        bh=Kmvy6jmyxSGe+B72xwSc13kkWmiV6lSKDp4kebtGVJ4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=hckWqWdgfYwfwLvwqSGWza7/stYyIoEqaxCFU+Ppg4r1LNzmM9PQkh4tbuSjcxCTw
         CJdWh55xasiY37a+87aWTbRQ9oB8eVfkSW9QCGHuoxSdU6393Q6VxOr7NJc/bTjBPf
         0AAdukb77/fM6xemB4hct4fb7sgF6YWwnjlJyIgI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8E7D1605A0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCH 1/3] arm64: dts: qcom: sdm845: Add Coresight support
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <cover.1547054308.git.saiprakash.ranjan@codeaurora.org>
 <a13ad49d3ae8d9a5a972027283b7212ab19f97d0.1547054308.git.saiprakash.ranjan@codeaurora.org>
 <20190113072319.GB28907@builder>
 <5724d2d4-39df-a923-5f94-b53c40a84fd3@codeaurora.org>
 <20190117195027.GA12955@builder>
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <c7c33640-ae2c-eacf-0c91-a7537b5f16c1@codeaurora.org>
Date:   Fri, 18 Jan 2019 08:30:15 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190117195027.GA12955@builder>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/18/2019 1:20 AM, Bjorn Andersson wrote:
> 
> There seems to be some variations of this, but we try to keep everything
> sorted in sdm845.dtsi to avoid having to jump around between the various
> files. So please merge it into sdm845.dtsi (sorted by address).
> 

Sure will do it.

Thanks,
Sai
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
