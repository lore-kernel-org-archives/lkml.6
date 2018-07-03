Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C555DC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 16:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C9FB2147E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 16:14:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C9FB2147E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933869AbeGCQOd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 12:14:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:51096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932392AbeGCQOc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 12:14:32 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFC082147E;
        Tue,  3 Jul 2018 16:14:30 +0000 (UTC)
Date:   Tue, 3 Jul 2018 12:14:29 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Petr Mladek <pmladek@suse.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] console/fbcon: Add support for deferred console
 takeover
Message-ID: <20180703121429.283faef0@gandalf.local.home>
In-Reply-To: <20180703161327.GA391@tigerII.localdomain>
References: <20180628090351.15581-1-hdegoede@redhat.com>
        <20180628090351.15581-4-hdegoede@redhat.com>
        <20180703161327.GA391@tigerII.localdomain>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Jul 2018 01:13:27 +0900
Sergey Senozhatsky <sergey.senozhatsky@gmail.com> wrote:

> On (06/28/18 11:03), Hans de Goede wrote:
> [..]
> >  
> > +config FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER
> > +	bool "Framebuffer Console Deferred Takeover"
> > +	depends on FRAMEBUFFER_CONSOLE=y && DUMMY_CONSOLE=y  
> 
> +	default n
> 
> > +	help
> > +	  If enabled this defers the framebuffer console taking over the
> > +	  console from the dummy console until the first text is displayed on
> > +	  the console. This is useful in combination with the "quiet" kernel
> > +	  commandline option to keep the framebuffer contents initially put up
> > +	  by the firmware in place, rather then replacing the contents with a
> > +	  black screen as soon as fbcon loads.  
> 
> Can we please default this to 'n'?
>

No explicit default means 'n'. You don't need to specify it.

-- Steve
