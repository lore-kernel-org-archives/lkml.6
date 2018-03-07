Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934055AbeCGQUo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 11:20:44 -0500
Received: from mail-wm0-f54.google.com ([74.125.82.54]:52155 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933335AbeCGQUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 11:20:40 -0500
X-Google-Smtp-Source: AG47ELt0jUD2FymUvXLrFz0F4QjLsfpkC3hU/b3l2yt4Ll8FY5NmmpXlVEqFBGgIOqPcB3NZcwRXJA==
Subject: Re: [RFC PATCH] ASoC: dapm: add support to pinctrl dapm
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20180305123213.2045-1-srinivas.kandagatla@linaro.org>
 <20180305155208.GK8588@sirena.org.uk>
 <21635274-1d7b-5ed9-6832-2e12fd844f7a@linaro.org>
 <20180307151329.GJ7290@sirena.org.uk>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <a9ebf59b-401b-27b2-f6d8-025438f0e16e@linaro.org>
Date: Wed, 7 Mar 2018 16:20:37 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180307151329.GJ7290@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/03/18 15:13, Mark Brown wrote:
> On Mon, Mar 05, 2018 at 08:35:48PM +0000, Srinivas Kandagatla wrote:
>> On 05/03/18 15:52, Mark Brown wrote:
> 
>>> This doesn't look right - we're trying to synchronize with the DAPM
>>> async queue from something that should be run inside that very queue.
>>> What is this supposed to be doing?
> 
>> I thought this is supposed to ensure that any pending asynchronous I/O is
>> completed before touching pinctrl framework.
> 
> No, it completes all the pending DAPM operations.  async I/O is part of
> that but it's not the only thing.

Thanks for explaining, I will remove the synchronizing part and send a 
next version,

thanks,
srini
> 
