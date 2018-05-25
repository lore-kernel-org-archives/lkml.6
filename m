Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935647AbeEYFBS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 01:01:18 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:42890 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935256AbeEYFBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 01:01:14 -0400
X-Google-Smtp-Source: AB8JxZpaGyLDIHAYkfaHx1ik354MJnhwFYHsRIm8kL/weYBr/rrNZ+owiEcSMMQcG5u+Cx4qLI68+Q==
Date: Fri, 25 May 2018 10:31:03 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, liuwei@actions-semi.com,
        96boards@ucrobotics.com,
        OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
        <devicetree@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        GPIO SUBSYSTEM <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        hzhang@ucrobotics.com, bdong@ucrobotics.com,
        Mani Sadhasivam <manivannanece23@gmail.com>,
        "Thomas C. Liau" <thomas.liau@actions-semi.com>,
        Jeff Chen <jeff.chen@actions-semi.com>
Subject: Re: [PATCH v2 5/5] MAINTAINERS: Add Actions Semi S900 pinctrl entries
Message-ID: <20180525050103.3hg3u2v5mvftqhht@linaro.org>
References: <20180520051736.4842-1-manivannan.sadhasivam@linaro.org>
 <20180520051736.4842-6-manivannan.sadhasivam@linaro.org>
 <CACRpkdYF7a-uwye0uwn-pT9Bprj74q1-Pcbq4WLyiE+kYY4j7w@mail.gmail.com>
 <25d1c303-71d7-8c38-880f-7bb0e133a876@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <25d1c303-71d7-8c38-880f-7bb0e133a876@suse.de>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

On Fri, May 25, 2018 at 06:12:00AM +0200, Andreas Färber wrote:
> Am 23.05.2018 um 10:40 schrieb Linus Walleij:
> > On Sun, May 20, 2018 at 7:17 AM, Manivannan Sadhasivam
> > <manivannan.sadhasivam@linaro.org> wrote:
> > 
> >> Add S900 pinctrl entries under ARCH_ACTIONS
> >>
> >> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > 
> > Patch applied tentatively so we have some maintenance entry for this.
> > 
> > Andreas expressed concerns about the driver earlier, so he might want it
> > split from the platform parts and have a separate entry for the pinctrl+GPIO
> > so Manivannan can maintain that part, also it makes sense to list
> > Manivannan as comaintainer of ARCH_ACTIONS with this in.
> > 
> > Andreas: how would you like to proceed?
> > 
> > I understand that I was a bit pushy or even rude in my last message
> > about the maintenance of this platform and the code structure of
> > the pin control driver. I am sorry if it caused any bad feelings on your
> > side :( social conflicts give me the creeps, I just try my best. Maybe
> > my best isn't always what it should be.
> 
> I fail to understand how splitting the MAINTAINERS section is going to
> help with the pinctrl conflict at hand? The problem is that instead of
> refactoring my S500 pinctrl driver to his liking, Mani has submitted a
> competing S900 pinctrl driver that you went on to merge. The human
> aspect is that merging his driver took the credit away from me having
> written the earlier pinctrl driver (based on my rtd1295 pinctrl driver).
> The practical aspect is that I can't drop my pinctrl driver from my work
> branch until there is equivalent functionality in the merged driver. I
> am lacking the time to rewrite S500 pin definitions on top of Mani's
> myself at this time, and I haven't seen S500 patches from him yet.
> 

I think we discussed this few more times before and I clearly mentioned this
pinctrl driver confilct in my old pinctrl series cover letter. If you had
submitted your pinctrl driver then Linus would had the option of picking up the
most robust one. But sadly you didn't had any time to complete and submit
yours and since there was only one pinctrl driver floating for Actions, Linus
went and merged mine.

Regarding the S500/S700 support, again I told you that my goal is to set up the
base driver for Actions OWL series SoC first and then adding support for every
other SoC's of the same family later. Now, I have succeeded in setting up the
clock, pinctrl and gpio drivers, so I can now work on extending support for
other SoC's as well.

FYI, I have ordered S700 based Cubieboard and will work on adding support for
that first. I still don't have access to S500 board yet since it is not
available on my region. Will find a way to get this asap.

> Also I had been investing efforts in explaining the upstreaming process
> to Actions, last in November. I see Thomas Liau and Jeff Chen missing in
> CC and I have not seen any Reviewed-by or Acked-by from anyone at
> Actions on this and the preceding series. There are more chips than the
> one on Linaro's 96board, so I would prefer to assure that the design
> works for all. Thus I am very critical of you applying the patches
> without waiting for review by Actions.
>

I don't think Actions would be interested in any upstreaming efforts. It
is our (comunity) responsibility to add support for that in order to
have our boards running mainline kernel and that's what we both have been
doing. Moreover I only saw once David Liau responded to your patchset and
there isn't much further. So how can you expect the subsystem maintainer's
to hold the patch series waiting for a so far silent SoC manufacturer's
response?

We should get move on and since my drivers are completely tested, we can
work on adding more SoC support later. And if something breaks on other
SoC platform, we can always modify the base driver accordingly.

> Other aspects are: The reason I wrote the pinctrl driver is that I
> experienced a UART TX issue on the Sparky board and was hoping a pinctrl
> driver might resolve that, but it didn't. So I still have a mix of
> boards where some are working and some are pretty unusable, without any
> clues on why.
> 
> That said, I don't object to having a separate MAINTAINERS section for
> the pinctrl driver(s) as long as I still get CC'ed on changes. We have
> wanted to add Mani as R for Actions overall, so that would probably mean
> adding me as R to an Actions pinctrl section, to avoid syncing the paths
> between two sections. I had previously felt that it does not make sense
> to list Mani as co-maintainer (M) for Actions overall since he can't tag
> and submit from my repo. And for the record I have offered him to take
> over which he didn't want to. I still hope to find some more time to
> review and queue his SPS patches, a driver that I have designed and thus
> understand and am much happier about the incremental additions there.
> 

Yes I agree that you offered me to take the Maintainership once through
IRC conversation, but I kind of refused it because I don't want to completely
take over the maintainership role from you since you did a great job in
getting the base SoC support mainlined initially. On the other hand, I
did ask you to add me as Co-Maintainer but you didn't responded to that.
I know that I can't send any pull requests to Arnd, but we should sort
it out IMO. Also, if you are completely swamped, then I take take up the
maintainership role now inorder to keep the things moving. TBH I don't
want my patches to be floating for months without any reason.

> A further side note is that I had reached out about setting up an
> infradead mailing list linux-actions, but there was no response from
> David or anyone. Having an L on the section(s) would avoid messing with
> R and hand-maintained CC lists. Any help with that appreciated.
> 

This is something we have to look out for and I will also see the possibility
of setting up the mailing list from my side.

Thanks for all of your great efforts!

Regards,
Mani

> Regards,
> Andreas
> 
> -- 
> SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
> GF: Felix Imendörffer, Jane Smithard, Graham Norton
> HRB 21284 (AG Nürnberg)
