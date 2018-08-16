Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A622C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 20:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFC5F21477
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 20:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="jUaGwcGs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFC5F21477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbeHPXOt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 19:14:49 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:36070 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbeHPXOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 19:14:49 -0400
Received: by mail-io0-f196.google.com with SMTP id m4-v6so4946920iop.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 13:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=r68fp81UveCrVseP5WsDMBkHFOz4CEP2y7m6ApU/9c0=;
        b=jUaGwcGsnYk/GyTY+QOS/icqb27hptl8eY7+OGpjxNWBbbrx0teC6RkB7zS7Hb8J6R
         bdkTlnP0K5PGuD+an71SNHx/bVDzA0Jlsg3ajfuteqWzjYaeagGxQ6CkM+p8nSfVgfdh
         xhI9x4shtAWmdSHdM0tMTmfB9di43RqJK8K6oUS0+pivohIdJFSN4BghZkmOEuvaG1cd
         KY++BrzEZGr0LUasJKdEFmEDH245VoXGHBeoUdjkbt04tpOfCLom32qlRVy+V7CU7FGb
         X0sYGssXvzFQTGsj/gEHwfnmHqd9C27IXddDn6IHk8HHRap9/DVYhyvQKBkGgCg9Fx1a
         OaEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r68fp81UveCrVseP5WsDMBkHFOz4CEP2y7m6ApU/9c0=;
        b=IlkPnGEPEmc+iM2sqkMy7iDCp4DDJ7QoafCLPJKhQRZuVbTTL0tnsco878ewVZRq5t
         Unwm2QetgSk/IfY9EeTvIOGdhyrHcoffMqy+PFsuBQg4j5Zjuwv2VQbZM/h8bKwdXawW
         7z3rMcmROGDarLECEOzVo5KqPBj9o5MtnMrts9vRWEebbszhPw5YrGYs5km9KHKKzDmT
         21tr1+rmxzktRs0umwN6KYSLkReqNZj4v1/dqIJsItn240Ivxj7xjhi1xQF7v8KJJXIi
         4ViQGPBYIbcnyq+N6pILP0sC78IkOkp51fKTNcf86iADoWOUaxoZ+hBZ6odV9xRr4ajl
         vskw==
X-Gm-Message-State: AOUpUlHQwO44pGguXoYPMNyVHOwG7RSttr5qGtNXTtebAZf8HirChzPD
        9NpgkhYvjrLBl2Rydp+wPyORhw==
X-Google-Smtp-Source: AA+uWPyihayFJG3qs2ILlWlZVM31jXC8DLtJAhtwywkwzVjoaVF1qTAGYjHM8lAWajEuZkgwgF1cTQ==
X-Received: by 2002:a6b:294b:: with SMTP id p72-v6mr25794966iop.17.1534450459313;
        Thu, 16 Aug 2018 13:14:19 -0700 (PDT)
Received: from [192.168.1.212] (107.191.0.158.static.utbb.net. [107.191.0.158])
        by smtp.gmail.com with ESMTPSA id y15-v6sm243597ioy.18.2018.08.16.13.14.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Aug 2018 13:14:17 -0700 (PDT)
Subject: Re: [PATCH] tracing/blktrace: Fix to allow setting same value
To:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     linux-block@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>
References: <20180816160837.30cb63cf@gandalf.local.home>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <82cb73d7-38a9-5e73-cf80-ff0873253d9e@kernel.dk>
Date:   Thu, 16 Aug 2018 14:14:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180816160837.30cb63cf@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/16/18 2:08 PM, Steven Rostedt wrote:
> [
>   Jens, you want to take this one, or do you want me to?
> ]

I can queue it up - done. Thanks!

-- 
Jens Axboe

