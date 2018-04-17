Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752427AbeDQIeQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 04:34:16 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:37830 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751893AbeDQIeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 04:34:12 -0400
X-Google-Smtp-Source: AIpwx49AzBrj5AxGa6iqwm5W5H/67HSdwr3AcqNWVqjWv3iwEKLysTd1TvlMWcXdb9CucYvvsK1DZ6369bw4wR3cZdY=
MIME-Version: 1.0
In-Reply-To: <20180409091051.2944-1-benjamin.tissoires@redhat.com>
References: <20180409091051.2944-1-benjamin.tissoires@redhat.com>
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date: Tue, 17 Apr 2018 10:34:11 +0200
Message-ID: <CAO-hwJJnHPEQ+R+8qWb1Dn+otqgmbcKgiNDOyNkVBD+xdzY_zw@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] Input: support for latest Lenovo thinkpads (series 80)
To: =?UTF-8?B?5buW5bSH5qau?= <kt.liao@emc.com.tw>
Cc: Oliver Haessler <oliver@redhat.com>, Benjamin Berg <bberg@redhat.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Aaron Ma <aaron.ma@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi KT,

gentle ping :)

Could you ACK/NACK this series?

Dmitry, the first patch could go without KT's approval. Also I
realized that Aaron submitted a similar patch for the X1 Carbon last
October: https://patchwork.kernel.org/patch/10008513/
So I think the first one should go ASAP now that the laptops are
shipping from Lenovo.

Cheers,
Benjamin

On Mon, Apr 9, 2018 at 11:10 AM, Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
> Hi Dmitry,
>
> Here is the v2 of the Lenovo 80 series.
> Changes from v1:
> - included patch to convert a function to static from build bot
> - use of device property instead of platform data (thus the new device tree
>   binding)
>
> BTW, KT, if you want to add your Signed-off-by on the patches, feel free to
> do so. You were of tremendous help :)
>
> Cheers,
> Benjamin
>
> Benjamin Tissoires (9):
>   Input: synaptics - add Lenovo 80 series ids to SMBus
>   input: elan_i2c_smbus - fix corrupted stack
>   Input: elan_i2c - add trackstick report
>   Input: elantech - split device info into a separate structure
>   Input: elantech_query_info() can be static
>   Input: elantech - query the resolution in query_info
>   Input: elantech - add support for SMBus devices
>   Input: elantech - detect new ICs and setup Host Notify for them
>   input: psmouse-smbus: allow to control psmouse_deactivate
>
>  .../devicetree/bindings/input/elan_i2c.txt         |   1 +
>  drivers/input/mouse/Kconfig                        |  12 +
>  drivers/input/mouse/elan_i2c_core.c                |  90 +++-
>  drivers/input/mouse/elan_i2c_smbus.c               |  22 +-
>  drivers/input/mouse/elantech.c                     | 479 +++++++++++++++------
>  drivers/input/mouse/elantech.h                     |  69 ++-
>  drivers/input/mouse/psmouse-base.c                 |  21 +-
>  drivers/input/mouse/psmouse-smbus.c                |  24 +-
>  drivers/input/mouse/psmouse.h                      |   2 +
>  drivers/input/mouse/synaptics.c                    |   5 +-
>  10 files changed, 565 insertions(+), 160 deletions(-)
>
> --
> 2.14.3
>
