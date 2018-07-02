Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F52C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 11:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35B0F25C57
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 11:55:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="suQygYhm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35B0F25C57
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754493AbeGBLzz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 07:55:55 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40270 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753397AbeGBLzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 07:55:53 -0400
Received: by mail-ed1-f66.google.com with SMTP id e19-v6so689243edq.7;
        Mon, 02 Jul 2018 04:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=RxrMUVGDhR3GC/B2L1wpEqprgsmh4736CIMcI8Fd+JY=;
        b=suQygYhmdUbAbSLIKmnvlMSGhIJlzcE7JZtjccKnu1XZlPDJXWK6mJCDOV8xsLBG4C
         C0OxCNww1FmbynVzv04QwXBPnYWs+jfdyt8lA+Fg3hyshwuFOJnhkV/kdCwaT9BVdOee
         3vtTgB/0fXUe2WPoCX3Dz7Z2woXOv73kSH+YuoJnImnX7KCwGwjDdXtD2sPRyhmU1V5+
         csMN6GDiOSXP3VocqK/JUU+lXxMc/0fG9Zw0wkVJ41MNCYWbXOtLrTuybMFs4NPYM2A4
         qNpLKFn1IGZ/sf87O4lqRSck61WOkVV3qWxzpUYLY5D9L+0qeWwb6DOQtZIb7Hiw76rd
         AUtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=RxrMUVGDhR3GC/B2L1wpEqprgsmh4736CIMcI8Fd+JY=;
        b=Ihey03P4rbko29VDD0SMhlHU93aQCb1xEUHfxT6NoPk9Bovowyaj/XprCnx8EHhFc9
         E8anXiS5ao84iFKCbRskvf3dtARzcpN2CT72+14g3jD9aZOA2P8eHjo/sL5ybb00wFn9
         PrlJwnaEEMw326zDAhqwr5YHzGm8NZhyTLBBGjgrx4fAhKwLRBvUc+910IAEu+j9oNwQ
         VIWOJux/o+t62ocd9j3B8em6wmQmUQ/GDGNHBRn/arl7aLm9dX/ZL1UD3tYEnVAl2Gd2
         r8pTG21VgtSj5Md+XqutoMXY5RTLooL5vsKb4wQhZfnzNf2uek0mTBJr8wrTyTG4O2xs
         SBnw==
X-Gm-Message-State: APt69E0vEsMsb1GQtEsmjGJLyP/Oo7q525OAKXZW4R+WAy4bXJVmFZNT
        oopJFOxjEiVZr7q/ybXF3rXxAErz
X-Google-Smtp-Source: AAOMgpcc/hgqFpyvUPmOZpSO/fIPNZDxmv3iaxkpnIkLI4mi7Cm/ovQasGGjXT8tqN6jlcFqUnDeRQ==
X-Received: by 2002:a50:d9c7:: with SMTP id x7-v6mr23865751edj.95.1530532551362;
        Mon, 02 Jul 2018 04:55:51 -0700 (PDT)
Received: from [192.168.42.231] (pd-18-120-80.service.infuturo.it. [151.18.120.80])
        by smtp.gmail.com with ESMTPSA id s21-v6sm7237537edr.62.2018.07.02.04.55.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 04:55:50 -0700 (PDT)
Subject: Re: [PATCH upstream] KASAN: slab-out-of-bounds Read in getname_kernel
To:     Ian Kent <raven@themaw.net>
Cc:     linux-kernel@vger.kernel.org, syzkaller@googlegroups.com,
        autofs@vger.kernel.org
References: <38c5a8ad-c192-74b9-b2ff-9eb2a3386930@gmail.com>
 <1530493827.2749.8.camel@themaw.net> <1530495726.2749.13.camel@themaw.net>
 <1bbf3634-6c2a-f40e-a9d3-9d6ffc9a0562@gmail.com>
 <1530526820.9527.4.camel@themaw.net>
From:   tomas <tomasbortoli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=tomasbortoli@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <b9188b32-d50a-4498-a05b-5f0e589bf985@gmail.com>
Date:   Mon, 2 Jul 2018 13:55:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1530526820.9527.4.camel@themaw.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, thanks. Please use my full name, Tomas Bortoli.

Cheers


