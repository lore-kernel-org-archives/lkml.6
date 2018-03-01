Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033403AbeCAQ6l (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 11:58:41 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38907 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033029AbeCAQ6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 11:58:38 -0500
X-Google-Smtp-Source: AG47ELvbwyl2SZktaWAYZdwdOIg+44R5gNVsP74J5dwXu4GePH8V4M2BMz92Co9eMNNKATR4Hr5pfg==
Subject: Re: [PATCH 8/9] ASoC: Intel: bytcr_rt5640: Drop unwanted
 ignore_suspend settings
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
References: <20180218220146.22485-1-hdegoede@redhat.com>
 <20180218220146.22485-9-hdegoede@redhat.com>
 <20180301162215.GC12864@sirena.org.uk>
 <55819630-6198-6227-63ef-69311b21b255@redhat.com>
 <20180301164819.GD12864@sirena.org.uk>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <2aa03d98-7f61-0699-98d6-ac3ca3497c41@redhat.com>
Date: Thu, 1 Mar 2018 17:58:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180301164819.GD12864@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 01-03-18 17:48, Mark Brown wrote:
> On Thu, Mar 01, 2018 at 05:26:06PM +0100, Hans de Goede wrote:
>> On 01-03-18 17:22, Mark Brown wrote:
>>> On Sun, Feb 18, 2018 at 11:01:45PM +0100, Hans de Goede wrote:
> 
>>>> The ignore_suspend settings were added in an attempt to try and fix
>>>> suspend / resume issues. But they never fully fixed these and now we've
>>>> a proper fix, so lets remove these.
> 
>>> Do these systems not have the ability to continue to play audio through
>>> suspend using the DSP?  That's the sort of thing that ignore_suspend is
>>> normally used for.
> 
>> In theory yes, in practice if we keep ignore_suspend set then we get
>> audio for a couple of more seconds after suspend until the buffers
>> are empty, as we have no code keeping them filled, which is not really
>> useful, since we don't support this in a meaningful way it is better
>> to just do a normal full suspend.
> 
> That sounds like what's missing is hookup of whatever the DSP uses to
> wake the system when it's getting to the bottom of the buffer?  That's
> the normal way this stuff is implemented anyway.

I'm afraid there is a lot more missing, at least from a standard Linux
distro pov, just waking up is not enough, we need to also wakeup
userspace to get the mp3-player (or whatever) to refill the buffer,
but preferably without waking up the GPU, turning on the screen, etc.

AFAIK support for this is currently completely missing, standard Linux
userspace currently treats suspend-2-idle as a a full suspend and any
wakeup as a full wakeup.

So AFAICT currently the ignore-suspend flag is currently not useful
and as the commit message mentions IIRC there were added to fix some
issues with suspend/resume in the past.

Regards,

Hans
