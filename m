Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50FCAC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 12:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF9102543A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 12:16:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lVfLp8Ll"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF9102543A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752716AbeGBMQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 08:16:12 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:40726 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752613AbeGBMQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 08:16:01 -0400
Received: by mail-pg0-f65.google.com with SMTP id x5-v6so208887pgp.7
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 05:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9FDy9G8n7aEyIin1ViIujVMnL0sRlxi6z8dIak+H1J4=;
        b=lVfLp8LlSoebZrlOkHZuw0Vl/yAV7ApIlEfxEz/Nxa/W8i3PoGdb2WKIWmhbbibWD9
         2Z2jArYaVYxSfF9nmSsQ1+2O0Rn54qoYA9THTVdPckAnet6KVNaMBoN7YfK/HYcLtDVs
         DUclRRsvlPfbmR6WlM1lDybidyDRsM9ygXN3g/7sEcPx9k7+yykBbHpbMltamYLcFprg
         lQoTGXwU7p7Ua9Ta2qam68ArHxHSuYPXEIHgPjZ7nOlPGiEqxpful8T1BXMtWzDtjj6V
         cbyNykeyOkrSn7xibuZxdbuJRFd1IQIeZx/m0MFG3HBbg9UOTpoircHRm7e28H6/1q9t
         gK6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9FDy9G8n7aEyIin1ViIujVMnL0sRlxi6z8dIak+H1J4=;
        b=Bc7Y53gsU7YVonoa7PX686qdq1wmXOKva7Yp+crs0/8uRhDt4uQf9OZGijjIpH9jnb
         CXVo9f0XTq65GKSMrVvJ+BZLm3TFY4cekhacDUP20ooszJeFj5KmvjyKRl01PpCqSh/i
         5LlC/l7WDBwscEcxFOCbX1NFT9LEkwi2a6TeQf7sxspXQ2NpRtw1mQfbZNibXWWC7Qhc
         Dv337tA/PqX5IED2Sx/INREBn0EMhAKkB9tT5WyCiLtJ8DJKjdQx288B0KhNi+FA6Bmi
         WknfUFxBnrvORVB/Ol1FZx7XTkmclyHvBBxtOyTEvfVUmxNyuqUhseK/NEhOoeiYCGGb
         rseg==
X-Gm-Message-State: APt69E1JpslAf7Bn8j+kEZMY3EtWQMlDA1loKn9dHzkQowZPrmYfSSo5
        vFXnNXlGvU2/WIE5+Ut/ZVCi+VYv4UL4kkBgejexwpXvOEA=
X-Google-Smtp-Source: AAOMgpc3b9DNT52+/413Agu1Us/BZcUtkgo8JJa0ZxatTMJAW2XQP4Cfba4lLyeB+kaBCIqFFqIXio6f5mVW5y3tlkg=
X-Received: by 2002:a62:b612:: with SMTP id j18-v6mr25245868pff.199.1530533760229;
 Mon, 02 Jul 2018 05:16:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:de2:0:0:0:0 with HTTP; Mon, 2 Jul 2018 05:15:39
 -0700 (PDT)
In-Reply-To: <b9188b32-d50a-4498-a05b-5f0e589bf985@gmail.com>
References: <38c5a8ad-c192-74b9-b2ff-9eb2a3386930@gmail.com>
 <1530493827.2749.8.camel@themaw.net> <1530495726.2749.13.camel@themaw.net>
 <1bbf3634-6c2a-f40e-a9d3-9d6ffc9a0562@gmail.com> <1530526820.9527.4.camel@themaw.net>
 <b9188b32-d50a-4498-a05b-5f0e589bf985@gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 2 Jul 2018 14:15:39 +0200
Message-ID: <CACT4Y+YanGz1DNav=cxDj1ianjmAKnA4s7wuhhop2RzrOsKAUQ@mail.gmail.com>
Subject: Re: [PATCH upstream] KASAN: slab-out-of-bounds Read in getname_kernel
To:     tomas <tomasbortoli@gmail.com>
Cc:     Ian Kent <raven@themaw.net>, LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>, autofs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 2, 2018 at 1:55 PM, tomas <tomasbortoli@gmail.com> wrote:
> Yes, thanks. Please use my full name, Tomas Bortoli.


Please also include:

Reported-by: syzbot+60c837b428dc84e83a93@syzkaller.appspotmail.com

from the original bug report. This this help to keep automatic testing
process running.

Thanks


