Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A585CC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61DC52082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:01:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61DC52082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=diasemi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbeLEMB6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 07:01:58 -0500
Received: from mail1.bemta25.messagelabs.com ([195.245.230.131]:19603 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726149AbeLEMB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 07:01:57 -0500
Received: from [46.226.53.50] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-c.eu-west-1.aws.symcld.net id A9/0A-12541-03EB70C5; Wed, 05 Dec 2018 12:01:52 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1WSb0wTZxzH+9xd705Ct6OgPFY0S8Mr59UWX/h
  sSxz+id5QE2Lci20MOeRsu7WF9EooZol1vnFErEVRKVUKghohGqUaVApag0BViHRIumzODRf5
  s1D+KAQZuh4XHXvxJJ/8vt/f9/m++NG4OkpqaMHpEOw23qIlE4i74190sPo2Kkff1KNB8xX3K
  fSmOkyi6CMrOt9zRIkODbkAil09iyF3YAvq8fyEo/7ZDiUKTHaTqKGtkUC/v+oA6MQ/FzAUue
  UjUXW9m0B1h/twdOxeM4UqazoJNBVrV6InwU4ctf+chf4MefDMZdxI/0Zu7nUF4KZfVRBcdcR
  HcTe9v1Hc+EQu9+uTVpI7XvsY58oPjZHcKd9bwA175kiu8sQ84GYamihu6toq7krgOpb94ddK
  sy2/0JmnNL1tGsSK7iBn7LULd4EIWwYSaDXTAGDjwwBVBpbQJGOAZ/+OgTJA0ynMbvjjrCh5c
  GaGgoOVUVzyJDNZ8H7vFClxCrMdPqoP4TJnwPryGwtMMOmwL/zHgkfFZMN77l5SylQzO2D/s+
  +k8RJmJ3z2Yl4pMWBWwpcHGxdWcSYV/vK8BpMYMgysb+3FZV4KhwffKGX+CA7cmqBk/hyOPh0
  jpHjIrIVHD4ry2AAvnbxDyLwe/lU1gMnxa6D/9iQp88fwfO0oLrdMgt1Vz4ljINW7qIV30Yp3
  0Yp30YofEJcAyrebjSaHlTdbWINezxoMGWyGXnp6Hb+f3asTitkSQXSwBh1fIurEUuteS4HOJ
  jiugfiZFRSFu1qA76IxBJbTmHapKnaBylF/kF9YUGriRdMee7FFEEMgjaa1UBVtjWtJdsEoOP
  eZLfFbfSdDOlGbolIH47JKLOKtotkoS2HA0pMnD5/G1YSt0CZoUlUDUgYjmUzFtvcR7y6+D6z
  UJKuAQqFQJxYJdqvZ8X99BKTSQJusckspiWab4/1PI/ESWLyEJYBJJRz8f5LGBZYd8a/b9ln4
  tre852JGTbvz6IoDuZGUkvUoPfP74RWK5rakB9bLxkj+aG7wE3Tm01Oe0pwvxweXB41rxzes6
  64qy2vwb2pbnXf65g9zu0It0bqJXV8NpB2Y78o8l+6bnQ2WTG/G/QnumemNL56Cy7FvhjwvNY
  /TXKZvsxLPKGyhqq1aQjTxhtW4XeT/BWaMJUjsAwAA
X-Env-Sender: stwiss.opensource@diasemi.com
X-Msg-Ref: server-19.tower-302.messagelabs.com!1544011311!3594542!1
X-Originating-IP: [193.240.73.197]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.14.24; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 26391 invoked from network); 5 Dec 2018 12:01:52 -0000
Received: from unknown (HELO sw-ex-cashub01.diasemi.com) (193.240.73.197)
  by server-19.tower-302.messagelabs.com with AES128-SHA256 encrypted SMTP; 5 Dec 2018 12:01:52 -0000
Received: from SW-EX-MBX02.diasemi.com ([169.254.4.108]) by
 sw-ex-cashub01.diasemi.com ([10.20.16.141]) with mapi id 14.03.0382.000; Wed,
 5 Dec 2018 12:01:51 +0000
