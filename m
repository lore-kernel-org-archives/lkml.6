Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C90F9C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 18:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA2C52084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 18:26:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728958AbfBYS0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 13:26:43 -0500
Received: from ms.lwn.net ([45.79.88.28]:42578 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbfBYS0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 13:26:42 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id BDDAB304;
        Mon, 25 Feb 2019 18:26:41 +0000 (UTC)
Date:   Mon, 25 Feb 2019 11:26:40 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Zenghui Yu <zenghuiyu96@gmail.com>
Cc:     gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Documentation/process/howto: Update for 4.x -> 5.x
 versioning
Message-ID: <20190225112640.50d6a2c5@lwn.net>
In-Reply-To: <1551023123-5031-1-git-send-email-zenghuiyu96@gmail.com>
References: <1551023123-5031-1-git-send-email-zenghuiyu96@gmail.com>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Feb 2019 23:45:23 +0800
Zenghui Yu <zenghuiyu96@gmail.com> wrote:

> As linux-5.0 is coming up soon, the howto.rst document can be
> updated for the new kernel version. Change all 4.x references
> to 5.x now.
> 
> Signed-off-by: Zenghui Yu <zenghuiyu96@gmail.com>

Overall: I think there's value in having the docs reflect current
numbers, though it would be better if the docs as a whole were kept
current at the same time.  howto.rst hasn't been updated yet, so this
attention is welcome - thanks for taking a look at it.  That said, I
really think we can do a little better.

>  Documentation/process/howto.rst | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/process/howto.rst b/Documentation/process/howto.rst
> index f16242b..19001e2 100644
> --- a/Documentation/process/howto.rst
> +++ b/Documentation/process/howto.rst
> @@ -235,16 +235,16 @@ Linux kernel development process currently consists of a few different
>  main kernel "branches" and lots of different subsystem-specific kernel
>  branches.  These different branches are:
>  
> -  - main 4.x kernel tree
> -  - 4.x.y -stable kernel tree
> +  - main 5.x kernel tree
> +  - 5.x.y -stable kernel tree
>    - subsystem specific kernel trees and patches
> -  - the 4.x -next kernel tree for integration tests
> +  - the 5.x -next kernel tree for integration tests

One thing I think we can do is to simply get rid of version numbers in a
lot of places and make this process easier when 6.x comes around.  What
this is really trying to say is that we have:

 - Linus's mainline tree
 - Various stable trees with multiple major numbers
 - Subsystem-specific trees
 - linux-next

If we could rework this along those lines, it will more accurately
reflect reality and not require updating next time.

> -4.x kernel tree
> +5.x kernel tree
>  ~~~~~~~~~~~~~~~
>  
> -4.x kernels are maintained by Linus Torvalds, and can be found on
> -https://kernel.org in the pub/linux/kernel/v4.x/ directory.  Its development
> +5.x kernels are maintained by Linus Torvalds, and can be found on
> +https://kernel.org in the pub/linux/kernel/v5.x/ directory.  Its development
>  process is as follows:

And here too I think we can just say "mainline" and that they can be
found at https://kernel.org/ or in the repo.

>    - As soon as a new kernel is released a two weeks window is open,
> @@ -277,21 +277,21 @@ mailing list about kernel releases:
>  	released according to perceived bug status, not according to a
>  	preconceived timeline."*
>  
> -4.x.y -stable kernel tree
> +5.x.y -stable kernel tree
>  ~~~~~~~~~~~~~~~~~~~~~~~~~
>  
>  Kernels with 3-part versions are -stable kernels. They contain
>  relatively small and critical fixes for security problems or significant
> -regressions discovered in a given 4.x kernel.
> +regressions discovered in a given 5.x kernel.

Here too, especially since most of the outstanding stable kernels won't
be 5.x for a long time.

>  This is the recommended branch for users who want the most recent stable
>  kernel and are not interested in helping test development/experimental
>  versions.
>  
> -If no 4.x.y kernel is available, then the highest numbered 4.x
> +If no 5.x.y kernel is available, then the highest numbered 5.x
>  kernel is the current stable kernel.

...and this, I believe, is misleading at best.  I'd just take that
sentence out.

> -4.x.y are maintained by the "stable" team <stable@vger.kernel.org>, and
> +5.x.y are maintained by the "stable" team <stable@vger.kernel.org>, and
>  are released as needs dictate.  The normal release period is approximately
>  two weeks, but it can be longer if there are no pressing problems.  A
>  security-related problem, instead, can cause a release to happen almost
> @@ -326,10 +326,10 @@ revisions to it, and maintainers can mark patches as under review,
>  accepted, or rejected.  Most of these patchwork sites are listed at
>  https://patchwork.kernel.org/.
>  
> -4.x -next kernel tree for integration tests
> +5.x -next kernel tree for integration tests
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  
> -Before updates from subsystem trees are merged into the mainline 4.x
> +Before updates from subsystem trees are merged into the mainline 5.x
>  tree, they need to be integration-tested.  For this purpose, a special
>  testing repository exists into which virtually all subsystem trees are
>  pulled on an almost daily basis:

linux-next is called "linux-next"; we should just use that name.

So what do you think?  Can we maybe get a version that removes most (or
all) of the explicit version numbers from this file?

Thanks,

jon
