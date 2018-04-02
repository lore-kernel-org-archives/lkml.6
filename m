Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754720AbeDBXY7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 19:24:59 -0400
Received: from mga14.intel.com ([192.55.52.115]:12018 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754550AbeDBXY6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 19:24:58 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,397,1517904000";
   d="scan'208";a="44366682"
Date: Mon, 2 Apr 2018 16:24:49 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Mel Gorman <mgorman@techsingularity.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Ingo Molnar <mingo@kernel.org>, Norbert Manthey <nmanthey@amazon.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: v4.16+ seeing many unaligned access in dequeue_task_fair() on IA64
Message-ID: <20180402232448.fbop7k5xicblski5@agluck-desk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v4.16 boots cleanly. But with the first bunch of merges
(Linus HEAD = 46e0d28bdb8e6d00e27a0fe9e1d15df6098f0ffb)
I see a bunch of:

ia64_handle_unaligned: 4863 callbacks suppressed
kernel unaligned access to 0xe00000031660fd74, ip=0xa0000001000f23e0
kernel unaligned access to 0xe00000033bdffbcc, ip=0xa0000001000f2370
kernel unaligned access to 0xe00000031660fd74, ip=0xa0000001000f23e0
kernel unaligned access to 0xe00000033bdffbcc, ip=0xa0000001000f2370
kernel unaligned access to 0xe00000031660fd74, ip=0xa0000001000f23e0

The addresses are all 4-byte, but not 8-byte aligned.

Any guesses before I start to bisect?

-Tony
