Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLACK,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F7F8C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 07:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E91D208FA
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 07:11:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E91D208FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbeGKHOo convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 03:14:44 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39391 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbeGKHOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 03:14:43 -0400
Received: by mail-ed1-f66.google.com with SMTP id w14-v6so18386667eds.6;
        Wed, 11 Jul 2018 00:11:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=E9+Qa+eJcgOUUDXFI8y+mug42fVGMlbpPRlnCIicivY=;
        b=o38LPxcjF6qSSeHxTdijKHACb5y5PxJ8PSQV1AKyASbwQssQ2obFvO5uyK2K1A5FsK
         0eGAZFpO4yUuRN3z9xMX0ZSmqsY8fzXdEyb9I9y3vpHLkDr/+bDDgj1ipl2roLfom1nH
         Iqt5i/avszhbzX+ZceAeKopP7Ig/G6VKeTf5vNUa3Pq5bVp7ZyBT1gWwIPN1NK1+/kKp
         8FgVUHKIoZ/0Cb1lhgYHQt0y1ixVUaIhZac4KoYvnK8Nnonza1tlHTe2mEugOM6dpcuq
         MGiODkFPfeyLdswTdo9rhWThKYAEPGhu1gx0v7MEOqKv1tNIhp0gxy0VNWPaYKmI5cnh
         1QUg==
X-Gm-Message-State: APt69E3NiAHUUS0q7JViwqZ7LXpcD3BMkv6rISNupZ0ySRp7/YJWfAVX
        SaE5j/xYNRll2PCuHOOqUZiv2MTI
X-Google-Smtp-Source: AAOMgpc88+Yie3g2Cn6ZU2XrhFYLiZS03QS67Yw1lIoWEsu3CyYjmFnDmPhW0b7EaDlR+ZZYqUgoWg==
X-Received: by 2002:a50:9f6f:: with SMTP id b102-v6mr30338618edf.219.1531293112039;
        Wed, 11 Jul 2018 00:11:52 -0700 (PDT)
Received: from mail-wm0-f43.google.com (mail-wm0-f43.google.com. [74.125.82.43])
        by smtp.gmail.com with ESMTPSA id o89-v6sm735314eda.18.2018.07.11.00.11.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 00:11:51 -0700 (PDT)
Received: by mail-wm0-f43.google.com with SMTP id v128-v6so1299037wme.5;
        Wed, 11 Jul 2018 00:11:51 -0700 (PDT)
X-Received: by 2002:a1c:6fdd:: with SMTP id c90-v6mr16204965wmi.16.1531293111207;
 Wed, 11 Jul 2018 00:11:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a15a:0:0:0:0:0 with HTTP; Wed, 11 Jul 2018 00:11:30
 -0700 (PDT)
In-Reply-To: <3034661.dpXlJLpBba@jernej-laptop>
References: <20180710203511.18454-1-jernej.skrabec@siol.net>
 <20180710203511.18454-11-jernej.skrabec@siol.net> <CAGb2v66vU4gBewGjLL-Ohx6mvKOVu4dDdwKNsXrkr3nZsSq3Cg@mail.gmail.com>
 <3034661.dpXlJLpBba@jernej-laptop>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 11 Jul 2018 15:11:30 +0800
