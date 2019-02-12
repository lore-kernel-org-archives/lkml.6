Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D145C282D7
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 00:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCD7C2084E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 00:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549930394;
	bh=Z/w+KuILO+w8PDyulUGOTmnxyyAdBqCfpDNzf/yoBWU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HOwz+1q+/wjGDZSKIQxKMMcABMZF/qmgXLSz1qMFYxwvcRCBymx22pqU81SXyqd0z
	 GfEkt/whNdD9r5Dtoh0bmTh1OHcocbc7UewRJbQu1p6ihVE4UclEVLMIII8w3VuNuo
	 NFqrOgvopPMn5J3rxBU1Qv2sAAP87xJjk/DqKU/4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbfBLANM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 19:13:12 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:39429 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727737AbfBLANM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 19:13:12 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 3EF6A23111;
        Mon, 11 Feb 2019 19:13:11 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 11 Feb 2019 19:13:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=dS/IKh+wD0hML3rtdAtdyaQ8Q0bFZ0uUhq5M1kNrLu0=; b=dC/1t80c
        TWp1XAI8YpGTceI8ozEos1VyE9zCyxpO7mDTI4CQmw+XOqiD0L0emXmK1bj0YFn5
        tvdt0JPkzEI+eeBeDeat4O0oK2xQ7WmFYSBzAM+XRCUBjsbPZn0bGTWbWu6r7oHg
        my29/mrIWPAtWrph86qjDrLWUAfXD73tqrq0JH5uIpN68H7UM3HCaDiMh+wTd2JA
        mKnDsnvV17S9h5hm9O0ppPIdjQGTDlNP/vBpZcrI0PWzahfK83jUZfuUWiMaP0HL
        PYOy/fPEJ/kQWaC5OC55skDenpEOB9bn2xcSX6zny/IxBYKKjha/CST0zeOiKBps
        q8jWtPhsMTZIMw==
X-ME-Sender: <xms:lw9iXBVZrbz4_9hEwbG27eCk7oF1vzL4UaYydq1zRbzGXf46eYJgKQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledruddttddgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfquhhtnecuuegrihhlohhuthemucef
    tddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkof
    gjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhnucevrdcujfgrrhguihhn
    ghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkphepuddvgedrudejuddrvd
    efrdduheenucfrrghrrghmpehmrghilhhfrhhomhepthhosghinheskhgvrhhnvghlrdho
    rhhgnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:lw9iXPSyR3KbwQvLFpY9DZb_-XVCnSqqN2fnDKl4b8YAMAZ0riOq0w>
    <xmx:lw9iXPJTsfdSffxFSp5kbNaDBvFqn7OnlihpKdBHhC6unuUd7L-F5A>
    <xmx:lw9iXA3jb4K1ldRkFZToMsFN3j9Zm-cHAlQQtXmzX0pZ2TzcZrji5g>
    <xmx:lw9iXKePEIMCeVrHIVQWS1Xx34qyA-050RfU9oUBOq9mbDCAipD4cw>
Received: from eros.localdomain (124-171-23-15.dyn.iinet.net.au [124.171.23.15])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1616CE44F4;
        Mon, 11 Feb 2019 19:13:08 -0500 (EST)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] tools/vm/slabinfo: Update options in usage message
Date:   Tue, 12 Feb 2019 11:12:16 +1100
Message-Id: <20190212001219.27769-2-tobin@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212001219.27769-1-tobin@kernel.org>
References: <20190212001219.27769-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently usage message list only a subset of the available options.
should list them all.

Update options in usage massage to include all available options.

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
Acked-by: Christoph Lameter <cl@linux.com>
---
 tools/vm/slabinfo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/vm/slabinfo.c b/tools/vm/slabinfo.c
index 334b16db0ebb..d3908c50c87c 100644
--- a/tools/vm/slabinfo.c
+++ b/tools/vm/slabinfo.c
@@ -110,7 +110,7 @@ static void fatal(const char *x, ...)
 static void usage(void)
 {
 	printf("slabinfo 4/15/2011. (c) 2007 sgi/(c) 2011 Linux Foundation.\n\n"
-		"slabinfo [-ahnpvtsz] [-d debugopts] [slab-regexp]\n"
+		"slabinfo [-aADefhilnosrStTvz1LXBU] [N=K] [-dafzput] [slab-regexp]\n"
 		"-a|--aliases           Show aliases\n"
 		"-A|--activity          Most active slabs first\n"
 		"-d<options>|--debug=<options> Set/Clear Debug options\n"
-- 
2.20.1

