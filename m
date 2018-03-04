Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933171AbeCDAds (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Mar 2018 19:33:48 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35204 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932093AbeCDAdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Mar 2018 19:33:43 -0500
X-Google-Smtp-Source: AG47ELvmwv3IchXVqLyZgrRpIKji9AnqcmA8T29EH4VUjteG11k1mxPF4JskpK25yXFKVX2s/5qAfA==
Subject: Re: [GIT PULL] of_overlay_fdt_apply() for 4.17
From: Frank Rowand <frowand.list@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
References: <6868959a-029f-01b0-3411-fcd47d3cd001@gmail.com>
Message-ID: <e77d4de0-d9b2-da68-6783-255fc3ef8be7@gmail.com>
Date: Sat, 3 Mar 2018 16:33:41 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <6868959a-029f-01b0-3411-fcd47d3cd001@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 03/02/18 15:09, Frank Rowand wrote:
> Hi Rob,
> 
> Please pull the changes to create the overlay FDT apply API.
> 
> This is the v6 changes.

Laurent asked me to pull my separate patch "x86: devicetree:
fix config option around x86_flattree_get_config()"
https://lkml.org/lkml/2018/3/2/1148
into this series.  I have done that and created a v7 patch series.

If I get an ack from the x86 maintainers I will create a new pull
request based on the v7 patch series.

-Frank


> -Frank
> 
> The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:
> 
>   Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/frowand/linux.git tags/overlay_apply_fdt_v6-for-4.17
> 
> for you to fetch changes up to 50079779c77ed1639645604f8ecfbd38cb3cec79:
> 
>   of: improve reporting invalid overlay target path (2018-03-02 14:16:29 -0800)
> 
> ----------------------------------------------------------------
> Move duplicating and unflattening of an overlay flattened devicetree
> (FDT) into the overlay application code.  To accomplish this,
> of_overlay_apply() is replaced by of_overlay_fdt_apply().
> 
> ----------------------------------------------------------------
> Frank Rowand (4):
>       of: change overlay apply input data from unflattened to FDT
>       of: Documentation: of_overlay_apply() replaced by of_overlay_fdt_apply()
>       of: convert unittest overlay devicetree source to sugar syntax
>       of: improve reporting invalid overlay target path
> 
>  Documentation/devicetree/overlay-notes.txt       |   4 +-
>  drivers/of/Kconfig                               |   1 +
>  drivers/of/overlay.c                             | 134 ++++++++--
>  drivers/of/resolver.c                            |   6 -
>  drivers/of/unittest-data/Makefile                |  28 ++-
>  drivers/of/unittest-data/overlay.dts             | 101 ++++----
>  drivers/of/unittest-data/overlay_0.dts           |  14 ++
>  drivers/of/unittest-data/overlay_1.dts           |  14 ++
>  drivers/of/unittest-data/overlay_10.dts          |  27 ++
>  drivers/of/unittest-data/overlay_11.dts          |  28 +++
>  drivers/of/unittest-data/overlay_12.dts          |  14 ++
>  drivers/of/unittest-data/overlay_13.dts          |  14 ++
>  drivers/of/unittest-data/overlay_15.dts          |  30 +++
>  drivers/of/unittest-data/overlay_2.dts           |   9 +
>  drivers/of/unittest-data/overlay_3.dts           |   9 +
>  drivers/of/unittest-data/overlay_4.dts           |  18 ++
>  drivers/of/unittest-data/overlay_5.dts           |   9 +
>  drivers/of/unittest-data/overlay_6.dts           |  10 +
>  drivers/of/unittest-data/overlay_7.dts           |  10 +
>  drivers/of/unittest-data/overlay_8.dts           |  10 +
>  drivers/of/unittest-data/overlay_9.dts           |  10 +
>  drivers/of/unittest-data/overlay_bad_phandle.dts |  23 +-
>  drivers/of/unittest-data/overlay_bad_symbol.dts  |  25 +-
>  drivers/of/unittest-data/tests-overlay.dtsi      | 217 +---------------
>  drivers/of/unittest.c                            | 300 +++++++++++------------
>  include/linux/of.h                               |   6 +-
>  26 files changed, 585 insertions(+), 486 deletions(-)
>  create mode 100644 drivers/of/unittest-data/overlay_0.dts
>  create mode 100644 drivers/of/unittest-data/overlay_1.dts
>  create mode 100644 drivers/of/unittest-data/overlay_10.dts
>  create mode 100644 drivers/of/unittest-data/overlay_11.dts
>  create mode 100644 drivers/of/unittest-data/overlay_12.dts
>  create mode 100644 drivers/of/unittest-data/overlay_13.dts
>  create mode 100644 drivers/of/unittest-data/overlay_15.dts
>  create mode 100644 drivers/of/unittest-data/overlay_2.dts
>  create mode 100644 drivers/of/unittest-data/overlay_3.dts
>  create mode 100644 drivers/of/unittest-data/overlay_4.dts
>  create mode 100644 drivers/of/unittest-data/overlay_5.dts
>  create mode 100644 drivers/of/unittest-data/overlay_6.dts
>  create mode 100644 drivers/of/unittest-data/overlay_7.dts
>  create mode 100644 drivers/of/unittest-data/overlay_8.dts
>  create mode 100644 drivers/of/unittest-data/overlay_9.dts
> 
