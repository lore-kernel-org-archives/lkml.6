Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38849C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 13:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF56320881
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 13:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u/HvrrJ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF56320881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbeJPVhZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 17:37:25 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40123 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727184AbeJPVhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 17:37:25 -0400
Received: by mail-qt1-f193.google.com with SMTP id b4-v6so25662126qtc.7;
        Tue, 16 Oct 2018 06:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=M9dycd42PGFOISTabqMritBVE5msvKnotmVgEcbQBlE=;
        b=u/HvrrJ98TpAiU1kAtPcl7RykwImhMX98McNGkBOiiTghVvYC1u48wImEEKFKLwIbC
         EcsvUJ0FfbB+a3fdHl4PqFOKzGl2HvO41cYjl3JiYtQk2jPr3/TogxTDNoAKWtYRsNU4
         bNryOcN+99+30wzzG4d9HaOj0WWTlkCY34Y9DxziBQxGGJNA/pzRLULQDLA2cOXLpLr8
         skioi3m020YgdH16Rc1nYGU11Dk02lSApgU3lZ4pAWXMCtavHm1mcQigcMvRdt/UXJ8M
         gmYRpKbIbGgf6iIam2p7q+Z6fJCyBJLAxAIXttAv6MRr+4vJGC7txqSoUoKzH75F4Dn0
         YzxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M9dycd42PGFOISTabqMritBVE5msvKnotmVgEcbQBlE=;
        b=N9aVqg3mZ9bkyEAFMntmn2iT1C1A9VBSU2EhgrVmcUQnREr0uZ4haRwileaCDSbYwI
         9IelDdX4gN7jVo+ZsnuI4urL/7I3JazVjayw/HCf8skNWpVd+fesE8HSmoELqxchSTf/
         wGaaLSYmxLgPRGlWckW/c2b6heeFvjhjgLOxGJjA1R3eb0lQ9jKAPrMMWw6zv4YBqj/h
         DNbmQfxU1pVuhmyBVKO8ozo5D1cSPlllViWIffIw3JcEXV2+nxSq9zciwd+8aLY8I9RX
         f6z1lgymi9DTWxd65mdYeTYBpH0/cSPXozjKh8LGIFJbmgoZdBFZmqkMszQMrdi4O62p
         79lA==
X-Gm-Message-State: ABuFfoggBzyV+/cowyBaZmY7RwMYfd6qG0QLESRkT1w2FTffOB7nCSa1
        tb4p8mJDLNt1wXutvIFEv2U=
X-Google-Smtp-Source: ACcGV63POfK0n44lAy7+Fztx1FC/Kn869+zXr9nGDNUQM8nHFaOCCCkKrXvmzjmrSo+hJ2BmIwmPww==
X-Received: by 2002:ac8:22ed:: with SMTP id g42-v6mr21020042qta.105.1539697610280;
        Tue, 16 Oct 2018 06:46:50 -0700 (PDT)
Received: from localhost.localdomain ([168.194.160.110])
        by smtp.gmail.com with ESMTPSA id t188-v6sm7196991qkc.58.2018.10.16.06.46.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Oct 2018 06:46:48 -0700 (PDT)
Received: by localhost.localdomain (Postfix, from userid 1000)
        id 32F14180C52; Tue, 16 Oct 2018 10:46:46 -0300 (-03)
Date:   Tue, 16 Oct 2018 10:46:46 -0300
From:   Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To:     Neil Horman <nhorman@tuxdriver.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+c7dd55d7aec49d48e49a@syzkaller.appspotmail.com>,
        David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>, linux-sctp@vger.kernel.org,
        netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Vladislav Yasevich <vyasevich@gmail.com>
