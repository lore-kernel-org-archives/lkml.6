Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934263AbeCGPxT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 10:53:19 -0500
Received: from mail-ot0-f194.google.com ([74.125.82.194]:34935 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933958AbeCGPxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 10:53:12 -0500
X-Google-Smtp-Source: AG47ELti7M68atOzRXYtUtl58/um6CBtqemDk5XmJc4gSHC/Xo23VOOD//KrJ59emm+LzQovh+caW1C4cSRZ5lrhNmE=
MIME-Version: 1.0
In-Reply-To: <20180307145559.y4tyyzd2pbqrk4yb@localhost.localdomain>
References: <20180220163540.6704-1-ckeepax@opensource.cirrus.com>
 <CAOMZO5BNYkuz6pH2qZmj+4kBPQB=j-JniiqVbqzdH8nTOXVZQQ@mail.gmail.com> <20180307145559.y4tyyzd2pbqrk4yb@localhost.localdomain>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 7 Mar 2018 12:53:10 -0300
Message-ID: <CAOMZO5BFRpOfZWfuK8ntfAdYG82uUW5HpaSwD4+P-SXY4W3Ujg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] mfd: arizona: Update reset pin to use GPIOD
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 7, 2018 at 11:55 AM, Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:

> Hmm... this raises a rather good point that I hadn't considered.
> This driver is used in a lot of shipping devices and the old
> style GPIO calls didn't take the activeness of the GPIO into
> account just blindly setting the value you asked for. However the
> new style calls do take this into account.
>
> The trouble is I guess we don't know whether most users bothered
> to set GPIO_ACTIVE_LOW or not. So it is very hard to say here if
> we are about to breaking a lot of existing device trees here.
>
> I guess probably the safest approach is to use
> gpiod_set_raw_value_cansleep here?

Yes, probably needed to avoid breakage of existing systems.
