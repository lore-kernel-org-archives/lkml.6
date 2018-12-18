Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C65CC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE788214C6
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:58:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tJVysAI4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbeLRI6i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 03:58:38 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34515 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbeLRI6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 03:58:38 -0500
Received: by mail-pg1-f195.google.com with SMTP id j10so6302336pga.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 00:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lJmPHhLH+Ak+LFpJlzS8oBULtOw4ewrmjWYAVhVAkJo=;
        b=tJVysAI4gJ/v1IMEd5ystfyTlf4yNtYDang8/Csx4A52Y8UulVhHHwp1sfCdztoxyM
         FlnpvymHv/i6G9IuIz60pdlT737t2UoF+agv+V/D9nB8tE+5v2WxFcyfuD53rqdqSrvQ
         pRHUEbU2JZU+uAiBWo5j+K9nzQasaSoxpkL50ONDGvlCx5+zYvB4S7iVpv3HDpau/5Ha
         RX2gHeIrTA41Ww93+g4e0hjG4SAb1vqb5FGHWQItRqWYxJYIOnOn+uEocQSvd19CkXS8
         bi2+8IUamS8pAgcOLdZtswWhvDRIS0xmBVHkwuv8U1aIRI1MdFl+Hg2/XPqruvEojBT/
         szrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lJmPHhLH+Ak+LFpJlzS8oBULtOw4ewrmjWYAVhVAkJo=;
        b=N2ME4mUBSTY1NHcBJBHbKUL96z1AuUQbVt3Af9HjVoRL3E8FgRXRq7+bXFqXClNG3G
         7aWzNwrAUGV7ouTwDwvrUg23qooaV054SK7gARIn+Bcmr4WfTubw8MNq7bqwUZqXthvf
         uAuo8bBsq+y5CC3YhKv1QIepevbQcNBgv4KI0KWfvhc2IakfLGkbPfDbw7AWKVuDGXXT
         b1pzimJKyh7vOmsKeoeM0PpbkvAQyv+dXZHT1ism5zxzYP6RMmiJfNCxfJ5w9JPhqass
         ZlgbaM+yolC047Onh8xYlfLKCsV5uT12vV5mYv5SryC5WcrJ9/uRxEvzBKYRqpqvUgQ9
         xNhQ==
X-Gm-Message-State: AA+aEWZHHFKwcj0/S+512zqgDk5yFDctWNTChTFUycne+US2m2MB46Az
        pr39t/CuGpifjGwRk3zcXN8=
X-Google-Smtp-Source: AFSGD/W8JaNDGUCKB2GFaf9rT+azqCWKHl1jDU5TM15/E8cQurh2ax0s9N0CXBKNV76vhoOrR189Yw==
X-Received: by 2002:a63:e74b:: with SMTP id j11mr4030185pgk.397.1545123517629;
        Tue, 18 Dec 2018 00:58:37 -0800 (PST)
Received: from localhost ([175.223.2.245])
        by smtp.gmail.com with ESMTPSA id v2sm20054911pgs.0.2018.12.18.00.58.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Dec 2018 00:58:36 -0800 (PST)
Date:   Tue, 18 Dec 2018 17:58:33 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: [PATCH] printk: Add caller information to printk() output.
Message-ID: <20181218085833.GA460@jagdpanzerIV>
References: <20181204152724.ypk44mi4a56nrud4@pathway.suse.cz>
 <459018db-763b-9520-ead2-2c0d5975fbf3@i-love.sakura.ne.jp>
 <20181210130930.bas4fozjhe3dc5nu@pathway.suse.cz>
 <c5b5d660-d217-35f0-c4f1-7252367934d1@i-love.sakura.ne.jp>
 <e3f69846-ef08-c8f5-368f-4dada13c9970@i-love.sakura.ne.jp>
 <20181213121847.mwlr2vyv6qzclhk6@pathway.suse.cz>
 <20181213124255.GB3053@tigerII.localdomain>
 <20181217145452.3kev4rmo2l5lt2qy@pathway.suse.cz>
 <93f19e57-5051-c67d-9af4-b17624062d44@i-love.sakura.ne.jp>
 <20181218083911.qxvlqlwlb4eye72x@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218083911.qxvlqlwlb4eye72x@pathway.suse.cz>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (12/18/18 09:39), Petr Mladek wrote:
>
> Sergey, are you okay with this squashed patch, please?
>

Yeah. There are several minor nitpicks, but here is my
Acked-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>


One final question - can syzbot folks confirm that the patch
helps? Just curious.

	-ss
