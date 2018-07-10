Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DBDFC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 23:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6DC220BEC
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 23:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RSVGSMbY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6DC220BEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732397AbeGJXjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 19:39:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:54150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732302AbeGJXjF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 19:39:05 -0400
Received: from [192.168.1.125] (cpe-24-28-70-126.austin.res.rr.com [24.28.70.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47569208E8;
        Tue, 10 Jul 2018 23:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531265860;
        bh=VeWOTjhJJxJeJST22FCdugf7g8IBn3mNQ1tZNngd2VA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=RSVGSMbYpSfSOb/kDdEn8hy55Bh0T+YU0+p6OAvMx2fRCa4gUuBbB2YZvX4Ilh8Np
         HsksQK7XYQjXuxDzG0rAYDTr2Xl4vpFbs2FMygnl549mAFXLV87kUFgL+0Ibwx532j
         3+LKv2mNv9sasMwoumhkLGd1kk8JyL9wiZiHwSV0=
Subject: Re: [PATCH v5 6/6] crypto: qcom: Add ACPI support
To:     Jeffrey Hugo <jhugo@codeaurora.org>, Vinod Koul <vkoul@kernel.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>, linux-arm-msm@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>,
        Timur Tabi <timur@codeaurora.org>
References: <20180709061925.20276-1-vkoul@kernel.org>
 <20180709061925.20276-7-vkoul@kernel.org>
 <2a678412-26d4-769e-ff6f-ace5d53e70b5@codeaurora.org>
From:   Timur Tabi <timur@kernel.org>
Message-ID: <6d29f5e3-e147-780a-fe49-5420b3934f1c@kernel.org>
Date:   Tue, 10 Jul 2018 18:37:37 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <2a678412-26d4-769e-ff6f-ace5d53e70b5@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/10/18 12:27 PM, Jeffrey Hugo wrote:
>>
>> Add support for probing on ACPI systems, with ACPI HID QCOM8160.
>>
>> On ACPI systems, clocks are always enabled, the PRNG should
>> already be enabled, and the register region is read-only.
>> The driver only verifies that the hardware is already
>> enabled never tries to disable or configure it.
>>
>> Signed-off-by: Timur Tabi <timur@codeaurora.org>
>> [port to crypto API]
>> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> 
> Tested-by: Jeffrey Hugo <jhugo@codeaurora.org>

Thanks, Jeff.  I appreciate it.

