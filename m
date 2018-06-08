Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 6KAnJVC0GltjJwAAmS7hNA
	; Fri, 08 Jun 2018 16:54:06 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 2AF18605A5; Fri,  8 Jun 2018 16:54:06 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ItF0NdQO"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 836AF601D2;
	Fri,  8 Jun 2018 16:54:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 836AF601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752840AbeFHQyD (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 12:54:03 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:35674 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752428AbeFHQx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 12:53:59 -0400
Received: by mail-pl0-f68.google.com with SMTP id k1-v6so226965plt.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 09:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=blZ+U1B8o54hRbPDbq8BTxqJ9y6gWINQElWz38jY2QU=;
        b=ItF0NdQOseQGADZXh13s8RM4nKjYqaRES/+ReCCFE7px4F+5++tn29lqkQZC5zH7Qe
         Eg/5n6q2vwWuwav+cy2iTqPpVamdVWQ7oOwYaJpkWYIgQg8kzy1dtD1zym7tgq6N31kV
         bxdUS/uTx1JmycXIhvFYgMyr5nMI8rA0Bl+doiyVPmzlvJL11nuI7fmfmbQ18pzJaakU
         4oTICxRvikEpSvjB55YyMUL+e6o9vWWBLbUdNAFj2Je8zRnT4EufBWhQHd5AdHADCPqU
         VNyjl2EHvOO+pofDPRno6SZoWPLmrh0nwueIHuGEzb1WAWKrkSxTeTcRBCcZsR5DGsdl
         9NFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=blZ+U1B8o54hRbPDbq8BTxqJ9y6gWINQElWz38jY2QU=;
        b=WTJprco8eEbs2x/ZLx1oiVxvgUKn1Ft3ErAgetX3gKq7so+ykzfzQHUq7x8tvSouHl
         wZ32FcT9x796SNN/54tepjO0Xm62mne6O3CjJC50vP7Y7G7exbv54h7netQ5MZbS++wO
         lfGLwX7PQwdKbqJrnwTZwiHXs3DDVDBDiytdVNJHHHSKyUKOhcPgOxfG9iKm2aHdjBuS
         SGtbOcKmFRCyCUgTiH0OVeFwXjMbx+gM9Ya7c5wFJbDfXiXbPiLvg5ym5jseveTgVnJF
         fYHaN2NIa5rXmb+DQvmhziT5H9BbqGVpbgBQq4jR3AInWVysbUenAZ9y0KHJba2F6UAH
         LmLA==
X-Gm-Message-State: APt69E0cXPDx7/wQpya2mtCEFP4Xgz3op1F4+I0icj5NSaqhqFjTPFd/
        FvHhhoxdQH7oACxedz72y0LZltBw1+5pU5+uAJNfAQ==
X-Google-Smtp-Source: ADUXVKLvKjZglNoxhPQi8GRkbrCDv3k4lBRzWjK+ffVXV7SZJY7rkDW2AtZzmYs0Drm67JSUd0FPgzCilx1LYfKSfHU=
X-Received: by 2002:a17:902:bb81:: with SMTP id m1-v6mr7430483pls.117.1528476839086;
 Fri, 08 Jun 2018 09:53:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:d42:0:0:0:0 with HTTP; Fri, 8 Jun 2018 09:53:38
 -0700 (PDT)
In-Reply-To: <CACT4Y+bBfwpcP2h0URpqwiNMQ5SFJdPDHThUu2xetmrxgC+3BQ@mail.gmail.com>
References: <95865cab-e12f-d45b-b6e3-465b624862ba@i-love.sakura.ne.jp>
 <CACT4Y+byRRtCA9B9bPG9mjrf3UY3OsGeBsoh8dZ0T+V6tKpTHg@mail.gmail.com>
 <201806080231.w582VIRn021009@www262.sakura.ne.jp> <CACT4Y+Y7Mj1JngLst1aRHDhURXQMn-eTjyPFjDdGAT0ZV-dHrw@mail.gmail.com>
 <CACT4Y+bBfwpcP2h0URpqwiNMQ5SFJdPDHThUu2xetmrxgC+3BQ@mail.gmail.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Fri, 8 Jun 2018 18:53:38 +0200
Message-ID: <CACT4Y+bHDWDapwOonO1EpR6TiRa=qf9nSDtHArq75yCGuHf=gg@mail.gmail.com>
Subject: Re: general protection fault in wb_workfn (2)
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        syzbot <syzbot+4a7438e774b21ddd8eca@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Tejun Heo <tj@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        linux-block@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 8, 2018 at 5:16 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
>> On Fri, Jun 8, 2018 at 4:31 AM, Tetsuo Handa
>> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>> Dmitry Vyukov wrote:
>>>> On Tue, Jun 5, 2018 at 3:45 PM, Tetsuo Handa
>>>> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>>> > Dmitry, can you assign VM resources for a git tree for this bug? This bug wants to fight
>>>> > against https://github.com/google/syzkaller/blob/master/docs/syzbot.md#no-custom-patches ...
>>>>
>>>> Hi Tetsuo,
>>>>
>>>> Most of the reasons for not doing it still stand. A syzkaller instance
>>>> will produce not just this bug, it will produce hundreds of different
>>>> bugs. Then the question is: what to do with these bugs? Report all to
>>>> mailing lists?
>>>
>>> Is it possible to add linux-next.git tree as a target for fuzzing? If yes,
>>> we can try debug patches easily, in addition to find bugs earlier than now.
>>
>> syzbot tested linux-next and mmotm initially, but they were removed at
>> the request of kernel developers. See:
>> https://groups.google.com/d/msg/syzkaller/0H0LHW_ayR8/dsK5qGB_AQAJ
>> and:
>> https://groups.google.com/d/msg/syzkaller-bugs/FeAgni6Atlk/U0JGoR0AAwAJ
>> Indeed, linux-next produces around 50 assorted one-off unexplainable
>> bug reports.
>>
>>
>>>> I think the solution here is just to run syzkaller instance locally.
>>>> It's just a program anybody can run it on any kernel with any custom
>>>> patches. Moreover for local instance it's also possible to limit set
>>>> of tested syscalls to increase probability of hitting this bug and at
>>>> the same time filter out most of other bugs.
>>>
>>> If this bug is reproducible with VM resources individual developer can afford...
>>>
>>> Since my Linux development environment is VMware guests on a Windows PC, I can't
>>> run VM instance which needs KVM acceleration. Also, due to security policy, I can't
>>> utilize external VM resources available on the Internet, as well as I can't use ssh
>>> and git protocols. Speak of this bug, even with a lot of VM instances, syzbot can
>>> reproduce this bug only once or twice per a day. Thus, the question for me boils
>>> down to, whether I can reproduce this bug using one VMware guest instance with 4GB
>>> of memory. Effectively, I don't have access to environments for running syzkaller
>>> instance...
>>
>> Well, I don't know what to say, it does require some resources.
>>
>>>> Do we have any idea about the guilty subsystem? You mentioned
>>>> bdi_unregister, why? What would be the set of syscalls to concentrate
>>>> on?
>>>> I will do a custom run when I get around to it, if nobody else beats me to it.
>>>
>>> Because bdi_unregister() does "bdi->dev = NULL;" which wb_workfn() is hitting
>>> NULL pointer dereference.
>>
>> Right, wb_workfn is not a generic function, it's fs-specific function.
>>
>> Trying to reproduce this locally now.
>
>
> No luck so far.
>
> Trying to look from a different angle: is it possible that bdi->dev is
> not set yet, rather then already reset?


I was able to reproduce this once locally running syz-crush utility
replaying one of the crash logs. Now running with Tetsuo's patch.

I can say we hunting a very subtle race condition with short
inconsistency window, perhaps few instructions.