From:   Steve Twiss <stwiss.opensource@diasemi.com>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        Lee Jones <lee.jones@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Arnd Bergmann" <arnd@arndb.de>,
        Cory Maccarrone <darkstar6262@gmail.com>,
        "David Dajun Chen" <david.chen@diasemi.com>,
        Dong Aisheng <dong.aisheng@linaro.org>,
        Eric Miao <eric.miao@marvell.com>,
        Graeme Gregory <gg@slimlogic.co.uk>,
        Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
        Haojian Zhuang <haojian.zhuang@marvell.com>,
        Jin Park <jinyoungp@nvidia.com>,
        "Jorge Eduardo Candelaria" <jedu@slimlogic.co.uk>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@opensource.wolfsonmicro.com>,
        Mattias Nilsson <mattias.i.nilsson@stericsson.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Mike Rapoport <mike@compulab.co.il>,
        "Tony Lindgren" <tony@atomide.com>,
        Venu Byravarasu <vbyravarasu@nvidia.com>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        "patches@opensource.cirrus.com" <patches@opensource.cirrus.com>,
        "Support Opensource" <Support.Opensource@diasemi.com>
Subject: RE: [PATCH v2 00/22] mfd: demodularization of non-modular drivers
Thread-Topic: [PATCH v2 00/22] mfd: demodularization of non-modular drivers
Thread-Index: AQHUisAczvba87NOX02k8riZ/bkUjaVwDbfw
Date:   Wed, 5 Dec 2018 12:01:49 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB7021C509AD4@SW-EX-MBX02.diasemi.com>
References: <1543811009-15112-1-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <1543811009-15112-1-git-send-email-paul.gortmaker@windriver.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.20.35.200]
x-kse-attachmentfiltering-interceptor-info: protection disabled
x-kse-serverinfo: sw-ex-cashub01.diasemi.com, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 05/12/2018 11:28:00
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On 03 December 2018 04:23, Paul Gortmaker wrote:

> Subject: [PATCH v2 00/22] mfd: demodularization of non-modular drivers
> 
> [v1 --> v2: add some more commits as requested by Lee (MFD maintainer),
>  update the 00/NN text; re-do build and link testing on new linux-next. ]
> 
> This group of MFD drivers are all controlled by "bool" Kconfig settings,
> but contain various amounts of largely pointless uses of infrastructure
> related to modular operations, even though they can't be built modular.
> 
> We can easily remove/replace all of it.  We are trying to make driver
> code consistent with the Makefiles/Kconfigs that control them. 

For the DA9052 and DA9055, changes:

-  drivers/mfd/da9052-core.c         | 11 -----------
-  drivers/mfd/da9052-i2c.c          | 22 ++-------------------
-  drivers/mfd/da9052-irq.c          |  1 -
-  drivers/mfd/da9052-spi.c          | 22 ++-------------------
-  drivers/mfd/da9055-core.c         | 13 ++-----------
-  drivers/mfd/da9055-i2c.c          | 24 ++---------------------

The responsibility can fall back to Dialog for these changes. We will
submit Kconfig patches for these and make them explicitly non-modular.
This will remove the ambiguity caused by the Kconfig bool options.

Regards,
Steve

