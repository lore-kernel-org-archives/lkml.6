Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751537AbeBWQXM (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 11:23:12 -0500
Received: from mail-wr0-f180.google.com ([209.85.128.180]:44158 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751381AbeBWQXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 11:23:10 -0500
X-Google-Smtp-Source: AH8x225X3ivLsp5mnMLZly9hbf6dJ23qBJweq638jJzx6hjhTChE+p8Ba79kJ5CtSMjA7QLRjNAxww==
Date: Fri, 23 Feb 2018 17:22:55 +0100
From: Robin Jarry <robin.jarry@6wind.com>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 2/2] objtool: use host flags to detect if libelf is
 missing
Message-ID: <20180223162255.cakkzdi3jpkh4vmi@6wind.com>
References: <cover.1519393674.git.robin.jarry@6wind.com>
 <2afbfc7911a0eb0642c33e8c2582f137a4fda2f3.1519393674.git.robin.jarry@6wind.com>
 <20180223153720.glun6fa2a3jde7mi@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180223153720.glun6fa2a3jde7mi@treble>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-02-23, Josh Poimboeuf:
> Hi Robin,
> 
> Did you test this?  I see some issues:
> 
> a) I don't see where the host_cflags variable comes from (and btw, it's
>    misspelled...)

Hi Josh,

Shame on me... Last minute fix. I had tested this first by forcing
HOSTCC="gcc <CFLAGS> <LDFLAGS>" but I found it rather dirty. As it turns
out, my patch is not better.

> b) I don't see where objtool uses HOSTLDFLAGS.

Indeed, I also missed this (see above).

It looks like objtool does not use HOSTCFLAGS nor HOSTLDFLAGS (defined
in top Makefile). Do you see a reason why? Maybe it would be a good idea
to share these flags (adding some specific ones for objtool, if needed).

What do you think?

-- 
Robin
