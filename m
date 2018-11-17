Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5414C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 17:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9646206BA
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 17:08:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LUyFr4Ao"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9646206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbeKRDZu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 22:25:50 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:32873 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbeKRDZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 22:25:49 -0500
Received: by mail-it1-f193.google.com with SMTP id p11-v6so3707810itf.0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Nov 2018 09:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CDqdlSL6KoZFanLKVwab8Fjpukx8HPVhW+/WPj417mk=;
        b=LUyFr4AoYvJLDzqkMEoWXmZXEMwR85hvZuAW8GAqnBl/7ybnEQFE1HjnYAbJK3Qhmq
         2JiMzwFR3H9msbOgTRAdMNnD2jPWRfH168IozA1mgRo7nCoB7fFcoX7V2kapxvK2i8Te
         iAF7FaF46KVryIF5A2MOja8UVrh/W34PYP5/9/mxET/0xgIVsit4zkypEMS7o1k/B4vA
         gxDyI0JjxLzyWY3yIDQ8uShIzlJuz9Pqw+/UpzDasrBfuUywgz+bJya/G5HToPK6DLh3
         sePuxIQi/Rr62vvieJ4agM57QKyay0eifoeTVRh8zX6SadZYo8pEjFJ9KqL7QtanXAOX
         48mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CDqdlSL6KoZFanLKVwab8Fjpukx8HPVhW+/WPj417mk=;
        b=gfa8btBzDnWY7xEgJD0uG6ag44McQsiz4lI56S3wWzDMdqLHgxX+hPC3ZjN9TsFDyq
         g9TAIKrjj3YAHaKJ3Y8pEkwM/+LW0kXjbJ2SwSLhu6I++afo4JKXFclCpCh4xsKitHo2
         7Be9rQMuoTlbUrs75ys3kwxHQv0dVeEv6MbAFf7ScMrwNrnc5U9bme43y7RqsvEOC5vK
         8YhrgUcb+e+XMlv6kzFc4Hf4wU6PWpsI8Utt7k73Z2z/6/svKujltHeoKA8mhLV89naS
         yieAJvCPnXFwRo5cHtG6NlYLSB52HURvAucnKe3NIf5TgJTnMyRrje1ThcPXHkod7UKy
         +vQg==
X-Gm-Message-State: AGRZ1gIfgr8inGRVZt+OtPTv2qQgFNbdtBKudcbqKuZRzMVc+khnBf0o
        gPXbj1HXgBZwIO8pra0AzPXM9iCQXyAO+9j/XtLcCg==
X-Google-Smtp-Source: AJdET5eMznpnE15zN+eSjOIO2or+JRkUtt107NzwsMHbjkQRehZCzBCGwJk1tcAuHQjLMbF7RzEiTIvEmFrCpbrcusg=
X-Received: by 2002:a02:6004:: with SMTP id i4-v6mr13096423jac.72.1542474510304;
 Sat, 17 Nov 2018 09:08:30 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a02:b003:0:0:0:0:0 with HTTP; Sat, 17 Nov 2018 09:08:09
 -0800 (PST)
In-Reply-To: <93ee204b846462f9ead610e5afe737389724d0aa.camel@redhat.com>
References: <000000000000710037057ad9551e@google.com> <CAKv+Gu8tJZUgL7q0R2KvGdyK+_y1U7KHQNDMpCmM7ZGprkKajg@mail.gmail.com>
 <93ee204b846462f9ead610e5afe737389724d0aa.camel@redhat.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sat, 17 Nov 2018 09:08:09 -0800
Message-ID: <CACT4Y+adVR4eoWpgn1syqbCitYn9hnnqvC2815V94B9yyBhtwQ@mail.gmail.com>
Subject: Re: WARNING in static_key_disable_cpuslocked
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        syzbot+6cffdef928852907751c@syzkaller.appspotmail.com,
        "David S. Miller" <davem@davemloft.net>,
        Borislav Petkov <bp@suse.de>, Jason Baron <jbaron@akamai.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        syzkaller-bugs@googlegroups.com,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 17, 2018 at 8:25 AM, Paolo Abeni <pabeni@redhat.com> wrote:
> Hi,
>
> On Sat, 2018-11-17 at 06:52 -0800, Ard Biesheuvel wrote:
>> (+ Paolo, Dave)
>>
>> On Sat, 17 Nov 2018 at 01:59, syzbot
>> <syzbot+6cffdef928852907751c@syzkaller.appspotmail.com> wrote:
>> >
>> > Hello,
>> >
>> > syzbot found the following crash on:
>> >
>> > HEAD commit:    442b8cea2477 Add linux-next specific files for 20181109
>> > git tree:       linux-next
>> > console output: https://syzkaller.appspot.com/x/log.txt?x=11f1dc25400000
>> > kernel config:  https://syzkaller.appspot.com/x/.config?x=2f72bdb11df9fbe8
>> > dashboard link: https://syzkaller.appspot.com/bug?extid=6cffdef928852907751c
>> > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10126533400000
>> >
>> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> > Reported-by: syzbot+6cffdef928852907751c@syzkaller.appspotmail.com
>
> This should be addressed in current net-next, by commit:
>
> commit 9c48060141bd937497774546e4bb89b8992be383
> Author: Paolo Abeni <pabeni@redhat.com>
> Date:   Thu Nov 15 02:34:50 2018 +0100
>
>     udp: fix jump label misuse
>
> Cheers,
>
> Paolo


#syz fix: udp: fix jump label misuse
