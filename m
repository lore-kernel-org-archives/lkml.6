Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C5CCC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 08:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A412E20661
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 08:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lAXh4x7f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A412E20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbeIDMxS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 08:53:18 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39181 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbeIDMxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 08:53:18 -0400
Received: by mail-pg1-f194.google.com with SMTP id i190-v6so1302857pgc.6
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 01:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=z8nWTJNILynVkAeC7fI6bICyWJWJeQY9XY30zNEy66Y=;
        b=lAXh4x7f0rGyBH7IzqL7RrCUtzrp2bRKUei8Ml6ZquD4smHV52qc84L5U2V6zeDRuT
         CXY0hHDxWJAXS3sR7BfwSlG0gxGyfpuJpT/Ehx234p0zUaZ9VxngFDj9Z+Jh0+sWiJsx
         pzF4xfjoRCF7630/0/bjqEL3L8porjd/D+SyBqc29J9neiYNsPQt84mdfl2Ob/3K84kt
         pGodug97aNOJRP61AxNX++It2eR6IN2nqbce2el2XnoHLwrVdQXiF79iNYw8Rxh1fqMv
         oFm3ChyL7xJANeosbMUD4pU10YsyCdenXi1oz9Eu+WnHRUnexhG4ITDgP7KGz60Ybr0t
         Jtdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=z8nWTJNILynVkAeC7fI6bICyWJWJeQY9XY30zNEy66Y=;
        b=BTw1gKHhdvGsk45H0mmS/DN49+RIghmhTWKeSVb2trWJdTZ3UdTGbW3ql4Lue6B48a
         t2oJb7uBbKAV0PXFbyYAVp3s7/LVHm13J/IrxN2INqMyig+WkWnXLbkIYaeYPFtB0wtO
         sDF8Yv6VnV4oCvMiIAoPmu1vcsHE0jKBlo05om0iZ81PyWdNXg5R79uABF88blF6G5e1
         /ixnQppYjyxTeOHbwFkpxfsMCSRR9X2K38StyYuOtV8RtbeTavhMOOkwNUPDRzHH4CFa
         qfH/4RHX+U/wfnGbDd4wZI3ZwprCTksr5a9wrXn3kYM4ZKLaDUYz7j/h5j4MUVaW9XJ4
         1ixw==
X-Gm-Message-State: APzg51CfEy2WCDZwyadGXZgo02siTIgIzoM58NGpYIM6niaTZaEV1YwK
        3/iOdbiegzMfWDfLK1lDEHzSjaqqAhrE+5Xv8R0Dvw==
X-Google-Smtp-Source: ANB0VdZQ9/P8Dv6XuuLickkwO7zR/FgYTyi+E8SrEfodlCzPKosLnmvmSXysHseRw71qtTvpK10Iwvd/iwBat2KlHpQ=
X-Received: by 2002:a62:2a48:: with SMTP id q69-v6mr33604341pfq.86.1536049753229;
 Tue, 04 Sep 2018 01:29:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Tue, 4 Sep 2018 01:28:52
 -0700 (PDT)
In-Reply-To: <CACT4Y+bQzLe3TBvAah681Mso++swqUt7RhdFLxX5R+WKqUSgNg@mail.gmail.com>
References: <001a1148578c10e4700568e814eb@google.com> <CACT4Y+bL_+3ZJLE_1KzGNrz4hi=Si-KKsKLCd09TMD1Ux2jpgg@mail.gmail.com>
 <20180404193504.GA7715@bombadil.infradead.org> <20180405032200.GC22358@thunk.org>
 <20180405032454.GD9301@bombadil.infradead.org> <CACT4Y+bQzLe3TBvAah681Mso++swqUt7RhdFLxX5R+WKqUSgNg@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 4 Sep 2018 10:28:52 +0200
Message-ID: <CACT4Y+YtQb3XmxGDn7Y3mkxj08a5iPbFPtpXiHzaY3H5UQZbyQ@mail.gmail.com>
Subject: Re: WARNING in up_write
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        syzbot <syzbot+dc5ab2babdf22ca091af@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 5, 2018 at 10:22 AM, Dmitry Vyukov <dvyukov@google.com> wrote:
> On Thu, Apr 5, 2018 at 5:24 AM, Matthew Wilcox <willy@infradead.org> wrote:
>> On Wed, Apr 04, 2018 at 11:22:00PM -0400, Theodore Y. Ts'o wrote:
>>> On Wed, Apr 04, 2018 at 12:35:04PM -0700, Matthew Wilcox wrote:
>>> > On Wed, Apr 04, 2018 at 09:24:05PM +0200, Dmitry Vyukov wrote:
>>> > > On Tue, Apr 3, 2018 at 4:01 AM, syzbot
>>> > > <syzbot+dc5ab2babdf22ca091af@syzkaller.appspotmail.com> wrote:
>>> > > > DEBUG_LOCKS_WARN_ON(sem->owner != get_current())
>>> > > > WARNING: CPU: 1 PID: 4441 at kernel/locking/rwsem.c:133 up_write+0x1cc/0x210
>>> > > > kernel/locking/rwsem.c:133
>>> > > > Kernel panic - not syncing: panic_on_warn set ...
>>> >
>>> > Message-Id: <1522852646-2196-1-git-send-email-longman@redhat.com>
>>> >
>>>
>>> We were way ahead of syzbot in this case.  :-)
>>
>> Not really ... syzbot caught it Monday evening ;-)
>>
>> Date: Mon, 02 Apr 2018 19:01:01 -0700
>> From: syzbot <syzbot+dc5ab2babdf22ca091af@syzkaller.appspotmail.com>
>> To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
>>         syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
>> Subject: WARNING in up_write
>
> :)
>
> #syz fix: locking/rwsem: Add up_write_non_owner() for percpu_up_write()

The title was later changed to:

#syz fix: locking/rwsem: Add a new RWSEM_ANONYMOUSLY_OWNED flag
