Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D27C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 06:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2EE920881
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 06:23:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="HhX/1TvJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CFpePq5F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2EE920881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbeIMLby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 07:31:54 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:40201 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726495AbeIMLbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 07:31:53 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 32CE021F1C;
        Thu, 13 Sep 2018 02:23:51 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 13 Sep 2018 02:23:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :date:from:message-id:subject:to:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=qcqNY9ny2fty+/0aaN6WF5xGm8VpWiFDvHvwRi2vX
        oY=; b=HhX/1TvJ8qfLT/uBSgEj33E9eLCfepLpBXGe8ZWwoA1m4vhGa8ni30j06
        2x/9wgfyZOslFpjhYwsBGnoVug/G+GOPP96J5tD1F+3y56goY/94JB6H+wBpRM9b
        3wSBeawPFVb5ebvjXQuqW3WWXywPJVdip9RDIxdtEpE97VzgMLJlTCEkAZehmqJQ
        yHM6p+KrACVe3v5HtMxqxp2K0EMuCFZSRAxV4lO75KRm3MVsqLyJjc03gAfhzQ83
        9uvX+EYOTgZN73Ffn0ULf/DlJ+UexVp9/TUkKcyfawMj2rjudze7FfKbd+oh3Uw+
        jZTK5XStwjdj9mAafWoPo404+m3Sw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:message-id:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=qcqNY9ny2fty+/0aa
        N6WF5xGm8VpWiFDvHvwRi2vXoY=; b=CFpePq5FxFBunU4P+1Josf304qc7gPkVR
        3LqNtFyY/iloWfKEcCVGATrrdWw9p6GHdVrYrkKnFgmVTvXXEBgGRAA+k4XmNu0D
        mXTubzRTQRtvacn+AssdEvmIf6BecBD+2L6rggkI6UhKzwmMyqVf7xDnTZj0v3lF
        A8HJptNaZ1RBaxURaNaUgE3tMl0MFSTHcwqWUY75HeNk+HlNmlPQ9tu+w5dzCnnY
        y2a0e8c2zKSdg1O1NJcKN4DrUObt9E9o/e6kcN+MYx9xBNHAQQYTi1nUn0UsHDFa
        CTuCOdFzak9wQ9Xceo5HcHVpyQdjJrkOg6/eXrErO8CNd2OqPN94A==
X-ME-Proxy: <xmx:dgKaW9K2HRF0JfSXbcfvRAdQH4OqjLv-w0bH0zZbrZJ-Oya__B68fQ>
    <xmx:dgKaW5kZHufGRxLLbBMkTX1I32STIFVG7QUkqPBaJsLKmugSwegHew>
    <xmx:dgKaW8merpR33p3UvBwM64Cs8fyJ2vKrA8FFB3O60AVE6Q-QlcEG_A>
    <xmx:dgKaW0qhYTeLi2UKpkHY817m813v1_eqSa1HMmXJhaE1AT_50ZKuKw>
    <xmx:dgKaWxnjhimNhxTOQZOHItRLNxEuG8_PdMx2JrQnwAIoYxYPd4M8Xw>
    <xmx:dwKaW-52rwa5k7xVUcrBKqHZiEXhwlwCzou2WxLdxv1eQwSAVklb3w>
X-ME-Sender: <xms:dgKaW7svRryqBD9TlckRzgQuOsRdXRYNanNZnlCF4tI6NVn5HDQVRQ>
Received: from localhost (124-169-9-200.dyn.iinet.net.au [124.169.9.200])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0866C102D2;
        Thu, 13 Sep 2018 02:23:49 -0400 (EDT)
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Tobin C. Harding" <me@tobin.cc>, Jiri Slaby <jslaby@suse.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH] docs: Fix filename for serial reference implementation
Date:   Thu, 13 Sep 2018 16:23:38 +1000
Message-Id: <20180913062338.27812-1-me@tobin.cc>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently documentation mentions a file but the filename has a typo in
it, underscore instead of hyphen.  This makes grep'ing for the file
hard.

Use correct filename for file amba-pl011.c

Signed-off-by: Tobin C. Harding <me@tobin.cc>
---
 Documentation/serial/driver | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/serial/driver b/Documentation/serial/driver
index da193e092fc3..86e47c19a924 100644
--- a/Documentation/serial/driver
+++ b/Documentation/serial/driver
@@ -7,7 +7,7 @@ This document is meant as a brief overview of some aspects of the new serial
 driver.  It is not complete, any questions you have should be directed to
 <rmk@arm.linux.org.uk>
 
-The reference implementation is contained within amba_pl011.c.
+The reference implementation is contained within amba-pl011.c.
 
 
 
-- 
2.17.1

