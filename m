Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225BAC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D931320823
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549404486;
	bh=33gU8Y67ldAEaOcxe+uTft9byPtSrzIGHSfE+Y3SiQM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=YNyU1duY5ybpD3PYwM2q5HNDnPFzkEV6azfOmNINcuBT7u6hs8C3G5j1ICybSEur7
	 NNM9FfU9eO/VEtFxWDwlVkBr0sg+Qqdi84p0kwRaE8c1qnxc/21K+KaXv4V0zH1BW0
	 Y8bsUj2Jhfx870VHyFE7jizft1WC77wUqoa/4ooM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729915AbfBEWIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 17:08:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:55506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbfBEWID (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 17:08:03 -0500
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7CCD218A1;
        Tue,  5 Feb 2019 22:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549404481;
        bh=33gU8Y67ldAEaOcxe+uTft9byPtSrzIGHSfE+Y3SiQM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fbpST3CeLMzonZVG0QSgJ5FSMAPzLvRaNguVm+sMWh7p70d7JxVl0k9D1UCZipDa/
         UwZCvKL74EEUpdmrHzvWCWzVbF5z98EH1geSe071aWnczmhR0+xUxGCinwQ9aoRYHR
         X2JmTw3y+nAqAR1XlAgRIlzQvafbFKDIdXf1IIG0=
Received: by mail-ua1-f49.google.com with SMTP id d2so1667431ual.2;
        Tue, 05 Feb 2019 14:08:01 -0800 (PST)
X-Gm-Message-State: AHQUAubnfxIYJgF2r/wTT02fiJkST0mGutd03TCHyLwDT5iihIamsztu
        Xsvh7rBXj+cwDh+0ykftUuGLJ8HldQDvz/v0DAc=
X-Google-Smtp-Source: AHgI3IYsnUCH6kMaEcnA6Waww1et1FUvdYMjHFv1pkeixMBd7AsguRH4+lG1bx/GvhyJUOkPzdNO62bDo5fPHcaGybE=
X-Received: by 2002:ab0:63d6:: with SMTP id i22mr2721638uap.137.1549404480766;
 Tue, 05 Feb 2019 14:08:00 -0800 (PST)
MIME-Version: 1.0
References: <1471462023-119645-1-git-send-email-cristina.moraru09@gmail.com>
 <20160818175505.GM3296@wotan.suse.de> <20160825074313.GC18622@lst.de> <20160825201919.GE3296@wotan.suse.de>
In-Reply-To: <20160825201919.GE3296@wotan.suse.de>
From:   Luis Chamberlain <mcgrof@kernel.org>
Date:   Tue, 5 Feb 2019 16:07:46 -0600
X-Gmail-Original-Message-ID: <CAB=NE6UfkNN5kES6QmkM-dVC=HzKsZEkevH+Y3beXhVb2gC5vg@mail.gmail.com>
Message-ID: <CAB=NE6UfkNN5kES6QmkM-dVC=HzKsZEkevH+Y3beXhVb2gC5vg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] Add CONFIG symbol as module attribute
To:     Christoph Hellwig <hch@lst.de>,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     Cristina Moraru <cristina.moraru09@gmail.com>,
        "vegard.nossum@gmail.com" <vegard.nossum@gmail.com>,
        Valentin Rothberg <valentinrothberg@gmail.com>,
        Hannes Reinecke <hare@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <mmarek@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tom Gundersen <teg@jklm.no>, Kay Sievers <kay@vrfy.org>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        backports@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "rafael.j.wysocki" <rafael.j.wysocki@intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Takashi Iwai <tiwai@suse.de>,
        Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Paul Bolle <pebolle@tiscali.nl>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Laurence Oberman <loberman@redhat.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Tejun Heo <tj@kernel.org>,
        Jej B <James.Bottomley@hansenpartnership.com>,
        "Theodore Ts'o" <tytso@mit.edu>, danijons@student.chalmers.se,
        Andrzej Wasowski <wasowski@itu.dk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2016 at 2:19 PM Luis R. Rodriguez <mcgrof@kernel.org> wrote:
