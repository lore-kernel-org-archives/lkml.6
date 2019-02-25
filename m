Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 817F4C10F00
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 17:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F3B520842
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 17:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8M3WJZC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbfBYRfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 12:35:13 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33619 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfBYRfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 12:35:12 -0500
Received: by mail-ed1-f67.google.com with SMTP id c55so8306133edb.0;
        Mon, 25 Feb 2019 09:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9F5JqPFc3Lwphaxkpkfmb1eh5c3hr3ldSOvZsbfhcco=;
        b=P8M3WJZCGSOzhAA/9bzAYL9x4/huuX7TKIgPHew0/sMVPbo44rtH4DrGS9aCBvpA4B
         73VvFr4YRgZsaNJ3nYllNN/kvYmp2msa1UuAGXJAJ3lctQNlOeQVP69OAmNEgC1CE1La
         u3zDG66ZXS4ccRfJM4W5Atb5xEJt61NogxkT5BY7na8ERk2ER1ZmEaXLfrL51xFxbqdD
         KoiV44oyo7gmx1CwGpqkqv/xZJy9B7+oB2tBcp1upQLib6u3jhB6phtu5K5BVqCWTWXp
         o7eeFUzMMzZIFN+qx/fb8XXOT96WzThFFnP0lL7+tuIIHRDGAvd/pixJlWTKXY4lyCgO
         rjXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9F5JqPFc3Lwphaxkpkfmb1eh5c3hr3ldSOvZsbfhcco=;
        b=WBlt1w7La6GGEKRq24zn7IHJBNDVikK9bO8pr0xH0RBKSeUy0z3+eZTgyYAopgFRGp
         D+lwLIEX9OAq2pu5+vqUeZjtZzB1BLxzcWpoLu+MpkgrE6mx2GPJA8mevplTJf5R9MqU
         k6Jrkkl9xL4vmeMckI8rX4apOkZLcz8fbeowU7FqsghP0/sbH8z7c8GNBLQU2ujSZmFV
         1C77LBjwu5Jx4dtVWJYPxaUBUEBfmV05/P2QCBbGilvo+63um4JJHwVlTIhdJZg3IFLz
         Oq6Y6+lmOIZQLNt7mmPT1VcLPxPyPZ9Cu94U/UKiPchJvgMHjEoACAuYSWB1jnLxOh9l
         QdIQ==
X-Gm-Message-State: AHQUAuYsARQAj7kuFhORa4z0UK3GEGybBOV8xosGVitqM/+O48DqRNlb
        wxXOtvh34kEIsDkJBFRv+lQ=
X-Google-Smtp-Source: AHgI3IaJr9H+OB+xRDlp0TQ0MC9DVfdBpxwM4CbQWaQy/qN94j/tKLcT2iEF4xnnnPlz7mUEGcWn6g==
X-Received: by 2002:a17:906:66d8:: with SMTP id k24mr2996888ejp.141.1551116110732;
        Mon, 25 Feb 2019 09:35:10 -0800 (PST)
Received: from archlinux-ryzen ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id l22sm2858541edc.68.2019.02.25.09.35.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 25 Feb 2019 09:35:10 -0800 (PST)
Date:   Mon, 25 Feb 2019 10:35:08 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: Clang patches for 4.9
Message-ID: <20190225173508.GA7885@archlinux-ryzen>
References: <20190225061301.GA23411@archlinux-ryzen>
 <20190225144513.GA14055@kroah.com>
 <20190225144719.GA14597@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190225144719.GA14597@kroah.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 03:47:19PM +0100, Greg Kroah-Hartman wrote:
> On Mon, Feb 25, 2019 at 03:45:13PM +0100, Greg Kroah-Hartman wrote:
> > On Sun, Feb 24, 2019 at 11:13:01PM -0700, Nathan Chancellor wrote:
> > > Hi Greg and Sasha,
> > > 
> > > Attached are three mbox files containing patches that bring the Clang
> > > backports that Nick did in 4.9.139 up to date with what is currently in
> > > 4.14 and mainline, as well as fix warnings that are present in the arm64
> > > and x86_64 defconfigs here and in AOSP (cuttlefish_defconfig). All of
> > > these warnings are fixed in 4.14 so there will be no regressions from
> > > upgrading.
> > 
> > Really?  I see a number of these only showing up in much newer kernels.

Sigh that's what I get for not double checking my email after adding
patches :(

> > Specifically these patches:
> >   1f60652dd586 ("pinctrl: max77620: Use define directive for max77620_pinconf_param values")
> >   a0dd6773038f ("phy: tegra: remove redundant self assignment of 'map'")
> >   a9903f04e0a4 ("sched/sysctl: Fix attributes of some extern declarations")
> > 
> > from the "arm" mbox you provided.  Why shouldn't the above patches go
> > into 4.14.y and in some cases, also 4.19.y and 4.20.y?

They should. All three pick cleanly to 4.14.y. Only the first one needs
to be taken into 4.19.y and 4.20.y.

> 
> Also, why are you wanting 238bcbc4e07f ("kbuild: consolidate Clang
> compiler flags") to be in 4.9?  You put it as the last patch in the
> series, nothing depends on it, which seems odd...
> 
> greg k-h

This was more of a "to make future backports easier" commit, plus makes
that block way easier to read. I should have included 3bd9805090af
("Makefile: Export clang toolchain variables") as well though. I don't
feel strongly about it either way but I also don't think the commit
hurts anything.

I'll leave it up to you and provide you with an updated merge resolution
accordingly.

Thanks!
Nathan
