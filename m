Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF063C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70C8A2082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DaxGoBt0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70C8A2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbeLELur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 06:50:47 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34468 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbeLELuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 06:50:46 -0500
Received: by mail-pg1-f194.google.com with SMTP id 17so8933772pgg.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 03:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vGeHgbEb+BAfqlNbbaLVtju6ge1Ninqvx0B71hWJkMM=;
        b=DaxGoBt0ikoEufZuygoCcyjT7PykHW0iYhDmStAYW7GYGKR5ymnG3WYEUoCuAoUB08
         1sWx23Wk06Vyhx1exPhuwHCEIvpvSpDgLSpCE9tACXW5iUBM31+PqTe8R86aPV2WgVjT
         tyNooI9cVUgxNcz7bdsyD3DpXNc8vrq0s3rpzB0WuVv2rt/VDEFDfLd6zBw9tDYWKBLW
         +si5c34Gq40TtEGfCx1mDG9rfXuJ0GV0QKB++fzBzjC87+u1EQ+3NUMW81LFbzIjndM2
         AHRijEFt6Fc1/LgSNQ0DQNgo3oXfkUVWREqQuaj5ZNf25JeFaHitMURxWo1Hj9Obq6fZ
         zCfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vGeHgbEb+BAfqlNbbaLVtju6ge1Ninqvx0B71hWJkMM=;
        b=B1Bb5IZHELa/1MhYtB7tRTjIKd79T1+Pv1DefRpCN3awOYlLnNCIQNIKzsXDOBDdQe
         /74Aca+feqbzEkaTcbirca1112y2fUffxS8KdjumuKcz+aNeV1Ph380USm9yHiPj8noA
         i5ECddXnWOYZccMHe4tiTyZnIJzVqDuz1R8IBPaQHLwXV0FFR5oVglc/lGqiiO22dPaa
         YW3hVXK12b21BbOlUvYYGecE8YvvbUEJnuDARarnS5M9HQp9XfI4dGmCpQRQcJzNagFJ
         OCrZTMg6An3QU/AGJrE+tyNmj8BYbeISYi9qmDB/jjtwheLnQiV7P0scB/TnpF+WjexR
         PVUg==
X-Gm-Message-State: AA+aEWZsFXAYO2ygOTUH3s3tgNarN7w2RDFuPkdjodfHGkBWjjgI6ZMZ
        HYeJJwJCbKDKe7g+IVcpzTk=
X-Google-Smtp-Source: AFSGD/WygGEnhk3yL2BqMyp44kOf+LG/75Tw2Qmli6O4LhDyfOwTlWIkX8AvqfGYRo1WBms5SORs7w==
X-Received: by 2002:a62:7892:: with SMTP id t140mr23915208pfc.237.1544010645779;
        Wed, 05 Dec 2018 03:50:45 -0800 (PST)
Received: from localhost ([110.70.47.191])
        by smtp.gmail.com with ESMTPSA id v184sm24886454pfb.182.2018.12.05.03.50.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 03:50:44 -0800 (PST)
Date:   Wed, 5 Dec 2018 20:50:41 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Petr Mladek <pmladek@suse.com>, Dmitry Vyukov <dvyukov@google.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: [PATCH] printk: Add caller information to printk() output.
Message-ID: <20181205115041.GB453@jagdpanzerIV>
References: <1543045075-3008-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20181130154024.ls3mntfdr4zvluub@pathway.suse.cz>
 <f224bd68-7394-ff70-cad6-d3fbbb3b5f7d@i-love.sakura.ne.jp>
 <20181203150603.cdqii263e4kmmibo@pathway.suse.cz>
 <b38c6957-c3c1-54fc-781e-06d7eed6a9b1@i-love.sakura.ne.jp>
 <20181204152724.ypk44mi4a56nrud4@pathway.suse.cz>
 <459018db-763b-9520-ead2-2c0d5975fbf3@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <459018db-763b-9520-ead2-2c0d5975fbf3@i-love.sakura.ne.jp>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (12/05/18 19:42), Tetsuo Handa wrote:
> >>
> >> PID_MAX_LIMIT is 4194304, which can take up to 10 bytes if [T%u] is used.
> > 
> > 4194304 is the worst case. I would use the same approach as with the
> > timestamp seconds. It uses 5 characters as the minimum. But it might
> > eventully get bigger.
> > 
> > IMHO, [T%5u] looks like a reasonable default.
> > 
> 
> While "%5lu.%06lu" for uptime does not decrease over time (and hence changing
> to "%lu.%06lu" does not cause wavy output), "[%6s]" for T$thread_id will cause
> wavy output after PID reached 100000. Isn't it hard to parse after all?

100000 is a lot. So I'd say we are fine.

A side note:

Do we need PIDs at all?
PIDs don't tell that much. When you are grepping serial log you can't
actually tell if PID 15000 there and PID 15000 here, 200000 log lines
apart, are same processes; or did PIDs wrap around? And you probably
don't even care. All you need is a way to reconstruct a message around
some very specific place in the log - say in a range [-500, +500] lines,
assuming that a backtrace you are trying to reconstruct is badly fragmented.
I think, even 3 lower digits of a PID should do the trick.

	-ss
