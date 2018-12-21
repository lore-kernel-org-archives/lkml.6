Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 629F9C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 18:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BA942190A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 18:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391391AbeLUSYT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 13:24:19 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:50484 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391377AbeLUSYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 13:24:18 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 3441314B646A0;
        Fri, 21 Dec 2018 10:24:17 -0800 (PST)
Date:   Fri, 21 Dec 2018 10:24:14 -0800 (PST)
Message-Id: <20181221.102414.1992688460948808079.davem@davemloft.net>
To:     rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        akpm@linux-foundation.org, namhyung@kernel.org,
        mhiramat@kernel.org, sparclinux@vger.kernel.org
Subject: Re: [for-next][PATCH 06/24] sparc64: Use
 ftrace_graph_get_ret_stack() instead of curr_ret_stack
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181221175656.191575102@goodmis.org>
References: <20181221175618.968519903@goodmis.org>
        <20181221175656.191575102@goodmis.org>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 21 Dec 2018 10:24:17 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steven Rostedt <rostedt@goodmis.org>
Date: Fri, 21 Dec 2018 12:56:24 -0500

> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> The structure of the ret_stack array on the task struct is going to
> change, and accessing it directly via the curr_ret_stack index will no
> longer give the ret_stack entry that holds the return address. To access
> that, architectures must now use ftrace_graph_get_ret_stack() to get the
> associated ret_stack that matches the saved return address.
> 
> Cc: sparclinux@vger.kernel.org
> Cc: "David S. Miller" <davem@davemloft.net>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Acked-by: David S. Miller <davem@davemloft.net>
