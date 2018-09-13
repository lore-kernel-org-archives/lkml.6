Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C623FC43143
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 19:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A3EA2086C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 19:35:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="fQzunwwq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A3EA2086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbeINAq2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 20:46:28 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45441 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbeINAq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 20:46:27 -0400
Received: by mail-lf1-f68.google.com with SMTP id r4-v6so5811561lff.12
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 12:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cQyRtSJ5aCr4qobA6icdkN4HNVR/jMMSty89NBD5Tyk=;
        b=fQzunwwqqFKJHVzbVYlhCnAceGQzpaQ76qXpZsr2MHCq3/b4TF41t+QXQik5foQwip
         6KXd2E/q/sTNWERooewvRu3e4v8Z+wrjAdftYHu22lM7uFo/aMrfogG3C3KjNqnXHPhI
         heQarVixmGlwOixVKftNGd1ZgX3y8gjMQWyxMidTEkfXKgrNZuJ5+zvAX0eTuCIM97aW
         XYxiVXpAgf5Vd43D7o9XWlEQNeiaWXunJ2RKUr/e54iyrH/efjOQ5pG8LeSwQG3Iw5Fj
         jpry7x7467WtdNrKBuXYUBcdduIpP2InsoK0pnTnjOV4WbZOzl/q1xW74et3wgY4UWPe
         iAjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cQyRtSJ5aCr4qobA6icdkN4HNVR/jMMSty89NBD5Tyk=;
        b=iGRQfpcmz/xcfARzcs1sz1mYjRY5Wyk+nqsNKryvDwxkVmU8kyqCVJdF+H6WUJiSBO
         zn1qgaqiqPZdP72OEtqJ9DQmUpCFLj7b6PojQlzNUlYTtM6pOokdMI4K6Buh64JG1Xy/
         FOzwEb1orZtk1ByF5ApNhhZQr/daQtzQ+wVpC5RUB/zgwQmnlJiWlN34CcZt3Ml6jnhp
         XBrBAFW2+l/q0OudaXWXyPwcSrcnRNOO4Vm5nR9WUYpL7R54A6M9l0TKs1qSvZo6QX42
         OZVQfKr9POezQJLLKf72SKCgVOQQxr6MHP1G/t4e0mW4kDwTDVs9Sci/0HYBPt1ohzd/
         slOg==
X-Gm-Message-State: APzg51A7EspZHADOS9B6KdKwb9GuSCZtYWkYNT6D7vH67tql46HUBIoK
        CGsJ36rwOuqLuMafP0wzDKNJIPgx0LiQgfKlzyfh
X-Google-Smtp-Source: ANB0VdY+LkEe35y3oVvF+1ZdXEQ4Sa+02rGTGLjydFk/A2j5J20wJjI6piwprCY95q2AUYBVfhm6vmrCv040rz9LflE=
X-Received: by 2002:a19:14e6:: with SMTP id 99-v6mr5939866lfu.26.1536867330871;
 Thu, 13 Sep 2018 12:35:30 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000038dab0575476b73@google.com> <f3bcebc6-47a7-518e-70f7-c7e167621841@I-love.SAKURA.ne.jp>
 <CAHC9VhT-Thu6KppC-MWzqkB7R1CaQA9DWXOQnG0b2uS9+rvzoA@mail.gmail.com>
 <ea29a8bf-95b2-91d2-043b-ed73c9023166@i-love.sakura.ne.jp>
 <9d685700-bc5c-9c2f-7795-56f488d2ea38@sony.com> <20180913111135.GA21006@dhcp22.suse.cz>
 <ec6547f4-6240-d901-b2d2-b5103a10493f@sony.com>
In-Reply-To: <ec6547f4-6240-d901-b2d2-b5103a10493f@sony.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 13 Sep 2018 15:35:19 -0400
Message-ID: <CAHC9VhT1MQ=oShEQyp+5hwLOYm1fGK_YjiW1T7tkyOPp5-ypnA@mail.gmail.com>
Subject: Re: [PATCH] selinux: Add __GFP_NOWARN to allocation at str_read()
To:     penguin-kernel@i-love.sakura.ne.jp, peter.enderborg@sony.com
Cc:     mhocko@kernel.org, selinux@tycho.nsa.gov,
        syzbot+ac488b9811036cea7ea0@syzkaller.appspotmail.com,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
        syzkaller-bugs@googlegroups.com, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 8:55 AM peter enderborg
