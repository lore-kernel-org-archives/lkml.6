Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 011DEC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 22:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADBDB21917
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 22:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549579849;
	bh=Pz5Mh8vSoDEW8hLlU8s62gfP62fcO7adWqyR5mug+PY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=VSLPSdhVhK/aD1Pmvj3Mo4PMs6Naru7VuvO46dbc+08hEsMp2m2EOxySsaM0rNaCY
	 DxqSOc51RP4j8vdE9mi104PW09wQ0UtCW6aHhdKLo3wF4TW6pIPym9dShg47dxWAf2
	 pHfAEjKSOakPza9btl/kqooMmqF94mo16C8ULdFQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfBGWur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 17:50:47 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:42279 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726622AbfBGWur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 17:50:47 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 8EF132235B;
        Thu,  7 Feb 2019 17:50:46 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 07 Feb 2019 17:50:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=dItnojEAFP5Cq99oJ
        B1tDw1BTK7iumgl5emWxoonvM4=; b=OMa8l/XK2rM49xDgXQwWA0+EvCWbeOmx8
        Qu9UAiV3MN5emZTwqGMssSw+uti+EqhxeTan7BWxXdq85NmaqETlZvG9x48AYDB5
        1fChLLZzYy2/XiVFw9Q539oasr8ZN5/t8kLgagTVJebpm87pPukLLYg6OERakEgO
        OPvzISA2cW3qx6raANcy4lTr5w+UQqGwPJrSie82hdvDzrf1xCaEDeXxA/f+bc0h
        CnXeqMuoNbbAjn9BEGG9r5VcDwa4CJnnO1nCfJxL3w4ijkl5/dftyaw95kw4YP8w
        XkCg9fFjGTPGZrW7GMDKvumeS66rUlwQdJNKHE8sGuC9/A06jG4eA==
X-ME-Sender: <xms:RrZcXM_l1Ne9SDg4BJE6YTqtTcNpKExaUUJECtiSVsIjGBsdSffMpw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledrledugddtudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthenuceurghilhhouhhtmecufedt
    tdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffogg
    fgsedtkeertdertddtnecuhfhrohhmpedfvfhosghinhcuvedrucfjrghrughinhhgfdcu
    oehtohgsihhnsehkvghrnhgvlhdrohhrgheqnecukfhppeduvddurdeggedrudelledrud
    dtleenucfrrghrrghmpehmrghilhhfrhhomhepthhosghinheskhgvrhhnvghlrdhorhhg
    necuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:RrZcXF9HxzQSr0b5e_jBr01BouwDIOpBPmrlX7F5kyUuwFa-zFSxSQ>
    <xmx:RrZcXPEan0uFopJ3Xk9ujbEzAgmDaPcT73As9MwdQqofYB81pF5kSw>
    <xmx:RrZcXPcAQ8x6Qq3xHdTBZWeMcqwpWQVmeYLIOvvEeAzXzHwGAKUDMw>
    <xmx:RrZcXLxvHrachqjOfVJk9nhmT6Q0zHdDv4z7ZFLP6C4HisOqJ80MQw>
Received: from eros.localdomain (ppp121-44-199-109.bras1.syd2.internode.on.net [121.44.199.109])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3926EE4649;
        Thu,  7 Feb 2019 17:50:43 -0500 (EST)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     kernel-hardening@lists.openwall.com
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Tycho Andersen <tycho@tycho.ws>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Minor bug fixes to leaking_addresses.pl
Date:   Fri,  8 Feb 2019 09:50:23 +1100
Message-Id: <20190207225026.11723-1-tobin@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are a few minor fixes/improvements to scripts/leaking_addresses.pl

Patch 1: Fixes places where I don't know how to Perl.

Patch 2: Removes `--version` command line option, completely this time.

Patch 3: Fix a bug in the command line options parsing.

thanks,
Tobin.


Tobin C. Harding (3):
  leaking_addresses: Fix calls to dprint
  leaking_addresses: Completely remove --version flag
  leaking_addresses: Expand tilde in output file name

 scripts/leaking_addresses.pl | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

-- 
2.20.1

