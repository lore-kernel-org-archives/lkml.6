Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B844C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 18:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBD472098A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 18:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FDxsqBIa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBD472098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbeJKBwG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 21:52:06 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:33946 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727219AbeJKBwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 21:52:05 -0400
Received: by mail-it1-f194.google.com with SMTP id l127-v6so16720701ith.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 11:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Z33oORL6dGlz1hAgvpezWEZKZKvuRO5QH4JW4LBgZmw=;
        b=FDxsqBIa7ovMy4MWwN4v0UTIUKtes5zHJVNLhMkIQ66U7n1DcwE44c2CbrkPoHQKxQ
         /XpddStkBzdvkZhFeygkJ78udgOrkiZoLh+fwq25FPzFE/0oM69HcQke8kFZMamqZGl2
         q09meN70KtjudhGfIVX3fZVD7dz562gtHSaIr9+GGhhcubifMmMJfMmUWIPcUEKDUUR+
         /dSWOM2atHR1iXrBYhH3bI/rDzySjgQRP1Oe5KX81hOw4DACL8U3HgFvBvUDoOO+JVeK
         KKL3m9D4htX1VONa5zotO38sAPfCIVJ+slcgx+r/ws7tvzdFdL2N0RAq3JvFR+RfNuL9
         pS5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Z33oORL6dGlz1hAgvpezWEZKZKvuRO5QH4JW4LBgZmw=;
        b=PonwEwzJFLVfupahkl3TmAKtHUse2ijj/vD+HFZaFfN7pNbxDo2TK4h1HjisNdlIZy
         q/hf7Vz6F7U2PW05yuADdgYhSovAdTb71VZtt0ml3i2e+5YmriZIiG5NOVa/mbV9Ey9S
         yLGBP//nFVDqumuGJK4rJsdBt34uFrm/dltZVjOJw90ectM3isUDnV5wK9o/78WQi0rX
         v+Ls+V+jQmlrYlRv8ef/advfXwjWTltvIk83RPi9s3+lMWZSdO1BSUq/a45dO67+MGIK
         oUMyy95cvKlsP9g4IcrRliKmKM9uNz83PqETy/TNhHdpKymAjDSL06x2XBEIQ+y7ycgZ
         LLjA==
X-Gm-Message-State: ABuFfohLF3iLkJx+7rHLEZ5Y872Y1SAQmiaD80HGgtsP19YoCl7nkkVf
        XIvwjPUGSnmgd3WRx/EyJezjD+KljLPhKXCuVsyx+Q==
X-Google-Smtp-Source: ACcGV60TkhOOdx0Uh87E50pW9GmlkQD+Ooz9GKXddbRCdKxz59WmWQRHp2+KBHtVFUOPvk4fEuChfkm0NYJuwNYv0+w=
X-Received: by 2002:a02:97c5:: with SMTP id v5-v6mr25226180jaj.72.1539196123394;
 Wed, 10 Oct 2018 11:28:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:1003:0:0:0:0:0 with HTTP; Wed, 10 Oct 2018 11:28:22
 -0700 (PDT)
In-Reply-To: <20181010181325.GD6761@localhost.localdomain>
References: <0000000000007e767d05776336da@google.com> <20181005145855.GB6761@localhost.localdomain>
 <CACT4Y+YVRWSF+VyoBB1vwDevt0gwZYz69bSAivmZDG6r4J-kaA@mail.gmail.com> <20181010181325.GD6761@localhost.localdomain>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 10 Oct 2018 20:28:22 +0200
Message-ID: <CACT4Y+YYpjjvW-UCkHEXWZA50F==7JC1cnMvoAZHKmOqq=9vAw@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in sctp_id2assoc
To:     Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc:     syzbot <syzbot+c7dd55d7aec49d48e49a@syzkaller.appspotmail.com>,
        David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>, linux-sctp@vger.kernel.org,
        netdev <netdev@vger.kernel.org>,
        Neil Horman <nhorman@tuxdriver.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Vladislav Yasevich <vyasevich@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 8:13 PM, Marcelo Ricardo Leitner
