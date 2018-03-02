Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424006AbeCBJeD (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 04:34:03 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:51135 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1425043AbeCBJdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 04:33:25 -0500
X-Google-Smtp-Source: AG47ELtiVZ66UqvFjXnDx2mjXyUche7+LxaFwp8If2E+DlWYREr2tMi4hc1yRB/TOX2tKu4zDGxMvjgR2F6UCBdUp9c=
MIME-Version: 1.0
In-Reply-To: <20180302091025.GC30267@amd>
References: <20180224214617.GA22619@amd> <71aa88ec-d4df-b49c-7d73-27197f468491@leemhuis.info>
 <20180226131318.GA14045@amd> <CAEnQRZBbMTeaxb+=AaarX6PSGasfVjtAUdpbPvJavZyTRMpdgQ@mail.gmail.com>
 <20180226231336.GA18565@amd> <CACRpkdarR_7HqGMPwfa8YpG9wnFs5mJrNwuctycn=MrdwaRxyw@mail.gmail.com>
 <20180302091025.GC30267@amd>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 2 Mar 2018 10:33:24 +0100
Message-ID: <CACRpkda=deFSmk2iyrtde3Z-aj6rW9_jNfE3Ep4X=ejprGxRUw@mail.gmail.com>
Subject: Re: [alsa-devel] regression v4.16 on Nokia N900: sound does not work
To: Pavel Machek <pavel@ucw.cz>
Cc: Daniel Baluta <daniel.baluta@gmail.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Ivajlo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        ext Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        kernel list <linux-kernel@vger.kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Martijn Braam <martijn@brixit.nl>,
        =?UTF-8?Q?Filip_Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        =?UTF-8?B?TWlja3Vsw6HFoSBRd2VydHo=?= <abcloriens@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>,
        clayton@craftyguy.net, Linux-OMAP <linux-omap@vger.kernel.org>,
        "Andrew F . Davis" <afd@ti.com>,
        Patrik Bachan <patrikbachan@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        serge@hallyn.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 2, 2018 at 10:10 AM, Pavel Machek <pavel@ucw.cz> wrote:
> Linux-Regression-ID: lr#4b650f
>
> On Tue 2018-02-27 09:43:32, Linus Walleij wrote:
>> On Tue, Feb 27, 2018 at 12:13 AM, Pavel Machek <pavel@ucw.cz> wrote:
>>
>> > I did git bisect, and the winner seems to be:
>> >
>> > pavel@duo:/data/l/linux-n900$ git bisect bad
>> > c85823390215e52d68d3826df92a447ed31e5c80 is the first bad commit
>> > commit c85823390215e52d68d3826df92a447ed31e5c80
>> > Author: Linus Walleij <linus.walleij@linaro.org>
>> > Date:   Wed Dec 27 16:37:44 2017 +0100
>> >
>> >     gpio: of: Support SPI nonstandard GPIO properties
>>
>> I have fixes queued for this, tried to send a pull request yesterday
>> but it turns out the fixes need fixing... OK I'm onto it anyways.
>
> Do you have any updates? Is there way to fix dts so that this does not
> trigger on N900?
>
> If this is taking longer to fix, should c85823390215 be reverted in
> the meantime? It does not seem particulary important/urgent...

No patience between the v4.16 release candidates eh ;)

commit 6662ae6af82df10259a70c7569b4c12ea7f3ba93
("gpiolib: Keep returning EPROBE_DEFER when we should")

and

commit ce27fb2c56db6ccfe8099343bb4afdab15e77e7b
("gpio: Handle deferred probing in of_find_gpio() properly")

that are both in Torvalds' tree since yesterday should be fixing
this, I think? Did you try just using the upstream HEAD?

Yours,
Linus Walleij
