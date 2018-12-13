Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F076C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10259208E7
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aF99buAs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10259208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbeLMMnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 07:43:02 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41952 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728517AbeLMMnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 07:43:01 -0500
Received: by mail-pf1-f196.google.com with SMTP id b7so1065867pfi.8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 04:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cokMUSjaXVTUGpy8NwxScbE3lIt+5uVLrM/NqE1NG1Q=;
        b=aF99buAsAvC9We6fA/+iRcHTqWpcw0R6Xpxrx6k/Fyme3CGDclKtw98EIue3X0btFB
         lbLA5OxGYCworxKCABC18LMxk8KveK8LThAGpkNjJql8jtSjawOxzIUcaLp61Wz0XzeM
         b3uSfrH5jBt6Pd5CqU9bMeI1rI4UfjwF6debEeZ6296hE2hxNRn7KYyciv43jhSykchY
         YLXGWgIe/eprRiG/XSzfGAau5k9pjH3gJaQxGkaVLB7xXMeXn6yF3vLZQbmkH1QMjKgK
         7TPdSNqUSNQu+SA20UuCI62HlexbnPc8CTddRjDdfmUkjGcLlZQVBv2Iq8x5bBOTetWs
         FqXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cokMUSjaXVTUGpy8NwxScbE3lIt+5uVLrM/NqE1NG1Q=;
        b=DXYIoMQZVd89uHxilCNy30we95W12/pcv6SHbB85gwySpaVA5p2OSbTqkruTEME79S
         dpwhPTr3YeNc6Ps1DznYGQdvq+69AWhsTijfuJKbY8BUucGmJxYZADjyRZcwR9f+L1r8
         D7tWLAmsB50TxqzHJ+cDXOVrOVstoIyFU0j805xFCcslHMPc2mhX1mGzBZ8sc6xefVbH
         IWCdacqOm3KM5gey+sWW3+X5rlIDfmnkyKsPdW+ekDVn/GM4z1NCEVfb/QgNe6BO5cVo
         6pVM0QUo4Bcl95BL+KBPqUcs5Lss8sK5Ddh8jINdCscmlE76aE7HyXv75D7owc1nxwYG
         tzmw==
X-Gm-Message-State: AA+aEWYTU6YDQnWD2TPvqmW4D1N/ahXkI+qHCaZj5XmWWkFRZ7EwFSct
        mwx3f9ib08xSmo7rzXkQgxA=
X-Google-Smtp-Source: AFSGD/VxUtMB8gSzeXBYk7/hT2PJHn2EJL+Ruhrdprgydt40zKHRKFj/OWa/Vqy1GFo95LRnT6U1Qg==
X-Received: by 2002:a62:f5da:: with SMTP id b87mr24331020pfm.253.1544704979592;
        Thu, 13 Dec 2018 04:42:59 -0800 (PST)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id a17sm2417259pgm.26.2018.12.13.04.42.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Dec 2018 04:42:58 -0800 (PST)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Thu, 13 Dec 2018 21:42:55 +0900
To:     Petr Mladek <pmladek@suse.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Dmitry Vyukov <dvyukov@google.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: [PATCH] printk: Add caller information to printk() output.
Message-ID: <20181213124255.GB3053@tigerII.localdomain>
References: <20181130154024.ls3mntfdr4zvluub@pathway.suse.cz>
 <f224bd68-7394-ff70-cad6-d3fbbb3b5f7d@i-love.sakura.ne.jp>
 <20181203150603.cdqii263e4kmmibo@pathway.suse.cz>
 <b38c6957-c3c1-54fc-781e-06d7eed6a9b1@i-love.sakura.ne.jp>
 <20181204152724.ypk44mi4a56nrud4@pathway.suse.cz>
 <459018db-763b-9520-ead2-2c0d5975fbf3@i-love.sakura.ne.jp>
 <20181210130930.bas4fozjhe3dc5nu@pathway.suse.cz>
 <c5b5d660-d217-35f0-c4f1-7252367934d1@i-love.sakura.ne.jp>
 <e3f69846-ef08-c8f5-368f-4dada13c9970@i-love.sakura.ne.jp>
 <20181213121847.mwlr2vyv6qzclhk6@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181213121847.mwlr2vyv6qzclhk6@pathway.suse.cz>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (12/13/18 13:18), Petr Mladek wrote:
> > Sometimes we want to print a series of printk() messages to consoles
> > without being disturbed by concurrent printk() from interrupts and/or
> > other threads. But we can't enforce printk() callers to use their local
> > buffers because we need to ask them to make too much changes. Also, even
> > buffering up to one line inside printk() might cause failing to emit
> > an important clue under critical situation.
> > 
> > Therefore, instead of trying to help buffering, let's try to help
> > reconstructing messages by saving caller information as of calling
> > log_store() and adding it as "[T$thread_id]" or "[C$processor_id]"
> > upon printing to consoles.
> > 
> > Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> 
> The patch looks fine to me:
> 
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> 
> Sergey, would you mind to ack this patch as well?

Sure, Petr

Acked-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

> From my point of view, the patch is ready to go into
> linux-next. Well, I would prefer to keep it there one more
> release cycle.

No objections.

	-ss
