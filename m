Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0823C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 20:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 926422184C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 20:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="JWrxhFw7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbfAWUfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 15:35:13 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:44774 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbfAWUfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 15:35:12 -0500
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 958A324E08E7;
        Wed, 23 Jan 2019 12:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1548275712; bh=g4XgkA4cBcQ2d9YDPsJLRxz08eNMX3SB4ubYnr6xZwQ=;
        h=From:To:CC:Subject:Date:From;
        b=JWrxhFw7IUSZ4Gx2GxVT5KLRUnzRif3GvaEXl0SkaREiyYijNemZ6vn6OyQCbtLj7
         b3WyfnA9gDoaJhUtwXHZ+JHIr1gd65ed23Bx39KPtFhoeUutQe+qPAk+fl/edDsTbe
         h/CI7T7/uuqXtbfq2xgMBczPUPWodjP7vRpS15A5l/rLgRV4oLdYRHRRJ1XY48XJvk
         CWhnqD30Yd0NeQphMCP7THMIhhM9PW0GAT7eHcPAD3S7FOqmNwqFEKpt4myVbW6aRV
         ajb30pwaaX3Sfy02URS3a1bGxFdBUL0LYnAEOHtuz2+aGGI8X9Ki2NVe8SnieZRPoh
         nIzLIm00VO5XQ==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2.internal.synopsys.com [10.12.239.237])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id EFFBBA0093;
        Wed, 23 Jan 2019 20:35:11 +0000 (UTC)
Received: from IN01WEHTCA.internal.synopsys.com (10.144.199.104) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 23 Jan 2019 12:33:17 -0800
Received: from IN01WEHTCB.internal.synopsys.com (10.144.199.105) by
 IN01WEHTCA.internal.synopsys.com (10.144.199.103) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 24 Jan 2019 02:03:18 +0530
Received: from vineetg-Latitude-E7450.internal.synopsys.com (10.10.161.70) by
 IN01WEHTCB.internal.synopsys.com (10.144.199.243) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 24 Jan 2019 02:03:15 +0530
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <linux-snps-arc@lists.infradead.org>, <linux-mm@kvack.org>,
        <peterz@infradead.org>, <mark.rutland@arm.com>,
        Vineet Gupta <vineet.gupta1@synopsys.com>
Subject: [PATCH v2 0/3] Replace opencoded set_mask_bits
Date:   Wed, 23 Jan 2019 12:33:01 -0800
Message-ID: <1548275584-18096-1-git-send-email-vgupta@synopsys.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.10.161.70]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Repost of [1] rebased on 5.0-rc3 + accumulated Acked-by/Reviewed-by.
No code changes since v1.

Please consider applying.

[1] http://lists.infradead.org/pipermail/linux-snps-arc/2019-January/005201.html

Thx,
-Vineet

Vineet Gupta (3):
  coredump: Replace opencoded set_mask_bits()
  fs: inode_set_flags() replace opencoded set_mask_bits()
  bitops.h: set_mask_bits() to return old value

 fs/exec.c              | 7 +------
 fs/inode.c             | 8 +-------
 include/linux/bitops.h | 2 +-
 3 files changed, 3 insertions(+), 14 deletions(-)

-- 
2.7.4

