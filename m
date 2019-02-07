Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF66C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 22:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BE5221721
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 22:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549579853;
	bh=cnnIzBmaKdcts/HY5HTx83TGHXr4nU1J6/oz50fPOm4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MqTTiWdkcmOTalHmt62ivqkHfrssWMydCkdb0qDbTZqg8MADmeY/4U9Uxwks5Ni8D
	 71/JNwNLd8CvTMh+pQYUSUHta9DL1EFWtYMhXBfoQTjqEa16gyM1bwHFMS7DLnjoCc
	 UBwZiiBD/6DrixSF4oQSlwTv10oPr8BS09vtj5y4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbfBGWuv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 17:50:51 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:33893 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726622AbfBGWut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 17:50:49 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id BAEEA220B8;
        Thu,  7 Feb 2019 17:50:48 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 07 Feb 2019 17:50:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=q1B/CJMZvoxqeOLP75leRL91Q4hN5azLv72yIUplkAg=; b=wX05h86f
        z47aZ82udeyhgS0O7oWVNdhuJZgYLzOMRY6REaetzFbBdWff9Q6e79YjOvCKvEae
        4jrTYE3nqxtVxffR3c2niZEWpwfH+X1sXfsQanwCGIFJ//JFIPgU80ySScAo38Jx
        6r/50jqM1DDVWOoaIEC9E6I90hpnJ0BV4jriMuahdu22gi5Rn0k5StzS0/k+6V1S
        604uOkgu6ubFqjrHCYFqsIRKaMuwu5qLUD8IW9VPWOkG4ab8ShFNqSQJEoamSNKA
        zwdMvKHXr94HW3HvPx34PGnrjXarSwm/oc4HvD5fCM60l7XZHsvFMGIKKAZN28bK
        /578NH2k5eJX0A==
X-ME-Sender: <xms:SLZcXGkNLLJTJ0cnkvb4_7lYBNiKqJoWaTGUItv7icrEFbbG6BYVkA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledrledugddtudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthenuceurghilhhouhhtmecufedt
    tdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojg
    hfggfgsedtkeertdertddtnecuhfhrohhmpedfvfhosghinhcuvedrucfjrghrughinhhg
    fdcuoehtohgsihhnsehkvghrnhgvlhdrohhrgheqnecukfhppeduvddurdeggedrudelle
    druddtleenucfrrghrrghmpehmrghilhhfrhhomhepthhosghinheskhgvrhhnvghlrdho
    rhhgnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:SLZcXBQwwQiBnYM5CeudDfaqVDE8lyKzOX_bgdxv8_6XcofGZCwSvg>
    <xmx:SLZcXLo09oQVYQVxzR4o3RuoNCRbJ6n_d0xokhyEmzDuFhRuljXQDA>
    <xmx:SLZcXH28aLRW5AOvoVc_UYreq09GJYHQ3K3pm5arWtsz5Z3lpfkoyA>
    <xmx:SLZcXCgZnj5LVxVHGBVNabmrEt1trpO0HGgR57Le14yMGJ5fJgtnMw>
Received: from eros.localdomain (ppp121-44-199-109.bras1.syd2.internode.on.net [121.44.199.109])
        by mail.messagingengine.com (Postfix) with ESMTPA id A6932E4078;
        Thu,  7 Feb 2019 17:50:46 -0500 (EST)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     kernel-hardening@lists.openwall.com
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Tycho Andersen <tycho@tycho.ws>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] leaking_addresses: Fix calls to dprint
Date:   Fri,  8 Feb 2019 09:50:24 +1100
Message-Id: <20190207225026.11723-2-tobin@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190207225026.11723-1-tobin@kernel.org>
References: <20190207225026.11723-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently calls to function dprint() are non uniform and at times
incorrect.

Use uniform _correct_ call to function dprint().

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 scripts/leaking_addresses.pl | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/leaking_addresses.pl b/scripts/leaking_addresses.pl
index 6a897788f5a7..214c12be8c86 100755
--- a/scripts/leaking_addresses.pl
+++ b/scripts/leaking_addresses.pl
@@ -231,7 +231,7 @@ sub get_kernel_config_option
 		my $tmp_file = "/tmp/tmpkconf";
 
 		if (system("gunzip < /proc/config.gz > $tmp_file")) {
-			dprint "$0: system(gunzip < /proc/config.gz) failed\n";
+			dprint("system(gunzip < /proc/config.gz) failed\n");
 			return "";
 		} else {
 			@config_files = ($tmp_file);
@@ -243,7 +243,7 @@ sub get_kernel_config_option
 	}
 
 	foreach my $file (@config_files) {
-		dprint("parsing config file: %s\n", $file);
+		dprint("parsing config file: $file\n");
 		$value = option_from_file($option, $file);
 		if ($value ne "") {
 			last;
@@ -502,7 +502,7 @@ sub walk
 				next;
 			}
 
-			dprint "parsing: $path\n";
+			dprint("parsing: $path\n");
 			timed_parse_file($path);
 		}
 	}
-- 
2.20.1

