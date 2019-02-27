Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A51C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 22:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA3D8218A4
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 22:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oZTe47Uc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730375AbfB0Wcq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 17:32:46 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36705 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728397AbfB0Wcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 17:32:45 -0500
Received: by mail-pf1-f196.google.com with SMTP id n22so8695476pfa.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 14:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WRV9mKFuM8QFsIzKl50EsC72M1HgmOdt/6BdHq+CUyE=;
        b=oZTe47UcPiHumB/0VQcU6FCgj3NkuSLCUwHQp/kYtPC0LXMsviC9lLp7LYoDwgyFTb
         zi6glxvLvJvpukLz/1G/ev3Oo64bWedHr5yNqlA3MQDe1gTYXtwqIjULTmtulKicKyRG
         S6ozhDfZQ7RafHNtfBOj/eZ1uJV7Tq70a+MdSTv8ZSJeutBPENEtcdHXzUkFCudsctv3
         ss2sOkZSxHNzzO7fqHhlxjqqzfotJwRo2JpgwONs4iFzBXLMijqiE1lfdFydEzuyNc6J
         NfjnkR8S8DbAPMNmMIiiWEWKJ3ofF4DfH/FDPF+OhK6p90NIAo+Z4VU00qkuHkZjqROE
         US8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WRV9mKFuM8QFsIzKl50EsC72M1HgmOdt/6BdHq+CUyE=;
        b=qQT3o9ahCAffbE8MCPP5eP4rekqltu9lpVpTnvkuYhEii9m1iFwWgo/W155j11tFPT
         zODqOPQVwdrP7BHzD0+QirVWZgyNo8062Pz3YzI5RJ/Jmmr7BcTlsXaSEnIaaY/iagP0
         4EOjcKftrz7O8reL1tNQTd9xX6yP7cZQBHsHyLblujSORcewqa0Gn5O4VS2Fj133pPf0
         s+aLRPgteD0gYiY6MIgGOZQqROmGQ7JaOwUHKahFt54V1wbl8Ga9Un5PIzwkZ4O9xOWN
         V3rhEP6oHw2xCpyZR6aKCwCp26uX7Pezf0ZXSKbqyBCag0f4HBYAsNTEBma4KsG+TrLh
         eFuA==
X-Gm-Message-State: APjAAAXmmd3LL+tUS/IG/cYAMFLIY8hU+TqjOu59dkgi7oSCONIuY+LV
        EIa3d3OCrEYqUOaUI0yMqKA=
X-Google-Smtp-Source: AHgI3IYeQW3t8Ioh4fwWO1QwvH+GG9FwiShpwT9pv/uS2cKSV6n/O0HWwkrKupL0IcTDeOXEnHXLXQ==
X-Received: by 2002:a63:b14d:: with SMTP id g13mr1371401pgp.270.1551306764628;
        Wed, 27 Feb 2019 14:32:44 -0800 (PST)
Received: from ast-mbp ([2620:10d:c090:200::3:25a5])
        by smtp.gmail.com with ESMTPSA id f87sm11280831pff.38.2019.02.27.14.32.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Feb 2019 14:32:43 -0800 (PST)
Date:   Wed, 27 Feb 2019 14:32:41 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Changbin Du <changbin.du@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Nadav Amit <namit@vmware.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 0/5] tracing/probes: uaccess: Add support user-space
 access
Message-ID: <20190227223239.x42tnefzwpbpkq3t@ast-mbp>
References: <155127853496.32576.3705994926675037747.stgit@devbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155127853496.32576.3705994926675037747.stgit@devbox>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 11:42:15PM +0900, Masami Hiramatsu wrote:
> 
> For perf-probe, we can add some attribute for each argument
> which indicate that the variable in user space. But still
> we can not decide it automatically by DWARF since __user attribute
> is not transrated to DWARF attribute.

clang has partial support for __attribute__((noderef, address_space(1)))
We'll work on patches to make it complete and pass __user attribute
all the way to debug info.

If somebody can work with gcc folks to do the same that would be awesome.

