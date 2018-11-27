Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1269C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 02:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FC972086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 02:13:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ntfgGhmJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FC972086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbeK0NJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 08:09:47 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40163 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727552AbeK0NJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 08:09:47 -0500
Received: by mail-pf1-f195.google.com with SMTP id i12so7548601pfo.7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 18:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=C2Pt8xP9+WD8GP/Q4gOyb9TqFHid8wy+SDEEJjPCdmc=;
        b=ntfgGhmJKQUqN/eOB3XK7rnFNWIbajNvWa7/tTeuwnZ6Y9fGAYLoanXg5P1zaur7Ch
         +zOM3RlbRRWG4vhjfiuRI7kyUAGd+uxVkM9zxRRiiUdaORvEarGQG8hkxRYdtYoAqllt
         BAHxM6ITDcoEFc1NNy1DLDuyaTKWdhpIXMU4kPGvdeTlBM1bUhenGQSe2XOqXLxcdbWf
         ECngFcozsxttRYSAEtJjg5rtUqmaq6MbDXesvdIpOJaFRdgRSmAM0lYjq75/TlsLZyN3
         DCw7/liULzPiww8MYQoxmNM08j+XzUrGHdY1Ns7IIKJfaDTstpnUqXd/Zcd4NvtsHDYG
         c3Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=C2Pt8xP9+WD8GP/Q4gOyb9TqFHid8wy+SDEEJjPCdmc=;
        b=YvxpvPpg6NBv41aeqW0izB6/Mb4+ykfe+OU4eszuzOxh/at9CsCsCOpON6dFEz2zE9
         vLZBhWQj7oIzWX+3aiiJCungIyXxIhkljwfCv46pP78TmlPNw1XPdFK9vFLlrkWri8zr
         U0UrUwvDKx7mxeWNlRzVDtUv8ZclfKkIo/lRM5Muqua+u3DkX6iI1AUQYTrGJBLqzIlm
         FI14sKraI4e+iRK6jYOANwRsc18drxm5ZHso9bUfT4tr4CWqw/r/4JO0Yrex0yP0J2eG
         +JBShZL96ignb3DqlGfHMUG8BFu4E0QWaRJjyz6Qv3NLpdzYiaolF9FliQohrnLTStCT
         ydhw==
X-Gm-Message-State: AA+aEWZmIDEN7o1yZdlWPhswnlvd5MqUCdxMhMMZ4dKhbzStWYHC6OVD
        rBOu6I7TiBr6blbYj5V4TSOanyfJ4Tk=
X-Google-Smtp-Source: AFSGD/V6rg+hStr4skPlPI4irZpVpA1XKCQg42PGYVVU8cPoBoiO1rdoNS+NJoqvBh/INi2D3DfY7Q==
X-Received: by 2002:a63:2141:: with SMTP id s1mr27597802pgm.148.1543284812357;
        Mon, 26 Nov 2018 18:13:32 -0800 (PST)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id z62sm2980204pfi.4.2018.11.26.18.13.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 18:13:31 -0800 (PST)
Date:   Tue, 27 Nov 2018 11:13:27 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Joey Pabalinas <joeypabalinas@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH v2 5/7] zram: support idle/huge page writeback
Message-ID: <20181127021327.GD237537@google.com>
References: <20181126082813.81977-1-minchan@kernel.org>
 <20181126082813.81977-6-minchan@kernel.org>
 <20181126094737.sfudpeoigra2vir7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126094737.sfudpeoigra2vir7@gmail.com>
User-Agent: Mutt/1.10.1+60 (6df12dc1) (2018-08-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 25, 2018 at 11:47:37PM -1000, Joey Pabalinas wrote:
> On Mon, Nov 26, 2018 at 05:28:11PM +0900, Minchan Kim wrote:
> > +	strlcpy(mode_buf, buf, sizeof(mode_buf));
> > +	/* ignore trailing newline */
> > +	sz = strlen(mode_buf);
> 
> One possible idea would be to use strscpy() instead and directly assign
> the return value to sz, avoiding an extra strlen() call (though you would
> have to check if `sz == -E2BIG` and do `sz = sizeof(mode_buf) - 1` in that
> case).

Thanks for the suggstion.
If I limit destination buffer smaller, I couldn't meet -E2BIG?

> 
> > +	if (!strcmp(mode_buf, "idle"))
> > +		mode = IDLE_WRITEBACK;
> > +	if (!strcmp(mode_buf, "huge"))
> > +		mode = HUGE_WRITEBACK;
> 
> Maybe using `else if (!strcmp(mode_buf, "huge"))` would be slightly
> better here, avoiding a second strcmp() if mode_buf has already
> matched "idle".

I considered "huge|idle" as an option. Anyway, in that case, mode should
"mode |= ". At this moment, yes, lets use "else if" since I don't have
strong opinion to support "idle|huge".

> 
> > +		if ((mode & IDLE_WRITEBACK &&
> > +			  !zram_test_flag(zram, index, ZRAM_IDLE)) &&
> > +		    (mode & HUGE_WRITEBACK &&
> > +			  !zram_test_flag(zram, index, ZRAM_HUGE)))
> > +			goto next;
> 
> Wouldn't writing this as `mode & (IDLE_WRITEBACK | HUGE_WRITEBACK)`
> be a bit easier to read as well as slightly more compact?
> 
> > +	ret = len;
> > +	 __free_page(page);
> > +release_init_lock:
> > +	up_read(&zram->init_lock);
> > +	return ret;
> 
> Hm, I noticed that this function either returns an error or just the passed
> in len on success, and I'm left wondering if there might be other useful
> information which could be passed back to the caller instead. I can't
> immediately think of any such information, though, so it's possible I'm
> just daydreaming :)

It is write syscall semantic of sysfs so not sure it's doable to pass
other value to user.

> 
> -- 
> Cheers,
> Joey Pabalinas


