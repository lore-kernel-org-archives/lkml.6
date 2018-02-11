Return-Path: <ulfalizer@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518381730; cv=none;
        d=google.com; s=arc-20160816;
        b=hBoyhLJeQW9GZPZ/ufS53IIWjYO2vSc15w29rMxy39pVELItPEluXzZoIQX280Hujd
         AQNs8K/akLMryPcaOyJqmwr8UWJi4N5YDkdQI54gx9ckT+aHQo7jp9nCsb0TWa66Nwy5
         iipEb1AMNTHrUXBE84eKme0LXtyeyAO7zv05H2is/vJoodMW11H5DO/kmALRy+s5u3bz
         zHeXcuMyI18JYmYS+ovVZedWDW84vns1pFxr7OzxR6DRXUboxRq8Bn2mwjKPXeZm2pn/
         GrrqhwxbPjlKQcnacVbvyMjCNtocxFlK+3CFyiDoU0QHgQCfCCx6ZxUVMY65d0T4Jaq1
         ZBoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=CUMvpCHDVTAzAr091HpSb/zM9kdk6qWyvBfzBHU73vk=;
        b=Qenc2U1Imrlkr3Wau8YGBhiIhPJTYtXIyatJn+jm/JV/Ewnj+Rf+/ekfNhIcOPK+es
         pDrk3pNrEztX24YpfjMIrzX1+p/rKvFgEKqrivgBktzQ4ag2naGV6Te6DGMoHG7pzG+6
         zWzWEOfQ+Y0YfSPmck+8EOg17kmzwvc4MOdpvSUSnV0kDOX0NA5hxcnSEDnbnLgBWF2z
         kGFYUpL1IRYIvv6lSANWm9iRl3tVDMgs0gDL2rLhopXrlZBxsUw63rgvO7RqmJz3mIae
         QIZAa/n9hUxcLZ9qzNd5CM4xcA2e2VEBXOi41z8pFkApH6BcAUToCu8aeVuhGIkAfeC1
         AXgQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=T1xZkAUn;
       spf=pass (google.com: domain of ulfalizer@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=ulfalizer@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=T1xZkAUn;
       spf=pass (google.com: domain of ulfalizer@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=ulfalizer@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x224sASmBVgQoLsmyFG3By7LU0q2Es7cPXR7Of3Cu01Q/Kz8iPHxWpgXzBo6jUDU9dZfflHMsydiGLOAGTOXGOuk=
MIME-Version: 1.0
In-Reply-To: <CAFkk2KSk_OpwagN_Ru0fHPyALK5HwtxHOcMhT8OHqeOH3hOP+w@mail.gmail.com>
References: <20180210054843.z3g7wvcmlccvww3h@huvuddator> <CAK7LNARHmAF2SxBcc1aUEH5MMzUo_furLevqy7QzGxqNRHYiyQ@mail.gmail.com>
 <20180210074924.3nhxsza5zdbaahxx@huvuddator> <20180210080556.mycqsjhxbaguwhay@huvuddator>
 <20180210085519.737ckf4bcl57h4g2@huvuddator> <CAGXu5jKQgxxC2RQL0dxLKFVED2v-LiWKjtXY3DDpfwAXbnxM4Q@mail.gmail.com>
 <CA+55aFz-SJ970iqDsR8-Ke4z6WvB4n9RXAeen8pG=+YJWubETw@mail.gmail.com>
 <CAGXu5jLo0iuMsH89vj3nr8sv+1YvXfXgoPeBdxHwZm5i=DWoOA@mail.gmail.com>
 <CA+55aFxdx3FYE6YGifRR=BSG9QzXwgThj5z7RmV5P5+RpNXSiQ@mail.gmail.com>
 <CA+55aFyPyYyG-riaBQU5cGp_sC=r8mf9Mg6L=DUEH6EyQfWYwA@mail.gmail.com>
 <20180211103432.pf2ot6nd7nbhdhsy@huvuddator> <CAGXu5jLtFcvbazxUvL_=6uT+a8m0JQEB7v0OE41Z-PMoX_fWpA@mail.gmail.com>
 <CAFkk2KSk_OpwagN_Ru0fHPyALK5HwtxHOcMhT8OHqeOH3hOP+w@mail.gmail.com>
From: Ulf Magnusson <ulfalizer@gmail.com>
Date: Sun, 11 Feb 2018 21:42:09 +0100
Message-ID: <CAFkk2KRm+_NQ2QLUta7fbezngLpD3eZ5NEp57SymBRMUZQZ4wQ@mail.gmail.com>
Subject: Re: [RFC PATCH 4/7] kconfig: support new special property shell=
To: Kees Cook <keescook@chromium.org>
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
X-GMAIL-MSGID: =?utf-8?q?1592138641612154111?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Feb 11, 2018 at 9:29 PM, Ulf Magnusson <ulfalizer@gmail.com> wrote:
> On Sun, Feb 11, 2018 at 6:56 PM, Kees Cook <keescook@chromium.org> wrote:
>> Another case I mentioned before that I just want to make sure we don't
>> reintroduce the problem of getting "stuck" with a bad .config file.
>> While adding _STRONG support, I discovered the two-phase Kconfig
>> resolution that happens during the build. If you selected _STRONG with
>> a strong-capable compiler, everything was fine. If you then tried to
>> build with an older compiler, you'd get stuck since _STRONG wasn't
>> support (as detected during the first Kconfig phase) so the
>> generated/autoconf.h would never get updated with the newly selected
>> _REGULAR). I moved the Makefile analysis of available stack-protector
>> options into the second phase (i.e. after all the Kconfig runs), and
>> that worked to both unstick such configs and provide a clear message
>> early in the build about what wasn't available.
>>
>> If all this detection is getting moved up into Kconfig, I'm worried
>> we'll end up in this state again. If the answer is "you have to delete
>> autoconf.h if you change compilers", then that's fine, but it sure
>> seems unfriendly. :)
>
> Did you mean include/config/auto.conf? That's the one that gets
> included by the Makefiles.
>
> If the feature detection is moved into Kconfig, you should only need
> to rerun the configuration (make menuconfig/oldconfig/olddefconfig) if
> you change the compiler. That will update .config while taking the new
> features into account, and then the second phase during 'make' will
> update include/config/auto.conf from .config.
>
> That second Kconfig phase generates include/generated/autoconf.h and
> include/config/. The include/config/ directory implements dependencies
> between source files and Kconfig symbols by turning the symbols into
> (empty) files. When building (during the "second phase"), Kconfig
> compares .config with include/config/auto.conf to see what changed,
> and signals the changes to 'make' by touch'ing the files corresponding
> to the changed symbols. The idea is to avoid having to do a full
> rebuild whenever the configuration is changed.
>
> Check out scripts/basic/fixdep.c as well if you want to understand how it works.
>
> Cheers,
> Ulf

By the way:

That second phase is also a "normal" Kconfig run in the sense that it
does all the usual dependency checking stuff. Even if .config doesn't
respect dependencies, include/config/auto.conf will. So I think you
might not even need to rerun the configuration (though .config will be
out-of-date until you do).

Cheers,
Ulf
