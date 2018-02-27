Return-Path: <keescook@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519774272; cv=none;
        d=google.com; s=arc-20160816;
        b=amjrqDHcVSkEiEG3Msg0wI9LpFDF7aAqHn9NJzNDHRpQHrrF5TwtTR/yjw0ZYMHNX4
         rp2DfFl0X2JqgODBRkc00tJLia1aPegtomPfXlUfWFzfNDFE53t/ysCCenW3MsZhYu/D
         GjM9DQAQDwYFw6J4saX1y69Be1WLfXcafGqdOX9urqxKbFEGpqUc3zptH+5aX0w0ke3m
         KiXuLa8QN9z3Iknj14HhQXKoA+oUICtoAK4HrTMaWGxWTn/HVyle12OFBKDEKVBDhY/c
         ukkYyHNWz5JrJ1Zfki8WiYTJldOkK+WIcDfgTtMZqdYT9ewm695L91uGKhXz5WG3/yfm
         xtNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=hE9Qt6JDqSVwEJpLZA7ZhjGYpkjMZrHKg/sw7jUIvj4=;
        b=HslPW2LDd6Qr42B9UIoWiZQmysdoV/J2B6WLXAaZK8exgy+EX/wb6UZI9rBn2rTlzn
         sirPPx113EJaojATThEK8NiwpLDo3d9jCQw7D/gJwgIo11eNnxNC6lGKve3aETQFAWOl
         RI9JyuPoavTfnjqS4KU++0hsZ94gCcwXMPjc8M9+uYnzDznK5C/m7gQMft196Uxi1OL5
         MlF5hkTLRZNtT3F50//Z4o/jsyCR0PjXwhSoJErVX9y7MMny7ShnNJEaXpXXRrAEl84m
         DE0gnobqJ29/d+bYzT9Cj7An6nnsf7hVnbd2Mjllexgk3cLXRZzMRiCTh6mCw9038m+H
         46uA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=s3c+bc/h;
       dkim=pass header.i=@chromium.org header.s=google header.b=CV3/cZcr;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=s3c+bc/h;
       dkim=pass header.i=@chromium.org header.s=google header.b=CV3/cZcr;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AG47ELvzCJ26dzpXmbReVjym8Md7yiU9a9spGta8OOfLbOqcejB3QsgfUncnp7i4//mvpwrb5VZRapAxSE0ORLGrJEk=
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <20180227232101.20786-4-mcgrof@kernel.org>
References: <20180227232101.20786-1-mcgrof@kernel.org> <20180227232101.20786-4-mcgrof@kernel.org>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 27 Feb 2018 15:31:11 -0800
X-Google-Sender-Auth: O35_liTMPQ-xSFGmTI4lGltPtU0
Message-ID: <CAGXu5jL1mrZ6LqV0WKBY=w_kZzzcSrUD6Z5YqToSS2qmNaS4Fw@mail.gmail.com>
Subject: Re: [RFT 3/7] firmware: make fw_add_devm_name() return 0 if cache present
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: cantabile.desu@gmail.com, Jakub Kicinski <kubakici@wp.pl>,
	Greg KH <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>,
	linux-wireless <linux-wireless@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
	Martin Fuzzey <mfuzzey@parkeon.com>, Mimi Zohar <zohar@linux.vnet.ibm.com>,
	David Howells <dhowells@redhat.com>, pali.rohar@gmail.com, Takashi Iwai <tiwai@suse.de>,
	arend.vanspriel@broadcom.com, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
	nbroeking@me.com, Vikram Mulukutla <markivx@codeaurora.org>, Mark Brown <broonie@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, David Woodhouse <dwmw2@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, Abhay_Salunke@dell.com,
	bjorn.andersson@linaro.org, jewalt@lgsinnovations.com, oneukum@suse.com,
	LKML <linux-kernel@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593598196329346880?=
X-GMAIL-MSGID: =?utf-8?q?1593598828101592490?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 27, 2018 at 3:20 PM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> Currently fw_add_devm_name() returns 1 if the firmware cache
> was already set. This makes it complicated for us to check for
> correctness. It is actually non-fatal if the firmware cache
> is already setup, so just return 0, and simplify the checkers.
>
> Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>

That'll teach me to read all the patches first. ;)

Honestly, I'd just fold this into the prior patch: there's only one
caller and it's exactly about checking the return value.

-Kees

> ---
>  drivers/base/firmware_loader.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/base/firmware_loader.c b/drivers/base/firmware_loader.c
> index 48932581c70c..a385622bf3e1 100644
> --- a/drivers/base/firmware_loader.c
> +++ b/drivers/base/firmware_loader.c
> @@ -403,7 +403,7 @@ static int fw_add_devm_name(struct device *dev, const char *name)
>
>         fwn = fw_find_devm_name(dev, name);
>         if (fwn)
> -               return 1;
> +               return 0;
>
>         fwn = devres_alloc(fw_name_devm_release, sizeof(struct fw_name_devm),
>                            GFP_KERNEL);
> @@ -450,7 +450,7 @@ int assign_fw(struct firmware *fw, struct device *device,
>         if (device && (opt_flags & FW_OPT_UEVENT) &&
>             !(opt_flags & FW_OPT_NOCACHE)) {
>                 ret = fw_add_devm_name(device, fw_priv->fw_name);
> -               if (ret && ret != 1) {
> +               if (ret) {
>                         mutex_unlock(&fw_lock);
>                         return ret;
>                 }
> --
> 2.16.2
>



-- 
Kees Cook
Pixel Security
