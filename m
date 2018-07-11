Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D02C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 19:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FF3420871
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 19:19:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FF3420871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389624AbeGKTY5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 15:24:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:49754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387848AbeGKTY5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 15:24:57 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE1F420871;
        Wed, 11 Jul 2018 19:19:12 +0000 (UTC)
Date:   Wed, 11 Jul 2018 15:19:11 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Petr Mladek <pmladek@suse.com>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH v5 2/3] fbcon: Call WARN_CONSOLE_UNLOCKED() where
 applicable
Message-ID: <20180711151911.2ea40200@gandalf.local.home>
In-Reply-To: <CAKMK7uFuZ6NJOKHG6PRNLUytE4m6ZUdMakwLx9Ns39OwvTneWQ@mail.gmail.com>
References: <20180628090351.15581-1-hdegoede@redhat.com>
        <20180628090351.15581-3-hdegoede@redhat.com>
        <717e6337-e7a6-7a92-1c1b-8929a25696b5@suse.de>
        <20180711105255.32803a3c@gandalf.local.home>
        <7ec11c96-7dd5-ec12-548e-7c1fa9b883e8@suse.de>
        <d528a539-255c-f019-eb6f-63f0585e0de3@redhat.com>
        <CAKMK7uG-xiCKkxhujL=J6n9ozYfW+fsioGHEmYRxpszVX=5PDg@mail.gmail.com>
        <892782ad-4b97-8eda-f5b0-3a893b3a5f84@redhat.com>
        <CAKMK7uFyPh0sHj7enAU2En4BidODAS+Tis=-UE16xOLQWm8iQA@mail.gmail.com>
        <2f37f47c-e28e-77fa-2383-96c7d3e77433@redhat.com>
        <CAKMK7uFuZ6NJOKHG6PRNLUytE4m6ZUdMakwLx9Ns39OwvTneWQ@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jul 2018 19:56:02 +0200
Daniel Vetter <daniel@ffwll.ch> wrote:

> > Have you seen Steven's suggestion which he send about the same time
> > as your mail I'm replying to here ? I personally think that doing
> > something like that makes sense (for as long as we have the need
> > for the lockless_fb_register debug hack).
> >
> > Note I've 2 patches ready to go to only fix this in fbcon.c, but I
> > think a more thorough fix makes sense.  
> 
> Yeah Steven's suggestion looks reasonable to fix this all for good.
> The #if 1 predates git history, so no idea why it was added or by whom
> :-)

I just sent the patch. If the printk maintainers take it, then you can
update the fb driver to set the ignore_console_lock_warning when
lockless_fb_register is set.

-- Steve
