Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E8D7C4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 07:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F9742087F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 07:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="enA/Gq5F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uZdE5s3v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F9742087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbeILMyr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 08:54:47 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:49783 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726358AbeILMyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 08:54:46 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 946142188F;
        Wed, 12 Sep 2018 03:51:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 12 Sep 2018 03:51:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :date:from:in-reply-to:message-id:references:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=AcVCf0lBnriHAVWWO
        yYxiat+4C/Pp7uCNQ34XJIHJYw=; b=enA/Gq5FY81aboqQ39svKzj6tCxhPaI17
        gIzW/2s0YAKBbyEOMlCltJEpxVl0YzLievGqUvaDFCrGrUL7X1txO9/1Uifx6pIB
        Hgqfq2JkXhSnWuvdwefVY10XFuHJ3cHDC4DQsA5NL2p2yym9PVWNa8Qy/3JoNFQZ
        8Ui/+w91FA5jLKKjpv1KKbtbDxSFhnNLlrMI+NDGycfA+0uvFWKb46gT/4i5Nr3i
        lkf/KTT8Ys555icRc8u89r9wKJNA8r0ihSg++sHBjJqOzeNgtfukHyL+ojrXHdIj
        v3x/TUwk4Oa8WTHV2mieFP+DVv9mQ4Bna4wpt/A0sWaiSNhjPmgdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=AcVCf0lBnriHAVWWOyYxiat+4C/Pp7uCNQ34XJIHJYw=; b=uZdE5s3v
        CS9iSemIe38fTeoLx8h3TOBM8fSI65M+kb6ZOKqRNTuLVUj1ukVzSasCnO0be5bW
        5hkp7PHT0iunab+L+fk5/sd+rBq53xEqiF7N1+cJFR/kAw/z5AJzziFi28xp9guJ
        5xILYsZU5wGKqvG6vDYMKICWbejUH0JRXmi3r/QpkindYYLAV6HK3SDHaaRv5dCs
        PeF3cnIqPXvA4uqPQE/aeuT6kBYF+bqe9TwLrwA/LnO2LuWyO+VsCv92sC3R7fqC
        Ps9y0eGENRyL1QBVmO2TRx+l1Sayem2+Vb9aUyGV0hShnuZ9r1sRDcc6xLvhgp3/
        63bw3Ml+O1R1mA==
X-ME-Proxy: <xmx:f8WYW8woQMyH6XRmtPuzoKXoK2YWb8dsYoywsa4WzJcnS-cvKkFRGA>
    <xmx:f8WYW31coGeSu6pDLm3QxZB8C1kuXQtwaGK9W9rFx7VAahNPuGB5LA>
    <xmx:f8WYW7Bi5kWpEZoWMxwa63mroHBRzlrcTtyt4RYZ_pF5A4Gs1xgP4w>
    <xmx:f8WYWxvc1_Y2qK8zUmDy5I4Hf3faZ7v56aKo727KowNHgt7xfDBuyw>
    <xmx:f8WYW8WnmOUfBEDT_wroEhDdP-8bmplEhxzoxb6UBKksEAyCBnX59A>
    <xmx:f8WYW9IsIALjANJfwmxar9-4Cr87ydUmpGNx4YOs8Yfd-KkImA1o3g>
X-ME-Sender: <xms:f8WYW780HRhNDUr9_8w-GuVdE6TXxUmM7ir70d1YvSEWtnPjS_6KRA>
Received: from localhost (ppp121-44-246-110.bras2.syd2.internode.on.net [121.44.246.110])
        by mail.messagingengine.com (Postfix) with ESMTPA id B76A4102D5;
        Wed, 12 Sep 2018 03:51:26 -0400 (EDT)
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     "Tobin C. Harding" <me@tobin.cc>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH 3/3] tty_port: Fix kernel-docs warnings
Date:   Wed, 12 Sep 2018 17:50:44 +1000
Message-Id: <20180912075044.8695-4-me@tobin.cc>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180912075044.8695-1-me@tobin.cc>
References: <20180912075044.8695-1-me@tobin.cc>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently extracting the kernel-docs causes a six warnings of type

  warning: Function parameter or member 'foo' not described in 'bar'

Add function parameter descriptions to the function kernel-docs.

Signed-off-by: Tobin C. Harding <me@tobin.cc>
---
 drivers/tty/tty_port.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index 382282013c9d..2444ed90b93d 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -622,6 +622,9 @@ EXPORT_SYMBOL(tty_port_close_end);
 
 /**
  * tty_port_close()
+ * @port: tty port
+ * @tty: the tty
+ * @filp: the file pointer
  *
  * Caller holds tty lock
  */
@@ -657,6 +660,9 @@ EXPORT_SYMBOL_GPL(tty_port_install);
 
 /**
  * tty_port_open()
+ * @port: tty port
+ * @tty: the tty
+ * @filp: the file pointer
  *
  * Caller holds tty lock.
  *
-- 
2.17.1

