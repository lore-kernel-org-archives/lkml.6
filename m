Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B932C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 13:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16AFA214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 13:33:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mgbb9p9J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16AFA214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730814AbeKVAHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 19:07:30 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:38284 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727486AbeKVAHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 19:07:30 -0500
Received: by mail-it1-f193.google.com with SMTP id h65so8823849ith.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 05:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mW96xN5AtLZsqRZBB0JVK90Y7+USNXWQ/PGTkWqfW1c=;
        b=Mgbb9p9JOkLRUatHdghXcpP47CIKwnyT1DrICKE+dRMJLeqYgoKY+/Crq49JKQb8V6
         9stj7/90PWvYl9dqoNxIvrCaMe2lZB2rmsIoK3ZycmMtFPulPvpfrv5GtUuwoBp7T7AR
         +pB9mzMJnLdFqO1YqxD7E3yFjvXn6aGh1PSzG2tjs+YENAAiefBfEg4axmJvunYfQU6M
         RgIOW54TN/xOQhb7ZVaQAeN8gHSW9bmacEUaF3AxowDlyoVZpFtbxQ1nJBtDfBW14oPj
         gMZChOkobuayJH9wSYQ7FxTKYiLg7DAEnB2sKJ5CWqwOqC3xrgVu3uGzBnet3R3bkFu/
         bVWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mW96xN5AtLZsqRZBB0JVK90Y7+USNXWQ/PGTkWqfW1c=;
        b=kd/L1WVJjFGAwz2GjjxNHpHUQcxvPWgUfcSTvVR2PTimVoXnJ/UH6V4OEa46hqxUMj
         3PnZ/n9NK6U9Of09DGuQpvlMBzOtJ3wkDVwIngHhQXHS4TMuBytiPqt8CRxaSi+9JCzy
         tBvk3J31MctPhSEj/mZaCt56bnxmNFkY5nJTwApOxf6mQYS+8zPTD5Q3fRkvvnqJqRQ5
         Z9OBR4ECZcMHi/Qmzckx/NJTP0uI6lAQOSES5e6Cv4yVbEgdLco4UlM1TjaEl1OT6L+t
         4Dd0AMkPG4UymJvXLe9FqTE+rVqHp+P8z6fbKH5COsFOB+Sl3Lk4pJWVkjRpUv6m1Oui
         sS5A==
X-Gm-Message-State: AA+aEWZpn5B/U2+PMi5drbsZTUKlBsvewkPuShfytG7mePC2tNT5vcc2
        ujeS1Tk46pNEdLiYZMGi9M7G3yTNv8WhYanzBfxXGQ==
X-Google-Smtp-Source: AJdET5dacCUKldR6cyXrs7298SyNjMf9fnQGUBeaGLFIlsZ3Qsm6jlINH4sINY+bYgsjfLMrWwjAXuDnWzabPN9p/Lc=
X-Received: by 2002:a24:b009:: with SMTP id d9-v6mr5345763itf.166.1542807183807;
 Wed, 21 Nov 2018 05:33:03 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a02:b003:0:0:0:0:0 with HTTP; Wed, 21 Nov 2018 05:32:43
 -0800 (PST)
In-Reply-To: <31735.1536701042@warthog.procyon.org.uk>
References: <CACT4Y+ajxhUaRg+XSuqQZN8rD96S820yMTWx2GpRVRb9Maz50g@mail.gmail.com>
 <0000000000006082bd05752f92bb@google.com> <29979.1536223287@warthog.procyon.org.uk>
 <23632.1536696987@warthog.procyon.org.uk> <20180912063454.0620abb4@canb.auug.org.au>
 <31735.1536701042@warthog.procyon.org.uk>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 21 Nov 2018 14:32:43 +0100
Message-ID: <CACT4Y+boXfNjHT1M5B6OttHiUFKsvL7AFH2Gfd+DbkNoQD4YVg@mail.gmail.com>
Subject: Re: linux-next boot error (2)
To:     David Howells <dhowells@redhat.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        syzbot <syzbot+762a577f56cfb1574647@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Levin, Alexander" <alexander.levin@verizon.com>,
        LKML <linux-kernel@vger.kernel.org>, linux@dominikbrodowski.net,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        nikolaus.voss@loewensteinmedical.de,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 11:24 PM, David Howells <dhowells@redhat.com> wrote:
> Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
>> I will apply this fix until the proper fix arrives in the vfs tree:
>
> Thanks.
>
> David


This was fixed in September, but the Reported-by tag wasn't added and
nobody told syzbot that this is fixed. So the bug is still considered
open:
https://syzkaller.appspot.com/bug?extid=762a577f56cfb1574647
10 days ago linux-next become broken for another reason, but syzbot
did not report a new bug because the previous one is still open (new
reports are merged into the existing open bug).

Please either use the Reported-by tag (for amended linux-next fixes
Tested-by can make more sense and is recognized too), or tell syzbot
separately:

#syz fix: apparmor: Implement security hooks for the new mount API

Also helps to keep dashboard relevant:
https://syzkaller.appspot.com/#upstream-open
a pile of hundreds of stale bugs is not too useful, and losing half of
bug reports in LKML archives is not good too.

Thanks in advance