>
> On 07/02/2018 12:20 PM, Ian Kent wrote:
>> On Mon, 2018-07-02 at 10:31 +0200, tomas wrote:
>>> Hi Ian,
>>>
>>> you are welcome!
>>>
>>> yes your patch is much better. You should just put the "_IOC_NR" macro
>>> around "cmd" in the lines added to "validate_dev_ioctl" to make it work.
>> LOL, yes, that was a dumb mistake.
>>
>> I'll send it to Andrew Morton, after some fairly simple sanity testing,
>> with both our Signed-off-by added.
>>
>>> Tomas
>>>
>>>
>>> On 07/02/2018 03:42 AM, Ian Kent wrote:
>>>> On Mon, 2018-07-02 at 09:10 +0800, Ian Kent wrote:
>>>>> On Mon, 2018-07-02 at 00:04 +0200, tomas wrote:
>>>>>> Hi,
>>>>>>
>>>>>> I've looked into this issue found by Syzbot and I made a patch:
>>>>>>
>>>>>> https://syzkaller.appspot.com/bug?id=d03abd8b42847f7f69b1d1d7f97208ae425
>>>>>> b116
>>>>>> 3
>>>>> Umm ... oops!
>>>>>
>>>>> Thanks for looking into this Tomas.
>>>>>
>>>>>> The autofs subsystem does not check that the "path" parameter is present
>>>>>> within the "param" struct passed by the userspace in case the
>>>>>> AUTOFS_DEV_IOCTL_OPENMOUNT_CMD command is passed. Indeed, it assumes a
>>>>>> path is always provided (though a path is not always present, as per how
>>>>>> the struct is defined:
>>>>>> https://github.com/torvalds/linux/blob/master/include/uapi/linux/auto_de
>>>>>> v-io
>>>>>> ct
>>>>>> l.h#L89).
>>>>>> Skipping the check provokes an oob read in "strlen", called by
>>>>>> "getname_kernel", in turn called by the autofs to assess the length of
>>>>>> the non-existing path.
>>>>>>
>>>>>> To solve it, modify the "validate_dev_ioctl" function to check also that
>>>>>> a path has been provided if the command is
>>>>>> AUTOFS_DEV_IOCTL_OPENMOUNT_CMD.
>>>>>>
>>>>>>
>>>>>> --- b/fs/autofs/dev-ioctl.c    2018-07-01 23:10:16.059728621 +0200around
>>>>>> +++ a/fs/autofs/dev-ioctl.c    2018-07-01 23:10:24.311792133 +0200
>>>>>> @@ -136,6 +136,9 @@ static int validate_dev_ioctl(int cmd, s
>>>>>>              goto out;
>>>>>>          }
>>>>>>      }
>>>>>> +    /* AUTOFS_DEV_IOCTL_OPENMOUNT_CMD without path */
>>>>>> +    else if(_IOC_NR(cmd) == AUTOFS_DEV_IOCTL_OPENMOUNT_CMD)
>>>>>> +        return -EINVAL;
>>>>> My preference is to put the comment inside the else but ...
>>>>>
>>>>> There's another question, should the check be done in
>>>>> autofs_dev_ioctl_openmount() in the same way it's checked in other
>>>>> ioctls that need a path, such as in autofs_dev_ioctl_requester()
>>>>> and autofs_dev_ioctl_ismountpoint()?
>>>>>
>>>>> For consistency I'd say it should.
>>>>>
>>>>>>
>>>>>>      err = 0;You should just put the "_IOC_NR" directive around "cmd" in
>>>>>> the lines added to "validate_dev_ioctl" to make it work.
>>>>>>  out:
>>>>>>
>>>>>>
>>>>>> Tested and solves the issue on Linus' main git tree.
>>>>>>
>>>>>>
>>>> Or perhaps this (not even compile tested) patch would be better?
>>>>
>>>> autofs - fix slab out of bounds read in getname_kernel()
>>>>
>>>> From: Ian Kent <raven@themaw.net>
>>>>
>>>> The autofs subsystem does not check that the "path" parameter is
>>>> present for all cases where it is required when it is passed in
>>>> via the "param" struct.
>>>>
>>>> In particular it isn't checked for the AUTOFS_DEV_IOCTL_OPENMOUNT_CMD
>>>> ioctl command.
>>>>
>>>> To solve it, modify validate_dev_ioctl() function to check that a
>>>> path has been provided for ioctl commands that require it.
>>>> ---
>>>>  fs/autofs/dev-ioctl.c |   15 +++++++--------
>>>>  1 file changed, 7 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/fs/autofs/dev-ioctl.c b/fs/autofs/dev-ioctl.c
>>>> index ea4ca1445ab7..61c63715c3fb 100644
>>>> --- a/fs/autofs/dev-ioctl.c
>>>> +++ b/fs/autofs/dev-ioctl.c
>>>> @@ -135,6 +135,11 @@ static int validate_dev_ioctl(int cmd, struct
>>>> autofs_dev_ioctl *param)
>>>>                             cmd);
>>>>                     goto out;
>>>>             }
>>>> +   } else if (cmd == AUTOFS_DEV_IOCTL_OPENMOUNT_CMD ||
>>>> +              cmd == AUTOFS_DEV_IOCTL_REQUESTER_CMD ||
>>>> +              cmd == AUTOFS_DEV_IOCTL_ISMOUNTPOINT_CMD) {
>>>> +           err = -EINVAL;
>>>> +           goto out;
>>>>     }
>>>>
>>>>     err = 0;
>>>> @@ -433,10 +438,7 @@ static int autofs_dev_ioctl_requester(struct file *fp,
>>>>     dev_t devid;
>>>>     int err = -ENOENT;
>>>>
>>>> -   if (param->size <= AUTOFS_DEV_IOCTL_SIZE) {
>>>> -           err = -EINVAL;
>>>> -           goto out;
>>>> -   }
>>>> +   /* param->path has already been checked */
>>>>
>>>>     devid = sbi->sb->s_dev;
>>>>
>>>> @@ -521,10 +523,7 @@ static int autofs_dev_ioctl_ismountpoint(struct file
>>>> *fp,
>>>>     unsigned int devid, magic;
>>>>     int err = -ENOENT;
>>>>
>>>> -   if (param->size <= AUTOFS_DEV_IOCTL_SIZE) {
>>>> -           err = -EINVAL;
>>>> -           goto out;
>>>> -   }
>>>> +   /* param->path has already been checked */
>>>>
>>>>     name = param->path;
>>>>     type = param->ismountpoint.in.type;
>>>
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller+unsubscribe@googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
