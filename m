Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F74C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 13:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C8E020870
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 13:48:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C8E020870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729357AbeKTAMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 19:12:19 -0500
Received: from mga03.intel.com ([134.134.136.65]:32280 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726189AbeKTAMS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 19:12:18 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Nov 2018 05:48:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,252,1539673200"; 
   d="scan'208";a="87075891"
Received: from aaronlu.sh.intel.com ([10.239.159.44])
  by fmsmga007.fm.intel.com with ESMTP; 19 Nov 2018 05:48:34 -0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?Pawe=C5=82=20Staszewski?= <pstaszewski@itcare.pl>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Yoel Caspersen <yoel@kviknet.dk>,
        Mel Gorman <mgorman@techsingularity.net>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Ian Kumlien <ian.kumlien@gmail.com>
Subject: [PATCH RESEND 0/2] free order-0 pages through PCP in page_frag_free() and cleanup
Date:   Mon, 19 Nov 2018 21:48:32 +0800
Message-Id: <20181119134834.17765-1-aaron.lu@intel.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a resend of the two patches.

Patch 1 is the same as:
[PATCH v2 1/2] mm/page_alloc: free order-0 pages through PCP in page_frag_free()
https://lkml.kernel.org/r/20181106052833.GC6203@intel.com
With one more ack from Tariq Toukan.

Patch 2 is the same as:
[PATCH v3 2/2] mm/page_alloc: use a single function to free page
https://lkml.kernel.org/r/20181106113149.GC24198@intel.com
With some changelog rewording.

Applies on top of v4.20-rc2-mmotm-2018-11-16-14-52.

Aaron Lu (2):
  mm/page_alloc: free order-0 pages through PCP in page_frag_free()
  mm/page_alloc: use a single function to free page

 mm/page_alloc.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

-- 
2.17.2

