Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57508C64E75
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 23:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 233C6222A2
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 23:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545693174;
	bh=lnhbj2BZvAgiIO4wrAbY6cSGZMQD+GhhD+xiPqjHxDo=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=IX7N9z4IMrHNJiYvek9XN3zFHDRd/RgR7QPxPSk+6LFv7wenCDMwMk1GiUs2BdOYK
	 NqVivlDIRLbTlMSZqq3Qb3PeA2JM+ylfC9TF5v6MNul11F1wPf3ERwqyJEK1/6H1qq
	 gMdEyI5i1d8tEt4Le3sCyIZfdR68RRVSjTo6U9JQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725878AbeLXXMw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 18:12:52 -0500
Received: from mail-wm1-f44.google.com ([209.85.128.44]:52686 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbeLXXMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 18:12:52 -0500
Received: by mail-wm1-f44.google.com with SMTP id m1so12077831wml.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 15:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=80HkBWvQPhHWg30bQjDg9VYkxsS+0cS6SAzvuIvSN28=;
        b=smP+huf2D0DOjMxeZ/BlvUMlAcRLHQGf8Q+cZSCVV2CXrNmtQb84zQ1TPnnIhA5Jdh
         wUiLmLzTlfviKMTF6N65WfAQSYEIH/RlVcyQdVNmNBYu+H+QbQVt1BXYpGp+NpYCei8B
         cg3yKpZgi9Inme6NSGkFhJWWRNKNv7yNv0NccAO/D/Hy/Tx6mgHAwhgtD7GRfVI1TqrS
         PEaWABrX6+krfiaIQwtGLAjT6Gv9KBl8mMO0ZCVzH+FXH+aWr6lLH6e8ogfKTRwOi7sk
         YFc5QCZmha9Prm+Qf+Cq8UHcGfmbV7aq5hryxgzTcrS5FeBiWTS8LvYdnU+dL7nOf0Np
         uyHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=80HkBWvQPhHWg30bQjDg9VYkxsS+0cS6SAzvuIvSN28=;
        b=sRMKoSu8yP7btIzhwBJ2Dke8dGCkJGoRx4C4M8zAzzNc6uxTp8/a16WJcgoywz6Q8k
         RK8nOc/KGHz7x/aec64tsEpTF8+IXx8LVZNlFWNJFIPz/RsCaI6SRAt8uQ0WmCpUy89s
         5GCTR1+3sxsa53G8TFoCk20ouqBenJ1lI/H9IaT8HtQAswNZOCC//2gVx1LgZZyP8b1Q
         x0s/1rSPIOpg1ieHCcNdmtYRW9axW4CSDfdUbyLuRRb4AMW16SzWyDNznoRCRPf8HNbU
         1yT+25nvlElGyAQlhFt+Yvd4iQw7Ha4gt3LeYOnMQejWtnPNGpFQwXwYfLM3MrMmr+tc
         pnzg==
X-Gm-Message-State: AJcUukcu0amtwFbZ01GburpRrtxukriramdK44bGgXMGIEDL+5qyH0ky
        yKYvaXCMQQ7ukVBwkulmhBbPad/l
X-Google-Smtp-Source: ALg8bN5L2/Ih2vdhe408DIxbBeSVUHfRAdVzbPZ1IFnGZT4kmpiHLhMhHs12cp7p9Ohs4iaru1G+Tw==
X-Received: by 2002:a1c:8484:: with SMTP id g126mr13904367wmd.117.1545693170447;
        Mon, 24 Dec 2018 15:12:50 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id h62sm17253932wmf.11.2018.12.24.15.12.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Dec 2018 15:12:49 -0800 (PST)
Date:   Tue, 25 Dec 2018 00:12:47 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/platform change for v4.21
Message-ID: <20181224231247.GA67865@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-platform-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-platform-for-linus

   # HEAD: c04e55388a4f2184e37827a1d2e733cded52d653 x86/platform/olpc: Do not call of_platform_bus_probe()

An OLPC platform support simplification patch.

 Thanks,

	Ingo

------------------>
Rob Herring (1):
      x86/platform/olpc: Do not call of_platform_bus_probe()


 arch/x86/platform/olpc/olpc_dt.c | 18 ------------------
 1 file changed, 18 deletions(-)
