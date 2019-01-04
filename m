Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D452C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 628D7218D8
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rp1XBAK8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbfADR0b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 12:26:31 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:36911 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbfADR03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 12:26:29 -0500
Received: by mail-it1-f195.google.com with SMTP id b5so2418019iti.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 09:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NUh97yTD4AeXCHDpYcM/SjNb50VxynL0Yg/zkOfIp9M=;
        b=Rp1XBAK8nuFMqxDDME5grrUUw5zz8MQJwSE/8YHLTzJ6i9oY6k9xN+2FFGtVep4KDe
         /4PDBUnrrO0C2zGwn0xRCvkqO6VL8iL/fryvpWxi/XCyJPqcT8eUrX/d4jD90FT9iAbZ
         zaIbyO1qe0WRNV/Gu+iNibHEDIruhysYoYVm/cX3CsKhFny7o+FBN1mo0JpCVTG1PPZr
         xbxGLgOKXWnAiJwVLu/VGdH3TXGYGKevTxCQ17yToMuCmstwVn15nGqH4ac9XTWXZ8n0
         iMyulOFJUcu/mgw5+x4anq8UM3rOa8us75VRax5w0SlT+g1Fdg+ZzfYrnft7CyTsmUYb
         S3qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NUh97yTD4AeXCHDpYcM/SjNb50VxynL0Yg/zkOfIp9M=;
        b=WvGe/tdVVbaHKlpWRIzjiFNyzMH8xcqbLEXwRcY2gRnDkBtnxBjaHsWuqdeLTVMaFF
         2rLVExIpO5XThIISGoEzz6GcUaQBI4hqIK1unvH0rEUL0xKQ6+hyQHzkTKKEFStH0cgR
         4o0u290jX9fO4jc4z8USlZ+i/Z1OnTPaFhDLwgYAWr54Ykw8jLnWVQvlKjnqrM4maCpO
         ngPWzBE+OB853YkXhLJRq5ThGSmtHQ1jB37zW6kmNVdC0Gx9cj9Z8WW6Tpyu0i3VAu7o
         jPW4p0sX/zDUVORjWSwMeXzPQyDqg59RGxswDqaeSjWP6LhIG4Eq3wFFBPfT7Hf1B3qU
         24gQ==
X-Gm-Message-State: AJcUukeSmETaMvakbGqYfO5vefRJAzvCWJnS/HHkme8ycSlP89myLOTH
        6UyFNs5x+PKB+wziqGEADYmW31PBj3WNiqSrhEX/UQ==
X-Google-Smtp-Source: ALg8bN75AB93HWYogBJPpx73XvcRNfMT/3+sFAbI18/OqhrCJ2d8K4QrRcR7+ryKBPwB0AOhahamxW3oW2KnF2cl5W4=
X-Received: by 2002:a05:660c:f94:: with SMTP id x20mr1339124itl.144.1546622787618;
 Fri, 04 Jan 2019 09:26:27 -0800 (PST)
MIME-Version: 1.0
References: <000000000000513fb7057e8d7013@google.com> <f2e566ac-5c4c-11ae-d436-ebb3522a2195@gmail.com>
 <20190103210743.6518841e@redhat.com> <CA+FuTScFwA3F44MvbaWrOYJ2EYgdKAmoMzEGjOLcz3ZPVQLLDA@mail.gmail.com>
 <20190103225404.66b0ec9f@redhat.com> <CACT4Y+aAofhchOpKTjLGGkQb5PAa74Uyp7kowdSoAwt130ZpAg@mail.gmail.com>
 <20190104115435.478b4b4a@redhat.com> <CACT4Y+bRLOVCx9Z=vCMspjzGrcnNFqNGWxDwiwYZbw2LTh__FA@mail.gmail.com>
 <20190104181424.5ad4b1de@redhat.com>
In-Reply-To: <20190104181424.5ad4b1de@redhat.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 4 Jan 2019 18:26:16 +0100
Message-ID: <CACT4Y+bq+X6UFTWmbGz1V0GAjPXizxfk_pLqcq8KkDkp3K-ERg@mail.gmail.com>
Subject: Re: kernel panic: stack is corrupted in udp4_lib_lookup2
To:     Stefano Brivio <sbrivio@redhat.com>
Cc:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot <syzbot+4ad25edc7a33e4ab91e0@syzkaller.appspotmail.com>,
        David Miller <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 4, 2019 at 6:14 PM Stefano Brivio <sbrivio@redhat.com> wrote:
