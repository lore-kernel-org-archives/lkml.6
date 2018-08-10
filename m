Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FAE2C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 12:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD14822408
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 12:22:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="ohICQVfS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD14822408
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbeHJOwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 10:52:25 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:45723 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbeHJOwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 10:52:24 -0400
Received: by mail-qk0-f193.google.com with SMTP id c192-v6so6172321qkg.12
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 05:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=AdoxhlBj3rFH3dxzCCJRR9mwXTXoWCGHM9DrGub/UeA=;
        b=ohICQVfS7IQtTdvtChJAJ9CbLsxdVGKr55N5nz+PDWwkr5/iLfjQbMuSRYc9aS4V23
         bH17PWqE/1+LdEmT3eoegBUilRig1G0SYSjri9aaZUaaV3Vk3nKHgLIcyUkLHmIyIzkA
         LkRXivy3StrMeSJyzR6JA8eolOKwHCWlofLfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=AdoxhlBj3rFH3dxzCCJRR9mwXTXoWCGHM9DrGub/UeA=;
        b=dmyHolic7a7qm3owemWZMWM3XEo49D+LLKUmtgnhixFY5sk6kNuMPkLPgY4Somk0OG
         iNFOU8WMuRXwKHLZc8mR2ATwKP1H+asWojrpkR7FGp/HJpzP2aX6uwplF2MBdA82c1xq
         PD4GqjeiPddynEPkf5nZWBQu2ekZx5CkTaLrUW6tZYUN1HCtDryd1ZcYpH3C2PdZ0osO
         kzSksXszAfBzT6xuSfEvU4qZiXDvhRrRBniDq+jasndVcoSvaoYn2HrMwnReaTyfDJfi
         DVOgewsdK+5KZcAXYwLcWj6VqJ7ZnFMvaokv39jxhWH29CEIwMMNY/Ou3a36nPfLoiV+
         XrRw==
X-Gm-Message-State: AOUpUlGQp1Vr4027pV3rwaMgTUVCH3NnkeRRfYjC5YguNglJgm1Pij3I
        zXB5Adl84ij8cWa5VMQkGZz9oXdpirjSSpL+de2P+w==
X-Google-Smtp-Source: AA+uWPxPORsfvkxZM18YhRGfoUUrdZzMGPrdJjtp0o5JspKFUDKya+/o0jdkPGTbezt7dyYW+dK1Td6pc18uNo8UBhY=
X-Received: by 2002:ae9:f449:: with SMTP id z9-v6mr5750879qkl.410.1533903762709;
 Fri, 10 Aug 2018 05:22:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:aed:3442:0:0:0:0:0 with HTTP; Fri, 10 Aug 2018 05:22:42
 -0700 (PDT)
In-Reply-To: <20180809210654.622445925@goodmis.org>
References: <20180809210333.588854137@goodmis.org> <20180809210654.622445925@goodmis.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 10 Aug 2018 05:22:42 -0700
Message-ID: <CAEXW_YRShy=3yPOZvr3afpD6sJ4y=rdgC-FpxjQAT31KEqstOQ@mail.gmail.com>
Subject: Re: [for-next][PATCH 3/6] tracing: More reverting of "tracing:
 Centralize preemptirq tracepoints and unify their usage"
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joel Fernandes <joelaf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 9, 2018 at 2:03 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
>
> Joel Fernandes created a nice patch that cleaned up the duplicate hooks used
> by lockdep and irqsoff latency tracer. It made both use tracepoints. But the
> latency tracer is triggering warnings when using tracepoints to call into
> the latency tracer's routines. Mainly, they can be called from NMI context.
> If that happens, then the SRCU may not work properly because on some
> architectures, SRCU is not safe to be called in both NMI and non-NMI
> context.
>
> This is a partial revert of the clean up patch c3bc8fd637a9 ("tracing:
> Centralize preemptirq tracepoints and unify their usage") that adds back the
> direct calls into the latency tracer. It also only calls the trace events
> when not in NMI.
>
> Cc: Joel Fernandes <joelaf@google.com>
> Fixes: c3bc8fd637a9 ("tracing: Centralize preemptirq tracepoints and unify their usage")
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

- Joel
