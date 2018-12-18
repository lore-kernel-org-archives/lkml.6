Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C3DC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5EB0217D8
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:10:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qpOMFhV6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbeLRKKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 05:10:55 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46584 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbeLRKKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 05:10:55 -0500
Received: by mail-pg1-f193.google.com with SMTP id w7so7580271pgp.13
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 02:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SzTU5vMrJWnlVd50H6l6cJ3m7jhynoeNErsz6WGN+RE=;
        b=qpOMFhV6Y6Y9u0iF0BZShQ2KPRe12ku0S+fgfnOM0AvD9YNuqIDeEZ++LElreMYxkL
         GuV/4LJorOcGpOBq4ZB08zugxYvmmj93EGdPP+9rGThJE4CxS+f2IDjicoxVKSSuYCbc
         IvWQ7cz3tn5zLqpqPokAnOwcFSbes6tqcSs5A/1Pkw6bYor3Mw8o6AEUUShIWCvNbx8l
         rxO58XmktO220z2l0j1XXBbhzK7gpMedYZS8LoItj57k6igLAZr7opFRJPXi6z9+kG3w
         qC+yN/21aZguZ7i32VtuID+9t0ESo0HsM0ywerJbpnsLmTPPwO73+hhyyPu/l0ryybC5
         TKkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SzTU5vMrJWnlVd50H6l6cJ3m7jhynoeNErsz6WGN+RE=;
        b=uE7szj2h452QLtS62ZUJKdwGwTfJKwT7X5hp60m0k26pvsZGRtxubYXUZ7yFJZGq71
         P8/bKnIt2eBfUUW5K2cmydJfSno4X0V18bc97+YvVKlTC29mHsN2ZSfGUQKSx7DY5+7s
         MZhpmP78G7fO9Exh2Lk9rv1cjblC2R7yW3V+LIhivN2rRExteohq+b+TcFpbDxiR8Jcm
         sRvQ46xdd7L7iw6CougUOQi7YetscKw/awYlB0OZY10+oWpfzlH3OE/ohkWbbi1njbRa
         ndymw/AUcvLnM4+Cz1MXpUP46PvS2jDltpfbyFh8diW833DhG3xdxiynnoqgOcHTCIf/
         tiNg==
X-Gm-Message-State: AA+aEWY+gb5zKuZ9uudFHx2KLsbTr53idtBGh5rrf/xcDsqoiwcCZFTh
        tHucG6xoDb2EIl+fWraLvyvXYUGc
X-Google-Smtp-Source: AFSGD/VQx4y093kZ1XVtipXa34hR/iPvQo3wa2VSMNlOgSZ0XXQ58QJAGnu7J0F/rrzyfnqJ7NGLlg==
X-Received: by 2002:a63:a611:: with SMTP id t17mr14985012pge.338.1545127854606;
        Tue, 18 Dec 2018 02:10:54 -0800 (PST)
Received: from localhost ([175.223.2.245])
        by smtp.gmail.com with ESMTPSA id x2sm20514336pfx.78.2018.12.18.02.10.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Dec 2018 02:10:53 -0800 (PST)
Date:   Tue, 18 Dec 2018 19:10:50 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: [PATCH] printk: Add caller information to printk() output.
Message-ID: <20181218101050.GB460@jagdpanzerIV>
References: <459018db-763b-9520-ead2-2c0d5975fbf3@i-love.sakura.ne.jp>
 <20181210130930.bas4fozjhe3dc5nu@pathway.suse.cz>
 <c5b5d660-d217-35f0-c4f1-7252367934d1@i-love.sakura.ne.jp>
 <e3f69846-ef08-c8f5-368f-4dada13c9970@i-love.sakura.ne.jp>
 <20181213121847.mwlr2vyv6qzclhk6@pathway.suse.cz>
 <20181213124255.GB3053@tigerII.localdomain>
 <20181217145452.3kev4rmo2l5lt2qy@pathway.suse.cz>
 <93f19e57-5051-c67d-9af4-b17624062d44@i-love.sakura.ne.jp>
 <20181218085524.GA1047@jagdpanzerIV>
 <20181218100119.3lf5ktzqbqkwsfb2@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218100119.3lf5ktzqbqkwsfb2@pathway.suse.cz>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (12/18/18 11:01), Petr Mladek wrote:
> I have updated the patch in printk.git, for-4.22 branch.

Thanks.

> PS: I think that I have rushed the patch probably too much.
> I did too much nitpicking in the past and am trying to find
> a better balance now.

It's all good.

	-ss
