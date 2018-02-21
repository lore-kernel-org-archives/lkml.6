Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965988AbeBUPYI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 10:24:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:47034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935786AbeBUPYG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 10:24:06 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49C6F217A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh@kernel.org
X-Google-Smtp-Source: AH8x226ygZFnZQrBBMLPSfRI95It3twsSRoaB63K7Kv/QEJjcGjX8sbqr9mpLqNzXj+1nMMTS9catzL6nTPYiww5h0c=
MIME-Version: 1.0
In-Reply-To: <CAMuHMdVJfKXWNFaN259JQ1bOVZQSbC-=u4Kmys2PE+HLa=xQKw@mail.gmail.com>
References: <20180220231046.32638-1-laurent.pinchart+renesas@ideasonboard.com>
 <20180220231046.32638-5-laurent.pinchart+renesas@ideasonboard.com> <CAMuHMdVJfKXWNFaN259JQ1bOVZQSbC-=u4Kmys2PE+HLa=xQKw@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 21 Feb 2018 09:23:44 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJA=2JLqRfERJ1hN=ErUqw+xT8OhZVMjSVeRH4mgrE36Q@mail.gmail.com>
Message-ID: <CAL_JsqJA=2JLqRfERJ1hN=ErUqw+xT8OhZVMjSVeRH4mgrE36Q@mail.gmail.com>
Subject: Re: [PATCH v4 04/16] of: changesets: Introduce changeset helper methods
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Matt Porter <mporter@konsulko.com>,
        Koen Kooi <koen@dominion.thruhere.net>,
        Guenter Roeck <linux@roeck-us.net>, Marek Vasut <marex@denx.de>,
        Wolfram Sang <wsa@the-dreams.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux I2C <linux-i2c@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2018 at 4:21 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Hi Laurent,
>
> On Wed, Feb 21, 2018 at 12:10 AM, Laurent Pinchart
> <laurent.pinchart+renesas@ideasonboard.com> wrote:
>> From: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
>>
>> Changesets are very powerful, but the lack of a helper API
>> makes using them cumbersome. Introduce a simple copy based
>> API that makes things considerably easier.
>>
>> To wit, adding a property using the raw API.
>>
>>         struct property *prop;
>>         prop = kzalloc(sizeof(*prop)), GFP_KERNEL);
>>         prop->name = kstrdup("compatible");
>>         prop->value = kstrdup("foo,bar");
>>         prop->length = strlen(prop->value) + 1;
>>         of_changeset_add_property(ocs, np, prop);
>>
>> while using the helper API
>>
>>         of_changeset_add_property_string(ocs, np, "compatible",
>>                         "foo,bar");
>>
>> Signed-off-by: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
>> [Fixed memory leak in __of_changeset_add_update_property_copy()]
>> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
>
> You missed one fix I have in my topic/overlays branch
> https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git/commit/?h=topic/overlays&id=150f95b9dec77ce371c229f7ac4d6dd8620bef4a

Are you planning to try to upstream all this? If not, I'll get Frank
to keep changing the overlay API to make carrying it out of tree more
painful. :)

Rob
