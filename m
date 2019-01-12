Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9395C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 12:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 806762086C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 12:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="efBTxDQr";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Ti5QamKz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725863AbfALMvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 07:51:02 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:52430 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbfALMvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 07:51:02 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 97623608A5; Sat, 12 Jan 2019 12:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547297461;
        bh=vc95Z/tMlWNdjowrwCwRgmlvYWxkp4Ha9JVSJUZtmRw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=efBTxDQrAUC6i3csoz7boD3nLvf3rJvOQk+L9BmwSRurQcswXvLaCU9ABEojoc6cu
         /TTk3HzC4nZmNHTTaEZ0YZC2vW2HpgWDiJqO/xedrNi9UxRoxCsfA8cAliU80/1syv
         kzcuBdngmV6a+1Nfn/8NQfK410f7zr/A7uOMgoCk=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id CF28B6087F;
        Sat, 12 Jan 2019 12:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547297460;
        bh=vc95Z/tMlWNdjowrwCwRgmlvYWxkp4Ha9JVSJUZtmRw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ti5QamKzeZ1n7mzWuR9OIUfBx8DLh82A/ne0E++ehrYuFCH79PMffGcpZ3jWdkNVP
         RZ5V/Gy4WInJZVuHnYZfC7K2PbR+Z0Rb4SBdWbS8LaU3wNViMzbhO+d5OUW0cuCDId
         7ZPAn+2WOJ5j/vUdQLrt9UEsH9BCa8QHk474Sk4A=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 12 Jan 2019 18:21:00 +0530
From:   saiprakash.ranjan@codeaurora.org
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
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
        linux-arm-msm@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org
Subject: Re: [PATCH 1/3] arm64: dts: qcom: sdm845: Add Coresight support
In-Reply-To: <20190111184643.GA22691@xps15>
References: <cover.1547054308.git.saiprakash.ranjan@codeaurora.org>
 <a13ad49d3ae8d9a5a972027283b7212ab19f97d0.1547054308.git.saiprakash.ranjan@codeaurora.org>
 <20190111184643.GA22691@xps15>
Message-ID: <81172d85ed7782e0db561fcf96a82d46@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

>> +
>> +	etm@7040000 {
>> +		compatible = "arm,coresight-etm4x", "arm,primecell";
>> +		arm,primecell-periphid = <0x000bb95d>;
> 
> I'm a little curious as to why you need to bypass the normal AMBA bus 
> discovery
> method by forcing the peripheral ID.  Tracers don't show up the way 
> other
> coresight devices do at boot time?
> 

Yes on some Qcom SoC's like SDM845 and also on some previous ones, for 
ETM(only) amba bus discovery method fails because of wrong pid read from 
the registers. So we have to force this primecell peripheral ids to 
probe etm.

- Sai

--
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member of Code Aurora Forum, hosted by The Linux Foundation