X-Gmail-Original-Message-ID: <CAGb2v66Ghosy92MQH8YmqxkimNe5S0sYSVmt+X-ZsDHYzPK=EA@mail.gmail.com>
Message-ID: <CAGb2v66Ghosy92MQH8YmqxkimNe5S0sYSVmt+X-ZsDHYzPK=EA@mail.gmail.com>
Subject: Re: [PATCH v2 10/18] drm/sun4i: mixer: Read id from DT
To:     =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@siol.net>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 3:10 PM, Jernej Škrabec <jernej.skrabec@siol.net> wrote:
> Dne sreda, 11. julij 2018 ob 05:11:56 CEST je Chen-Yu Tsai napisal(a):
>> On Wed, Jul 11, 2018 at 4:35 AM, Jernej Skrabec <jernej.skrabec@siol.net>
> wrote:
>> > Currently, TCON supports 2 ways to match TCON with engine (mixer in this
>> > case). Old way is to just traverse of graph backwards and compare node
>> > pointer. New way is to match TCON and engine by their respective ids.
>> > All SoCs with DE2 enabled till now used the old way, which means mixer
>> > id was never used and thus never implemented.
>> >
>> > However, for R40, only the new way will be used. To prepare for that,
>> > implement mixer id fetching from DT.
>> >
>> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
>> > ---
>> >
>> >  drivers/gpu/drm/sun4i/sun8i_mixer.c | 40 +++++++++++++++++++++++++++--
>> >  1 file changed, 38 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c
>> > b/drivers/gpu/drm/sun4i/sun8i_mixer.c index aa81b9838ae8..4bd4d8ccb34f
>> > 100644
>> > --- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
>> > +++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
>> > @@ -22,6 +22,7 @@
>> >
>> >  #include <linux/component.h>
>> >  #include <linux/dma-mapping.h>
>> >  #include <linux/of_device.h>
>> >
>> > +#include <linux/of_graph.h>
>> >
>> >  #include <linux/reset.h>
>> >
>> >  #include "sun4i_drv.h"
>> >
>> > @@ -322,6 +323,42 @@ static struct regmap_config sun8i_mixer_regmap_config
>> > = {>
>> >         .max_register   = 0xbfffc, /* guessed */
>> >
>> >  };
>> >
>> > +static int sun8i_mixer_of_get_id(struct device_node *node)
>> > +{
>> > +       struct device_node *port, *ep;
>> > +       int ret = -EINVAL;
>> > +
>> > +       /* output is port 1 */
>> > +       port = of_graph_get_port_by_id(node, 1);
>> > +       if (!port)
>> > +               return -EINVAL;
>> > +
>> > +       /* try to find downstream endpoint */
>> > +       for_each_available_child_of_node(port, ep) {
>> > +               struct device_node *remote;
>> > +               u32 reg;
>> > +
>> > +               remote = of_graph_get_remote_endpoint(ep);
>> > +               if (!remote)
>> > +                       continue;
>> > +
>> > +               ret = of_property_read_u32(remote, "reg", &reg);
>> > +               if (!ret) {
>> > +                       of_node_put(remote);
>> > +                       of_node_put(ep);
>> > +                       of_node_put(port);
>> > +
>> > +                       return reg;
>> > +               }
>> > +
>> > +               of_node_put(remote);
>> > +       }
>> > +
>> > +       of_node_put(port);
>> > +
>> > +       return ret;
>> > +}
>> > +
>>
>> The above looks good.
>>
>> >  static int sun8i_mixer_bind(struct device *dev, struct device *master,
>> >
>> >                               void *data)
>> >
>> >  {
>> >
>> > @@ -353,8 +390,7 @@ static int sun8i_mixer_bind(struct device *dev, struct
>> > device *master,>
>> >         dev_set_drvdata(dev, mixer);
>> >         mixer->engine.ops = &sun8i_engine_ops;
>> >         mixer->engine.node = dev->of_node;
>> >
>> > -       /* The ID of the mixer currently doesn't matter */
>> > -       mixer->engine.id = -1;
>> > +       mixer->engine.id = sun8i_mixer_of_get_id(dev->of_node);
>>
>> Should you be handling error codes?
>
> Sadly, no. Other supported DE2 SoC miss reg property in DT and it would break
> them. Additionally, V3s has only one mixer and thus technically doesn't
> violate binding with omiting mixer id.
>
> Anyway, it was -1 all the time before and not really used, so having negative
> value doesn't change anything for other SoCs. If this fails and it's needed,
> it would stop at mixer <-> TCON matching stage anyway.
>
> I guess I should add comment for that.

Yes. Please. We'll leave the rest till later. I plan to fix up the missing
IDs for all the other SoCs anyway.

ChenYu
