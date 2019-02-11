Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6767CC282C2
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 03:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D53F20838
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 03:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M1FHUPmj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfBKDT3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 22:19:29 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42382 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfBKDT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 22:19:29 -0500
Received: by mail-pl1-f195.google.com with SMTP id s1so4626723plp.9;
        Sun, 10 Feb 2019 19:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cgWdB6v4yNctpIKdtKMVW1ScVMcY97smR1mEsSPfDuI=;
        b=M1FHUPmjSK57TxjL2P1/MQd2BfP3pj1pGX2JOAPafMj2Tt1D/b0gFLGCQ+I3EZT40G
         /nJAxgI941+GBxn+XWA4fbkvfFBWb+6ayV3dcQ50vxFlqrlACWhdg8bLrzjdqt5SO/eb
         JHt7ygX5zMH2lkZ+N/nsMiFU1AhzcP7PUSYieifXy5bopYAzDiu2hsUrfaNYta7ZKiAK
         U5Xv2HeI8IxFWdRdKavnJjUy/0HPNLTTib8eJsGaq+KubzH5iQDlraQzriM7tHDlM1hb
         4iQpbjQ3JzZTd4fjJQhJKd9UbySqMiGqi/tgPNX/tMBMi9cMAUd4Tu7E7H6MNGy75nhO
         Nj2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cgWdB6v4yNctpIKdtKMVW1ScVMcY97smR1mEsSPfDuI=;
        b=e0h4sByzw3FSMOjEOyyJPFCTLi2wITtz8Fj6ESAHvD3IiSczr07zc2rCsKaCoZwSgi
         3fHDVPZK3qAiLwDXsktu+MGV7a3Y/cBS0aM25EE5dXiejmtYxsUQ5Hq9nAMVyI1vcYAp
         z6hq/Wz95naopE6SAUxA4mXKdG6G/XpeSWSomdXr1sjSukxl10hmFngP9YB5COqzqY7+
         NXzcFt3RUGNnPM1yeuN9rZpx1GDPgQQ2215UD1ZF8CKCQu5hH2xV2MYGF4qHYvhuZYID
         IxBhiQs1cdNdqteRpr5tqGFVJPgyXXa4/i12L+YrGJk3SZ/qm/TqdwF3iF4zai6koCyg
         WXDQ==
X-Gm-Message-State: AHQUAubl1k84n/FN/QwgZoEnFZGg93U/nP/TI/oPtFSX3W2a0XHnzHXU
        zfqzhDtfJQAaqtDmMImCtNU=
X-Google-Smtp-Source: AHgI3Ia39vAWwofp+SKZImbwpxIBNWMVYQTtQQURXtt8oBG7YaQPUGzWh172HmCsgaaO4qeCKQ3YxQ==
X-Received: by 2002:a17:902:9893:: with SMTP id s19mr9750250plp.165.1549855167336;
        Sun, 10 Feb 2019 19:19:27 -0800 (PST)
Received: from localhost.localdomain ([2601:644:8201:32e0:7256:81ff:febd:926d])
        by smtp.gmail.com with ESMTPSA id m67sm14997730pfm.73.2019.02.10.19.19.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Feb 2019 19:19:26 -0800 (PST)
Date:   Sun, 10 Feb 2019 19:19:23 -0800
From:   Eduardo Valentin <edubezval@gmail.com>
To:     pr-tracker-bot@kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Rui Zhang <rui.zhang@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] Thermal-SoC management fixes for v5.0-rc6
Message-ID: <20190211031921.GA1799@localhost.localdomain>
References: <20190210041721.GA2805@localhost.localdomain>
 <154977271617.2362.11794417398216386913.pr-tracker-bot@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154977271617.2362.11794417398216386913.pr-tracker-bot@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

Thanks for the note, but..

On Sun, Feb 10, 2019 at 04:25:16AM +0000, pr-tracker-bot@kernel.org wrote:
> The pull request you sent on Sat, 9 Feb 2019 20:17:23 -0800:
> 
> > git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal fixes
> 
> has been merged into torvalds/linux.git:
> https://git.kernel.org/torvalds/c/7ad915f5ebf5b9e7ca98a7048d8f84a631fe388b

I think the bot is off here because the above commit is about a merge
from the linux-omap tree from Tony.

7ad915f5ebf5 ("Merge tag 'omap-for-v3.10-rc1/fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap into fixes")

not the above pull. In fact, this pull was not merged so far, as per the log
of v5.0-rc6. I mean, this is a very late fixes pull anyways and I can always
resend the pull, but I believe the bot got confused this time.


> 
> Thank you!
> 
> -- 
> Deet-doot-dot, I am a bot.
> https://korg.wiki.kernel.org/userdoc/prtracker
