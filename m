Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C3E2C32789
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03646204FD
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:38:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03646204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwn.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729857AbeKUDI2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 22:08:28 -0500
Received: from ms.lwn.net ([45.79.88.28]:55830 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726557AbeKUDI2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 22:08:28 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id DD20D35A;
        Tue, 20 Nov 2018 16:38:26 +0000 (UTC)
Date:   Tue, 20 Nov 2018 09:38:25 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     NeilBrown <neilb@suse.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Documentation: update path-lookup.md for parallel
 lookups
Message-ID: <20181120093825.7e009b1e@lwn.net>
In-Reply-To: <87k1l9dgx9.fsf@notabene.neil.brown.name>
References: <87k1l9dgx9.fsf@notabene.neil.brown.name>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Nov 2018 11:55:46 +1100
NeilBrown <neilb@suse.com> wrote:

> Since this document was written, i_mutex has been replace with
> i_rwsem, and shared locks are utilized to allow lookups in the one
> directory to happen in parallel.
> 
> So replace i_mutex with i_rwsem, and explain how this is used for
> parallel lookups.
> 
> Signed-off-by: NeilBrown <neilb@suse.com>

I've applied this, thanks.  I do have a couple of small comments, though...

#1: what are the chances of getting this document converted to RST and
tied into our documentation tree?

#2: ...

> Just FYI
> 
> $ git grep -w i_mutex | wc -l
> 262
> 
> it was 276 before this patch... so a small improvement.
> 
> NeilBrown
> 
> 
>  Documentation/filesystems/path-lookup.md | 85 ++++++++++++++++++------
>  1 file changed, 66 insertions(+), 19 deletions(-)
> 
> diff --git a/Documentation/filesystems/path-lookup.md b/Documentation/filesystems/path-lookup.md
> index e2edd45c4bc0..06151b178f80 100644
> --- a/Documentation/filesystems/path-lookup.md
> +++ b/Documentation/filesystems/path-lookup.md
> @@ -12,6 +12,10 @@ This write-up is based on three articles published at lwn.net:
>  - <https://lwn.net/Articles/650786/> A walk among the symlinks
>  
>  Written by Neil Brown with help from Al Viro and Jon Corbet.
> +It has subsequently been updated to reflect changes in the kernel
> +including:
> +
> +- per-directory parallel name lookup.

I'm unconvinced about the value of putting changelogs into the docs
themselves; that's what we keep git around for.  (I *do* think there's
some value of having something in a document giving a hint of how current
it is, though).

Thanks,

jon
