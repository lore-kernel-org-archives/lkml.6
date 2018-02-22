Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AH8x226Eg+Mb83X+RujS2FlRvmiknb0SMQCbHoSOrk0Ca2uIV3lGi0VfwavDQydeGAl0pWBGswCe
ARC-Seal: i=1; a=rsa-sha256; t=1519320508; cv=none;
        d=google.com; s=arc-20160816;
        b=Iyc+TddJlU8KZ+nzU2VmLFiCxTCl8WRYM+7fCwupxBmOxk36oG1YC17+47nV+9Inrn
         D2Tc7gIEKy4htbKpBONZvaV/o9juP1bA4z4ogkD+0w/0n3+3lwYQGcVRjdqN1CiFopvL
         2i4cUy5sidL6QVUC3051ohX0PA1ZnQXLpaMcyqVTY5XXrkrV7PuzkmrDhZ4xvctrMVw5
         Aj0UfczNjabnAEPN6klxq9HX8sWsUlxKrKuBEujpRAuasIKE6GmPdqouNwBAR+gbuJxw
         gpBkzFLEiBeY0/4VufAwDs0CxyOjEefWHoW9DuAUBDrL3b2b8xY3w2gTnfcU2Y2ZzE2B
         wI2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:dkim-filter:arc-authentication-results;
        bh=LB3Vbr1L9dHHAjnBIQmeQUAfb7bchP2UG7JPqdr+3Ag=;
        b=OEXcsDxTnGdFWy9vC67PY4t05n4cLxE/onyC36iS/ySTmPBq5V14wiR34wzuM58Mxx
         V6cNF5tkJvFVzbSlF2XbHI3mpYub2mJkiETevOWi7XzVUTRjRuC4auH//e+J9tYapkC4
         eJn3pKPO/P7sH0c7vZ+iWDuIQmr03+3PmqqtMVwg+MMaGA24We3XXY86tCAoic82WB1O
         Iu+EjbfFEGeMG8G9CrkRyyTN1WA3VsfVKROIqW+o2/WpfIn1D0AgOtYD+/vjKWM8klig
         +m+FhMFehxrZkcW7JpZgGkZahnSKZdW9m+KinMgM3eCyyiAiEL1dNBGogyJxKe5Yfqid
         i8Nw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=kyR0bDTY;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.90 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=kyR0bDTY;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.90 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w1MHRsv3025903
X-Nifty-SrcIP: [209.85.213.50]
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1bRC5EwXJ8=xcaZqf5c7=8h12spJ1XCf1NFvCS-7qDnw@mail.gmail.com>
References: <20180216214117.1947175-1-arnd@arndb.de> <20180216214117.1947175-3-arnd@arndb.de>
 <CAK7LNARvbsMc3JpcxZjvmc3UjvACx3t66cLM_aSDcADiPA0V7g@mail.gmail.com>
 <CAK8P3a0DAu1q3jLMN=JjrNAd4a4UVFcEcLF2h1VgSvXjZsU++g@mail.gmail.com>
 <CAK7LNAR2GO21TMP=viR1sni_17zFZ+03TUh8pak1etVYEF8kTQ@mail.gmail.com> <CAK8P3a1bRC5EwXJ8=xcaZqf5c7=8h12spJ1XCf1NFvCS-7qDnw@mail.gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 23 Feb 2018 02:27:13 +0900
X-Gmail-Original-Message-ID: <CAK7LNASdbcFGCeY+kiT3WpJPGsHaT=db=sdg20Y_-veEf0mZ_Q@mail.gmail.com>
Message-ID: <CAK7LNASdbcFGCeY+kiT3WpJPGsHaT=db=sdg20Y_-veEf0mZ_Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] Kconfig: improve handling for all{rand,yes,no,}.config
 fragments
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "Yann E. MORIN" <yann.morin.1998@free.fr>,
        Michal Marek <mmarek@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592595410017482900?=
X-GMAIL-MSGID: =?utf-8?q?1593123022275400269?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-02-22 1:57 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
> On Tue, Feb 20, 2018 at 6:04 PM, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>> 2018-02-20 18:59 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
>>> On Tue, Feb 20, 2018 at 10:26 AM, Masahiro Yamada
>>> <yamada.masahiro@socionext.com> wrote:
>>>> 2018-02-17 6:41 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
>>>
>>>>> @@ -621,14 +622,24 @@ int main(int ac, char **av)
>>>>>                 case randconfig:        name = "allrandom.config"; break;
>>>>>                 default: break;
>>>>>                 }
>>>>> -               if (conf_read_simple(name, S_DEF_USER) &&
>>>>> -                   conf_read_simple("all.config", S_DEF_USER)) {
>>>>> -                       fprintf(stderr,
>>>>> -                               _("*** KCONFIG_ALLCONFIG set, but no \"%s\" or \"all.config\" file found\n"),
>>>>> -                               name);
>>>>> -                       exit(1);
>>>>> +               /* try ./name, arch/$(ARCH)/configs/name and kernel/config/name */
>>>>> +               if (!conf_read_simple(name, S_DEF_USER))
>>>>> +                       break;
>>>>> +               arch = getenv("ARCH");
>>>>> +               if (arch) {
>>>>> +                       snprintf(fullname, sizeof(fullname), "arch/%s/configs/%s",
>>>>> +                                arch, name);
>>>>> +                       if (!conf_read_simple(fullname, S_DEF_USER))
>>>>> +                               break;
>>>>>                 }
>>>>
>>>>
>>>> I am not a big fan of hard-coding the kernel directory structure.
>>>>
>>>> We already do this [1], but I am thinking of kicking this out.
>>>> [1] https://github.com/torvalds/linux/blob/v4.16-rc1/scripts/kconfig/confdata.c#L33
>>>
>>> Ok, I see. How about adding a way to detect that we are build-testing
>>> with randconfig instead?
>>
>>
>> How about implementing something in scripts/kconfig/Makefile?
>>
>> merge_config collects config fragments into 'configfiles'
>>
>> I was thinking of a similar thing.
>>
>>
>> If KCONFIG_ALLCONFIG is 1,
>> scripts/kconfig/Makefile searches
>> './', '$srctree/', 'arch/$(SRCARCH)/configs/', 'kernel/configs/'
>> and sets the found file in it,
>>
>> If KCONFIG_ALLCONFIG already contains a file name, it is used as-is.
>>
>> scripts/kconfig/conf.c will be simplified.
>
> Yes, good idea. I'm struggling a bit with the implementation (fitting
> it into the
> simple-tagets rule), can you come up with a prototype?
>
> We also need to decide what happens when e.g. both a ./all.config and
> arch/${SRCARCH}/configs/allrand.config file exist, should the first path
> take precedence or the more specific file?
>

Hmm, maybe the following order?

[1] ./allrandom.config
[2] $(srctree)/allrandom.config
[3] ./all.config
[4] $(srctree)/all.config
[5] kernel/configs/allrandom.config + arch/$(SRCARCH)/configs/allrandom.config


I think you want to include
both kernel/configs/allrandom.config and
arch/$(SRCARCH)/configs/allrandom.config
if exist.

Some options are common, some are arch-specific.

This is how tinyconfig works.


-- 
Best Regards
Masahiro Yamada
