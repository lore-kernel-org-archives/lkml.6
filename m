Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751279AbeEVGsx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 02:48:53 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:62409 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751196AbeEVGsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 02:48:51 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w4M6mhkW023213
X-Nifty-SrcIP: [209.85.217.174]
X-Google-Smtp-Source: AB8JxZo0N4v2fzPebPi//eHuOfssAbWsq978kqd8ukKOVAg7oSznNMTQGL9HM3U7oLTaX4CVshrYt4Hx/9/03kPx4RA=
MIME-Version: 1.0
In-Reply-To: <20180520100601.GB18441@ravnborg.org>
References: <1526804213-8238-1-git-send-email-yamada.masahiro@socionext.com>
 <1526804213-8238-5-git-send-email-yamada.masahiro@socionext.com> <20180520100601.GB18441@ravnborg.org>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 22 May 2018 15:48:02 +0900
X-Gmail-Original-Message-ID: <CAK7LNASfQBw4O=etKBmEJFLcvq+NqetwJjo4Dt0XzzRdmen2Eg@mail.gmail.com>
Message-ID: <CAK7LNASfQBw4O=etKBmEJFLcvq+NqetwJjo4Dt0XzzRdmen2Eg@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] kconfig: refactor ncurses package checks for
 building mconf
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "Luis R . Rodriguez" <mcgrof@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arvind Prasanna <arvindprasanna@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-05-20 19:06 GMT+09:00 Sam Ravnborg <sam@ravnborg.org>:
> Hi Masahiro
>
> On Sun, May 20, 2018 at 05:16:52PM +0900, Masahiro Yamada wrote:
>> The mconf (or its infrastructure, lxdiaglog) depends on ncurses.
>> Move and rename check-lxdialog.sh to mconf-cfg.sh to make it work in
>> the same way as for qconf and gconf.
>>
>> According to Randy's report, we still need to carry the fallback code
>> in case the pkg-config fails to find ncurses.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> ---
>> -
>> -# Use recursively expanded variables so we do not call gcc unless
>> -# we really need to do so. (Do not call gcc as part of make mrproper)
>> -HOST_EXTRACFLAGS += $(shell $(CONFIG_SHELL) $(check-lxdialog) -ccflags) \
>> -                    -DLOCALE
> ...
>
>>  # Add environment specific flags
>> -HOST_EXTRACFLAGS += $(shell $(CONFIG_SHELL) $(srctree)/$(src)/check.sh $(HOSTCC) $(HOSTCFLAGS))
>> -HOST_EXTRACXXFLAGS += $(shell $(CONFIG_SHELL) $(srctree)/$(src)/check.sh $(HOSTCXX) $(HOSTCXXFLAGS))
>> -
>> +HOST_EXTRACFLAGS += $(shell $(CONFIG_SHELL) $(srctree)/$(src)/check.sh $(HOSTCC) $(HOSTCFLAGS)) \
>> +                 -DLOCALE
>> +HOST_EXTRACXXFLAGS += $(shell $(CONFIG_SHELL) $(srctree)/$(src)/check.sh $(HOSTCXX) $(HOSTCXXFLAGS)) \
>> +                 -DLOCALE
>
> Any chance that the ugly hack in check.sh could be ported over to use pkg-config?
>
> There should be no need to specify both $(shell ...) AND $(CONFIG_SHELL)
> This was not introduced by this commit, but as the Makefile is cleaned up include this too.
>


Rather, I have been wondering if we could rip off the gettext stuff entirely...




-- 
Best Regards
Masahiro Yamada
