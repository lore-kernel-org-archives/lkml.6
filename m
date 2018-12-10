Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90741C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FAE62084E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="iXyAFh3E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FAE62084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbeLJVoo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 16:44:44 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35040 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbeLJVon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 16:44:43 -0500
Received: by mail-pf1-f196.google.com with SMTP id z9so6037996pfi.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 13:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Q/LNkITI6Mo00J9iVRX70fKCzr1sV4kHJirNir7Hw5E=;
        b=iXyAFh3E3oigxUa5uYeSGAQCGcrf13cPQEJBqIBuI9upstTBdM5bP2igSIoanHfjv2
         XZhpulwOxUuNq+Z5B2ZOQ6peURFOeItO3fOgBcjrN/4KwlHVHfgKG9YmAI0J6MabzxVg
         LKoags1R4zDMIxOkBWiBM18Vya7OdqSXHu1gJ2qtxTHxmMkxkWIyS7GxNA8HV4liqXPL
         SVKOtcr3EUlmJjYiZkNQnyAOmvSCpKZJ38o4Ee/X8OTDY+o9+BQ3svPe0cHYP1sYK/H8
         yYIKit/AoJ26+6d6teoCtl0I+mQowr3x0infaTdR7KAVXuRWGbWEpOslqdMZB25rGfq9
         bxuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Q/LNkITI6Mo00J9iVRX70fKCzr1sV4kHJirNir7Hw5E=;
        b=q3P0Kcd79CLXbWaKUpWNCDvHOl2jQ4xqn/dfbVWtMBlyPby7I7Oh+DQb4TcsW+tgcK
         bTYvbBXQxrIPCo4v+iM5MV4EYnhRTaP/47Tsfd8X+K2vHBm0LOrlRBiCc/PNAlb+V+O9
         UvL301T4HuM1+DUsdJnY3RVjeaZQ5Sxu2Pv0nUs+GjjL+O29YB+REtd9tBmL/heR/cnR
         zK7w5N5PpQldSjA7Xqz5cYacMPvfZ36ZMNgyR2caaRrYKJ9L+eB2p1V1HzpyqkmOgVvX
         vkRnbq2dIFd5dUxeintK7PyTv9V1m+wEqr9jEsC6c4MD/OEA/AI8KP2vxF+i96SV0vTW
         B/0w==
X-Gm-Message-State: AA+aEWaxfdvtldatG1j8nTb2ZDG+lGwdTkjqBo9MCHPOZpkxOrwJGvH9
        bxx0og60EvrwOvkNYp4KI9T/+V7xMrwbSw==
X-Google-Smtp-Source: AFSGD/VxET1oVt24BqIeyvVIB9B9KDrV/eZ1ANkti5jRWK7TaQob+R5u44BJACGZzOlho23GjXhRNg==
X-Received: by 2002:a63:bd1a:: with SMTP id a26mr12159678pgf.121.1544478282281;
        Mon, 10 Dec 2018 13:44:42 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id 64sm16187094pff.101.2018.12.10.13.44.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 13:44:41 -0800 (PST)
Subject: Re: [PATCH] mtip32xx: avoid using semaphores
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181210213459.1147671-1-arnd@arndb.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6caf6fa4-15e5-a7ec-cec4-69e5ad70c090@kernel.dk>
Date:   Mon, 10 Dec 2018 14:44:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181210213459.1147671-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/18 2:34 PM, Arnd Bergmann wrote:
> The "cmd_slot_unal" semaphore is never used in a blocking way
> but only as an atomic counter. Change the code to using
> atomic_dec_if_positive() as a better API.

Looks good to me. We should also convert the return to blk-mq
when we hit failure here to BLK_STS_DEV_RESOURCE, but that's
a separate patch.

-- 
Jens Axboe

