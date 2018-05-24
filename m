Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970596AbeEXOzZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 10:55:25 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:34575 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966012AbeEXOzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 10:55:19 -0400
X-Google-Smtp-Source: ADUXVKIX+0zRNO2M9LSMM1f2+KvZYvXAPxAQImK7y3CQspVN1I3KE8yMqjaGXISiU6pmWp/5CEQt15BD+jZOy/J42Ls=
MIME-Version: 1.0
References: <20180522165842.233949-1-groeck@google.com> <s5hmuwqpjdd.wl-tiwai@suse.de>
 <20180523135609.GK4828@sirena.org.uk> <CABXOdTeCr-ExO9O3XAHK-DnNf5yLGO0TPkXgs60TB90jGNB2_Q@mail.gmail.com>
 <20180523155811.GO4828@sirena.org.uk> <CABXOdTePWquSQaFQsoNTrVNmYydZLqF534zeoTfz0RfLDHSseA@mail.gmail.com>
 <20180524141842.GW4828@sirena.org.uk>
In-Reply-To: <20180524141842.GW4828@sirena.org.uk>
From: Guenter Roeck <groeck@google.com>
Date: Thu, 24 May 2018 07:55:06 -0700
Message-ID: <CABXOdTfKXqgRecs3xuxb-XRodJkK7+h5V0hqt889CsD6vkm5yA@mail.gmail.com>
Subject: Re: [RFC/RFT PATCH] ASoC: topology: Improve backwards compatibility
 with v4 topology files
To: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, Guenter Roeck <groeck@chromium.org>,
        "Patel, Chintan M" <chintan.m.patel@intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2018 at 7:18 AM Mark Brown <broonie@kernel.org> wrote:

> On Wed, May 23, 2018 at 09:17:23AM -0700, Guenter Roeck wrote:
> > On Wed, May 23, 2018 at 8:58 AM Mark Brown <broonie@kernel.org> wrote:

> > > I'm saying we should move them there.  They're clearly part of the
> > > userspace ABI and therefore belong in uapi, it was a mistake to let
them
> > > be elsewhere.

> > They define a firmware file format. Not sure if I would call that
userspace
> > ABI.

> It's a binary provided by userspace to the kernel, I'd say that's
> clearly an ABI.

> > I don't mind adding the structures to
> > sound/soc/intel/skylake/skl-tplg-interface.h,
> > but it seems a bit out of scope to tie this with moving the file to
> > include/uapi/sound.
> > I think that should be a separate discussion.

> Is there some reason not to just do it while we're looking at this?  I
> don't see why we wouldn't want to do this.

I don't mind doing this. However, keeping the change local and in a single
patch
would make it easier to backport, and I think that the ability to backport
would be
essential to get more than one-person test coverage. I also would have liked
feedback from someone at Intel, at least for the Skylake specific
structures.

Anyway, what file do you have in mind for the structure definitions, both
for the ones
in soc-tolopogy.c and the ones needed in skl-topology.c ? Everything into
asoc.h,
or something else ?

Guenter
