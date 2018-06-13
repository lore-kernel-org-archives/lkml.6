Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 28D66C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 20:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C88AA208CD
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 20:45:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="lUGgnfO4";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TjIjnrml"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C88AA208CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935689AbeFMUpJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 16:45:09 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49462 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935365AbeFMUpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 16:45:08 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B56AF60795; Wed, 13 Jun 2018 20:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528922707;
        bh=7ve/4fAiuLeLBKihURuFViPj1J/oQrZVg3GBN1IrpRk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=lUGgnfO4HWU/wJCAiqkquFa61BBNmqwQururp8p/8IKD/tKnQdbztjh9pzZCwe7w4
         eNEdjMUozrXtGws9LH8JGlY61GVx/BlLkSZDP542SERSJR+9mGytl9L3ge9oaKjpHX
         hB90W7vbbGWQzykcUnM6peRYGYmEGtRWvVTXcKHs=
Received: from [10.222.143.167] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: timur@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8A181602B8;
        Wed, 13 Jun 2018 20:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528922704;
        bh=7ve/4fAiuLeLBKihURuFViPj1J/oQrZVg3GBN1IrpRk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=TjIjnrmlWBxWat6EVpmtbYrJrO8F0LyOQN7kx8rkep1J8KWahLI+N0wl/fZtF8lxg
         WVUHIIBfZG3ViN2hPYg1PbAZ6BJtOzWZYtgWcXT8TfyCjZvapXZj5Ht3inHdpC8MvX
         ja7w2aMAmuYR0CogSxzop0frrgnJjtJzmBqYlSTc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8A181602B8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=timur@codeaurora.org
Subject: Re: [PATCH net] net: qcom/emac: Add missing of_node_put()
To:     YueHaibing <yuehaibing@huawei.com>, davem@davemloft.net
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Hemanth Puranik <hpuranik@codeaurora.org>
References: <20180611130345.15172-1-yuehaibing@huawei.com>
From:   Timur Tabi <timur@codeaurora.org>
Message-ID: <5bae4b8f-6235-8c28-61f9-88d574084d6a@codeaurora.org>
Date:   Wed, 13 Jun 2018 15:45:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180611130345.15172-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/11/2018 08:03 AM, YueHaibing wrote:
> Add missing of_node_put() call for device node returned by
> of_parse_phandle().
> 
> Signed-off-by: YueHaibing<yuehaibing@huawei.com>

Acked-by: Timur Tabi <timur@codeaurora.org>

This seems legit.  The comment for of_find_device_by_node() that says 
the np needs to be released was added after the code was written, so 
it's possible that I didn't know at the time that this was a requirement.

However, I no longer have the ability to test EMAC on device tree 
platforms, so I can't verify this code.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
