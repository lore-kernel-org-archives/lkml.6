Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA20C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 18:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDD932184B
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 18:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vjCsaGYq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732121AbfACS16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 13:27:58 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:50499 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731932AbfACS1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 13:27:54 -0500
Received: by mail-it1-f195.google.com with SMTP id z7so46546958iti.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 10:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R9DiAGdyfuhA7D/JWWmEJya2gLJZpZRx2G9bT+Z1w/4=;
        b=vjCsaGYqXd2rCILY+pZAiYxUUaTuU2UBkzcsJv8jdWnPrOqtymVhOVIMY6Ke6/RgcW
         jTVicPHwKuwO3VNjmIu/tT8SUSXcKcSk0grKqhvrCOqOyQ0Oqmm1Vyk4OGbuT30RAqci
         /lK1q40kzkTMxKZbeOIK1gzkW1VPQMrgPE2nV2efONcD8EB77UAeed/HxxkIUy0ASdl7
         Q+OSbAS59a6bY/nDpwc2WK+rpjoi6xHIVCOZZ/KcqG6De1WnJ3Zt67KafJA/DEnCVVqT
         /hzr+lYksUNz9n8H/BjUsmeWI16dSt3IWa8i7fOg9xXz9xPArBXBTDHiOIdr7JDlRAdC
         09Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R9DiAGdyfuhA7D/JWWmEJya2gLJZpZRx2G9bT+Z1w/4=;
        b=nBi+buVo1m9tVhFJO+cbZ6o8EpqT4dak8YcEXdRzJI16Jnpn/UojOeXcUZ4PPoFs02
         +bj3GAf4J0JrIRS80lFc8WYFaIdcJHd/tuIJSPSemW+YpJ3LqLhfhuAGn40590ObYpOc
         Jq+Lq/7ycOIuWb7g2WjJL7VhgpQUX9xLnlch0oWsaOpf7y98lHYdaZ3dEV2q1Pp/2nhZ
         IAusYwE1Z16Vxlf3wlkTPymc6EgcALyVA0hJSSejQCbtmiP48VimUcjeUU9YG2N6GDK5
         6RqOhv8v9WPl3oNhgJC6SGRLedMQNUp9tfSM0Hu024567caLohDXt1bqqi5O9wyUIkvF
         jDGw==
X-Gm-Message-State: AJcUukd4cL6ImMhta4bYmXi/EFCebWiMPPlo+GlaNrAVU/xYgXFut8zl
        l/I+sp97tlDCtr6qMGtWTJrtOhXfNaO65LBbQe0n3IG4BpQ=
X-Google-Smtp-Source: ALg8bN7I7c0tH/v8N98oA2iVL6/nCz6M2Me2b9koCtifH4Dq5fOzoFumOvjTuznxNH0uT+8XmV513Haj1DgcwHFFHtI=
X-Received: by 2002:a02:97a2:: with SMTP id s31mr19309106jaj.82.1546540073372;
 Thu, 03 Jan 2019 10:27:53 -0800 (PST)
MIME-Version: 1.0
References: <20181204152724.ypk44mi4a56nrud4@pathway.suse.cz>
 <459018db-763b-9520-ead2-2c0d5975fbf3@i-love.sakura.ne.jp>
 <20181210130930.bas4fozjhe3dc5nu@pathway.suse.cz> <c5b5d660-d217-35f0-c4f1-7252367934d1@i-love.sakura.ne.jp>
 <e3f69846-ef08-c8f5-368f-4dada13c9970@i-love.sakura.ne.jp>
 <20181213121847.mwlr2vyv6qzclhk6@pathway.suse.cz> <20181213124255.GB3053@tigerII.localdomain>
 <20181217145452.3kev4rmo2l5lt2qy@pathway.suse.cz> <93f19e57-5051-c67d-9af4-b17624062d44@i-love.sakura.ne.jp>
 <20181218083911.qxvlqlwlb4eye72x@pathway.suse.cz> <20181218085833.GA460@jagdpanzerIV>
 <CACT4Y+ahbDb7F2B1-z5QxroZcqP+AEUfUi6Sa1ZHRpaCeVmZ=w@mail.gmail.com>
In-Reply-To: <CACT4Y+ahbDb7F2B1-z5QxroZcqP+AEUfUi6Sa1ZHRpaCeVmZ=w@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 3 Jan 2019 19:27:41 +0100
Message-ID: <CACT4Y+ZKR7eib+ZtK-7mbCw6rD6KOeuWtjWtxAcnHEWnYqyjJw@mail.gmail.com>
Subject: Re: [PATCH] printk: Add caller information to printk() output.
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Kevin Hilman <khilman@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 2, 2019 at 5:09 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Tue, Dec 18, 2018 at 9:58 AM Sergey Senozhatsky
> <sergey.senozhatsky.work@gmail.com> wrote:
> >
> > On (12/18/18 09:39), Petr Mladek wrote:
> > >
> > > Sergey, are you okay with this squashed patch, please?
> > >
> >
> > Yeah. There are several minor nitpicks, but here is my
> > Acked-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> >
> >
> > One final question - can syzbot folks confirm that the patch
> > helps? Just curious.
>
> This slip through the cracks. Tetsuo pinged me and I am testing now.
> Need to create a set of tests and update parsing code to handle this.

I've pushed support for CONFIG_PRINTK_CALLER to syzkaller/syzbot:
https://github.com/google/syzkaller/commit/7da2392541a49c3f17b2e7d24e04b84d72b965fb
Let's see what happens. Limited local testing shows that it's working
as intended and significatly improves quality of reports and ability
to make sense out of kernel output.

Tetsuo, thanks for your great persistence with this change!
Sergey, Petr, thanks for reviews!

+Fengguang, Kevin, maybe you will find this useful for 0-day/kernel-ci.
