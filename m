Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932753AbeCISpV (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 13:45:21 -0500
Received: from mail-vk0-f67.google.com ([209.85.213.67]:41116 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932385AbeCISpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 13:45:18 -0500
X-Google-Smtp-Source: AG47ELuXeCWV04J8i8K83CVY8O6CsDmmJIOysRzXFWydJKpyg4JtYATo8GA5ITVTwUEDx+SEuiIj+7+nYAQTbLCyTqw=
MIME-Version: 1.0
In-Reply-To: <20180309125050.GD5252@sirena.org.uk>
References: <20180308200653.GA47801@beast> <20180309125050.GD5252@sirena.org.uk>
From: Kees Cook <keescook@chromium.org>
Date: Fri, 9 Mar 2018 10:45:16 -0800
X-Google-Sender-Auth: -oHoojcSU1JdbGa3XWtFxCzQHCQ
Message-ID: <CAGXu5jJo2JVXKV+nieGwzH0XOPpzzo4DmYy0L05iZD6wwO1vGg@mail.gmail.com>
Subject: Re: [PATCH] ASoC: soc-core: Add missing NULL check
To: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.com>, Pavel Machek <pavel@ucw.cz>,
        Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
        moderated for non-subscribers <alsa-devel@alsa-project.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 9, 2018 at 4:50 AM, Mark Brown <broonie@kernel.org> wrote:
> On Thu, Mar 08, 2018 at 12:06:53PM -0800, Kees Cook wrote:
>
>> If a codec is not attached to the sound soc, a NULL deref is possible as a
>> regular user in /sys.
>
> I can't parse this, sorry.  What is the "sound soc"?

SoC's sound component? I'm not sure either. :) I was just sending the
patch that I mentioned from the thread where Pavel mentioned this
Oops.

Pavel, can you isolate the specific file that is causing the oops?
(Maybe this patch should be a WARN() instead of silent return 0, since
we still don't want to crash, but it should be considered a bug...)

>
>> +++ b/sound/soc/soc-core.c
>> @@ -137,6 +137,9 @@ static ssize_t soc_codec_reg_show(struct snd_soc_codec *codec, char *buf,
>>       size_t total = 0;
>>       loff_t p = 0;
>>
>> +     if (!codec || !codec->driver)
>> +             return 0;
>> +
>
> How are we managing to create a sysfs file for a CODEC which doesn't
> have a CODEC struct associated with it?  That is obviously nonsensical
> and suggests we've got some more serious problem going on here - if
> there's no CODEC those sysfs attributes simply shouldn't be there.

No idea! Hopefully Pavel has more details...

-Kees

-- 
Kees Cook
Pixel Security
