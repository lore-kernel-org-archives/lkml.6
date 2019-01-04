Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7568DC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 11:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 414492173B
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 11:09:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KENghtmg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbfADLJo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 06:09:44 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54231 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727824AbfADLJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 06:09:39 -0500
Received: by mail-wm1-f66.google.com with SMTP id d15so806604wmb.3;
        Fri, 04 Jan 2019 03:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=cooBYbj1urazYVb+mzhgEi7gus8Knm3xgSwD4owERyE=;
        b=KENghtmgA5nkxqYbGy4aA9pD8PG2cSDrnDDa82LCPDWUhGoK4hOKkR9cyu5jXrYiRx
         LYWkqccs1DB14aaBlxowDLe8nfjAnMYW671G6iPR6+P/dLSiOKPcG8xvE1ym2rx/bL1I
         C/fOTFYHr3qeIo2W/iCgfeX9AnnqepOUzgx5YaFo3cW/JF6tv0j3aKmV8RKKJLlIEQlD
         9iRzX6OhCK8n5+K8fG62JzfjLrCY+rKgR3BQSjGsxf3ApWzEoVPd6cRkpOsSfo/0JA+Q
         z0+t1kNAQ/VjutORWRnMynl2XFZorpGJQnvRfaHhd8wAiqM5Oi7sbc9bhgzzCcVUkQ1r
         2AYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=cooBYbj1urazYVb+mzhgEi7gus8Knm3xgSwD4owERyE=;
        b=bHwj3QM2Vcfa7MgdvzSLkFjd0T/z9vaV5++cEVOORiBXcoEpNxnkzhHr/y8hzfCcpz
         7524dAgAXFwrkIsZKxzrOMau/Jbu5zpu1kt7nMvImfjJkVp/lLHnWP18u299Ofh0viOR
         uh6yGIEaXTlukFZTNyzYoSPueGyfxYelnB4K5AfhTVVV6XATRUgLz6cP75WSIJctuBM8
         d81dgeHECsZ5MJDKTZs9p92f4UkuBuwo/DPbqV738I5IyBDTQRrILmxT+ygDWhecafq+
         HXcO5/j5ljo0sBy+aVfUsTp204kzLy2fDy0PjOauIvvp0fx3uujFxC1ABQuykF3qp3AJ
         +XdA==
X-Gm-Message-State: AJcUukf0ZUJVs5rb9N9OCIjGi5AbcMj7v5TFI8x3MsFktsNvwX9aTtWB
        TWQQoXvyelD0s+AJuIK5zg==
X-Google-Smtp-Source: ALg8bN42Jxipd/8vbOuomobEJhWKcrG9g6nkJk+NPMXWfVsvj/Vqwmk5Gh4zyxaZDvRiikzhtPawZg==
X-Received: by 2002:a1c:2902:: with SMTP id p2mr993682wmp.19.1546600176736;
        Fri, 04 Jan 2019 03:09:36 -0800 (PST)
Received: from avx2 (nat-minsk-pool-46-53-201-92.telecom.by. [46.53.201.92])
        by smtp.gmail.com with ESMTPSA id v4sm835442wme.6.2019.01.04.03.09.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Jan 2019 03:09:35 -0800 (PST)
Date:   Fri, 4 Jan 2019 14:09:33 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Mateusz =?utf-8?B?U3TEmXBpZcWE?= <mateusz.stepien@netrounds.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Old content of /proc/net after switching network
 namespace
Message-ID: <20190104110933.GA2682@avx2>
References: <4749d3bd-eac9-2a3e-aa93-d76d2e015945@netrounds.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4749d3bd-eac9-2a3e-aa93-d76d2e015945@netrounds.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 04, 2019 at 09:21:23AM +0100, Mateusz Stępień wrote:
> After changing network namespace using setns, the content of /proc/net 
> still represents the original namespace.
> It looks like procfs dentries are not invalidated in dcache properly 
> after the namespace switch.
> It happens only, when you read content of /proc/net before changing 
> namespace
> The problem is reproducible in 4.19.13 but not in 4.14.X.
> Bisecting the stable kernel tree shows that the commit
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=1da4d377f943fe4194ffb9fb9c26cc58fad4dd24 
> introduced the problem.
> Reverting mentioned commit resolves it.
> 
> MCVE (slightly modified example from [man 2 setns]):

	open /proc/net/dev
	read
	close

	setns

	open /proc/net/dev
	read
	close

This bug was discussed recently and Al even posted how to fix it
properly.

Try this horror patch meanwhile:

--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -219,19 +219,30 @@ void proc_free_inum(unsigned int inum)
 	ida_simple_remove(&proc_inum_ida, inum - PROC_DYNAMIC_FIRST);
 }
 
+static bool net_root(const struct proc_dir_entry *pde)
+{
+	return pde->parent == &proc_root && pde->mode == 0;
+}
+
 static int proc_misc_d_revalidate(struct dentry *dentry, unsigned int flags)
 {
+	const struct proc_dir_entry *pde;
+
 	if (flags & LOOKUP_RCU)
 		return -ECHILD;
 
-	if (atomic_read(&PDE(d_inode(dentry))->in_use) < 0)
+	pde = PDE(d_inode(dentry));
+
+	if (atomic_read(&pde->in_use) < 0 || net_root(pde))
 		return 0; /* revalidate */
 	return 1;
 }
 
 static int proc_misc_d_delete(const struct dentry *dentry)
 {
-	return atomic_read(&PDE(d_inode(dentry))->in_use) < 0;
+	const struct proc_dir_entry *pde = PDE(d_inode(dentry));
+
+	return atomic_read(&pde->in_use) < 0 || net_root(pde);
 }
 
 static const struct dentry_operations proc_misc_dentry_ops = {
