Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935398AbeBNUbJ convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 15:31:09 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:44821 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935361AbeBNUbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 15:31:05 -0500
Date: Wed, 14 Feb 2018 21:30:16 +0100 (CET)
From: Stefan Wahren <stefan.wahren@i2se.com>
To: =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
Cc: Eric Anholt <eric@anholt.net>, bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-rpi-kernel@lists.infradead.org,
        Phil Elwell <phil@raspberrypi.org>, Gerd Hoffmann <kraxel@redhat.com>,
        linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        linux-arm-kernel@lists.infradead.org
Message-ID: <431948292.48734.1518640216077@email.1und1.de>
In-Reply-To: <20180214202454.6e7ebeaf@naga.suse.cz>
References: <97593d6e1a41af1baff61f7d9e6e68a450fc9da6.1518619058.git.msuchanek@suse.de>
 <1fbf0d77-cb53-f0fa-b810-e9954138d907@i2se.com>
 <20180214163649.3a0c9476@kitsune.suse.cz>
 <20180214165827.386b9bb1@kitsune.suse.cz>
 <ecf8dd61-ab16-b298-d197-ea93ecf5982b@i2se.com>
 <20180214202454.6e7ebeaf@naga.suse.cz>
Subject: Re: [PATCH 1/2] mmc: bcm2835: reset host on timeout
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev21
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K0:oERPDb+/X5W65hsruIYLZlfyN1blF0rZ9N3xmnJynPp4fDslquT
 V3nmjodvaiP+IcCqO0w/OofEJ8bYS+wyqVA8Y4uf5AWsVVRnP3VGG7XI5n1K2miRz7cO6LI
 XOR2+c8EBcPx6xSLUqdF1JKa7xmpyDqbvuMcksnqy79TVn/n+rEBHZDy7p23ydZw4S9B4u/
 wX19K4MJkfpAGouTqaCHQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8GvB+xatAaM=:SdMAT02yGPB3pccnE1I9ug
 9jtPNL5c+PHDi7SZFEP89Jk6tuBYcTncakqPm5SD+O1Ob2Z8liUOypaJCazXB43WivqeuM3gf
 w/7uOKSVSdOEcimuTVw5fhoZf96TKEKMMbzcuBNeZIaHu6cUHhCWfa3WG20zBoZXdnX9o8ieU
 dZUdSWR3WNZZJrsvGGn6CDOPJlL/VOheKEeia5Z50+Um40166eP1fSBaVpbxbpc2PQQ2jhmWd
 4zQraeZiuY1X89sD5vbA8mPSDNh6VVDV1CnYCA9V3w8aY/qgBHYyPBmmGYcROjEthXIanL3zY
 k2mogAcR9ByTaFvgcJJVU1lDHEwX4qU8iF+IV5WFvgMdEQDRkB9InqZo9qDM9/G41UZvqldzG
 V4vxkJgufiQ7bP4lvr7QzExlzs0zgoCX/gaMLcGGZO4SGprWhORRt1b4GBWI2O8myUMIUdRAo
 AKC5nhXQzyfcTRtJ3lL95q4HMkQ843lZNpD7+M/29nd2eazuQ9ohWcnuyMrNjpbVs3IvN3zLr
 BZPfPtxJ4BT7yJA8i2qprLwZ+fFPN39+hal2Z3tdOKUyHiHscnUcjeWsTtrnxmAi43li12RUt
 L3Y2g0RVOKNZjmb9uL6YD+OVbuAFGWpbdhJCxUJeMcoNSclfjZ7ArKi2PrkKf2Y6/UVCfqoTo
 6njlqxnvbqFDW6nt24LlVT0lLZ77RM6VyOSC9vfcL4OWYbxVju/alMRzAly+ixPrat++Dc5oY
 Rs62gVCeAU1nI9QnbeSeFpe5pOZm7Tcl5thTHiQfQplvHMktMME/HPs2qZE=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

> Michal Suchánek <msuchanek@suse.de> hat am 14. Februar 2018 um 20:24 geschrieben:
> 
> 
> On Wed, 14 Feb 2018 17:49:31 +0100
> Stefan Wahren <stefan.wahren@i2se.com> wrote:
> 
> > Hi Michal,
> > 
> > [add Phil]
> > 
> > Am 14.02.2018 um 17:13 schrieb Michal Suchánek:
> > > On Wed, 14 Feb 2018 16:36:49 +0100
> > > Michal Suchánek <msuchanek@suse.de> wrote:
> > >  
> > >> On Wed, 14 Feb 2018 15:58:31 +0100
> > >> Stefan Wahren <stefan.wahren@i2se.com> wrote:
> > >>  
> > >>> Hi Michal,
> > >>>
> > >>> Am 14.02.2018 um 15:38 schrieb Michal Suchanek:    
> > >>>> The bcm2835 mmc host tends to lock up for unknown reason so reset
> > >>>> it on timeout. The upper mmc block layer tries retransimitting
> > >>>> with single blocks which tends to work out after a long wait.
> > >>>>
> > >>>> This is better than giving up and leaving the machine broken for
> > >>>> no obvious reason.      
> > >>> could you please provide more information about this issue
> > >>> (affected hardware, kernel config, version, dmesg, reproducible
> > >>> scenario)? 
> > > It tends to reproduce when upgrading a few packages with zypper and
> > > otherwise at random during system operation. It seems that for my
> > > card it worsens with age to some degree so perhaps it depends on the
> > > fragmentation of the internal card flash.
> > >
> > > Attaching dmesg and kernel config.  
> > 
> > do you noticed this issue before 4.15-rc4?
> 
> I initially noticed it with 4.4 kernel with some backports to make it
> bootable on RPi.

this confuses me. Gerd and i ported this driver from downstream and finally it's got merged in 4.12. 

So do you mean that you backported the mainline version to 4.4 or the downstream version of 4.4?

On a quick look they seems identical, but they aren't.

> > 
> > Could you please test with 4.15 final again?
> 
> Right, I can apply the patches on something more recent.
> 
> > 
> > What kind of SD card (name) triggers the issue?
> 
> Samsung EVO MB-MP16D

Thanks

> 
> Also see https://elinux.org/RPi_SD_cards#Which_SD_card.3F

I'm very sceptical about this list. The card above is listed as OK and NOK. The experienced issues doesn't need to be direct related to the card (unproperly umounted, bad driver, ...).

Stefan

> 
> Thanks
> 
> Michal
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
