Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A4A6C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 14:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1843121473
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 14:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fq11guSm";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="O8gM1tsr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbfA2Oyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 09:54:50 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:60574 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfA2Oyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 09:54:49 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 99FEA607F4; Tue, 29 Jan 2019 14:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548773688;
        bh=4a1KzVQTbGqBLNGcaW04Ct2MNcmCMNFxQwsaZ2ynFy4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=fq11guSmTJTIBPK3E+LPzKfugjgZa7EPplvGjsqbOZ3zgPjty6jctJo6rRnMG3fjQ
         JzhB3CieMse7PbvZ4sYO8ZlPtUrKuMroFv6W1TlANisvEM0dhKChVxgnUwFU/oCA2f
         e7S35OY0RKm0qeaeRtSdu3YmVouB85UAZZOWKfrY=
Received: from [192.168.1.100] (unknown [157.49.239.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7EFBE60918;
        Tue, 29 Jan 2019 14:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548773687;
        bh=4a1KzVQTbGqBLNGcaW04Ct2MNcmCMNFxQwsaZ2ynFy4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=O8gM1tsrM6uoopLRdkquCIKAh7UgByqJ3+zRsQBoAGpdLjOTm20JxvE15GgJXGEWk
         CpZ1meZrURfri7wU66KUc246ZuUPXhBGfE6+llHY20dCBFchq1EwXK0DKf18yZrZv9
         D502U6PSEb6+McuNe4Q0Rl2xbgKdh5UcZWBAvUTA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7EFBE60918
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCHv5 6/7] coresight: debug: Add Unique Component Identifier
 (UCI) table
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
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
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <cover.1548419933.git.saiprakash.ranjan@codeaurora.org>
 <1019e6fed1ade6a580f01df9b3f70c2a9df5b3be.1548419933.git.saiprakash.ranjan@codeaurora.org>
 <20190129132528.GA16669@leoy-ThinkPad-X240s>
 <20190129133605.GB16669@leoy-ThinkPad-X240s>
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <fabcf7ca-96c4-8a54-f6cf-713eb1f0b822@codeaurora.org>
Date:   Tue, 29 Jan 2019 20:24:34 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190129133605.GB16669@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo,

On 1/29/2019 7:06 PM, Leo Yan wrote:
> 
> I just now found if apply this patch onto coresight next branch [1],
> it will conflict with patch 'coresight: cpu-debug: Support for CA73
> CPUs' [2].  Sorry if introduce regression by this.
> 

This patch depends on UCI support which is being discussed at:

https://lore.kernel.org/lkml/20190121233151.13363-2-mike.leach@linaro.org/

So I think this should not go into coresight-next until the UCI support
is merged into coresight-next as well.

If UCI support is already merged, then I can rebase this patch on top
of coresight-next and resend.

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
