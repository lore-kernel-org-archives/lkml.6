Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967726AbeBNMw1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 07:52:27 -0500
Received: from lilium.sigma-star.at ([109.75.188.150]:49884 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967589AbeBNMw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 07:52:26 -0500
From: Richard Weinberger <richard@sigma-star.at>
To: Enrico Weigelt <lkml@metux.net>, Aleksa Sarai <asarai@suse.de>
Cc: Linux Containers <containers@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: plan9 semantics on Linux - mount namespaces
Date: Wed, 14 Feb 2018 13:53:40 +0100
Message-ID: <2658681.ustYaP9yci@blindfold>
In-Reply-To: <4864d279-9a3f-eaf4-c297-ea34be604e41@metux.net>
References: <0f058286-a432-379b-f559-f2fe713807ab@metux.net> <CAFLxGvzxLP_UTQbwEY99bQfyftWzZHwaOP+WrzJ8099EKtbVLg@mail.gmail.com> <4864d279-9a3f-eaf4-c297-ea34be604e41@metux.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enrico,

Am Mittwoch, 14. Februar 2018, 13:38:48 CET schrieb Enrico Weigelt:
> On 14.02.2018 12:30, Richard Weinberger wrote:
> > On Wed, Feb 14, 2018 at 12:27 PM, Enrico Weigelt <lkml@metux.net> wrote:
> >> On 14.02.2018 11:24, Aleksa Sarai wrote:
> >>> What distribution are you using and which release?
> >> 
> >> On a self-compiled system.
> >> 
> >> Forgot to enable namespaces in the kernel. Now it seems to work
> >> as root, but not as an unprivileged user:
> >> 
> >> 
> >> daemon@alphabox:~ unshare -r -U
> >> unshare: can't open '/proc/self/setgroups': Permission denied
> >> daemon@alphabox:~ unshare -f -r -U
> >> unshare: can't open '/proc/self/setgroups': Permission denied
> > 
> > Please read http://man7.org/linux/man-pages/man7/user_namespaces.7.html
> > setgroups is a corner case and needs special care.
> 
> I'm still confused. Does the unshare program do something wrong here ?

It does what you ask it for.
Also see the --setgroups switch.
AFAICT --setgroups=deny is the new default, then your command line should just 
work. Maybe your unshare tool is too old.

> Anyways, I doubt that user namespaces help solving my problem.
> 
> What I'd like to achieve is that processes can manipulate their private
> namespace at will and mount other filesystems (primarily 9p and fuse).
> 
> For that, I need to get rid of setuid (and per-file caps) for these
> private namespaces.

This is exactly why we have the user namespace.
In the user namespace you can create your own mount namespace and do (almost) 
whatever you want.
Please note that you cannot mount any kind of filesystem.
For FUSE, see https://lwn.net/Articles/684774/

Thanks,
//richard

-- 
sigma star gmbh - Eduard-Bodem-Gasse 6 - 6020 Innsbruck - Austria
ATU66964118 - FN 374287y
