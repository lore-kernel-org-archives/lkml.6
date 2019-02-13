Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B2BC282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DD76222BB
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffw98skW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731125AbfBMCRz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:17:55 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37782 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729117AbfBMCRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:17:54 -0500
Received: by mail-pf1-f193.google.com with SMTP id s22so403475pfh.4;
        Tue, 12 Feb 2019 18:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vnz5kzABQYt2zuTvXNxw6aywAdp4yjjXOdzhLQ2Y/60=;
        b=ffw98skWAAwrBvrqacLBFPEYjOaLHW0HqfKUxurjkTKF9efgjf1uwHbTuVL3IFGxn3
         W9dzJUJ9+5jQOlrNlx4MCA65A7qHsXu2b8J3BBv6XfYu0NBIUBMG3OQbAHcz2Q27PO7Y
         q6TGdiWpL3mRAoFTQOJ+SundWwrwbh12r91ZYLisEQkKNUg46HIOBCZ1pUhLZObORaWR
         WLuKSOLsHkgFbklzMvdsO05pMRDqv+viO3YNZSkQrq0+OYR/FZQAp86czn3byO/D8L8u
         ZG/1NwuKxDdEDYW366KENnR/57jzyU0VpWMWZ7HqA2d+gvev6jitJNLvFuZIEmpQGO8T
         Ca7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vnz5kzABQYt2zuTvXNxw6aywAdp4yjjXOdzhLQ2Y/60=;
        b=co9q9YjVDCsKf/E+kHay0DnD//LGOiFmXqeRUI5eNZ8gfy6XJy5qotobYOjaDaRK+K
         DAu78V4stmA3qhL9WATpeZNWvaSOS3CIDDyQhStVIQBFp+fBIVu6ZZPFXqa5x21ReAF0
         2L1iM9Pz9SAS0r1JS4dta2yLB2fHphuB2tl5HYiw4B1PT5KmZ0M8W7pyuwyOCMAffKRE
         oqtVbi5TKblZoacLqKT8pRpiWbRrF8DMlc8aAY2C4p3Ouc6PAu5Ac8D9qggVewFFK67v
         U1poa17B9JJILhfo2MtZk2cXSieSNGnC9ALdnI2dbLWgg//a7fAg496sdgjlPhDFh+pb
         eI0Q==
X-Gm-Message-State: AHQUAuY5m3F6AKy7xZIacEWNeK6xZpDSVb+mj5WrRXZNJ83DgunhsFKC
        Ld3WNxFe/dKpiCCgcoJ+jIM=
X-Google-Smtp-Source: AHgI3Ianr/k1MEUCfMlVY+1tBZn21L5jD6ZUM7GHT5N6gLOgmvUXcry7/7WE4Tl6pVq4glLIuwuS6g==
X-Received: by 2002:a63:ea56:: with SMTP id l22mr6615008pgk.391.1550024273694;
        Tue, 12 Feb 2019 18:17:53 -0800 (PST)
Received: from bobby.localdomain ([2601:1c0:5501:37e2::72a1])
        by smtp.gmail.com with ESMTPSA id h8sm17027993pgv.27.2019.02.12.18.17.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 18:17:52 -0800 (PST)
Date:   Tue, 12 Feb 2019 18:17:53 -0800
From:   Robert Eshleman <bobbyeshleman@gmail.com>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: light: Add driver for ap3216c
Message-ID: <20190213021753.GA19621@bobby.localdomain>
References: <89716a4433cd83aea5f4200359b184b0ee2cc8bd.1549828313.git.bobbyeshleman@gmail.com>
 <CAGngYiXPsj-TAZxC43UtAZYTkbztFtDB-z4jW29CthmaoeNy_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGngYiXPsj-TAZxC43UtAZYTkbztFtDB-z4jW29CthmaoeNy_w@mail.gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 02:29:58PM -0500, Sven Van Asbroeck wrote:
> On Sun, Feb 10, 2019 at 3:39 PM Robert Eshleman <bobbyeshleman@gmail.com> wrote:
> >
> > This patch adds support for the ap3216c ambient light and proximity
> > sensor.
> 
> PS
> 
> Why not use the chip in the mode where the interrupt is automatically cleared by
> reading the data? This could work if you read the data in the
> interrupt routine, store
> it in a buffer, then send the event to iio. Then when userspace wants
> to read out the
> value, don't actually touch the hardware, but return the buffered value.
> 
> I don't think you then need any synchronization primitives to
> accomplish this, such as
> mutexes, spin locks, etc. Because the interrupt routine is single-threaded.
> 
> You don't even need a memory barrier for the buffered value,
> because the iio core uses a waitqueue internally, which automatically issues
> an mb(). As far as I know.

Hey Sven,

First, thank you for the feedback.

I had initially went with a similar design, but there is
the case in which the interrupt fires and then before the status
register is read by the handler a user process reads the data and
clears the interrupt.  When the handler continues execution it will
read a zero status and return IRQ_NONE.  My understanding of how
Linux handles IRQ_NONE is pretty poor, but I felt that this behavior
is incorrect even if inconsequential.  This could be avoided by
doing a status register read with every data read, and buffering
that as well, but then we lose the benefit altogether by increasing
I2C reads.

In the approach you describe here, it seems like that would
work if this driver wasn't supporting shared interrupts.  In the
case that a user-space read happens to clear the interrupt before
the handler reads the status register, I think we would end up
falsely returning IRQ_NONE.

Is my understanding of this correct?  It's very possible I'm
misunderstanding IRQ_NONE and shared interrupts.

Again, thank you for the feedback.

-Bobby

