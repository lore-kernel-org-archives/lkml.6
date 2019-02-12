Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E60C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 00:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80D932084E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 00:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549930404;
	bh=DFKyiK4KDmShgNLTZ+xJX9y8GpIoASXixZYXIHtvDjk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wS2o3GMLLdEbqTUqwwRCO7sZ5+2KzwjLHPmVyOxQJq9gG2iEWdYSN+wb2J+GOoAEP
	 WpUvXIJUxIL8w4vbUc3XGiNv8APWuZYutJPkkQlycHKMIt6MZIlR1WJSJ4NIrwLYfl
	 4Ndj53BpM+GxB9dIlBd6XTk6W/EqJznZK9C7+gDI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbfBLANX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 19:13:23 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:38829 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727947AbfBLANV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 19:13:21 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 0B13D23087;
        Mon, 11 Feb 2019 19:13:20 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 11 Feb 2019 19:13:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=cPKBJNZQCgPqw/8JHAVck3mRTEXN2P5xG79ahOFXmac=; b=Lcxx/u1g
        AgwXH6L3zAsWpbV9tAnjTAPNmmzyKl3PpqgW1eU87JElspa4T9cls7xyPL6OyNzG
        9YZaBE2D6+pJn2WnJA9L4qjVxlhexFnmUPDBeNKOKcSpTfCwogKk5vyoRXqNEaOs
        WAT8jFkd5Rfz8O7UYCf5XZMa9XUULwf3Rt7tB4RE1/n8Dsi4pQ1Y4sucE9SbxXre
        pj3HFOKmnrtWKwLjRSvvfqG3wYFP43LQT5s9a3/38/e0Ja80iPPSar85CQYIYHnb
        EW9en0jqkTLn79i3oTvkHurCV7CCRPjMFWL+87HvHOQ4pDs5WFKHFucUZzcrFq+e
        6y9UT5mktKgybg==
X-ME-Sender: <xms:nw9iXBUPutPEEMOQTQ4QA-NLuVUgjOnPaPnOv-8msfZHjo1P52rRWg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledruddttddgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfquhhtnecuuegrihhlohhuthemucef
    tddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkof
    gjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhnucevrdcujfgrrhguihhn
    ghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkphepuddvgedrudejuddrvd
    efrdduheenucfrrghrrghmpehmrghilhhfrhhomhepthhosghinheskhgvrhhnvghlrdho
    rhhgnecuvehluhhsthgvrhfuihiivgepud
X-ME-Proxy: <xmx:nw9iXMf-Wx_Cw4aUphkkxbR9tT_06sQStvj4oSYl2-GBVlaJZ7eZ4A>
    <xmx:nw9iXARhapRoOITp-puX89Rpwz4m2b1xwHiBfjk84PwOZ7Tf9o8Pxg>
    <xmx:nw9iXOCbxnYEB0D_gfYpgVUlwGK-QsclQHli6GNOamT9lfgGWegHSg>
    <xmx:oA9iXHTr_68LnBqebLr62iYlANqA8UqY9F8b-kRkneFA9MZzBDwjtA>
Received: from eros.localdomain (124-171-23-15.dyn.iinet.net.au [124.171.23.15])
        by mail.messagingengine.com (Postfix) with ESMTPA id BA9E8E4438;
        Mon, 11 Feb 2019 19:13:17 -0500 (EST)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] tools/vm/slabinfo: Clean up usage menu debug items
Date:   Tue, 12 Feb 2019 11:12:19 +1100
Message-Id: <20190212001219.27769-5-tobin@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212001219.27769-1-tobin@kernel.org>
References: <20190212001219.27769-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Attempt to make the usage comment for debug options a little cleaner.

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
Acked-by: Christoph Lameter <cl@linux.com>
---
 tools/vm/slabinfo.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/tools/vm/slabinfo.c b/tools/vm/slabinfo.c
index 97715b73af70..73818f1b2ef8 100644
--- a/tools/vm/slabinfo.c
+++ b/tools/vm/slabinfo.c
@@ -114,7 +114,6 @@ static void usage(void)
 		"-a|--aliases           Show aliases\n"
 		"-A|--activity          Most active slabs first\n"
 		"-B|--Bytes             Show size in bytes\n"
-		"-d<options>|--debug=<options> Set/Clear Debug options\n"
 		"-D|--display-active    Switch line format to activity\n"
 		"-e|--empty             Show empty slabs\n"
 		"-f|--first-alias       Show first alias\n"
@@ -136,14 +135,17 @@ static void usage(void)
 		"-1|--1ref              Single reference\n"
 		"-X|--Xtotals           Show extended summary information\n"
 
-		"\nValid debug options (FZPUT may be combined)\n"
-		"a / A          Switch on all debug options (=FZUP)\n"
-		"-              Switch off all debug options\n"
-		"f / F          Sanity Checks (SLAB_CONSISTENCY_CHECKS)\n"
-		"z / Z          Redzoning\n"
-		"p / P          Poisoning\n"
-		"u / U          Tracking\n"
-		"t / T          Tracing\n"
+		"\n"
+		"-d  | --debug          Switch off all debug options\n"
+		"-da | --debug=a        Switch on all debug options (--debug=FZPU)\n"
+
+		"\n"
+		"-d[afzput] | --debug=[afzput]\n"
+		"    f | F              Sanity Checks (SLAB_CONSISTENCY_CHECKS)\n"
+		"    z | Z              Redzoning\n"
+		"    p | P              Poisoning\n"
+		"    u | U              Tracking\n"
+		"    t | T              Tracing\n"
 	);
 }
 
-- 
2.20.1

