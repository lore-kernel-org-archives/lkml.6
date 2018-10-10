Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B17C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 11:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D670B214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 11:31:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WCBz3Tq8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D670B214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbeJJSxQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 14:53:16 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38805 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbeJJSxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 14:53:15 -0400
Received: by mail-pl1-f195.google.com with SMTP id b5-v6so2408371plr.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 04:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gha6wpi/f3e9MshDSFDvCXHZRWMC1m7RO4ossY+4h2U=;
        b=WCBz3Tq8c7r/oy73JbDzaY2/jjjXIVh8n7mGFwnBolvbWnjBOH2F1K3UQ6fcLpUaJT
         CQAq7JDrF18ksubZl3uCcqpddAJ6OzX68x44hNNwgnSBmPpY0yi0yGjufxcp0myuMx23
         0040to0Ss5DM82Oig7hBAQpqATuQonVDY5iU585MDmyxiqnKQCCpbaLdi49IOq28VYRM
         buEZkbDFoS3SrqQOwZ8M+0jSGMxeJZTt2eIu3U09ICe3ZH+yqL65yxM81mfGW0O76L3m
         z98BibzYmcDAMgWJBqXV5SLXW8HAekVlKvUI/G9ZPr+9xSWI/2e5d1qwadwlji2RZ9ds
         mCQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gha6wpi/f3e9MshDSFDvCXHZRWMC1m7RO4ossY+4h2U=;
        b=YC9b9rloZUTHmWdA2kEH6i7xyDnrejqyIt03s6raEMHRMZK/yBHC6F7ahp8Y8iFjg3
         D4fu++m4TM6s3+1Elq5lDB8D6GYsOba65+5tz+fBrYfF09BbyUFpp3v5+p3fys19fUzD
         izlo1GB66EZ5WgsPalayu7kdgjT1fhHYjzfuCcbWTVvp0IW5leBhAuq9QCgsX1e3ZGLQ
         Fwj5hZSUx8rWSpkw6EBk0mTF296QnKYfjnLJc8T/lmnF+uKmDDn2w92FDStMeDjV3yWP
         Td7JjEkZ9p0cRO1bIeX6QoyB5MjYvMCPcdir7x52xgQXFNvU8sY3EnYm1aZ143nb+2sI
         FW9g==
X-Gm-Message-State: ABuFfogFKAdY9wDrr8EX6ZcFVsBe7UGQfdPXEPHd6nO6lEaN2LfHfdJE
        xEPX4ERxFEX2c11fO11c9tM=
X-Google-Smtp-Source: ACcGV616Ji/cuhx/xwqa53wGZT9btc9pBL7EQiT9PmZI088sF/Y06wr2e6tmlcdvlLijWM0R6t7I+w==
X-Received: by 2002:a17:902:8e81:: with SMTP id bg1-v6mr33056631plb.129.1539171091936;
        Wed, 10 Oct 2018 04:31:31 -0700 (PDT)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id p1-v6sm39819801pfj.72.2018.10.10.04.31.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 04:31:31 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Wed, 10 Oct 2018 20:31:20 +0900
To:     Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH] printk: fix integer overflow in setup_log_buf()
Message-ID: <20181010113120.GA3949@tigerII.localdomain>
References: <20181010103808.882-1-sergey.senozhatsky@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181010103808.882-1-sergey.senozhatsky@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (10/10/18 19:38), Sergey Senozhatsky wrote:
> The way we calculate free logbuf free space percentage
> overflows signed integer:
> 
> 	int free;
> 
> 	free = __LOG_BUF_LEN - log_next_idx;
> 	pr_info("early log buf free: %u(%u%%)\n",
> 		free, (free * 100) / __LOG_BUF_LEN);
> 
> We support LOG_BUF_LEN of up to 2G, since setup_log_buf() is called
> during early init logbuf is mostly empty, so
> 
> 	__LOG_BUF_LEN - log_next_idx
> 
> is close to 2G. When we multiply it by 100, we overflow signed
> integer value range.

I'm really sorry. The commit message got totally messed up here.
What I meant was 1<<25. I used 2G as a boot param for testing to
set up a proper new_log_buf_len value. And somehow got confused,
I was in a hurry. I'll send a follow up with fixed commit message.

	-ss
