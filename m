Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F998C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BC4C217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549982756;
	bh=ZRSNjjzu1x2hodr/GFiH3t8T9ti74DQsSKqaJls9tbM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=H56l7NAVyvylb8avQN0mjw43Lnao/7YCDVRuocn8ZvV0PS7M32L0wfr16i2RJz69E
	 hHb9lU1Pi4QaG+woPWCHb4GmhBu5UI4+S0Y+L3g9ukZiYIt+SE+eLl3H3dfRLCXWHx
	 Cbm1uC1cmqVevWrYzUZi/nLEq23rxAbcTyHBMdFc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730289AbfBLOpy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 09:45:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:44896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727562AbfBLOpy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 09:45:54 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 485452083B;
        Tue, 12 Feb 2019 14:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549982753;
        bh=ZRSNjjzu1x2hodr/GFiH3t8T9ti74DQsSKqaJls9tbM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MSx7NLJU0/yhDFtNYB7NsDzD/5ebUQnN9phRqQhJIYwOZDiGQisc6mhgJTJ6VrULO
         gvhzHpckdm053acEwXkTLee4/w+0FF/EZ8n35CyP8bn3uka5WyeopJX3P8YyZTj0GR
         z9eeAN0X/HakRUhGGIV9MEh1MVxHcOQIZ2qRMyCw=
Date:   Tue, 12 Feb 2019 15:45:51 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Wang <wonderfly@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Peter Feiner <pfeiner@google.com>,
        linux-serial@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC PATCH v1 01/25] printk-rb: add printk ring buffer
 documentation
Message-ID: <20190212144551.GA17291@kroah.com>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
 <20190212143003.48446-2-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212143003.48446-2-john.ogness@linutronix.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 03:29:39PM +0100, John Ogness wrote:
> The full documentation file for the printk ring buffer.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  Documentation/printk-ringbuffer.txt | 377 ++++++++++++++++++++++++++++++++++++

Nit, shouldn't this be in .rst format and tied into the "build the
kernel documentation" process somehow?

thanks,

greg k-h
