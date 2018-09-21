Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C480ECE561
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 02:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E92521547
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 02:06:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E92521547
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388976AbeIUHw3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 03:52:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40336 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388699AbeIUHw3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 03:52:29 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 93B7CA6E16;
        Fri, 21 Sep 2018 02:05:59 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BE269601A4;
        Fri, 21 Sep 2018 02:05:55 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     mingo@kernel.org, tglx@linutronix.de, hpa@zytor.com
Cc:     linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com,
        x86@kernel.org, thgarnie@google.com, corbet@lwn.net,
        linux-doc@vger.kernel.org, peterz@infradead.org,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH 0/3] x86/mm/doc: Clean up mm.txt
Date:   Fri, 21 Sep 2018 10:05:47 +0800
Message-Id: <20180921020550.13095-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Fri, 21 Sep 2018 02:05:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This clean up is suggested by Ingo.

It firstly fix the confusions in mm layout tables by unifying
each memory region description in the consistent style.

Secondly take the KASLR words out of the mm layout tables to make
it as a separate section to only list mm layout in non-KASLR case.
Then add KASLR document at the end of mm.txt.

Meanwhile update document about KERNEL_IMAGE_SIZE in
arch/x86/include/asm/page_64_types.h .

Baoquan He (3):
  x86/KASLR: Update document about KERNEL_IMAGE_SIZE
  x86/mm/doc: Clean up the memory region layout descriptions
  x86/doc/kaslr.txt: Create a separate part of document abourt KASLR at
    the end of file

 Documentation/x86/x86_64/mm.txt      | 138 +++++++++++++++++++++++------------
 arch/x86/include/asm/page_64_types.h |   7 +-
 2 files changed, 96 insertions(+), 49 deletions(-)

-- 
2.13.6

