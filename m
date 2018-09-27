Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69269C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 10:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D9D721571
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 10:02:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D9D721571
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbeI0QTr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 12:19:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:60156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727015AbeI0QTq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 12:19:46 -0400
Received: from vmware.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60D0321571;
        Thu, 27 Sep 2018 10:02:16 +0000 (UTC)
Date:   Thu, 27 Sep 2018 06:02:04 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: CON_PRINTBUFFER console registration is a bit
 racy
Message-ID: <20180927060107.2ef35dfb@vmware.local.home>
In-Reply-To: <20180926113715.6llme2vmvynzuoa3@pathway.suse.cz>
References: <20180914023428.814-1-sergey.senozhatsky@gmail.com>
        <20180914085934.m2bgixltdzpfh62o@pathway.suse.cz>
        <20180914111953.GA20572@tigerII.localdomain>
        <20180926113715.6llme2vmvynzuoa3@pathway.suse.cz>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Sep 2018 13:37:15 +0200
Petr Mladek <pmladek@suse.com> wrote:

> If you really want this change, please add a comment, for example:
> 
> /*
>  * Set exclusive_console still with disabled interrupts to
>  * reduce race window with eventual console_flush_on_panic()
>  * that ignores console_lock.
>  */
> 
> I am not against the change. It makes some sense and it does
> not break anything. It is just not obvious and might either
> get easily lost again or it might cause confusion. I mean that
> it might cause false feeling that exclusive_console is
> synchronized by logbuf_lock.
> 
> printk code already is complex enough without this subtle
> tricks.

I'm fine with the change and agree that a comment should be added.

-- Steve
