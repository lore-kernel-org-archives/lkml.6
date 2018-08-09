Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7245AC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 14:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B391208CA
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 14:35:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Fw1WUVqs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B391208CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732588AbeHIRAO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 13:00:14 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:35812 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732384AbeHIRAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 13:00:13 -0400
Received: by mail-oi0-f66.google.com with SMTP id m11-v6so10214916oic.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 07:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=SS5BDV6V8Wq7DF71MLXBv4Ykz9gcmE7xaZde1hqlAd8=;
        b=Fw1WUVqsxLSwUOuqvLOLpWbGOReQ141K56mPWa4pD37FN4sFfWZQvHZEcVJLtohvQN
         nd+gDqxwdSKK5IHxS7HJmXHw7dzxNOriJ7NeJfsPuTzJzKKpUZ62jsil4anmYdAq1IDl
         oZgubjgmsK/kb6nDhV1l5GFjAHG3U8zqANjeM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=SS5BDV6V8Wq7DF71MLXBv4Ykz9gcmE7xaZde1hqlAd8=;
        b=tSnQe8NvwAOKHqALU9gTdeThDws4nwyfZS1v5NpttRC6tA3hphpdVsD6Jlk4sY4757
         kSwseD5TvNzkSI/UA4gKUv9nWnjQEmkI8IksgipJE0n3Yh0uGYcpwukUMjpM7f7eLxUk
         alRXyNxsar1gAexkSfC9tTM62TWs7ebGbKOHGJyGM9szMY/61v3vor/eXzCQkHVBewDY
         p0uJZRpi/GQ36JS2LU/xhW11Sb/CnLeb3yHCJDxm/7avWDFcbTfaybCtZn54DKKmg42b
         xa40s9I4EHN5s16yrQfwacQ5tIl79YDZPKE+yOCLs1/t1IJaifsrcwBv40jRgHb0Cghj
         8+JA==
X-Gm-Message-State: AOUpUlERwNiGzAUsx/rQSPIBsDwBtpr1W5rwC7Enk8CZk6+x/I6i56Kw
        iwGu6Z6fF5Gqdx1bpHw8utHTrHC6HAL49qUCm936bA==
X-Google-Smtp-Source: AA+uWPyuGY0KVss2mRePpyBvsPkPaNDLJsscF1qw1Pq4w1k+75Q9m1CoVSBd4IbzPdc7ysDrzqqOhF62vTIifOZ4sX4=
X-Received: by 2002:aca:d04b:: with SMTP id h72-v6mr2223165oig.17.1533825302578;
 Thu, 09 Aug 2018 07:35:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:113c:0:0:0:0:0 with HTTP; Thu, 9 Aug 2018 07:35:01 -0700 (PDT)
X-Originating-IP: [212.96.48.140]
In-Reply-To: <27374.1533824694@warthog.procyon.org.uk>
References: <153313703562.13253.5766498657900728120.stgit@warthog.procyon.org.uk>
 <153313723557.13253.9055982745313603422.stgit@warthog.procyon.org.uk>
 <87in4n9zg0.fsf@xmission.com> <27374.1533824694@warthog.procyon.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 9 Aug 2018 16:35:01 +0200
Message-ID: <CAJfpegvWE9htLjqeR6=2BWBSuvJzJpWcjBC_EmX_k1RCGXTfbw@mail.gmail.com>
Subject: Re: [PATCH 28/33] vfs: syscall: Add fsconfig() for configuring and
 managing a context [ver #11]
To:     David Howells <dhowells@redhat.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux API <linux-api@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 9, 2018 at 4:24 PM, David Howells <dhowells@redhat.com> wrote:
> Eric W. Biederman <ebiederm@xmission.com> wrote:
>
>> First let me thank you for adding both FSCONFIG_CMD_CREATE and
>> FSCONFIG_CMD_RECONFIGURE.  Unfortunately the implementation is currently
>> broken.  So this patch gets my:
>>
>> This is broken in two specific ways.
>> ...
>> 2) FSCONFIG_CMD_CREATE will succeed even if the superblock already
>>    exists and it can not use all of the superblock parameters.
>>
>>    This happens because vfs_get_super will only call fill_super
>>    if the super block is created.  Which is reasonable on the face
>>    of it.  But it in practice this introduces security problems.
>>
>>    a) Either through reconfiguring a shared super block you did not
>>       realize was shared (as we saw with devpts).
>>
>>    b) Mounting a super block and not honoring it's mount options
>>       because something has already mounted it.  As we see today
>>       with proc.  Leaving userspace to think the filesystem will behave
>>       one way when in fact it behaves another.
>>
>> I have already explained this several times, and apparently I have been
>> ignored.  This fundamental usability issue that leads to security
>> problems.
>
> I've also explained why you're wrong or at least only partially right.  I *do*
> *not* want to implement sget() in userspace with the ability for userspace to
> lock out other mount requests - which is what it appears that you've been
> asking for.
>
> However, as I have said, I *am* willing to add one of more flags to help with
> this, but I can't make any "legacy" fs honour them as this requires the
> fs_context to be passed down to sget_fc() and the filesystem - which is why I
> was considering leaving it for later.

You can determine at fsopen() time whether the filesystem is able to
support the O_EXCL behavior?  If so, then it's trivial to enable this
conditionally.  I think that's what Eric is asking for, it's obviously
not fair to ask for a change in behavior of the legacy interface.

Thanks,
Miklos
