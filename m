Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B6CC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3A4E217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549982804;
	bh=tp0Xe81Oc6uMmKanh6Fxcc6NmTEPO7LQsJLbiNqlChk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cJkSLcNCPssQrY+xdxINk7IAKjM0PoOZQIJXrW/1CmZRGxarCSKUgpARtp9pyAV8K
	 8z41MkECR4oK/6jZcMX0M7eJeMBkEMu/HeP4BX9ycSAV9vU1U0qB5e6ke8aTa1jQWt
	 MHZ7w1juWRhuKgX9o/3a/9JZjP2WhC+c5+WezSOs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730419AbfBLOqn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 09:46:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:45358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727562AbfBLOqn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 09:46:43 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0581F2083B;
        Tue, 12 Feb 2019 14:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549982802;
        bh=tp0Xe81Oc6uMmKanh6Fxcc6NmTEPO7LQsJLbiNqlChk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BfmRds/JjN4U+JxJKuvFCD9hCQ/We2PjMRfO51CL5mU6sO2oHlpIAmIXIu9IZXFnc
         CBhVsDyDJtntfv+q4UCcMtM38qQ20Us493y2zedrafT7QMC8QvUc3cP+CgsC+L0CM+
         CVciiHCqzfBGrq9CZc/uCOf+1Joeny8u81TYf68g=
Date:   Tue, 12 Feb 2019 15:46:40 +0100
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
Subject: Re: [RFC PATCH v1 03/25] printk-rb: define ring buffer struct and
 initializer
Message-ID: <20190212144640.GB17291@kroah.com>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
 <20190212143003.48446-4-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212143003.48446-4-john.ogness@linutronix.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 03:29:41PM +0100, John Ogness wrote:
> See Documentation/printk-ringbuffer.txt for details about the
> initializer arguments.

You can put that documentation here in the .h file and have it pulled
out automatically into the documentation files when they are created.
That way you always keep everything in sync properly.

thanks,

greg k-h
