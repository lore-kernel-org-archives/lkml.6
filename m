Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40491ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 09:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05A7F20685
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 09:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ldLDYLYI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05A7F20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbeJaSoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 14:44:04 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:39513 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727519AbeJaSoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 14:44:04 -0400
Received: by mail-it1-f193.google.com with SMTP id m15so17396788itl.4
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 02:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=yc7OcjVCN36mTSpW0wy8KANsGpLY7gN1OYjTmjpUD7Y=;
        b=ldLDYLYIiAPx5vw1iehRiJx/sOVSROU8g3BAFvjHZvDD6hJBZKG193IzHKkApCA/6R
         vdIHIrgQ4j1vIYWHO2M1Uv4eIRcLoSWmGzEeXECYoqAN0ZaxT1H7YVK7YRJeqIG6UcG1
         w9rcacCv0N1mRRefPmHKWdxh4uJ1x0+4T+X7bBw9mfHxzkpZzKE5lZ+Zr8QXzX51hvUa
         6//cQLsUzrvBsC5xd8C1ojr141MURIYsu72XVAnwGz+BYmbCnBe/253Atf+C5BWwZulO
         odmR5tbGT7uZ3N36DJIDdlgmtHStSncPhS1kuzh3FzppaASwVqz5U/GOLTZIBMQLpJT3
         rfcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=yc7OcjVCN36mTSpW0wy8KANsGpLY7gN1OYjTmjpUD7Y=;
        b=ZxjP6aPP49SYzQrsq4sOCsE8lklXN7WbfiNFhDrhSRFozQSG+IYynvqSXbDfxeogCx
         In3z6+GZCHBMePXp50nXoGVS3ZFgwoh6K4jE99WOoZAt7cWfooz1KfJfwvKYcq320qjG
         ze+tIOiRaZr3tdT9QMQG4MvTlJIH7Ke5jBuHY0aGm/fvyWOqCIvCHm6mfqZRdPTWKxiC
         RL3C7vIvYhmNUz6fji42nMxA2NsaUo0FGGJsb81Vb/3ZF8cintsCeWxhsFBqNSjMOFZJ
         Yof5BDJxlFfaTuOOoKCjxfuraqT46I4gHGxTs/j2u9V/dRL3lOsvnt/mQT1C+wh03DLN
         KmbA==
X-Gm-Message-State: AGRZ1gJj1groANo1ythdTaRtJnJVABp8xLgKQgq6Og7Gg3iC01Ab/ikW
        1WQn3sGZB6ulnY4l6X8E+rid46i2JfeEgC4hOTKDSg==
X-Google-Smtp-Source: AJdET5eIp+jfEEGNjr/EEr9jM7aNvcWk6Z530gA57oXxGSfiNie+qKQBCnthkAMBvQDfIxwn7jmeQtQ2DMO94+oRUGQ=
X-Received: by 2002:a24:37ce:: with SMTP id r197-v6mr1426621itr.166.1540979200228;
 Wed, 31 Oct 2018 02:46:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:1003:0:0:0:0:0 with HTTP; Wed, 31 Oct 2018 02:46:19
 -0700 (PDT)
In-Reply-To: <20181031031842.GI10491@bombadil.infradead.org>
References: <000000000000c9000f05797370e4@google.com> <20181031031842.GI10491@bombadil.infradead.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 31 Oct 2018 10:46:19 +0100
Message-ID: <CACT4Y+YAUKABCr3T6ryPSR_wygCQ5ab=o-Ouv+D9zwdffFfiMA@mail.gmail.com>
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

On Wed, Oct 31, 2018 at 4:18 AM, Matthew Wilcox <willy@infradead.org> wrote:
> On Tue, Oct 30, 2018 at 08:00:03AM -0700, syzbot wrote:
>> syzbot found the following crash on:
>>
>> HEAD commit:    4b42745211af Merge tag 'armsoc-soc' of git://git.kernel.or..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=1187d06d400000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=93932074d01b4a5
>> dashboard link: https://syzkaller.appspot.com/bug?extid=4fd0c066d82852499145
>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>>
>> Unfortunately, I don't have any reproducer for this crash yet.
>
> Hmmpf.  Would have been nice if syzbot had caught this during its tests
> of the -next tree ...

What -next tree do you mean? If it satisfies the criteria we can add it:
https://github.com/google/syzkaller/issues/592
