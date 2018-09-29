Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D15C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 13:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39FBA206B2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 13:25:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="etyeaefE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39FBA206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbeI2Tx7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 15:53:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:52698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728077AbeI2Tx6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 15:53:58 -0400
Received: from [192.168.1.75] (cpe-24-28-70-126.austin.res.rr.com [24.28.70.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C847206B2;
        Sat, 29 Sep 2018 13:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538227531;
        bh=+cJR0VnpRJ1Z59/fYsownE5L5SjIOJ4yjJVn3kbUuRw=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=etyeaefENyIx/EHTiw/FZJklDXbrdVjPNRdI9yFS/13e8BBtIKOxb8VwgnskgDyI0
         hwp7eosPaWkFm4brdYgnbLBR1GHclV69L+AmnH+aISxCddFFYFu9vdu/nmGTsE7XIG
         b/pjW9WaJoVXtbJLFejfa3DuqRibCbDArLyiPP0o=
Subject: Re: [PATCH v2] gpiolib: Show correct direction from the beginning
From:   Timur Tabi <timur@kernel.org>
To:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc:     jhugo@codeaurora.org, swboyd@chromium.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org
References: <20180921103604.13361-1-ricardo.ribalda@gmail.com>
 <20180921103604.13361-2-ricardo.ribalda@gmail.com>
 <153803107307.119890.10052910965015646333@swboyd.mtv.corp.google.com>
 <ffe11a8c-368b-8c74-54a7-a088c3997032@kernel.org>
 <3e07cab8-0f3e-7474-8f6d-e6bb16e8f998@codeaurora.org>
 <5aea282d-6fc9-cd70-cec4-10f28aa819b9@codeaurora.org>
 <CAOZdJXUUWUWHzus+3sbEXbW_q92e+SSzTQJCqCyQp6Y6_HOo3g@mail.gmail.com>
 <CAPybu_3v6Y1Bs1+WQKFfdNmAFdBN6VJTDiCG1ApNVM2AWt4vjA@mail.gmail.com>
 <9df3f61f-ac54-f5b1-6b86-db539e07c5bd@kernel.org>
Message-ID: <c9600a0d-46a3-70df-816c-e7c7687f324b@kernel.org>
Date:   Sat, 29 Sep 2018 08:25:30 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <9df3f61f-ac54-f5b1-6b86-db539e07c5bd@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/29/18 8:21 AM, Timur Tabi wrote:
> 
>> Is it possible to access the hardware?
> 
> Linaro and some Linux OSVs should still have systems, but I usually just 
> ask Jeff to test code for me.

Alternatively, you can just add valid_mask support to your driver, and 
add a check to your get_direction() function to see if it ever is asked 
to access an invalid GPIO.

