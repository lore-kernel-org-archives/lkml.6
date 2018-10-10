Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83562C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D2BA214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kSR85cXz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D2BA214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbeJJWFb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 18:05:31 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:54854 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbeJJWF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 18:05:29 -0400
Received: by mail-it1-f193.google.com with SMTP id l191-v6so8385330ita.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 07:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=eR5W3uCmNlJALvqBYS/2cb/UjVeU1vw7hwPFdeoRg2s=;
        b=kSR85cXz1P10ftc+WvqAgH02L2qwbn3mvmNR3YHJBxxfE6PmWOJd1A+fwG7pP8xX2f
         ZekF8LVcNUdN9ytiBYKWkmvYI+blwLrvxEgzvwCuTidpvXf8BYbRsxFERarexEIIh8lq
         yQoKtqRstN+Kqf7WysRbP+qBL95sd8k5p7C6l1lCcXHMwUqPKECg4uBjwjReDsPzgxLA
         NXDdXWuesKxrTjOjFWpDRUOYC1MrG2bDpjKvBYp0g5bGhVaeipkN8SRyaLO1gfTrPdy0
         T4SAlxjmCy74HBMM5JDu9yM/dcoiNAY3WrclyNOeaHOFlShzCSEHJjf+Z78XVuCVAHW6
         fx0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=eR5W3uCmNlJALvqBYS/2cb/UjVeU1vw7hwPFdeoRg2s=;
        b=Tr+kpdGzxVQ+vTQ4UR8cIy9+KkZUu9aG6gAZslOanDL+XrNCCHkxANNJMjLMpBDZgB
         SvXosq9STr9dnif8D+HVoclesBlMEult4Q6cpmXOK5voJXUdOaOzTF7V6Mz/6jJHqQeM
         AH/5eiZo0oox7q0WnBI5QcE8GaONM7B7f8pk+9dKfsT6cF0q19as4GfZiAl1fua2FQ5e
         0flaW+W8U5rFXO8MsRvMM4GCVt7NTD5QLRYeV0eU5w3ed9nDdRbbod74d6sEQZIiSF4p
         2EFkbdRJiVX3UCt2bitRGhrg+cTq7KC053r6//24793ghprYSbIt7gIc2iTPdzZbBwtP
         4isQ==
X-Gm-Message-State: ABuFfoghGJ1VJK7Z7RU7m/CZjsBCO3gKx8Vnjnqt2hUyair8jq1cwmQV
        aczgQfss/iPwwBT6F+i+w/BMggNIw9xkyAJCdKw3fQ==
X-Google-Smtp-Source: ACcGV62/3GYuQJDsccco+aU5u9Tw44KhkcWmqP0SCckgGHyRxCe2s8la/LkHYpK/7IucjcysPCfdeJLa1sCyoFC30Yg=
X-Received: by 2002:a24:f584:: with SMTP id k126-v6mr942113ith.166.1539182578626;
 Wed, 10 Oct 2018 07:42:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:1003:0:0:0:0:0 with HTTP; Wed, 10 Oct 2018 07:42:38
 -0700 (PDT)
In-Reply-To: <20181009020949.GA29622@nautica>
References: <000000000000ca61cd0571178677@google.com> <000000000000fddb150577c15af6@google.com>
 <20181009020949.GA29622@nautica>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 10 Oct 2018 16:42:38 +0200
Message-ID: <CACT4Y+b5GK0hXtCs-ZEz0XHPC4k+BWW9cPsQX-RdZKutMs2N8Q@mail.gmail.com>
Subject: Re: BUG: corrupted list in p9_read_work
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     syzbot <syzbot+2222c34dc40b515f30dc@syzkaller.appspotmail.com>,
        David Miller <davem@davemloft.net>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        netdev <netdev@vger.kernel.org>,
        Ron Minnich <rminnich@sandia.gov>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        v9fs-developer@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 9, 2018 at 4:09 AM, Dominique Martinet
