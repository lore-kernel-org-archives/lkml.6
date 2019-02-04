Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB49C282DB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 00:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D110D20820
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 00:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549241871;
	bh=9KLJYqZs2SMdmznN4tXbXNFwsRRMZIIv2vwio90EYm8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0E2es03ROnh0Br2Zpsd+MC8U3UeCI3dwN/6nxYqv56qdNb0o7qz6PFrxCMK7Yfp+8
	 2r5CLQk773fG2VgroQvIV4yVrJ3xKKeEutLFphMG9omkSFr1V+pvYxw7YVsqNwFd1p
	 7R5+J4tylItpEL/fldTFJ5ZZSPEXANSJDf+UYdLk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbfBDA5r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 19:57:47 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:47089 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727433AbfBDA5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 19:57:45 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id C7E0220CF2;
        Sun,  3 Feb 2019 19:57:44 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sun, 03 Feb 2019 19:57:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=XQDJC6eQAtw+8e8Xzlnxqu6fJLyDeNJ8trLkEmZ1sR0=; b=PSCWH+4R
        8xRnjbTcSafhHKm7O7q9v2+h1tuCE4MpDN0RpP/uTw43mYlNptBPNHqzx+k8eApS
        sQ2ezK9YHF2EJNIqbBliBA/k1H1wV1WMPeeawASIWLH+G1NQ5I5KIuDtdaNUySyW
        xsTwiUAc9Dg9ysNEq5FS7Ug/kkjs2AZYP5QPhMDIp5zNOr0D5ddBU8l+1AEXNh32
        M/rsQNfU5N9cUrOtbQ9KXkfeKz1xI3VsoV4o+l+pKzjdqXayScSz7fc0+KqDONj/
        EvhVx/xLQjVikd8w1Lp1HV4bI+e4OB3+az7pJq1IMvJra/b0zIvtF7GqGywnYivT
        JA8OSd3XfdiAWw==
X-ME-Sender: <xms:CI5XXDtup5RKL-0YXo-hnGTo6dWfWWGgBOBHLEQp6EMGSID1dJ6SnQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledrkeefgddvjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthenuceurghilhhouhhtmecufedt
    tdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojg
    hfggfgsedtkeertdertddtnecuhfhrohhmpedfvfhosghinhcuvedrucfjrghrughinhhg
    fdcuoehtohgsihhnsehkvghrnhgvlhdrohhrgheqnecukfhppeduvddurdeggedrvddvje
    drudehjeenucfrrghrrghmpehmrghilhhfrhhomhepthhosghinheskhgvrhhnvghlrdho
    rhhgnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:CI5XXMDQLzyV1vJ90U65DfL7FdBVh_y03oOsIcYxmK2Wn8HcoX1-8A>
    <xmx:CI5XXOV-ICvss76W_6OHH0nw70g_5vrpPTpImEiQiswrrn_5G0_n6A>
    <xmx:CI5XXCJNJq237asu_PsuiU0_WhCToq-BcRNGPD7pOgTE-dr1EE-vDg>
    <xmx:CI5XXEAa72wilVoEYkoakFIF4quDBwGDG-QAG9vTO8Ub3qUU3tdDjw>
Received: from eros.localdomain (ppp121-44-227-157.bras2.syd2.internode.on.net [121.44.227.157])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4D4A710087;
        Sun,  3 Feb 2019 19:57:41 -0500 (EST)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Christopher Lameter <cl@linux.com>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] slub: Capitialize comment string
Date:   Mon,  4 Feb 2019 11:57:11 +1100
Message-Id: <20190204005713.9463-2-tobin@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204005713.9463-1-tobin@kernel.org>
References: <20190204005713.9463-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SLUB include file has particularly clean comments, one comment string is
holding us back.

Capitialize comment string.

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 include/linux/slub_def.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/slub_def.h b/include/linux/slub_def.h
index 3a1a1dbc6f49..541b082ffcaf 100644
--- a/include/linux/slub_def.h
+++ b/include/linux/slub_def.h
@@ -110,7 +110,7 @@ struct kmem_cache {
 #endif
 #ifdef CONFIG_MEMCG
 	struct memcg_cache_params memcg_params;
-	/* for propagation, maximum size of a stored attr */
+	/* For propagation, maximum size of a stored attr */
 	unsigned int max_attr_size;
 #ifdef CONFIG_SYSFS
 	struct kset *memcg_kset;
-- 
2.20.1

