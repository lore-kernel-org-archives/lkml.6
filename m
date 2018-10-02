Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5422C004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 08:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 895A42089C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 08:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pEeuvuzd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 895A42089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbeJBO7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 10:59:02 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37805 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbeJBO7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 10:59:01 -0400
Received: by mail-pl1-f193.google.com with SMTP id az3-v6so516828plb.4;
        Tue, 02 Oct 2018 01:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=r9c0v6k5yYT3ldRRauxDANN9klpUOh7jyIlXr5bZ5j4=;
        b=pEeuvuzdZEBLx5yPXCSxgQ3jrshhAmwzryfiKpQzHU75uo5OoE8SDg7+A6/0XuaH0z
         SJJsTRgX4rcMXJPECloSiF0cmaIRHAEqzH2EOZvdxW22oxUwjX+jvEVj8rr4x/75GK3a
         /HmH1iTe9nlUfzjw0yNuSDY/iwVxSRxhguqjBX08mV/DDx+gk3s7bJeXXjA6ZBE3R2O6
         fK/fphqAfqAmGo2ZoYqNL1Fx+Gnw0Bpl0veaBnyWjP1KhjlhCDRQsaBD/P2Rs8WOlApl
         9rnoPNq1fkhZZFgg1BfAi12Th1KcxbJzH58P4DFt2EyCg+GmgSj8MdkQVcD40byPTiGb
         0dFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r9c0v6k5yYT3ldRRauxDANN9klpUOh7jyIlXr5bZ5j4=;
        b=qjAQHCEhobdrPHSmtehFMwoj8qO0VblXTd565SZ3ZNie6bETkX00NDhflVjbcERyl2
         b6GmmkGAWI7ILb2EE/VIC2+8zB3lWFAAUtkjcC/jXYd2rWrYGftN+r3FAIlYM6nA5DQL
         DO1HkEO721wTBhvhrZ/VHIKndDLAuzWntnp5uMrF40u4CQNwa/ptDwrIkJ5odPNOGIEC
         OB5q4vAIh6KkiKExdXT2feZQcv1mTLnK0DaorU8kRMBJG4Tm1S1YhLLcsR1vockkqhYH
         ozh7EiJbqEhh0RPD3ddZsodnRhgL+kdaSPCHcvJeGEGcTRzzvB1Oim1ddPDp+Mk59QDa
         5t2w==
X-Gm-Message-State: ABuFfogwWB3F9zaSpGhc70iaRd5d7h4Y8HIztsyUv6Tl6nmKMFsRiHFX
        L1PN40ScslFG1BrZ4kmb7qw=
X-Google-Smtp-Source: ACcGV62lUJT55kRqXlBHmLMhoVO4qgiI02vYuGYvMjMNkVzPbikIps85XFpLTvO4vKKdqdDF7fFDXA==
X-Received: by 2002:a62:c40f:: with SMTP id y15-v6mr15272213pff.161.1538468219012;
        Tue, 02 Oct 2018 01:16:59 -0700 (PDT)
Received: from localhost ([39.7.19.27])
        by smtp.gmail.com with ESMTPSA id s14-v6sm16944915pgv.29.2018.10.02.01.16.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Oct 2018 01:16:57 -0700 (PDT)
Date:   Tue, 2 Oct 2018 17:16:53 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Daniel Wang <wonderfly@google.com>
Cc:     stable@vger.kernel.org, pmladek@suse.com,
        Alexander.Levin@microsoft.com, akpm@linux-foundation.org,
        byungchul.park@lge.com, dave.hansen@intel.com, hannes@cmpxchg.org,
        jack@suse.cz, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mathieu.desnoyers@efficios.com, mgorman@suse.de, mhocko@kernel.org,
        pavel@ucw.cz, penguin-kernel@i-love.sakura.ne.jp,
        peterz@infradead.org, rostedt@goodmis.org, tj@kernel.org,
        torvalds@linux-foundation.org, vbabka@suse.cz,
        xiyou.wangcong@gmail.com, pfeiner@google.com
Subject: Re: 4.14 backport request for dbdda842fe96f: "printk: Add console
 owner and waiter logic to load balance console writes"
Message-ID: <20181002081653.GJ598@jagdpanzerIV>
References: <20180927194601.207765-1-wonderfly@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180927194601.207765-1-wonderfly@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (09/27/18 12:46), Daniel Wang wrote:
> Prior to this change, the combination of `softlockup_panic=1` and
> `softlockup_all_cpu_stacktrace=1` may result in a deadlock when the reboot path
> is trying to grab the console lock that is held by the stack trace printing
> path. What seems to be happening is that while there are multiple CPUs, only one
> of them is tasked to print the back trace of all CPUs. On a machine with many
> CPUs and a slow serial console (on Google Compute Engine for example), the stack
> trace printing routine hits a timeout and the reboot path kicks in. The latter
> then tries to print something else, but can't get the lock because it's still
> held by earlier printing path.

Sorry, I'm missing something here. Steven's patch deals with lockups and
I understand why you want to backport the patch set; but console output
deadlock on panic() is another thing.

You said
	"then tries to print something else, but can't get the lock
	 because it's still held by earlier printing path"

Can't get which of the locks?

	-ss
