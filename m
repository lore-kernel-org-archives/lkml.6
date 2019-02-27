Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB5BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AF7A2133D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="e6TiKOJI";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Vznn7cH4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730142AbfB0OZ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 09:25:57 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:46574 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbfB0OZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 09:25:57 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 06BBA60E59; Wed, 27 Feb 2019 14:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1551277556;
        bh=d3l+OeS5MZZ+WH4sNkNSOgvIs5aZp8+UhkUbb9R4eQk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=e6TiKOJIA+rOdHWTdGYJBusW5a4mQqmXkq9VHuvGWKW2IfCM9xBlv8g8uKwY7xpL/
         I4hP70IuDjqiD9gX7VBcUBcvOBCyritc8nlIayqk42IZeQakKU+988wRvN6k48H1cv
         C3kYNFKTUQxg0vxAXAUh4+3imb9EB5Y3iMHyuVv0=
Received: from [10.226.60.81] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C6436608FF;
        Wed, 27 Feb 2019 14:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1551277555;
        bh=d3l+OeS5MZZ+WH4sNkNSOgvIs5aZp8+UhkUbb9R4eQk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Vznn7cH4AmCP/vKlOcJYeFrSOM7xyvwLMXaqeWa93C7PwHt3qDRJ+tf57Zgyxd/Kz
         AwOZs+YBT1CLrr97BKbrmt77zwrcydNbky+Dbe3Q8fXTN2JMkNQDmVCvRYrIuFuH8y
         tt9TQYk00uQvhv7t9rrZB50t0ew0ST8M7bYITyUA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C6436608FF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [PATCH] arm64: dts: qcom: Add Dragonboard 845c
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190227074009.19248-1-bjorn.andersson@linaro.org>
From:   Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <60e2bea0-463c-7705-b9bf-a0380111156a@codeaurora.org>
Date:   Wed, 27 Feb 2019 07:25:54 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190227074009.19248-1-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/27/2019 12:40 AM, Bjorn Andersson wrote:
> This adds an initial dts for the Dragonboard 845. Supported
> functionality includes Debug UART, UFS, USB-C (peripheral), USB-A
> (host), Ethernet, microSD-card and Bluetooth.
> 
> Initializing the SMMU is clearing the mapping used for the splash screen
> framebuffer, which causes the baord to reboot. This can be worked around

baord -> board?

> using:
> 
>    fastboot oem select-display-panel none
> 
> Ethernet and the second USB-A port depends on a functional firmware
> loader for the uPD720201.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---


-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
