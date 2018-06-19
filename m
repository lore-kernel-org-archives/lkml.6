Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB02C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 814F0204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:31:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 814F0204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757285AbeFSNbH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 09:31:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:54864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753145AbeFSNbF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 09:31:05 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF771204EC;
        Tue, 19 Jun 2018 13:31:04 +0000 (UTC)
Date:   Tue, 19 Jun 2018 09:31:02 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: Make CONSOLE_LOGLEVEL_QUIET configurable
Message-ID: <20180619093102.5ad9164d@gandalf.local.home>
In-Reply-To: <20180619115726.3098-1-hdegoede@redhat.com>
References: <20180619115726.3098-1-hdegoede@redhat.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Jun 2018 13:57:26 +0200
Hans de Goede <hdegoede@redhat.com> wrote:

> The goal of passing the "quiet" option to the kernel is for the kernel
> to be quiet unless something really is wrong.
> 
> Sofar passing quiet has been (mostly) equivalent to passing
> loglevel=4 on the kernel commandline. Which means to show any messages
> with a level of KERN_ERR or higher severity on the console.
> 
> In practice this often does not result in a quiet boot though, since
> there are many false-positive or otherwise harmless error messages printed,
> defeating the purpose of the quiet option. Esp. the ACPICA code is really
> bad wrt this, but there are plenty of others too.
> 
> This commit makes CONSOLE_LOGLEVEL_QUIET configurable.
> 
> This for example will allow distros which want quiet to really mean quiet
> to set CONSOLE_LOGLEVEL_QUIET so that only messages with a higher severity
> then KERN_ERR (CRIT, ALERT, EMERG) get printed, avoiding an endless game
> of whack-a-mole silencing harmless error messages.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