Subject: Re: KASAN: use-after-free Read in sctp_id2assoc
Message-ID: <20181016134646.GJ6634@localhost.localdomain>
References: <0000000000007e767d05776336da@google.com>
 <20181005145855.GB6761@localhost.localdomain>
 <CACT4Y+YVRWSF+VyoBB1vwDevt0gwZYz69bSAivmZDG6r4J-kaA@mail.gmail.com>
 <20181010181325.GD6761@localhost.localdomain>
 <CACT4Y+YYpjjvW-UCkHEXWZA50F==7JC1cnMvoAZHKmOqq=9vAw@mail.gmail.com>
 <20181010184011.GE6761@localhost.localdomain>
 <20181015112330.GA31030@hmswarspite.think-freely.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181015112330.GA31030@hmswarspite.think-freely.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 07:28:17AM -0400, Neil Horman wrote:
> On Wed, Oct 10, 2018 at 03:40:11PM -0300, Marcelo Ricardo Leitner wrote:
> > On Wed, Oct 10, 2018 at 08:28:22PM +0200, Dmitry Vyukov wrote:
> > > On Wed, Oct 10, 2018 at 8:13 PM, Marcelo Ricardo Leitner
> > > <marcelo.leitner@gmail.com> wrote:
> > > > On Wed, Oct 10, 2018 at 05:28:12PM +0200, Dmitry Vyukov wrote:
> > > >> On Fri, Oct 5, 2018 at 4:58 PM, Marcelo Ricardo Leitner
> > > >> <marcelo.leitner@gmail.com> wrote:
> > > >> > On Thu, Oct 04, 2018 at 01:48:03AM -0700, syzbot wrote:
> > > >> >> Hello,
> > > >> >>
> > > >> >> syzbot found the following crash on:
> > > >> >>
> > > >> >> HEAD commit:    4e6d47206c32 tls: Add support for inplace records encryption
> > > >> >> git tree:       net-next
> > > >> >> console output: https://syzkaller.appspot.com/x/log.txt?x=13834b81400000
> > > >> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=e569aa5632ebd436
> > > >> >> dashboard link: https://syzkaller.appspot.com/bug?extid=c7dd55d7aec49d48e49a
> > > >> >> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> > > >> >>
> > > >> >> Unfortunately, I don't have any reproducer for this crash yet.
> > > >> >>
> > > >> >> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > >> >> Reported-by: syzbot+c7dd55d7aec49d48e49a@syzkaller.appspotmail.com
> > > >> >>
> > > >> >> netlink: 'syz-executor1': attribute type 1 has an invalid length.
> > > >> >> ==================================================================
> > > >> >> BUG: KASAN: use-after-free in sctp_id2assoc+0x3a7/0x3e0
> > > >> >> net/sctp/socket.c:276
> > > >> >> Read of size 8 at addr ffff880195b3eb20 by task syz-executor2/15454
> > > >> >>
> > > >> >> CPU: 1 PID: 15454 Comm: syz-executor2 Not tainted 4.19.0-rc5+ #242
> > > >> >> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > > >> >> Google 01/01/2011
> > > >> >> Call Trace:
> > > >> >>  __dump_stack lib/dump_stack.c:77 [inline]
> > > >> >>  dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
> > > >> >>  print_address_description.cold.8+0x9/0x1ff mm/kasan/report.c:256
> > > >> >>  kasan_report_error mm/kasan/report.c:354 [inline]
> > > >> >>  kasan_report.cold.9+0x242/0x309 mm/kasan/report.c:412
> > > >> >>  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
> > > >> >>  sctp_id2assoc+0x3a7/0x3e0 net/sctp/socket.c:276
> > > >> >
> > > >> > I'm not seeing yet how this could happen.
> > > >> > All sockopts here are serialized by sock_lock.
> > > >> > do_peeloff here would create another socket, but the issue was
> > > >> > triggered before that.
> > > >> > The same function that freed this memory, also removes the entry from
> > > >> > idr mapping, so this entry shouldn't be there anymore.
> > > >> >
> > > >> > I have only two theories so far:
> > > >> > - an issue with IDR/RCU.
> > > >> > - something else happened that just the call stacks are not revealing.
> > > >>
> > > >> The "asoc->base.sk != sk" check after idr_find suggests that we don't
> > > >> actually know what sock it belongs to. And if we don't know then
> > > >
> > > > Right. The check is more because the IDR is global and not per socket
> > > > (and we don't want sockets accessing asocs from other sockets), and not
> > > > that the asoc may move to another socket in between, but it also
> > > > protects from such cases, yes.
> > > >
> > > >> locking this sock can't help keeping another sock association alive.
> > > >> Am I missing something obvious here? Should we take assoc ref while we
> > > >
> > > > Not sure. Maybe I am.  Thanks for looking into this, btw.
> > > >
> > > >> are still holding sctp_assocs_id_lock?
> > > >
> > > > Shouldn't be needed.
> > > >
> > > > Solely by the call stacks:
> > > > - we tried to establish a new asoc from a sctp_connect() call,
> > > >   blocking one.
> > > > - it slept waiting for the connect
> > > > - (something closed the asoc in between the sleeps, because it freed
> > > >   the asoc right when waking up on sctp_wait_for_connect())
> > > > - it freed the asoc after sleeping on it on sctp_wait_for_connect [A]
> > > > - another thread tried to peeloff that asoc [B]
> > > >
> > > > For [B] to access the asoc in question, it had to take the same sock
> > > > lock [A] had taken, and then the idr should not return an asoc in
> > > > sctp_i2asoc(). Note that we can't peeloff an asoc twice, thus why
> > > > the certainty here.
> > > >
> > > > If [B] actually kicked in before the sleep resumed, that should have
> > > > been fine because it took the same sock lock [A] would have to
> > > > re-take. In this case an asoc would have been returned by
> > > > sctp_id2asoc(), the asoc would have been moved to a new socket, but
> > > > all while holding the original socket sock lock.
> > > 
> > > But why A and B use the same lock?
> > > 
> > > sctp_assocs_id is global, so it contains asocs from all sockets, right?
> > > assoc id comes straight from userspaces.
> > > So isn't it possible that B uses completely different sock but passes
> > > assoc id from the A sock? Then B should find assoc in sctp_assocs_id,
> > > and at the point of "asoc->base.sk != sk" check the assoc can be
> > > already freed.
> > 
> > That explains it. Somehow I was thinking the issue was for reading
> > ->dead instead.  Now it's pretty clear. Then this should be the patch
> > we want. Can you please give it a spin? (only compile tested)
> > 
> > While holding the spinlock, an entry cannot be removed from the idr
> > and thus it cannot be freed. So even if the app uses an id from
> > another socket, it will still be there.
> > 
> > ---8<---
> > 
> > diff --git a/net/sctp/socket.c b/net/sctp/socket.c
> > index f73e9d38d5ba..a7722f43aa69 100644
> > --- a/net/sctp/socket.c
> > +++ b/net/sctp/socket.c
> > @@ -271,11 +271,10 @@ struct sctp_association *sctp_id2assoc(struct sock *sk, sctp_assoc_t id)
> >  
> >  	spin_lock_bh(&sctp_assocs_id_lock);
> >  	asoc = (struct sctp_association *)idr_find(&sctp_assocs_id, (int)id);
> > +	if (asoc && (asoc->base.sk != sk || asoc->base.dead))
> > +		asoc = NULL;
> >  	spin_unlock_bh(&sctp_assocs_id_lock);
> >  
> > -	if (!asoc || (asoc->base.sk != sk) || asoc->base.dead)
> > -		return NULL;
> > -
> >  	return asoc;
> >  }
> >  
> > 
> Marcello, can you post this with a proper changelog commit please?  Based on the
> bug report, and description of the problem, I think we can all agree this is a
> sane fix

Yes, in a few. The patch should be ready, but ahm.. I had destroyed by
test environment (disk failures). I'm seizing the moment to bring it
up.

Thanks,
  Marcelo

> 
> 
> Thanks
> Neil
> 
