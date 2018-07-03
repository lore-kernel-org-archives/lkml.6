Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D98FC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 19:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1774221A59
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 19:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BLlmcgqA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1774221A59
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753624AbeGCTQI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 15:16:08 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:32905 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752061AbeGCTQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 15:16:06 -0400
Received: by mail-wr0-f194.google.com with SMTP id k7-v6so3045492wrq.0;
        Tue, 03 Jul 2018 12:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CUlT63CJpf5j3g4MrMvIMD865wbNYiI2DscIOt5eEfM=;
        b=BLlmcgqARSREtpdIduuzRvnVLNdh/RXiWY+fSL0Mh11liUNiixxTnm1sMokzxmpKg/
         DBSWOlF4660VY+WN7BGyf4xAgksD2pNbd1obff2MTSqIYq4x07GRqlUblpaYWZ8CZ4tl
         x+ROUP+4x7yCfP3x7VUY6eqg6uaKw2FTDGO/vCs9f6Fovs9wNwMXb/ZyZ0ygLp3labF4
         Ja6/1BjEfn0pOP+SB4p8wAQOUEZVT4poVM4axkZ9X8Op5zufjp+8o/23ipaxIa6SMBQO
         VGxZPkUqu1cEpGvNo4YDaTy6rwEdkrvc4WrAUOiA0fKR6leaHw9F1fDr+NRJ8cMjZkBZ
         +yBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CUlT63CJpf5j3g4MrMvIMD865wbNYiI2DscIOt5eEfM=;
        b=tq+N5fjezXPj+BSvcPTlz0eDor6rmqQWL34TQsexX61SnGn4VFucb0TQ9jpOgY714J
         KmQXrSnf+vNaQsfujb7RrbOGCPsK2j/4UCb8sHED0NuyBIBh0VOneXxZxOC+0vAj4GRF
         Lk2AKqkhSWzid55w/uV3tZNwNLJ3AVv8SugrS5AiCPkpvThHiCbfQZIGtC/xOfG3bs1+
         +3CdVWkBed+n9uk0aU4UThAlktEr3/4QLtRalieFXcdxAvGCgCWnJVWuv/Pz4Y4AMDVb
         yMZUvwv7rl9YMXcUI7w1KYKJz/dTUgg04YrgIwnNfZGOPHbngKFKKnub7MMwIyVdL79O
         v6bg==
X-Gm-Message-State: APt69E3VlMWO7FLqO5AQrxEU5BMoZM1z+ahcWcC+ec0sfoqj8ZQFn0qN
        mEG2mjlrfPSNxqQ3Urlb/Fab
X-Google-Smtp-Source: AAOMgpdPxp/zv5bfWNZfwkHnpKZJigFpKkpwp5gS37kkS058gUOa45wKKxt33nT8e8MsjsN3ZQ42ng==
X-Received: by 2002:adf:a0f3:: with SMTP id n48-v6mr6405540wrn.23.1530645365405;
        Tue, 03 Jul 2018 12:16:05 -0700 (PDT)
Received: from avx2 (nat4-minsk-pool-46-53-177-92.telecom.by. [46.53.177.92])
        by smtp.gmail.com with ESMTPSA id 49-v6sm1076418wrx.18.2018.07.03.12.16.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 12:16:04 -0700 (PDT)
Date:   Tue, 3 Jul 2018 22:16:02 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH -mm] proc: fix BUILD_BUG_ON breakage on powerpc64
Message-ID: <20180703191602.GA25521@avx2>
References: <20180629174946.1b4f40ef@canb.auug.org.au>
 <20180629212521.GA23437@avx2>
 <20180630131710.72cec2be@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180630131710.72cec2be@canb.auug.org.au>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 30, 2018 at 01:18:22PM +1000, Stephen Rothwell wrote:
> Hi Alexey,
> 
> On Sat, 30 Jun 2018 00:25:22 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:
> >
> > On Fri, Jun 29, 2018 at 05:49:46PM +1000, Stephen Rothwell wrote:
> > > fs/proc/inode.c:110:2: note: in expansion of macro 'BUILD_BUG_ON'
> > >   BUILD_BUG_ON(sizeof(struct proc_dir_entry) >= SIZEOF_PDE);
> > >   ^~~~~~~~~~~~
> > > 
> > > Caused by commit
> > > 
> > >   527ae8759f10 ("proc: fixup PDE allocation bloat")
> > > 
> > > I have reverted that commit for today.  
> > 
> > Can't reproduce it with commit 7aa4b0a46be8badd053c958481f0e89e634ae4df
> > (the one before revert) both on 32-bit and 64-bit.
> > 
> > Can you post fs/proc/inode.i ?
> 
> Attached (xz compresesed).
> 
> This is built with gcc 7.3.1 (built from source) hosted on PowerPC LE
> and targeted at PowerPC BE (a powerpc allyesconfig build).  I did not
> have any trouble with any of my other PowerPC targeted builds.

I'm not sure what's going on. Taking preprocessed file and compiling it
with ppc64 cross compiler gives sizeof(struct proc_dir_entry) = 232.

Anyway here is obvious fixlet:

[PATCH -mm] proc: fix BUILD_BUG_ON breakage on powerpc64-allyesconfig

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/proc/internal.h |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -65,12 +65,12 @@ struct proc_dir_entry {
 	char inline_name[];
 } __randomize_layout;
 
-#ifdef CONFIG_64BIT
-#define SIZEOF_PDE	(sizeof(spinlock_t) <= 4 ? 192 : 256)
-#else
-#define SIZEOF_PDE	(sizeof(spinlock_t) <= 4 ? 128 : 192)
-#endif
-
+#define SIZEOF_PDE	(				\
+	sizeof(struct proc_dir_entry) < 128 ? 128 :	\
+	sizeof(struct proc_dir_entry) < 192 ? 192 :	\
+	sizeof(struct proc_dir_entry) < 256 ? 256 :	\
+	sizeof(struct proc_dir_entry) < 512 ? 512 :	\
+	0)
 #define SIZEOF_PDE_INLINE_NAME (SIZEOF_PDE - sizeof(struct proc_dir_entry))
 
 extern struct kmem_cache *proc_dir_entry_cache;