<peter.enderborg@sony.com> wrote:
> On 09/13/2018 01:11 PM, Michal Hocko wrote:
> > On Thu 13-09-18 09:12:04, peter enderborg wrote:
> >> On 09/13/2018 08:26 AM, Tetsuo Handa wrote:
> >>> On 2018/09/13 12:02, Paul Moore wrote:
> >>>> On Fri, Sep 7, 2018 at 12:43 PM Tetsuo Handa
> >>>> <penguin-kernel@i-love.sakura.ne.jp> wrote:
> >>>>> syzbot is hitting warning at str_read() [1] because len parameter can
> >>>>> become larger than KMALLOC_MAX_SIZE. We don't need to emit warning for
> >>>>> this case.
> >>>>>
> >>>>> [1] https://syzkaller.appspot.com/bug?id=7f2f5aad79ea8663c296a2eedb81978401a908f0
> >>>>>
> >>>>> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> >>>>> Reported-by: syzbot <syzbot+ac488b9811036cea7ea0@syzkaller.appspotmail.com>
> >>>>> ---
> >>>>>  security/selinux/ss/policydb.c | 2 +-
> >>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>>
> >>>>> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> >>>>> index e9394e7..f4eadd3 100644
> >>>>> --- a/security/selinux/ss/policydb.c
> >>>>> +++ b/security/selinux/ss/policydb.c
> >>>>> @@ -1101,7 +1101,7 @@ static int str_read(char **strp, gfp_t flags, void *fp, u32 len)
> >>>>>         if ((len == 0) || (len == (u32)-1))
> >>>>>                 return -EINVAL;
> >>>>>
> >>>>> -       str = kmalloc(len + 1, flags);
> >>>>> +       str = kmalloc(len + 1, flags | __GFP_NOWARN);
> >>>>>         if (!str)
> >>>>>                 return -ENOMEM;
> >>>> Thanks for the patch.
> >>>>
> >>>> My eyes are starting to glaze over a bit chasing down all of the
> >>>> different kmalloc() code paths trying to ensure that this always does
> >>>> the right thing based on size of the allocation and the different slab
> >>>> allocators ... are we sure that this will always return NULL when (len
> >>>> + 1) is greater than KMALLOC_MAX_SIZE for the different slab allocator
> >>>> configurations?
> >>>>
> >>> Yes, for (len + 1) cannot become 0 (which causes kmalloc() to return
> >>> ZERO_SIZE_PTR) due to (len == (u32)-1) check above.
> >>>
> >>> The only concern would be whether you want allocation failure messages.
> >>> I assumed you don't need it because we are returning -ENOMEM to the caller.
> >>>
> >> Would it not be better with
> >>
> >>     char *str;
> >>
> >>     if ((len == 0) || (len == (u32)-1) || (len >= KMALLOC_MAX_SIZE))
> >>         return -EINVAL;
> >>
> >>     str = kmalloc(len + 1, flags);
> >>     if (!str)
> >>         return -ENOMEM;
> > I strongly suspect that you want kvmalloc rather than kmalloc here. The
> > larger the request the more likely is the allocation to fail.
> >
> > I am not familiar with the code but I assume this is a root only
> > interface so we don't have to worry about nasty users scenario.
> >
> I don't think we get any big data there at all. Usually less than 32 bytes. However this data can be in fast path so a vmalloc is not an option.
>
> And some of the calls are GFP_ATOMC.

Based on all the comments it looks like Tetsuo's original patch is
probably the best fix right now.  I'm going to merge this into
selinux/next.

Tetsuo, thanks for the patch, and thanks to everyone else for the
comments/review.

-- 
paul moore
www.paul-moore.com