>
> On Fri, 4 Jan 2019 12:05:04 +0100
> Dmitry Vyukov <dvyukov@google.com> wrote:
>
> > On Fri, Jan 4, 2019 at 11:54 AM Stefano Brivio <sbrivio@redhat.com> wrote:
> > >
> > > On Fri, 4 Jan 2019 11:32:12 +0100
> > > Dmitry Vyukov <dvyukov@google.com> wrote:
> > >
> > > > On Thu, Jan 3, 2019 at 10:54 PM Stefano Brivio <sbrivio@redhat.com> wrote:
> > > > >
> > > > > On Thu, 3 Jan 2019 15:15:06 -0600
> > > > > Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:
> > > > >
> > > > > > syzbot generated stack traces with
> > > > > >
> > > > > > [  183.517380]  udpv6_err+0x46/0x60
> > > > > > [  183.520739]  ? __udp6_lib_err+0x1890/0x1890
> > > > > > [  183.525054]  gue6_err_proto_handler+0x199/0x280
> > > > >
> > > > > Where? I can't find that in any logs linked from the dashboard at
> > > > > https://syzkaller.appspot.com/bug?extid=4ad25edc7a33e4ab91e0 :(
> > > >
> > > > Stefano, there are these 4 bugs reported that have similarly looking
> > > > reproducers involving udp sockets and that crash modes that looks like
> > > > stack corruption/overflow:
> > > >
> > > > https://syzkaller.appspot.com/bug?extid=14005fa30c9a07192934
> > > > https://syzkaller.appspot.com/bug?extid=d14090007dc9ba5fa9b7
> > > > https://syzkaller.appspot.com/bug?extid=137ed32ec9a6d5b0d5fe
> > > > https://syzkaller.appspot.com/bug?id=d5bc3e0c66d200d72216ab343a67c4327e4a3452
> > > >
> > > > Are these the same bug as this?
> > >
> > > Judging from the reproducers for the first three, they seem to be.
> >
> > OK, then I will mark them as dups of this one.
>
> syzbot just finished the tests I requested and couldn't reproduce the
> first three issues with the fix I posted (fou6: Prevent unbounded
> recursion in GUE error handler).
>
> This should prove they are in fact the same issue.
>
> > > I
> > > guess I can trigger tests also for those by sending a (sharp)syz
> > > test ... e-mail with the patch to the Reported-by: addresses, right?
> >
> > Correct.
> > These should be on LKML, but as you noted you can just add the syzbot
> > email with tag to TO/CC. That email is available in the Reported-by
> > tag (and also shown on the dashboard).
>
> Okay, thanks for confirming.
>
> > > And the three reports you pointed out from the pile of corrupted
> > > reports also seem to match, others look unrelated.
> >
> > I've added these as tests:
> >
> > https://github.com/google/syzkaller/blob/master/pkg/report/testdata/linux/report/341
> > https://github.com/google/syzkaller/blob/master/pkg/report/testdata/linux/report/342
> > https://github.com/google/syzkaller/blob/master/pkg/report/testdata/linux/report/343
> > https://github.com/google/syzkaller/blob/master/pkg/report/testdata/linux/report/344
> >
> > Will try to figure out how to distinguish them from true corrupted
> > reports. Usually when Call Trace does not have any frames, it's a sign
> > of a corrupted report, and in other crashes we see the same report but
> > with a stack trace. But some stack-corruption-related reliably don't
> > have stack traces (not corrupted). But then some other
> > stack-corruption-related crashes do have stack traces, and for these
> > no stack trace again means a corrupted kernel output. Amusingly this
> > is one of the most complex parts of syzkaller.
>
> I'm not sure how complicated that would be, but what about some metric
> based on valid symbol names being reported?

Please elaborate. What do you mean by "valid symbol names"?

Note that corrupted output detection solves 2 problems:
1. Do we think the output is truncated to the point of being not useful?
E.g. sometimes kernel produces just 1 line:

general protection fault: 0000 [#1] PREEMPT SMP KASAN

This is sure a crash, but it's not too useful to report.

2. Do we have any reasons to think we extracted bogus crash identity?
E.g. crash intermixed with output from another thread so that we say
"something-bad in function foo", when in fact function foo come from
output of the second non-crashing thread.
