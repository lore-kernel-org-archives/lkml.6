Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3EDEC282DA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 00:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B195218D8
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 00:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549241871;
	bh=lP7goBSRjlmzI2eHnmDHwnhLc5Hb3h8W2SdRIZtzFT8=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=GLtx1LiBy7eg8wCZ6tPeoABjfUjAZ+u51Q6Ox9iKQrxdPU8tOr7P97IRXWp6P4KBi
	 hj1Tlj7UBQN3LTq7Ac+zHYXBP2cmEcZ14kDdB4Ju7/PG3FVCEvbsj8A/lT1jLMoz8D
	 2Byc7jKIUeHnjUQeCaAVbBpZvQObjeokquzycbaI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbfBDA5n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 19:57:43 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:53113 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727433AbfBDA5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 19:57:43 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 2E47821F99;
        Sun,  3 Feb 2019 19:57:42 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sun, 03 Feb 2019 19:57:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=/ir7ml8F/rIYLqfkm
        9Jph1TAjuA2uenn+ZQNjGjtcNU=; b=t7MNzljy/yEunoZpuhZZEoubaVkuiag2i
        NYcbFZB+Ffe7jh2qmWcKJQL5Zs1ryp++41Pa73wjGEPc7crElXE2NfirQ64h2mx2
        87/d7Hno9L48rD9D2pnuDsO3slS607+STuk32xRqNA4nUyeOtakawXfNqX8ZY/00
        J4CstaqQttz3hm1n2MYM1UYGWa25Mf//pZ815ln2Jhb+go+pEHT8TiGnaV50Kyyt
        OhKm863VQ1L/06L9pCrZsZIkMZ0/J3W7RQtYeECjxMK2Ven0gDzKFLJmQqBOiOvp
        1HfymtkVRkGwBbXB/f1kePivg3bcU9BB7+88P5MbS2qqI915Xk4+Q==
X-ME-Sender: <xms:BI5XXNpQJ3lhDN9eejiI8ws69zDyPaVMbb8Sp0wTyZxk3ibWhXGhFg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledrkeefgddvjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthenuceurghilhhouhhtmecufedt
    tdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffogg
    fgsedtkeertdertddtnecuhfhrohhmpedfvfhosghinhcuvedrucfjrghrughinhhgfdcu
    oehtohgsihhnsehkvghrnhgvlhdrohhrgheqnecukfhppeduvddurdeggedrvddvjedrud
    ehjeenucfrrghrrghmpehmrghilhhfrhhomhepthhosghinheskhgvrhhnvghlrdhorhhg
    necuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:BI5XXC5R17GzisinsJlTD1aS1r2EB0ohyObNwW7aZWNn0_ZMOkPByQ>
    <xmx:BI5XXDpoz84tXD102xmZxbXX6BjeJH8X7JdoKcsEP7DYHz34n0AQfw>
    <xmx:BI5XXEj4zDE1VFRiNeVJcoNQloME4ua7nMkRA0gNik53vRinNuUy9A>
    <xmx:Bo5XXAeAiqQAWgxqsqWbIfJOK7rptciyBjJx8koLW73z0Z-oeNOnsw>
Received: from eros.localdomain (ppp121-44-227-157.bras2.syd2.internode.on.net [121.44.227.157])
        by mail.messagingengine.com (Postfix) with ESMTPA id E8E4D1030F;
        Sun,  3 Feb 2019 19:57:36 -0500 (EST)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Christopher Lameter <cl@linux.com>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] slub: Do trivial comments fixes
Date:   Mon,  4 Feb 2019 11:57:10 +1100
Message-Id: <20190204005713.9463-1-tobin@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is v2 of the comments fixes [to single SLUB header file].


thanks,
Tobin.


Changes since v1:

 - Re-order patches (put the easy acceptable ones from v1 first).
 - Do grammar/punctuation fixes thoroughly (thanks William).
 - Send the set to Andrew instead of Christopher since we are going in
   through his tree.

Tobin C. Harding (3):
  slub: Capitialize comment string
  slub: Use C89 comment style
  slub: Correct grammar/punctuation in comments

 include/linux/slub_def.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

-- 
2.20.1

