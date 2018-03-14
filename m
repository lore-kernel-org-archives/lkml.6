Return-Path: <mcgrof@kernel.org>
X-Google-Smtp-Source: AG47ELsKMY5/lqzfk1IHFUBUn8haLObsZ2rcKcg8LTv1+Q1yzO3GNNF496hmAEoNkBfFJ0HUVV0M
ARC-Seal: i=1; a=rsa-sha256; t=1521067014; cv=none;
        d=google.com; s=arc-20160816;
        b=F1CDym8drKRjcwBF+RQFV2eSU55MH+uWSZcuBGtiCAhqgIwNXbXdUoNpK5q6oQyaOu
         VAeYXpz3ULiDAiz6XS+ioSGLrrXaPNDMgNQI41D3P+h1xqhND56M1/xcBu7Imd7loTM0
         rg/ANPKm6F0VfTYQvhuiVJbZK7N8niCo2Bm+NZW5IDoz2ws3jQQ1aiyuu+SBf//KmdAi
         WPw8wiw6aVLv6pqRgJe+ljy20BDzvI33ikiAzoms+afD1fOIKLF6MosWVguAROX7Jruz
         cAbMqr5TuDGWaoCHB2GRdLU2Y16HvfxdCTrBWqYsZqOwgFJ1KE17g2NUjEgFVwl4nsGG
         fwFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dmarc-filter:arc-authentication-results;
        bh=egUpRgRQl3/zJE3j+ZeOuQNiYnGcaszC/2PFmVxLzxc=;
        b=P6+J4HF+xRgawxB8ncdhLypB1Zzo6uT1mGodDxLk+IWaiWRSmR73YE9ArdHi9/IK3g
         9CgaMxERxPP6q063cuveRZj6MRhY6ccENmuWRH2D70V+66hjUK26SCWfyel1aQr7wDol
         Jem0D4G2DEThKE7btOwiIGuoG80aDHxHIVm2+SjjP5T2PVYeCXkfOxLvy4tLwDDUYnvo
         ZNi0FQwza5Qq7nUyUklQjr/IpgxaOlhuAKSAsLUJXbKD63Xdanrm1lcfHBjsgRg+I6kZ
         lOx+/LpXstXO2E4tAYPtngYEHDcqJQh6aVDxEHVdlaigWvTqaS1dnWxK6lRqnVf4D9xB
         E/VA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11AC3217D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mcgrof@kernel.org
MIME-Version: 1.0
In-Reply-To: <20180314185347.GA15837@kroah.com>
References: <20180310141501.2214-1-mcgrof@kernel.org> <20180310141501.2214-6-mcgrof@kernel.org>
 <20180314185347.GA15837@kroah.com>
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Date: Wed, 14 Mar 2018 15:36:32 -0700
X-Gmail-Original-Message-ID: <CAB=NE6Ur+hHN6HHBzafJXQ_G9AJggHPKd-jvrPmB79k98aTMDw@mail.gmail.com>
Message-ID: <CAB=NE6Ur+hHN6HHBzafJXQ_G9AJggHPKd-jvrPmB79k98aTMDw@mail.gmail.com>
Subject: Re: [PATCH v3 05/20] firmware: simplify CONFIG_FW_LOADER_USER_HELPER_FALLBACK
 further
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, cantabile.desu@gmail.com, kubakici@wp.pl,
	linux-wireless <linux-wireless@vger.kernel.org>, Kees Cook <keescook@chromium.org>, shuah@kernel.org,
	Martin Fuzzey <mfuzzey@parkeon.com>, Mimi Zohar <zohar@linux.vnet.ibm.com>,
	David Howells <dhowells@redhat.com>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>,
	Takashi Iwai <tiwai@suse.de>, Arend Van Spriel <arend.vanspriel@broadcom.com>,
	=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
	Nicolas Broeking <nbroeking@me.com>, Vikram Mulukutla <markivx@codeaurora.org>,
	Mark Brown <broonie@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	David Woodhouse <dwmw2@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>,
	Abhay Salunke <Abhay_Salunke@dell.com>, Bjorn Andersson <bjorn.andersson@linaro.org>,
	jewalt@lgsinnovations.com, oneukum@suse.com, Alexei Starovoitov <ast@fb.com>,
	Andres Rodriguez <andresx7@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Linux FS Devel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594560421519500389?=
X-GMAIL-MSGID: =?utf-8?q?1594954365815382588?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 14, 2018 at 11:53 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Sat, Mar 10, 2018 at 06:14:46AM -0800, Luis R. Rodriguez wrote:
>> All CONFIG_FW_LOADER_USER_HELPER_FALLBACK really is, is just a bool,
>> initailized at build time. Define it as such. This simplifies the
>> logic even further, removing now all explicit #ifdefs around the code.
>>
>> Acked-by: Kees Cook <keescook@chromium.org>
>> Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
>> ---
>>  drivers/base/firmware_loader.c | 25 ++++++++++++++++++-------
>>  1 file changed, 18 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/base/firmware_loader.c b/drivers/base/firmware_loader.c
>> index 7dd36ace6152..59dba794ce1a 100644
>> --- a/drivers/base/firmware_loader.c
>> +++ b/drivers/base/firmware_loader.c
>> @@ -266,6 +266,22 @@ static inline bool fw_state_is_aborted(struct fw_priv *fw_priv)
>>
>>  #ifdef CONFIG_FW_LOADER_USER_HELPER
>>
>> +/**
>> + * struct firmware_fallback_config - firmware fallback configuratioon settings
>> + *
>> + * Helps describe and fine tune the fallback mechanism.
>> + *
>> + * @force_sysfs_fallback: force the sysfs fallback mechanism to be used
>> + *   as if one had enabled CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y.
>> + */
>> +struct firmware_fallback_config {
>> +     bool force_sysfs_fallback;
>> +};
>
> This is C, why are you messing around with a structure and "getters and
> setters" for a set of simple values?
>
>> +static const struct firmware_fallback_config fw_fallback_config = {
>> +     .force_sysfs_fallback = IS_ENABLED(CONFIG_FW_LOADER_USER_HELPER_FALLBACK),
>> +};
>
> static bool force_sysfs_fallback = IS_ENABLED(CONFIG_FW_LOADER_USER_HELPER_FALLBACK);

For this case yes, but I later expand on this structure for all
fallback configuration items. So we have to start it somewhere.

> Then just read/write the foolish thing, don't make this more complex
> than is needed please.

Please read the final results and let me know what you think.

> There is a "getter and setters are evil" rant somewhere out there
> online, if you really need me to dig up the old tired arguments :)

I don't use them for sport, I use them given the fallback stuff *is*
not something the direct core firmware code should use openly, it will
really depend on if the fallback interface was enabled. As such we
provide wrapper for access into them.

  Luis
