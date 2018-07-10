Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6114CC5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 00:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A1DC20840
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 00:26:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="lpSjKrGO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="liWVsBka"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A1DC20840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754611AbeGJA0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 20:26:02 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:38397 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754530AbeGJAZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 20:25:55 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 920BB21CEC;
        Mon,  9 Jul 2018 20:25:54 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 09 Jul 2018 20:25:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :content-transfer-encoding:content-type:date:from:message-id
        :mime-version:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=IIF83T2qnhOGbSBhuNPhD0kHKfuX+binvvjo3yvIdhQ=; b=lpSjKrGO
        O0vTX/TzFu8f6CBFrjj09vzPcZKVUoopvO+lePelDYydUdRUflgvjr6+e8N3/gYs
        OZSc1A9uafPVxVq4+qgMaA7mV4INDr9Ll/li2EGQbFWibU1156tLYPxRgQ5Dguc9
        bqYYT9mqP6GtOYIYnl4QIdlYc7ibyo6neLyK1DcDbHr8g0aDc01RG9R1Jiu4nR7t
        zuacsfXnbIWCsE+QOvAC58Qy9y6Tol/706IvjgwNgUmD9NZF91nsSfns1DKy1Uv9
        VoI6wXC9g5BB0I1b4k/PJz8Tvlu4ki9VobtJ+Lyh3JpSLoVJRUAXcO5p2FbvPhhM
        6qDXwoVWAk4VUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=IIF83T2qnhOGbSBhuNPhD0kHKfuX+
        binvvjo3yvIdhQ=; b=liWVsBkaHQ8A0Xo9dyVaNFUHyt91ihyapKaWj7c+fxtMu
        YKdCa13nyngRcIRteXwoDexhRcTaQJxteDDk32vBygBf3bJa/llR3+r3IOXBNo1E
        tzQrngRk9SrEB9PfpZQhX3TYRd+Ip1KkUkeTcHyEo1Cvgcg/8oze2BpC+to5FWhX
        /hRC3wwAKswxj3BH/C90/06ixqWc/l9NmSxO5vkY1s3ea4FzkWMorAUJ0ABCVLWD
        /HUNE/3XsHbDVUbsZ1IU6f7HG+VUOehz5Yt69RIYV/sRCOaGuNaewcnhYMe0y5Kp
        ev6jMGM5SkfAO5cnNOawZ9P6+EByS2cEGR0dvxokw==
X-ME-Proxy: <xmx:Ef1DW3m-g-kML_X1A0-8wg7I_vG-5dLCWLnsCTKkIDPHeg7t_hVQFQ>
    <xmx:Ef1DW1TdXRmn32eTNFdpwIl-8y7dkAkMjqfyHpnOsh7Zvc1EK9suAg>
    <xmx:Ef1DW1Izq1XFdFegGudWe4MdVVd_LP90b04Bdgx_rUMd17fOzHSpCg>
    <xmx:Ef1DW3GniDJRP0ZySgFnP5qydBZh_P1svGRy_sRv-qFECDCydwfOBw>
    <xmx:Ef1DW61wOAr9hckcYo-muY-vHhkKLWfVagXhKJSY0DBlEFkoE88lsQ>
    <xmx:Ev1DW4s9GbIhdLndb_ByrP5oFGixB5Y9mMlOr8ayio3pvUFC2BSK7w>
X-ME-Sender: <xms:Ef1DW-Bd4hiVFTFTAWnQm77peJ_by5ZYhe9Pi_9TSPWHzRC1LZO4Lg>
Received: from localhost (ppp121-44-208-89.bras1.syd2.internode.on.net [121.44.208.89])
        by mail.messagingengine.com (Postfix) with ESMTPA id 317351025C;
        Mon,  9 Jul 2018 20:25:52 -0400 (EDT)
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     "Tobin C. Harding" <me@tobin.cc>, Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] fix: enable early printing of hashed pointers
Date:   Tue, 10 Jul 2018 10:25:16 +1000
Message-Id: <20180710002519.5044-1-me@tobin.cc>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ted,

Sending this set to you because it fixes the recent patch set applied to
your random-next branch.

This set includes changes already posted on LKML as

	[PATCH v9 0/4] enable early printing of hashed pointers

Since I'm a massive noob I did not realise that since v7 of this set was
applied to random-next already that doing incremental versions was
pointless.

So, this set is the changes done in v8 and v9 of the above patch set.
I have retained the acked-by tag from Randy for the docs fixes.
Attribution for pointing out the issues has been 'lost in translation',
I'll buy you guys a beer one day instead ...

With this set applied linux-next still throws a build warning

	lib/vsprintf.c:1667:13: warning: ‘have_filled_random_ptr_key’
 	defined but not used [-Wunused-variable] 

This is fixed by another patch currently in flight ([PATCH] "vsprintf:
fix build warning" - thanks Arnd).

Epic amounts of confusion, solely caused as usual by myself.

thanks,
Tobin.


Tobin C. Harding (3):
  random: Remove unnecessary cast
  vsprintf: Remove incorrect EXPORT_SYMBOL
  docs: Fix docs for boot parameter debug_boot_weak_hash

 Documentation/admin-guide/kernel-parameters.txt | 13 ++++++-------
 drivers/char/random.c                           |  2 +-
 lib/vsprintf.c                                  |  1 -
 3 files changed, 7 insertions(+), 9 deletions(-)

-- 
2.17.1

