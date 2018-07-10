Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 868B2C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 02:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C3DB208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 02:14:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C3DB208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932949AbeGJCOJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 22:14:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:57128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932620AbeGJCOF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 22:14:05 -0400
Received: from vmware.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 711112089E;
        Tue, 10 Jul 2018 02:14:04 +0000 (UTC)
Date:   Mon, 9 Jul 2018 22:14:02 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Tobin C. Harding" <me@tobin.cc>
Cc:     Theodore Ts'o <tytso@mit.edu>, Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] docs: Fix docs for boot parameter
 debug_boot_weak_hash
Message-ID: <20180709221402.7e18c422@vmware.local.home>
In-Reply-To: <20180710002519.5044-4-me@tobin.cc>
References: <20180710002519.5044-1-me@tobin.cc>
        <20180710002519.5044-4-me@tobin.cc>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Jul 2018 10:25:19 +1000
"Tobin C. Harding" <me@tobin.cc> wrote:

> Recently boot parameter 'debug_boot_weak_hash' was added.  Latter
> discussion on LKML developed more descriptive documentation but due to
> the programmers lack of understanding (*cough* me) on how linux-next
> works these improvements never got picked up.
> 
> Update documentation for boot parameter 'debug_boot_weak_hash' as
> discussed (patch posted and acked) on LKML.
> 
> Fixes: bfe80ed3d7c76 ("vsprintf: add command line option debug_boot_weak_hash")
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Tobin C. Harding <me@tobin.cc>

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> ---
>  Documentation/admin-guide/kernel-parameters.txt | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 31c9b76058a7..e3b1c84d19c6 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -749,13 +749,12 @@
>  	debug		[KNL] Enable kernel debugging (events log level).
>  
>  	debug_boot_weak_hash
> -			[KNL] Enable printing pointers early in the boot
> -			sequence.  If enabled, we use a weak hash instead of
> -			siphash to hash pointers.  Use this option if you need
> -			to see pointer values during early boot (i.e you are
> -			seeing instances of '(___ptrval___)').
> -			Cryptographically insecure, please do not use on
> -			production kernels.
> +			[KNL] Enable printing [hashed] pointers early in the
> +			boot sequence.  If enabled, we use a weak hash instead
> +			of siphash to hash pointers.  Use this option if you are
> +			seeing instances of '(___ptrval___)') and need to see a
> +			value (hashed pointer) instead. Cryptographically
> +			insecure, please do not use on production kernels.
>  
>  	debug_locks_verbose=
>  			[KNL] verbose self-tests