>
> On Thu, Aug 25, 2016 at 09:43:13AM +0200, Christoph Hellwig wrote:
> > The idea seems useful, but I reallt don't like the 'reverse-engineering'
> > approach.
> >
> > If we want to this properly from the ground up we should just split out
> > our CONFIG_ SYMBOLS into
> >
> > MODULE_* - builds exactly one module (tristate, or maybe also as a built-in
> > only one, then like a bool)
> >
> > CONFIG_* - just bool, MODULE_ may depend on it, too.
>
> Curious what does the split buy us if the real meaningful input is the value
> assigned to the config ? Ie, MODULE_FOO=m would be the modules we want to
> check for.

Also, unless you have kernel sources I don't think you could still
easily infer which MODULE_* config option enabled the module, could
you? And this was one of the original goals with this patch set. I
still think extending the modinfo section would be needed to allow
udevadm info to easily extract the information, no?

> > The other nice thing is that we could probably fold most of the Makefiles
> > into Kconfig using that methods as well, by listing the objectes required
> > for a module, e.g.
>
> OK If the Kconfig file has the objects listed I can see the gain of using
> Kconfig then to more easily map out to a symbol, given doing this on Makefiles
> is not straight forward.
>
> > module NVME_TARGET
> >       tristate "NVMe Target support"
> >       depends on BLOCK
> >       depends on CONFIGFS_FS
> >       name nvmet
> >       objects core.o configfs.o admin-cmd.o io-cmd.o fabrics-cmd.o
> >       objects discovery.o
> >
> > module NVME_TARGET_LOOP
> >       tristate "NVMe loopback device support"
> >       depends on BLK_DEV_NVME
> >       depends on NVME_TARGET
> >       select NVME_FABRICS
> >       select SG_POOL
> >       name nvme-loop
> >       objects loop.o
>
> I can see a huge win of having a direct specification that provides as a
> feature two way mapping from CONFIG <--> module (objects) and backwards again
> easily and clearly without hacks, specially if upon boot then we can then
> provide the precise kernel configuration you need, for both built-in and
> modules. The above could help with modules -- for built-in reverse mapping
> we'd need something else, perhaps a configurable option to keep tabs on
> inits called with associated configs.
>
> The above would be a pretty intrusive change though, in comparison to
> Cristina's original approach.

I think this is the biggest issue so far, and that we have no code to
showcase for it. Meanwhile pegging at least a kconfig symbol to
modinfo for at least a lot of modules would help considerably for
other use cases mentioned.

> The reverse-engineering object --> config
> aspect of her work and of the old scripts/kconfig/streamline_config.pl
> explains why it was hard. I'd be curious to learn of other gains possible
> other than those listed so far, if we had this.
>
> Re-iterating gains of having a simple two way CONFIG <--> module (objects)
> mapping (following the above proposal now):
>
> a) When optimizing build requirements for a kernel for a system.
>    That is you boot into a distro kernel and then want to build
>    a slim kernel only with sensible kernel configuration options.
>
> b) When you are on a distribution kernel but the distribution
>    kernel provided lacks hardware support for your device, you
>    may either want to upgrade the full kernel in which case you
>    want to do a) or -- you may want to just a backports release
>    which provides just the modules you need, you'd use it on top
>    of the distribution kernel.
>
> c) Having the mapping in sysfs would allow to simplify
>    streamline_config.pl avoid parsing Makefiles in perl. (From Michal)

It took me a while to recall where this was and why after 3 years of
not following up on this thread. So in case others fall into the same
boat, the sysfs gain here is that the modinfo section could be
readable then on any module's:

/sys/module/e1000/section/kconfig_symb

> d) Fold most of the Makefiles into Kconfig
>
> In retrospect c) still seems related to a) as we'd do away with
> the hacks completely needed by streamline_config.pl, a) can be
> augmented if we figure out a built-in solution as well.
>
> d) Just seems like collateral of a more precise mapping than
> what a Makefile provides. Anything else ?

In lieu of no Luke Skywalker, if you will, for a large kconfig revamp
on this, I'm inclined to believe *at least* having some kconfig_symb
exposed for some modules is better than nothing. Christoph are you
totally opposed to this effort until we get a non-reverse engineered
effort in place? It just seems like an extraordinary amount of work
and I'm not quite sure who's volunteering to do it.

Other stakeholders may benefit from at least having some config -->
module mapping for now. Not just backports or building slimmer
kernels.

 Luis
