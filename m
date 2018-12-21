Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD503C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 19:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B338D21929
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 19:29:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391743AbeLUT3M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 14:29:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:58002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390012AbeLUT3M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 14:29:12 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C157921906;
        Fri, 21 Dec 2018 19:29:10 +0000 (UTC)
Date:   Fri, 21 Dec 2018 14:29:09 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     David Miller <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        akpm@linux-foundation.org, namhyung@kernel.org,
        mhiramat@kernel.org, sparclinux@vger.kernel.org
Subject: Re: [for-next][PATCH 06/24] sparc64: Use
 ftrace_graph_get_ret_stack() instead of curr_ret_stack
Message-ID: <20181221142909.0b905cbc@gandalf.local.home>
In-Reply-To: <20181221.102414.1992688460948808079.davem@davemloft.net>
References: <20181221175618.968519903@goodmis.org>
        <20181221175656.191575102@goodmis.org>
        <20181221.102414.1992688460948808079.davem@davemloft.net>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Dec 2018 10:24:14 -0800 (PST)
David Miller <davem@davemloft.net> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> Date: Fri, 21 Dec 2018 12:56:24 -0500
> 
> > From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> > 
> > The structure of the ret_stack array on the task struct is going to
> > change, and accessing it directly via the curr_ret_stack index will no
> > longer give the ret_stack entry that holds the return address. To access
> > that, architectures must now use ftrace_graph_get_ret_stack() to get the
> > associated ret_stack that matches the saved return address.
> > 
> > Cc: sparclinux@vger.kernel.org
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>  
> 
> Acked-by: David S. Miller <davem@davemloft.net>

Thanks David!

-- Steve

