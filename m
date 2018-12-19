Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 418B5C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 17:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AE90218C3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 17:17:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729223AbeLSRRY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 12:17:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51516 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726555AbeLSRRY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 12:17:24 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 553067F410;
        Wed, 19 Dec 2018 17:17:24 +0000 (UTC)
Received: from redhat.com (null.msp.redhat.com [10.15.80.136])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0EDD2282FA;
        Wed, 19 Dec 2018 17:17:23 +0000 (UTC)
Date:   Wed, 19 Dec 2018 11:17:22 -0600
From:   David Teigland <teigland@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] dlm updates for 4.21
Message-ID: <20181219171722.GA14517@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Wed, 19 Dec 2018 17:17:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull dlm updates from tag:

git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-4.21

This set is entirely trivial fixes, mainly around correct cleanup
on error paths and improved error checks.  One patch adds scheduling
in a potentially long recovery loop.

Thanks,
Dave

Bob Peterson (1):
      dlm: Don't swamp the CPU with callbacks queued during recovery

David Teigland (2):
      dlm: fix missing idr_destroy for recover_idr
      dlm: fix invalid cluster name warning

Denis V. Lunev (1):
      dlm: fix possible call to kfree() for non-initialized pointer

Thomas Meyer (1):
      dlm: NULL check before some freeing functions is not needed

Tycho Andersen (3):
      dlm: fix invalid free
      dlm: don't allow zero length names
      dlm: don't leak kernel pointer to userspace

Vasily Averin (4):
      dlm: fixed memory leaks after failed ls_remove_names allocation
      dlm: possible memory leak on error path in create_lkb()
      dlm: lost put_lkb on error path in receive_convert() and receive_unlock()
      dlm: memory leaks on error path in dlm_user_request()

Wen Yang (1):
      dlm: NULL check before kmem_cache_destroy is not needed

 fs/dlm/ast.c       | 10 ++++++++++
 fs/dlm/lock.c      | 17 ++++++++++-------
 fs/dlm/lockspace.c |  9 ++++-----
 fs/dlm/member.c    |  7 ++++---
 fs/dlm/memory.c    |  9 +++------
 fs/dlm/user.c      |  5 +++--
 6 files changed, 34 insertions(+), 23 deletions(-)

