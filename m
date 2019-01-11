Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3716EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 10:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE62820872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 10:06:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="TSqlUULP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731637AbfAKKG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 05:06:58 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45270 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731380AbfAKKG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 05:06:57 -0500
Received: by mail-ed1-f66.google.com with SMTP id d39so12574867edb.12
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 02:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vJf48/sX7AnRDpDJIWf3yAdJDrwjCu5NvywBcajjBw8=;
        b=TSqlUULPXi7TXzrD2EdkkE4BzmnHqf5XPq0NuPEi0/W9pso5mGoCiIAUNOl+XJfbH5
         24Rzy/y3xrOl++Cg+z5C05BPJ3Q262S4jRvp95eUvYrld0gYosD85WQJCAf03RiyXmDW
         KAsodYygeZOeKzrDNL0nPwDlUNTz7p5nLPV+ILQ82b+1BQUEVaeEv/uXBKPCyNrVbrFN
         4YyMxAJ5FTHhnd8DX2a0HLi8TyFPKhkX97u1j+jH1drgwrOQteI+uqwqjWj6GyP3sMOp
         YY/mV1+qAbWhReY3ybHQfUJy8NOOYmZ1+mpX40tkD6xryt9UvEm4nF7bsQ3Izc4tbMal
         6A1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vJf48/sX7AnRDpDJIWf3yAdJDrwjCu5NvywBcajjBw8=;
        b=fwWEw6JSd5BEnTZC0+xpHdy5p6G50S/zZd5zDSwKnoEyYui7qukmctT/YNe7yqMMXL
         jxCWpTUP1kV3AZdzhwDcWfwoIf8cZEd+1Jz3fvJq3zZ7HuJLn9rRoEbOFGSvbdTA19BY
         H8fbEfXgi9Bh0/DSDOfMJsG1SybFhsoccbB9bRc4VoqCGgOytQT9O0eREDuBgADt3/WL
         rBsmzpscoefYD5CQUOj5WvEM8Ow1jIBycctOe5Pfm2Iz3XWNNgjbrddOLlvhHMPGE5HI
         GxTxlaqUPh4kjMyYB/ifJaOydFw1QMuJ4GWGrKN4SkYCYLRFCqLZmyLVhE1Fz80ShPSE
         sgTQ==
X-Gm-Message-State: AJcUukflOxFFWz3PdxA/FOWSEGoYMrConQDD5CK8J852DHCtEVCF6o7j
        9F8r/hwdVedUgMoeQxB8bgt83w==
X-Google-Smtp-Source: ALg8bN7BetzpTMMgvuYKqy6f3Bd4ZSVxrnfprlI+W4JJm/Q8gDObVX86HHh+STvjPbXtMIEC1gC71w==
X-Received: by 2002:a17:906:154c:: with SMTP id c12-v6mr11435180ejd.69.1547201214790;
        Fri, 11 Jan 2019 02:06:54 -0800 (PST)
Received: from brauner.io ([2a02:8109:b6c0:d6c:c571:88:8aee:976c])
        by smtp.gmail.com with ESMTPSA id a38sm2214446edd.44.2019.01.11.02.06.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 02:06:54 -0800 (PST)
Date:   Fri, 11 Jan 2019 11:06:53 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     tkjos@android.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, arve@android.com,
        dan.carpenter@oracle.com, joel@joelfernandes.org, maco@android.com,
        tkjos@google.com
Subject: Re: [PATCH v2 2/2] binderfs: reserve devices for initial mount
Message-ID: <20190111100652.vw5dhopo5vyc24he@brauner.io>
References: <20190102113219.3716-1-christian@brauner.io>
 <20190102113219.3716-2-christian@brauner.io>
 <20190111091818.GA17058@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190111091818.GA17058@kroah.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 10:18:18AM +0100, Greg KH wrote:
> On Wed, Jan 02, 2019 at 12:32:19PM +0100, Christian Brauner wrote:
> > The binderfs instance in the initial ipc namespace will always have a
> > reserve of 4 binder devices unless explicitly capped by specifying a lower
> > value via the "max" mount option.
> > This ensures when binder devices are removed (on accident or on purpose)
> > they can always be recreated without risking that all minor numbers have
> > already been used up.
> > 
> > Cc: Todd Kjos <tkjos@google.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> > ---
> > v2:
> > - patch unchanged
> > v1:
> > - patch introduced
> > v0:
> > - patch not present
> > ---
> >  drivers/android/binderfs.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> What did you make this patch against?  It doesn't apply cleanly so I
> don't want to take it until we get everything synced up properly
> together :(
> 
> I'll apply patch 1/2 now, can you rebase and resend this one?

Yup. I'll rebase on top of char-misc-linus now. :)

Thanks!
Christian
