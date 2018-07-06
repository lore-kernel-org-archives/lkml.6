Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 038A2C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 811AE23EB6
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=omnibond-com.20150623.gappssmtp.com header.i=@omnibond-com.20150623.gappssmtp.com header.b="LoGBOxeC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 811AE23EB6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932612AbeGFOFR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 10:05:17 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:42869 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932374AbeGFOFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 10:05:15 -0400
Received: by mail-yb0-f196.google.com with SMTP id c10-v6so2858115ybf.9
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 07:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+4Dg5pQy0fw+GXCWJBkYactAsCXuNlVRMswY6wqQ8wo=;
        b=LoGBOxeCU0P2iLpq6rgHESiz+61g6t6oLF2uCoy78GyuaiQu3AF0icA/a9eDz5PrZn
         D2ZxuS4asqy4eIX0uPO/Si3H44K5yvM992EGu7OUznOrsw6Z3clURXt40PWqdaPfwdd2
         mesAtmUck0IwbV6dkT0oDeuzpdZhSiuCaU5nzs1Lx0bVGXNGToWkReuF6g86a/rnL1e/
         9DcOyT/scstMSCMeVwqYaXy6AMEeD+dbdTgs++sK0K4tX/7XQ1Pvtsae+nG82eZblQ+y
         ivTG6itD9hqCpA8+cKVKvIDKgXdqp9arLGfywhZvy3is6HAkEPmuBaUXMcetXH9121v3
         7MgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+4Dg5pQy0fw+GXCWJBkYactAsCXuNlVRMswY6wqQ8wo=;
        b=LpGj0cfX4HURZ67RYQL1umcjfok9xYQdEsFmJUQ9JuEzj5JZtX1Zd9a4OTOmTAIArC
         Jd7UIV5tkPRjjVjeF7R+IiG5vtOr7NLTU7i5jcrDIVZZIJf3l4q4qCgJljfrEDE7Ygsv
         OmhCVaD83n0fh4j+HrjaBxYJ6OEa7jb+l0p6sSxHLQtdAEuyIzMxGXQw+XP8qUqTI854
         1t/2eozcXQJhqgf3CtQu9x7sy0u+iHCmOMEyH3oTpNIY7VE5/xeuvxzSoZQeFWEWnY2W
         534AkPQTignwAN3oC5y7MFVU/31KgEEpl+3+WJjR9XMqi/70sZSer5M3Nq70Le6fQIlz
         9DNg==
X-Gm-Message-State: APt69E2lE87rwMPNYWuk3lrryo4GsutYJ3Fv7qc9AtezbeM85sr679jS
        TeSJqPQuLvJpDrsVNc4op1IN6vp+FyGrvMtnIlylEA==
X-Google-Smtp-Source: AAOMgpe61921CmCWh0Cms4u1VHYmrkfvmiGPYZ8f2QdlkkmGzevv6k1o7dWMNOQ3msj+ykiiUzyvPmQNtnPmjt5XTuM=
X-Received: by 2002:a25:ba4b:: with SMTP id z11-v6mr5426327ybj.427.1530885915273;
 Fri, 06 Jul 2018 07:05:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:86c6:0:0:0:0:0 with HTTP; Fri, 6 Jul 2018 07:05:14 -0700 (PDT)
In-Reply-To: <CAFqt6zYdHM4HG4ug5ONgeHSsZbVYd1nngVt19+v0_YR8swRuPw@mail.gmail.com>
References: <20180628184240.GA17183@jordon-HP-15-Notebook-PC> <CAFqt6zYdHM4HG4ug5ONgeHSsZbVYd1nngVt19+v0_YR8swRuPw@mail.gmail.com>
From:   Mike Marshall <hubcap@omnibond.com>
Date:   Fri, 6 Jul 2018 10:05:14 -0400
Message-ID: <CAOg9mSQuKzP9-CKc_G5ySsh9Km8riEUJWhvf3UxjUQn4rPhRPQ@mail.gmail.com>
Subject: Re: [PATCH] orangefs: Adding new return type vm_fault_t
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Martin Brandenburg <martin@omnibond.com>,
        devel@lists.orangefs.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Souptick Joarder: Any comment for this patch?

Thanks for sending it <g>...

I have it in my stack, but I haven't studied it, or xfstested it yet, so
no useful comments yet...

-Mike



On Fri, Jul 6, 2018 at 2:44 AM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
> On Fri, Jun 29, 2018 at 12:12 AM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
>> Use new return type vm_fault_t for fault handler. For now,
>> this is just documenting that the function returns a VM_FAULT
>> value rather than an errno. Once all instances are converted,
>> vm_fault_t will become a distinct type.
>>
>> See the following
>> commit 1c8f422059ae ("mm: change return type to vm_fault_t")
>>
>> Fixed checkpatch.pl warning.
>>
>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>> ---
>>  fs/orangefs/file.c | 19 ++++++++++---------
>>  1 file changed, 10 insertions(+), 9 deletions(-)
>>
>> diff --git a/fs/orangefs/file.c b/fs/orangefs/file.c
>> index db0b521..a5a2fe7 100644
>> --- a/fs/orangefs/file.c
>> +++ b/fs/orangefs/file.c
>> @@ -528,18 +528,19 @@ static long orangefs_ioctl(struct file *file, unsigned int cmd, unsigned long ar
>>         return ret;
>>  }
>>
>> -static int orangefs_fault(struct vm_fault *vmf)
>> +static vm_fault_t orangefs_fault(struct vm_fault *vmf)
>>  {
>>         struct file *file = vmf->vma->vm_file;
>> -       int rc;
>> -       rc = orangefs_inode_getattr(file->f_mapping->host, 0, 1,
>> +       int ret;
>> +
>> +       ret = orangefs_inode_getattr(file->f_mapping->host, 0, 1,
>>             STATX_SIZE);
>> -       if (rc == -ESTALE)
>> -               rc = -EIO;
>> -       if (rc) {
>> -               gossip_err("%s: orangefs_inode_getattr failed, "
>> -                   "rc:%d:.\n", __func__, rc);
>> -               return rc;
>> +       if (ret == -ESTALE)
>> +               ret = -EIO;
>> +       if (ret) {
>> +               gossip_err("%s: orangefs_inode_getattr failed, ret:%d:.\n",
>> +                               __func__, ret);
>> +               return VM_FAULT_SIGBUS;
>>         }
>>         return filemap_fault(vmf);
>>  }
>> --
>> 1.9.1
>>
>
> Any comment for this patch ?
