Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935244AbeCENuQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 08:50:16 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50615 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933502AbeCENuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 08:50:13 -0500
X-Google-Smtp-Source: AG47ELsHU8UOGnz/+Dczs6LYxqc73pvekykRcxoyTtNKKbgWyvRON41kF0lTmLMoQeLE9bbIDY9mNQ==
Subject: Re: [PATCH 8/9] ASoC: Intel: bytcr_rt5640: Drop unwanted
 ignore_suspend settings
From: Hans de Goede <hdegoede@redhat.com>
To: Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
References: <20180218220146.22485-1-hdegoede@redhat.com>
 <20180218220146.22485-9-hdegoede@redhat.com>
 <20180301162215.GC12864@sirena.org.uk>
 <55819630-6198-6227-63ef-69311b21b255@redhat.com>
 <20180301164819.GD12864@sirena.org.uk>
 <2aa03d98-7f61-0699-98d6-ac3ca3497c41@redhat.com>
 <20180301171744.GE12864@sirena.org.uk>
 <8ed79e1c-0a64-47d5-8076-9febfe896d3d@redhat.com>
Message-ID: <1fb05e12-01b1-b3f3-eef3-6f0fe3d2a740@redhat.com>
Date: Mon, 5 Mar 2018 14:50:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <8ed79e1c-0a64-47d5-8076-9febfe896d3d@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 04-03-18 15:11, Hans de Goede wrote:
> Hi,
> 
> On 01-03-18 18:17, Mark Brown wrote:
>> On Thu, Mar 01, 2018 at 05:58:35PM +0100, Hans de Goede wrote:
>>> On 01-03-18 17:48, Mark Brown wrote:
>>
>>>> That sounds like what's missing is hookup of whatever the DSP uses to
>>>> wake the system when it's getting to the bottom of the buffer?  That's
>>>> the normal way this stuff is implemented anyway.
>>
>>> I'm afraid there is a lot more missing, at least from a standard Linux
>>> distro pov, just waking up is not enough, we need to also wakeup
>>> userspace to get the mp3-player (or whatever) to refill the buffer,
>>> but preferably without waking up the GPU, turning on the screen, etc.
>>
>>> AFAIK support for this is currently completely missing, standard Linux
>>> userspace currently treats suspend-2-idle as a a full suspend and any
>>> wakeup as a full wakeup.
>>
>> Sure, but do such userspaces exist - ChromeOS or something for example?
> 
> ChromeOS has a more or less standard userspace I believe.
> 
>>> So AFAICT currently the ignore-suspend flag is currently not useful
>>> and as the commit message mentions IIRC there were added to fix some
>>> issues with suspend/resume in the past.
>>
>> Is it possible the issue was playback during suspend?
> 
> There was an issue with suspend being blocked (so the machine not suspending)
> if audio was playing because of one the suspend callbacks returning
> an error. I believe the ignore_suspend settings where added as a workaround
> for that and that is no longer a problem.

To be precise (I just got a bugzilla email because someone added a
comment) I believe the ignore_suspend settings were added in an
attempt to fix / workaround this bug:

https://bugzilla.kernel.org/show_bug.cgi?id=111481

And not to allow audio to keep playing while suspended.

Regards,

Hans
