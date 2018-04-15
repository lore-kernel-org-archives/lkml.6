Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752662AbeDOXVK (ORCPT <rfc822;w@1wt.eu>);
        Sun, 15 Apr 2018 19:21:10 -0400
Received: from mout.web.de ([217.72.192.78]:40629 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751919AbeDOXVJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Apr 2018 19:21:09 -0400
Date: Mon, 16 Apr 2018 01:21:02 +0200
From: Hansjoerg Lipp <hjlipp@web.de>
To: Gabriel C <nix.or.die@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Passing luks passphrase from grub to systemd
Message-ID: <20180415232101.qhqjhdlwq4zkwvbf@hjlipp.my-fqdn.de>
References: <20180415190631.5nilksv3fr2clxbj@hjlipp.my-fqdn.de>
 <CAEJqkghu-c90=cocnkxW7zD9twkb0v=DTNbQgmUC4JGC6fvgWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEJqkghu-c90=cocnkxW7zD9twkb0v=DTNbQgmUC4JGC6fvgWw@mail.gmail.com>
User-Agent: NeoMutt/20170421 (1.8.2)
X-Provags-ID: V03:K1:jHGratHwPsLkcoGVzGJbHYPYCV81VsxVSvN/Y0gz6q27h4TKE9V
 XvXuvjGBlLsb8k1SDjr1V6r08vTTbAQCyGABzchhc7qy7MXSOpJTA1VW6t2ZQ9Qw71V+nsz
 m6auzDdyYc06G6LO0kt9A0nGqMtMvEAHdJ7ZCEA4YEsAZSQUBT9GfoWPqGMuXFYKQ9vqKAc
 WvcS5EQIZnQfEe6X1KJQA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QmKMmFWMovk=:xWgj2seQlAuVH+MxNKcwFj
 df6G3LUyngMWGpZF5BEk6rbetX2QFlNRsx8X2Af0k7FoWYhZbeYgFIUWLC/l2SIoFNyDquKXr
 34CxOIiSKmN5QJFOgiJv8y85qhozpSgMtxsPfvYyb3b0oSgZYZ+xiX501xJ9tRJewu3YYjBy6
 Olg3FXP3TknNd7fTJ5wmKIxY9zFMx5JXg0mRKcXpvnDw8B19f0fLB8/xtBmWUdS/LFsKLBCvi
 pyRaSuua/z1vwcQa+V1KmLFGlVhARUdz7INAx9cQ1B/HK7t2tStuohT5U7hl7h+iUfY7Q9vVm
 Ndi1bcsKvBs10BgvlGpek2IFu6bFnLrd8RGAmvmdaUHilAJOwR5xZUQ4HswRtu43Fp8EdTQlG
 k2hkGte9geya/ZwlGMYVBGPNqTfEBk3xlZDBYLIZy+fRrfdyi49zFaiNnd8JNk0dzb5erNu/J
 zhTRIT08hU2kOOJyaYK4LSO6hf9gPVRBRqJ+JSjzmMBZFOCgxKmvcRodMvncj0kmqcv1TQPvT
 VKaOgC/5z+p24HJrRG/Ps79EHkMLgUWPoTjuNcKpDoKIRbnaH5KgArLHKq9gFUjgtU6oSmvI5
 O9TTWU2Nu9pUPBYjcI7rbAg8faj6EOrWmWR+3VPH+s5+Mgy72EjSoD8M7a4v1AjgS6WvBIgAb
 lVc5qbDoEQzQAh4wKJn1P/KB+CecoFN1jziYUkIz16vGIjLR5r4iGTW8LDyM1QIux2gAKhRDv
 nkR0/pr2bD47aTpEEnfqAbHQDGVU1/gRqq7lWnEoyFgOe7xnQ2i680ZFmVPos+Dq9/Qj32i/u
 7uNn4Yrjw0vJL4JZifGvgg4JY2sUw==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Gabriel,

On Mon, Apr 16, 2018 at 12:35:33AM +0200, Gabriel C wrote:
> 2018-04-15 21:06 GMT+02:00 Hansjoerg Lipp <hjlipp@web.de>:
> > as I'm stuck with a (non-EFI x86_64) system with encrypted root
> > partition, I have to enter the passphrase twice (grub needs it for
> > getting the kernel etc., systemd needs it for mounting the root
> > partition). This can be quite inconvenient, especially if the passphrase
> > is long and contains special characters, and grub assumes a different
> > keyboard layout.
> > I therefore developed a proof of concept code allowing grub to pass the
> > passphrase to the kernel and systemd to get the passphrase from the
> > kernel. See the description and patch for the Linux part and the link to
> > all changes below.
> 
> Somethng like this is not needed.
> All that is possible already from userspace.
> 
> Systemd can do that on his own ( see systemd-cryptsetup-generator )
> ( other init ofc too ) assuming your initrd , cryptsetup and grub is
> setup correctly.

can this be done even if the /boot directory is located inside the
encrypted root partition? I'll have another look at this tomorrow as I'm
currently too tired. This would be really great news for me.  (And I'd
have to wonder how I didn't get this right on my own... I already
learned a lot about the boot process doing this, and obviously I still
do not understand enough.)

Thank you for your quick response,
Hansjoerg
