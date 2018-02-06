Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AH8x226w226Sw5snI1k3aEjM0mm3uKN5aNKvovdfsyQcg2qkpZJj4FnyEOv9WvdalqwcoSAjQywv
ARC-Seal: i=1; a=rsa-sha256; t=1517913927; cv=none;
        d=google.com; s=arc-20160816;
        b=fgh/BEYgWEpZmltBNY5dTGNM/6ZggRoWPH1m8iIcpyySsRVtHnHuDH6ED1+lKiKtnY
         8Wxeyxu16VYa1VywdDyulzJ0s0YbBL2H+aFJfTizzrQG4om4HGnbGrWDsgj3sxRiCeBD
         WCps79LDgoJdRNzhMobCo5iMuZLDjPN6jv1ACkYDlbveCH6pOElGqxxMixYwjMBMftnC
         BBy7kRU0RCz9pH+az91n2/qf+5RTiDG0XSUQdpErhdFwUCY5dKAzwNgDiTou7t/fRd4E
         ldkuaHxOc9RYhbaECJ2EtLA67u/w5+8NqiPr+s61XVfj/Q9ttOSuW2UlZNRTfb8CsOvP
         qIzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:dkim-filter:arc-authentication-results;
        bh=Aoa7rZ8c8jqUw6pte6o6fZBNoH1rOkKhc4D/QCln3tk=;
        b=GhK0Wz1d73vYiHJb/5BxOvlBjcUh/coW8JMRogoL96vp4HvkDOGN4djOpZh2sujH12
         LMpvjGYfg4cJNHcdPgdlJnOeQwwtUHmZ074YJ4pKC6J1UOT6tmCDTPyFJVhq5gq5pScC
         gqOefaIUJB8EacVoOwJ4OS221hcqreP57QxtmT0g5VKrJmo5ebfWHhfD+qJfTLOQzqjn
         aw40XhTsl5SCZ3JLvaOhyuT9XPpoqOoLwrXvBDPpEUkgWlUaOA8aK60rmEJeVLAK697X
         W05w5PNEiAHWLUMsw5ES+PeE4dYgwilWW1y84bcoTMNgfyzL6JvZ4mrPqKqVnBuUO5dm
         bzyQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=IPeLzkum;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.90 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=IPeLzkum;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.90 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w16Aj3uR006318
X-Nifty-SrcIP: [209.85.213.44]
MIME-Version: 1.0
In-Reply-To: <20180206093450.GB31558@kroah.com>
References: <1517877294-4826-1-git-send-email-yamada.masahiro@socionext.com>
 <1517877294-4826-7-git-send-email-yamada.masahiro@socionext.com> <20180206093450.GB31558@kroah.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 6 Feb 2018 19:44:22 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS_29myncTw+6u7fH9BgjzZJfXSN1CJjOjK-qXjPRQ8hQ@mail.gmail.com>
Message-ID: <CAK7LNAS_29myncTw+6u7fH9BgjzZJfXSN1CJjOjK-qXjPRQ8hQ@mail.gmail.com>
Subject: Re: [PATCH 06/14] kbuild: define PYTHON2 and PYTHON3 variables
 instead of PYTHON
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        "Luis R . Rodriguez" <mcgrof@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ulf Magnusson <ulfalizer@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591609779326365104?=
X-GMAIL-MSGID: =?utf-8?q?1591648114493602385?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-02-06 18:34 GMT+09:00 Greg Kroah-Hartman <gregkh@linuxfoundation.org>:
> On Tue, Feb 06, 2018 at 09:34:46AM +0900, Masahiro Yamada wrote:
>> The variable 'PYTHON' allows users to specify a proper executable
>> name in case the default 'python' does not work.  However, this does
>> not address the case where both Python 2 and Python 3 scripts are
>> used in one system.
>>
>> PEP 394 (https://www.python.org/dev/peps/pep-0394/) provides a
>> convention for Python scripts portability.  Here is a quotation:
>>
>>   In order to tolerate differences across platforms, all new code
>>   that needs to invoke the Python interpreter should not specify
>>   'python', but rather should specify either 'python2' or 'python3'.
>>   This distinction should be made in shebangs, when invoking from a
>>   shell script, when invoking via the system() call, or when invoking
>>   in any other context.
>>
>> arch/ia64/scripts/unwcheck.py is apparently written in Python 2, so
>> it should be invoked by 'python2'.
>>
>> It is legitimate to use 'python' for scripts compatible with both
>> Python 2 and Python 3, but this is rare (at least I do not see the
>> case in kernel tree).  You do not need to make efforts to write your
>> scripts in that way.  Anyway, Python 2 will retire in 2020.
>>
>> This commit is needed for my new scripts written in Python 3.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> ---
>>
>>  Makefile           | 5 +++--
>>  arch/ia64/Makefile | 2 +-
>>  2 files changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/Makefile b/Makefile
>> index 11aff0f..c4e935c 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -384,7 +384,8 @@ GENKSYMS  = scripts/genksyms/genksyms
>>  INSTALLKERNEL  := installkernel
>>  DEPMOD               = /sbin/depmod
>>  PERL         = perl
>> -PYTHON               = python
>> +PYTHON2              = python2
>> +PYTHON3              = python3
>
> Is this going to break any systems that were previous setting PYTHON?
>
> I like this change, and feel it is the correct thing to do, but having a
> "fallback" might be needed here.
>
> Could you do what the perf makefile does and do something like:
>         override PYTHON := $(call get-executable-or-default,PYTHON,$(PYTHON2))
> or is it really not an issue as only ia64 seems to care about this?
>

As far as I see, ia64 is the only instance that has used this ever.

(the perf Makefile defines PYTHON by itself, so should not be a problem.)


If people expect the backward-compatibility for this, I can do like follows:

# backward compatibility for 'PYTHON'
PYTHON2  := $(if $(PYTHON), $(PYTHON), python2)



Another (unlikely) possible breakage is
'python2' may not be installed on users' system.

I believe this is rare, but if needed, I could do like follows
at the cost of ugliness.


PYTHON2 := $(if $(PYTHON), $(PYTHON), \
        $(shell python2 --version 2>/dev/null && echo python2 || echo python))



-- 
Best Regards
Masahiro Yamada
