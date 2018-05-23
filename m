Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754755AbeEWQaA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 12:30:00 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:43711 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754661AbeEWQ37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 12:29:59 -0400
X-Google-Smtp-Source: AB8JxZpywGTjgljGkw/5Zp9mdmbs/PkRdgZwx+2DORzTwhMciEgGmtAWnek8MvZ/VpDHunY1sefY5M/wtk4NMLHFFw8=
MIME-Version: 1.0
References: <20180522165842.233949-1-groeck@google.com> <s5hmuwqpjdd.wl-tiwai@suse.de>
In-Reply-To: <s5hmuwqpjdd.wl-tiwai@suse.de>
From: Guenter Roeck <groeck@google.com>
Date: Wed, 23 May 2018 09:29:46 -0700
Message-ID: <CABXOdTf4GhycxC6TNyigS6YyiLXbZK=DHpP2Wzhw7405xVB3BA@mail.gmail.com>
Subject: Re: [RFC/RFT PATCH] ASoC: topology: Improve backwards compatibility
 with v4 topology files
To: Takashi Iwai <tiwai@suse.de>
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
        Guenter Roeck <groeck@chromium.org>,
        "Patel, Chintan M" <chintan.m.patel@intel.com>,
        Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2018 at 6:54 AM Takashi Iwai <tiwai@suse.de> wrote:

> On Tue, 22 May 2018 18:58:42 +0200,
> Guenter Roeck wrote:
> >
> > +struct skl_dfw_v4_module_caps {
> > +     u32 set_params:2;
> > +     u32 rsvd:30;
> > +     u32 param_id;
> > +     u32 caps_size;
> > +     u32 caps[HDA_SST_CFG_MAX];
> > +};

> Missing __packed attribute?


Yes and no. The original structure (see
sound/soc/intel/skylake/skl-tplg-interface.h
in v4.5.y and earlier) doesn't have the __packed attribute either. I guess
it doesn't hurt,
since it is all u32, so I'll add it in.

Guenter

> And I'm wondering whether we should move these definitions to uapi
> headers.


> thanks,

> Takashi
