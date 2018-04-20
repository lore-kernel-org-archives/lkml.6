Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755377AbeDTPFV (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 11:05:21 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:38008 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755281AbeDTPFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 11:05:19 -0400
X-Google-Smtp-Source: AIpwx4/fH7bOTKB+Lbqd2M2Sjbg4u64ywd3KVovNddgV+n/gzWyv+TPbCJjnrGTnO1cv+7zD5Q8FX+jl8eXHca5Af88=
MIME-Version: 1.0
In-Reply-To: <20180420073402.GA9356@amd>
References: <20180404165559.4cd0c12c@canb.auug.org.au> <20180404074856.GA9342@amd>
 <20180404175852.GI5700@atomide.com> <20180404184622.GA8608@amd>
 <20180404195951.GJ5700@atomide.com> <20180404201837.GA9710@amd>
 <20180415173908.GA2024@amd> <CAGXu5jK9f62n95sOdJViXHXzQFyCdcsWt9HPvcdSFRp9Qqg0bg@mail.gmail.com>
 <20180420073402.GA9356@amd>
From: Kees Cook <keescook@chromium.org>
Date: Fri, 20 Apr 2018 08:05:17 -0700
X-Google-Sender-Auth: 1m_YtXbAT_w4GMtKNFizyXk34CM
Message-ID: <CAGXu5j+6D3PiVc9SR4+31ZGDC2r5uWJOw8Sn3cDhXdNqBGH+hQ@mail.gmail.com>
Subject: Re: [regression v4.17-rc0] Re: FORTIFY_SOURCE breaks ARM compilation
 in -next -- was Re: ARM compile failure in Re: linux-next: Tree for Apr 4
To: Pavel Machek <pavel@ucw.cz>
Cc: Daniel Micay <danielmicay@gmail.com>, Tony Lindgren <tony@atomide.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        pali.rohar@gmail.com, sre@kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, Kevin Hilman <khilman@kernel.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>, ivo.g.dimitrov.75@gmail.com,
        Patrik Bachan <patrikbachan@gmail.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        =?UTF-8?B?TWlja3Vsw6HFoSBRd2VydHo=?= <abcloriens@gmail.com>,
        Clayton Craft <clayton@craftyguy.net>,
        Martijn Braam <martijn@brixit.nl>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        =?UTF-8?Q?Filip_Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>,
        Jinbum Park <jinb.park7@gmail.com>,
        Russell King <rmk+kernel@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 20, 2018 at 12:34 AM, Pavel Machek <pavel@ucw.cz> wrote:
> On Sun 2018-04-15 11:00:06, Kees Cook wrote:
>> On Sun, Apr 15, 2018 at 10:39 AM, Pavel Machek <pavel@ucw.cz> wrote:
>> > Hi!
>> >
>> >> Thanks.
>> >>
>> >> Ok, let me try to bisect it. Compile-problem should be easy...
>> >>
>> >> Hmm. And as it is compile-problem in single file, it should even be
>> >> reasonably fast. I did not realize how easy it would be:
>> >>
>> >> #!/bin/bash
>> >> set -e
>> >> cp config.ok .config
>> >> yes '' | ARCH=arm make lib/string.o
>> >>
>> >> And the winner is:
>> >>
>> >> ee333554fed55555a986a90bb097ac7f9d6f05bf is the first bad commit
>> >> commit ee333554fed55555a986a90bb097ac7f9d6f05bf
>> >> Author: Jinbum Park <jinb.park7@gmail.com>
>> >> Date:   Tue Mar 6 01:39:24 2018 +0100
>> > ...
>> >
>> >>     Acked-by: Kees Cook <keescook@chromium.org>
>> >>     Signed-off-by: Jinbum Park <jinb.park7@gmail.com>
>> >>     Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
>> >
>> > So I bisect a problem in -next, and patch is merged to Linus,
>> > _anyway_, breaking compilation there? Neither Jinbum nor Russell even
>> > bother to comment.
>>
>> Hi! Sorry I lost this email in my inbox. It seems this is specific to
>> a particular subset of arm architectures? (My local builds of arm all
>> succeed, for example. Can you send your failing config?) I'll take a
>> closer look on Monday if Daniel doesn't beat me to it.
>
> Daniel, Kees: any news?
>
> I'm aware you did not specify which Monday :-).

Hi! Sorry, I got distracted. So the .config you sent me builds fine
with my cross compiler. I suspect this is something specific to ELDK's
compiler. I can try some other compiler versions. What version of gcc
is failing?

-Kees

-- 
Kees Cook
Pixel Security
