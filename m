Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD0D7ECE560
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 12:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 713AF2146D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 12:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QdtwIrgR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 713AF2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729626AbeIRRfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 13:35:07 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:35167 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727757AbeIRRfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 13:35:07 -0400
Received: by mail-yb1-f196.google.com with SMTP id o63-v6so681755yba.2;
        Tue, 18 Sep 2018 05:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0Cjwhv5QdZtdLtvZJDJ+BXukkojj1hvJJNUvuw7wz7U=;
        b=QdtwIrgRcgRdGbGC9iqv18MILaGt0xKxHP0sZC3A/YUMa3ZJsboqchRqvGuCuTn1Qs
         ns1k5j67tF9/JR+e1v5T52svU7BdOFXc5E13h6CdgWHRRvQeAW/nE2TUr5KJGFCddIkO
         yWXY2zOjZE3hYdon3LaUpsoXKy+Zn/a9+xlSqnVMDe5bNRbPbxFsbqkAQJ2Nmu9UQO0t
         hwrVCQ99vlZzE40yWHtft6bKc9PUCvhW5veBvusDJbR/5x4AR+N8lbMrIews2LnWYV5x
         zhQWNu6KlCUXSxLwfFdnBX2Y2Y3loiqljTUa5+J8c7CHccLIAWsbOsLDwTV/SBQdtkEz
         13OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0Cjwhv5QdZtdLtvZJDJ+BXukkojj1hvJJNUvuw7wz7U=;
        b=pdU8qDj/JPVX5y1FipJ/AevgHXQhYQoHY9PAfMs8C6H1uy5kGFAZZaPpmyyBpaq/h6
         anGlPlJmvWXfPDyCiAqZaJq42z1PoQX5oFVKIETKa37qk81OS3hN6tta1rhNxC3TtxdL
         1h4Mwrwj0ax4mhtugySUnrl0CYnkqCArtIvi9bQ1Q2nnIlridR2YleH5ktdnQcFeASev
         WYjOiHWCD+7pM9C49KIsgAElmn4KRiKwTeQQFtGPTyoRqm1raEooutaiFWl31fMYEAY0
         Vto7ImYoNMWvoHPjwQXrrDrSALzkj8aE2U1u248sHmYUUk7NxobZVI55tP0kLGnaCRQi
         8ERA==
X-Gm-Message-State: APzg51DzGPx+DWH3Zfxh586tMhTUV/1J0gb9rx5Rv/VCbM9iAME04PzU
        oLVvPrt2xibAbHt52cUvZ5YZscwiD5ggPnZ+vXc=
X-Google-Smtp-Source: ANB0VdYliaFmP/ZcMgYxd97k16ONrEIJuz84vRboCDNYJcPBKHzW0ubTN9a/ReapJSc8ZOfgd6ivJrUpDDzrld6UPHk=
X-Received: by 2002:a25:240a:: with SMTP id k10-v6mr7024293ybk.325.1537272169447;
 Tue, 18 Sep 2018 05:02:49 -0700 (PDT)
MIME-Version: 1.0
References: <20180917141950.111841-1-nixiaoming@huawei.com>
 <CAOQ4uxj_o9FP8EH9_=TX=Tv9WDfExykrni7OjE3992YZrJDpZg@mail.gmail.com>
 <E490CD805F7529488761C40FD9D26EF12A7B97FA@DGGEMM527-MBS.china.huawei.com>
 <CAOQ4uxg+BE5pkN5Mi3Z8ShA=s69Jp+whOsJ3+0BP-1NMK769_g@mail.gmail.com> <E490CD805F7529488761C40FD9D26EF12A7B9DD9@DGGEMM527-MBS.china.huawei.com>
In-Reply-To: <E490CD805F7529488761C40FD9D26EF12A7B9DD9@DGGEMM527-MBS.china.huawei.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 18 Sep 2018 15:02:38 +0300
Message-ID: <CAOQ4uxjx73HmVeQpxLCuG5aNoWMcVh+JeESxmaM=3NzoTfr4bw@mail.gmail.com>
Subject: Re: [PATCH v2] fanotify reports the thread id of the event trigger
To:     nixiaoming@huawei.com
Cc:     Steve Grubb <sgrubb@redhat.com>, Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 12:50 PM Nixiaoming <nixiaoming@huawei.com> wrote:
>
> On Tue, Sep 18, 2018 3:07 PM Amir Goldstein <amir73il@gmail.com>
> >On Tue, Sep 18, 2018 at 6:01 AM Nixiaoming <nixiaoming@huawei.com> wrote:
> >>
> >> On Mon, Sep 17, 2018 11:51 PM Amir Goldstein <amir73il@gmail.com> wrote:
> >> >On Mon, Sep 17, 2018 at 6:05 PM nixiaoming <nixiaoming@huawei.com> wrote:
> >...
> >> >> diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
> >> >> index b8f4182..44c659f 100644
> >> >> --- a/include/linux/fsnotify_backend.h
> >> >> +++ b/include/linux/fsnotify_backend.h
> >> >> @@ -193,6 +193,7 @@ struct fsnotify_group {
> >> >>                         unsigned int max_marks;
> >> >>                         struct user_struct *user;
> >> >>                         bool audit;
> >> >> +                       bool should_report_tid;
> >> >
> >> >For brevity I would call that report_tid, but not insisting.
> >> >
> >>
> >> Whether it is better to change to "unsigned int flags"
> >> Save "group->fanotify_data.flags=flags;" in "fanotify_init"
> >> Determine whether "group->fanotify_data.flags" contains "FAN_EVENT_INFO_TID" in "fanotify_alloc_event";
> >>
> >> At the same time, if there are other flags that need to be used later, there is no need to add new members.
> >>
> >> By the way, whether or not "bool audit" can also be included by flags
> >>
> >
> >I strongly agree. Didn't want to impose this change on you, but in
> >fact, I already did
> >that in my own patch set, so you can use my patches as reference:
> >https://github.com/amir73il/linux/commit/5225fe1e19c74f4d7a4a4cc98ff6ef5872c8e620
> >https://github.com/amir73il/linux/commit/0d1a226f5c18012f19ed6eabfab46f0f125ec190
> >
> >If you do this you need to separate your change into 2 patches.
> >First make the fanotify_data.flags change collecting the pieces from both
> >my patches.
> >Then make your TID change using fanotify_data.flags.
> >
> >Thanks,
> >Amir.
> >
> Should I do this:
> 1 git cherry-pick 5225fe1e19c74f4d7a4a4cc98ff6ef5872c8e620
>     Git cherry-pick 0d1a226f5c18012f19ed6eabfab46f0f125ec190
>   Manually handle patch conflicts
> 2 Add a new flag "FAN_EVENT_INFO_TID" into fanotify_data.flags
> 3 Incorporate "bool audit" into fanotify_data.flags
> 4 Submit 4 patches
>

No there is stuff in my patches that is irrelevant.
Let me prepare a clean patch for fanotify_data.flags and you can work
on top of that.

I'll try to post it later today.

Thanks,
Amir.