<asmadeus@codewreck.org> wrote:
> syzbot wrote on Mon, Oct 08, 2018:
>> syzbot has found a reproducer for the following crash on:
>>
>> HEAD commit:    0854ba5ff5c9 Merge git://git.kernel.org/pub/scm/linux/kern..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=1514ec06400000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=88e9a8a39dc0be2d
>> dashboard link: https://syzkaller.appspot.com/bug?extid=2222c34dc40b515f30dc
>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10b91685400000
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+2222c34dc40b515f30dc@syzkaller.appspotmail.com
>>
>> list_del corruption, ffff88019ae36ee8->next is LIST_POISON1
>> (dead000000000100)
>> ------------[ cut here ]------------
>> [...]
>>  list_del include/linux/list.h:125 [inline]
>>  p9_read_work+0xab6/0x10e0 net/9p/trans_fd.c:379
>
> Hmm this looks very much like the report from
> syzbot+735d926e9d1317c3310c@syzkaller.appspotmail.com
> which should have been fixed by Tomas in 9f476d7c540cb
> ("net/9p/trans_fd.c: fix race by holding the lock")...
>
> It looks like another double list_del, looking at the code again there
> actually are other ways this could happen around connection errors.
> For example,
>  - p9_read_work receives something and lookup works... meanwhile
>  - p9_write_work fails to write and calls p9_conn_cancel, which deletes
> from the req_list without waiting for other works to finish (could also
> happen in p9_poll_mux)
>  - p9_read_work finishes processing the read and deletes from list again
>
> For this one the simplest fix would probably be to just not
> list_del/call p9_client_cb at all if m->r?req->status isn't
> REQ_STATUS_ERROR in p9_read_work after the "got new packet" debug print,
> and frankly I think that's saner so I'll send a patch shortly doing
> that, but I have zero confidence there aren't similar bugs around, the
> tcp code is so messy... Most of the syzbot reports recently have been
> around trans_fd which I don't think is used much in real life, and this
> is not really motivating (i.e. I think it would probably need a more
> extensive rewrite but nobody cares) :/
>
>
> Dmitry, on that note, do you think syzbot could possibly test other
> transports somehow? rdma or virtio cannot be faked as easily as passing
> a fd around, but I'd be very interested in seeing these flayed a bit.
>
> (I'm also curious what logic is used to generate the syz tests, the
> write$P9_Rxx replies have nothing to do with what the client would
> expect so it probably doesn't test very far; this test in particular
> does not even get past the initial P9_TVERSION that the client would
> expect immediately after mount, so it's basically only testing logic
> around packet handling on error... Or if we're accepting a RREADDIR in
> reply to TVERSION we have bigger problems, and now I'm looking at it I
> think we just might never check that....... I'll look at that for the
> next cycle)

Good question.

It's a mix of dumb and not-so-dumb.
First we have descriptions of kernel interface, here are 9p ones:
https://github.com/google/syzkaller/blob/master/sys/linux/9p.txt
These descriptions allows to generate primitively meaningful things
(e.g. proper struct layout). They also capture some interrelations
between calls. For example, you can see these "resource rfd9p" and
"resource wfd9p" at the top, these as "fd subtypes", and descriptions
capture what produces these resources as output and what consumes
these resources as input. For example, rfd9p is produced by pipe and
consumed by mount, so we know that these calls need to be called in
that order. But this does not work too well for, for example, 9p
message tags/types, because we don't know what exactly message type we
will read out and these tags expire after reply.

Second, syzkaller uses code coverage as guidance. So as soon as it
learns to do proper handshake, it sees new coverage and memorizes this
program as useful and tries to extend it more in future. Later it
learns how to create a single file, sees new coverage, memorizes, etc.
This allows it to incrementally build more and more complex programs
over time.

You can see current code coverage it achieved here (in cover column):
https://syzkaller.appspot.com/#managers
e.g. (note: 80MB file):
https://storage.googleapis.com/syzkaller/cover/ci-upstream-kasan-gce-root.html

As far as I see it did some non-trivial progress for 9p subsystem. I
don't know if it reached everything reachable or not, though.
