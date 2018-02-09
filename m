Return-Path: <keescook@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518209216; cv=none;
        d=google.com; s=arc-20160816;
        b=gAdT+B4LmD0Dt+frAefMYYXtZ7ExVsJ2Mv9+smALxhhTGDll1cNlrIbGbmcoNA8Lx7
         AGjUsIs5iRUtrffiv4JYF2o4VuKYHGEMiY0xzGfEjTsRoUCWKJR7FnCMe5vmQeTtOFFx
         AcMgD6r74HcyijGFXAOuU5IMKNnVUlu9X+IJ3PBMs/nMyIUVr+2Ew9UKy7bhcfrmkbNi
         zXyeNu81pBC1LoX5ezMJtwxwU02F+3PBB3xKnYM1J7lk8TjVStL2/Rtv+PyjipxJfGbl
         6UOF+IDyhN9uQ5pQYMfrmruNaiUMoVVyBqB8et+SonYoc38hUACXqrLew5ypFIL/7Qb0
         pfFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=6PC8hQ9mCf8ZdabxOnS9ErVkr7oe8MONPGfLcC6GHKw=;
        b=wLW9sbT+DxdWDuXNDlSn18Em6Sxpth8pfLIA5CpRuvrSXAWbxPxWYOXzotO/cQn86o
         0VvsOZG0xMi5kbk+EkzLcwaOR1T+CyY3PPeEKO8cSCH/0cASExDSkc7AuBo39jtVTuRx
         whjJPGpfzEXLkelItBZabJSw+DXti11ENfo+wRvA9QudGXrAsB4J1qU/EQR/Q787x0AE
         Fr0wDHyCxnO4wuEUF21wfRv3WZF/wbfoPq4TsUJDyKkP8t+MssjBdC9ane626QhePrFI
         Vw8oWX24oEoPEsdra56K0qNvyp5udCabBSFBsKK5izOSjBvpQI8rnkjxmbmXfo6mwpdp
         kSBw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=pAValYke;
       dkim=pass header.i=@chromium.org header.s=google header.b=K5SR4Kf3;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=pAValYke;
       dkim=pass header.i=@chromium.org header.s=google header.b=K5SR4Kf3;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AH8x226ex87mhLlakQ/VzuPuXoR59JfSdTYF3Qrp3JrCG3ygLeYjQjht7950baiYqVV5REB9sokPp6yji8BHh+8VGNo=
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <20180209124607.akjhncb5sempjqcn@huvuddator>
References: <1518106752-29228-1-git-send-email-yamada.masahiro@socionext.com>
 <1518106752-29228-5-git-send-email-yamada.masahiro@socionext.com>
 <20180209053038.pscoijvowmyudyzf@huvuddator> <CAK7LNATRxYCx9sE1haw815votyA5K8GQrMPPh0Q+n3kYa=JsgA@mail.gmail.com>
 <20180209124607.akjhncb5sempjqcn@huvuddator>
From: Kees Cook <keescook@chromium.org>
Date: Fri, 9 Feb 2018 12:46:54 -0800
X-Google-Sender-Auth: RQ7LYjlC-VkLo3ue1pgqQ6eDWnI
Message-ID: <CAGXu5j+hv6G3m+fgr7ibXAnoE-2GsxtXoqr0pd5AaaNdFVQxYg@mail.gmail.com>
Subject: Re: [RFC PATCH 4/7] kconfig: support new special property shell=
To: Ulf Magnusson <ulfalizer@gmail.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>,
	Nicolas Pitre <nicolas.pitre@linaro.org>, "Luis R . Rodriguez" <mcgrof@suse.com>,
	Randy Dunlap <rdunlap@infradead.org>, Sam Ravnborg <sam@ravnborg.org>,
	Michal Marek <michal.lkml@markovi.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Pavel Machek <pavel@ucw.cz>, linux-s390 <linux-s390@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591850368607646970?=
X-GMAIL-MSGID: =?utf-8?q?1591957747410879739?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 9, 2018 at 4:46 AM, Ulf Magnusson <ulfalizer@gmail.com> wrote:
> One thing that makes Kconfig confusing (though it works well enough in
> practice) is that .config files both record user selections (the saved
> configuration) and serve as a configuration output format for make.
>
> It becomes easier to think about .config files once you realize that
> assignments to promptless symbols never have an effect on Kconfig
> itself: They're just configuration output, intermixed with the saved
> user selections.
>
> Assume 'option env' symbols got written out for example:
>
>         - For a non-user-assignable symbol, the entry in the .config
>           file is just configuration output and ignored by Kconfig,
>           which will fetch the value from the environment instead.
>
>         - For an assignable 'option env' symbol, the entry in the
>           .config file is a saved user selection (as well as
>           configuration output), and will be respected by Kconfig.

In the stack-protector case, this becomes quite important, since the
goal is to record the user's selection regardless of compiler
capability. For example, if someone selects _REGULAR, it shouldn't
"upgrade" to _STRONG. (Similarly for _NONE.) Having _AUTO provides a
way to pick "best possible for this compiler", though. If a user had
previously selected _STRONG but they're doing builds with an older
compiler (or a misconfigured newer compiler) without support, the goal
is to _fail_ to build, not silently select _REGULAR.

So, in this case, what's gained is the logic for _AUTO, and the logic
to not show, say, _STRONG when it's not available in the compiler. But
we must still fail to build if _STRONG was in the .config. It can't
silently rewrite it to _REGULAR because the compiler support for
_STRONG regressed.

-Kees

-- 
Kees Cook
Pixel Security
