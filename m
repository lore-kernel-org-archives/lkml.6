Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3425C169C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 00:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A374720820
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 00:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549241877;
	bh=jDzVbAzGlPKQ4DmeKyGMrOl0sW6zi9D+iy6qwCNVeaQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=l73IT1T/4neqY3MxR6y+lexUbWqtU9dB0lkdBZA3G5hmNMpgjkOvE0sdQi3jOQywS
	 Be+OuUal9KOtOa4uEpsTm6U0/kdCvAQ0Jo/LObTFYPZbWCkGIgDEtLVrBA0EqMOLwf
	 7ZERdPrAdbD+zASy0YeLfYnx/1eKO55FOGXjUPwA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbfBDA5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 19:57:55 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:38099 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727433AbfBDA5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 19:57:54 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 0514520D0F;
        Sun,  3 Feb 2019 19:57:53 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sun, 03 Feb 2019 19:57:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=UPtLQBBDpQY8OrRZNx58X637Zf8UbyPpXV+o1ETUk5k=; b=nYNyba3e
        FAlBG+Ougq0t2IIV2kUbyeYo6H5UF/zL5hGKKT9xCvczVCyzvHgQFXXKazYhwsfl
        TMfwxt6Y4rim/paoPQA/H/8SLTKi0ISG2GOo3yQgxVzNtvG/9RajdkCIZdZGdBAa
        UuHLeYmGvgrjn6srihmak+lOwdjGsKGFLQPx8F4QZ79lQ5Drd+oGGTS8xNAs5kDg
        Wt2o09UJkIFRnKrWAF0MCRAOCZZ+psL27DaI5OGhOzMp87JHJujxdNJZ1WeAct1Q
        G0t100rAZPBDQ0qqlosCwuztOfA41rfjv52wwVVLn17Cj1mpptPGu/H3uIwUsLwv
        p9yQvNRDP8eO7g==
X-ME-Sender: <xms:EI5XXG587kEdtMQ8ZpIXpaEh9f3Qvk75sQ_1idixHURPrYuZ-41zwg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledrkeefgddvjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthenuceurghilhhouhhtmecufedt
    tdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojg
    hfggfgsedtkeertdertddtnecuhfhrohhmpedfvfhosghinhcuvedrucfjrghrughinhhg
    fdcuoehtohgsihhnsehkvghrnhgvlhdrohhrgheqnecukfhppeduvddurdeggedrvddvje
    drudehjeenucfrrghrrghmpehmrghilhhfrhhomhepthhosghinheskhgvrhhnvghlrdho
    rhhgnecuvehluhhsthgvrhfuihiivgepvd
X-ME-Proxy: <xmx:EI5XXJQaJEHGlrfgeAzzySV_ANE_RzgH0-xOGvrQYV6lh-FpOWYRtQ>
    <xmx:EI5XXN-Gr9TxfLZ-f7xsi97PSPesZ9sojTcJmgF1FKKDh605QAW0pQ>
    <xmx:EI5XXCpFtTVCUS2Qt6cYCUZLEEz-gnuI5oa1f991cQLDJMeaPUQZ-g>
    <xmx:EI5XXD2XcygaWH3Al5C8oVAQSnGdJabEAG5WPMPKexsEDTPkmbE_GQ>
Received: from eros.localdomain (ppp121-44-227-157.bras2.syd2.internode.on.net [121.44.227.157])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8719A100BA;
        Sun,  3 Feb 2019 19:57:49 -0500 (EST)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Christopher Lameter <cl@linux.com>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] slub: Correct grammar/punctuation in comments
Date:   Mon,  4 Feb 2019 11:57:13 +1100
Message-Id: <20190204005713.9463-4-tobin@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204005713.9463-1-tobin@kernel.org>
References: <20190204005713.9463-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently there are a few minor grammatical errors in the comments.
While we are at it we can fix punctuation to be correct and uniform
also.

Correct grammar/punctuation in comments.

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 include/linux/slub_def.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/slub_def.h b/include/linux/slub_def.h
index a3f1fc7e52a6..d2153789bd9f 100644
--- a/include/linux/slub_def.h
+++ b/include/linux/slub_def.h
@@ -81,12 +81,12 @@ struct kmem_cache_order_objects {
  */
 struct kmem_cache {
 	struct kmem_cache_cpu __percpu *cpu_slab;
-	/* Used for retriving partial slabs etc */
+	/* Used for retrieving partial slabs, etc. */
 	slab_flags_t flags;
 	unsigned long min_partial;
-	unsigned int size;	/* The size of an object including meta data */
-	unsigned int object_size;/* The size of an object without meta data */
-	unsigned int offset;	/* Free pointer offset. */
+	unsigned int size;	/* The size of an object including metadata */
+	unsigned int object_size;/* The size of an object without metadata */
+	unsigned int offset;	/* Free pointer offset */
 #ifdef CONFIG_SLUB_CPU_PARTIAL
 	/* Number of per cpu partial objects to keep around */
 	unsigned int cpu_partial;
-- 
2.20.1

