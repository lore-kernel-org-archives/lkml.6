Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752666AbeDTTaG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 15:30:06 -0400
Received: from mail-qt0-f171.google.com ([209.85.216.171]:39250 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751170AbeDTTaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 15:30:04 -0400
X-Google-Smtp-Source: AIpwx49Z3MEVROVlWFQLoaZxVXBw57nkq1P4fNIhhq6IzHykmpCzEVjoT2O3pqYuasJz5pZDynF8QEPuG2R98uDq4MU=
MIME-Version: 1.0
In-Reply-To: <20180420192832.GA1870@amd>
References: <20180404175852.GI5700@atomide.com> <20180404184622.GA8608@amd>
 <20180404195951.GJ5700@atomide.com> <20180404201837.GA9710@amd>
 <20180415173908.GA2024@amd> <CAGXu5jK9f62n95sOdJViXHXzQFyCdcsWt9HPvcdSFRp9Qqg0bg@mail.gmail.com>
 <20180420073402.GA9356@amd> <CAGXu5j+6D3PiVc9SR4+31ZGDC2r5uWJOw8Sn3cDhXdNqBGH+hQ@mail.gmail.com>
 <20180420191523.GA28597@amd> <CA+DvKQKLpXP50vV0yoyB_w26NK5h6KdVUSWEHvHZ-8OdVvdt9w@mail.gmail.com>
 <20180420192832.GA1870@amd>
From: Daniel Micay <danielmicay@gmail.com>
Date: Fri, 20 Apr 2018 15:30:03 -0400
Message-ID: <CA+DvKQ+ekrr51_JcPiGrOaHj79NxYUqLWEo97z97tSuUzcuoZg@mail.gmail.com>
Subject: Re: [regression v4.17-rc0] Re: FORTIFY_SOURCE breaks ARM compilation
 in -next -- was Re: ARM compile failure in Re: linux-next: Tree for Apr 4
To: Pavel Machek <pavel@ucw.cz>
Cc: Kees Cook <keescook@chromium.org>, Tony Lindgren <tony@atomide.com>,
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

Well, that's not related, it's just this:

#ifdef __GNUC__
#if (__GNUC__ == 3 && __GNUC_MINOR__ < 3)
#error Your compiler is too buggy; it is known to miscompile kernels.
#error    Known good compilers: 3.3, 4.x
#endif
#if GCC_VERSION >= 40800 && GCC_VERSION < 40803
#error Your compiler is too buggy; it is known to miscompile kernels
#error and result in filesystem corruption and oopses.
#endif
#endif
