Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E358C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 04:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4548320846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 04:28:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oGvFpzRh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4548320846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751648AbeFTE2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 00:28:55 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:39306 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750842AbeFTE2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 00:28:53 -0400
Received: by mail-pg0-f68.google.com with SMTP id w12-v6so860915pgc.6;
        Tue, 19 Jun 2018 21:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5XxPFcbufTiQQMxTgixuo/u0WlgPO3UZSe1lymGHCaA=;
        b=oGvFpzRh1JbWVsTYQXSzZ4TCjdRhu+8eXi7SiiMVIthWcJvCYEY+wRHpx1BXEO9KPr
         pKwzlM4Ocj/70YJUrkpKLOeXuI2YCz/tR+5hd6+XpGzEMpOnM0sMUPOQNkq4955It8Vi
         bZOykvqsk0Fk9rez6HN7fhXkmDM5R+AoDW7A29D8w5T2XCh6P90Lf8kISg+U6KWGMceB
         rRELcGZ1KkkEfehGERrfnLc+irrUKW8W6QqZOzSZSjLyBF8IdM6ffp7d1FlHSDc2cIxg
         4aWdXr9jdBbwpzZckqKko1bK/c2j18/2mthvKih4sQkCpzeVCn20j5Eu2DcDY0F/o7wN
         hVXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5XxPFcbufTiQQMxTgixuo/u0WlgPO3UZSe1lymGHCaA=;
        b=UhyEF9DWU6vTsWCu85+g+AK9KRu7KVOIvWba9PdsRAjC8oSEu+dAqjesAQXgBPlnC+
         K/7t+cWz0oycoSAQic1bKco/+aOpqArVHtOVTlloPZ+PE2fiqXyjaYu+w7MdbVqdsML5
         EkWl509Gb4XrS93jeHVT/hKXcnVjPABaHGrqtEJ2ZuRDtMMYWwJb3JYc7rZax0a9Y6Oh
         LY98gl3MHKX8MOpQD7/fuS0TKg3ussj03SOy5Jp9pCn/aXfzspg1F0kgz7uVdi1PRL/C
         wwTJ3fAGzXnDGz1JEp4uMFLNgHP63OcxZ/OKSsgBDcy4Oy2WLiTm2cv6mtLMNDF5GcRK
         q0Sg==
X-Gm-Message-State: APt69E2AkXCBiMZdoMQdrqw4M3EBoNRa9hlLyTshdUbw1G4ORv5jEezE
        czVU+ewssbrpTxNqP6+qMqc=
X-Google-Smtp-Source: ADUXVKLWNaT6yzCbhWEG+uV6IsqH0Zsz5lHog60pZPmXMMGXp4Fuf/7pU1JeG5+BvVNuiVL77yvx1Q==
X-Received: by 2002:aa7:83d1:: with SMTP id j17-v6mr21198679pfn.236.1529468932853;
        Tue, 19 Jun 2018 21:28:52 -0700 (PDT)
Received: from localhost ([110.70.59.159])
        by smtp.gmail.com with ESMTPSA id a10-v6sm1867725pfg.107.2018.06.19.21.28.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jun 2018 21:28:51 -0700 (PDT)
Date:   Wed, 20 Jun 2018 13:28:47 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        SergeySenozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC][PATCH 0/6] Use printk_safe context for TTY and UART port
 locks
Message-ID: <20180620042847.GH650@jagdpanzerIV>
References: <20180615093919.559-1-sergey.senozhatsky@gmail.com>
 <20180618143818.50b2f2f9@alans-desktop>
 <20180619005308.GA405@jagdpanzerIV>
 <20180619083021.4avsgvcqjrpkat6s@pathway.suse.cz>
 <CA+55aFz9aGc-vGvKv_ZR2W2ZkZNSZfOHa0m_MbGH_a=x8oAW5Q@mail.gmail.com>
 <20180620025050.GE650@jagdpanzerIV>
 <CA+55aFzC5=awDhzOy9u_2FNaQmRprUTxj_KV2xO+GnpNAFg8MQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFzC5=awDhzOy9u_2FNaQmRprUTxj_KV2xO+GnpNAFg8MQ@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (06/20/18 12:38), Linus Torvalds wrote:
> On Wed, Jun 20, 2018 at 11:50 AM Sergey Senozhatsky
> <sergey.senozhatsky.work@gmail.com> wrote:
> >
> > It's not UART on its own that immediately calls into printk(), that would
> > be trivial to fix, it's all those subsystems that serial console driver
> > can call into.
> 
> We already have the whole PRINTK_SAFE_CONTEXT_MASK model that only
> adds it to a secondary buffer if you get recursion.  Why isn't that
> triggering? That's the whole point of it.

This is exactly what I'm doing in my patch set.
PRINTK_SAFE_CONTEXT_MASK so far worked *one* way only: when we start
from printk.c

IOW:

      printk -> printk_safe_mask -> vsprinf -> printk

But we also can have printk-related deadlocks the *other* way
around. For instance:

      uart -> printk -> uart

printk_safe_mask is not triggering there because we don't use
printk_safe in uart / tty yet. And this is what I do in my
patch set - extend printk_safe usage.

The patch set does not add any _new_ locks or locking rules.
It just replaces the existing

		spin_lock(a)
with
		prinkt_safe_enter();
		spin_lock(a)

and
		spin_unlock(a)
with
		spin_unlock(a)
		printk_safe_exit();

and that's it.

So now we use printk_safe mechanism to avoid another bunch of
deadlock scenarious: which don't start from printk, but from
parts of the kernel which printk eventually calls.

	-ss
