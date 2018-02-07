Return-Path: <ulfalizer@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518046986; cv=none;
        d=google.com; s=arc-20160816;
        b=UK79s0/0JcXu0cqG2OsNQBiOFmEnU0oDCxeIsGnCHDmafuhW6BSyUFBx11qZfdcNRf
         wVw1t0ol2KQ5HR+CumvinfqjazlPhfbMlKwShOG9JkdnFtdNwLwPzVtPV8pyzGtMs+xm
         kpCho4USUFSKj9G2AO40TR6muAJ8t2rDMPkM/0OcMSTi21c5n+xAItRFw5XGFcNA+FnV
         RFliF8NaAjf/jJK0oEFkm65j430px5HOgp7q3XteplZA/VqUrxCK6oHKhtM4J389tnlt
         20P1vxyky+9JHKPcTOGmxVT9qNXtwZ+hUXjTobGnUeB9aeozU9WheNC/wnPN/9hK6EAY
         FBVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=1aPTyZgD9M43qYgqUx40yXeCvtFg9TuBMSNm9m2uqXg=;
        b=rdK0n0m3c3H8jiMS6q3T/imfM7VTZrWiU7oIt/IDdXbIFJMlre9bWTkPfJRZLcWO7Q
         KDQruPYuS32/RAAKUtJ/rpFGj+gtMphyI1ywlg00ieMOtKq0/D2iAskVmRNSQywfbC+L
         kF56BtRnuCr29sRIxScNxn7S8Iu/81f4JsL2WJrEj+OoDsDVpQRMxYue2d1T/oFBBOcc
         SHLZHJqW2VupLNsZcDaY//Ron4DAUCWA61F8Y59aCpC+2woLjF4APuRInZzCuGqjyHys
         dVLa8GergaVfQcupome/VQfz1loZcwRvMgyPGOJjTx9fJorOcxHJkNVQHj9UMjT1PC3J
         zuEQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=sLQ3kwhq;
       spf=pass (google.com: domain of ulfalizer@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulfalizer@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=sLQ3kwhq;
       spf=pass (google.com: domain of ulfalizer@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulfalizer@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x224JE3/Rq7EXsO44yeQ7qhC+LLxzlg65VKxbKiQHOFoFh5uDv/ycPXQ9LMW9Nd6FtwABYqe+lqB5d5tFDc+8/To=
MIME-Version: 1.0
In-Reply-To: <1517877294-4826-6-git-send-email-yamada.masahiro@socionext.com>
References: <1517877294-4826-1-git-send-email-yamada.masahiro@socionext.com> <1517877294-4826-6-git-send-email-yamada.masahiro@socionext.com>
From: Ulf Magnusson <ulfalizer@gmail.com>
Date: Thu, 8 Feb 2018 00:43:05 +0100
Message-ID: <CAFkk2KRpb2aGNS4DP3iwqbZNXcAdXyjHsS1MrsYUgKUm-6vAUA@mail.gmail.com>
Subject: Re: [PATCH 05/14] kconfig: remove 'config*' pattern from .gitignnore
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>,
	Nicolas Pitre <nicolas.pitre@linaro.org>, "Luis R . Rodriguez" <mcgrof@suse.com>,
	Randy Dunlap <rdunlap@infradead.org>, Sam Ravnborg <sam@ravnborg.org>,
	Michal Marek <michal.lkml@markovi.net>, Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591609778319723045?=
X-GMAIL-MSGID: =?utf-8?q?1591787637472934764?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 6, 2018 at 1:34 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> I could not figure out why this pattern should be ignored.
> Checking commit 1e65174a3378 ("Add some basic .gitignore files")
> did not help.
>
> Let's remove this pattern, then see if it is really needed.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
>  scripts/kconfig/.gitignore | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/scripts/kconfig/.gitignore b/scripts/kconfig/.gitignore
> index 51f1c87..a76856e 100644
> --- a/scripts/kconfig/.gitignore
> +++ b/scripts/kconfig/.gitignore
> @@ -1,7 +1,6 @@
>  #
>  # Generated files
>  #
> -config*
>  *.lex.c
>  *.tab.c
>  *.tab.h
> --
> 2.7.4
>

Reviewed-by: Ulf Magnusson <ulfalizer@gmail.com>
