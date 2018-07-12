Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29786C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 13:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0AAC21479
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 13:43:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0AAC21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732449AbeGLNww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 09:52:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:50190 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726782AbeGLNwv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 09:52:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6238DAD9C;
        Thu, 12 Jul 2018 13:43:13 +0000 (UTC)
Date:   Thu, 12 Jul 2018 15:43:12 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>
Subject: Re: [PATCH v2] console: Replace #if 1 with a bool to ignore
Message-ID: <20180712134312.yxbg7pollgpxkrfy@pathway.suse.cz>
References: <20180712092938.22e33641@gandalf.local.home>
 <20180712093049.692ad3bd@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180712093049.692ad3bd@gandalf.local.home>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2018-07-12 09:30:49, Steven Rostedt wrote:
> On Thu, 12 Jul 2018 09:29:38 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > From: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > 
> > There's been discussion on the fb list about the addition of
> > WARN_CONSOLE_UNLOCKED() inside the fb code. The complaint is that when
> > the fb module is loaded with lockless_register_fb the console lock is
> > not taken for debugging reasons. With the addition of
> > WARN_CONSOLE_UNLOCK() within the fb code, this causes the console to
> > fill up with warnings when trying to debug the fb driver.
> > 
> > There's also a #if 1 that enables the warning which was added before
> > git history, and we look down on constant #if's in the kernel nowadays
> > anyway.
> > 
> > Remove the #if 1 and add a ignore_console_lock_warning boolean that can
> > be set by drivers to ignore the warning in order to do debugging.
> > 
> > Link: http://lkml.kernel.org/r/717e6337-e7a6-7a92-1c1b-8929a25696b5@suse.de
> > Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> > Acked-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> > Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> 
> Petr,
> 
> If you want this to go by way of fbdev tree, then can you Ack it?

Sure.

Acked-by: Petr Mladek <pmladek@suse.com>

I assume that it will go via fbdev tree with the other changes
unless I hear otherwise.

Best Regards,
Petr
