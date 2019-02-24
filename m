Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D034EC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 10:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A28020661
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 10:17:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="ailYQkdB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbfBXKRD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 05:17:03 -0500
Received: from mx.kolabnow.com ([95.128.36.42]:44684 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbfBXKRC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 05:17:02 -0500
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTP id B5584411BC;
        Sun, 24 Feb 2019 11:16:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:message-id:date:date:subject:subject
        :from:from:received:received:received; s=dkim20160331; t=
        1551003418; x=1552817819; bh=xdV37zz4/GvWEA2lccx1zgAyXjF337MhHYd
        cnsFq/kQ=; b=ailYQkdBJ3szCQ6N8rt26jkWluDELDO8WY1cHv/AbIzHlYs04ap
        GwxLifxH5in6sJTgztuQ+HHMs9WLT6aD/sgmHgTXgkRzupqxVwNbA1ZDqYBQ26fN
        RffGI/1ShDLRz2t/+zONPKDKVBbXwTgQS719Z3AQDn1yMHnAYShLju/iidmO467m
        6AYskTXA3W+TI5Hznu+HbSls3O/DiYeLofzgJSHMFaGhbpyZKl/9YLufDwSQLPsF
        c6Bdg6/6ze8tpyhJf4lL76DgewS/gH5FtC+bXVfZ9k2k1APTi4qT4g6aIca+x5Ry
        Hat8dUM6XKaH7dr4ih/tk4HjIJVfszDxQQREoXdniTO+YRDmupCJH2eGonkYC7rK
        yugw6q6COoP39VxkNAK0ge/ObY/b7ULpRv7BLARk52uxImUjUcTJkxW63jeACE/1
        OD2IgE5xEyOtC6HsNZiV8UirOZf6Nac7STEn7wH0oKQdbB/WBM/zmv+HDzJ06z2G
        R3IaSh8PeY6I3MQwAXUr2AGRNbm6EAUAsYnjQQVocbEmbwQv3lW7OWpOPIQIt/QX
        xUwLX+ykFSYaS8LfwLu6X0CKkhldfhoypuzPlLyz8RaV8mFJRuyot242lsPq+YTv
        8DOCKXWQMpZbKt1z12QRlXoFLINhT2/hVMFoogcoPFAMyXKBzw7jIpMY=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out003.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id tPSNoP8s587B; Sun, 24 Feb 2019 11:16:58 +0100 (CET)
Received: from int-mx003.mykolab.com (unknown [10.9.13.3])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTPS id 815F8404B2;
        Sun, 24 Feb 2019 11:16:58 +0100 (CET)
Received: from ext-subm002.mykolab.com (unknown [10.9.6.2])
        by int-mx003.mykolab.com (Postfix) with ESMTPS id EF0D0B88;
        Sun, 24 Feb 2019 11:16:57 +0100 (CET)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Zenghui Yu <zenghuiyu96@gmail.com>
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, gregkh@linuxfoundation.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] Documentation/process/howto: Update for 4.x -> 5.x versioning
Date:   Sun, 24 Feb 2019 11:16:56 +0100
Message-ID: <4160738.QP7Yp4kBzP@harkonnen>
In-Reply-To: <CAKcZhuWHU+udbAyL910JW8rhZsbpomz5TXs0z2FD4m5c5Sf8hw@mail.gmail.com>
References: <CAKcZhuWHU+udbAyL910JW8rhZsbpomz5TXs0z2FD4m5c5Sf8hw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hello,

I have just a general observation for the community, not related to the 
content of this patch, but related with the idea behind.

Is it really important to specify the major release number in the documents? . 
Can't we just use a generic x.y.z, or a more generic statement?

When you open a documentation page like

https://www.kernel.org/doc/html/latest/

you will see the release number in the top left corner, which implies that 
what you read is (should be) valid for that version. And if you read from the 
sources you should know which version you checked out, and if you don't you
can always verify.

I do not see the added value of having those numbers in the documents, unless 
the purpose is to highlight some specific exceptions.

Am I missing some important reasons that justify these numbers?

Thank you

On Sunday, February 24, 2019 9:43:20 AM CET Zenghui Yu wrote:
> As linux-5.0 is coming up soon, the howto.rst document can be
> updated for the new kernel version. Change all 4.x references
> to 5.x now.
> 
> Signed-off-by: Zenghui Yu <zenghuiyu96@gmail.com>
> ---
>  Documentation/process/howto.rst | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/process/howto.rst
> b/Documentation/process/howto.rst index f16242b..19001e2 100644
> --- a/Documentation/process/howto.rst
> +++ b/Documentation/process/howto.rst
> @@ -235,16 +235,16 @@ Linux kernel development process currently
> consists of a few different
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
> 
> -4.x kernel tree
> +5.x kernel tree
>  ~~~~~~~~~~~~~~~
> 
> -4.x kernels are maintained by Linus Torvalds, and can be found on
> -https://kernel.org in the pub/linux/kernel/v4.x/ directory.  Its
> development +5.x kernels are maintained by Linus Torvalds, and can be found
> on +https://kernel.org in the pub/linux/kernel/v5.x/ directory.  Its
> development process is as follows:
> 
>    - As soon as a new kernel is released a two weeks window is open,
> @@ -277,21 +277,21 @@ mailing list about kernel releases:
>   released according to perceived bug status, not according to a
>   preconceived timeline."*
> 
> -4.x.y -stable kernel tree
> +5.x.y -stable kernel tree
>  ~~~~~~~~~~~~~~~~~~~~~~~~~
> 
>  Kernels with 3-part versions are -stable kernels. They contain
>  relatively small and critical fixes for security problems or significant
> -regressions discovered in a given 4.x kernel.
> +regressions discovered in a given 5.x kernel.
> 
>  This is the recommended branch for users who want the most recent stable
>  kernel and are not interested in helping test development/experimental
>  versions.
> 
> -If no 4.x.y kernel is available, then the highest numbered 4.x
> +If no 5.x.y kernel is available, then the highest numbered 5.x
>  kernel is the current stable kernel.
> 
> -4.x.y are maintained by the "stable" team <stable@vger.kernel.org>, and
> +5.x.y are maintained by the "stable" team <stable@vger.kernel.org>, and
>  are released as needs dictate.  The normal release period is approximately
>  two weeks, but it can be longer if there are no pressing problems.  A
>  security-related problem, instead, can cause a release to happen almost
> @@ -326,10 +326,10 @@ revisions to it, and maintainers can mark
> patches as under review,
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




