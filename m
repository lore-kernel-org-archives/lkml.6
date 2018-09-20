Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5326ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 15:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8363D21536
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 15:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="PlEm4tPJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8363D21536
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733148AbeITUyY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 16:54:24 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:50328 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbeITUyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 16:54:23 -0400
Received: by mail-it0-f67.google.com with SMTP id j81-v6so13610457ite.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 08:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Z53lxvNlSsmPoo6LaZvOeXOGiFawKddRLhnGWlEVrGs=;
        b=PlEm4tPJYvy3CUaMFqzKL9UxUQqqqoElb0ZhCIFewjHxfasmDXPB6fA3Fu5pNYPF0c
         m8UXqFSSRklIRt2VbPXIKZzqLxGbST/uqLp7hPHlknAaQAyFZyTDc+a2uSNVl+AKSReH
         pSnAt0cWyi0aGiST+EBo9FYtCIZ70ZH+AzEZ8j/WkwZyFPL+pv4wKMZuP1I4BCfso2LZ
         UR8z6rjmIdszd/JdheKJuHgHs40aFcbgLZDIvD0GZ3oSIENnyWKnQ5XfQ4poN+IfjWJA
         IvKYCale9J4dh8SrGpZZULwNFiPuE3v8pQy/Og4fm9WziKt3vPn/JWxF111KQTgtkRXu
         BwQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Z53lxvNlSsmPoo6LaZvOeXOGiFawKddRLhnGWlEVrGs=;
        b=TU1hIFhoedI7fZ3zFvFFQ+0+BvwWh/dXjgDX9q2c3x0gEhjAns8fLUmSRbrE5rtnap
         uyVaC6KnpisgvEiDRP8CHY7CcHWSXbKhq4sEz0ZdSpSj1UD2GWY4JcC4HRDAb0kZnaNM
         oz/l0+bVpA1/6mKUHu+lZIlUY3jr4fLz9AZMCLm9P4gZ7DRUq2deeu2zSJKtx2OoFnzJ
         PNsFCk7ilfKxG1qvSAnQFNELK+gCxP+obACpXIUYn8OhA1o/phBQ9pFDIvCyfWoAywlu
         dbq6n/TqvEVz1EvgH2Cuprl31jC5qXiOID9pRQwAH1dgpttM+0NhQLU/BwSkGxRn62fD
         sYsA==
X-Gm-Message-State: APzg51DyXiB1lJNto6URCHbMgP3zVCxf1lXymynq7Rk6VVR6bYl9kcwy
        AVbcD0Ey10tWj0D1zE0Tm8ILkw==
X-Google-Smtp-Source: ANB0VdYSSLsSBZw3fby2+/Tkqe2NtgrWEvD+mOvDww7vu2B1g/sf2b45w2hkQBA8dMafA8rTs5cs7g==
X-Received: by 2002:a24:b554:: with SMTP id j20-v6mr2407618iti.79.1537456227549;
        Thu, 20 Sep 2018 08:10:27 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id n198-v6sm1368687itn.36.2018.09.20.08.10.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 08:10:26 -0700 (PDT)
Subject: Re: [PATCH] floppy: Do not copy a kernel pointer to user memory in
 FDGETPRM ioctl
To:     Joe Lawrence <joe.lawrence@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Andy Whitcroft <robobotbotbot@gmail.com>,
        Brian Belleville <bbellevi@uci.edu>,
        Jiri Kosina <jikos@kernel.org>,
        Kees Cook <keescook@chromium.org>
References: <1520467365-7194-1-git-send-email-bbellevi@uci.edu>
 <20180529132722.GH7445@brain>
 <CAGXu5jLXm8mJuwtDEO_+dDJk5tRA+2mkEv5S9NaPP87J42B7KQ@mail.gmail.com>
 <20180920140127.72w35olyd4ivnxjp@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <bc9117f5-35ad-3119-e8ca-30f7b7ad81e7@kernel.dk>
