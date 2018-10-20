Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A644DC67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 17:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78B7421533
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 17:47:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78B7421533
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jjacky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbeJUB6U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 21:58:20 -0400
Received: from mail.jjacky.com ([23.29.69.116]:57419 "EHLO mail.jjacky.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727735AbeJUB6U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 21:58:20 -0400
X-Greylist: delayed 392 seconds by postgrey-1.27 at vger.kernel.org; Sat, 20 Oct 2018 21:58:16 EDT
Received: by mail.jjacky.com (OpenSMTPD) with ESMTP id 1deeddaa;
        Sat, 20 Oct 2018 17:40:26 +0000 (UTC)
From:   Olivier Brunel <jjk@jjacky.com>
To:     Network Development <netdev@vger.kernel.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        linux-kernel@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Olivier Brunel <jjk@jjacky.com>
Subject: [PATCH 2/2] net: bpfilter: Set user mode helper's command line
Date:   Sat, 20 Oct 2018 19:39:57 +0200
Message-Id: <20181020173957.31239-3-jjk@jjacky.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181020173957.31239-1-jjk@jjacky.com>
References: <20180826180816.04ef7d16@jjacky.com> <20180827183122.0b4ac65e@jjacky.com> <20180828033500.g3siwst5h2ckewwb@ast-mbp> <20180905175243.78a6ba81@jjacky.com> <CAADnVQ+xFfwV67BRXD0epoTwKz54W3mcYHXVWBd1iWb94p+zpg@mail.gmail.com>
 <20181020173957.31239-1-jjk@jjacky.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Olivier Brunel <jjk@jjacky.com>
---
 net/bpfilter/bpfilter_kern.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bpfilter/bpfilter_kern.c b/net/bpfilter/bpfilter_kern.c
index 94e88f510..7acfc8308 100644
--- a/net/bpfilter/bpfilter_kern.c
+++ b/net/bpfilter/bpfilter_kern.c
@@ -92,6 +92,7 @@ static int __init load_umh(void)
 	int err;
 
 	/* fork usermode process */
+	info.cmdline = "bpfilter_umh";
 	err = fork_usermode_blob(&bpfilter_umh_start,
 				 &bpfilter_umh_end - &bpfilter_umh_start,
 				 &info);
-- 
2.19.0

