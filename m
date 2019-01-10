Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DACAC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 04:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D120C20879
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 04:42:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XbP+bcl4";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="WVBVz5nl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbfAJEmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 23:42:54 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:41944 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbfAJEmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 23:42:54 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A93D96089D; Thu, 10 Jan 2019 04:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547095373;
        bh=yKZxbKxuH76RPO64h06mP584lP5CvpNQXbQHIafW3a8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=XbP+bcl4uac0j+ATjJpgnQZPmeo3V8FSZmKvkYrdH7JOYnuX+/m1B38mLzJfxNUTS
         09EidbkJAgxFsGxVo+rAjclBdlI0S8cW6KwoXEeJgyoOyqhcIx3EDlS7asc+p7qeQx
         5m12iFyEb0s6qf7pUUIoT6d6xXQ973xshwlj9P94=
Received: from [10.79.129.145] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 112CD60386;
        Thu, 10 Jan 2019 04:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547095372;
        bh=yKZxbKxuH76RPO64h06mP584lP5CvpNQXbQHIafW3a8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=WVBVz5nlRsrquHn9hKBAwhVd4b8rLJGNaThbLpHisUSDpP4QeNbGHcmDdDwiINFwb
         i5FxAcTbKCfOYDgABrD2+0ev+2XRU9svK5vyY71UYwMj9zN9v24zEgCartFaTTTMVT
         vjCuqyVQgMecsw49j5F1j0/dyDOrLgFW640sPR/8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 112CD60386
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sdm845: Remove the duplicate header
 inclusion
To:     Doug Anderson <dianders@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Leo Yan <leo.yan@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <cover.1547054308.git.saiprakash.ranjan@codeaurora.org>
 <5f400b3a15cab5dd071e4a129d38cb21e7123b78.1547054308.git.saiprakash.ranjan@codeaurora.org>
 <CAD=FV=UgFwVdsTuaQhVA9q18Ns8n278A4mx=TrvuOW3mmZm84A@mail.gmail.com>
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <b8762c0d-45f2-7f32-2d13-ce1bd1274e0a@codeaurora.org>
Date:   Thu, 10 Jan 2019 10:12:45 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAD=FV=UgFwVdsTuaQhVA9q18Ns8n278A4mx=TrvuOW3mmZm84A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,

On 1/10/2019 4:27 AM, Doug Anderson wrote:
> 
> This was on my TODO list, but you beat me to it.  This could land any
> time and is completely separate from the other patches in this series.
> 
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> 

Thanks for the review. Sorry I missed keeping you and Bjorn in CC.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
