Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F19D1C169C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 00:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC58320820
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 00:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549241873;
	bh=slru85ESzM7xLnO/Jk6DRzIxYwEiDODp/BuFgRqsXl8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Nxii2QOkpRDx1kmrwGT0lhQlJvAPjT920f/NfEwQkEaa4Sd9djK6wIjybrjR0CGeC
	 Mhi+BMvH/9TgvVzKqB14J26NbnDeezppOJAsSFvDO4Z5wYNvoqU3EUQ6TS799dUE03
	 NmNn3IQzAVkFRKsdXpkqLST1AWG144ktQbuW0VkM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbfBDA5w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 19:57:52 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:42889 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727433AbfBDA5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 19:57:50 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 0A8FA20EA9;
        Sun,  3 Feb 2019 19:57:49 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sun, 03 Feb 2019 19:57:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=vcmHXuO0fiNhzPIXwjvNEwttdZPxTbfquzDsHc95XIY=; b=UZ9x1OHM
        MYVHu9XvtfawVtIousvWePSJIVavhprQBTEDBg4XVN0AvJNk8+gFxufbmQSqQ984
        nO50vy6j299jEYQz1oXMAUgp7Y0v1W5ycvb0R8/mGXwtGJsaZGAO6LkY86Rub/n6
        4tH1qHKDAQlIwQY6ZEUzhlXpIGOo9oeUVEJSFz8Jim9Dnx24bg75lxVC0OV3G95s
        Jc1SiA/lB7iUHO4YyW1fVAT0U5r+umLPcKhD/xXJMm9ejomgTrZoIz53BV0pxtdO
        ZI4cLtsFRPpramU+gDYtlfDtv64CgRuzS4UK0MMyKQ5WHJwasb1EUG7QRZjVxFEc
        tFMg4YUGzF4TmA==
X-ME-Sender: <xms:DI5XXJr4Dl1KfoCMbRarZSDSp6u1H5C2IclaVgQoNi71gRvpcl52Iw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledrkeefgddvjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthenuceurghilhhouhhtmecufedt
    tdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojg
    hfggfgsedtkeertdertddtnecuhfhrohhmpedfvfhosghinhcuvedrucfjrghrughinhhg
    fdcuoehtohgsihhnsehkvghrnhgvlhdrohhrgheqnecukfhppeduvddurdeggedrvddvje
    drudehjeenucfrrghrrghmpehmrghilhhfrhhomhepthhosghinheskhgvrhhnvghlrdho
    rhhgnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:DI5XXCk3Rca7k4ilHQugsiRGTgbFRtu7jMN9LUAJlSyijmMtAFKyCw>
    <xmx:DI5XXMr9k44PaEhQXQu6Et3d5osCbCK1bWHosx2NjOLV-CKofI47Rg>
    <xmx:DI5XXDaUsQ75d8SPPJxTUbtMSjBgbFkEx6q69UP0lqh2T6-hnRzsRQ>
    <xmx:DY5XXDqG_eeQF_GT9pX_Khv1vzrp8CAireSWiAVFlRIpVTz4qtYP-A>
Received: from eros.localdomain (ppp121-44-227-157.bras2.syd2.internode.on.net [121.44.227.157])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8223110317;
        Sun,  3 Feb 2019 19:57:45 -0500 (EST)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Christopher Lameter <cl@linux.com>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] slub: Use C89 comment style
Date:   Mon,  4 Feb 2019 11:57:12 +1100
Message-Id: <20190204005713.9463-3-tobin@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204005713.9463-1-tobin@kernel.org>
References: <20190204005713.9463-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SLUB include file uses a c99 comment style.  In line with the rest of
the kernel lets use c89 comment style.

Use C89 comment style.

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 include/linux/slub_def.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/slub_def.h b/include/linux/slub_def.h
index 541b082ffcaf..a3f1fc7e52a6 100644
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

