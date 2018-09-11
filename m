Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57041C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 18:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3A5D20866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 18:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="F50pwITk";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="F50pwITk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3A5D20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbeIKXSM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 19:18:12 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39948 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbeIKXSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 19:18:12 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id ABC55607DD; Tue, 11 Sep 2018 18:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536689861;
        bh=1rxzD8DWJkhuA4nKdzU6smb2w/KKCiLzHn+DapyrBhQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=F50pwITkvKAI7o/gnC7eYc2TbI29IyiHqBZvQvOZHtvYufsUpPhp71FffrECeigEF
         H44dcTNVoppUQ6vVdtWpyVFK0vsAxE5XGJKV5R/cK5EzMrz4Dv4kCVLBhiwECyqziX
         AcdFZiPMu2cFqnDGtaJCl5INuvrKyxaOgkI+pfFQ=
Received: from [10.63.172.127] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tsoni@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 121FD60721;
        Tue, 11 Sep 2018 18:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536689861;
        bh=1rxzD8DWJkhuA4nKdzU6smb2w/KKCiLzHn+DapyrBhQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=F50pwITkvKAI7o/gnC7eYc2TbI29IyiHqBZvQvOZHtvYufsUpPhp71FffrECeigEF
         H44dcTNVoppUQ6vVdtWpyVFK0vsAxE5XGJKV5R/cK5EzMrz4Dv4kCVLBhiwECyqziX
         AcdFZiPMu2cFqnDGtaJCl5INuvrKyxaOgkI+pfFQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 121FD60721
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tsoni@codeaurora.org
Subject: Re: [PATCH] samples/rpmsg: Introduce a module parameter for message
 count
To:     Suman Anna <s-anna@ti.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20180911174643.26199-1-s-anna@ti.com>
From:   Trilok Soni <tsoni@codeaurora.org>
Message-ID: <2d904881-ec72-dd68-48ff-b8307642bc63@codeaurora.org>
Date:   Tue, 11 Sep 2018 11:17:40 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180911174643.26199-1-s-anna@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn,

>   
>   #define MSG		"hello world!"
> -#define MSG_LIMIT	100
> +
> +static int count = 100;
> +module_param(count, int, 0644);

I thought Greg KH doesn't want any new code to have module_param call, 
right? Are we Ok here or I am missing something here.

-- 
---Trilok Soni
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a 
Linux Foundation Collaborative Project
