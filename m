Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754006AbeCFTVN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 14:21:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:42125 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753453AbeCFTVK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 14:21:10 -0500
Date: Tue, 6 Mar 2018 20:21:06 +0100
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Eric Anholt <eric@anholt.net>, bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-rpi-kernel@lists.infradead.org,
        Phil Elwell <phil@raspberrypi.org>, Gerd Hoffmann <kraxel@redhat.com>,
        linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        linux-arm-kernel@lists.infradead.org,
        Stefan Schake <stschake@gmail.com>
Subject: Re: [PATCH 1/2] mmc: bcm2835: reset host on timeout
Message-ID: <20180306202106.0abd51ca@kitsune.suse.cz>
In-Reply-To: <166274019.307112.1520085525833@email.1und1.de>
References: <97593d6e1a41af1baff61f7d9e6e68a450fc9da6.1518619058.git.msuchanek@suse.de>
        <1fbf0d77-cb53-f0fa-b810-e9954138d907@i2se.com>
        <20180214163649.3a0c9476@kitsune.suse.cz>
        <20180214165827.386b9bb1@kitsune.suse.cz>
        <ecf8dd61-ab16-b298-d197-ea93ecf5982b@i2se.com>
        <20180214202454.6e7ebeaf@naga.suse.cz>
        <166274019.307112.1520085525833@email.1und1.de>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sat, 3 Mar 2018 14:58:45 +0100 (CET)
Stefan Wahren <stefan.wahren@i2se.com> wrote:

> Hi Michal,
> 

> yesterday i finished my stress tests with Raspberry Pi 3.
> 
> Scenario:
> - copy Tumbleweed on SD card
> (openSUSE-Tumbleweed-ARM-JeOS-raspberrypi3.aarch64-2018.02.02-Build1.2.raw,
> Linux 4.14.15)
> - setup locales with yast
> - run zypper update
> - reboot
> - install and remove java 1.8 in a loop for at least 1 hour
> 
> Results of the different SD cards:
> Toshiba uSDHC Class 10 UHS-1 32 GB: PASS
> BASETech uSDHC Class 10 16 GB: PASS
> Samsung uSDHC EVO+ UHS-1 16 GB: PASS
> Samsung uSDHC Class 6 32 GB: PASS
> SanDisk Edge Class 4 16 GB: PASS
> Kingston uSDHC Class 10 UHS-1 32 GB: PASS
> QUMOX uSDHC Class 10 UHS-1 16 GB: FAIL (zypper segfaulted
> permantently) Transcend uSDHC Class 10 UHS-1 32 GB: PASS
> 
> I was never able to reproduce this timeout. 

For the record I was not able to reproduce the issue installing and
removing openjdk-1.7.0 in a loop for an hour on Leap 42.3 system which
is affected by the issue. This was a loop of repeatedly installing and
removing four packages and was executed 68 times. I enabled zypper
package caching to avoid spending time in download.

Thanks

Michal
