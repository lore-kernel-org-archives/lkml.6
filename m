Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1597CC5CFEB
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 02:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C17682089D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 02:06:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C17682089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754571AbeGJCGY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 22:06:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:43086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754450AbeGJCGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 22:06:16 -0400
Received: from vmware.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEB8D20873;
        Tue, 10 Jul 2018 02:06:14 +0000 (UTC)
Date:   Mon, 9 Jul 2018 22:06:13 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Tobin C. Harding" <me@tobin.cc>
Cc:     Theodore Ts'o <tytso@mit.edu>, Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] random: Remove unnecessary cast
Message-ID: <20180709220613.769cbe80@vmware.local.home>
In-Reply-To: <20180710002519.5044-2-me@tobin.cc>
References: <20180710002519.5044-1-me@tobin.cc>
        <20180710002519.5044-2-me@tobin.cc>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Jul 2018 10:25:17 +1000
"Tobin C. Harding" <me@tobin.cc> wrote:

> Currently we are casting an argument to the macro min_t().  This is
> unnecessary since the macro already includes a cast.
> 
> Remove unnecessary cast from argument to macro min_t()
> 
> Signed-off-by: Tobin C. Harding <me@tobin.cc>

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> ---
>  drivers/char/random.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index d686aa2a129b..03bd13876901 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -1736,7 +1736,7 @@ int __must_check get_random_bytes_arch(void *buf, int nbytes)
>  	trace_get_random_bytes_arch(left, _RET_IP_);
>  	while (left) {
>  		unsigned long v;
> -		int chunk = min_t(int, left, (int)sizeof(unsigned long));
> +		int chunk = min_t(int, left, sizeof(unsigned long));
>  
>  		if (!arch_get_random_long(&v))
>  			break;

