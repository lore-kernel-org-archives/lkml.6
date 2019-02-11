Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBABBC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 07:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 928B42146F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 07:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2G2u39h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfBKHz3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 02:55:29 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41450 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbfBKHz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 02:55:29 -0500
Received: by mail-pf1-f193.google.com with SMTP id b7so4885837pfi.8;
        Sun, 10 Feb 2019 23:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ygAEYs2cUK0TFmtHBpTd5q1OXKnqXfmKH4w1qi/rkyE=;
        b=N2G2u39hE7742HJ34qPv5zld3vE71j66atBmbESmuD7la48FpTSssaywppnOm5KUu4
         Ylr+laAskz9xKmLsh3EPfmVfjTP7kOdiA7r+01vRcxQGNWZPXMXmWqOLtRd4SEa0H0V2
         bOMTxVNwj/Qai5hZNZvVmdhu6Vgdz7xJ1ay3qKzuONaDiSUfkAWufnv3Sw+GGiYB7SHJ
         kSSBUgGO18OTpuHilZp1I5/+aDCHVTb1lX+gy07NjAsZb9OfRgi9s5GNPPYbZTaP5sYI
         OZtRGePYFQF+Ry/87MyrWPjMHWkdRv8AyoLQwFQge/RTYsdfFXQRQ39ThUjDvEm9PjgM
         0y3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ygAEYs2cUK0TFmtHBpTd5q1OXKnqXfmKH4w1qi/rkyE=;
        b=AtdB3r+q7vDsALi/5Lyb+vqID9l2amNEfCxe1F7VWNH0Y2g8dlEYNbBYoP4quW4ekd
         SIirJmNHYuzwtEl+z4jKxkvATuM9wb4dD/Tq535coqG3OmHodSBaDoClQKZuFnblDzVl
         ecCAhT10JFfyDdIPVJYlBlE95YDedqIX6ies523LTWzqKVHd85jEwi2zaCoPViCCQ3/K
         PlEI615ELrLBL4GVorVWO71rxS14extocCY2y3YcCnL86nu6dlTfVXvvGQqqgeRLFGLv
         fshQFWhdH1Ax74jiN6Uj+kIy6d0vQXSPpi4GM2f0UfwvC1O1bjWiYNhXzrUW0YB66vn3
         nU8w==
X-Gm-Message-State: AHQUAuYH8E09fVwRcZEy+QYbcZzlyuu+Qf+6C+vGB5jLhYU6i0kvqy6z
        1sbBEmOv7afd8EsJiBHP5HA=
X-Google-Smtp-Source: AHgI3IYwJrTZAnuaPYyDWZ08ETuWFKbUPQzGipOaxRvNkL74WbdP2DA2ucnKRH6VIK5oE9Ofh/9nyg==
X-Received: by 2002:a63:da18:: with SMTP id c24mr16494423pgh.318.1549871728594;
        Sun, 10 Feb 2019 23:55:28 -0800 (PST)
Received: from localhost ([175.223.48.87])
        by smtp.gmail.com with ESMTPSA id y72sm14624151pfa.98.2019.02.10.23.55.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 Feb 2019 23:55:27 -0800 (PST)
Date:   Mon, 11 Feb 2019 16:55:24 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org,
        akpm@linux-foundation.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        dyoung@redhat.com, sergey.senozhatsky@gmail.com, pmladek@suse.com
Subject: Re: [PATCH v3 1/7] dump_stack: Support adding to the dump stack arch
 description
Message-ID: <20190211075524.GA26690@jagdpanzerIV>
References: <20190207124635.3885-1-mpe@ellerman.id.au>
 <20190208185515.r6vkrezbd3odhpxt@home.goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190208185515.r6vkrezbd3odhpxt@home.goodmis.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (02/08/19 13:55), Steven Rostedt wrote:
[..]
> > +	if (len) {
> > +		/*
> > +		 * Order the stores above in vsnprintf() vs the store of the
> > +		 * space below which joins the two strings. Note this doesn't
> > +		 * make the code truly race free because there is no barrier on
> > +		 * the read side. ie. Another CPU might load the uninitialised
> > +		 * tail of the buffer first and then the space below (rather
> > +		 * than the NULL that was there previously), and so print the
> > +		 * uninitialised tail. But the whole string lives in BSS so in
> > +		 * practice it should just see NULLs.
> > +		 */
> > +		smp_wmb();
> 
> This shows me that this can be called at a time when more than one CPU is
> active. What happens if we have two CPUs calling dump_stack_add_arch_desc() at
> the same time? Can't that corrupt the dump_stack_arch_desc_str?

Can overwrite part of it, I guess (but it seems that Michael
is OK with this). The string is still NULL terminated.

The worst case scenario I can think of is not the one when
two CPUs call dump_stack_add_arch_desc(), but when CPUA calls
dump_stack_add_arch_desc() to append some data and at the
same time CPUB calls dump_stack_set_arch_desc() and simply
overwrites dump_stack_arch_desc_str. Not sure if this is
critical (or possible).

	-ss
