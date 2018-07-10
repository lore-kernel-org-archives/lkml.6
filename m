Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5776C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 19:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41C9D208E5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 19:43:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=omnibond-com.20150623.gappssmtp.com header.i=@omnibond-com.20150623.gappssmtp.com header.b="JqBwmBe8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41C9D208E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732885AbeGJTn6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 15:43:58 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:37671 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732205AbeGJTn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 15:43:58 -0400
Received: by mail-yw0-f194.google.com with SMTP id w76-v6so8286868ywg.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 12:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2w65hC6n2nrFnkV+hXs+sCBYakLczw1plYkq13XpdOs=;
        b=JqBwmBe8Q4TIKXSJ76s2XoKhaVx757cSfkoB0DjwHo0OsyKgITSnS+GbbZj24h+dFE
         YKODdEMxWEkOWqWQnBw6DoTurErunVnarihWemVjwwpipdkX0WokOD4usfI2jokOKVVK
         3orHmd/I+BP93TfMbtIS0HWmdfnfyThQJA7LYvVCOo1l7TIVdViT6gcu7RN+rlCRePIR
         jYciNPb8ozOsLam3TijCblZlmFnN2yyuUOf6TeynSPbanRIsDgunsgVRFSARVwrPo5j4
         1lyUClVSVSb2whwmrE0Uo++Fd7BrQ8loVYh6Rz0T7IFx7xmw0IsrZAYyaKODr10dUC68
         y/mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2w65hC6n2nrFnkV+hXs+sCBYakLczw1plYkq13XpdOs=;
        b=KkdkHXk3tvcjoZrDrlBlf6EybF/koxHQSu40+r2R6ofgdfYGgufr1WGgTVI7A/TLoy
         b4JkgvblqC1muCh0iGajQ+lWgbpCdIPosc+tZDD42slLvobo3KmkftUGRdOEA5O4zdQ5
         lzFbM1F28dJ4c3JBS1vB72uItzVU4Qb7XzU/InhkR5JsojR4lO1jJUoHWA/p9OFzLPfX
         J1Bcl1u7Y2ch77+EQmGRkawWixeDTd6SSP/CWEmaxJ4h9ALwEeV3B/pAcrDqoBWvPqNP
         j/s/jy5v2+7QAS8WHvQIwDJE2fzAmsy3VJJUHWRmvpf1wIrTqud/nKrX+tQMRImSfMtR
         IqqQ==
X-Gm-Message-State: APt69E35DcDNnK2JfsqS4wYUdqX5GlIg7xLRu3KJlbeJcSEBCJwpSGVO
        P6r/T0zzLTFuMovxs9oMg2A5Fu9Uw8nZGZulRj9JmA==
X-Google-Smtp-Source: AAOMgpcYE+FXFLOkeKiOmk/hx3gcYR6TJvBuTr4XvdiP7tdtnkUmgEUnNQTQl4TVWb91Wh/Y7/7FfBvIZinIePEqvLc=
X-Received: by 2002:a81:8a42:: with SMTP id a63-v6mr13234248ywg.433.1531251807235;
 Tue, 10 Jul 2018 12:43:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:86c6:0:0:0:0:0 with HTTP; Tue, 10 Jul 2018 12:43:26
 -0700 (PDT)
In-Reply-To: <CAOg9mSQuKzP9-CKc_G5ySsh9Km8riEUJWhvf3UxjUQn4rPhRPQ@mail.gmail.com>
References: <20180628184240.GA17183@jordon-HP-15-Notebook-PC>
 <CAFqt6zYdHM4HG4ug5ONgeHSsZbVYd1nngVt19+v0_YR8swRuPw@mail.gmail.com> <CAOg9mSQuKzP9-CKc_G5ySsh9Km8riEUJWhvf3UxjUQn4rPhRPQ@mail.gmail.com>
From:   Mike Marshall <hubcap@omnibond.com>
Date:   Tue, 10 Jul 2018 15:43:26 -0400
Message-ID: <CAOg9mSTzPy_eSQEqctjesrWTa1SfDT9os9Gr+mG94FLFXkuXYQ@mail.gmail.com>
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

Hi...

I applied this patch to 4.18.0-rc4. It applied cleanly and there's no xfstests
regressions. Sorry if I held you up any...

You can add: Tested-By: Mike Marshall <hubcap@omnibond.com>



-Mike

On Fri, Jul 6, 2018 at 10:05 AM, Mike Marshall <hubcap@omnibond.com> wrote:
> Souptick Joarder: Any comment for this patch?
>
> Thanks for sending it <g>...
>
> I have it in my stack, but I haven't studied it, or xfstested it yet, so
> no useful comments yet...
>
> -Mike
>
>
>
> On Fri, Jul 6, 2018 at 2:44 AM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
>> On Fri, Jun 29, 2018 at 12:12 AM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
>>> Use new return type vm_fault_t for fault handler. For now,
>>> this is just documenting that the function returns a VM_FAULT
>>> value rather than an errno. Once all instances are converted,
>>> vm_fault_t will become a distinct type.
>>>
>>> See the following
>>> commit 1c8f422059ae ("mm: change return type to vm_fault_t")
>>>
>>> Fixed checkpatch.pl warning.
>>>
>>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>>> ---
>>>  fs/orangefs/file.c | 19 ++++++++++---------
>>>  1 file changed, 10 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/fs/orangefs/file.c b/fs/orangefs/file.c
>>> index db0b521..a5a2fe7 100644
>>> --- a/fs/orangefs/file.c
>>> +++ b/fs/orangefs/file.c
>>> @@ -528,18 +528,19 @@ static long orangefs_ioctl(struct file *file, unsigned int cmd, unsigned long ar
>>>         return ret;
>>>  }
>>>
>>> -static int orangefs_fault(struct vm_fault *vmf)
>>> +static vm_fault_t orangefs_fault(struct vm_fault *vmf)
>>>  {
>>>         struct file *file = vmf->vma->vm_file;
>>> -       int rc;
>>> -       rc = orangefs_inode_getattr(file->f_mapping->host, 0, 1,
>>> +       int ret;
>>> +
>>> +       ret = orangefs_inode_getattr(file->f_mapping->host, 0, 1,
>>>             STATX_SIZE);
>>> -       if (rc == -ESTALE)
>>> -               rc = -EIO;
>>> -       if (rc) {
>>> -               gossip_err("%s: orangefs_inode_getattr failed, "
>>> -                   "rc:%d:.\n", __func__, rc);
>>> -               return rc;
>>> +       if (ret == -ESTALE)
>>> +               ret = -EIO;
>>> +       if (ret) {
>>> +               gossip_err("%s: orangefs_inode_getattr failed, ret:%d:.\n",
>>> +                               __func__, ret);
>>> +               return VM_FAULT_SIGBUS;
>>>         }
>>>         return filemap_fault(vmf);
>>>  }
>>> --
>>> 1.9.1
>>>
>>
>> Any comment for this patch ?
