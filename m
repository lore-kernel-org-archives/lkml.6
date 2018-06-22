Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D267C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 00:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB46A22BE8
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 00:38:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="XdyGDCZ6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RvqkGld4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB46A22BE8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934217AbeFVAiN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 20:38:13 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:51209 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934094AbeFVAh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 20:37:28 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 2122521BD2;
        Thu, 21 Jun 2018 20:37:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 21 Jun 2018 20:37:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :date:from:in-reply-to:message-id:references:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=ZWpDjBEvXW0OcJ/6F
        Dm9PNrXTE/3OSO9/YP/tmlUtDg=; b=XdyGDCZ6QsWlnqjHpyFYEOr82oY7qO2CJ
        /kwG9cAqPdizd7Mnsl4buYcfC73XfwuYuX0QGfW6X51C4aEf60sT5skJ39auhazu
        +XytnKGJTXlm9WIsj3l/X+21UbddkYeyEyhsn8VQo8qRLhRN6G1DBSZn9/I30Fa5
        6hOzSv0eV9TSqX8971aEFAYGKrU5e8AFTeK8R5d1Oqzm7gC0/oCWMYdo+yyKrOWO
        rzuyERhJfvFdnWx+WibhuAMNXwH/XH+tGqtOPWPeufEkLGxcwugTjEQEtZXpUf02
        kuxCmZn3wgAJA/1ov6cWGqWTMlTq6tIHheuAc02GfqLN99T8AdCDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=ZWpDjBEvXW0OcJ/6FDm9PNrXTE/3OSO9/YP/tmlUtDg=; b=RvqkGld4
        x78lfj1cNjwPS3QVODV75uH3aLWPw0Hcn8cE5D04thD8ADqtoGJ9WLRLyv1do0LA
        Ffk1icLoiQvB5BxbopTpVvy1wI4JQhY7pUZwdJAXk4JMpb/Mk0/LKh2+YTjlD91a
        MCZ9lMhGIp6KPgfnR7aXYKymZCmR6AIz6FjloLUqLCxzhobnH577OicwuA2zq6j2
        sKuzMQk2zSMVwvRKxAv4yAVZrnjXBVQ84kjavZ6E3Q8v3FkKSpZ4EO2SdqOk7rVM
        P2dUN2jzSOAzZsSfg8IjY/31V0Dbaiav+Fsr6r8g9HWIit4rBEGA5j3F3WK/WpeP
        tIDHbsNmY+/RdA==
X-ME-Proxy: <xmx:yEQsW90S2zzMopJ5rSlFxvxAJg5UarOiDt2fTlOzAKA_58poEUjRqg>
    <xmx:yEQsW1UKy3FJeYyu0YQun61HYnmOaPataP0zE36MeqtuwuZ1y5yQmg>
    <xmx:yEQsW68hKraJ5Tu-yhor1vP2I4_nlZkZ97AhoJElhPT_nggl56LaKA>
    <xmx:yEQsW92TqwxIvtZ6_2WZhWuSR064u844RBBeC3G9s9WqZfyGzMyAxw>
    <xmx:yEQsW9cU46WX4MkFev7lai1I0EhAk-vxu4St8oqxHIf449Ee5PTSyw>
    <xmx:yEQsW93lPiEoUyFvhsEiY6kLTIxQ3om9ks87vpAzIbkh8LXybAPcyQ>
X-ME-Sender: <xms:yEQsW_1w5zMpk0sjtQv_19dnO1iP588kcQWWqO_VQ2kbSotVxfYrzQ>
Received: from localhost (124-169-15-204.dyn.iinet.net.au [124.169.15.204])
        by mail.messagingengine.com (Postfix) with ESMTPA id 56E3910255;
        Thu, 21 Jun 2018 20:37:27 -0400 (EDT)
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     "Tobin C. Harding" <me@tobin.cc>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        "David S. Miller" <davem@davemloft.net>, linux-doc@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] Documentation: e1000: Use correct heading adornment
Date:   Fri, 22 Jun 2018 10:37:06 +1000
Message-Id: <20180622003708.31848-3-me@tobin.cc>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180622003708.31848-1-me@tobin.cc>
References: <20180622003708.31848-1-me@tobin.cc>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently documentation file was converted to rst.  The document title
has the incorrect heading adornment.  From kernel docs:

	* Please stick to this order of heading adornments:

	  1. ``=`` with overline for document title::

	       ==============
	       Document title
	       ==============

Add  overline heading adornment to document title.

Fixes commit (228046e76189 Documentation: e1000: Update kernel documentation)

CC: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Tobin C. Harding <me@tobin.cc>
---
 Documentation/networking/e1000.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/networking/e1000.rst b/Documentation/networking/e1000.rst
index 616848940e63..55f28e5043b6 100644
--- a/Documentation/networking/e1000.rst
+++ b/Documentation/networking/e1000.rst
@@ -1,3 +1,4 @@
+===========================================================
 Linux* Base Driver for Intel(R) Ethernet Network Connection
 ===========================================================
 
-- 
2.17.1

