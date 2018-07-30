Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 539A316256E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F27B320857
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:15:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="em5ou5S7";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bQlmisIP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F27B320857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729561AbeG3Svx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 14:51:53 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44786 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726782AbeG3Svx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 14:51:53 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 60946621F8; Mon, 30 Jul 2018 17:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532970955;
        bh=taB/858mpBEY6vsbgw0TSwyq/iKCH2s/fpfqaiNrOoI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=em5ou5S7ccuWzyJXjE8ksxf7FeHuFTvghDZdZXTAiFR8aNmiF5JeqeEKZTFCmWQWw
         KvWDMlYohYeNIxVujWkMsUtogI8SxD9A5sioziFaJvH8BtVqvXNnH1ie7r5tbDeS1I
         6hnaSQlqfLWoiODxtc1mcJ9vGS99/RE0FYrfsZK4=
Received: from [10.226.60.116] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kramasub@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5B288621C9;
        Mon, 30 Jul 2018 17:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532970954;
        bh=taB/858mpBEY6vsbgw0TSwyq/iKCH2s/fpfqaiNrOoI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=bQlmisIP3RJwEr2H+x/GY6R6IqX6eccBKezgGV5XjCN9u3tROzu068MlSRCsSTuwT
         BsdWvjnTEVvO4ybfCxAhZODlhChYOCAeCvsZTH7svJHEFwEybzw/b9Ra8DQJat5vFY
         qcxpOFoygFnToCPrZQ8fQ3RMgsnUQG4HZBPtHqfM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5B288621C9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kramasub@codeaurora.org
Subject: Re: [PATCH v7 1/4] i2c: i2c-qcom-geni: Add bus driver for the
 Qualcomm GENI I2C controller
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     andy.gross@linaro.org, david.brown@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, gregkh@linuxfoundation.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-i2c@vger.kernel.org,
        evgreen@chromium.org, acourbot@chromium.org, swboyd@chromium.org,
        dianders@chromium.org, Sagar Dharia <sdharia@codeaurora.org>,
        Girish Mahadevan <girishm@codeaurora.org>
References: <1528823348-30532-1-git-send-email-kramasub@codeaurora.org>
 <1528823348-30532-2-git-send-email-kramasub@codeaurora.org>
 <20180729103208.uyxp2feonvznmzsp@ninjato>
From:   Karthik Ramasubramanian <kramasub@codeaurora.org>
Message-ID: <d98a059f-e76e-0ae8-e02c-4a980ab925a8@codeaurora.org>
Date:   Mon, 30 Jul 2018 11:15:52 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180729103208.uyxp2feonvznmzsp@ninjato>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/29/2018 4:32 AM, Wolfram Sang wrote:
> On Tue, Jun 12, 2018 at 11:09:05AM -0600, Karthikeyan Ramasubramanian wrote:
>> This bus driver supports the GENI based i2c hardware controller in the
>> Qualcomm SOCs. The Qualcomm Generic Interface (GENI) is a programmable
>> module supporting a wide range of serial interfaces including I2C. The
>> driver supports FIFO mode and DMA mode of transfer and switches modes
>> dynamically depending on the size of the transfer.
>>
>> Signed-off-by: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
>> Signed-off-by: Sagar Dharia <sdharia@codeaurora.org>
>> Signed-off-by: Girish Mahadevan <girishm@codeaurora.org>
>> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> 
> Looks good except one minor thing:
> 
>> +	pm_runtime_set_suspended(gi2c->se.dev);
>> +	pm_runtime_set_autosuspend_delay(gi2c->se.dev, I2C_AUTO_SUSPEND_DELAY);
>> +	pm_runtime_use_autosuspend(gi2c->se.dev);
>> +	pm_runtime_enable(gi2c->se.dev);
>> +	i2c_add_adapter(&gi2c->adap);
>> +
>> +	return 0;
> 
> i2c_add_adapter can fail. So, I'd guess you want to check the return
> value and move it above the pm_runtime calls?
> 
Sure, I will update and upload a new patchset.

Regards,
Karthik.
-- 
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
