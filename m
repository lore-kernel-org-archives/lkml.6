Return-Path: <keescook@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519773606; cv=none;
        d=google.com; s=arc-20160816;
        b=cRsPvfyBisQ/+5uVmsjvLKYl1MPcAftXw54MMhC9jxHg4IG3jDTEj0pKcY5mSb8nU8
         PuSgfmp4lVqUhjsKkoGMmNgbk00dhs/qbSj6MwSKFMDvvwTpYetzpzTu1yVe0BFNRQhN
         h6a6LwisNFGycJkl69O+F2HXk00Vh0OA3Ob6FFUn5lyOtO9akEX3qZi8Xqg+c7d+6Zzy
         3BAajOWIk6pHxqDiSCU76yw0wZkMrPk92VTAf/XpFuedGgzATSbIYJvmmobnOO+JUgXu
         XyQ+/+4DRuoi1b0Ai/iGGc8FSCnzim2rZyW2Gvl0RofFiXNcxs7NVJywWQ8vF8KOuusc
         jKMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=J1FuwBOujuUzNf891scewCjH5fmMd7isBW+Ne4cV/Uk=;
        b=DTXBxc+1etLIBGpX6bkcevrSlkbnP7/aecMZ5guAudQunviqzu9BPZKjv7G1xdg8Kh
         +1LUO+WfJPbO1Bs4wqZxwPzxG+SMS3e9j1jI+zk6XyzWL+pU7PSqAk9V9KResQ4+b2cR
         e9Lt/aiF/b5hN2agmpAoquEapLu4xsuUrvmiTVArYWTOzS2XeQuBUR+ICf6IJPb1a2KD
         +lSUzv/2TBuwOAZTwomVSu4UTFNrD1hyU6KXxbWNWt5x2KtaZ6lNG322xV57HA5Pcm4s
         bC1QgsuPrDPS5VHXKQvyWFcPltuKk2oCm4aqKdcQsO77f4OYj/2/nHmPk3JL3dr2VECd
         2zBw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=rO9qGZ0N;
       dkim=pass header.i=@chromium.org header.s=google header.b=knc2+Tl9;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=rO9qGZ0N;
       dkim=pass header.i=@chromium.org header.s=google header.b=knc2+Tl9;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AG47ELt19GKJ1RKudo7KN9LuRBIdPUy/Ug2nP5TCFXISywEr9en7xtQj2mv/iZVxlyByC8aGmEH0nE4ji/CqzwcxDFc=
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <20180224024613.24078-5-mcgrof@kernel.org>
References: <20180224024613.24078-1-mcgrof@kernel.org> <20180224024613.24078-5-mcgrof@kernel.org>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 27 Feb 2018 15:20:05 -0800
X-Google-Sender-Auth: Y7o7c07M6dfyi9Foc3kdHyK3KMo
Message-ID: <CAGXu5jLHHtehy7ADhRVv7sRTGQseyOE-JJKbciRD1o4jiJ++hg@mail.gmail.com>
Subject: Re: [PATCH v2 04/11] firmware: simplify CONFIG_FW_LOADER_USER_HELPER_FALLBACK
 further
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, Martin Fuzzey <mfuzzey@parkeon.com>,
	Mimi Zohar <zohar@linux.vnet.ibm.com>, David Howells <dhowells@redhat.com>, pali.rohar@gmail.com,
	Takashi Iwai <tiwai@suse.de>, arend.vanspriel@broadcom.com,
	=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>, nbroeking@me.com,
	Vikram Mulukutla <markivx@codeaurora.org>, stephen.boyd@linaro.org,
	Mark Brown <broonie@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	David Woodhouse <dwmw2@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>,
	Abhay_Salunke@dell.com, bjorn.andersson@linaro.org, jewalt@lgsinnovations.com,
	LKML <linux-kernel@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593248716837062122?=
X-GMAIL-MSGID: =?utf-8?q?1593598129526791153?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 23, 2018 at 6:46 PM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> All CONFIG_FW_LOADER_USER_HELPER_FALLBACK really is, is just a bool,
> initailized at build time. Define it as such. This simplifies the
> logic even further, removing now all explicit #ifdefs around the code.

In the next revision, can you mention that struct
firmware_fallback_config is going to grow in future patches. I spent
too long trying to understand why this wasn't just a two line patch
with only IS_ENABLED... added. :)

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

>
> Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
> ---
>  drivers/base/firmware_loader.c | 25 ++++++++++++++++++-------
>  1 file changed, 18 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/base/firmware_loader.c b/drivers/base/firmware_loader.c
> index 7dd36ace6152..59dba794ce1a 100644
> --- a/drivers/base/firmware_loader.c
> +++ b/drivers/base/firmware_loader.c
> @@ -266,6 +266,22 @@ static inline bool fw_state_is_aborted(struct fw_priv *fw_priv)
>
>  #ifdef CONFIG_FW_LOADER_USER_HELPER
>
> +/**
> + * struct firmware_fallback_config - firmware fallback configuratioon settings
> + *
> + * Helps describe and fine tune the fallback mechanism.
> + *
> + * @force_sysfs_fallback: force the sysfs fallback mechanism to be used
> + *     as if one had enabled CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y.
> + */
> +struct firmware_fallback_config {
> +       bool force_sysfs_fallback;
> +};
> +
> +static const struct firmware_fallback_config fw_fallback_config = {
> +       .force_sysfs_fallback = IS_ENABLED(CONFIG_FW_LOADER_USER_HELPER_FALLBACK),
> +};
> +
>  static inline bool fw_sysfs_done(struct fw_priv *fw_priv)
>  {
>         return __fw_state_check(fw_priv, FW_STATUS_DONE);
> @@ -1151,19 +1167,14 @@ static int fw_load_from_user_helper(struct firmware *firmware,
>         return ret;
>  }
>
> -#ifdef CONFIG_FW_LOADER_USER_HELPER_FALLBACK
> -static bool fw_force_sysfs_fallback(unsigned int opt_flags)
> -{
> -       return true;
> -}
> -#else
>  static bool fw_force_sysfs_fallback(unsigned int opt_flags)
>  {
> +       if (fw_fallback_config.force_sysfs_fallback)
> +               return true;
>         if (!(opt_flags & FW_OPT_USERHELPER))
>                 return false;
>         return true;
>  }
> -#endif
>
>  static bool fw_run_sysfs_fallback(unsigned int opt_flags)
>  {
> --
> 2.16.2
>



-- 
Kees Cook
Pixel Security
