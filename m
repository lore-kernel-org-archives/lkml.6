Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01684FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 14:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A576D20873
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 14:28:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="qAbOWtWp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A576D20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731934AbeG3QEH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 12:04:07 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:35156 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbeG3QEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 12:04:07 -0400
Received: by mail-it0-f65.google.com with SMTP id q20-v6so17121427ith.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 07:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BNdRZVElpzXsW9acgApNR9BIIO0xrEbZFL1v4NTR/0U=;
        b=qAbOWtWpT4vWnR3qHPPcKjhKxs7ZbKIkIEyh135o3eJjvlvxF/OaaS/LsYSCH7n6Dg
         ejlGUZmupCBpyF8pnm0izZOPve10rdM0fyr6RfxzL1vwQPgAvOKkvNmfJfU9zPIFxeIr
         rlS0tfnLAh8IhMa6PbSdwYuT12ZAnO0gzPI9omAQcl4gZkznqsrg0Gvn68l5/8Tx8pVE
         oemXxzix3C2dNAYHy8IkUiDE/QAlXUSEXRHjluZe2twFGZt8Uq+v3R8k0H2t2TalR5AA
         aFz8p8WWq9DMKmOjZBYNXOTRHRE+MLw7ZnhWantC6UjhwLk2jnjQw9AXrF20Mznpv4jV
         nTeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BNdRZVElpzXsW9acgApNR9BIIO0xrEbZFL1v4NTR/0U=;
        b=PIt6PQox11uHcOEYhxh9Q0weha/qPItCqDwrbgReo3B3lXiRPL7Tgz1ILWnZd2QXBT
         EhFEFOeEPl/qC5eeFZXzn0pYXJWLLAc5rcFixIi7WxpzGv3SBl6s0zEjujf0hmtnfS8x
         7JjcO7jGIcAQB3FrZA1BLzhstXLQilNk9OOqGbQeqCt5AP5p/XGVlkGn6GJ91LGDn5C8
         yy/1UGA5zUqnRhxWShyDo5B7MAq1Y4ZZvZ4SvkUZJyee52ViDPC1v9Zz6E2msxTITli3
         KAle18Bgga5wt3enJj2Ulg1cC0VbEZH1gZfFo81mTdVqcc0A+pjeEdSN+XT+GINxsfpS
         O5Iw==
X-Gm-Message-State: AOUpUlHj1bWLleWukTVusWyb8Nb5UfJCTnCKP8XjMbXO5xMeYJcxHRt2
        CRQZqJ1B8q8RWIWgQnT9ZJPgyA==
X-Google-Smtp-Source: AAOMgpe/IwGpfjqXryZoS2Vu9ZKwMwVfbDVLzUCqgVtbqBwSwq03QUrhHRWtyC8qmw5WBXqKk14Bvw==
X-Received: by 2002:a24:3b0e:: with SMTP id c14-v6mr15270862ita.42.1532960932218;
        Mon, 30 Jul 2018 07:28:52 -0700 (PDT)
Received: from [192.168.1.212] (107.191.0.158.static.utbb.net. [107.191.0.158])
        by smtp.gmail.com with ESMTPSA id v5-v6sm5960556ite.20.2018.07.30.07.28.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jul 2018 07:28:51 -0700 (PDT)
Subject: Re: [PATCH] block: blk_init_allocated_queue() set q->fq as NULL in
 the fail case
To:     xiao jin <jin.xiao@intel.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     tom.leiming@gmail.com, bart.vanassche@wdc.com,
        stable@vger.kernel.org, yanmin.zhang@intel.com,
        Ming Lei <ming.lei@redhat.com>
References: <1532931072-5190-1-git-send-email-jin.xiao@intel.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0bd7c6a3-4c55-d2f4-9b48-01f3898891b8@kernel.dk>
Date:   Mon, 30 Jul 2018 08:28:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <1532931072-5190-1-git-send-email-jin.xiao@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/30/18 12:11 AM, xiao jin wrote:
> We find the memory use-after-free issue in __blk_drain_queue()
> on the kernel 4.14. After read the latest kernel 4.18-rc6 we
> think it has the same problem.
> 
> Memory is allocated for q->fq in the blk_init_allocated_queue().
> If the elevator init function called with error return, it will
> run into the fail case to free the q->fq.
> 
> Then the __blk_drain_queue() uses the same memory after the free
> of the q->fq, it will lead to the unpredictable event.
> 
> The patch is to set q->fq as NULL in the fail case of
> blk_init_allocated_queue().

Applied, thanks.

-- 
Jens Axboe

