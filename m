Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9AFC282CE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 00:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 165432084E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 00:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549930399;
	bh=ho3Ei7gMR01hXBdNhxV6CjmsygEVGAxh7x2a0oDSvi0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qfAyynzZFptAc9M+g3/BtbLEz5fnn6lXNdpRvFDIkXDWGpDaL7VeknK3kk5ZuQbWW
	 3hFx9ONMYWm14ZWuIUfwT3SOeeeeHn5uKzJYmAb7lzkkmYcJpi0nT8qpVvrj4L9Q5x
	 v0YIgTAsGmKMmqTS8loYO/oOsPBER04ZS0yKRoXw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbfBLANR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 19:13:17 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:49929 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727737AbfBLANO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 19:13:14 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 17B8B22EFE;
        Mon, 11 Feb 2019 19:13:14 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 11 Feb 2019 19:13:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=0/IiYVbe08LKfkkZtbX2t34wGzdR6tyGpfwzJlxBdFw=; b=3ik+ZAA7
        RWfPVg62mCe6HTrgmyo33Gu7XAMJvftZAG1Ih674rXmGfTOWoycV4fVbYvO4ftcN
        gm473TeIcKcxV9XI9qcLR90AOiavoykndN1hkwd8DjOOoIoKz/SN7AhtvuryXw6p
        RHRk1Ceq1enIRf19UA/3A16d56pq7nAqkcpBrpZ4d5gbZ6WgfTXS87W+VTuOVBv9
        PcAi4mSXgEONSnnn1aRVkTNJxlyI3WSv6wlnJKqdZ0Wfpd4zcl4UsqQpdPIzrQ2S
        pUBFGB4pf+fewR3OlgFX0ox5o10bxa2CHdiZ5gnlvypZ2dN3ddMQch3cpHzKs2e2
        bK1HbvUwQBx0Lw==
X-ME-Sender: <xms:mQ9iXENsdYdEPV_39ZaUoGuQItGg70WwSKLSQYEnp8ydjn2b4mTmVQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledruddttddgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfquhhtnecuuegrihhlohhuthemucef
    tddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkof
    gjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhnucevrdcujfgrrhguihhn
    ghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkphepuddvgedrudejuddrvd
    efrdduheenucfrrghrrghmpehmrghilhhfrhhomhepthhosghinheskhgvrhhnvghlrdho
    rhhgnecuvehluhhsthgvrhfuihiivgepud
X-ME-Proxy: <xmx:mg9iXA_gyhVnEHtx7wzyfcOuaR3nfZlfw4mQ1C9sRW0-hy9CFTAq2w>
    <xmx:mg9iXFeKzbk9HoVlUgmQDH9UldPGb1y8TgdW_QPwr9D-TMmUrSXkvQ>
    <xmx:mg9iXAmRlhsJq-fY0NzGXcGnVlxdXN5eX-sMufR34FVULE1xWZKTEw>
    <xmx:mg9iXMvhtAmWBAGLXFduwX5qOMluYMnJzkNmrNtfcXgpCt8_b0qBkw>
Received: from eros.localdomain (124-171-23-15.dyn.iinet.net.au [124.171.23.15])
        by mail.messagingengine.com (Postfix) with ESMTPA id 01CDCE4438;
        Mon, 11 Feb 2019 19:13:11 -0500 (EST)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] tools/vm/slabinfo: Put options in alphabetic order
Date:   Tue, 12 Feb 2019 11:12:17 +1100
Message-Id: <20190212001219.27769-3-tobin@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212001219.27769-1-tobin@kernel.org>
References: <20190212001219.27769-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Primarily the usage message lists options in alphabetic order however
there are a bunch of the options that are not in alphabetic order.

Put options in alphabetic order.

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
Acked-by: Christoph Lameter <cl@linux.com>
---
 tools/vm/slabinfo.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/vm/slabinfo.c b/tools/vm/slabinfo.c
index d3908c50c87c..5119adb9d009 100644
--- a/tools/vm/slabinfo.c
+++ b/tools/vm/slabinfo.c
@@ -113,6 +113,7 @@ static void usage(void)
 		"slabinfo [-aADefhilnosrStTvz1LXBU] [N=K] [-dafzput] [slab-regexp]\n"
 		"-a|--aliases           Show aliases\n"
 		"-A|--activity          Most active slabs first\n"
+		"-B|--Bytes             Show size in bytes\n"
 		"-d<options>|--debug=<options> Set/Clear Debug options\n"
 		"-D|--display-active    Switch line format to activity\n"
 		"-e|--empty             Show empty slabs\n"
@@ -120,21 +121,21 @@ static void usage(void)
 		"-h|--help              Show usage information\n"
 		"-i|--inverted          Inverted list\n"
 		"-l|--slabs             Show slabs\n"
+		"-L|--Loss              Sort by loss\n"
 		"-n|--numa              Show NUMA information\n"
+		"-N|--lines=K           Show the first K slabs\n"
 		"-o|--ops		Show kmem_cache_ops\n"
-		"-s|--shrink            Shrink slabs\n"
 		"-r|--report		Detailed report on single slabs\n"
+		"-s|--shrink            Shrink slabs\n"
 		"-S|--Size              Sort by size\n"
 		"-t|--tracking          Show alloc/free information\n"
 		"-T|--Totals            Show summary information\n"
+		"-U|--Unreclaim		Show unreclaimable slabs only\n"
 		"-v|--validate          Validate slabs\n"
 		"-z|--zero              Include empty slabs\n"
 		"-1|--1ref              Single reference\n"
-		"-N|--lines=K           Show the first K slabs\n"
-		"-L|--Loss              Sort by loss\n"
 		"-X|--Xtotals           Show extended summary information\n"
-		"-B|--Bytes             Show size in bytes\n"
-		"-U|--Unreclaim		Show unreclaimable slabs only\n"
+
 		"\nValid debug options (FZPUT may be combined)\n"
 		"a / A          Switch on all debug options (=FZUP)\n"
 		"-              Switch off all debug options\n"
-- 
2.20.1

