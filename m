Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E73C9C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB90121783
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547123748;
	bh=f31l96OT6VJpg74eoxWMl1yslM1me9bGdepAfA23F2s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iKQWvBQe2VqBiz/E5he8F7qCuLU1jplxGwatVFyPEhlXaY7DDnDV9195DF5SEy7jY
	 +vDNMQ0lFHBPt3Mra+F75An6DGEBkK71gAYpAeXPkKJdvu6DqccFVjz1ZZ8LL0V74H
	 9dQQQd5/h3YEpLyNbV1SzV3LQJkMbu3ZU81VD11E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbfAJMfs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 07:35:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:49276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727214AbfAJMfr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 07:35:47 -0500
Received: from guoren-Inspiron-7460 (23.83.240.247.16clouds.com [23.83.240.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93E6B214DA;
        Thu, 10 Jan 2019 12:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547123747;
        bh=f31l96OT6VJpg74eoxWMl1yslM1me9bGdepAfA23F2s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VJkEJHvwmvj0ANJBj/QXgQD9Ee/E/3jlZHbF+Rl8DU31bV7659lmIFILWjG/t/h9e
         X36dOj3PfYqVJjq8LBQ9V5EnLE0yidwf3VF3wnJRnP2VYM1ruYbYL0OdppeIhyTCjb
         khj1gbdzhisGOQNIAC99AhU9qcLxTwRDlqtnKs/c=
Date:   Thu, 10 Jan 2019 20:35:41 +0800
From:   Guo Ren <guoren@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [GIT PULL] csky fixup for linux-5.0-rc1
Message-ID: <20190110123541.GB15390@guoren-Inspiron-7460>
References: <1547045397-24388-1-git-send-email-guoren@kernel.org>
 <20190110081052.GB13262@guoren-Inspiron-7460>
 <CAHk-=whE1Gea=216t=1OfEUrsEYRq2wn27OaPE8HBD4mSUDaOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whE1Gea=216t=1OfEUrsEYRq2wn27OaPE8HBD4mSUDaOQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 03:59:22AM -0800, Linus Torvalds wrote:
> On Thu, Jan 10, 2019 at 12:11 AM Guo Ren <guoren@kernel.org> wrote:
> >
> > This pull-request is wrong on the patch:
> > "csky: fixup module relocation error with 807 & 860".
> > diff --git a/arch/csky/kernel/module.c b/arch/csky/kernel/module.c
> > -       uint16_t location_tmp = (uint16_t *)location;
> > +       uint16_t *location_tmp = (uint16_t *)location;
> >
> > Please drop it if possible and I'll send another [GIT PULL].
> 
> Too late, already pulled.
> 
> Send a patch, and I'll apply it. Or send a pull request with updates
> if there's more than that oneliner..
Thx, I've sent a patch for you:
"[PATCH V2] csky: fixup compile error with CPU 810."

Best Regards
 Guo Ren
