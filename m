Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E3EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2624D20870
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L6sYfpnD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2624D20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbeJJVwS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 17:52:18 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:40590 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbeJJVwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 17:52:17 -0400
Received: by mail-io1-f66.google.com with SMTP id w16-v6so4007814iom.7
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 07:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=996gmTE0ugPjw74D9Crx0L4633ih1R/lkntcI+8aC0g=;
        b=L6sYfpnD7mGDA/vviIkSWT0y9SyjMZil1tHSayXtiR7fXrW7dmMGtKdZu3QEOF6Jku
         5HdhIu8xJsqOChgT3T4Z0FgcjMFeLqKEm4HCjQcI8vFmXJetVp+Zl/KjaSjHGwPtpHnm
         vDAP62AfbCB8KDZX+qKn3xIeBjjgIlTDFWQ90DXkBA4FLnkZK38p6S0EGuRWzXTo5fkz
         CuU3NKYAu56B4iSF+UTiyvwEL+fYkg705y2G2rW2qEYHraUOs7HEIO4ZD4S2W2RjOXvI
         RFQ17L2f46N4pHNt4T94NOB2rSkVAsk2EUExYY5mxaE8FtDzgRhF2CKR/8+vEIBZ0A+U
         r84Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=996gmTE0ugPjw74D9Crx0L4633ih1R/lkntcI+8aC0g=;
        b=rDDJ3YzR+AGZAzjXt532q/6Ih0cqgQRuBY6COgQm356PrkXw7nbKGR0Osxv/c1mmoP
         mNYCaKC8wYgXoqtc9P/02lr4uXLenLBEZfUv7+rpdqq6X61A5VEIUODifEFDFwtA5i4P
         Eaci5UCMl6ZpcprKJGqsIrdzv1vg2W9aDqBYAFiSXfDKcQ1iLxcJhHzrhvndrKYcZlD3
         Nx0vanXZu8QpOuYKXSJKRGp906E0W+iEvHJI31d0U6v0YpEWBYUBDqIXWW0teRrcsFmD
         ZcrxJVZ1+ZE3O3UXH0t1lERW/yzU6rRXWctJGf94nOXOK4Nqi0X6Ur3p83fciuMRpulh
         GUBg==
X-Gm-Message-State: ABuFfohVOdrAA+zXTgoCGN3vhIW2kxrTET1qIQDoEIHqIp5dFoBXwsuj
        jlHE8BpIPDeakcyJLHKW7/ddKavBmKNLgWoypghFeg==
X-Google-Smtp-Source: ACcGV61WDPRT+6Gs7OETwLDyHDo6+4ATzKodXnUjQI41jQEoly+xoJ0W92ptOjYFNsAzabmWOfllzclJK0TH+ciLku0=
X-Received: by 2002:a6b:8b97:: with SMTP id n145-v6mr16477900iod.282.1539181790647;
 Wed, 10 Oct 2018 07:29:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:1003:0:0:0:0:0 with HTTP; Wed, 10 Oct 2018 07:29:29
 -0700 (PDT)
In-Reply-To: <20181009020949.GA29622@nautica>
References: <000000000000ca61cd0571178677@google.com> <000000000000fddb150577c15af6@google.com>
 <20181009020949.GA29622@nautica>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 10 Oct 2018 16:29:29 +0200
Message-ID: <CACT4Y+Y0JS17HaC8u6f2jz_wSuLnSTbUrGmMpN+fH2FT3H2cYQ@mail.gmail.com>
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
>
>
> Back to the current patch, since as I said I am not confident this is a
> good enough fix for the current bug, will I get notified if the bug
> happens again once the patch hits linux-next with the Reported-by tag ?
> (I don't have the setup necessary to run a syz repro as there is no C
> repro, and won't have much time to do that setup sorry)

Yes, the bug will be reported again if it still happens after the
patch is merged (not just into linux-next, but into all tested trees,
but it does not matter much). So marking bugs as fixed tentatively is
fine if that's our best guess.

But note that syzbot can test fixes itself on request. It boils down
to just giving it the patch and the base tree:
https://github.com/google/syzkaller/blob/master/docs/syzbot.md#testing-patches
