Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B53C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F1E3208EC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:32:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=omnibond-com.20150623.gappssmtp.com header.i=@omnibond-com.20150623.gappssmtp.com header.b="Jw+YqYOu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F1E3208EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387468AbeGKMgG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 08:36:06 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:33483 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732870AbeGKMgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 08:36:06 -0400
Received: by mail-yw0-f193.google.com with SMTP id c135-v6so9063390ywa.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 05:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9eF57SmJisC98t+66HCyaHRLc6OqRz/SJNotiesc+B0=;
        b=Jw+YqYOuQxbKdxlNf7cDjhTZQLlFZjkkNajJvSX7ioN9zvSrNwPGrNm5x5pOzgdEhl
         iFt/SclpkwjmK8StvpDdyacDTJteGZrsOR0zxKCR0dwgeve6fcDVHkaktaISFmzkvnQu
         1CW1VSMrr5DTrzknyCczW3q3ohGJyJs8xzIhjmpSxWvnpD5hJUO311EiVRUf5YbpAtyZ
         4VPjgctQ92pxuydzNcDATnixRe5LRr4xRpofCuL0K3owN7+QY7DYSpP5Fd+Q13EuvkUz
         /b5w/yUOo/z96bUzcxoHvWO0KoloqDhg9ArakvyXrkr2houfsqkii+q9T+XQ/Rtw5MyQ
         JsUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9eF57SmJisC98t+66HCyaHRLc6OqRz/SJNotiesc+B0=;
        b=CzB+XyTwQkVFNpZQoXgUR8VweEaxCWPISsQ1DpPnG5hNpNJthqtwRoHP3/Er4W0+ly
         2Xnkufgs0KsaVvXtfWaMmDkvFWm1w555XiYfB60ga+BqTC4yKfG80W/n8U8x03pnXL2K
         TeMqjj2f64eIEdl+bw4GzA0YuUTQirfGY4xSLwj8BCp2pLz4bePW8fK50SeHe2i2ZwWh
         qTMJakeBE0gPPve0nTe9BERDLv+mMfwxjN1PuKZvjBq5Qu+1QdyLhh/AWjTnKX7+4NvL
         0tZIS5GN0iHwUMCOa7863HZoNWFZdT6pJcVnpGeqT3G0OPjb+7TUmOMGUtifIuFOuBcI
         Hhmg==
X-Gm-Message-State: APt69E3KLugoOeIDCO/JwlqY41lSi9zYj9h9/478/dDcmbpGVNTViNM6
        /bm2cHB+1q7GROu7H6q/2c863CJYFo3kqhtVB3qz+A==
X-Google-Smtp-Source: AAOMgpfbjO17WTKx9rgcQu/ZRc8WrHgLTpJCjcAZHpZNdYL1hrfcWYAOa5Wd/VH18L0RIkK1ox/aadfdmhHzrmGl+aA=
X-Received: by 2002:a81:8a42:: with SMTP id a63-v6mr14566680ywg.433.1531312318632;
 Wed, 11 Jul 2018 05:31:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:86c6:0:0:0:0:0 with HTTP; Wed, 11 Jul 2018 05:31:57
 -0700 (PDT)
In-Reply-To: <CAFqt6zYAsfdXhRqH_cJPrafbA8x5LYTg-FNzwNXV39dbYV5XsQ@mail.gmail.com>
References: <20180628184240.GA17183@jordon-HP-15-Notebook-PC>
 <CAFqt6zYdHM4HG4ug5ONgeHSsZbVYd1nngVt19+v0_YR8swRuPw@mail.gmail.com>
 <CAOg9mSQuKzP9-CKc_G5ySsh9Km8riEUJWhvf3UxjUQn4rPhRPQ@mail.gmail.com>
 <CAOg9mSTzPy_eSQEqctjesrWTa1SfDT9os9Gr+mG94FLFXkuXYQ@mail.gmail.com> <CAFqt6zYAsfdXhRqH_cJPrafbA8x5LYTg-FNzwNXV39dbYV5XsQ@mail.gmail.com>
