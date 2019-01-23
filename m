Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E0EC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 06:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73BA121726
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 06:51:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="R3TUSqar";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bmvcOTHV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfAWGvd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 01:51:33 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:54286 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbfAWGvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 01:51:32 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 25CBB60850; Wed, 23 Jan 2019 06:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548226291;
        bh=OHTrLd6CL/NsoihFM6/7CvbjXzcCvcf7CB11djWG+zM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=R3TUSqar1i6JfGigRBTd1WOFwnGv1r1qYIsQqh/IPkoJzK5ERY53SgUs0ZLMKHWaN
         RNh89yWymFb5bLr/akOfb8qLTFnPEbdATQTnMdMFYn+q2apelzZanhDJMfQJAaTVPT
         V2FKn1eXhNpZz4pb3oMB2vHftjFOKNPt7uTmdwms=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id C5A2F60225;
        Wed, 23 Jan 2019 06:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548226290;
        bh=OHTrLd6CL/NsoihFM6/7CvbjXzcCvcf7CB11djWG+zM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bmvcOTHV8YufP3n4KKC5/oPJe6nTIWnuOptzqBq0pNSM1WsSN/6X99bkKbrIX+4PI
         u+qm+xaSXu4o4X1DsYoUfag6xl8onWtgvrCdHq1fG+m6cyS5o2/sGQPsQjm64oUexK
         UKT2Wyj6Ose49djHPFWaC7yjNYWZSYSrsrl23Zr0=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 23 Jan 2019 12:21:30 +0530
From:   alokc@codeaurora.org
To:     Peter Rosin <peda@axentia.se>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-serial@vger.kernel.org,
        Karthikeyan Ramasubramanian <kramasub@codeaurora.org>,
        andy.gross@linaro.org, david.brown@linaro.org,
        georgi.djakov@linaro.org, dianders@chromium.org,
        swboyd@chromium.org, bjorn.andersson@linaro.org,
        linux-arm-msm-owner@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/6] i2c: i2c-qcom-geni: Add interconnect support
In-Reply-To: <d44cdb5e-2408-493c-3f86-db97c224dc3f@axentia.se>
References: <1548138816-1149-1-git-send-email-alokc@codeaurora.org>
 <1548138816-1149-4-git-send-email-alokc@codeaurora.org>
 <d44cdb5e-2408-493c-3f86-db97c224dc3f@axentia.se>
Message-ID: <d52763d50d610b44351663e18a960066@codeaurora.org>
X-Sender: alokc@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-22 14:43, Peter Rosin wrote:
> On 2019-01-22 07:33, Alok Chauhan wrote:
>> Get the interconnect paths for I2C based Serial Engine device
>> and vote accordingly based on maximum supported I2C frequency.
>> 
>> Signed-off-by: Alok Chauhan <alokc@codeaurora.org>
>> ---
>>  drivers/i2c/busses/i2c-qcom-geni.c | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>> 
>> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c 
>> b/drivers/i2c/busses/i2c-qcom-geni.c
>> index db075bc..e8fe63a 100644
>> --- a/drivers/i2c/busses/i2c-qcom-geni.c
>> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
>> @@ -14,6 +14,7 @@
>>  #include <linux/pm_runtime.h>
>>  #include <linux/qcom-geni-se.h>
>>  #include <linux/spinlock.h>
>> +#include <linux/interconnect.h>
> 
> Please keep the includes sorted. Probably applies for the other patches
> in the series as well?
> 
> Cheers,
> Peter

Sure, will do. Thanks for your comment.

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,a Linux Foundation Collaborative Project
