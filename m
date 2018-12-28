Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10FDEC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 04:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C469C2148E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 04:47:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Kj5qIE8c";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Jb+6Rz93"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731575AbeL1Era (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 23:47:30 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:40340 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731486AbeL1Era (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 23:47:30 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 65BD96074E; Fri, 28 Dec 2018 04:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545972449;
        bh=jprrkloCLLJIdQcF9ZWZP44CWuStVuG/+LAuOmH8l2k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Kj5qIE8cpShEdEpAg+uBelJ8rudCMFuRzj76HKdJOHOQ5vgacQ2R8eqyM1eD1t74X
         cXuvdwbPQHXBjQOBbaIT0oMLb8AOeOJlGDoIMECnt7ONs+51qbu/ByS2fMY4zypfuZ
         Zcqr3/24pvVR9jiaaoCQYzB/begeLeC+BIghzcLs=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id AB76A60350;
        Fri, 28 Dec 2018 04:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545972448;
        bh=jprrkloCLLJIdQcF9ZWZP44CWuStVuG/+LAuOmH8l2k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Jb+6Rz93cKISVC1D2SMkfxHzz2dgsIaBCcGMOIhSy49De4PA+JPloZZ0h0ZSxZVZe
         wQ38LVkH79lIORYmbJvngE17jBLljB9VpZTvHds01ZaE6jjl9srHbbufK4Ha1Q7z7t
         KBV/8OYzlWo6J661X2uH2d+QAnh7e11gEbDtKzXA=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 28 Dec 2018 10:17:28 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Rob Herring <robh@kernel.org>
Cc:     bjorn.andersson@linaro.org, david.brown@linaro.org,
        mark.rutland@arm.com, andy.gross@linaro.org,
        briannorris@chromium.org, akdwived@codeaurora.org,
        clew@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-arm-msm-owner@vger.kernel.org, ohad@wizery.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: remoteproc: qcom: Add firmware bindings
 for Q6V5 MSS
In-Reply-To: <20181220201002.GA8831@bogus>
References: <20181212124456.3164-1-sibis@codeaurora.org>
 <20181212124456.3164-2-sibis@codeaurora.org> <20181220201002.GA8831@bogus>
Message-ID: <bbae159b2349b7681f922d46d02305db@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,
Thanks for the review :)

On 2018-12-21 01:40, Rob Herring wrote:
> On Wed, Dec 12, 2018 at 06:14:55PM +0530, Sibi Sankar wrote:
>> Add optional firmware bindings for Q6V5 MSS. It lists the two relative
>> firmware paths which are used for booting and authenticating the 
>> Hexagon
>> core.
>> 
>> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
>> ---
>>  Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt | 7 
>> +++++++
>>  1 file changed, 7 insertions(+)
>> 
>> diff --git 
>> a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt 
>> b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
>> index 9ff5b0309417..1f6988a60636 100644
>> --- a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
>> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
>> @@ -36,6 +36,13 @@ on the Qualcomm Hexagon core.
>>  	Value type: <stringlist>
>>  	Definition: must be "wdog", "fatal", "ready", "handover", "stop-ack"
>> 
>> +- qcom,firmware:
> 
> We already have a standard name 'firmware-name'. Use that. I'm fine 
> with
> allowing it to be more than 1 string.

sure will replace "qcom,firmware" with "firmware-name" in the next 
re-spin

> 
>> +	Usage: optional
>> +	Value type: <stringlist>
>> +	Definition: must list the 2 relative firmware paths (mba and modem
>> +		    metadata respectively) which are used for booting and
>> +		    authenticating the Hexagon core.
>> +
>>  - clocks:
>>  	Usage: required
>>  	Value type: <phandle>
>> --
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
>> Forum,
>> a Linux Foundation Collaborative Project
>> 

-- 
-- Sibi Sankar --
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
