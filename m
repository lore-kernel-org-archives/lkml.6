Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752716AbeCDOLN (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 09:11:13 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:32865 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751878AbeCDOLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 09:11:12 -0500
X-Google-Smtp-Source: AG47ELsLKjiSC9qvLAO1mysdcxVXPwNlLrUK/xBfossSBc0vZgVRWR4Jzg/loQe+ZHpiA7+lB8D9/Q==
Subject: Re: [PATCH 8/9] ASoC: Intel: bytcr_rt5640: Drop unwanted
 ignore_suspend settings
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
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <8ed79e1c-0a64-47d5-8076-9febfe896d3d@redhat.com>
Date: Sun, 4 Mar 2018 15:11:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180301171744.GE12864@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 01-03-18 18:17, Mark Brown wrote:
> On Thu, Mar 01, 2018 at 05:58:35PM +0100, Hans de Goede wrote:
>> On 01-03-18 17:48, Mark Brown wrote:
> 
>>> That sounds like what's missing is hookup of whatever the DSP uses to
>>> wake the system when it's getting to the bottom of the buffer?  That's
>>> the normal way this stuff is implemented anyway.
> 
>> I'm afraid there is a lot more missing, at least from a standard Linux
>> distro pov, just waking up is not enough, we need to also wakeup
>> userspace to get the mp3-player (or whatever) to refill the buffer,
>> but preferably without waking up the GPU, turning on the screen, etc.
> 
>> AFAIK support for this is currently completely missing, standard Linux
>> userspace currently treats suspend-2-idle as a a full suspend and any
>> wakeup as a full wakeup.
> 
> Sure, but do such userspaces exist - ChromeOS or something for example?

ChromeOS has a more or less standard userspace I believe.

>> So AFAICT currently the ignore-suspend flag is currently not useful
>> and as the commit message mentions IIRC there were added to fix some
>> issues with suspend/resume in the past.
> 
> Is it possible the issue was playback during suspend?

There was an issue with suspend being blocked (so the machine not suspending)
if audio was playing because of one the suspend callbacks returning
an error. I believe the ignore_suspend settings where added as a workaround
for that and that is no longer a problem.

Pierre-Louis, do you have any input on this / on this patch?

Regards,

Hans
