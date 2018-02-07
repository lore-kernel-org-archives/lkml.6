Return-Path: <pintu.ping@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1517983265; cv=none;
        d=google.com; s=arc-20160816;
        b=ASzP6xS2A/YSB7ng+KzRKajqhq3peCiYzyUYRuzqLd+ulM2uJipkkLhhiuVofI4KVA
         JTSFkHcQ1wpP+D8filcQ89qQwjb6/kKjP9knA+wgO7nYVhP7PNK2GfVXuoBaukZy6op3
         oKSR/+rv4aKJWwPPYqc9mbcHGx7vg8cSfJsFe8OSOtWHBGOw39pPFN9rt+a2PNjPEdPy
         IuB3Ry6HDGwG+JRLehxBgWK/jvHQthoKBsTB8tsaHsQjQqjsut7GtIvKI05hIVUkpDzS
         i8xV7hXMD9QigOvAjWJf1JTAvA7BfpI1LPk4wYl3xjJcystqxw69+1c529T3alEmK7/o
         OH5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:dkim-signature
         :arc-authentication-results;
        bh=4OdiAm4fSHY7JQaziTO8NEFrocNXzAXvX5itE+PDV1Y=;
        b=auI4cXOxZ9q3zLxQOxwJwbgbTNyk30jC7lKZm8FX7AJHm/DOsZndUAP4MA4Sco35Nh
         n9OsDiOEOd+55cevvlYzK5i7iOdyVVhFRrJX0O3w4L8jehJYH6sZIZN99LkFuJ+IWRcO
         /m1mH8lSj999yzDVhHe61gSW/bICNKkQCLt/I3MHrRdxfzaYAmjdDQgYsKD+VlWNzlAf
         KxHcFniHFHLZrMWw8TZ8B/59aXSTrMVT/noUbXpWz5s+3LgQLjcv7aOJBJH6JCVyGcAa
         FULyzs1/uBD5qXXfEye1QijqYA2gXsvrvyr4laRmuxhEcZOvpoiJfRNQQWyDkekozHoN
         NQ+g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=YnfQaiDA;
       spf=pass (google.com: domain of pintu.ping@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=pintu.ping@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=YnfQaiDA;
       spf=pass (google.com: domain of pintu.ping@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=pintu.ping@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x2259HcbynxBo8PwdxX0cnMMM9JzmV3cEUt7EVpLpLvPhBf0ijBYPF6tXwBeZfSuL1G/ak2rVZZI4G35cWFPcZKY=
MIME-Version: 1.0
In-Reply-To: <1517961219-17700-1-git-send-email-daniel.diaz@linaro.org>
References: <1517961219-17700-1-git-send-email-daniel.diaz@linaro.org>
From: Pintu Kumar <pintu.ping@gmail.com>
Date: Wed, 7 Feb 2018 11:31:04 +0530
Message-ID: <CAOuPNLh17DH2nZL86WSWKUKQJr-Z1EY+ZqRFsXRTqK-XMtyx2g@mail.gmail.com>
Subject: Re: [PATCH] selftests/android: Fix line continuation in Makefile
To: =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Cc: Shuah Khan <shuahkh@osg.samsung.com>, linux-kselftest@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>, Darren Hart <dvhart@infradead.org>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>,
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591697740031389880?=
X-GMAIL-MSGID: =?utf-8?q?1591720819991765330?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 7, 2018 at 5:22 AM, Daniel D=C3=ADaz <daniel.diaz@linaro.org> w=
rote:
> The Makefile lacks a couple of line continuation backslashes
> in an `if' clause, which can make the subsequent rsync
> command go awry over the whole filesystem (`rsync -a / /`).
>
>   /bin/sh: -c: line 5: syntax error: unexpected end of file
>   make[1]: [all] Error 1 (ignored)
>   TEST=3D$DIR"_test.sh"; \
>                   if [ -e $DIR/$TEST ]; then
>   /bin/sh: -c: line 2: syntax error: unexpected end of file
>   make[1]: [all] Error 1 (ignored)
>   rsync -a $DIR/$TEST $BUILD_TARGET/;
>   [...a myriad of:]
>   [  rsync: readlink_stat("...") failed: Permission denied (13)]
>   [  skipping non-regular file "..."]
>   [  rsync: opendir "..." failed: Permission denied (13)]
>   [and many other errors...]
>   fi
>   make[1]: fi: Command not found
>   make[1]: [all] Error 127 (ignored)
>   done
>   make[1]: done: Command not found
>   make[1]: [all] Error 127 (ignored)
>
> Signed-off-by: Daniel D=C3=ADaz <daniel.diaz@linaro.org>
> ---
>  tools/testing/selftests/android/Makefile | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/selftests/android/Makefile b/tools/testing/sel=
ftests/android/Makefile
> index 1a74922..f6304d2 100644
> --- a/tools/testing/selftests/android/Makefile
> +++ b/tools/testing/selftests/android/Makefile
> @@ -11,11 +11,11 @@ all:
>                 BUILD_TARGET=3D$(OUTPUT)/$$DIR;   \
>                 mkdir $$BUILD_TARGET  -p;       \
>                 make OUTPUT=3D$$BUILD_TARGET -C $$DIR $@;\
> -               #SUBDIR test prog name should be in the form: SUBDIR_test=
.sh
> +               #SUBDIR test prog name should be in the form: SUBDIR_test=
.sh \
>                 TEST=3D$$DIR"_test.sh"; \
> -               if [ -e $$DIR/$$TEST ]; then
> -                       rsync -a $$DIR/$$TEST $$BUILD_TARGET/;
> -               fi
> +               if [ -e $$DIR/$$TEST ]; then \
> +                       rsync -a $$DIR/$$TEST $$BUILD_TARGET/; \
> +               fi \
>         done

Thanks for your patch.
However, I have copied this Makefile from
tools/testing/selftests/futex/Makefile before modifying it.
If there is a problem with backslash then the same problem must be
there in futex Makefile as well.
Can you compare these 2 Makefile and see if there is any problem.

Also is it because of make version ?
Can you check your make version ?

Thank You!
Pintu

>
>  override define RUN_TESTS
> --
> 2.7.4
>
