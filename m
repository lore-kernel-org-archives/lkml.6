Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A1BC282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 22:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7C3121721
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 22:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549579859;
	bh=oMe6vXkT+1BD6acEyXWgQwOYkTbpUjzso39Rr0KCQpc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=K9ASaHm9rcBmmZxXuRARc7vpsRGC2P7eF2SJ3fa7flYriLmmG28gNU1jLZH8Lj8Xo
	 MgBDbBvPRfwDHbDe4RveOduPqz7BIiLSOXuyvofHGpemq8PxhMc12QwHIUxJCmQSj3
	 yLHo/pyDTCBg+h6QJ1ziUpqYP/svfZoasjGp/TZY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbfBGWu5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 17:50:57 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:46623 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727091AbfBGWuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 17:50:55 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 117832208C;
        Thu,  7 Feb 2019 17:50:53 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 07 Feb 2019 17:50:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=rl9IOz7bUSqbOMyGkhPi6aRMwmI5d43wx7DRds0uh/4=; b=j//XwNNY
        x67JRCHmIIU1wa4IoY4O5vgv0aGupjDmbAAT+hm+yqE+lz5ZbD1i4Tu6qqeC57uK
        e4Zrnfly5CZsWHZ3K98wZY7axHfgSvLtObu2hk74++g6rozSN8HFcIEMaAudKSfC
        3K9iCCa6fLfhyM/4wraKWrSgDvD7mTCLNBBMvukHv9cSNT+J31GMOQm7uQg0qYXD
        0AqPDld20Nz77IKJ7Bte1apee7YJy8zSHBT37EeoecPCiIYxOeSb9GwGMoJmRO8T
        8zXiI4TOK6mq70llkv4cjVJCHdkhrMkccGNTG2S1iy0rw9AO0h25svMh4Y1eKlg7
        GCnJwhPI2G+/8Q==
X-ME-Sender: <xms:TLZcXAF5-A2k8pRI7ALNJK33_Ep1RvGrxChlRLFFKc13N1OdJDCUWQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledrledugddtudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthenuceurghilhhouhhtmecufedt
    tdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojg
    hfggfgsedtkeertdertddtnecuhfhrohhmpedfvfhosghinhcuvedrucfjrghrughinhhg
    fdcuoehtohgsihhnsehkvghrnhgvlhdrohhrgheqnecukfhppeduvddurdeggedrudelle
    druddtleenucfrrghrrghmpehmrghilhhfrhhomhepthhosghinheskhgvrhhnvghlrdho
    rhhgnecuvehluhhsthgvrhfuihiivgepud
X-ME-Proxy: <xmx:TLZcXLauQuqu6qhWqrm2I61y9iNS4GXq3ih-N4enw9DzlsKbCpO_bQ>
    <xmx:TLZcXITt-ANM7n7-oOWTNK-RIPNjlLKqEuI6Bn7Re205EdQclo1nCg>
    <xmx:TLZcXHAt52_mcLkIXOMrg_4DQPQAu29aCll_HKDe0v-SAucBD3LJCQ>
    <xmx:TbZcXGyZr7yNKXKjY9fXGv87AkMWhp5mzs5XXOKf5jfywBgM0JwbaQ>
Received: from eros.localdomain (ppp121-44-199-109.bras1.syd2.internode.on.net [121.44.199.109])
        by mail.messagingengine.com (Postfix) with ESMTPA id 27E8DE4078;
        Thu,  7 Feb 2019 17:50:50 -0500 (EST)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     kernel-hardening@lists.openwall.com
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Tycho Andersen <tycho@tycho.ws>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] leaking_addresses: Expand tilde in output file name
Date:   Fri,  8 Feb 2019 09:50:26 +1100
Message-Id: <20190207225026.11723-4-tobin@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190207225026.11723-1-tobin@kernel.org>
References: <20190207225026.11723-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently if user passes an output file to the script via
--output-raw we do not handle expansion of tilde.

Use perl function glob() to expand tilde in output file name.

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 scripts/leaking_addresses.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/leaking_addresses.pl b/scripts/leaking_addresses.pl
index ef9e5b2a1614..ce545ca3fb70 100755
--- a/scripts/leaking_addresses.pl
+++ b/scripts/leaking_addresses.pl
@@ -150,7 +150,7 @@ if (!(is_supported_architecture() or $opt_32bit or $page_offset_32bit)) {
 }
 
 if ($output_raw) {
-	open my $fh, '>', $output_raw or die "$0: $output_raw: $!\n";
+	open my $fh, '>', glob($output_raw) or die "$0: $output_raw: $!\n";
 	select $fh;
 }
 
-- 
2.20.1

