Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E65C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 13:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFAB6208B0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 13:09:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IuNoVs7O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFAB6208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753421AbeGCNJU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 09:09:20 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:41926 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752606AbeGCNJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 09:09:19 -0400
Received: by mail-lf0-f68.google.com with SMTP id y127-v6so1559501lfc.8
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 06:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ok+/bU0FmO5iKD6m1QJTeSMkgauJuBuxVOOOzT6iB7E=;
        b=IuNoVs7OwatyV27qm4m5APfcAAR4NMj6xo7JrBty3s5ITqXY3FlDJwnIw6vDcPdtVa
         T6p3vWz0m6qLNrWT0yPCmUKgXjHZTnW7Rxb41wJag86W+0YfopgRRKdXPTKhWiUrXALa
         0fzo/UYj45YzlCSw7f0GFvAG5MKro4yTvlWcq4Q9yautlP+b177VGemuPBuSmFZllHGs
         BBJ1Udo/yPBAQ73ljwrZgPoHQUwR3oXMtJl4x8PAJqx9rFGy/3tLrT1H8nbEZQyQWTap
         wfDLoF5k6Vf8Hntcy+yv+2fTu+Ul8ms0gsUVOCqCtpEqMwIpIh61Flqgj3i7ETAXsMNY
         dvAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ok+/bU0FmO5iKD6m1QJTeSMkgauJuBuxVOOOzT6iB7E=;
        b=Rjq6txzJ8TViNIUllGk8m2doiIvYXzY7v/3cyUYR4K63a3M0KWhkGY3s6iJGmuZdKp
         cAvBasX0tlTNdNDhQVKG9DjI6sy5TD4ou/AII/0XWYBbwb+on9b09b1doe7vq7t9g5Fe
         GnkrPRqQwj3YJHvNklNNtwUVdt+fW6yKjAQ/FpT0hVSgpy2c8xEYUH4r1xiy5h5NwlBI
         vJ+tH9bLOns5NAwnOy55NpYWnmTynC1Cq3JK0F+Tpjoxh0sNKHNESp4ZX0ols4hV9SPB
         3NhVgVXbB1Yy6QOIQRKBOgK3OQJs7LLI2zR3vUPmDM6qUO8mCkgsy2t3ZU/RnqY0COjk
         ev2g==
X-Gm-Message-State: APt69E0RVca4LgGVnuq8DJGZxn9YfpfFSoWXKYGDmX1Dogq5JeA7t594
        zo06epu5XJ4UNMHIymv9Pls=
X-Google-Smtp-Source: AAOMgpdfMWiQKOaX3jZpe+FD3qD7v0mzVuR6jYCt5bMbR49CrLLtMXGev7tbSAJ6jc9bl7MuOgb3eA==
X-Received: by 2002:a19:1d8c:: with SMTP id d134-v6mr20833117lfd.56.1530623357869;
        Tue, 03 Jul 2018 06:09:17 -0700 (PDT)
Received: from xi.terra (c-8bb2e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.178.139])
        by smtp.gmail.com with ESMTPSA id o19-v6sm249955lfk.65.2018.07.03.06.09.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 06:09:16 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1faL3N-00005r-2M; Tue, 03 Jul 2018 15:09:09 +0200
Date:   Tue, 3 Jul 2018 15:09:09 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] misc: sram: enable clock before registering regions
Message-ID: <20180703130909.GQ9802@localhost>
References: <20180703100548.30214-1-johan@kernel.org>
 <20180703100548.30214-2-johan@kernel.org>
 <e736a83f-bdd9-d136-070d-7093f5e8be2c@mentor.com>
 <20180703114703.GO9802@localhost>
 <82483d77-500c-e2dd-00ed-79cc842f5371@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82483d77-500c-e2dd-00ed-79cc842f5371@mentor.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 03:30:09PM +0300, Vladimir Zapolskiy wrote:
> On 07/03/2018 02:47 PM, Johan Hovold wrote:
> > On Tue, Jul 03, 2018 at 01:23:30PM +0300, Vladimir Zapolskiy wrote:
> >> Hi Johan,
> >>
> >> On 07/03/2018 01:05 PM, Johan Hovold wrote:
> >>> Make sure to enable the clock before registering regions and exporting
> >>> partitions to user space at which point we must be prepared for I/O.
> >>>
> >>> Fixes: ee895ccdf776 ("misc: sram: fix enabled clock leak on error path")
> >>> Cc: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
> >>> Signed-off-by: Johan Hovold <johan@kernel.org>
> >>
> >> thank you for the change, however please note that the identified commit
> >> for the fix is incorrect one apparently.
> >>
> >> In my opinion the proper tag contents would be
> >>
> >> Fixes: b4c3fcb3c71f ("misc: sram: extend usage of reserved partitions")
> >>
> >> I hope you agree to it, also I would suggest to swap the changes in
> >> the series.
> > 
> > No, I think I used the right commit in the Fixes tag as that was the
> > commit which moved the clock enable to after the memory-region
> > registration (at which point the memory could potentially be accessed).
> 
> I was confused by the moved sram_reserve_regions() call, which was added
> way later.
> 
> Allright, if it is assumed that gen_pool_get() interface requires only
> a registered memory pool provider device, and it does, then there is
> another kind of a problem, a SRAM/genpool consumer may not get access
> to a valid region in SRAM before the latter is added to the SRAM pool
> in sram_probe().

Right, this whole genpool interface is fragile, but that's a different
story.

> Instantly I don't know how to solve the issue above, it may require
> a change to lib/genalloc.c to request a registration of genpool device
> driver, but then such a change solves the problem identified by you
> as well.

The resource (genpool) should not be registered before it's been fully
initialised, while any prior attempts to look it up could cause the
consumer driver to defer their probes, for example. But again, that's
beyond the scope here.

> For your change as a proper (partial?) fix:
> 
> Reviewed-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>

Thanks for the review!

Johan