> This
> means not using modular functions/macros for drivers that can never be
> built as a module.  Some of the downfalls this oversight leads to are:
> 
>  (1) it is easy to accidentally write unused module_exit and remove code
>  (2) it can be misleading when reading the source, thinking it can be
>      modular when the Makefile and/or Kconfig prohibit it
>  (3) it requires the include of the module.h header file which in turn
>      includes nearly everything else, thus adding a lot of CPP overhead.
>  (4) it gets copied/replicated into other drivers and spreads quickly.
> 
> What we see in current drivers falls into one or more of the following
> categories:
> 
> 1) include of <linux/module.h> when it simply isn't needed
> 
> 2) Use of MODULE_LICENSE, MODULE_DEVICE_TABLE,  MODULE_AUTHOR etc.
>    macros that are no-ops for non-modular drivers.
> 
> 3) Creation of a module_exit() function that will be compiled and
>    linked in but never actually called for non-modular drivers.
> 
> 4) Addition of a platform_driver ".remove" function that is bound
>    into the struct but will never be called for non-module use cases.
> 
> Solution to #1 --> #3 is simple ; we just delete the related code.
> 
> The solution to #4 is similar - we delete the ".remove" function and
> the binding into the platform_driver struct.  However, since the same
> ".remove" function could also be triggered by an "unbind" (such as for
> pass-through of a device to a guest instance)  - so we also explicitly
> disable any unbind for the driver.
> 
> The unbind mask allows us to ensure we will see if there was some odd
> corner case out there that was relying on it.  Typically it would be a
> multi-port ethernet card passing a port through to a guest, so a
> sensible use case in MFD drivers seems highly unlikely.  This same
> solution has already been used in multiple other mainline subsystems.
> 
> Build testing was done on drivers/mfd for allyesconfig on x86_64, ARM
> and ARM-64 on a recent linux-next checkout.
> 
> Paul.
> 
> ---
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Cory Maccarrone <darkstar6262@gmail.com>
> Cc: David Dajun Chen <dchen@diasemi.com>
> Cc: Dong Aisheng <dong.aisheng@linaro.org>
> Cc: Eric Miao <eric.miao@marvell.com>
> Cc: Graeme Gregory <gg@slimlogic.co.uk>
> Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> Cc: Haojian Zhuang <haojian.zhuang@marvell.com>
> Cc: Jin Park <jinyoungp@nvidia.com>
> Cc: Jorge Eduardo Candelaria <jedu@slimlogic.co.uk>
> Cc: Laxman Dewangan <ldewangan@nvidia.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: Mattias Nilsson <mattias.i.nilsson@stericsson.com>
> Cc: Michael Hennerich <michael.hennerich@analog.com>
> Cc: Mike Rapoport <mike@compulab.co.il>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Venu Byravarasu <vbyravarasu@nvidia.com>
> Cc: linux-omap@vger.kernel.org
> Cc: patches@opensource.cirrus.com
> Cc: Support Opensource <support.opensource@diasemi.com>
> 
> 
> Paul Gortmaker (22):
>   mfd: aat2870-core: Make it explicitly non-modular
>   mfd: adp5520: Make it explicitly non-modular
>   mfd: as3711: Make it explicitly non-modular
>   mfd: da903x: Make it explicitly non-modular
>   mfd: da9052-*: Make it explicitly non-modular
>   mfd: da9055-i2c: Make it explicitly non-modular
>   mfd: da9055-core: make it explicitly non-modular
>   mfd: db8500-prcmu: drop unused MODULE_ tags from non-modular code
>   mfd: htc-i2cpld: Make it explicitly non-modular
>   mfd: max8925-core: drop unused MODULE_ tags from non-modular code
>   mfd: rc5t583: Make it explicitly non-modular
>   mfd: sta2x11: drop unused MODULE_ tags from non-modular code
>   mfd: syscon: Make it explicitly non-modular
>   mfd: tps65090: Make it explicitly non-modular
>   mfd: tps65910: Make it explicitly non-modular
>   mfd: tps80031: Make it explicitly non-modular
>   mfd: wm831x-spi: Make it explicitly non-modular
>   mfd: wm831x-i2c: Make it explicitly non-modular
>   mfd: wm831x-core: drop unused MODULE_ tags from non-modular code
>   mfd: wm8350-i2c: Make it explicitly non-modular
>   mfd: wm8350-core: drop unused MODULE_ tags from non-modular code
>   mfd: wm8400-core: Make it explicitly non-modular
> 
>  drivers/mfd/aat2870-core.c        | 40 +++------------------------------------
>  drivers/mfd/adp5520.c             | 30 +++++++----------------------
>  drivers/mfd/as3711.c              | 14 --------------
>  drivers/mfd/da903x.c              | 26 +++----------------------
>  drivers/mfd/da9052-core.c         | 11 -----------
>  drivers/mfd/da9052-i2c.c          | 22 ++-------------------
>  drivers/mfd/da9052-irq.c          |  1 -
>  drivers/mfd/da9052-spi.c          | 22 ++-------------------
>  drivers/mfd/da9055-core.c         | 13 ++-----------
>  drivers/mfd/da9055-i2c.c          | 24 ++---------------------
>  drivers/mfd/db8500-prcmu.c        | 10 ++++------
>  drivers/mfd/htc-i2cpld.c          | 18 +-----------------
>  drivers/mfd/max8925-core.c        |  7 +------
>  drivers/mfd/rc5t583.c             | 14 --------------
>  drivers/mfd/sta2x11-mfd.c         | 10 ++++------
>  drivers/mfd/syscon.c              | 12 +-----------
>  drivers/mfd/tps65090.c            | 30 +++++------------------------
>  drivers/mfd/tps65910.c            | 18 +-----------------
>  drivers/mfd/tps80031.c            | 37 ++----------------------------------
>  drivers/mfd/wm831x-core.c         |  7 ++-----
>  drivers/mfd/wm831x-i2c.c          | 20 ++------------------
>  drivers/mfd/wm831x-spi.c          | 24 ++---------------------
>  drivers/mfd/wm8350-core.c         |  6 ++----
>  drivers/mfd/wm8350-i2c.c          | 24 +----------------------
>  drivers/mfd/wm8400-core.c         | 18 +++---------------
>  include/linux/mfd/da9052/da9052.h |  1 -
>  26 files changed, 52 insertions(+), 407 deletions(-)
> 
> --
> 2.7.4

