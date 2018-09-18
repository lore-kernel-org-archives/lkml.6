Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D75ECE568
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 07:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3B782083A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 07:07:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r+bO/pE0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3B782083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728681AbeIRMiZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 08:38:25 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:46932 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbeIRMiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 08:38:25 -0400
Received: by mail-yb1-f196.google.com with SMTP id y20-v6so370065ybi.13;
        Tue, 18 Sep 2018 00:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U/IkB6St4PGGv0Hq4a0jCpOBNWJAKtxu+EXnbktDY28=;
        b=r+bO/pE0u/Q09rd/gvaEoxLSp6eKUn+5+wgkmePVAlmMyDm/ByI2akOehGuWwlZWg9
         KEebq0sQVaXcNZuFe6rZX+81ZBCCxxwfiiK5Bcz+g3ssphPRjrg3wrn+RV03cNUMVAPl
         dBktG/oOP/lKjpE34S0ADfcQq9qB0KQ+sl0hRYGQ5Qt3n380k+YSoiBR4rV+uHZ391SW
         x3GjFOt8ajkkWOy0DFAnY4Bm8Jjn19dmL48q55UeQ09aBZZoy7V6PpB/TAK6W0S4iykS
         Xmk0f7wFvkJeHTflsmRDgivhveTFzQ9gbht7LrVjH26Lh2W4VOir0JFPGagrWMIFpbZw
         nWOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U/IkB6St4PGGv0Hq4a0jCpOBNWJAKtxu+EXnbktDY28=;
        b=V4Z0CR33H+FevLPho1W+0MX7HzG8JYAIr2Dx30lyIB2IUf4eUNCOFzI+W01WPYxH43
         X3NxsCcoSb2bO26utXrcrpc+zGbslhUYSpT+AUVEm+0F5GUrxyamIlWm+FYvKL6khB4y
         Aq9F4Ubkizb6bMntK71EUlkAB0yfJmY3wgS9Z2cr7hn/ire9EQgb0OkkfmMnFgBFsLQJ
         VnIEgVLvAJ6vAGctXaHFBVGJyYRgXeFsydC7dnaNGq2ZRkLdik8Nqyppr3YXyMqwl6D6
         hz/Ul9oC+NWnQqtSrGC5Py7ZtH6/eVGoLEQyTxCRLFcKJZ6+AjZn6f1Dg0wLdHjO9oFQ
         GYLQ==
X-Gm-Message-State: APzg51Dzt3d8UJIcaLYBlS9ssDPBnJvtEwBb08076wXjIwk3KveUiUCI
        BJsppTQX6TDGfuizi2aoLxHOmbTg+W9W8MR3xCA=
X-Google-Smtp-Source: ANB0VdbsDUEz4lMRCai7JdKcTeETqj/x40VYK8hcKiNoToF9SI299zdjmshH8pv2Zjbtwztq368yPWlviVMZwvP8LZ0=
X-Received: by 2002:a25:af94:: with SMTP id g20-v6mr4897772ybh.320.1537254430090;
 Tue, 18 Sep 2018 00:07:10 -0700 (PDT)
MIME-Version: 1.0
References: <20180917141950.111841-1-nixiaoming@huawei.com>
 <CAOQ4uxj_o9FP8EH9_=TX=Tv9WDfExykrni7OjE3992YZrJDpZg@mail.gmail.com> <E490CD805F7529488761C40FD9D26EF12A7B97FA@DGGEMM527-MBS.china.huawei.com>
In-Reply-To: <E490CD805F7529488761C40FD9D26EF12A7B97FA@DGGEMM527-MBS.china.huawei.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 18 Sep 2018 10:06:58 +0300
Message-ID: <CAOQ4uxg+BE5pkN5Mi3Z8ShA=s69Jp+whOsJ3+0BP-1NMK769_g@mail.gmail.com>
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

On Tue, Sep 18, 2018 at 6:01 AM Nixiaoming <nixiaoming@huawei.com> wrote:
>
> On Mon, Sep 17, 2018 11:51 PM Amir Goldstein <amir73il@gmail.com> wrote:
> >On Mon, Sep 17, 2018 at 6:05 PM nixiaoming <nixiaoming@huawei.com> wrote:
...
> >> diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
> >> index b8f4182..44c659f 100644
> >> --- a/include/linux/fsnotify_backend.h
> >> +++ b/include/linux/fsnotify_backend.h
> >> @@ -193,6 +193,7 @@ struct fsnotify_group {
> >>                         unsigned int max_marks;
> >>                         struct user_struct *user;
> >>                         bool audit;
> >> +                       bool should_report_tid;
> >
> >For brevity I would call that report_tid, but not insisting.
> >
>
> Whether it is better to change to "unsigned int flags"
> Save "group->fanotify_data.flags=flags;" in "fanotify_init"
> Determine whether "group->fanotify_data.flags" contains "FAN_EVENT_INFO_TID" in "fanotify_alloc_event";
>
> At the same time, if there are other flags that need to be used later, there is no need to add new members.
>
> By the way, whether or not "bool audit" can also be included by flags
>

I strongly agree. Didn't want to impose this change on you, but in
fact, I already did
that in my own patch set, so you can use my patches as reference:
https://github.com/amir73il/linux/commit/5225fe1e19c74f4d7a4a4cc98ff6ef5872c8e620
https://github.com/amir73il/linux/commit/0d1a226f5c18012f19ed6eabfab46f0f125ec190

If you do this you need to separate your change into 2 patches.
First make the fanotify_data.flags change collecting the pieces from both
my patches.
Then make your TID change using fanotify_data.flags.

Thanks,
Amir.
