Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E3A7C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 19:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 633D32084E
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 19:47:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 633D32084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwn.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbeKZGjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 01:39:22 -0500
Received: from ms.lwn.net ([45.79.88.28]:57918 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725863AbeKZGjW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 01:39:22 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 7FD2497E;
        Sun, 25 Nov 2018 19:47:33 +0000 (UTC)
Date:   Sun, 25 Nov 2018 12:47:32 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Tvrtko Ursulin <tursulin@ursulin.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] Documentation/admin-guide: introduce
 perf-security.rst file
Message-ID: <20181125124732.6c1807de@lwn.net>
In-Reply-To: <4d95341d-d1f4-fc48-f173-a6fedfc70d33@linux.intel.com>
References: <259a9cd2-5c56-4f8d-57c4-cabaeaa774bc@linux.intel.com>
        <4d95341d-d1f4-fc48-f173-a6fedfc70d33@linux.intel.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Nov 2018 12:14:14 +0300
Alexey Budankov <alexey.budankov@linux.intel.com> wrote:

> +For the purpose of performing security checks Linux implementation splits
> +processes into two categories [6]_ : a) privileged processes (whose effective
> +user ID is 0, referred to as superuser or root), and b) unprivileged processes
> +(whose effective UID is nonzero).

Is that really what's going on here?  If I understand things correctly,
it's looking for CAP_SYS_PTRACE rather than a specific UID; am I missing
something here?

(Also, you would want "*the* Linux implementation" in the first sentence
above).

One other thing:

> +(whose effective UID is nonzero). Privileged processes bypass all kernel
> +security permission checks so perf_events performance monitoring is fully
> +available to privileged processes without *access*, *scope* and *resource*
> +restrictions.

Could I ask for a slight toning down of the markup here?  There's a lot of
*emphasis* here that isn't really needed and tends to get in the way.

Thanks,

jon
