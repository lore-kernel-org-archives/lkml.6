Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A55C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A25D320861
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TzeBlIQR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A25D320861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbeIMRlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 13:41:10 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:45303 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbeIMRlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 13:41:10 -0400
Received: by mail-yw1-f68.google.com with SMTP id p206-v6so1063585ywg.12;
        Thu, 13 Sep 2018 05:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LIspygbBKjgywJ6fd0g0bpGlzgsVSuJpH7pUxXvDb+0=;
        b=TzeBlIQRwS8fqYznvTzCeIbo9iM+y9nzYl3MNzWCJyWg9FOd0oRBpb8FepKRtHFpVD
         EAKEyPcXGbnXsxzjdUuHqauiSb7vPRg+XC53qAxmS8PtHh0eZb6zBRdaVRXdUSDKWSxV
         dJrATqREJmd2bUIuYE9nBD3mPijSlhH7iJk6P+L3NawEKzVBNB7HSkcCgzC58Cgod0T3
         sXPebfcVoEED2mNQ5sgmHooqTkHZI2Xo9mRA1MOWUcdc8NFANZkr2g5rb01q8aJkOZDg
         Nx91JTU2kYMDkQssvv+lOl3EfR17XdKz7dEnHckMOZmSnsqx2tAslHYlALwwqq3Hlelk
         08rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LIspygbBKjgywJ6fd0g0bpGlzgsVSuJpH7pUxXvDb+0=;
        b=FG1olIpiTcI5lKqSwqrGMjEKgceocGYni2yxrsOERbND+YQQpAMK6GhYycM38U8bi5
         wtSbhM+0JxrqjFoAmP5WSkPw0XCXPeEf0n9YmdQpqm2NZnXpt1oIA5UtKqi7q7q7gyBt
         FsgpK93xf0F7Prs2HFQtOkc+9nH9wYwiG/uTA0zS317HLHu3lXryt7XRC/JhGT8mcxn/
         GzQUmhR90208ar6WcBRwkgunKc1OSb44EgCIfjk8r3TkgRkwBtLBvbSXyFzPUqvWupdi
         xXkzSBkWYWJVAZRa8qDr7zzqEd/6OuEDzNlLC3HXpytxNlbTEEAjTI47YBiFhROZmmdv
         45bA==
X-Gm-Message-State: APzg51AfrRPiwOJ023Ios+HfEX2B+GWwhaaRyw6ncb+6ziRfIEFPOt/y
        VU0mNg1gqN47HUiKojxL3DAwOoBHB3p9nqglinI=
X-Google-Smtp-Source: ANB0VdbMz1de921M7rTEc02Ng3b+1Q6XMd7Pwmm/L88vQ3PTrc3lXwrYKpYVqurvX66jp7IydH/zymxAgy9BNjet2Ws=
X-Received: by 2002:a81:ac09:: with SMTP id k9-v6mr3349578ywh.409.1536841913575;
 Thu, 13 Sep 2018 05:31:53 -0700 (PDT)
MIME-Version: 1.0
References: <E490CD805F7529488761C40FD9D26EF12A7A1814@dggemm507-mbs.china.huawei.com>
 <CAOQ4uxiQ_Kb9H9z5nCJL0XJGO_2Dn2Z3KtGv2WZHkt-e+vkZ=w@mail.gmail.com> <E490CD805F7529488761C40FD9D26EF12A7A5ADA@dggemm507-mbs.china.huawei.com>
In-Reply-To: <E490CD805F7529488761C40FD9D26EF12A7A5ADA@dggemm507-mbs.china.huawei.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 13 Sep 2018 15:31:42 +0300
Message-ID: <CAOQ4uxjQK_PKAp2WMPewPZzVhE9WGHfuxyQBPcjyJ6xdJ_j7Dw@mail.gmail.com>
Subject: Re: Is it possible to add pid and comm members to the event structure
 to increase the display of user and thread information?
To:     nixiaoming@huawei.com
Cc:     Eric Paris <eparis@parisplace.org>, Robert Love <rlove@rlove.org>,
        John McCutchan <john@johnmccutchan.com>,
        Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 2:25 PM Nixiaoming <nixiaoming@huawei.com> wrote:
>
> On Tue, Sep 11, 2018 at 11:12 PM Amir Goldstein <amir73il@gmail.com> wrote:
> >On Tue, Sep 11, 2018 at 9:51 AM Nixiaoming <nixiaoming@huawei.com> wrote:
> >>
> >> Inotify api cannot display information about users and processes.
> >> That is, you can only know that the file event is generated, but you don't know who triggered the event, which is not conducive to fault location.
> >> Is it possible to add pid and comm members to the event structure to increase the display of user and thread information?
> >>
> >
> >"Is it possible?" is not the only relevant question.
> >I suppose your patch can sort of works, but it exposes information to
> >potentially unpriveleged
> >processes, even exposes pid values outside of the process pid namespace.
> >
> >While those issues could be addressed, you can't change the format
> >struct inotify_event
> >without breaking existing applications.
> >
> In order to improve the fault location capability, can we make incompatible interface changes?

Not unless application/sysadmin/distro opts-in for the incompatible change.

>
> >I guess you are not using fanotify API, which already provides pid
> >information (albiet tgid),
> >because it lacks other functionality that you need? Which
> >functionality might that be?
> >Is it directory modification events?
> >If so than you might be interested in my effort to add support for
> >those events to fanotify:
> >https://github.com/amir73il/fsnotify-utils/wiki/Super-block-root-watch
> >
> The fanotify API does not support monitoring file deletion events

Yes, I am working toward that goal.

> The fanotify API supports tgid display,
> but for multi-threaded programs,
> it still cannot accurately identify which thread triggered the event.
> Can I modify tgid to pid?
> - event->tgid = get_pid(task_tgid(current));
> + event->tgid = get_pid(task_pid(current));
>

So if you would like to change that you need to add a new flag to
fanotify_init (e.g. FAN_EVENT_INFO_TID)
new applications that would opt-in for the flag will get task_pid()
while existing application will keep getting task_tgid()
new applications will get -EINVAL when passing FAN_EVENT_INFO_TID
to fanotify_init() on an old kernel and they could then fall back to getting
tgid in events and be aware of that fact.

Thanks,
Amir.
