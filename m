Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754191AbeDJOs1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 10:48:27 -0400
Received: from mail-qt0-f171.google.com ([209.85.216.171]:34735 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753468AbeDJOs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 10:48:26 -0400
X-Google-Smtp-Source: AIpwx48FRm30oqsGgh94kRtMDjLB2zze7CjeLxGQhQtAbPUoDJHHOZQOIWMwizXTDJPHWxMYOenTTg==
From: Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date: Tue, 10 Apr 2018 10:48:19 -0400 (EDT)
X-X-Sender: vince@macbook-air
To: linux-kernel@vger.kernel.org
cc: Song Liu <songliubraving@fb.com>,
        Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org
Subject: perf: fuzzer leads to trace_kprobe: Could not insert message flood
Message-ID: <alpine.DEB.2.21.1804101043490.6068@macbook-air>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Author: Song Liu <songliubraving@fb.com>
Date:   Wed Dec 6 14:45:15 2017 -0800

When running the perf_fuzzer on a current git checkout my logs are flooded 
with messages such as this:
[71487.869077] trace_kprobe: Could not insert probe at unknown+0: -22
[71488.174479] trace_kprobe: Could not insert probe at unknown+0: -22

Presumably this is due to the introduction of the perf_kprobe PMU in
	commit e12f03d7031a977356e3d7b75a68c2185ff8d155
	Author: Song Liu <songliubraving@fb.com>
	Date:   Wed Dec 6 14:45:15 2017 -0800

Is there a way to get this error disabled, or else rate-limited?

Vince
