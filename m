Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032535AbeE0BGq (ORCPT <rfc822;w@1wt.eu>);
        Sat, 26 May 2018 21:06:46 -0400
Received: from mga17.intel.com ([192.55.52.151]:12722 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751103AbeE0BGp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 May 2018 21:06:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,446,1520924400";
   d="scan'208";a="59350730"
Subject: [PATCH 0/2] x86/numa_emulation: Introduce uniform split capability
From: Dan Williams <dan.j.williams@intel.com>
To: mingo@kernel.org
Cc: Wei Yang <richard.weiyang@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        David Rientjes <rientjes@google.com>, Ingo Molnar <mingo@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, x86@kernel.org
Date: Sat, 26 May 2018 17:56:47 -0700
Message-ID: <152738260746.11641.13275998345345705617.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current numa emulation capabilities for splitting System RAM by a
fixed size or by a set number of nodes may result in some nodes being
larger than others. The implementation prioritizes establishing a
minimum usable memory size over satisfying the requested number of numa
nodes.
    
Introduce a uniform split capability that evenly partitions each
physical numa node into N emulated nodes. For example numa=fake=3U
creates 6 emulated nodes total on a system that has 2 physical nodes.

This capability is useful for debugging and evaluating platform
memory-side-cache capabilities as described by the ACPI HMAT (see
5.2.27.5 Memory Side Cache Information Structure in ACPI 6.2a)
 
See more details in patch2.

---

Dan Williams (2):
      x86/numa_emulation: Fix emulated-to-physical node mapping
      x86/numa_emulation: Introduce uniform split capability


 Documentation/x86/x86_64/boot-options.txt |    4 +
 arch/x86/mm/numa_emulation.c              |   98 +++++++++++++++++++++++------
 2 files changed, 82 insertions(+), 20 deletions(-)
