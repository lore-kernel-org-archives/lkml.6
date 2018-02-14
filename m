Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162741AbeBNTLI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 14:11:08 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:35568 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162681AbeBNTLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 14:11:06 -0500
X-Google-Smtp-Source: AH8x226ErFMwaUBbQFn5P3Ejlu+oKe5CxLYZ2sWP7TxeaBOJak/aH5nucjx78mWI1rXkC576ltZywA==
Message-ID: <1518635464.3674.2.camel@redhat.com>
Subject: Re: [Nouveau] 4.16-rc1: UBSAN warning in
 nouveau/nvkm/subdev/therm/base.c + oops in nvkm_therm_clkgate_fini
From: Lyude Paul <lyude@redhat.com>
To: Pierre Moreau <pmoreau@pmoreau.org>,
        Ilia Mirkin <imirkin@alum.mit.edu>
Cc: Meelis Roos <mroos@linux.ee>, nouveau <nouveau@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel list <linux-kernel@vger.kernel.org>
Date: Wed, 14 Feb 2018 14:11:04 -0500
In-Reply-To: <20180214174125.b5bdowaadck3vf5n@pmoreau.org>
References: <alpine.LRH.2.21.1802132200260.24929@math.ut.ee>
         <alpine.LRH.2.21.1802141628110.25362@math.ut.ee>
         <CAKb7Uvj3MKGzNNcrc=-JA5GN4jt9+TU7ZjWDZpccmYJLDo76WQ@mail.gmail.com>
         <CAKb7UvhRt=25J5aOUZusdE51hh1JVc45aQ8OhCVeOJwzYvLOJw@mail.gmail.com>
         <20180214174125.b5bdowaadck3vf5n@pmoreau.org>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.4 (3.26.4-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Actually this was brought up to me already, there's a fix on the mailing list
for this I reviewed a little while ago from nvidia that we should pull in:

https://patchwork.freedesktop.org/patch/203205/

Would you guys mind confirming that this patch fixes your issues?

On Wed, 2018-02-14 at 18:41 +0100, Pierre Moreau wrote:
> On 2018-02-14 — 09:36, Ilia Mirkin wrote:
> > On Wed, Feb 14, 2018 at 9:35 AM, Ilia Mirkin <imirkin@alum.mit.edu> wrote:
> > > On Wed, Feb 14, 2018 at 9:29 AM, Meelis Roos <mroos@linux.ee> wrote:
> > > > > This is 4.16-rc1+todays git on a lowly P4 with NV5, worked fine in
> > > > > 4.15:
> > > > 
> > > > NV5 in another PC (secondary card in x86-64) made the systrem crash on
> > > > boot, in nvkm_therm_clkgate_fini.
> > > 
> > > Mind booting with nouveau.debug=trace? That should hopefully tell us
> > > more exactly which thing is dying. If you have a cross-compile/distcc
> > > setup handy, a bisect may be even more useful.
> > 
> > Erm, sorry, nevermind. You even said it -- nvkm_therm_clkgate_fini is
> > somehow mis-hooked up for NV5 now. A bisect result would still make
> > the culprit a lot more obvious.
> 
> CC’ing Lyude Paul as she hooked up the clockgating support.
> 
> Looking at the code, only NV40+ do have a therm engine. Therefore, shouldn’t
> nvkm_therm_clkgate_enable(), nvkm_therm_clkgate_fini() and
> nvkm_therm_clkgate_oneinit() all check for therm being not NULL, on top of
> their check for the clkgate_* hooks being there? Or instead, maybe have the
> check in nvkm_device_init() nvkm_device_init()?
> 
> Pierre
-- 
Cheers,
	Lyude Paul
