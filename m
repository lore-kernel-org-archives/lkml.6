Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6AF2C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8588924053
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:20:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="houx2VKz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8588924053
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754312AbeGEQUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 12:20:35 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:43153 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753537AbeGEQUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 12:20:33 -0400
Received: by mail-pf0-f194.google.com with SMTP id y8-v6so5865101pfm.10
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 09:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5i5hWbV3zj2tou+u/7JyQASZ3/DiaoP0BWtGdzQtZlM=;
        b=houx2VKzuE3X1lDplw7xDg3YFff9z+O3SQmrFVcL7hfchMrYEvmy1qzzEAGIdbKA4C
         HYhzr9i9yOpx6hFrZkVfvqhZKgmEWL0dpIJcCps5c8fp8eiHSAu/8Q7U3OAWxZL18NZL
         BrQlMGOD+6h6zOmPH2N8ydKxTK/5Hu+LM0MR+7zoVGaMNp/1wj/WkF8sgv8apjplHoQE
         SW1Zl4vZXxT9L7YNrQlDA1PEYkbdGek0RY7WN5J2JQDilewLhb1xKuQC1C/7tWApPsMU
         sDDrX/rL8rVSouT4X/xv45QKLSsAJVRhdHlGZsEeO1kUynX0ozmo1yHr0y6Xkkcr+hby
         5rIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5i5hWbV3zj2tou+u/7JyQASZ3/DiaoP0BWtGdzQtZlM=;
        b=bDQtpLBA/QJuCEszYGDwmOFfblccsuR1QyXdpps9IummHLbhoA2egs1oKZ7wgIyWLm
         HsESJ0hYVkFQCfGe/X+wW+oBgIxdd3FLgl3YcTTa8lqZjkGZEiA/UyeGZ8ltyWN7CtEw
         blHKmMlvvIRw5fj5uzqCezUqFmtQeVWs+jQLvfC4jVVwgGtpzxKAtfSQJDwADAJz0kRC
         YURz8k6OxBYofeFYBHr8w6YPTfhXYnv6DCI8FvwGrj+sehH5XKAS1fmSzhy96xlKeRb8
         gzWQRU9TMDIrgriR6rvB8y9TDWzAYNM+r4prmDHhxKi7YYUGtebPrAZf4nWuxIeTAJOl
         DwdA==
X-Gm-Message-State: APt69E0XL2VHQGFTx0sJPnMhfqlXiSfLh88kS6N3cdkfR1NmWady63GI
        zOD2yKuTMsQ4p/RX+qRAxGNkqLgY0Ty5WTVOPvPADQ==
X-Google-Smtp-Source: AAOMgpfI4xqBxHTZhJHhG/YSPhrvoBPF9TqUvigBqC+61BizQ8+8GCXRJy/pY0+baCUezrJ8/eNZLTCYrnmL/UTnz38=
X-Received: by 2002:a65:58c8:: with SMTP id e8-v6mr6161303pgu.96.1530807632182;
 Thu, 05 Jul 2018 09:20:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:de2:0:0:0:0 with HTTP; Thu, 5 Jul 2018 09:20:11
 -0700 (PDT)
In-Reply-To: <CACT4Y+aOvjaHHmKiKZzZAMqv3NRsXEXcfN3+v7LzrKqWyM1e4Q@mail.gmail.com>
References: <000000000000ebc8e405702ddd18@google.com> <alpine.DEB.2.21.1807041718070.1752@nanos.tec.linutronix.de>
 <CACT4Y+aOvjaHHmKiKZzZAMqv3NRsXEXcfN3+v7LzrKqWyM1e4Q@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 5 Jul 2018 18:20:11 +0200
Message-ID: <CACT4Y+ZTM-jjAnnxjgki0vuVDK=-zRhKSAMbfrJVEWf6_v0xKA@mail.gmail.com>
Subject: Re: KASAN: use-after-scope Read in __hrtimer_run_queues
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     syzbot <syzbot+7f73a81393d3b3777fb0@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 4, 2018 at 5:27 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
> On Wed, Jul 4, 2018 at 5:20 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
>> On Wed, 4 Jul 2018, syzbot wrote:
>>
>>> Hello,
>>>
>>> syzbot found the following crash on:
>>>
>>> HEAD commit:    2bdea157b999 Merge branch 'sctp-fully-support-for-dscp-and..
>>> git tree:       bpf-next
>>> console output: https://syzkaller.appspot.com/x/log.txt?x=14339f42400000
>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=f62553dc846b0692
>>> dashboard link: https://syzkaller.appspot.com/bug?extid=7f73a81393d3b3777fb0
>>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>>>
>>> Unfortunately, I don't have any reproducer for this crash yet.
>>>
>>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>>> Reported-by: syzbot+7f73a81393d3b3777fb0@syzkaller.appspotmail.com
>>>
>>> ==================================================================
>>> BUG: KASAN: use-after-scope in lookup_object lib/debugobjects.c:157 [inline]
>>> BUG: KASAN: use-after-scope in debug_object_deactivate+0x425/0x450
>>> lib/debugobjects.c:540
>>> Read of size 8 at addr ffff88019d1a5ec0 by task syz-executor3/13445
>>
>> I don't see how lib/debugobjects.c:157 would be a valid use after scope
>> issue. The one in line 540 makes no sense either.
>
> Hi Thomas,
>
> They all don't make sense:
> https://groups.google.com/d/msg/syzkaller-bugs/A-S5Rfn5bwQ/dFvmNcmyAAAJ
>
> One of them says "stack overflow", so there seems to be a serious
> system corruption that now leads to assorted nonsensical crashes. And
> this seems to be a very recent change.

#syz dup: KASAN: stack-out-of-bounds Read in timerqueue_add