<marcelo.leitner@gmail.com> wrote:
> On Wed, Oct 10, 2018 at 05:28:12PM +0200, Dmitry Vyukov wrote:
>> On Fri, Oct 5, 2018 at 4:58 PM, Marcelo Ricardo Leitner
>> <marcelo.leitner@gmail.com> wrote:
>> > On Thu, Oct 04, 2018 at 01:48:03AM -0700, syzbot wrote:
>> >> Hello,
>> >>
>> >> syzbot found the following crash on:
>> >>
>> >> HEAD commit:    4e6d47206c32 tls: Add support for inplace records encryption
>> >> git tree:       net-next
>> >> console output: https://syzkaller.appspot.com/x/log.txt?x=13834b81400000
>> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=e569aa5632ebd436
>> >> dashboard link: https://syzkaller.appspot.com/bug?extid=c7dd55d7aec49d48e49a
>> >> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>> >>
>> >> Unfortunately, I don't have any reproducer for this crash yet.
>> >>
>> >> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> >> Reported-by: syzbot+c7dd55d7aec49d48e49a@syzkaller.appspotmail.com
>> >>
>> >> netlink: 'syz-executor1': attribute type 1 has an invalid length.
>> >> ==================================================================
>> >> BUG: KASAN: use-after-free in sctp_id2assoc+0x3a7/0x3e0
>> >> net/sctp/socket.c:276
>> >> Read of size 8 at addr ffff880195b3eb20 by task syz-executor2/15454
>> >>
>> >> CPU: 1 PID: 15454 Comm: syz-executor2 Not tainted 4.19.0-rc5+ #242
>> >> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
>> >> Google 01/01/2011
>> >> Call Trace:
>> >>  __dump_stack lib/dump_stack.c:77 [inline]
>> >>  dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
>> >>  print_address_description.cold.8+0x9/0x1ff mm/kasan/report.c:256
>> >>  kasan_report_error mm/kasan/report.c:354 [inline]
>> >>  kasan_report.cold.9+0x242/0x309 mm/kasan/report.c:412
>> >>  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
>> >>  sctp_id2assoc+0x3a7/0x3e0 net/sctp/socket.c:276
>> >
>> > I'm not seeing yet how this could happen.
>> > All sockopts here are serialized by sock_lock.
>> > do_peeloff here would create another socket, but the issue was
>> > triggered before that.
>> > The same function that freed this memory, also removes the entry from
>> > idr mapping, so this entry shouldn't be there anymore.
>> >
>> > I have only two theories so far:
>> > - an issue with IDR/RCU.
>> > - something else happened that just the call stacks are not revealing.
>>
>> The "asoc->base.sk != sk" check after idr_find suggests that we don't
>> actually know what sock it belongs to. And if we don't know then
>
> Right. The check is more because the IDR is global and not per socket
> (and we don't want sockets accessing asocs from other sockets), and not
> that the asoc may move to another socket in between, but it also
> protects from such cases, yes.
>
>> locking this sock can't help keeping another sock association alive.
>> Am I missing something obvious here? Should we take assoc ref while we
>
> Not sure. Maybe I am.  Thanks for looking into this, btw.
>
>> are still holding sctp_assocs_id_lock?
>
> Shouldn't be needed.
>
> Solely by the call stacks:
> - we tried to establish a new asoc from a sctp_connect() call,
>   blocking one.
> - it slept waiting for the connect
> - (something closed the asoc in between the sleeps, because it freed
>   the asoc right when waking up on sctp_wait_for_connect())
> - it freed the asoc after sleeping on it on sctp_wait_for_connect [A]
> - another thread tried to peeloff that asoc [B]
>
> For [B] to access the asoc in question, it had to take the same sock
> lock [A] had taken, and then the idr should not return an asoc in
> sctp_i2asoc(). Note that we can't peeloff an asoc twice, thus why
> the certainty here.
>
> If [B] actually kicked in before the sleep resumed, that should have
> been fine because it took the same sock lock [A] would have to
> re-take. In this case an asoc would have been returned by
> sctp_id2asoc(), the asoc would have been moved to a new socket, but
> all while holding the original socket sock lock.

But why A and B use the same lock?

sctp_assocs_id is global, so it contains asocs from all sockets, right?
assoc id comes straight from userspaces.
So isn't it possible that B uses completely different sock but passes
assoc id from the A sock? Then B should find assoc in sctp_assocs_id,
and at the point of "asoc->base.sk != sk" check the assoc can be
already freed.
