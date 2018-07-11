Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF29C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 05:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1029A208EC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 05:56:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HdoPQEEf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1029A208EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbeGKF7G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 01:59:06 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:40153 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbeGKF7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 01:59:06 -0400
Received: by mail-lf0-f67.google.com with SMTP id y200-v6so20260761lfd.7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 22:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=X0z2PPyVCo58eKp3nM1yoSVwUm3z0qdPdonZPgGrVXI=;
        b=HdoPQEEfjS4fHBLxSIC5T9JbnSdEKixxNX9fZO5d9m6ym59Fk7aVdNFDu+qXg3x5qN
         hi81vBZV3s73GYUFA2QlPiGRlWwzje2UJNtcejCzXWNCOxTj4xnBKhOrP+3jOM3CwjEN
         8UbRgAsRHjcK//QWwj6ImYSHFmspVzxtBBZScHB7tDbFDC2d88FvoQlfe09m5bd09X/I
         0q/l9Dkn87tPew8cQePhnr0HpicJGVZyKsVjnxFxCnB6kjX82jWgE/XrbF5+rG8vhslS
         LIcfMAEMo7ZU1M/UtYQGspVXkqt+qx5EIayqqzQ5nX1uhlTzUHTQ6YZAkA8CoThREW1d
         tomg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=X0z2PPyVCo58eKp3nM1yoSVwUm3z0qdPdonZPgGrVXI=;
        b=SD5K+Rf0A3lb5adLFtgGkksmsjS1kD8SQKsd+VvbbmUSsgKQ7l6F91P6NAbE2BJcl9
         QWE0YCEozkhR37EsBoPNq5U1RdWUV2l65kHDIbjsQGWL31/fskrwgWuAEqYU++sW/9RE
         SeqvH/daDyoM8vfpSsrwmHVafZgsPuqWwMXxpd6kaOXqz0hC8W0BXfMZI8ZNdIs2/0YI
         dNJrQmVGC8AO/sBf4Xuo13HGEHlmp3yVEwfEPVxeI19q/C3drAUKkkXfIgxey9veDCjy
         R1gDM+s3lU1MC0V9ifbdOuLOZXqf9JtLPnc2Z7+VlJNdAyCXTG/xd6OAm23k9FjCTfhA
         TKtA==
X-Gm-Message-State: APt69E0ze3c9kG7xcqlMVTCHugEPSQ7WVMmswZht77Mw96BfN7sghNxL
        mPhqlUEe7Lems0gOUWcFjb1kH8C6/9w92yMs4SU=
X-Google-Smtp-Source: AAOMgpeX5y8e/28h8aAZ01UA3wFQHaDNAZq0Ucmp5Ctbu2nOwiYkb2U6jT19kbLYXizWEvBH+rTmWuVKDe5BI14muyY=
X-Received: by 2002:a19:8d07:: with SMTP id p7-v6mr5083036lfd.117.1531288589177;
 Tue, 10 Jul 2018 22:56:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:2b14:0:0:0:0:0 with HTTP; Tue, 10 Jul 2018 22:56:28
 -0700 (PDT)
In-Reply-To: <CAOg9mSTzPy_eSQEqctjesrWTa1SfDT9os9Gr+mG94FLFXkuXYQ@mail.gmail.com>
References: <20180628184240.GA17183@jordon-HP-15-Notebook-PC>
 <CAFqt6zYdHM4HG4ug5ONgeHSsZbVYd1nngVt19+v0_YR8swRuPw@mail.gmail.com>
 <CAOg9mSQuKzP9-CKc_G5ySsh9Km8riEUJWhvf3UxjUQn4rPhRPQ@mail.gmail.com> <CAOg9mSTzPy_eSQEqctjesrWTa1SfDT9os9Gr+mG94FLFXkuXYQ@mail.gmail.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Wed, 11 Jul 2018 11:26:28 +0530
Message-ID: <CAFqt6zYAsfdXhRqH_cJPrafbA8x5LYTg-FNzwNXV39dbYV5XsQ@mail.gmail.com>
Subject: Re: [PATCH] orangefs: Adding new return type vm_fault_t
To:     Mike Marshall <hubcap@omnibond.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Martin Brandenburg <martin@omnibond.com>,
        devel@lists.orangefs.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 1:13 AM, Mike Marshall <hubcap@omnibond.com> wrote:
> Hi...
>
> I applied this patch to 4.18.0-rc4. It applied cleanly and there's no xfstests
> regressions. Sorry if I held you up any...
>
> You can add: Tested-By: Mike Marshall <hubcap@omnibond.com>
>

Thanks Mike. Can we get this patch in queue for 4.19 merge window ?

> -Mike
>
> On Fri, Jul 6, 2018 at 10:05 AM, Mike Marshall <hubcap@omnibond.com> wrote:
>> Souptick Joarder: Any comment for this patch?
>>
>> Thanks for sending it <g>...
>>
>> I have it in my stack, but I haven't studied it, or xfstested it yet, so
>> no useful comments yet...
>>
>> -Mike
>>
>>
>>
>> On Fri, Jul 6, 2018 at 2:44 AM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
>>> On Fri, Jun 29, 2018 at 12:12 AM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
>>>> Use new return type vm_fault_t for fault handler. For now,
>>>> this is just documenting that the function returns a VM_FAULT
>>>> value rather than an errno. Once all instances are converted,
>>>> vm_fault_t will become a distinct type.
>>>>
>>>> See the following
>>>> commit 1c8f422059ae ("mm: change return type to vm_fault_t")
>>>>
>>>> Fixed checkpatch.pl warning.
>>>>
>>>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>>>> ---
>>>>  fs/orangefs/file.c | 19 ++++++++++---------
>>>>  1 file changed, 10 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/fs/orangefs/file.c b/fs/orangefs/file.c
>>>> index db0b521..a5a2fe7 100644
>>>> --- a/fs/orangefs/file.c
>>>> +++ b/fs/orangefs/file.c
>>>> @@ -528,18 +528,19 @@ static long orangefs_ioctl(struct file *file, unsigned int cmd, unsigned long ar
>>>>         return ret;
>>>>  }
>>>>
>>>> -static int orangefs_fault(struct vm_fault *vmf)
>>>> +static vm_fault_t orangefs_fault(struct vm_fault *vmf)
>>>>  {
>>>>         struct file *file = vmf->vma->vm_file;
>>>> -       int rc;
>>>> -       rc = orangefs_inode_getattr(file->f_mapping->host, 0, 1,
>>>> +       int ret;
>>>> +
>>>> +       ret = orangefs_inode_getattr(file->f_mapping->host, 0, 1,
>>>>             STATX_SIZE);
>>>> -       if (rc == -ESTALE)
>>>> -               rc = -EIO;
>>>> -       if (rc) {
>>>> -               gossip_err("%s: orangefs_inode_getattr failed, "
>>>> -                   "rc:%d:.\n", __func__, rc);
>>>> -               return rc;
>>>> +       if (ret == -ESTALE)
>>>> +               ret = -EIO;
>>>> +       if (ret) {
>>>> +               gossip_err("%s: orangefs_inode_getattr failed, ret:%d:.\n",
>>>> +                               __func__, ret);
>>>> +               return VM_FAULT_SIGBUS;
>>>>         }
>>>>         return filemap_fault(vmf);
>>>>  }
>>>> --
>>>> 1.9.1
>>>>
>>>
>>> Any comment for this patch ?
