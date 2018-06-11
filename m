Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id /1O2CCgxHlt1dAAAmS7hNA
	; Mon, 11 Jun 2018 08:24:09 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 6C872607BB; Mon, 11 Jun 2018 08:24:09 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j++xxqAC"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id DC99A60791;
	Mon, 11 Jun 2018 08:24:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DC99A60791
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932415AbeFKIYH (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 04:24:07 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:43899 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932250AbeFKIYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 04:24:05 -0400
Received: by mail-pl0-f68.google.com with SMTP id c41-v6so11887435plj.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 01:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QkwOdRXa54x0TBzS1g3OGHAdvKBdpAprApOFLeePv34=;
        b=j++xxqACUNGxYT4cWUObjf7zWxdP72ed7hG23rRE0mKLgSD8TwXdqvYu5lRcJ4CDrb
         r/WL1nbmnKVyskFT2CRPr6OVER+/jl8rIkbU763mRAmJRVZ8iw3z7dnmr/aHD+MUuZmA
         5aMsMGad414c2F5V18g7+cnIaiKFtzxcI9hNQME8O5lb25qAJUkXLXA1UPZX6+O4T2As
         iUygRLS29d0XfpEPWEvYChDpVArjNzhyUqWJpjxeaJxOSPwtn07mH/sguloiEZwk77Zj
         rsb8cs+4STOyqv+clwSqIFSuMNIjUl7nTk+WsCJy8PLoK7MFtqmaL3SoqSu8X6U2cTvF
         vHBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QkwOdRXa54x0TBzS1g3OGHAdvKBdpAprApOFLeePv34=;
        b=rFv05/B8iRRyVGWkNjcgtXaNBNwdH4lTFUkRDSUUbh19QlO7Act3x7juHxDzhpqQPA
         s0eIc9SaVnovTk7YYLFGmRQPHJ4qGN4jXkLLwSjNTsFXUvHQbiXzzDpsgV78v1OiLM6Y
         HUqeXG8mZbC0vCU3hgl5c9X2XlLTx5P1VIg8gnaDS6Gfx0fiWHRkedyS02QqHCKc9W1m
         6ghVWafu5bKfyH8YCrcgGYhypaow1LwZr3LCIQgDCLrChP8bWQ2MIg+UAx/nwhLRCU5h
         ffXpKWWMUZyh0NB8PbIIPF3m6TkEfFkTdfKUBOkpxDg4lj9ErtSfVTFxpG7bES9Ns1eB
         kSiA==
X-Gm-Message-State: APt69E3UZJVlxzSyearRxx2nvUhcvTIp+FzFca+5g6ALRQp8kHclKGoe
        +Gy0mkCSvXgY+M//fCALn2yauDe5IgHjs1rGPJvA/iP+
X-Google-Smtp-Source: ADUXVKKNiYY3mHAha/YaXGbvN6VoFGXvy5W8mxYT3+5UFjfzJi0w/ToC/YAM9NrNZOSKC7QipLg97ch0zzTD7SkQ1EQ=
X-Received: by 2002:a17:902:ab95:: with SMTP id f21-v6mr10310836plr.264.1528705444316;
 Mon, 11 Jun 2018 01:24:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:de2:0:0:0:0 with HTTP; Mon, 11 Jun 2018 01:23:43
 -0700 (PDT)
In-Reply-To: <1d8de494-0a52-33f5-4c8d-0ec08cfb101c@kernel.dk>
References: <CACT4Y+ZmRj61ia-WQBC=M72o=OZWk5LSnzf2qOEuOLHAa4do_A@mail.gmail.com>
 <1d8de494-0a52-33f5-4c8d-0ec08cfb101c@kernel.dk>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 11 Jun 2018 10:23:43 +0200
Message-ID: <CACT4Y+b3ZWfOEHdYPCtP3mULz+6PheWv1CRvEME4jcpbjiJirA@mail.gmail.com>
Subject: Re: mainline boot is broken: KASAN: use-after-free in blk_flush_complete_seq
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 9, 2018 at 2:33 PM, Jens Axboe <axboe@kernel.dk> wrote:
> On 6/9/18 3:34 AM, Dmitry Vyukov wrote:
>> Hi,
>>
>> Boot of mainline kernel is currently broken.
>> On commit 7d3bf613e99abbd96ac7b90ee3694a246c975021.
>> Config:
>> https://gist.githubusercontent.com/dvyukov/9f7f1fd9e477efd85b221b3a21036c20/raw/7c56ede0840494b26045976960866f2b265c6f64/gistfile1.txt
>> Should have been introduced very recently.
>
> Can you try the below?

Yes, this fixes the use-after-free:

Tested-by: Dmitry Vyukov <dvyukov@google.com>

>> You may need to also patch "umh: fix race condition", because that's
>> another boot crasher currently present in tree.
>
> Not sure that that refers to.


Currently there are 2 boot bugs present in upstream tree: this block
bug and an umh bug. I assumed that anybody who will be fixing the
block bug will want to first reproduce it and then test the fix
locally. But if one would try to do it, they will actually hit the umh
bug first. So I provided the fixing commit for the umh bug to simplify
things for whoever would be fixing this block bug.


> diff --git a/block/blk-flush.c b/block/blk-flush.c
> index 058abdb50f31..ce41f666de3e 100644
> --- a/block/blk-flush.c
> +++ b/block/blk-flush.c
> @@ -169,9 +169,11 @@ static bool blk_flush_complete_seq(struct request *rq,
>         struct request_queue *q = rq->q;
>         struct list_head *pending = &fq->flush_queue[fq->flush_pending_idx];
>         bool queued = false, kicked;
> +       unsigned int cmd_flags;
>
>         BUG_ON(rq->flush.seq & seq);
>         rq->flush.seq |= seq;
> +       cmd_flags = rq->cmd_flags;
>
>         if (likely(!error))
>                 seq = blk_flush_cur_seq(rq);
> @@ -212,7 +214,7 @@ static bool blk_flush_complete_seq(struct request *rq,
>                 BUG();
>         }
>
> -       kicked = blk_kick_flush(q, fq, rq->cmd_flags);
> +       kicked = blk_kick_flush(q, fq, cmd_flags);
>         return kicked | queued;
>  }
>
>
> --
> Jens Axboe
>
