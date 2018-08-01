Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66BCEC46462
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 05:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D0F320841
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 05:09:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="I34rT4TA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gcX5wWLO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D0F320841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733199AbeHAGxd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 02:53:33 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:43197 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731897AbeHAGxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 02:53:33 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id B32465A9;
        Wed,  1 Aug 2018 01:09:48 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 01 Aug 2018 01:09:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :date:from:in-reply-to:message-id:references:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=z1R3eoUnFc0Tiga+5
        CjudKJUG+S+fK7wqMn3SI49NC8=; b=I34rT4TAYbhrfeqX3OPXQB+ai724BT902
        dVYXLB3AU+Ta5ALCKPotMFK0VC/UUFCKF+rCD3VO2kp4YRI9of2eRgA6TGZtvTyd
        X/8GQHKl4LfktoRc449hur10gDnf3IihqztwjpMae53w4deOs3IoR1AUUn2DygM0
        ESIb8/tGPQnBk0JFN5TBLxLsIAV+I/8duFt+OAPz4aRbY/lZmklpjuewAKQj6kS1
        NJrE+w27wzcY0B8iF6+dtEu5Ik5M9Q/y7PIyqrvye5ystP8Ta3FGqNoHjhDmeXz4
        N6A+uKUgRXAlC6U91PqSkh8pG5VpyDJOkvGDUKkS2vl0YNDgjX0CA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=z1R3eoUnFc0Tiga+5CjudKJUG+S+fK7wqMn3SI49NC8=; b=gcX5wWLO
        DXMVlwiep2MnRTQERf2xz6aOCeir2MX585W0rLR8p3cKdTBkrizvIxI4Mt84ZcAX
        pDVl/4aVPbF/6w+y7+Q0GUFvLBE90fLHAXZZ+7Uc2dfXPOUYREO3qK5g60sV2eTa
        GHQUAfrNFBvy5CjI3KCXtZsTQhJLdlp8Msj1eS0lJt4SbcszQ6khcKEt/ZXa4dKB
        W4nXRl1NDILnAvC1xvQHpg+P6faYHfNXkzsL2rwuD69EeoMKu01rIZ+8kqw+5OCE
        sFNwHDUJWucJFTMuKgguzPEZ3qewO8C1bm6fq6MsIlhf0SOlCebXRj9ziMeUpoaM
        i8mdGWwhRaEBZA==
X-ME-Proxy: <xmx:m0BhWzRbYPRwZT8uTdkxV6F_YGCaFgJ2IH7dGTP_mGjIa9dgf2oDAg>
    <xmx:m0BhWzfzKB2YD350zSVqAxKWHGkUWaow_vwAFgdWvgeowznDM0SF3g>
    <xmx:m0BhW7EZlLV2sMbhkMsuZ9ztZZRYm4ICuC_72hySSEoKIUTa4jUTVg>
    <xmx:m0BhW8LE7UUkMmOj8ZMPOZnlz4jZLuKSQUDqUdxdWZuCsA40RK3JqQ>
    <xmx:m0BhWxusmWPucJ75BKpeM-FeO0TncqPUwzZCo0xTdbL0UMbshVphWg>
    <xmx:nEBhW8YDCXnW81hjVziDphHoDhoprhTKJ1LZ_Nsp_gxL8VSkJlPZzQ>
X-ME-Sender: <xms:m0BhW49WYig8Ks2fG_YnkKYJiiw6Ebql6ZAc_VT_HyRirYn3gLKDfQ>
Received: from localhost (124-169-17-12.dyn.iinet.net.au [124.169.17.12])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3BCD11026B;
        Wed,  1 Aug 2018 01:09:46 -0400 (EDT)
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     "Tobin C. Harding" <me@tobin.cc>, Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>, linux-doc@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 06/13] docs: net: Remove non-standard identifiers
Date:   Wed,  1 Aug 2018 15:09:01 +1000
Message-Id: <20180801050908.29970-7-me@tobin.cc>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180801050908.29970-1-me@tobin.cc>
References: <20180801050908.29970-1-me@tobin.cc>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

File uses a custom identifier '**'.  Documentation build is cleaner if
we use standard identifiers.  Usage is not _really_ a list and its not
_really_ a section header.  Lets just remove the double stars since
we just added code snippet format for following text so the identifiers
are redundant now.

Remove non-standard identifiers '**'.

Signed-off-by: Tobin C. Harding <me@tobin.cc>
---
 Documentation/networking/filter.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/networking/filter.rst b/Documentation/networking/filter.rst
index 916e7ac01576..62630e8f023a 100644
--- a/Documentation/networking/filter.rst
+++ b/Documentation/networking/filter.rst
@@ -292,14 +292,14 @@ Possible BPF extensions are shown in the following table::
 These extensions can also be prefixed with '#'.
 Examples for low-level BPF:
 
-** ARP packets::
+ARP packets::
 
   ldh [12]
   jne #0x806, drop
   ret #-1
   drop: ret #0
 
-** IPv4 TCP packets::
+IPv4 TCP packets::
 
   ldh [12]
   jne #0x800, drop
@@ -308,14 +308,14 @@ Examples for low-level BPF:
   ret #-1
   drop: ret #0
 
-** (Accelerated) VLAN w/ id 10::
+(Accelerated) VLAN w/ id 10::
 
   ld vlan_tci
   jneq #10, drop
   ret #-1
   drop: ret #0
 
-** icmp random packet sampling, 1 in 4::
+icmp random packet sampling, 1 in 4::
 
   ldh [12]
   jne #0x800, drop
@@ -328,7 +328,7 @@ Examples for low-level BPF:
   ret #-1
   drop: ret #0
 
-** SECCOMP filter example::
+SECCOMP filter example::
 
   ld [4]                  /* offsetof(struct seccomp_data, arch) */
   jne #0xc000003e, bad    /* AUDIT_ARCH_X86_64 */
-- 
2.17.1

