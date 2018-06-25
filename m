Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 035F3C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1150256DC
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nslDUAlp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1150256DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754815AbeFYJgl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 05:36:41 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:43586 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754133AbeFYJgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 05:36:39 -0400
Received: by mail-pf0-f196.google.com with SMTP id y8-v6so6184956pfm.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 02:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=n6pIFX+OJhUEAUPB2vuFxGL0MHNyhePs+lQpf/znwNI=;
        b=nslDUAlplNVbRekvatx3QFrI1toKo+HwHIaeMTSTEE12Rx7y05ZHHF0C1q+wqD19NC
         GR/5LRunm1bJWt6bbWt6bDQmV5D3o5szlI685+V4SfaSbw1JZ03OJwjSgF1tobSVStbJ
         iB+m1u6250n0kxrddtCTaqrh8s12pN/dJtsJvqO+gy/M7xFwNWrn9xPEDDVvQKqwCujJ
         hKRC0M4Xh9kHWsA0QShxhjhEJMugQYweJ13vlnpakQNiQ/H0MlBxXtMAn9fZFOpuf4bh
         An0K+j9Ao34kMev7JSFeCDqXHmGKO3g1GcAjtSnCwZjez07CgiUjtrCJB99ZM0ITH3fw
         COHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=n6pIFX+OJhUEAUPB2vuFxGL0MHNyhePs+lQpf/znwNI=;
        b=Ip8NPZxmEzGbJquuyvUyfFA7ItXU6aqtWjIWzX6XVwJykrIDidAcskTe9gMOUot0K5
         GIY2Sy/HWJbHBkN3CiCWKd5bI0kWvzfPhPtb4sv/35/eJu8qghEb4b3ZQUqTxywjY91r
         OmnV5IKGeHhCsjJdjeLFfyehBdndMRI41fb5ie8TL4rf1W3QNfdrUiko2/arlLDKW+AD
         s64fxu9G6Mpj9r4vYcvop+1v/FX566CRbv5TQTGn3rIkqmWbWvBiAhvqjxbPiTaqS1/B
         lg+T8bJlZQXnhStP0Rrcaciq+JjxUbJda8bFrWxtvvgn5F/3vhJ9FVHKGkRbSteWGTGc
         SPvA==
X-Gm-Message-State: APt69E0AhlC396wIYb6/kMAjYXg5dU+hR3YbZbEHMbB4Lm7LsC7m9uDW
        x1H4mmqWeZ0cRnlSZFiCOHj1sK/9p5+vx/d0rDUAAw==
X-Google-Smtp-Source: ADUXVKLuQASARGs8JCAK6EVwWBehAGdH/qjMhWkcuDSZrLaQY9bkVLx1IUs6GFQV2RVgJRb/P4LBoDOX6cYhy1rX6RE=
X-Received: by 2002:a65:4bcd:: with SMTP id p13-v6mr10114809pgr.114.1529919398219;
 Mon, 25 Jun 2018 02:36:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:de2:0:0:0:0 with HTTP; Mon, 25 Jun 2018 02:36:17
 -0700 (PDT)
In-Reply-To: <20180625014122.GB557@jagdpanzerIV>
References: <CACT4Y+ZGSefrYL9xtQs=yPMRNFsOUumuJXsShJPhCOBSLySxuw@mail.gmail.com>
 <20180620083126.GA477@jagdpanzerIV> <CACT4Y+YMubTm1xduj+XCbQnNwQxYFLjBT33cFKisN1HyeaBpZw@mail.gmail.com>
 <20180620090413.GA444@jagdpanzerIV> <20180620091541.GB444@jagdpanzerIV>
 <CACT4Y+bcp4fSBBq3F86T-C4+n-YkeXUGMqpvkJ6vj6mK-TU2EA@mail.gmail.com>
 <20180620110759.GD444@jagdpanzerIV> <CACT4Y+aER3O2x2ApM=MVFoFXhp_T_rUeyG9CBx031qyH0voSRg@mail.gmail.com>
 <20180620130628.GA1000@tigerII.localdomain> <197be25e-c841-bf3c-7081-61f0a9653c8c@i-love.sakura.ne.jp>
 <20180625014122.GB557@jagdpanzerIV>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 25 Jun 2018 11:36:17 +0200
Message-ID: <CACT4Y+YXRD1RCV4jFyEaCOB8D17j3+bXG9qXJ5XrcmsznjidRg@mail.gmail.com>
Subject: Re: [PATCH] printk: inject caller information into the body of message
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Petr Mladek <pmladek@suse.com>,
        syzkaller <syzkaller@googlegroups.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 3:41 AM, Sergey Senozhatsky
<sergey.senozhatsky.work@gmail.com> wrote:
> On (06/22/18 22:06), Tetsuo Handa wrote:
>> >
>> > Awesome. If you and Fengguang can combine forces and lead the
>> > whole thing towards "we couldn't care of pr_cont() less", it
>> > would be really huuuuuge. Go for it!
>>
>> Can't we have seq_printf()-like one which flushes automatically upon seeing '\n'
>> or buffer full? Printing memory information is using a lot of pr_cont(), even in
>> function names (e.g. http://lkml.kernel.org/r/20180622083949.GR10465@dhcp22.suse.cz ).
>> Since OOM killer code is serialized by oom_lock, we can use static buffer for
>> OOM killer messages.
>
> I'm not the right guy to answer this question. Sorry. We need to Cc MM
> people on this.
>
> Does OOM's pr_cont() usage cause too much disturbance to syzkaller? I thought
> that OOM was slightly out of sight.

Hard to tell. Nothing specific comes to mind.
We do see lines like these:

BUG: unable to handle kernel [ 110.NUM] device gre0 entered promiscuous mode
BUG:--------[ cut here ]------------

and frequently it's also required to look deep inside of crash message
to understand what they really mean. Hard to tell how random pr_cont's
contribute to the problem. We now throw away everything that looks any
corrupted right away.
I guess the main requirement is that the crash report itself does not
use pr_cont and provided we have task/cpu context we can separate the
crash report lines from everything else (assuming that random
pr_cont's on other CPUs won't glue to the report lines).
