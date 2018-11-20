Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A11C18DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 13:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08D7120851
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 13:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hIInteTa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08D7120851
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbeKTXwa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 18:52:30 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:35741 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbeKTXw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 18:52:29 -0500
Received: by mail-it1-f194.google.com with SMTP id v11so3453854itj.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 05:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=L/LJKDb9qV1jIIWGz4LuixjhEUZ2sxe7NOqkJbx6PBg=;
        b=hIInteTaCMZJk5WLIa8KABCK/nWUf3iSRGXl1ktYDwta8BSYbHLXICFZ8uqSm0Hpuw
         ReBCJiuMHIhwi+AhOy7syqidRg5+VZJP//spln7lNEHVRrmWiChmC13gA6uM0/HcJVRc
         FUmcOYO3pElKoVX3ZBgx2LxVVEIjzzHCZ7FOX+pjV0anXSQAVoYkcqFJPAHrPX1mX6CG
         eziaIPMxgPNIm2970Gd/jN8PxwhYqn9xXuwmYyiPSMikCF8JCeh0037kEBqoL6YXPjoZ
         7WSD+Byh/uYWpTXBtlNiTArLE1cWSe1BcApsfy1JN4soe5E4c/j6u1VTrFa1m01E8Jse
         fDlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=L/LJKDb9qV1jIIWGz4LuixjhEUZ2sxe7NOqkJbx6PBg=;
        b=lUImzSsLk+4MCl8tTfhP815K8iLmL4Lf5p9iXSK0GAlYCcKIVuyakb3RG/uxegrzkO
         5gwYR2CJZ0lf0QXPHkrY4yy2wXf2Y/X5Qv8LOpjdyCXVg6kkBInbhIHKSADL3FFlVu9E
         xBmJGDUof3f5wTwqNk8Xot83FplUwu5In764c7W+i6RrX4qhnywqNuQA9GfKuHEIazxt
         Lt9ETLvcpcyD6a/OV4boqs19/7rr5FvWu3DOAEQPHtUi7vmTmCUh1gB49WVX1yS6b6OJ
         xxuHeKxvFIik6W+EK5ayxgyWBh2ZTN+7Unydr7WeW55kZxGitdGh1vWRCjjB/mfpqH9S
         9quw==
X-Gm-Message-State: AGRZ1gI4umTKtH+ub8vWUC3udRLnBqh6LLdrkbPaNLgIyWkkylCQ+PgE
        NTy1DnJYBw/H/wjpm50zTZJsccnEgvVW6JGbpAwZDA==
X-Google-Smtp-Source: AFSGD/XywZkyW34t2+fMIxYmnSZqHtVDXwVqgoDigHQLIzgwf/bii5aN0YOnU9Z3u/zifx6UCryKKxwpZEgP10ZGGQs=
X-Received: by 2002:a05:660c:f94:: with SMTP id x20mr1869575itl.144.1542720201161;
 Tue, 20 Nov 2018 05:23:21 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a02:b003:0:0:0:0:0 with HTTP; Tue, 20 Nov 2018 05:23:00
 -0800 (PST)
In-Reply-To: <abb5d9ab502e37ff9fdbbd50ec770fda72e12117.camel@kernel.org>
References: <000000000000222b58057a7d9f39@google.com> <9d9ad7f2781bf15af4bd6ccc9feee35c7cd17979.camel@kernel.org>
 <87bm6svhhl.fsf@notabene.neil.brown.name> <b49e02d54460c79c4e5472983f6b9390005881b8.camel@kernel.org>
 <CACT4Y+Z3zM0z9PScAKjyjspu35B-6OgTT_qEwc+AB_MFzJkL0A@mail.gmail.com>
 <87bm6pewnm.fsf@notabene.neil.brown.name> <CACT4Y+Ysn70kTSgp_KZ5aRGuiNK0wUcqbjAH8xBJ8MqV+mFyqQ@mail.gmail.com>
 <c76712278e2d7f5c4c8cfbab687a941bf493b0c6.camel@kernel.org>
 <20181117140356.GA29895@fieldses.org> <CACT4Y+ag3mJNGUkjHQSyikT9xMJSjuY3fhSJ-2QH0eL1bTPhYw@mail.gmail.com>
 <abb5d9ab502e37ff9fdbbd50ec770fda72e12117.camel@kernel.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 20 Nov 2018 14:23:00 +0100
Message-ID: <CACT4Y+YgC6b3WDc2a6ZDDDduKx3d9rWDe0v6HFUZhZprgznfRA@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in locks_delete_block
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Bruce Fields <bfields@fieldses.org>, NeilBrown <neilb@suse.com>,
        syzbot <syzbot+a4a3d526b4157113ec6a@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 12:08 PM, Jeff Layton <jlayton@kernel.org> wrote:
> On Tue, 2018-11-20 at 07:57 +0100, Dmitry Vyukov wrote:
>> On Sat, Nov 17, 2018 at 3:03 PM, Bruce Fields <bfields@fieldses.org> wrote:
>> > On Sat, Nov 17, 2018 at 08:33:27AM -0500, Jeff Layton wrote:
>> > > Thanks for the explanation, Dmitry. I've added the tag to the patch in
>> > > my tree. It should show up in linux-next soon.
>> > >
>> > > I still find it a little misleading to say that syzbot reported a bug
>> > > when it actually found a bug inside an earlier version of the patch, but
>> > > I'll just learn to get over it.
>> >
>> > The usual tag for someone that found a bug in an earlier version of a
>> > patch would be Reviewed-by:.  Is there any reason we can't use that
>> > here?  The "syzbot+..." email should be enough on its own, I can't see a
>> > reason why their scripts would need to require a particular tag.  Or
>> > maybe we could use Tested-by:, or some other tag made up for this case?
>> >
>> > I do worry that someone who sees "Reported-by:..." might for example
>> > mistakenly assume that it would help to backport that patch if they see
>> > a similar-looking oops.
>>
>> I see. It may also be picked by scripts that detects patches that need
>> to be backported to stable because of the "Reported-by: syzbot" tag.
>> This is somewhat unfortunate.
>>
>> There is no problem parsing another tag on syzbot side. Does Tested-by
>> look good to you? If it found a bug in the patch and then it was
>> fixed, Tested-by looks reasonable. And we also detect
>> Reported-and-tested-by already because that's what syzbot suggests
>> after it tested a proposed fix for a bug.
>>
>> I am somewhat concerned how to spread this information across all
>> kernel developers. There is effectively no way to do this. We can't
>> expect people to read docs, they generally don't. I guess I just
>> document this at "See https://goo.gl/tpsmEJ for more information" and
>> then we can point other people there if/when this concern pops up
>> again.
>
> Tested-by sounds like it might be a reasonable fit. I'll change the
> patch in my tree to read that way.

Turns out this already works (we did not check exact tag, just search
for the right email with a hash). So I added a test for Tested-by tag
and extended the docs:
https://github.com/google/syzkaller/commit/9aca6b5240809308d9078a0a0f0707512c5b0220
