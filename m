Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E75B6C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 05:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82E5120685
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 05:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="rP/cC28D";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mYbqnRX/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82E5120685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728924AbeGZGRe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 02:17:34 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:56835 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726421AbeGZGRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 02:17:34 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id DC8F121DC0;
        Thu, 26 Jul 2018 01:02:33 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 26 Jul 2018 01:02:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :date:from:message-id:subject:to:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=YgNhRQCahx4NZfLqWiZpaVMOBiS+IZpdByUxgEHqy
        L8=; b=rP/cC28D/4kck/54zavSXNQ0MD+PMITeIR0TIW8hZZORnve2dXIVtbaMP
        m4MkVC0YoYdy9IQhguFuf/83qIMRt87Hm4ZwnMmxf6AnzDklusADRneabLmSB4+w
        Mq0u/tvCSIIQXqFBCsKs8l/3td3RJT1ZXjoPfAkpDSjDlgNt5x5hTerv8RXSZUWT
        TL6i3LmiLeMRnj+YVKSSNouGQGd61X1YHTJPVaUAe5BVGuaLMSs0uZUKO2DVPHLB
        QDmRrBACWxkEFMB1m9plqp1zrrcs4pJMTu1k4G2yLrGJ1DJ7NTCqS3sSIcXMHtR6
        oRDKLz6Sc615oJ0IuhAdxX240U4Cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:message-id:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=YgNhRQCahx4NZfLqW
        iZpaVMOBiS+IZpdByUxgEHqyL8=; b=mYbqnRX/ExwK9WrE6Spo7xfUe5rjPvNPZ
        2uLHlMkXoh16uMcOeia37f42LstFfS7dCjV5FFKSYIkzHPzvSCsWv3f7DA2fesx/
        KG8TgtqfoZKvm2dauGEaWpDbb6rQuiIS6uMzTfjH3+hGBFrEbC5613S6rlb4O6qH
        JNL5cR3JoBKgdvZDI0bsdZS1Eogi/UIErcvphtOfNvmPQV4PlHZOvcqoL4n9cM6M
        ui76cEBC4po6riisWaclkpSdwoyjtxUFh9TikRlygUcWhlvw9KnQ5TNTk3hEC7gi
        H+TLF7DnMNCk7UnF8Ta3rpVkH3/LMeROuS2m7eb908tdVs2MmOGtA==
X-ME-Proxy: <xmx:6VVZW2FOeo4ZNxAutZXD6KzXki5yw7yT325YHn3oNg5px_mH6WybOQ>
    <xmx:6VVZW13DcMvdVRRJZJKt4ZYvQwqg7E4To1UHMIxlXJrz2pEhpZytsQ>
    <xmx:6VVZW2_YQCRpJk3qYxu7o4wttJDxAV4rk1pdR1DpqFHl83gA8TAmkQ>
    <xmx:6VVZWwEtyku-34BXH-BccyoKHdYt2e0RG68z2XbMvFEqX4rKFvjSGg>
    <xmx:6VVZW0hNbxROkOZNtqHjBMF5Tsu5aISA4cni2SsW69ruwlut4ZA-4Q>
    <xmx:6VVZW9AgKEiiM0ejpzSHK9ztQnAN5LQ1sobIj_7KWU0xB--88Yf8Sg>
X-ME-Sender: <xms:6VVZW2SZ3m30gzYHE_bRdF2vxHedxyzu7zZ43MFwmFWjYMa6-PVIDA>
Received: from localhost (ppp121-44-239-245.bras2.syd2.internode.on.net [121.44.239.245])
        by mail.messagingengine.com (Postfix) with ESMTPA id B03D310268;
        Thu, 26 Jul 2018 01:02:32 -0400 (EDT)
From:   "Tobin C. Harding" <me@tobin.cc>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     "Tobin C. Harding" <me@tobin.cc>, Jonathan Corbet <corbet@lwn.net>,
        Edward Cree <ecree@solarflare.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        linux-doc@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 net-next 0/3] docs: net: Convert netdev-FAQ to RST
Date:   Thu, 26 Jul 2018 15:02:23 +1000
Message-Id: <20180726050226.1980-1-me@tobin.cc>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

Jon answered all the tree questions on v1 so if you will please take
this through your tree that would be awesome.

v2:
 - Fix typo 'canonical_path_format' (thanks Edward) 
 - Add patch fixing references netdev-FAQ

thanks,
Tobin.


Tobin C. Harding (3):
  docs: Add rest label the_canonical_patch_format
  docs: net: Convert netdev-FAQ to restructured text
  docs: Update references to netdev-FAQ

 Documentation/bpf/bpf_devel_QA.rst            |  21 +-
 Documentation/networking/00-INDEX             |   2 -
 Documentation/networking/index.rst            |   1 +
 Documentation/networking/netdev-FAQ.rst       | 259 ++++++++++++++++++
 Documentation/networking/netdev-FAQ.txt       | 244 -----------------
 Documentation/process/stable-kernel-rules.rst |   2 +-
 Documentation/process/submitting-patches.rst  |   1 +
 7 files changed, 271 insertions(+), 259 deletions(-)
 create mode 100644 Documentation/networking/netdev-FAQ.rst
 delete mode 100644 Documentation/networking/netdev-FAQ.txt

-- 
2.17.1

