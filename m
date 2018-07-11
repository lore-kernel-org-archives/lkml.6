Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D79C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 17:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8388B20C0C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 17:35:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8388B20C0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732921AbeGKRk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 13:40:27 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40214 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732519AbeGKRk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 13:40:27 -0400
Received: by mail-wm0-f68.google.com with SMTP id z13-v6so3394957wma.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 10:35:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0Mc9T0cK3SomEsBSAYC1T7bWSwBgZZ+GVQJfeRumY+E=;
        b=jrgratXoIgIkHYDs6xVOxLgxHbUHcE1TxxzZ3GbFXMTJXPObThd3GvUbJSwCg1AZWA
         f5UkB01m5tBHUJC+dsJGyGjeRYZ+f2qjeGGjGGDO3vdf91pmHOqtG+C6L8N/o2tD2dqJ
         fAmIxYhmr3do5Pe7K+6sfMAFEDAuY6Azt1hrHKdRFflrzPW6YI3YzNVZwIkj5C0C8/yA
         h2MdLYZYVBfW9QCOSY772mJJsFvTbmJCCz/a9EBoWbkwGwScZtZy0tXnYWceHq6hTE15
         o0niAfx5LkEiUoaJwLpdITc0m/CMn7RAVxV833VRi/FdxM2GY6wtRBTuRRSUZZkgeLJv
         Vzfw==
X-Gm-Message-State: APt69E0dShh4BRvAGxSJpEHtkB1JPBcJYSK0Zt0Oaz1zBjCE/RWtOP/s
        WuNfdbrejmZjJ6XPWoyM6jY1ug==
X-Google-Smtp-Source: AAOMgpeoAyw8qNqs4k+mZ0fJUn1Y6/DG4b3vgUMPG0SMmn1c746cjWX5fIAPnTHWGtHMQMUZgwTNpw==
X-Received: by 2002:a1c:2094:: with SMTP id g142-v6mr16719173wmg.144.1531330504131;
        Wed, 11 Jul 2018 10:35:04 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id b16-v6sm1782210wrq.62.2018.07.11.10.35.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 10:35:03 -0700 (PDT)
Subject: Re: [PATCH v5 2/3] fbcon: Call WARN_CONSOLE_UNLOCKED() where
 applicable
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
References: <20180628090351.15581-1-hdegoede@redhat.com>
 <20180628090351.15581-3-hdegoede@redhat.com>
 <717e6337-e7a6-7a92-1c1b-8929a25696b5@suse.de>
 <20180711105255.32803a3c@gandalf.local.home>
 <7ec11c96-7dd5-ec12-548e-7c1fa9b883e8@suse.de>
 <d528a539-255c-f019-eb6f-63f0585e0de3@redhat.com>
 <CAKMK7uG-xiCKkxhujL=J6n9ozYfW+fsioGHEmYRxpszVX=5PDg@mail.gmail.com>
 <892782ad-4b97-8eda-f5b0-3a893b3a5f84@redhat.com>
 <CAKMK7uFyPh0sHj7enAU2En4BidODAS+Tis=-UE16xOLQWm8iQA@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <2f37f47c-e28e-77fa-2383-96c7d3e77433@redhat.com>
Date:   Wed, 11 Jul 2018 19:35:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAKMK7uFyPh0sHj7enAU2En4BidODAS+Tis=-UE16xOLQWm8iQA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11-07-18 17:42, Daniel Vetter wrote:
> On Wed, Jul 11, 2018 at 5:35 PM, Hans de Goede <hdegoede@redhat.com> wrote:
>> Hi,
>>
>> On 11-07-18 17:28, Daniel Vetter wrote:
>>>
>>> On Wed, Jul 11, 2018 at 5:14 PM, Hans de Goede <hdegoede@redhat.com>
>>> wrote:
>>>>
>>>> Hi,
>>>>
>>>> On 11-07-18 17:07, Thomas Zimmermann wrote:
>>>>>
>>>>>
>>>>> Hi
>>>>>
>>>>> Am 11.07.2018 um 16:52 schrieb Steven Rostedt:
>>>>>>
>>>>>>
>>>>>>
>>>>>> What if you make lockless_register_fb visible to fbcon, and then we can
>>>>>> have a macro:
>>>>>
>>>>>
>>>>>
>>>>> There are more of these macro invocations under drivers/tty/vt, which
>>>>> also mess up the log during debugging.
>>>>
>>>>
>>>>
>>>> Hmm, so this option is already broken (in a way) then, my first reaction
>>>> to your mail was that we should just remove that option. But that seemed
>>>> a bit harsh to me so I've been working on a fix for the last 10 minutes
>>>> or so.
>>>>
>>>> But if it is already broken I'm tempted to just remove the option and
>>>> be done with it.  We really need less cruft in the fbdev/fbcon code not
>>>> more.
>>>
>>>
>>> Please don't remove it, it makes debugging kms driver issues on
>>> initial modeset (which is usually run from framebuffer_register, while
>>> hodling the console_lock) impossible.
>>
>>
>> OK, so if we don't remove it, we should probably make it so that it
>> can be used without triggering any WARN_ONs, which would require changing
>> the existing WARN_CONSOLE_UNLOCKED() so that the calls from
>> drivers/tty/vt/vt.c
>> also do not trigger it ?
>>
>> I guess one can just ignore the oopses when debugging, but debugging surely
>> would be easier if there are just no oopses ?
> 
> I'd say let's only bother with the ones in fbcon.c. Avoids the trouble
> with having to expose the fb module option to vt.c somehow.

The plan was actually do the things the other way around, add a flag to
vt.c which when set disables the WARN_ON calls and then have fbdev[.ko]
set that when the fb.lockless_fb_register option is set.

> The ones
> in vt.c are as old as the git history (from a quick check at least),
> and in my debugging they never have been annoying (or I somehow didn't
> ever hit them, not idea).

There is a #if 1 #define #else #define empty around the WARN_CONSOLE_UNLOCKED()
call in include/linux/console.h I've the feeling that is there as a hack
to be able to quickly disable the WARN_ONs when debugging.

Have you seen Steven's suggestion which he send about the same time
as your mail I'm replying to here ? I personally think that doing
something like that makes sense (for as long as we have the need
for the lockless_fb_register debug hack).

Note I've 2 patches ready to go to only fix this in fbcon.c, but I
think a more thorough fix makes sense.

Regards,

Hans

