Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4078EC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 23:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11DAE218AF
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 23:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbfBFXqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 18:46:25 -0500
Received: from ms.lwn.net ([45.79.88.28]:35370 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726186AbfBFXqZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 18:46:25 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id C6C602D4;
        Wed,  6 Feb 2019 23:46:24 +0000 (UTC)
Date:   Wed, 6 Feb 2019 16:46:23 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Otto Sabart <ottosabart@seberm.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 1/1] doc: kernel-parameters.txt: fix documentation of
 elevator parameter
Message-ID: <20190206164623.2c34715d@lwn.net>
In-Reply-To: <6775e969738a795c578dbc3072f3bebcd6cf7247.1549223107.git.ottosabart@seberm.com>
References: <6775e969738a795c578dbc3072f3bebcd6cf7247.1549223107.git.ottosabart@seberm.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Feb 2019 21:00:19 +0100
Otto Sabart <ottosabart@seberm.com> wrote:

> Legacy IO schedulers (cfq, deadline and noop) were removed in
> f382fb0bcef4.
> 
> The documentation for deadline was retained because it carries over to
> mq-deadline as well, but location of the doc file was changed over time.
> 
> The old iosched algorithms were removed from elevator= kernel parameter
> and mq-deadline, kyber and bfq were added with a reference to their
> documentation.
> 
> Fixes: f382fb0bcef4 ("block: remove legacy IO schedulers")
> Signed-off-by: Otto Sabart <ottosabart@seberm.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index b799bcf67d7b..2238fb3c7dcf 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1182,9 +1182,10 @@
>  			arch/x86/kernel/cpu/cpufreq/elanfreq.c.
>  
>  	elevator=	[IOSCHED]
> -			Format: {"cfq" | "deadline" | "noop"}
> -			See Documentation/block/cfq-iosched.txt and
> -			Documentation/block/deadline-iosched.txt for details.
> +			Format: { "mq-deadline" | "kyber" | "bfq" }
> +			See Documentation/block/deadline-iosched.txt,
> +			Documentation/block/kyber-iosched.txt and
> +			Documentation/block/bfq-iosched.txt for details.

Applied, thanks.

jon
