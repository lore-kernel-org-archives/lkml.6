Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52174C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 15:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3B542175D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 15:46:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3B542175D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729234AbeHMS3i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 14:29:38 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46139 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728461AbeHMS3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 14:29:37 -0400
Received: by mail-wr1-f66.google.com with SMTP id h14-v6so14665249wrw.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 08:46:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tpxF+YCVx4pcXSjK6cOMV8Pg/1LfPISLwZpVtg2lpn4=;
        b=UY4pevrw+uKxHwg8OtJjmLbGOFnXQGiaFMjS7o+mNkz3/z26sdlkwm9fTu8ko8H4Ml
         BVm+iWmpAaVMBMIGkrTkisEWw8dL8qdO4uidSeJufJkloiOqAKlf/fi9iUr74aPN0YIW
         5z6QiQ46MYuXqABZBAHLnDkX43iFhfAkoIKfNxwXWZsZyqlR+tbHYnWugkphYzcRlC5W
         aQ8fm6W65PXHDjjhYV9MG+sRvnpfgbuG6GJpIaR0NKa3IP2aA4LjVD0w/ycOsChqWGAi
         R0jEo0JyzZSoEQuOKnoLXODew517XvhpUJ0JA/gSy3W4sXJAtkj6CENsJDVoJMUIh+w3
         Y4FQ==
X-Gm-Message-State: AOUpUlEaRgY3KF3fpgSX61RYpQskTrB9ePZ+X9/pYGFrolaSN4tBhijv
        eGTtuHnLzQSC/yqtEJ67vEY=
X-Google-Smtp-Source: AA+uWPweBoTo/kk1R8beOp7se6dQ5xmP0YhGVxa/8Hy4djRYt+F2EpqMfgImwAfYDxUT2KUj5Yvsbg==
X-Received: by 2002:adf:8466:: with SMTP id 93-v6mr10845221wrf.274.1534175209913;
        Mon, 13 Aug 2018 08:46:49 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id h7-v6sm17674737wrs.8.2018.08.13.08.46.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 08:46:49 -0700 (PDT)
Received: from d104.suse.de (nat.nue.novell.com [195.135.221.2])
        by techadventures.net (Postfix) with ESMTPA id 03D0512482A;
        Mon, 13 Aug 2018 17:46:47 +0200 (CEST)
From:   osalvador@techadventures.net
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, dan.j.williams@intel.com, jglisse@redhat.com,
        rafael@kernel.org, david@redhat.com, yasu.isimatu@gmail.com,
        logang@deltatee.com, dave.jiang@intel.com,
        Jonathan.Cameron@huawei.com, vbabka@suse.cz, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v2 0/3] Refactoring for remove_memory_section/unregister_mem_sect_under_nodes
Date:   Mon, 13 Aug 2018 17:46:36 +0200
Message-Id: <20180813154639.19454-1-osalvador@techadventures.net>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oscar Salvador <osalvador@suse.de>

This patchset does some cleanups and refactoring in the memory-hotplug code.

The first and the second patch are pretty straightforward, as they
only remove unused arguments/checks.

The third one refactors unregister_mem_sect_under_nodes.
This is needed to have a proper fallback in case we could not allocate
memory. (details can be seen in patch3).

Oscar Salvador (3):
  mm/memory-hotplug: Drop unused args from remove_memory_section
  mm/memory_hotplug: Drop mem_blk check from
    unregister_mem_sect_under_nodes
  mm/memory_hotplug: Refactor unregister_mem_sect_under_nodes

 drivers/base/memory.c |  5 ++---
 drivers/base/node.c   | 30 +++++++++++++++---------------
 include/linux/node.h  |  5 ++---
 3 files changed, 19 insertions(+), 21 deletions(-)

-- 
2.13.6

