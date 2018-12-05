Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 500B2C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1557620892
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:46:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1557620892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwn.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbeLETqw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 14:46:52 -0500
Received: from ms.lwn.net ([45.79.88.28]:47864 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727257AbeLETqv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 14:46:51 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 75478316;
        Wed,  5 Dec 2018 19:46:49 +0000 (UTC)
Date:   Wed, 5 Dec 2018 12:46:44 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     NeilBrown <neilb@suse.com>
Cc:     linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] Documentation: convert path-lookup from markdown to
 resturctured text
Message-ID: <20181205124644.3f8a452a@lwn.net>
In-Reply-To: <87sgzc7v50.fsf@notabene.neil.brown.name>
References: <87k1l9dgx9.fsf@notabene.neil.brown.name>
        <87sgzc7v50.fsf@notabene.neil.brown.name>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Dec 2018 10:02:51 +1100
NeilBrown <neilb@suse.com> wrote:

> This allows the document to be integrated with the main documentation
> tree.
> Changes include:
> - rename from .md to .rst
> - use `` for code, not single `
> - use correct sub-section marking
> - fix indented blocks, both code and non-code
> - fix external-link markup
> 
> Signed-off-by: NeilBrown <neilb@suse.com>

Looks good at a first glance, but I have one question...

>  Documentation/filesystems/index.rst                |   2 +
>  .../{path-lookup.md => path-lookup.rst}            | 875 +++++++++++----------
>  2 files changed, 448 insertions(+), 429 deletions(-)
>  rename Documentation/filesystems/{path-lookup.md => path-lookup.rst} (59%)
> 
> diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
> index 46d1b1be3a51..3c0f441a9536 100644
> --- a/Documentation/filesystems/index.rst
> +++ b/Documentation/filesystems/index.rst
> @@ -359,3 +359,5 @@ encryption of files and directories.
>      :maxdepth: 2
>  
>      fscrypt
> +
> +.. include::  path-lookup.rst

Is there a reason you used "include" rather than just adding it to the
TOC tree with the rest?

Thanks,

jon
