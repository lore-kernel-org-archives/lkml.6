Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933100AbeEWNnG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 09:43:06 -0400
Received: from mga14.intel.com ([192.55.52.115]:34199 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932876AbeEWNnB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 09:43:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,433,1520924400";
   d="scan'208";a="61050816"
Subject: Re: [alsa-devel] [RFC/RFT PATCH] ASoC: topology: Improve backwards
 compatibility with v4 topology files
To: Mark Brown <broonie@kernel.org>
Cc: Guenter Roeck <groeck@google.com>, Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>,
        Chintan Patel <chintan.m.patel@intel.com>,
        Guenter Roeck <groeck@chromium.org>
References: <20180522165842.233949-1-groeck@google.com>
 <fb9aebba-919a-2e80-aec7-2fd44e5e1861@linux.intel.com>
 <20180523082424.GA4828@sirena.org.uk>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <521b23cd-f083-6a19-1374-fde7057c869b@linux.intel.com>
Date: Wed, 23 May 2018 08:42:59 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180523082424.GA4828@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/23/18 3:24 AM, Mark Brown wrote:
> On Tue, May 22, 2018 at 02:59:35PM -0500, Pierre-Louis Bossart wrote:
> 
>> I am also not convinced by the notion that maintaining topology files is
>> only a userspace/distro issue. This would mean some distros will have access
>> to the required topology files, possibly enabling DSP processing
>> capabilities, but other will not and will not be able to enable even basic
>> playback/capture. Just like we have a basic firmware with limited
>> functionality in /lib/firmware/intel, it would make sense to require a basic
>> .conf file in alsa-lib for every upstream machine driver - along possibly
>> with a basic UCM file so that audio works no matter what distro people use.
> 
> The point here is that people should be able to update their kernel
> without updating their userspace so things have to work with whatever
> they have right now - anything that relies on shipping new firmware or
> configuration files to userspace is a problem.

Agree.

My point was a bit different: distributions like Gallium start without 
the relevant topology files and UCM settings, and we should have a 
reference to quickly enable audio without having to borrow and modify 
files from another distro. I faced this issue when I worked with the 
Gallium folks to enable audio on Rambi and Cyan Chromebooks and ended-up 
creating this reference myself.
