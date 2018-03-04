Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752084AbeCDSMi convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 13:12:38 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:33625 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751692AbeCDSMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 13:12:35 -0500
Date: Sun, 4 Mar 2018 19:11:49 +0100 (CET)
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
Message-ID: <46261671.179357.1520187109844@email.1und1.de>
In-Reply-To: <20180304165717.6d4d8e68@naga.suse.cz>
References: <97593d6e1a41af1baff61f7d9e6e68a450fc9da6.1518619058.git.msuchanek@suse.de>
 <1fbf0d77-cb53-f0fa-b810-e9954138d907@i2se.com>
 <20180214163649.3a0c9476@kitsune.suse.cz>
 <20180214165827.386b9bb1@kitsune.suse.cz>
 <ecf8dd61-ab16-b298-d197-ea93ecf5982b@i2se.com>
 <20180214202454.6e7ebeaf@naga.suse.cz>
 <431948292.48734.1518640216077@email.1und1.de>
 <20180304165717.6d4d8e68@naga.suse.cz>
Subject: Re: [PATCH 1/2] mmc: bcm2835: reset host on timeout
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev22
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K0:XZxKzR/V/Z93KpLqm46D24ZUkP/HZ4cpiopdbm+GMXWlAAFSHHl
 NYR9GPMpxkp2ZeXWCcIoeaKi9wo8fiboZgKhSbD2q6L3wQAD4Vhk2yCYhEip9ABeoVDoFdf
 a6yFI0ABed8GRrubyjADJ0VaoNLCvl7QHZJTHzB7R4b0RH/xq4Y1GJRTlpfKTObQ7TV1B16
 nikZfibyoYeNTylt4TZhg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/fnAZeESTos=:HjmeoBJpzRsZcWhkuKQ+BX
 h6h5/MtHWIWG+pkOkwQ9Cg2tV1xBJWXfSyqtN2unnJmrzATQlmJ099wJLdpLs+Tq+uDGQZIQ7
 b5IdhfD7iejEmrqud9aogDYm4/74PoxZ2M0F1grMgr1+069KHypWbCvf4Wv6R4FBSnqB2/b/A
 y/dnvkSKcHq5Lx/jdq1dtOOS2l4N9KrB3MzRp9IyzkUZsQVySO5FGysjHvj1d7pO5zpYlpfqZ
 3BLxHomYK5LnVsvrC+Kk/TZn+FWT6LANIChS7mBLtP1FDNNFiUXN18WiY4xSvawGA6gPtJ/eZ
 S6eT36gK4ScJPePbnr4Xfg7MTQAuw/4dvdhi4R+onCoVHg/9G4DbdsNgBaXV9iIdCZho8FD7b
 NdnrZi0iY+BuapggeTwxE5B0QRguQR6Riwyk6qHbjDSG9GOUx+P+e6fdhWPc2/HBBxU9Kxysv
 MvGGpC53EIcWVLP0s1PjeBj9k3fd5fJ/wXNjVxV/Qk5EddFTqiSMjEHKL0v7dQHtw+/eQsCMb
 rwptEG8Y7R0lsZmdgtXUZQdr6lgBJSw06fI9VjP/a9nYtoa2aqJN81/i3YWPS7SEeOlPZPXaM
 g4xTJESl7+8HgkAWRc7TwodD7xq1QQeHTg4TmNWnjk7gpmznDPxesnG+ojosDojZrv4lV3eEc
 wqNfCRfMV5Il0VH5EKQRvaWB1lp/NbE5YElSBiOae4ilRrdNU+TuXSqPsckdIYOtLIUsHD1ZO
 ZIPI+chQdCDf3jRn+zMyZBowFlmJXK4GKfKqg9lKuL7LVUGd20vfhfhfrs8=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

> Michal Suchánek <msuchanek@suse.de> hat am 4. März 2018 um 16:57 geschrieben:
> 
> 
> On Wed, 14 Feb 2018 21:30:16 +0100 (CET)
> Stefan Wahren <stefan.wahren@i2se.com> wrote:
> 
> > Hi Michal,
> > 
> > > Michal Suchánek <msuchanek@suse.de> hat am 14. Februar 2018 um
> > > 20:24 geschrieben:
> > > 
> > > 
> > > On Wed, 14 Feb 2018 17:49:31 +0100
> > > Stefan Wahren <stefan.wahren@i2se.com> wrote:
> > >   
> > > > Hi Michal,
> > > > 
> > > > [add Phil]
> > > > 
> > > > Am 14.02.2018 um 17:13 schrieb Michal Suchánek:  
> > > > > On Wed, 14 Feb 2018 16:36:49 +0100
> > > > > Michal Suchánek <msuchanek@suse.de> wrote:
> > > > >    
> > > > >> On Wed, 14 Feb 2018 15:58:31 +0100
> > > > >> Stefan Wahren <stefan.wahren@i2se.com> wrote:
> > > > >>    
> > > > >>> Hi Michal,
> > > > >>>
> > > > >>> Am 14.02.2018 um 15:38 schrieb Michal Suchanek:      
> > > > >>>> The bcm2835 mmc host tends to lock up for unknown reason so
> > > > >>>> reset it on timeout. The upper mmc block layer tries
> > > > >>>> retransimitting with single blocks which tends to work out
> > > > >>>> after a long wait.
> > > > >>>>
> > > > >>>> This is better than giving up and leaving the machine broken
> > > > >>>> for no obvious reason.        
> > > > >>> could you please provide more information about this issue
> > > > >>> (affected hardware, kernel config, version, dmesg,
> > > > >>> reproducible scenario)?   
> > > > > It tends to reproduce when upgrading a few packages with zypper
> > > > > and otherwise at random during system operation. It seems that
> > > > > for my card it worsens with age to some degree so perhaps it
> > > > > depends on the fragmentation of the internal card flash.
> > > > >
> > > > > Attaching dmesg and kernel config.    
> > > > 
> > > > do you noticed this issue before 4.15-rc4?  
> > > 
> > > I initially noticed it with 4.4 kernel with some backports to make
> > > it bootable on RPi.  
> > 
> > this confuses me. Gerd and i ported this driver from downstream and
> > finally it's got merged in 4.12. 
> > 
> > So do you mean that you backported the mainline version to 4.4 or the
> > downstream version of 4.4?
> 
> I did not backport it but looking at the changelog it is backport of
> the 4.12 driver. It does not look as the 4.15 driver though. Looks like
> there was some reorganization of the bcm mmc since then.
> 
> > 
> > On a quick look they seems identical, but they aren't.
> > 
> > > > 
> > > > Could you please test with 4.15 final again?  
> > >
> 
> I tried upgrading to the current master (4.16-rc3+) and the issue is
> still reproducible although less frequent. I did full upgrade from the
> install image which installs over 300 packages and the issue triggered
> somewhere around 200th while before installing a half dozen packages
> would usually trigger it.
> 

this is the same what i did during my stress tests. The step installed 475 packages. The timeout never occured.

Stefan
