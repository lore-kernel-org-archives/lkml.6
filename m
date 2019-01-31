Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE6AC282C7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 04:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A010B20870
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 04:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="L4Kf1drA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R25mjrc/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731382AbfAaELM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 23:11:12 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:43919 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731290AbfAaELK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 23:11:10 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id AC8262221E;
        Wed, 30 Jan 2019 23:11:09 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 30 Jan 2019 23:11:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=+qm6IAuBdYJ0K
        JEezxlGA4lLZCD+PJm0pFyznNM0TqM=; b=L4Kf1drAhsQV9rdCZsdUaatbA2lCl
        kGJljvJbkTAT2b2Tt9MYfnwGbOqVdw7DjKOrXfWtEIQHdBu96VGKlow56UQy/Cgu
        gOCe6dnmYpRsmvTe4wCHweH1DQ0yb0nJv2kfcAHvNh3LqFSGRAKc/+Ob9OqlVzPP
        t5dV7dgLy0zy8pU9ksi1r3Ka5DsLGCp/5ctjpC79d63qgymuVTQJawiNni3b6aeJ
        O84oaOJpJ7BOoUJyjywmbK/JU3a3bhTg8fpWXw7j2VmARIDH/jh1Jj2ZhG1eqBUd
        Ekobj4sOmRHlnV/1diYWfgd1AA+T3N8aHZzLSb8S2cmL/HuMq/RmH55nQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=+qm6IAuBdYJ0KJEezxlGA4lLZCD+PJm0pFyznNM0TqM=; b=R25mjrc/
        LAGhD40XbnnU9l/QhALVsTi9Tu6c7taouJNs3lmWj2JGWbjcS65Leyh+R3Dc5em+
        DH3DD5yCow/9lRE7XBLHSg8zOgmICS+K2rXkCAhx00DH+nOLYaR0RgPqAxcFFnx9
        iaa6TzJ50qjamNzeHtmYFwCSEiZEG8YcPrfJ83sq4QrNr7+3KcpcajvXOTItTuit
        BRSDkrHp/FcKgA9ot5q1Jf2QiDSpG0QajojpUP8X/GMd/XJmlV0egimdP3/41pr+
        NS23fjvGqtMFv3Tyb4oGsUPqePVhIR2yE3BvWrijXUtr908cquvOEBU9lpTmn9jF
        y+rR2ifAqgDPww==
X-ME-Sender: <xms:XXVSXO21kSLiHAp1m2PEN4-OVMrjgTVd3UZW-tFEPUHzOmH9MVt4qw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledrjeehgdeijecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthenuceurghilhhouhhtmecufedt
    tdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrhhlucfvnfffucdlfedtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgs
    ihhnucevrdcujfgrrhguihhnghdfuceomhgvsehtohgsihhnrdgttgeqnecukfhppeduud
    ekrddvuddurddvudefrdduvddvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmvgesthho
    sghinhdrtggtnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:XXVSXFVZHn9vA7AK_7wbaObvp4SM6DyPBkBugSIH8aANI3CG9bAdrw>
    <xmx:XXVSXB5UNTauek0eN9f7_PZhczRzW9Lz58c2O6HE_O7K3Rjb5BsHGA>
    <xmx:XXVSXELO7pzSPBpkfFn7eiPJr9cJaL8VpqYlTz7hXCbU5Nvd-IF6vQ>
    <xmx:XXVSXFNdNsuk7grXB-DrY3L2HZp-1PvyZW6fg4Enj4IW380K5mROBQ>
Received: from eros.localdomain (ppp118-211-213-122.bras1.syd2.internode.on.net [118.211.213.122])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9F7B110086;
        Wed, 30 Jan 2019 23:11:06 -0500 (EST)
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Christopher Lameter <cl@linux.com>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] slub: Use C89 comment style
Date:   Thu, 31 Jan 2019 15:10:03 +1100
Message-Id: <20190131041003.15772-4-me@tobin.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190131041003.15772-1-me@tobin.cc>
References: <20190131041003.15772-1-me@tobin.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Tobin C. Harding" <tobin@kernel.org>

SLUB include file uses a c99 comment style.  In line with the rest of
the kernel lets use c89 comment style.

Use C89 comment style.

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 include/linux/slub_def.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/slub_def.h b/include/linux/slub_def.h
index d12d0e9300f5..c8e52206a761 100644
--- a/include/linux/slub_def.h
+++ b/include/linux/slub_def.h
@@ -151,7 +151,7 @@ struct kmem_cache {
 #else
 #define slub_cpu_partial(s)		(0)
 #define slub_set_cpu_partial(s, n)
-#endif // CONFIG_SLUB_CPU_PARTIAL
+#endif /* CONFIG_SLUB_CPU_PARTIAL */
 
 #ifdef CONFIG_SYSFS
 #define SLAB_SUPPORTS_SYSFS
-- 
2.20.1

