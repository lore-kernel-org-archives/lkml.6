Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id E8cTL9tHGVs4QAAAmS7hNA
	; Thu, 07 Jun 2018 14:57:36 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id AB89A608BF; Thu,  7 Jun 2018 14:57:34 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="k+gwBTU0"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 5DFE760915;
	Thu,  7 Jun 2018 14:57:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5DFE760915
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935091AbeFGO5b (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:57:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60216 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933342AbeFGO51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:57:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/Gq1QCDVL4+76GIPBTLbhp/hZ7serT4aZYPqq4pmEg4=; b=k+gwBTU0Rhh4hexwBpuSounjT
        MipYsm+lL3LK//THgKMXN3W319qvq6uSo928v9Aizp+GG6IdhHNIi8bWtynWtf/w2LEIeLQF6/xDc
        iQM6EQhtm93oWcoLHcE4jBwkrBA4hDEK0qgKgh1BO5B/02mfy4pqzz+Sh2DDa5gq2XJu1lsc44gXM
        Yuw1ttGiNHx2wuD2agqVGaaKEzILD1J9lIcxKT6o/JL5vEKf+PkQ6zKZDUn8n30dvNCJmBWOBtPqw
        HL9oUEJQJj7WtHEhNxl9DXB8ckhqZ7ajVt+jZR/OaSMx8iHao/5I7fUM6bKMGNnFPqtoNlviHQHg8
        U8Oe/2AKA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fQwLs-0005tf-4q; Thu, 07 Jun 2018 14:57:24 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Kees Cook <keescook@chromium.org>
Cc: Matthew Wilcox <mawilcox@microsoft.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: [PATCH 0/6] More conversions to struct_size
Date: Thu,  7 Jun 2018 07:57:14 -0700
Message-Id: <20180607145720.22590-1-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Wilcox <mawilcox@microsoft.com>

Hi Kees,

Here are some patches which I had in my tree as demonstrations of
converting code to use kvzalloc_struct.  I've ported them to use
struct_size instead, since these spots weren't caught by your coccinelle
scripts.  Some of them are far too manual to have ever been doable by
a tool.  Maybe some of them will inspire more automated fixes though.

Matthew Wilcox (6):
  Convert virtio_console to struct_size
  Convert infiniband uverbs to struct_size
  Convert v4l2 event to struct_size
  Convert vhost to struct_size
  Convert jffs2 acl to struct_size
  Convert intel uncore to struct_size

 arch/x86/events/intel/uncore.c       | 19 ++++++++++---------
 drivers/char/virtio_console.c        |  3 +--
 drivers/infiniband/core/uverbs_cmd.c |  4 ++--
 drivers/media/v4l2-core/v4l2-event.c |  3 +--
 drivers/vhost/vhost.c                |  3 ++-
 fs/jffs2/acl.c                       |  3 ++-
 fs/jffs2/acl.h                       |  1 +
 include/rdma/ib_verbs.h              |  5 +----
 8 files changed, 20 insertions(+), 21 deletions(-)

-- 
2.17.0
