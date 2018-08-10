Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF60C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 15:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 145B3223C6
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 15:29:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 145B3223C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbeHJR74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 13:59:56 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34719 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727381AbeHJR74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 13:59:56 -0400
Received: by mail-wr1-f68.google.com with SMTP id c13-v6so8690196wrt.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 08:29:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tZ2pUXudqHMvttxTFUUXp2FL75BvT7A1xx18lfkERkQ=;
        b=cS+q5rTnL24MdctK541sphjpKaaEyLth/JM0YctWqDZT/cQ5jpk6lgOLaRE1OJWn6m
         HtrkkrvfYMsgnSiosseirGd6dAgIlm2Dr5dmjTDcxpDYR+xqSUe52E12vPot6ZiQI05s
         5mvSMIxAlezVQ2f2yDWek6MLbQy2XPRU+ORyM601oh20rO3au5gaj9hUbERCQpY/opIz
         AJF42vY9K/rr2kPv9aKhf+fwtrEd2+HW8EBsDCv0b6RNTmxwWXaAWWWnrRFMoSMnq9sX
         ReEZP26aLSQHPbUAVID7zSZytfjpzWX5W85laQS9qNneebRafy9o4D7Qx2Z7plinR1sN
         rGIQ==
X-Gm-Message-State: AOUpUlGZhX7IEL6ZIMgLqT91LtuSapHnqDjr/RxJ0iFcC37dlak0vQyQ
        XGpV09gYR5UNkhLaOf73dag=
X-Google-Smtp-Source: AA+uWPygCq5sUV7Ow93YgVQ3Pg6z0f6w0Xlg+RxKpr0y9pyn7LltkOoMXTDnIO1CPx94jSmVOD/z4A==
X-Received: by 2002:adf:e190:: with SMTP id k16-v6mr4618527wri.36.1533914975383;
        Fri, 10 Aug 2018 08:29:35 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id j9-v6sm10863026wrv.5.2018.08.10.08.29.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 08:29:34 -0700 (PDT)
Received: from d104.suse.de (charybdis-ext.suse.de [195.135.221.2])
        by techadventures.net (Postfix) with ESMTPA id B37721247F5;
        Fri, 10 Aug 2018 17:29:33 +0200 (CEST)
From:   osalvador@techadventures.net
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, vbabka@suse.cz, dan.j.williams@intel.com,
        yasu.isimatu@gmail.com, jonathan.cameron@huawei.com,
        david@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH 0/3] Refactor/cleanup for remove_memory_section/unregister_mem_sect_under_nodes
Date:   Fri, 10 Aug 2018 17:29:28 +0200
Message-Id: <20180810152931.23004-1-osalvador@techadventures.net>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oscar Salvador <osalvador@suse.de>

This patchset is about cleaning up/refactoring a few functions
from the memory-hotplug code.

The first and the second patch are pretty straightforward, as they
only remove unused arguments/checks.
The third one change the layout of the unregister_mem_sect_under_nodes a bit.

Oscar Salvador (3):
  mm/memory_hotplug: Drop unused args from remove_memory_section
  mm/memory_hotplug: Drop unneeded check from
    unregister_mem_sect_under_nodes
  mm/memory_hotplug: Cleanup unregister_mem_sect_under_nodes

 drivers/base/memory.c |  5 ++---
 drivers/base/node.c   | 34 +++++++++++-----------------------
 2 files changed, 13 insertions(+), 26 deletions(-)

-- 
2.13.6

