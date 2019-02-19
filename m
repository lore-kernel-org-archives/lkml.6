Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E3D2C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 03:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 599C221773
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 03:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sSID8mpY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbfBSDaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 22:30:09 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40398 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbfBSDaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 22:30:09 -0500
Received: by mail-pf1-f194.google.com with SMTP id h1so9519240pfo.7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 19:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OXK6fp4pusxSkcr3snEhbgyXQ6Ejx4HHzW7W0he3jqs=;
        b=sSID8mpYPyllKQFqI5RB+8DiBfRjGWRdLPeKmWzVibbPRi6Hd8t1nigc/G2WkOBoYM
         MvbnYgfXpSRUDFxPhyr2a4mKsCBP9gusjFqqGW9fIU+KrEm/KOYhRta5kuoySp+UnW60
         GggK4YD+p7w7MOeNF7Wffu9O2oUiHlnArKQswgHqUSyouDxbtpaGAMb1e27mHgZl6LoI
         NBk3cTJjk5gwOw/c8Yxhcl80yJD9IvAySa3qcC7DvZ3AguVnZppQJJR1u4MhCR1duPdA
         uo16zr8PkF+RC4HAVXZLkGKYzPHU1v69/dAi/NE15r+XT6MAgfJSDiZ+TNunbJ8nVz2n
         CHJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OXK6fp4pusxSkcr3snEhbgyXQ6Ejx4HHzW7W0he3jqs=;
        b=DCHa1WgRkUCS9DdfznpqOYeCenMU1HaVxKLFrEPksD2+YGKwWxZSFzurXVrgHoiA4E
         CSdgZnp4AILF+Uj60l2JUgPJIqFVbq9Mt6uHW7VDD89SCe1GAR0Tj8mtMiqEdvzoqxIL
         NXBitFzomMJ2GpWH7pehMYwEyFofsYUsHgeOY0FDb3vwt2KTgGmjuTb8AgolWQZytWSC
         doId/BYM4OMV6+jrLywj9qoXU4wZhb6O+P67oOZxLmj4ROTjy2s3mdEEzyTDTFRIC/Rc
         ax3YbPeIm/0VokJkhec9M5eA3ErZR/URk2v3whmOIl2FN3n84bPG9ZFH0A53Qj1MI1S8
         SyFw==
X-Gm-Message-State: AHQUAubgViER/Mawljqi7Zw2g5hME/uyYjsa63l8rCDkvdH2MG5soZ3u
        iY2M73tzy0qH9a0MhrIr1T4=
X-Google-Smtp-Source: AHgI3IYOz8O60tSlTTwfjTYKwYxUPnB9Io+WeiEidlWccmrDELoxDCsp2HcMipfryi5nTLIR9Wq4WA==
X-Received: by 2002:a62:6282:: with SMTP id w124mr27545777pfb.168.1550547008379;
        Mon, 18 Feb 2019 19:30:08 -0800 (PST)
Received: from localhost ([175.223.35.193])
        by smtp.gmail.com with ESMTPSA id v22sm11713490pfa.49.2019.02.18.19.30.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 19:30:07 -0800 (PST)
Date:   Tue, 19 Feb 2019 12:30:03 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 8/9] vsprintf: Prevent crash when dereferencing
 invalid pointers
Message-ID: <20190219033003.GA2284@jagdpanzerIV>
References: <20190208152310.29531-1-pmladek@suse.com>
 <20190208152310.29531-9-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190208152310.29531-9-pmladek@suse.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (02/08/19 16:23), Petr Mladek wrote:
[..]
> + /*
> +  * This is not a fool-proof test. 99% of the time that this will fault is
> +  * due to a bad pointer, not one that crosses into bad memory. Just test
> +  * the address to make sure it doesn't fault due to a poorly added printk
> +  * during debugging.
> +  */
> +static const char *check_pointer_msg(const void *ptr)
> +{
> +	char byte;
> +
> +	if (!ptr)
> +		return "(null)";
> +
> +	if (probe_kernel_address(ptr, byte))
> +		return "(efault)";
> +
> +	return NULL;
> +}

Hmm... So the assumption here is that the target buffer always has
at least strlen("(efault)") bytes and, thus, we always can write the
error message to it.

> +static int check_pointer(char **buf, char *end, const void *ptr,
> +			     struct printf_spec spec)
> +{
> +	const char *err_msg;
> +
> +	err_msg = check_pointer_msg(ptr);
> +	if (err_msg) {
> +		*buf = string_nocheck(*buf, end, err_msg, spec);
> +		return -EFAULT;
> +	}
> +
> +	return 0;
> +}

Suppose in my driver I sprintf() pointers to 4-bytes strings and, thus,
have only 5 spare bytes in target buffer. But one of the pointers is
faulty and now sprintf() writes "(efault)" to target buffer which can
hold only 5 bytes.

	-ss
