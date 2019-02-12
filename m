Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE90C282CE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 00:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15C762084E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 00:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549930401;
	bh=U7Ui8oKUg6rAwYS7qcT2qi9HQV1czSH0004lG831VXQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Iw6gHa6TKFaC8ndjIKe/spbpW7cZ8A7mV/tGKx23vSZi3stxEuHzhbPeOCKzjcpGd
	 +96h6JPFj62baeUbla6MUP4crxtlk1jcWP4OnEoU2PObQlIot6emk46Eae8LFRA3D3
	 57huEDNanQJrHBOJfBzmMfGZP+EOmxvYA+6QSXmo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbfBLANT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 19:13:19 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:56889 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727947AbfBLANS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 19:13:18 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 0B63922EFE;
        Mon, 11 Feb 2019 19:13:17 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 11 Feb 2019 19:13:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=WEHpxNhXuKHtjgMSBgFwXXvDIahNCEewFbe9A9ToP+c=; b=KoDPUuFo
        l5qHkFPK/x/t7FMIckFIIMeultvuEqAeSlhnIihWKCKZHxaB03nAHFoJNY5omQZ7
        7RHnkQL+kNa4AxAAZ1zuHJCj4nglBLSNJ6PaqvWFk4TirbD9xPlIXMoZzj2RsOiB
        yFNt7d8M1xCkY2/IGxsbD5FlR+NCAP9slNeLAvIpCZ958bkOvzHghZCSqG7RUzgd
        1Q7uaZ3+lLj1N90mirEw9uH4TiucL6nTVcVYlQmsjqgBi0zTQyHV44XYDqIlnelG
        Kq1aSqlSweNwR0S9nGTe64mtHPpNzXES05/21uBGp+woOz03Grup6kyANY9aij7d
        a+T+hqunlsBBww==
X-ME-Sender: <xms:nA9iXJJKt5Olz16ZA6bcg9PnmqPvP6K2Nb1QeJFNV0VbItKdtHsowg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledruddttddgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfquhhtnecuuegrihhlohhuthemucef
    tddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkof
    gjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhnucevrdcujfgrrhguihhn
    ghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkphepuddvgedrudejuddrvd
    efrdduheenucfrrghrrghmpehmrghilhhfrhhomhepthhosghinheskhgvrhhnvghlrdho
    rhhgnecuvehluhhsthgvrhfuihiivgepud
X-ME-Proxy: <xmx:nA9iXGxLsTA5rjiZvE2cnHax5icuCvN2NWxohtYRNZJIny0ATLcYqw>
    <xmx:nA9iXAbPwdjJ_qPvurN5Qisv8J5ifQJ7YaEy1EAb_bR7GKSfkegbQQ>
    <xmx:nA9iXC7hAzB0tM5_S88Pbd-2G9tD36UDPMIbG0FYLkdQfySzEOy7nQ>
    <xmx:nQ9iXDeES8CSoErvKhpcBhqckV36_sh0gx29jyl-skXHBr_bpFudkg>
Received: from eros.localdomain (124-171-23-15.dyn.iinet.net.au [124.171.23.15])
        by mail.messagingengine.com (Postfix) with ESMTPA id E15BDE4438;
        Mon, 11 Feb 2019 19:13:14 -0500 (EST)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] tools/vm/slabinfo: Align usage output columns
Date:   Tue, 12 Feb 2019 11:12:18 +1100
Message-Id: <20190212001219.27769-4-tobin@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212001219.27769-1-tobin@kernel.org>
References: <20190212001219.27769-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Usage message uses spaces not tabspaces, a few tabspaces have snuck in
making the columns not align correctly when output.

Align usage output columns using spaces instead of tabspaces.

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
Acked-by: Christoph Lameter <cl@linux.com>
---
 tools/vm/slabinfo.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/vm/slabinfo.c b/tools/vm/slabinfo.c
index 5119adb9d009..97715b73af70 100644
--- a/tools/vm/slabinfo.c
+++ b/tools/vm/slabinfo.c
@@ -124,13 +124,13 @@ static void usage(void)
 		"-L|--Loss              Sort by loss\n"
 		"-n|--numa              Show NUMA information\n"
 		"-N|--lines=K           Show the first K slabs\n"
-		"-o|--ops		Show kmem_cache_ops\n"
-		"-r|--report		Detailed report on single slabs\n"
+		"-o|--ops               Show kmem_cache_ops\n"
+		"-r|--report            Detailed report on single slabs\n"
 		"-s|--shrink            Shrink slabs\n"
 		"-S|--Size              Sort by size\n"
 		"-t|--tracking          Show alloc/free information\n"
 		"-T|--Totals            Show summary information\n"
-		"-U|--Unreclaim		Show unreclaimable slabs only\n"
+		"-U|--Unreclaim         Show unreclaimable slabs only\n"
 		"-v|--validate          Validate slabs\n"
 		"-z|--zero              Include empty slabs\n"
 		"-1|--1ref              Single reference\n"
-- 
2.20.1

