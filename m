Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38302C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6D43216F4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qFenbdpv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6D43216F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbeI0UiR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 16:38:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:40398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727335AbeI0UiR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 16:38:17 -0400
Received: from [192.168.1.75] (cpe-24-28-70-126.austin.res.rr.com [24.28.70.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 061AC215E4;
        Thu, 27 Sep 2018 14:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538057987;
        bh=4h/9fxHAFiMIjsTrxx7NJb/w4Dp11sM9untbuGNsUMY=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=qFenbdpvWPEN53TLoiuHl4Mw1tpjr9TMu+ab9rcBrXHwkGBfvehhJbDdI4ZDqvIjc
         Cg+aiqWoExjxHrBljpg9NyMDosH/vBvbxFbfue5MYEXMFdbDQqkXqHP2SmOPLzooFU
         xin2m+fV80HbplzT6WzBmhQPOkkLF76gbyBWjsCI=
Subject: Re: [PATCH v2] gpiolib: Show correct direction from the beginning
To:     Jeffrey Hugo <jhugo@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        linux-gpio@vger.kernel.org
References: <20180921103604.13361-1-ricardo.ribalda@gmail.com>
 <20180921103604.13361-2-ricardo.ribalda@gmail.com>
 <153803107307.119890.10052910965015646333@swboyd.mtv.corp.google.com>
 <ffe11a8c-368b-8c74-54a7-a088c3997032@kernel.org>
 <3e07cab8-0f3e-7474-8f6d-e6bb16e8f998@codeaurora.org>
From:   Timur Tabi <timur@kernel.org>
Message-ID: <c9c24958-a020-a6b4-5ee4-51356bf345a5@kernel.org>
Date:   Thu, 27 Sep 2018 09:19:45 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <3e07cab8-0f3e-7474-8f6d-e6bb16e8f998@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/18 9:04 AM, Jeffrey Hugo wrote:
> 
> I guess its lucky I saw this then.

Did you not get this email: 
https://lore.kernel.org/patchwork/patch/989545/#1173771
