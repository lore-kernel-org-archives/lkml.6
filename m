Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753960AbeCFRSY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 12:18:24 -0500
Received: from muru.com ([72.249.23.125]:59702 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753070AbeCFRSX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 12:18:23 -0500
Date: Tue, 6 Mar 2018 09:18:19 -0800
From: Tony Lindgren <tony@atomide.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Maciej Purski <m.purski@samsung.com>,
        linux-omap@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: Regulator regression in next-20180305
Message-ID: <20180306171819.GF5796@atomide.com>
References: <20180305231246.GB5799@atomide.com>
 <CAOMZO5CXy=7ZKVapp_2Q4wq=mY-dJ0owZZN84vqUj1j1xasOKg@mail.gmail.com>
 <20180306163035.GE13586@sirena.org.uk>
 <CAOMZO5DL_a8DOKgyZ4j2-bcPZLeUtQ9ekc74yVwtKYofbpOafg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMZO5DL_a8DOKgyZ4j2-bcPZLeUtQ9ekc74yVwtKYofbpOafg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Fabio Estevam <festevam@gmail.com> [180306 16:57]:
> Hi Mark,
> 
> On Tue, Mar 6, 2018 at 1:30 PM, Mark Brown <broonie@kernel.org> wrote:
> 
> > diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
> > index e685f8b94acf..2c5b20a97f51 100644
> > --- a/drivers/regulator/core.c
> > +++ b/drivers/regulator/core.c
> > @@ -159,7 +159,7 @@ static void regulator_lock_supply(struct regulator_dev *rdev)
> >  {
> >         int i;
> >
> > -       for (i = 0; rdev; rdev = rdev_get_supply(rdev), i++)
> > +       for (i = 1000; rdev; rdev = rdev_get_supply(rdev), i++)
> >                 mutex_lock_nested(&rdev->mutex, i);
> 
> With this change the log is a bit different, but still get a kernel hang:
> https://pastebin.com/eF08TnuT

That patch does not seem to change anything for me. The errors
I posted yesterday for mmc0 only happen on duovero, other omap
variants just fail silently with no cards showing.

Regards,

Tony
