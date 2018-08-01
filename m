Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 038F1C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 05:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEA1C20841
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 05:10:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="JrdxOi7+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oX3jNJoX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEA1C20841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733259AbeHAGxo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 02:53:44 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:57167 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733057AbeHAGxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 02:53:43 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 5DE3E57E;
        Wed,  1 Aug 2018 01:09:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 01 Aug 2018 01:09:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :date:from:in-reply-to:message-id:references:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=l0shLeptNupfOvx/i
        eZtlDPz1a0bI2fXG5YS5l7Rxm4=; b=JrdxOi7+7rmiuSQw9lPTZgiMUuVOkuXpq
        2H7a84Ae6bAqhnX7YwRyPS/+u+TDcPQagSHzMGJxOv6lHtO7mvW1J/GrAcO0WLE1
        oxAZvWTMhXoNnj2wIYLdl6d/R3ALFYZJgo7EHPaEV1bq11Y9nLpNe7DlZfOV5rqg
        MbYmNCtSOUbvpXQPm/SjDz0LHPbmDJ8XvxclPi5CWQfZm5VtMzJXe6eMtH7/FCqq
        DqmXJzCkji4OS3xeyziUjIpIHRrGU95DwR08GujOiIzyH3l+/7LFznFB5YMhD51U
        Km/j7FodRVZkz0WOlC/O2BK6WSvfp3azUzNglKbUvo69Ne/QR69XQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=l0shLeptNupfOvx/ieZtlDPz1a0bI2fXG5YS5l7Rxm4=; b=oX3jNJoX
        SN34+NuUNyfdCfdPI0P0C1AYf2jozq8g8txLQmFUsPbXnwlZ/6+NPqRbxYdXQS8Q
        VpmpHEQ9VxzS1m02YNLttD7ye35cXXWq5NHLVL45fKKFk9TAiuDvqwFhRunc8Zxq
        YxgilkPvRgj+c1/niBjzKvM7NvPcnqQJmiJkOpWFXh4U4I1VzGCXjED0Wr/NpjAz
        TWw2E7Dr4Vk8vG0hqecKRIZDhs06xJtQK2iX8ztMJALGB9dJ0xIT+8ccXPoPCorz
        3aRzimKhbOVODEe2Il/i3R2oenZGhnRfbBs5JFaFwK6G9z6+lbZxiKDHLw/yXNuP
        KsFwWHfsYiyNiQ==
X-ME-Proxy: <xmx:pkBhW_xyOc6lj_XbxAfkFDmwqsSizTW0THajhiiPM_KLdaXt1LzP5g>
    <xmx:pkBhW1Om7huurr36X3LXk28qWC2Z9asvpggeGTw6CVbJ9ztjo2-URA>
    <xmx:pkBhWw7hVYaG33L5EqJ1Ng-I-1BtJgv8AHAxxMB6CryfjhElaoPyCQ>
    <xmx:pkBhW2NSQ5VoSqI8kU1bibsMb1VLBxgIKWyR5a8JO0bLGxsgmgDyzQ>
    <xmx:pkBhW-m4h7KOgCp1OOWzFabow8qzuq83EoIrx9U5plSMl1p4SAiphA>
    <xmx:p0BhWwPIt9UNY2S8ccHhJUsDzI4Hg4cVNslou8qR6vQsLxqWw_d2uQ>
X-ME-Sender: <xms:pkBhW7wcux_IRkOeV-_NW5mpB0Z98hnctWxSfkkZH5RhK_YnzgqBVw>
Received: from localhost (124-169-17-12.dyn.iinet.net.au [124.169.17.12])
        by mail.messagingengine.com (Postfix) with ESMTPA id 297CE10255;
        Wed,  1 Aug 2018 01:09:57 -0400 (EDT)
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     "Tobin C. Harding" <me@tobin.cc>, Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>, linux-doc@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 09/13] docs: net: Use lowercase 'k' for kernel
Date:   Wed,  1 Aug 2018 15:09:04 +1000
Message-Id: <20180801050908.29970-10-me@tobin.cc>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180801050908.29970-1-me@tobin.cc>
References: <20180801050908.29970-1-me@tobin.cc>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The whole document uses a lowercase 'k' for 'kernel' except in one
instance.  The kernel community also favours a lowercase 'k'.

Use lowercase 'k' for kernel instead of uppercase 'K'.

Signed-off-by: Tobin C. Harding <me@tobin.cc>
---
 Documentation/networking/filter.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/networking/filter.rst b/Documentation/networking/filter.rst
index dda1afdb5f26..10c4eab042df 100644
--- a/Documentation/networking/filter.rst
+++ b/Documentation/networking/filter.rst
@@ -9,7 +9,7 @@ Introduction
 
 Linux Socket Filtering (LSF) is derived from the Berkeley Packet Filter.
 Though there are some distinct differences between the BSD and Linux
-Kernel filtering, but when we speak of BPF or LSF in Linux context, we
+kernel filtering, but when we speak of BPF or LSF in Linux context, we
 mean the very same mechanism of filtering in the Linux kernel.
 
 BPF allows a user-space program to attach a filter onto any socket and
-- 
2.17.1