Date:   Thu, 20 Sep 2018 09:10:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180920140127.72w35olyd4ivnxjp@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/18 8:01 AM, Joe Lawrence wrote:
> On Mon, Aug 27, 2018 at 12:45:25AM -0700, Kees Cook wrote:
>> On Tue, May 29, 2018 at 6:27 AM, Andy Whitcroft <robobotbotbot@gmail.com> wrote:
>>> On Wed, Mar 07, 2018 at 04:02:45PM -0800, Brian Belleville wrote:
>>>> The final field of a floppy_struct is the field "name", which is a
>>>> pointer to a string in kernel memory. The kernel pointer should not be
>>>> copied to user memory. The FDGETPRM ioctl copies a floppy_struct to
>>>> user memory, including the "name" field. This pointer cannot be used
>>>> by the user, and it will leak a kernel address to user-space, which
>>>> will reveal the location of kernel code and data and undermine KASLR
>>>> protection. Instead, copy the floppy_struct except for the "name"
>>>> field.
>>>>
>>>> Signed-off-by: Brian Belleville <bbellevi@uci.edu>
>>>> ---
>>>>  drivers/block/floppy.c | 1 +
>>>>  1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
>>>> index eae484a..4d4a422 100644
>>>> --- a/drivers/block/floppy.c
>>>> +++ b/drivers/block/floppy.c
>>>> @@ -3470,6 +3470,7 @@ static int fd_locked_ioctl(struct block_device *bdev, fmode_t mode, unsigned int
>>>>                                         (struct floppy_struct **)&outparam);
>>>>               if (ret)
>>>>                       return ret;
>>>> +             size = offsetof(struct floppy_struct, name);
>>>>               break;
>>>>       case FDMSGON:
>>>>               UDP->flags |= FTD_MSG;
>>>
>>> I am not sure it is reasonable to simply set size here to the length of the
>>> valid data.  Though in the real world everyonne should be using the defines
>>> and those should include the full length, the code itself does not require
>>> this, it only prevents overly long reads.  So I think it is possible to do
>>> this read with a shorter userspace buffer; with this change we would
>>> then write beyond the end of the buffer.
>>>
>>> This also seems to introduce a slight behavioural difference between the
>>> primary and compat calls.  The compat call already elides the name but it
>>> also is copying into a new structure for return and this is pre-cleared,
>>> so the name will always be null for the compat case and undefined for
>>> the primary ioctl.
>>>
>>> Perhaps the below patch would be more appropriate.
>>>
>>> -apw
>>>
>>> From ddb8c77229a9507fa5575c910d2847e123a9c94c Mon Sep 17 00:00:00 2001
>>> From: Andy Whitcroft <apw@canonical.com>
>>> Date: Tue, 29 May 2018 13:04:15 +0100
>>> Subject: [PATCH 1/1] floppy: Do not copy a kernel pointer to user memory in
>>>  FDGETPRM ioctl
>>>
>>> The final field of a floppy_struct is the field "name", which is a pointer
>>> to a string in kernel memory.  The kernel pointer should not be copied to
>>> user memory.  The FDGETPRM ioctl copies a floppy_struct to user memory,
>>> including this "name" field.  This pointer cannot be used by the user
>>> and it will leak a kernel address to user-space, which will reveal the
>>> location of kernel code and data and undermine KASLR protection.
>>>
>>> Model this code after the compat ioctl which copies the returned data
>>> to a previously cleared temporary structure on the stack (excluding the
>>> name pointer) and copy out to userspace from there.  As we already have
>>> an inparam union with an appropriate member and that memory is already
>>> cleared even for read only calls make use of that as a temporary store.
>>>
>>> Based on an initial patch by Brian Belleville.
>>>
>>> CVE-2018-7755
>>> Signed-off-by: Andy Whitcroft <apw@canonical.com>
>>
>> I didn't see this land anywhere? Who's tree is this going through?
>>
>> -Kees
>>
> 
> Looks like a pretty simple fix, but still don't see this one anywhere...
> maybe Jiri or Jens could pick it up (as per get_maintainer output :)

Applied for 4.19.

-- 
Jens Axboe

