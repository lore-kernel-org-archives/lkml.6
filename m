Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E9ACC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 00:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6519206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 00:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="NWvzfKHn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbfAKA0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 19:26:41 -0500
Received: from smtprelay.synopsys.com ([198.182.60.111]:46888 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727634AbfAKA0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 19:26:41 -0500
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 2B5A610C06EF;
        Thu, 10 Jan 2019 16:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1547166401; bh=KGZ9OeLmlgo9sWjwCllJ2JfHatcqtBn7FO/ruNLVtd4=;
        h=From:To:CC:Subject:Date:From;
        b=NWvzfKHn4SzWSknpom+EaJ5nNKhfSjQWlUeCLMYRvImFBJlX3lVnn0EBHW1zy9m9l
         zJBh2DKWqssQWl1c/17HGNlQ2l4p2zYOTBXL90Lfbh8Xq335xYPEA8cKyIlBZcjYw4
         7QQ5qsci411q9R2mUrVC8ePZdOz5JR2nfHRSXZ5N1j+UcJDqJb65t1u7OzsKGGJ/23
         8O3Jn7IvrZcswpdoe9YfVR+YstVVTwpeLHbFufr9o4JU57tTBbQ2fbSaZ8oPAyvpoG
         qCTiOCewVXluJDWQtCzGlcwGZEl3F/l3/gsNC0Ng0I0aMPG6scawDPh2GCiAnoLWwC
         p4PtqiZgmdacw==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        by mailhost.synopsys.com (Postfix) with ESMTP id 192A43993;
        Thu, 10 Jan 2019 16:26:41 -0800 (PST)
Received: from IN01WEHTCA.internal.synopsys.com (10.144.199.104) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 10 Jan 2019 16:26:40 -0800
Received: from IN01WEHTCB.internal.synopsys.com (10.144.199.105) by
 IN01WEHTCA.internal.synopsys.com (10.144.199.103) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 11 Jan 2019 05:56:39 +0530
Received: from vineetg-Latitude-E7450.internal.synopsys.com (10.10.161.70) by
 IN01WEHTCB.internal.synopsys.com (10.144.199.243) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 11 Jan 2019 05:56:40 +0530
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <linux-snps-arc@lists.infradead.org>, <linux-mm@kvack.org>,
        <peterz@infradead.org>, Vineet Gupta <vineet.gupta1@synopsys.com>
Subject: [PATCH 0/3] Replace opencoded set_mask_bits
Date:   Thu, 10 Jan 2019 16:26:24 -0800
Message-ID: <1547166387-19785-1-git-send-email-vgupta@synopsys.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.10.161.70]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I did these a while back and forget. Rebased to 5.0-rc1.
Please consider applying.

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

