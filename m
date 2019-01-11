Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD56EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A479D218D4
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Ba0/9Wyt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388394AbfAKTeb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 14:34:31 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33653 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730371AbfAKTeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 14:34:31 -0500
Received: by mail-pf1-f193.google.com with SMTP id c123so7417543pfb.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 11:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=vJobNwacwqELFSn9sezgDxi723fb3GrAhFS+Ypv4NN0=;
        b=Ba0/9WytPW7bVkcWE8ZByDPjWX+8iuvKJ8Ll6FzmDBgj6GlssfqK8Rtn5Ib6+2Vjh8
         1dwseXgEvshMmw0Vz6Yg0ijhEObsrEdFKFdL7yPDKxhXEjhiM8kUQ+DVpa1WYRrHx0tC
         4tiB8cYT2JP5R50Y5k4GZ2QBNI/zQWk0ZgpazKIeyMBVk4QcIT6Q+b3BcapojBQaAi9i
         PerxhLbcjH2kYCSqKozP3CwRH1yknwqi4xbopth9XBH8hUWDux811FPFfBH2vSAOTi1a
         dtMwU/nx0bIz7N0duoK53NId5Ib7KkV60MUv8kwnMMyN0LLmeyY1db0uQbMMjvM5vB3q
         wnLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=vJobNwacwqELFSn9sezgDxi723fb3GrAhFS+Ypv4NN0=;
        b=rslIxFLTugljbis6AbDuxwv+2Pu7TFNEZ6D4/OCsvUZAWfM+o45AUs0jsKXg0PUg/s
         WyIvO8mONJ0zON8F7VAx4xDogNaFXgWe/06AMPa3CjDKcEu09V1GxZJa8lQuD930AiH0
         W7VXHlKYS6DScBne2/s4B/XJbZDC+875f4twrLjra4sbSzOUulmBPFHfvL0jF2xCB3nj
         Cc+CkPsLkbVz1KCklOeeoQs/WdITGQhOa84RwrRPBcFi27xxGobmpW89QjnGqc9TqK0z
         WG++EW5dXRTNWGlBqLXCaSjvxQGVmrfTFWWKMJOv0VlLJIBlYWzWg06p2CRbipKVx7Kh
         nlhw==
X-Gm-Message-State: AJcUukfB3CsrBxijXHUVm7HBVlAsvgQN4c5pkL/iwGNOrIkO/8eg9F44
        PzFhk5euB5/CGP/hh6vSqjFZGw==
X-Google-Smtp-Source: ALg8bN4x4AE2g1LcqhsOU54NrX74CWOz6J9XgXLTy6k+mS76NrnccRah4G9l5H0LAHlu/i7iO/DGnw==
X-Received: by 2002:a62:220d:: with SMTP id i13mr15707191pfi.162.1547235270148;
        Fri, 11 Jan 2019 11:34:30 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id 125sm102764027pfg.39.2019.01.11.11.34.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 11:34:29 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Dmitry Vyukov <dvyukov@google.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>,
        Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: [PATCH] printk: Add caller information to printk() output.
In-Reply-To: <CACT4Y+ZKR7eib+ZtK-7mbCw6rD6KOeuWtjWtxAcnHEWnYqyjJw@mail.gmail.com>
References: <20181204152724.ypk44mi4a56nrud4@pathway.suse.cz> <459018db-763b-9520-ead2-2c0d5975fbf3@i-love.sakura.ne.jp> <20181210130930.bas4fozjhe3dc5nu@pathway.suse.cz> <c5b5d660-d217-35f0-c4f1-7252367934d1@i-love.sakura.ne.jp> <e3f69846-ef08-c8f5-368f-4dada13c9970@i-love.sakura.ne.jp> <20181213121847.mwlr2vyv6qzclhk6@pathway.suse.cz> <20181213124255.GB3053@tigerII.localdomain> <20181217145452.3kev4rmo2l5lt2qy@pathway.suse.cz> <93f19e57-5051-c67d-9af4-b17624062d44@i-love.sakura.ne.jp> <20181218083911.qxvlqlwlb4eye72x@pathway.suse.cz> <20181218085833.GA460@jagdpanzerIV> <CACT4Y+ahbDb7F2B1-z5QxroZcqP+AEUfUi6Sa1ZHRpaCeVmZ=w@mail.gmail.com> <CACT4Y+ZKR7eib+ZtK-7mbCw6rD6KOeuWtjWtxAcnHEWnYqyjJw@mail.gmail.com>
Date:   Fri, 11 Jan 2019 11:34:28 -0800
Message-ID: <7h4lafng3f.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Vyukov <dvyukov@google.com> writes:

> On Wed, Jan 2, 2019 at 5:09 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>>
>> On Tue, Dec 18, 2018 at 9:58 AM Sergey Senozhatsky
>> <sergey.senozhatsky.work@gmail.com> wrote:
>> >
>> > On (12/18/18 09:39), Petr Mladek wrote:
>> > >
>> > > Sergey, are you okay with this squashed patch, please?
>> > >
>> >
>> > Yeah. There are several minor nitpicks, but here is my
>> > Acked-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
>> >
>> >
>> > One final question - can syzbot folks confirm that the patch
>> > helps? Just curious.
>>
>> This slip through the cracks. Tetsuo pinged me and I am testing now.
>> Need to create a set of tests and update parsing code to handle this.
>
> I've pushed support for CONFIG_PRINTK_CALLER to syzkaller/syzbot:
> https://github.com/google/syzkaller/commit/7da2392541a49c3f17b2e7d24e04b84d72b965fb
> Let's see what happens. Limited local testing shows that it's working
> as intended and significatly improves quality of reports and ability
> to make sense out of kernel output.
>
> Tetsuo, thanks for your great persistence with this change!
> Sergey, Petr, thanks for reviews!
>
> +Fengguang, Kevin, maybe you will find this useful for 0-day/kernel-ci.

Yes, will definitely give it a try.  

Kevin
