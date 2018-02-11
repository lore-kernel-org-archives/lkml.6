Return-Path: <keescook@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518383114; cv=none;
        d=google.com; s=arc-20160816;
        b=NoInd5mphhDkMzWVCCldxqppxc5Ak7wlirBdhAkZk9jkDyNsbSdRmKvMwblhv/Pgdb
         I4ZNnP7NciGHrNjTUipf4E7Pl/Wl+aFVW3WmWC8Wn5zgIzsdAlHKjnIFK5ny3XO+wPXG
         8ReTZIt2fCKoTH6XUsvYSNo7KstU51pR6gHG87hdyxJuhUtLE1ORhp++Dn23UA1QPdBm
         VAjEwgEhWgLZgRA74sVyPw0l+OV/TpEZ5bswYYx6VgTb2MGoVQLisloa97dUA/3bSRtZ
         +AvlrqiEciOzNlDEbsopS3T0+BY07S4yeZaHryRoJ6JPqzdOSDpC86THnXA+UnXYTXDQ
         A+qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=xEZYFJfWMeyLjQ+SPWeG9EROa1ufZJVUhvybPTZ85iA=;
        b=bu2cBo4xoeuxFQjUhvjGMV/qNqoerCUJEzubD6qHfPENxCoLauu8FpxhXeW3fHRm8Z
         mQNodAiihC+aDXi3u4J3przRB15tJqYid0Df0cidyDYFKt8Of+E/Izeqsih7txKpdCJg
         EnAhdVvBuUMKh7fkgp+rxeSp8JCVNg10YHGzGrUpl+2lK6X044ToWluvemKfHPQyRtc6
         OnmUgjobaVzvMOehmv9mgKGGa8tOGE9wnp2VzWp5a2OF/uWe3+a7JX/RVPMShaRCZ8Lm
         w4ZpSNFgKV7K8jaXCK9BVaHqfWLLH5FPsu7XTO3uIDtsgi/tBbDyk7807kxyOH9uat7P
         O7bw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=cn+04PTi;
       dkim=pass header.i=@chromium.org header.s=google header.b=dwewu+BI;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=cn+04PTi;
       dkim=pass header.i=@chromium.org header.s=google header.b=dwewu+BI;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AH8x225KPNTOf1bm4giDoWjBdT9h3ZvRNqutVobuml1bOpoZSsGicJtDeyLmyL8OQf9tKejYOFkLBLp4JUMdfnMjpSM=
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <CAFkk2KRAjA80Y74Nahf2Nk_5yOucoa1y2Xp54F2k-Hv0xgTAFg@mail.gmail.com>
References: <20180210054843.z3g7wvcmlccvww3h@huvuddator> <CAK7LNARHmAF2SxBcc1aUEH5MMzUo_furLevqy7QzGxqNRHYiyQ@mail.gmail.com>
 <20180210074924.3nhxsza5zdbaahxx@huvuddator> <20180210080556.mycqsjhxbaguwhay@huvuddator>
 <20180210085519.737ckf4bcl57h4g2@huvuddator> <CAGXu5jKQgxxC2RQL0dxLKFVED2v-LiWKjtXY3DDpfwAXbnxM4Q@mail.gmail.com>
 <CA+55aFz-SJ970iqDsR8-Ke4z6WvB4n9RXAeen8pG=+YJWubETw@mail.gmail.com>
 <CAGXu5jLo0iuMsH89vj3nr8sv+1YvXfXgoPeBdxHwZm5i=DWoOA@mail.gmail.com>
 <CA+55aFxdx3FYE6YGifRR=BSG9QzXwgThj5z7RmV5P5+RpNXSiQ@mail.gmail.com>
 <CA+55aFyPyYyG-riaBQU5cGp_sC=r8mf9Mg6L=DUEH6EyQfWYwA@mail.gmail.com>
 <20180211103432.pf2ot6nd7nbhdhsy@huvuddator> <CAGXu5jLtFcvbazxUvL_=6uT+a8m0JQEB7v0OE41Z-PMoX_fWpA@mail.gmail.com>
 <CAFkk2KRAjA80Y74Nahf2Nk_5yOucoa1y2Xp54F2k-Hv0xgTAFg@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Sun, 11 Feb 2018 13:05:12 -0800
X-Google-Sender-Auth: AZz1zB_JckftYhNmmyT3m2gz5wQ
Message-ID: <CAGXu5jLnho=kMVwZgV0rEs=brt2OZZrxEcYCK=8kt5kLbraZwQ@mail.gmail.com>
Subject: Re: [RFC PATCH 4/7] kconfig: support new special property shell=
To: Ulf Magnusson <ulfalizer@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Masahiro Yamada <yamada.masahiro@socionext.com>,
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>,
	Nicolas Pitre <nicolas.pitre@linaro.org>, "Luis R . Rodriguez" <mcgrof@suse.com>,
	Randy Dunlap <rdunlap@infradead.org>, Sam Ravnborg <sam@ravnborg.org>,
	Michal Marek <michal.lkml@markovi.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Pavel Machek <pavel@ucw.cz>, linux-s390 <linux-s390@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
	Ingo Molnar <mingo@kernel.org>, "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>,
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591850368607646970?=
X-GMAIL-MSGID: =?utf-8?q?1592140092664549581?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Feb 11, 2018 at 10:34 AM, Ulf Magnusson <ulfalizer@gmail.com> wrote:
> On Sun, Feb 11, 2018 at 6:56 PM, Kees Cook <keescook@chromium.org> wrote:
>> Old? That's not the case. The check for -fno-stack-protector will
>> likely be needed forever, as some distro compilers enable
>> stack-protector by default. So when someone wants to explicitly build
>> without stack-protector (or if the compiler's stack-protector is
>> detected as broken), we must force it off for the kernel build.
>
> What I meant is whether it makes sense to test if the
> -fno-stack-protector option is supported. Can we reasonably assume
> that passing -fno-stack-protector to the compiler won't cause an
> error?

That isn't something I've tested; but I can check if it's useful.

> Is it possible to build GCC with no "no stack protector" support? Do
> we need to support any compilers that would choke on the
> -fno-stack-protector flag itself?
>
> If we can reasonably assume that passing -fno-stack-protector is safe,
> then CC_HAS_STACKPROTECTOR_NONE isn't needed.

Well, there are two situations:

- does the user want to build _without_ stack protector? (which is
something some people want to do, no matter what I think of it)

- did _AUTO discover that stack protector output is broken?

In both cases, we need to pass -fno-stack-protector in case the distro
compiler was built with stack protector enabled by default.

-Kees

-- 
Kees Cook
Pixel Security