On 07/02/2018 12:20 PM, Ian Kent wrote:
> On Mon, 2018-07-02 at 10:31 +0200, tomas wrote:
>> Hi Ian,
>>
>> you are welcome!
>>
>> yes your patch is much better. You should just put the "_IOC_NR" macro
>> around "cmd" in the lines added to "validate_dev_ioctl" to make it work.
> LOL, yes, that was a dumb mistake.
>
> I'll send it to Andrew Morton, after some fairly simple sanity testing,
> with both our Signed-off-by added.
>
>> Tomas
>>
>>
>> On 07/02/2018 03:42 AM, Ian Kent wrote:
>>> On Mon, 2018-07-02 at 09:10 +0800, Ian Kent wrote:
>>>> On Mon, 2018-07-02 at 00:04 +0200, tomas wrote:
>>>>> Hi,
>>>>>
>>>>> I've looked into this issue found by Syzbot and I made a patch:
>>>>>
>>>>> https://syzkaller.appspot.com/bug?id=d03abd8b42847f7f69b1d1d7f97208ae425
>>>>> b116
>>>>> 3
>>>> Umm ... oops!
>>>>
>>>> Thanks for looking into this Tomas.
>>>>
>>>>> The autofs subsystem does not check that the "path" parameter is present
>>>>> within the "param" struct passed by the userspace in case the
>>>>> AUTOFS_DEV_IOCTL_OPENMOUNT_CMD command is passed. Indeed, it assumes a
>>>>> path is always provided (though a path is not always present, as per how
>>>>> the struct is defined:
>>>>> https://github.com/torvalds/linux/blob/master/include/uapi/linux/auto_de
>>>>> v-io
>>>>> ct
>>>>> l.h#L89).
>>>>> Skipping the check provokes an oob read in "strlen", called by
>>>>> "getname_kernel", in turn called by the autofs to assess the length of
>>>>> the non-existing path.
>>>>>
>>>>> To solve it, modify the "validate_dev_ioctl" function to check also that
>>>>> a path has been provided if the command is
>>>>> AUTOFS_DEV_IOCTL_OPENMOUNT_CMD.
>>>>>
>>>>>
>>>>> --- b/fs/autofs/dev-ioctl.c    2018-07-01 23:10:16.059728621 +0200around
>>>>> +++ a/fs/autofs/dev-ioctl.c    2018-07-01 23:10:24.311792133 +0200
>>>>> @@ -136,6 +136,9 @@ static int validate_dev_ioctl(int cmd, s
>>>>>              goto out;
>>>>>          }
>>>>>      }
>>>>> +    /* AUTOFS_DEV_IOCTL_OPENMOUNT_CMD without path */
>>>>> +    else if(_IOC_NR(cmd) == AUTOFS_DEV_IOCTL_OPENMOUNT_CMD)
>>>>> +        return -EINVAL;
>>>> My preference is to put the comment inside the else but ...
>>>>
>>>> There's another question, should the check be done in
>>>> autofs_dev_ioctl_openmount() in the same way it's checked in other
>>>> ioctls that need a path, such as in autofs_dev_ioctl_requester()
>>>> and autofs_dev_ioctl_ismountpoint()?
>>>>
>>>> For consistency I'd say it should.
>>>>
>>>>>  
>>>>>      err = 0;You should just put the "_IOC_NR" directive around "cmd" in
>>>>> the lines added to "validate_dev_ioctl" to make it work.
>>>>>  out:
>>>>>
>>>>>
>>>>> Tested and solves the issue on Linus' main git tree.
>>>>>
>>>>>
>>> Or perhaps this (not even compile tested) patch would be better?
>>>
>>> autofs - fix slab out of bounds read in getname_kernel()
>>>
>>> From: Ian Kent <raven@themaw.net>
>>>
>>> The autofs subsystem does not check that the "path" parameter is
>>> present for all cases where it is required when it is passed in
>>> via the "param" struct.
>>>
>>> In particular it isn't checked for the AUTOFS_DEV_IOCTL_OPENMOUNT_CMD
>>> ioctl command.
>>>
>>> To solve it, modify validate_dev_ioctl() function to check that a
>>> path has been provided for ioctl commands that require it.
>>> ---
>>>  fs/autofs/dev-ioctl.c |   15 +++++++--------
>>>  1 file changed, 7 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/fs/autofs/dev-ioctl.c b/fs/autofs/dev-ioctl.c
>>> index ea4ca1445ab7..61c63715c3fb 100644
>>> --- a/fs/autofs/dev-ioctl.c
>>> +++ b/fs/autofs/dev-ioctl.c
>>> @@ -135,6 +135,11 @@ static int validate_dev_ioctl(int cmd, struct
>>> autofs_dev_ioctl *param)
>>>  				cmd);
>>>  			goto out;
>>>  		}
>>> +	} else if (cmd == AUTOFS_DEV_IOCTL_OPENMOUNT_CMD ||
>>> +		   cmd == AUTOFS_DEV_IOCTL_REQUESTER_CMD ||
>>> +		   cmd == AUTOFS_DEV_IOCTL_ISMOUNTPOINT_CMD) {
>>> +		err = -EINVAL;
>>> +		goto out;
>>>  	}
>>>  
>>>  	err = 0;
>>> @@ -433,10 +438,7 @@ static int autofs_dev_ioctl_requester(struct file *fp,
>>>  	dev_t devid;
>>>  	int err = -ENOENT;
>>>  
>>> -	if (param->size <= AUTOFS_DEV_IOCTL_SIZE) {
>>> -		err = -EINVAL;
>>> -		goto out;
>>> -	}
>>> +	/* param->path has already been checked */
>>>  
>>>  	devid = sbi->sb->s_dev;
>>>  
>>> @@ -521,10 +523,7 @@ static int autofs_dev_ioctl_ismountpoint(struct file
>>> *fp,
>>>  	unsigned int devid, magic;
>>>  	int err = -ENOENT;
>>>  
>>> -	if (param->size <= AUTOFS_DEV_IOCTL_SIZE) {
>>> -		err = -EINVAL;
>>> -		goto out;
>>> -	}
>>> +	/* param->path has already been checked */
>>>  
>>>  	name = param->path;
>>>  	type = param->ismountpoint.in.type;
>>

