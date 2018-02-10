Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753364AbeBJAiX (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 19:38:23 -0500
Received: from mga01.intel.com ([192.55.52.88]:46202 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753300AbeBJAiW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 19:38:22 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,486,1511856000";
   d="scan'208";a="202832219"
Subject: [PATCH v2 0/2] mm, smaps: MMUPageSize for device-dax
From: Dave Jiang <dave.jiang@intel.com>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org, dan.j.williams@intel.com,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        mhocko@kernel.org
Date: Fri, 09 Feb 2018 17:38:21 -0700
Message-ID: <151822289999.52376.4998780583577188804.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

>From Dan Williams:
Here is another occasion where we want special-case hugetlbfs enabling
to also apply to device-dax. I started to wonder what other hstate
conversions we might do beyond ->split() and ->pagesize(), but this
appears to be the last of the usages of hstate_vma() in
generic/non-hugetlbfs specific code paths.

v2:
I fixed up the powerpc build issue that Michal reported by restoring the
original location of the function and making the symbol weak.

---

Dan Williams (2):
      mm, hugetlbfs: introduce ->pagesize() to vm_operations_struct
      device-dax: implement ->pagesize() for smaps to report MMUPageSize


 arch/powerpc/mm/hugetlbpage.c |    5 +----
 drivers/dax/device.c          |   10 ++++++++++
 include/linux/mm.h            |    1 +
 mm/hugetlb.c                  |   23 ++++++++++++-----------
 4 files changed, 24 insertions(+), 15 deletions(-)

--
