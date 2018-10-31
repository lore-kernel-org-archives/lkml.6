Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74449C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 19:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3681320657
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 19:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mg/K6Hj7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3681320657
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729558AbeKAEUa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 00:20:30 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:50423 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbeKAEUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 00:20:30 -0400
Received: by mail-it1-f196.google.com with SMTP id k206-v6so19942582ite.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 12:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Fd6T9C3R0pNUYJd462HlvlZHWLO/Na5uVyCVmRMPhyw=;
        b=Mg/K6Hj7s4zhvRcgZpwVJSBKyo9Vv/vC3p5sLp8pAPiVmZwni4D3IkwsDOlK/+zNUp
         LrM0Gneiw3P65ewUFjnDXFX56s6V2PhDSy2bmX8fxv23g4BvV3GI9HpSkMwbDXL7X0lf
         RfrqEpvarcEJ8nN0igrGerzn3i7e819V0m219oEJAoYILDMBt/IUsnupGJRYKSqHeBcM
         YwnI5Z2INfhtJTNCMs8TpZ8dY1VZbe0Wkd66qDqR9S1W8+ZZ+9ORbMa3pFqDz6uzHrBd
         O3h3k4Hzwwzz2FJnmHxSnuLSWB5r7hT9hl+2qPcxA3lGG3vu3+56WLyLWmsKx9naO32a
         4jMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Fd6T9C3R0pNUYJd462HlvlZHWLO/Na5uVyCVmRMPhyw=;
        b=AZBTxy5JgcfBDeHTKf37R0vrnYvxQ/v3G3ocf9QMc8GCHky64Dv2d705J0ZTfaZKBU
         E6LoDynM7dhTJOqtHWbuHUYaQoaKFLz9DPfsqhJzbcPTx9A7ZF9RntKzovFmTfhTrYnX
         iYRrKA87rFjPjpZLgyOjI3wVC6znwryPWLQi1vaBoueLSRd/FQl2lPjIvQfeyPg+uRR9
         FEXQ7eGXxmY6gfHBBt3egvHI3AFSusTIQ/ov9RzAowhGaAEh/wIVB/y9GDcqxMX8aIC6
         jfuxISXB7hmRX9fwze0/SYhhs0fEbf4D7hMWyMlBkAeAb5ZHnwFNwwvo6IgKsEYSA8th
         HGIw==
X-Gm-Message-State: AGRZ1gLKGTbwqJAicVdDr2inCqVy7+3/3T/kxEttcSSN5Wx5Jm4D70bZ
        CjWgYNVMf6Y1CBG1WOfvlEA7emmqNRtLPPaCBWXiig==
X-Google-Smtp-Source: AJdET5evtmn4G2HK/jf1JY3AEn5GyLMeAQ+In5ha97JMBcvpH0YidUkvLz8Stp9a5OH97SGhlvnzRdONJxz/JFY2QVM=
X-Received: by 2002:a24:940f:: with SMTP id j15-v6mr3153699ite.12.1541013665377;
 Wed, 31 Oct 2018 12:21:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:1003:0:0:0:0:0 with HTTP; Wed, 31 Oct 2018 12:20:44
 -0700 (PDT)
In-Reply-To: <20181031191827.GN10491@bombadil.infradead.org>
References: <000000000000c9000f05797370e4@google.com> <20181031031842.GI10491@bombadil.infradead.org>
 <CACT4Y+YAUKABCr3T6ryPSR_wygCQ5ab=o-Ouv+D9zwdffFfiMA@mail.gmail.com> <20181031191827.GN10491@bombadil.infradead.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 31 Oct 2018 20:20:44 +0100
Message-ID: <CACT4Y+Y1BFaasXeW_yKqXaoZJ3btFpFNV_WY5ZrU4rhPmZcyZg@mail.gmail.com>
Subject: Re: WARNING in get_unlocked_entry
To:     Matthew Wilcox <willy@infradead.org>
Cc:     syzbot <syzbot+4fd0c066d82852499145@syzkaller.appspotmail.com>,
        Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com, Al Viro <viro@zeniv.linux.org.uk>,
        zwisler@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 8:18 PM, Matthew Wilcox <willy@infradead.org> wrote:
> On Wed, Oct 31, 2018 at 10:46:19AM +0100, Dmitry Vyukov wrote:
>> On Wed, Oct 31, 2018 at 4:18 AM, Matthew Wilcox <willy@infradead.org> wrote:
>> > On Tue, Oct 30, 2018 at 08:00:03AM -0700, syzbot wrote:
>> >> syzbot found the following crash on:
>> >>
>> >> HEAD commit:    4b42745211af Merge tag 'armsoc-soc' of git://git.kernel.or..
>> >> git tree:       upstream
>> >> console output: https://syzkaller.appspot.com/x/log.txt?x=1187d06d400000
>> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=93932074d01b4a5
>> >> dashboard link: https://syzkaller.appspot.com/bug?extid=4fd0c066d82852499145
>> >> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>> >>
>> >> Unfortunately, I don't have any reproducer for this crash yet.
>> >
>> > Hmmpf.  Would have been nice if syzbot had caught this during its tests
>> > of the -next tree ...
>>
>> What -next tree do you mean? If it satisfies the criteria we can add it:
>> https://github.com/google/syzkaller/issues/592
>
> I meant linux-next, as in the merge of everybody's -next trees.  Reading
> that bug, it seems outside your scope for now ;-(


We do test linux-next:
https://syzkaller.appspot.com/#managers
But this crash happened only once across all trees and machines. So it
just looks too elusive (subtle race?) to be reliably spotted in
linux-next.
