Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED10C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 02:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7041C2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 02:12:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7041C2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932887AbeGJCMW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 22:12:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:45932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932620AbeGJCMR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 22:12:17 -0400
Received: from vmware.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3787620862;
        Tue, 10 Jul 2018 02:12:16 +0000 (UTC)
Date:   Mon, 9 Jul 2018 22:12:14 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Tobin C. Harding" <me@tobin.cc>
Cc:     Theodore Ts'o <tytso@mit.edu>, Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] vsprintf: Remove incorrect EXPORT_SYMBOL
Message-ID: <20180709221214.167e0ed0@vmware.local.home>
In-Reply-To: <20180710002519.5044-3-me@tobin.cc>
References: <20180710002519.5044-1-me@tobin.cc>
        <20180710002519.5044-3-me@tobin.cc>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Jul 2018 10:25:18 +1000
"Tobin C. Harding" <me@tobin.cc> wrote:

> Recently boot variable 'debug_boot_weak_hash' was added (by me).  In a
> classic case of cargo cult programming the novice developer added a
> macro call to EXPORT_SYMBOL().  This is wrong and was pointed out on
> LKML.  As pointed out EXPORT_SYMBOL() cannot be used on static
> variables.
> 
> Remove incorrect usage of macro EXPORT_SYMBOL()
> 
> Fixes: bfe80ed3d7c76 ("vsprintf: add command line option debug_boot_weak_hash")
> Signed-off-by: Tobin C. Harding <me@tobin.cc>

Revieved-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Hmm, not sure if Ted rebases his trees or not, but if he does, he could
also fold this into that commit.

-- Steve

> ---
>  lib/vsprintf.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index cdc2c355dff5..fe834a201f3d 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -1655,7 +1655,6 @@ static DEFINE_STATIC_KEY_TRUE(not_filled_random_ptr_key);
>  
>  /* Make pointers available for printing early in the boot sequence. */
>  static int debug_boot_weak_hash __ro_after_init;
> -EXPORT_SYMBOL(debug_boot_weak_hash);
>  
>  static int __init debug_boot_weak_hash_enable(char *str)
>  {

