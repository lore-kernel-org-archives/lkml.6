Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 288F9C46463
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 05:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D49DC208A2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 05:10:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="V6BoSBOE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ASpbzro/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D49DC208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387427AbeHAGyA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 02:54:00 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:46101 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733055AbeHAGyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 02:54:00 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 9E1DA584;
        Wed,  1 Aug 2018 01:10:16 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 01 Aug 2018 01:10:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :date:from:in-reply-to:message-id:references:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=vEoAdNED6P7p/ahY+
        NikoYgfaHHcAOvlbDezmhyznBU=; b=V6BoSBOE2W9GXX4z1VtcQPQMZl8ItbthN
        xVFFnTFrC0jZVy1Oy0dBL4hDtz/DEV/pL/5KUE5HZH0UK+LcwEchtWaXEDDnw3DW
        fF72e8NlM9QNBJrOed8TG40qNSTIsIwWUp+2ZYNnLV/Wpl05r497GYGmyb5fVRKF
        X2LRq1hE3rkWwRheKVx/Bnru/40O1utuLuPFrFvxXpXop4XIa8S565qbml7c4IGu
        bMiVhb0XP1T9wBz5XPac+APZZ9tb6abPebu5q9OamMeOzN9g4qjivUSviYgJPBxs
        iKkFaB3w7DL0pjm0O8jUl51Vr9M8j4vfcjvg2og9C4jyCZrF7JpNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=vEoAdNED6P7p/ahY+NikoYgfaHHcAOvlbDezmhyznBU=; b=ASpbzro/
        NxeinskNLL7K8Ds9svw7seDpcfU0xp52DVGcL/Dho2cuDR8fV70DTysX9DiqFRpY
        GnkEz1zWbZ6jTXQRQAtR0861FqKrwukUeHA0UjED/FIX4kVp19jogEfn0lWVDHO9
        yhI0L14DR0/m3vr2+jWX7gx2X4tsi3rVG20rJbwRLFxG6iclzcvkvtU9zbl/9Nax
        rXcokt2rrBxwC7XRxnlYY83k4XZYo53Q3J/OQtdTapxtJu882v09qphBRjjrGcBe
        XxNfR4DnXRxCAadFBzDBnEnoqc2Lw2wuWlDSt9N7zWk+7kgos9DMUqoHIOxZZQzw
        KB4el0LmbIHJSA==
X-ME-Proxy: <xmx:uEBhWzM2XgdorRbpYt3X_0UEMlIpXRlWLwAreK695uvHQh8o66sN7g>
    <xmx:uEBhWx4PPJ48CvY707skUvk2UPbOkQqh9Vdf8RVLHJfRFUVA_1v7iA>
    <xmx:uEBhW7ViAogUQbgvvAZbBGo26Ui02o2S0sVlloG18Z_-0HA_IfsWIw>
    <xmx:uEBhWwMtNbuRoF6UbUw5o-s9ayyPWY18Ibv6pCmgRVgfyFQprtQw5w>
    <xmx:uEBhW7A2HuGsCg6m5-4HbbPYN4Y_mQPS_r61hhPwIGaeg1h4rvLY5w>
    <xmx:uEBhW1PEzT17_XzW4ymDM6kGX76VzSOHl4e4AiV4OKdgVdr_GFQ1DQ>
X-ME-Sender: <xms:uEBhW7_ve7g8fJ99htHWu-rxNRYRptUBZmHrte_SlsDRcMod3ETBzA>
Received: from localhost (124-169-17-12.dyn.iinet.net.au [124.169.17.12])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4DDE9E462B;
        Wed,  1 Aug 2018 01:10:15 -0400 (EDT)
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     "Tobin C. Harding" <me@tobin.cc>, Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>, linux-doc@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 13/13] docs: net: Fix authors list to render as a list
Date:   Wed,  1 Aug 2018 15:09:08 +1000
Message-Id: <20180801050908.29970-14-me@tobin.cc>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180801050908.29970-1-me@tobin.cc>
References: <20180801050908.29970-1-me@tobin.cc>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently authors list renders on a single line in HTML.  The text
format implies that a list was meant.

Use RST list construct to fix authors contact details to be rendered as
a list.

Signed-off-by: Tobin C. Harding <me@tobin.cc>
---
 Documentation/networking/filter.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/networking/filter.rst b/Documentation/networking/filter.rst
index b989a6c882b8..1913718e3f2a 100644
--- a/Documentation/networking/filter.rst
+++ b/Documentation/networking/filter.rst
@@ -1532,6 +1532,6 @@ The document was written in the hope that it is found useful and in order
 to give potential BPF hackers or security auditors a better overview of
 the underlying architecture.
 
-Jay Schulist <jschlst@samba.org>
-Daniel Borkmann <daniel@iogearbox.net>
-Alexei Starovoitov <ast@kernel.org>
+- Jay Schulist <jschlst@samba.org>
+- Daniel Borkmann <daniel@iogearbox.net>
+- Alexei Starovoitov <ast@kernel.org>
-- 
2.17.1

