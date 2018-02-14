Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030511AbeBNOSN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 09:18:13 -0500
Received: from lilium.sigma-star.at ([109.75.188.150]:51704 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030288AbeBNOSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 09:18:12 -0500
From: Richard Weinberger <richard@sigma-star.at>
To: Enrico Weigelt <lkml@metux.net>
Cc: Aleksa Sarai <asarai@suse.de>,
        Linux Containers <containers@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: plan9 semantics on Linux - mount namespaces
Date: Wed, 14 Feb 2018 15:19:24 +0100
Message-ID: <2050418.Dl5pXkWGsk@blindfold>
In-Reply-To: <a2a6f189-008e-38f2-afcb-b9393d8d440a@metux.net>
References: <0f058286-a432-379b-f559-f2fe713807ab@metux.net> <2658681.ustYaP9yci@blindfold> <a2a6f189-008e-38f2-afcb-b9393d8d440a@metux.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 14. Februar 2018, 15:03:55 CET schrieb Enrico Weigelt:
> On 14.02.2018 13:53, Richard Weinberger wrote:
> > It does what you ask it for. > Also see the --setgroups switch.> AFAICT
> > --setgroups=deny is the new
> default, then your command line should just> work. Maybe your unshare
> tool is too old.
> Also doesn't help:
> 
> daemon@alphabox:~ unshare -U -r --setgroups=deny
> unshare: can't open '/proc/self/setgroups': Permission denied

Works here(tm).
Can you debug it? Maybe we miss something obvious.
 
> >> What I'd like to achieve is that processes can manipulate their private
> >> >> namespace at will and mount other filesystems (primarily 9p and
> fuse).>>>> For that, I need to get rid of setuid (and per-file caps) for
> these>> private namespaces.>
> 
> > This is exactly why we have the user namespace.
> > In the user namespace you can create your own mount namespace and do
> > (almost) whatever you want.
> 
> What's the exact relation between user and mnt namespace ?
> Why do I need an own user ns for private mnt ns ? (except for the suid
> bit, which I wanna get rid of anyways).

mount related system calls are root-only. Therefore you need the user 
namespace to become a root in your own little world. :)

Thanks,
//richard

-- 
sigma star gmbh - Eduard-Bodem-Gasse 6 - 6020 Innsbruck - Austria
ATU66964118 - FN 374287y
