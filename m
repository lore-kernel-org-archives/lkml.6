Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F0BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 00:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4918B22360
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 00:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="tinmC4P6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4918B22360
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731662AbeKNKwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 05:52:03 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:32942 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbeKNKwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 05:52:02 -0500
Received: by mail-pf1-f193.google.com with SMTP id v68-v6so6970960pfk.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 16:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6mILXThxmixLFoPClItbrpsJciAf9/SBDZQqR4fUTPs=;
        b=tinmC4P6HGy2ntOO1H8a+V0qLQHlxC5PlENZVJCXxhdGSFagmRqeAuVk32/2wi47/H
         8o0pNLEPVNbSed5Km71mO4bPXDGadUAywiXIR0ETpbLCkhmKlQ+LOZab1JZlS5O6TpEy
         BkfmOjlRdTQwYJmxB7G8FAwfTEGLwATs2jFZEHCVPxrt7qq7dBcfY0iIk+XLXoRJRCYe
         MEOPBk+C0XpGOJF07aoCE4gyEbWmjOHAxnf04hmvrrrsZ9k7+3BOTLSB44vJdY+Yn3+G
         fGQnKWOSfq4/Aa5WWIzR3LoueJDD3mhFhurl4Dq8rxUWoWj9w77htYe/WnXKULZ0gvhF
         Cptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6mILXThxmixLFoPClItbrpsJciAf9/SBDZQqR4fUTPs=;
        b=Vubgl68mSMr3mV9Jkc+Zq4oEPjNtd679bBPltc25Nuf41oKgEWpGzJJFajLR3gtB4U
         iubNa9ApZV3QKfYgEyJkywwgl39jE6Yp9h5BzCIj+mDIfw669iRt4L7c61/9I2J28TCS
         q2cAi1LpAslKUMowyDDodcoUlGYVuOfWK7TqTj3bciX6xrP9Wiw9+lstYtjujO3IUpb6
         NzgWHjgFZzzso8v77JTocEObnK5CUoF0/BKhP3eLszmnuR8r5/pDmmj/EhkndGq6uiF3
         p8W67g0l16+4Bajj+hMYTu3VN7dRRlfQS7S2LSSfFrFm0iNSyHTmq7o5smJuwxmViDBb
         987w==
X-Gm-Message-State: AGRZ1gJZZR6lwEaT1aHlGn1HEdwzPTrA2i4HlS8ybDT1qH1cE+Bdc5Z3
        z6Xbhu1L4ToiVEK7f+63kwnpPn0LN68=
X-Google-Smtp-Source: AJdET5dDe4lTfmv4iwA4hhbNObaZKVmB1va72HKOVwyT6KiQvUVQ0FWwJANSl7+cPVvWTLS6TzacfQ==
X-Received: by 2002:a62:1912:: with SMTP id 18-v6mr606983pfz.194.1542156671857;
        Tue, 13 Nov 2018 16:51:11 -0800 (PST)
Received: from ?IPv6:2620:10d:c081:1134::122f? ([2620:10d:c090:180::1:2c26])
        by smtp.gmail.com with ESMTPSA id u69sm10113899pfj.116.2018.11.13.16.51.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 16:51:10 -0800 (PST)
Subject: Re: [PATCH] nvme: utilize two queue maps, one for reads and one for
 writes
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20181114004148.GA29545@roeck-us.net>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f1e91342-2b04-6d9f-e77a-6e812c6888d0@kernel.dk>
Date:   Tue, 13 Nov 2018 17:51:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181114004148.GA29545@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/13/18 5:41 PM, Guenter Roeck wrote:
> Hi,
> 
> On Wed, Oct 31, 2018 at 08:36:31AM -0600, Jens Axboe wrote:
>> NVMe does round-robin between queues by default, which means that
>> sharing a queue map for both reads and writes can be problematic
>> in terms of read servicing. It's much easier to flood the queue
>> with writes and reduce the read servicing.
>>
>> Implement two queue maps, one for reads and one for writes. The
>> write queue count is configurable through the 'write_queues'
>> parameter.
>>
>> By default, we retain the previous behavior of having a single
>> queue set, shared between reads and writes. Setting 'write_queues'
>> to a non-zero value will create two queue sets, one for reads and
>> one for writes, the latter using the configurable number of
>> queues (hardware queue counts permitting).
>>
>> Reviewed-by: Hannes Reinecke <hare@suse.com>
>> Reviewed-by: Keith Busch <keith.busch@intel.com>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> This patch causes hangs when running recent versions of
> -next with several architectures; see the -next column at
> kerneltests.org/builders for details.  Bisect log below; this
> was run with qemu on alpha. Reverting this patch as well as
> "nvme: add separate poll queue map" fixes the problem.

I don't see anything related to what hung, the trace, and so on.
Can you clue me in? Where are the test results with dmesg?

How to reproduce?

-- 
Jens Axboe

