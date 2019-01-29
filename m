Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E74C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 04:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35946217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 04:35:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="G8e36OFb";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="G8e36OFb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbfA2Efm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 23:35:42 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:49486 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbfA2Efl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 23:35:41 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A97ED6086A; Tue, 29 Jan 2019 04:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548736540;
        bh=5u4g+WUouOUxOpqRHhxuGu7sPHEixJtAN83EGTCKbF8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=G8e36OFbejBun8UviwuPp+PhFtIvDA1JORd2YC5gwpFISZC38fXnhaFHrHKac9lAk
         208v/talaupLJqY2+xxfnf8c7A855d77IlCXkrt26L1NYZ/LYVwxzE11pKiy22ew1t
         f4Kxd68WQjvIFXPSvmcqYlQWmZjPJEUpdin1yawU=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 58A216055A;
        Tue, 29 Jan 2019 04:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548736540;
        bh=5u4g+WUouOUxOpqRHhxuGu7sPHEixJtAN83EGTCKbF8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=G8e36OFbejBun8UviwuPp+PhFtIvDA1JORd2YC5gwpFISZC38fXnhaFHrHKac9lAk
         208v/talaupLJqY2+xxfnf8c7A855d77IlCXkrt26L1NYZ/LYVwxzE11pKiy22ew1t
         f4Kxd68WQjvIFXPSvmcqYlQWmZjPJEUpdin1yawU=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 29 Jan 2019 10:05:39 +0530
From:   saiprakash.ranjan@codeaurora.org
To:     Doug Anderson <dianders@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Tingwei Zhang <tingwei@codeaurora.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-arm-msm-owner@vger.kernel.org
Subject: Re: [PATCHv5 7/7] arm64: dts: qcom: sdm845: Remove the duplicate
 header inclusion
In-Reply-To: <CAD=FV=XjVU=stq9U+tBtJpAiQa+6hDKi8+F5LOX4bq68-wQNaA@mail.gmail.com>
References: <cover.1548419933.git.saiprakash.ranjan@codeaurora.org>
 <d0370bc569491d11827a6eb12a75a236c3d60a0e.1548419933.git.saiprakash.ranjan@codeaurora.org>
 <CAD=FV=XjVU=stq9U+tBtJpAiQa+6hDKi8+F5LOX4bq68-wQNaA@mail.gmail.com>
Message-ID: <21171aed64071e5c83376de5a280b134@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,

On 2019-01-29 00:54, Doug Anderson wrote:
> Hi,
> 
> You can probably stop sending this one.  It's in Andy's tree now.  See
> commit ea0edd7e63f4 ("arm64: dts: qcom: sdm845: Remove the duplicate
> header inclusion").

Sorry, missed this one.
