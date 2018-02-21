Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751399AbeBUXte (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 18:49:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:34068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750741AbeBUXtc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 18:49:32 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5810521741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh@kernel.org
X-Google-Smtp-Source: AH8x227JR/nZyRmHBWOy3u635w9MgfkPRsDv+OlXW97tKvp3Y4sS2tvwbiPgeMRaRGAi0M9kAXUTVX8r0tl8/XEpDzQ=
MIME-Version: 1.0
In-Reply-To: <4098480.WkPaFBmRlF@avalon>
References: <20180220231046.32638-1-laurent.pinchart+renesas@ideasonboard.com>
 <20180220231046.32638-7-laurent.pinchart+renesas@ideasonboard.com>
 <CAL_Jsq+D4wwPSZbSXrJpwcNvB1Xth=Cn-bTyXL2RkSOb9s+d_A@mail.gmail.com> <4098480.WkPaFBmRlF@avalon>
From: Rob Herring <robh@kernel.org>
Date: Wed, 21 Feb 2018 17:49:10 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLR06_1=39JUXOyrSPP-p3LssWasZz2m=cgoHKaXh=Mhw@mail.gmail.com>
Message-ID: <CAL_JsqLR06_1=39JUXOyrSPP-p3LssWasZz2m=cgoHKaXh=Mhw@mail.gmail.com>
Subject: Re: [PATCH v4 06/16] of: unittest: changeset helpers
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:MEDIA DRIVERS FOR RENESAS - FCP"
        <linux-renesas-soc@vger.kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Matt Porter <mporter@konsulko.com>,
        Koen Kooi <koen@dominion.thruhere.net>,
        Guenter Roeck <linux@roeck-us.net>, Marek Vasut <marex@denx.de>,
        Wolfram Sang <wsa@the-dreams.de>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux I2C <linux-i2c@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2018 at 5:39 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Hi Rob,
>
> On Thursday, 22 February 2018 01:10:25 EET Rob Herring wrote:
>> On Tue, Feb 20, 2018 at 5:10 PM, Laurent Pinchart wrote:
>> > From: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
>> >
>> > Add a unitest specific for the new changeset helpers.
>> >
>> > Signed-off-by: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
>> > Signed-off-by: Laurent Pinchart
>> > <laurent.pinchart+renesas@ideasonboard.com>
>> > ---
>> >
>> >  drivers/of/unittest.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++
>> >  1 file changed, 54 insertions(+)
>> >
>> > diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
>> > index 7a9abaae874d..1b21d2c549a8 100644
>> > --- a/drivers/of/unittest.c
>> > +++ b/drivers/of/unittest.c
>> > @@ -609,6 +609,59 @@ static void __init of_unittest_changeset(void)
>> >
>> >  #endif
>> >  }
>> >
>> > +static void __init of_unittest_changeset_helper(void)
>> > +{
>> > +#ifdef CONFIG_OF_DYNAMIC
>>
>> I think this can be:
>>
>> if (!IS_ENABLED(CONFIG_OF_DYNAMIC))
>>   return;
>
> Not quite, as there are functions used below (such as of_changeset_init())
> that are not defined if CONFIG_OF_DYNAMIC isn't enabled. We could create stubs
> in that case but I believe that's out of scope for this patch series.

Okay. I thought we had the necessary stubs, but didn't check too closely.

>
>> Otherwise,
>>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>
> --
> Regards,
>
> Laurent Pinchart
>
