Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE443C4161D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1435921104
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:53:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1435921104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730679AbeKUEXc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 23:23:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56380 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727182AbeKUEXb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 23:23:31 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 46539315485C;
        Tue, 20 Nov 2018 17:53:10 +0000 (UTC)
Received: from treble.redhat.com (ovpn-122-214.rdu2.redhat.com [10.10.122.214])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6763119C7F;
        Tue, 20 Nov 2018 17:53:09 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Artem Savkov <asavkov@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 0/2] objtool: Fixes in .cold detection logic
Date:   Tue, 20 Nov 2018 11:52:14 -0600
Message-Id: <cover.1542736240.git.jpoimboe@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Tue, 20 Nov 2018 17:53:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A couple of objtool fixes from Artem Savkov.  Fix a double-free in an
error path, and a seg fault seen with -ffunction-sections.

Artem Savkov (2):
  objtool: Fix double-free in .cold detection error path
  objtool: Fix seg fault in .cold detection with -ffunction-sections

 tools/objtool/elf.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

-- 
2.17.2

