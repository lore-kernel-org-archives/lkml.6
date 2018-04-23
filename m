Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755902AbeDWQaN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 12:30:13 -0400
Received: from merlin.infradead.org ([205.233.59.134]:53892 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755600AbeDWQ3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 12:29:37 -0400
Message-Id: <20180423161648.622657048@infradead.org>
User-Agent: quilt/0.63-1
Date: Mon, 23 Apr 2018 18:16:48 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org,
        diego.viola@gmail.com, len.brown@intel.com, rjw@rjwysocki.net,
        rui.zhang@intel.com
Subject: [PATCH 0/5] Various tsc/clocksource fixes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches are the result of the regression Diego reported against commit:

  aa83c45762a2 ("x86/tsc: Introduce early tsc clocksource")

His Core2 triggers mark_tsc_unstable() while we're running with tsc-early,
which then results in us failing to unregister the clocksource.

Furthermore, since mark_tsc_unstable() only looks at the regular tsc
clocksource, we don't even mark tsc_early UNSTABLE or de-rate it, resulting in
it actually staying a desirable clocksource.

Fixing that is a little more tricky; albeit far less critical after we
guarantee to unregister tsc-early.

Please consider these for /urgent. I've used both Fixes and stable tags
on a bunch of them because the above commit is already in v4.16 and
would need stable help.
