Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752870AbeCDPqX convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 10:46:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:51043 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752688AbeCDPqV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 10:46:21 -0500
Date: Sun, 4 Mar 2018 16:46:16 +0100
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
        Scott Branden <sbranden@broadcom.com>,
        linux-rpi-kernel@lists.infradead.org, Eric Anholt <eric@anholt.net>,
        bcm-kernel-feedback-list@broadcom.com,
        Gerd Hoffmann <kraxel@redhat.com>, linux-mmc@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-kernel@vger.kernel.org,
        Ray Jui <rjui@broadcom.com>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] mmc: bcm2835: print some informational messages
 during reset
Message-ID: <20180304164616.75e8e55e@naga.suse.cz>
In-Reply-To: <1950058855.86123.1518718920111@email.1und1.de>
References: <97593d6e1a41af1baff61f7d9e6e68a450fc9da6.1518619058.git.msuchanek@suse.de>
        <97593d6e1a41af1baff61f7d9e6e68a450fc9da6.1518619058.git.msuchanek@suse.de>
        <57ff1e429a7fc12300a3cca0c5e9a637beed0d3a.1518619058.git.msuchanek@suse.de>
        <F404E9C8-AE64-4B36-AD1B-911BD3C33946@gmail.com>
        <20180214204733.7987d16c@naga.suse.cz>
        <1950058855.86123.1518718920111@email.1und1.de>
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Feb 2018 19:22:00 +0100 (CET)
Stefan Wahren <stefan.wahren@i2se.com> wrote:

> Hi Michal,
> 
> > Michal Suchánek <msuchanek@suse.de> hat am 14. Februar 2018 um
> > 20:47 geschrieben:
> > 
> > 
> > On Wed, 14 Feb 2018 08:50:16 -0800
> > Florian Fainelli <f.fainelli@gmail.com> wrote:
> >   
> > > On February 14, 2018 6:38:58 AM PST, Michal Suchanek
> > > <msuchanek@suse.de> wrote:  
> > > >The previous patch does reset during hardware error so make the
> > > >reset progress more visible.    
> > > 
> > > Based on your previous email it looks like this can happen quite
> > > frequently so we might be spamming the kernel log with such reset
> > > messages. Turning this into a debug print would not be great
> > > either, how about a custom sysfs attribute counting the number of
> > > times a reset was done?  
> > 
> > Since every such message happens when the system stalls for like
> > half a minute I don't think there will be that many until somebody
> > notices something is amiss. It might be also helpful in diagnosing
> > if other cards lock up in different way - for me the DMA shutdown
> > is short so I guess it's the mmc host that is locked up and the DMA
> > engine is fine. It might look differently on different systems,
> > though.  
> 
> FWIW according to your dmesg your RPi doesn't use the DMA engine:
> 
> [ 5.004609] sdhost-bcm2835 3f202000.sdhost: unable to initialise DMA
> channel. Falling back to PIO [ 5.154518] sdhost-bcm2835
> 3f202000.sdhost: loaded - DMA disabled
> 
> For me it's a chicken and egg problem if the DMA driver is build as a
> kernel module.

It can be included in the ramdisk but somebody would have to add it to
the list of required modules because the dependency is non-obvious.

Thanks

Michal
