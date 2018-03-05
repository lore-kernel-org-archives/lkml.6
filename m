Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753107AbeCEUfw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 15:35:52 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33575 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753020AbeCEUfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 15:35:51 -0500
X-Google-Smtp-Source: AG47ELs5YNror8WwZa1V7+YsXDb3mMEJDWscWcLpVYaxRXAKvK2nCsuKAzQQgle+m2nwMWW0EfvYpg==
Subject: Re: [RFC PATCH] ASoC: dapm: add support to pinctrl dapm
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20180305123213.2045-1-srinivas.kandagatla@linaro.org>
 <20180305155208.GK8588@sirena.org.uk>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <21635274-1d7b-5ed9-6832-2e12fd844f7a@linaro.org>
Date: Mon, 5 Mar 2018 20:35:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180305155208.GK8588@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the review,

On 05/03/18 15:52, Mark Brown wrote:
> On Mon, Mar 05, 2018 at 12:32:13PM +0000, srinivas.kandagatla@linaro.org wrote:
> 
>> +int dapm_pinctrl_event(struct snd_soc_dapm_widget *w,
>> +		       struct snd_kcontrol *kcontrol, int event)
>> +{
>> +	struct snd_soc_dapm_pinctrl_priv *priv = w->priv;
>> +	struct pinctrl *p = w->pinctrl;
>> +	struct pinctrl_state *s;
>> +
>> +	if (!p || !priv)
>> +		return -EIO;
>> +
>> +	soc_dapm_async_complete(w->dapm);
> 
> This doesn't look right - we're trying to synchronize with the DAPM
> async queue from something that should be run inside that very queue.
> What is this supposed to be doing?

I thought this is supposed to ensure that any pending asynchronous I/O 
is completed before touching pinctrl framework.

TBH, I have done this inline with regulators/clk dapm events.

--srini
> 
