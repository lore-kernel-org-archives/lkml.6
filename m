Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 133BDC64E79
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 22:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6DF1217D6
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 22:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545692105;
	bh=TwShqVAELQi8yzhRUYk4BTdfhdn1Dm31DfT2p6ik/sg=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=VVFpmBwHi/HpsLHcqFcS54Et0m0+E39OHwyBEKyHYGtZuN3cAVMOirxWB1msYpp2w
	 YLYP623QA4WsMdYD96vjKCQJNr40KvSCwpO31t1eXNqjArK73LxmuAbmm7qXwZNjh6
	 nz1+OJlhOz1ng5s8ANuwMw9YpLN7O+ikcm2veXr4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725856AbeLXWzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 17:55:04 -0500
Received: from mail-wr1-f54.google.com ([209.85.221.54]:43368 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbeLXWzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 17:55:04 -0500
Received: by mail-wr1-f54.google.com with SMTP id r10so12594302wrs.10
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 14:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=pGGmWLyOr0E+w9xb5wqdSqns62bCJhSQ/AT0OK28yDE=;
        b=TatnFMMFBzBi87EJ6jHJ7foVEHdTLdWouSWZgx+0+tzaUuDFQ/N6QEnGWztA6qOm6Z
         6jR3X+KGCGvrCtHmgBXTi88NrSzUYqsV1YNmksYXCntrWIPL2eW/Gv94ClQkA3nnqzRQ
         twtbcxjRB6+EoWSSfDmp+MHi3auPKqjM3dkjFurv7VRRSd6JM6ybXJW7isk6k3cDHbHG
         jXVSh/+O6qlbXO2lXCSHcCF4TQ+M/97tb3Nrqm639n6TsCm7nhFVkZKRT8pf1UhvMFfv
         gTv7ucxXnORoBTjGivoZv708Lf3a074q1bA9+5t0ctx3Q8jnLnzk9HlSjVM1BZwKIk1W
         9K4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=pGGmWLyOr0E+w9xb5wqdSqns62bCJhSQ/AT0OK28yDE=;
        b=QYmYU2BNw2EkALKniGDJ+MvVNjfvckjtmljZmRvT9gHrtTwUdu/xr7SxrQjnetjErI
         D6zFw6q4EO0ITK7aQa5M0eL9bopFpydseM/+eD52mNWcbBo/805kg7JsGzV4r/Ksl9CW
         Zaat52YKb9nERC35jnRE38faEsOKWnWT7uSA5erRuiz4XhBWjdOY2nobUj3D9RClw5iP
         Y7VnKTvizhAIaeVCa+IqACzX7uXBF5i4uP7JP+fjJYFEicw/rtJ/H/xCvF2BeXXXGKmC
         4h2Y91olk9punogDkHfBmST2ARIRYDSkj1ocLLlmL4W/PVtaQksvQHp5dALdbIVrRAc8
         5J2w==
X-Gm-Message-State: AJcUukdQy/GmaMXJmy6XiFfUOuW53kTRZA47/ZyW1uOH00zQ3OWvdAG/
        97iIJxuoCVFPdhAwFdZ6z4w=
X-Google-Smtp-Source: ALg8bN65g7qpA01fsK7zkngf0kJUaBzGC/2SVAX7fuzTxcDcggsKTHrS9b/uWKxLard3db6GFdzyQA==
X-Received: by 2002:a5d:4512:: with SMTP id s18mr13827885wrq.182.1545692102918;
        Mon, 24 Dec 2018 14:55:02 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id y138sm27369290wmc.16.2018.12.24.14.55.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Dec 2018 14:55:02 -0800 (PST)
Date:   Mon, 24 Dec 2018 23:55:00 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/boot changes for v4.21
Message-ID: <20181224225500.GA23680@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-boot-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-boot-for-linus

   # HEAD: 69be4efeb959147ff86f22e35aea9526f9b86715 x86/boot: Add missing va_end() to die()

Two cleanups.

 Thanks,

	Ingo

------------------>
Jordan Borgner (1):
      x86/boot: Simplify the detect_memory*() control flow

Mattias Jacobsson (1):
      x86/boot: Add missing va_end() to die()


 arch/x86/boot/boot.h        |  2 +-
 arch/x86/boot/memory.c      | 31 ++++++++++---------------------
 arch/x86/boot/tools/build.c |  1 +
 3 files changed, 12 insertions(+), 22 deletions(-)

