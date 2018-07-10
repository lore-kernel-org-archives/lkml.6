Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03443C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B102C20883
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:25:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="iqDjD1ku";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NZz6CHM7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B102C20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732520AbeGJSZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:25:22 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42858 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732245AbeGJSZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:25:22 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9828160B18; Tue, 10 Jul 2018 17:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531244759;
        bh=jYPfHnneS3EXHeZYjnIRzT3dEqMxfmcNXd6Df4giv4w=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=iqDjD1kupvT1eC4k9IWVseo/n+x/fDdWIjpFWsSX2eKKlC/Fr2VcJSr4F3Jlan7An
         T8SpL183WXrg+poPEufx6pKjzTwUnB/AwGNDXTDEiQMwOxkzPN6UqOfWZgE3smzd72
         oXLVdYq4MZWKqFUIXzg4NZQrBk/S2FESut66FdtE=
Received: from [10.46.160.165] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: collinsd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 627C760B14;
        Tue, 10 Jul 2018 17:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531244758;
        bh=jYPfHnneS3EXHeZYjnIRzT3dEqMxfmcNXd6Df4giv4w=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=NZz6CHM7r2oUJQf2cv/NF3S6K0minrJlvxN+o1RBoB7ihIqitOKZvQwUrbIJvWmtZ
         N5ZJvJ5DfoqQojbr0Pl0QKmQd/FRazxrUWWHA4B5WaGcBW53qncpj+3q486pyvWekI
         hyafdus4pesMBWt1bOf4OQRC8PDGezqX/uU+L1io=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 627C760B14
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=collinsd@codeaurora.org
Subject: Re: [PATCH 3/3] arm64: dts: qcom: pm8998: Add thermal zone
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
References: <20180628210915.160893-1-mka@chromium.org>
 <20180628210915.160893-3-mka@chromium.org>
 <CAD=FV=Wo4wc_QZYr0a2_Ge=B6T4RNJDnOyxAd8r6sT4iZJjCKg@mail.gmail.com>
 <20180629185102.GV129942@google.com>
 <3b5054bb-76e4-a06f-54bb-e6ea7bbbcc69@codeaurora.org>
 <20180629235417.GY129942@google.com>
From:   David Collins <collinsd@codeaurora.org>
Message-ID: <8144dd3c-6138-7f16-ec17-d75e84fcfb34@codeaurora.org>
Date:   Tue, 10 Jul 2018 10:45:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20180629235417.GY129942@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Matthias,

On 06/29/2018 04:54 PM, Matthias Kaehlcke wrote:
> On Fri, Jun 29, 2018 at 02:29:55PM -0700, David Collins wrote:
...
>> The PMIC TEMP_ALARM hardware peripheral will perform an automatic partial
>> PMIC shutdown upon hitting over-temperature stage 2 (125 C).  This turns
>> off peripherals within the PMIC that are expected to draw significant
>> current.  The set of peripherals included varies between PMICs.  This
>> partial shutdown will occur simultaneously with the triggering of an
>> interrupt to the APPS processor that informs the qcom-spmi-temp-alarm
>> driver that an over-temperature threshold has been crossed.
>>
>> The TEMP_ALARM peripheral will perform an automatic full PMIC shutdown
>> upon hitting over-temperature stage 3 (145 C).  Software won't receive an
>> interrupt in this case because all power is cut.
> 
> This information is very useful, thanks David!
> 
> The (partial) hardware shutdown seems like a good measure of last
> resort, however I suppose we prefer Linux to initiate a shutdown
> before losing part of the peripherals (drivers might not be happy
> about this and probably not revover even when the temperature goes
> down again) or reach a full PMIC shutdown.
> 
> Please let me know if there are reasons to prefer to go the hardware
> limits, it's also an option for device makers to overwrite these
> settings if they want different behavior.

Disabling stage 3 automatic full PMIC shutdown at 145 C is definitely a
bad idea.  This exists as a last resort in order to save the hardware and
ensure end user safety in case of excessive temperature even if software
is locked up.

Disabling stage 2 automatic partial PMIC shutdown at 125 C is not
recommended as the PMIC is already outside of reasonable operating
conditions and needs to take corrective action quickly.  However, doing so
may be acceptable if software is taking action to shut down the system
immediately upon receiving the stage 2 over-temperature interrupt.

Take care,
David

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
