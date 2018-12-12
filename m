Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 476CCC67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 21:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06E2420811
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 21:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544649373;
	bh=qKdiLhf6Dp4uSNZDkAGD8j5pUcJwKe37uPHlL464Lm8=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=lX2lIp3gC2jAxCSpAW0osQ4KuaUHAg7fuVFo+4cfBVdT8R8ePLjVZ413dyMeu5Pjf
	 I0zqcY8Op75sOmUx/wAiYpiE97VJo6i8fXpgow4VQN3V7lghSY7tw7jl19Swq52lEz
	 9Y/hRQLbMmFrLI4yS8p6LDBI0l/SPcpJcxMevdK4=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06E2420811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbeLLVQL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 16:16:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:50310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728400AbeLLVQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 16:16:08 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A8E120811;
        Wed, 12 Dec 2018 21:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544649367;
        bh=qKdiLhf6Dp4uSNZDkAGD8j5pUcJwKe37uPHlL464Lm8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=olSkG2gAUs+0PFC/b7b+bf8q4KYdRgMz8AD2X+gihQ7A0rKxdSKbxJKZnBv1TGnR9
         YgNN4fTxjt9tyx2oYC/j+v5nGlb99wlFCRr83ZQVLXhotf76gOYuV7M8U9I0lEpcPZ
         i+FcYY2WX+kJ6p2ZL8CHV21ijIJ3X49iXFc/I300=
Subject: Re: [PATCH] fix dma-buf/udmabuf selftest
To:     Tom Murphy <murphyt7@tcd.ie>, linux-kselftest@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Gerd Hoffmann <kraxel@redhat.com>, linux-kernel@vger.kernel.org,
        shuah <shuah@kernel.org>
References: <20181127103312.19368-1-murphyt7@tcd.ie>
From:   shuah <shuah@kernel.org>
Message-ID: <81c4efd9-2ccd-53ec-98e7-663c95d6d5c4@kernel.org>
Date:   Wed, 12 Dec 2018 14:15:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181127103312.19368-1-murphyt7@tcd.ie>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On 11/27/18 3:33 AM, Tom Murphy wrote:
> This patch fixes the udmabuf selftest. Currently the selftest is broken.
> I fixed the selftest by setting the F_SEAL_SHRINK seal on the memfd
> file descriptor which is required by udmabuf and added the test to
> the selftest Makefile.
> 
> Signed-off-by: Tom Murphy <murphyt7@tcd.ie>

Does this change look good you? I plan to get this in for 4.21-rc1. Let 
me know if you have any objections.

thanks,
-- Shuah

