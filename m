Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C38C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 08:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 750682088E
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 08:09:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DAQGLY4U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 750682088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932427AbeFPIJr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 04:09:47 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:40513 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753949AbeFPIJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 04:09:44 -0400
Received: by mail-ua0-f195.google.com with SMTP id l11-v6so7868350uak.7
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jun 2018 01:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=RQNVUFk5wBRArzV/fdrwoI0x5mEfVxwFCUI/F4yjT8g=;
        b=DAQGLY4UzDtvufcY8yM13dIVM6hpSWAdmRMDq1IZGExn9h3JI3E1jeOSNdcN8vZ+61
         TtbgBL8boUJYCtKrpBiPCp+2H/WvUxQQCE2cswpu37hboIhjkI81JswTXXTWOMf97T4d
         gtufYpSlh2F06udC+Jtpt0L9FsKZqSgkeiSMS/oRezYcdTlUDONpvFlDyY7bskM0pP/c
         NKkF/FKDxmxFIExvy4vr1SwmNMYtQ9v2Si55Drbtgeo5yQrqMgVrCaY1As1KuPNbBsWZ
         MqSHUUeygPnT7DlXrxgRuFX2NHXnrMgtJgm0I38eDlstGitgd0T/qJFULyFlTV61o+pd
         9eUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc;
        bh=RQNVUFk5wBRArzV/fdrwoI0x5mEfVxwFCUI/F4yjT8g=;
        b=rFKvu39dppEzzdvuFmIyrN57TeCjVpJH/uIYSMhtELxojNuttwyOcSPIcpNl2w+KoK
         ECzZbcEf1UoaakjriJhSmnNs0V1BUYc+7lX+3szlnEYcy8rT8g+EDuwmcJKbextbkpku
         mDaJ3FWogcUooGhcDP9z0CGENtjolyZEtzAMl/Bvoha3a3aiMAwhAwICC+ynrD9M3/pO
         vl23YroxanAc2GJZqocNS20q3ME5MGUZ7STthWiVmOO86tLaTGA82oJ6Uk2uHbBhe3uY
         +d56SgceZO+O8SIYQ4urEhwCXxmcaKh7nwlA8t502dENrgJwXph9aNqoCVNY4UfmMoce
         xEyQ==
X-Gm-Message-State: APt69E2IyQsG+/ad0Ebms5UCeSQNZD+QQlSrBob6zbifW8Tv6+leZYoO
        lV9HTfKW2EOVHwsi9mk520nmTtCHFJssxk0JXnc=
X-Google-Smtp-Source: ADUXVKI5rZxJaMeIo4hVIw+dJ2M31C18gi98AsP6bW61Vttgx9a/STRQ4NGuZ9/bptVn9oFPedSZqzCAta2smiic9gM=
X-Received: by 2002:ab0:1571:: with SMTP id p46-v6mr2965857uae.129.1529136583033;
 Sat, 16 Jun 2018 01:09:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:3593:0:0:0:0:0 with HTTP; Sat, 16 Jun 2018 01:09:42
 -0700 (PDT)
Reply-To: rajatxjain@gmail.com
In-Reply-To: <20180616071108.GB30558@kroah.com>
References: <20180616012910.152694-1-rajatja@google.com> <20180616071108.GB30558@kroah.com>
From:   Rajat Jain <rajatxjain@gmail.com>
Date:   Sat, 16 Jun 2018 01:09:42 -0700
Message-ID: <CAA93t1rOdj4zorR=iU1=9qJmzeTeqD9L5GdX8pm7=NHXzSiy_g@mail.gmail.com>
Subject: Re: [PATCH] sysfs: Fix internal_create_group() for named group updates
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rajat Jain <rajatja@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Thanks for your review.

On Sat, Jun 16, 2018 at 12:11 AM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Fri, Jun 15, 2018 at 06:29:10PM -0700, Rajat Jain wrote:
>> There are a couple of problems with named group updates in the code
>> today:
>>
>> * sysfs_update_group() will always fail for a named group, because
>>   internal_create_group() will try to create a new sysfs directory
>>   unconditionally, which will ofcourse fail with -EEXIST.
>>
>> * We can leak the kernfs_node for grp->name if some one tries to:
>>   - rename a group (change grp->name), or
>>   - update a named group, to an unnamed group
>>
>> It appears that the whole purpose of sysfs_update_group() was to
>> allow changing the permissions or visibility of attributes and not
>> the names. So make it clear in the comments, and allow it to update
>> an existing named group.
>
> Who uses sysfs_update_group() today that has these problems?  Or do you
> want to use it in new code?  How can it be broken today so badly that it
> does not work?

Sorry, my bad, I need to provide more clarification: None of the
existing users of this API use it on a named attribute group, thus
will not see this issue. I hit this issue while writing new code
(However, since then my code logic has changed so that it does not
need to use this API anymore).

I'm just trying to fix an issue with this API, that I stumbled upon,
which might be seen in future by any new code that uses this API with
named attribute groups. At the minimum, I think we should clarify in
comments (or better yet, ensure) that this API cannot be misused.


>
>> Signed-off-by: Rajat Jain <rajatja@google.com>
>> ---
>>  fs/sysfs/group.c | 26 +++++++++++++++++++-------
>>  1 file changed, 19 insertions(+), 7 deletions(-)
>>
>> diff --git a/fs/sysfs/group.c b/fs/sysfs/group.c
>> index 4802ec0e1e3a..8bd10dc730ae 100644
>> --- a/fs/sysfs/group.c
>> +++ b/fs/sysfs/group.c
>> @@ -119,12 +119,23 @@ static int internal_create_group(struct kobject *kobj, int update,
>>               return -EINVAL;
>>       }
>>       if (grp->name) {
>> -             kn = kernfs_create_dir(kobj->sd, grp->name,
>> -                                    S_IRWXU | S_IRUGO | S_IXUGO, kobj);
>> -             if (IS_ERR(kn)) {
>> -                     if (PTR_ERR(kn) == -EEXIST)
>> -                             sysfs_warn_dup(kobj->sd, grp->name);
>> -                     return PTR_ERR(kn);
>> +             if (update) {
>> +                     kn = kernfs_find_and_get(kobj->sd, grp->name);
>> +                     if (!kn) {
>> +                             WARN(1,
>> +                                  "Can't update unknown attr grp name: %s/%s\n",
>> +                                  kobj->name, grp->name);
>> +                             return -EINVAL;
>
> This is going to cause the syzbot to bug the heck out of us, as people
> do run with panic-on-warning.  Just make this a "normal" error message
> and dump the stack if you want that.

Agreed, I will turn into a normal error.

>
> But maybe we should just get rid of this function entirely, it feels
> very ackward and I can't remember why we added it...

There are a couple of existing in-tree users of this API, and I do not
understand a lot about that code.

Thanks & Best Regards,

Rajat

>
> thanks,
>
> greg k-h