From:   Mike Marshall <hubcap@omnibond.com>
Date:   Wed, 11 Jul 2018 08:31:57 -0400
Message-ID: <CAOg9mSRurxsWaK7hu8SEDvqOX8_54iaAPERY9wrFTj2O5Pn1mA@mail.gmail.com>
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

Yes, I'd be happy to send it in at the 4.19 merge window...

-Mike

On Wed, Jul 11, 2018 at 1:56 AM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
> On Wed, Jul 11, 2018 at 1:13 AM, Mike Marshall <hubcap@omnibond.com> wrote:
>> Hi...
>>
>> I applied this patch to 4.18.0-rc4. It applied cleanly and there's no xfstests
>> regressions. Sorry if I held you up any...
>>
>> You can add: Tested-By: Mike Marshall <hubcap@omnibond.com>
>>
>
> Thanks Mike. Can we get this patch in queue for 4.19 merge window ?
>
>> -Mike
>>
>> On Fri, Jul 6, 2018 at 10:05 AM, Mike Marshall <hubcap@omnibond.com> wrote:
>>> Souptick Joarder: Any comment for this patch?
>>>
>>> Thanks for sending it <g>...
>>>
>>> I have it in my stack, but I haven't studied it, or xfstested it yet, so
>>> no useful comments yet...
>>>
>>> -Mike
>>>
>>>
>>>
>>> On Fri, Jul 6, 2018 at 2:44 AM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
>>>> On Fri, Jun 29, 2018 at 12:12 AM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
>>>>> Use new return type vm_fault_t for fault handler. For now,
>>>>> this is just documenting that the function returns a VM_FAULT
>>>>> value rather than an errno. Once all instances are converted,
>>>>> vm_fault_t will become a distinct type.
>>>>>
>>>>> See the following
>>>>> commit 1c8f422059ae ("mm: change return type to vm_fault_t")
>>>>>
>>>>> Fixed checkpatch.pl warning.
>>>>>
>>>>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>>>>> ---
>>>>>  fs/orangefs/file.c | 19 ++++++++++---------
>>>>>  1 file changed, 10 insertions(+), 9 deletions(-)
>>>>>
>>>>> diff --git a/fs/orangefs/file.c b/fs/orangefs/file.c
>>>>> index db0b521..a5a2fe7 100644
>>>>> --- a/fs/orangefs/file.c
>>>>> +++ b/fs/orangefs/file.c
>>>>> @@ -528,18 +528,19 @@ static long orangefs_ioctl(struct file *file, unsigned int cmd, unsigned long ar
>>>>>         return ret;
>>>>>  }
>>>>>
>>>>> -static int orangefs_fault(struct vm_fault *vmf)
>>>>> +static vm_fault_t orangefs_fault(struct vm_fault *vmf)
>>>>>  {
>>>>>         struct file *file = vmf->vma->vm_file;
>>>>> -       int rc;
>>>>> -       rc = orangefs_inode_getattr(file->f_mapping->host, 0, 1,
>>>>> +       int ret;
>>>>> +
>>>>> +       ret = orangefs_inode_getattr(file->f_mapping->host, 0, 1,
>>>>>             STATX_SIZE);
>>>>> -       if (rc == -ESTALE)
>>>>> -               rc = -EIO;
>>>>> -       if (rc) {
>>>>> -               gossip_err("%s: orangefs_inode_getattr failed, "
>>>>> -                   "rc:%d:.\n", __func__, rc);
>>>>> -               return rc;
>>>>> +       if (ret == -ESTALE)
>>>>> +               ret = -EIO;
>>>>> +       if (ret) {
>>>>> +               gossip_err("%s: orangefs_inode_getattr failed, ret:%d:.\n",
>>>>> +                               __func__, ret);
>>>>> +               return VM_FAULT_SIGBUS;
>>>>>         }
>>>>>         return filemap_fault(vmf);
>>>>>  }
>>>>> --
>>>>> 1.9.1
>>>>>
>>>>
>>>> Any comment for this patch ?
