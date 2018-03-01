Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033987AbeCAS2n (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 13:28:43 -0500
Received: from mail-ot0-f175.google.com ([74.125.82.175]:41900 "EHLO
        mail-ot0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033953AbeCAS2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 13:28:39 -0500
X-Google-Smtp-Source: AG47ELticMP3wR81qZDEZDa8ahlcUbUaawJ1stK72bUnhgjF8N6sTQmtMZZKz23i6BROmFfpICpph8MmjgG8tMPDezs=
MIME-Version: 1.0
In-Reply-To: <CAOMZO5BsSpi_40ky5L_XafxNULnprphv9nhPCQVNgi+vmexD+Q@mail.gmail.com>
References: <CAOMZO5BsSpi_40ky5L_XafxNULnprphv9nhPCQVNgi+vmexD+Q@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 1 Mar 2018 15:28:37 -0300
Message-ID: <CAOMZO5DhpG+68CtrVR-nYbD3gjH5zoPiTqdz3NcUqSW5iJsOLg@mail.gmail.com>
Subject: Re: regmap: Failed to create debugfs directory
To: Mark Brown <broonie@kernel.org>
Cc: brgl@bgdev.pl, david@lechnology.com,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 1, 2018 at 3:19 PM, Fabio Estevam <festevam@gmail.com> wrote:
> Hi,
>
> Running linux-next 20180301 on a imx6q-sabresd the following
> regmap-debugfs warnings are seen:
>
> [    0.067965] CPU identified as i.MX6Q, silicon rev 1.2
> [    0.083466] vdd1p1: supplied by regulator-dummy
> [    0.084768] vdd3p0: supplied by regulator-dummy
> [    0.085816] vdd2p5: supplied by regulator-dummy
> [    0.109831] (NULL device *): Failed to create debugfs directory
> ....
>
> [    2.961117] input: EETI eGalax Touch Screen as
> /devices/soc0/soc/2100000.aips-bus/21a8000.i2c/i2c-2/2-0004/input/input0
> [    2.977027] (NULL device *): Failed to create debugfs directory
> [    2.983929] snvs_rtc 20cc000.snvs:snvs-rtc-lp: rtc core: registered
> 20cc000.snvs:snvs-rtc-lp as rtc0
> [    2.993457] i2c /dev entries driver
> [    3.002084] (NULL device *): Failed to create debugfs directory
> [    3.010452] imx2-wdt 20c0000.wdog: timeout 60 sec (nowayout=0)

This only happens when the regmap name is 'dummy'.

[    0.083651] vdd1p1: supplied by regulator-dummy
[    0.084929] vdd3p0: supplied by regulator-dummy
[    0.085974] vdd2p5: supplied by regulator-dummy
[    0.110028] *****regmap name: dummy
[    0.110090] (NULL device *): regmap*** Failed to create debugfs directory


[    3.001355] input: EETI eGalax Touch Screen as
/devices/soc0/soc/2100000.aips-bus/21a8000.i2c/i2c-2/2-0004/input/input0
[    3.016820] *****regmap name: dummy
[    3.020450] (NULL device *): regmap*** Failed to create debugfs directory
[    3.028316] snvs_rtc 20cc000.snvs:snvs-rtc-lp: rtc core: registered
20cc000.snvs:snvs-rtc-lp as rtc0
[    3.037854] i2c /dev entries driver
[    3.046467] *****regmap name: dummy
[    3.050078] (NULL device *): regmap*** Failed to create debugfs directory

How should we treat the dummy regmap entries?

Thanks
