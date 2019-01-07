Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 241CCC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 23:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE32D2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 23:45:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbfAGXp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 18:45:59 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:34708 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbfAGXp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 18:45:58 -0500
Received: from localhost.localdomain (c-24-6-170-16.hsd1.ca.comcast.net [24.6.170.16])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 2C2B5891;
        Mon,  7 Jan 2019 23:45:58 +0000 (UTC)
Date:   Mon, 7 Jan 2019 15:45:57 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: + proc-fix-proc-net-after-setns2-checkpatch-fixes.patch added
 to -mm tree
Message-Id: <20190107154557.1f4bfeb8bf1aaa45a0d555e3@linux-foundation.org>
In-Reply-To: <20190107233720.GA26994@avx2>
References: <20190107223609.Z6BC6rJ1M%akpm@linux-foundation.org>
        <20190107233720.GA26994@avx2>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jan 2019 02:37:20 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:

> On Mon, Jan 07, 2019 at 02:36:09PM -0800, akpm@linux-foundation.org wrote:
> > Subject: proc-fix-proc-net-after-setns2-checkpatch-fixes
> > 
> > WARNING: Block comments use * on subsequent lines
> > #56: FILE: fs/proc/proc_net.c:44:
> > +	// /proc/net/* can be changed under us by setns(CLONE_NEWNET)
> > +	pde->proc_dops = &simple_dentry_operations;
> 
> I did it on purpose! Otherwise default vim colouring marks "/*" in red
> because it is comment without "*/"

There's always a way ;)

--- a/fs/proc/proc_net.c~proc-fix-proc-net-after-setns2-checkpatch-fixes-fix
+++ a/fs/proc/proc_net.c
@@ -40,7 +40,7 @@ static struct net *get_proc_net(const st
 
 static void pde_force_lookup(struct proc_dir_entry *pde)
 {
-	/* /proc/net/* can be changed under us by setns(CLONE_NEWNET) */
+	/* /proc/net/ entries can be changed under us by setns(CLONE_NEWNET) */
 	pde->proc_dops = &simple_dentry_operations;
 }
 
_

