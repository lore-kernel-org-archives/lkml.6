Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 954A4C67792
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 21:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AF412146E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 21:43:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="DHvh58vF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uk0BXNzC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AF412146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390521AbeGKVtZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 17:49:25 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:43637 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732931AbeGKVtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 17:49:25 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 42530299;
        Wed, 11 Jul 2018 17:43:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 11 Jul 2018 17:43:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :date:from:in-reply-to:message-id:references:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=Lutjf3HTqXC92WZai
        cOaFEjkhSWLjkvQ8Sfbc7Px4z8=; b=DHvh58vFfwN+T7d9k+FyJsxXIicQU2X0n
        ZZtMBtEALUzqpz6aR64Va+fILK+3ZTiIuO42ZcfaG+ww69l5eH1oyNIFMxXZQszK
        zucZ/yrEy+Qnu5vK8KMcuZ/n8zRyySs4Csi1+65b1CXQhRsXwJ53OlTY7HnqDGWs
        /S2B2thfCJVyFHVO1LKwUJcZbHulcRnIMKOSQXb7dN3twK3H6riiuq5clmnNREAH
        T3Td53K03q1qygfBLVFM1Z4MpT30CmtnQHvqax8BeaXG7IzaDCobLoZ74zE71g5o
        iag3HB42OGTdPd3dt8K8Ajl4qEYoPbemSxJL8i3u3c+LLRatgWLRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=Lutjf3HTqXC92WZaicOaFEjkhSWLjkvQ8Sfbc7Px4z8=; b=uk0BXNzC
        tpM2EJI2fFcGzk6fhVmukjLn3uM34JKHVH8Uuhx+HJkQGzodwD271Q3993hsfjbf
        vE2M6ziCeOVC2dri1qc7wyH8FH1XItVTiRvhHoUjzl1WESDZfjM4qOz/uoERsL0J
        sBR1UkT6BqRgwdfJWD6e4OsPvUl9LNEqtYg7FtlyWg+2QnptuiSIQtwYR16uoux2
        dDw+DEElYUabafdM5Jkwxlijh7V3mb2r35xxhvIElU6vTUC6fvUN0H5YnD+wo4Er
        8MXMeiNOwBz6MDwNvFbvNe8eLk3Rkl9yCwNQLj7MDjxu3s8dJ5pDdJvX6FF3pYks
        E7ueogh5I8djfw==
X-ME-Proxy: <xmx:53lGW69pMQqRE2G0JEzQg4-TyyC0lcnVkAlrQRRZUYIRB72zNN-uvg>
    <xmx:53lGWx1A7hisZvM57bpGnNFpCB-innwkHps7piWSVVXxbe8TTUQbLw>
    <xmx:53lGWyUxX6_uUQN9mIHdYhheFb568O6w-v_UuOhX7HrkaLYV7UUjiw>
    <xmx:53lGW7PNDC-7sPUOPTYTKc2y8z1SBcIGy4aAPyTMJWE8ED1SMqijcA>
    <xmx:53lGWyJVQVPoaGIvlJVYNXLzR2xf4Ya9_AWdAjZnLmnOsrhF0ZP2vw>
    <xmx:53lGW54RjolgWZ8Hsijfpd2MbUPRRqp0UkkDb0IrmO-cMzz8LkCtZA>
X-ME-Sender: <xms:53lGW3R9H8-XjUTldIfv7sJ4NmEaD9SZE7umf4MTFCsAu-SxidzCpg>
Received: from localhost (ppp121-44-208-89.bras1.syd2.internode.on.net [121.44.208.89])
        by mail.messagingengine.com (Postfix) with ESMTPA id 13381E4855;
        Wed, 11 Jul 2018 17:43:02 -0400 (EDT)
From:   "Tobin C. Harding" <me@tobin.cc>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     "Tobin C. Harding" <me@tobin.cc>,
        Sridhar Samudrala <sridhar.samudrala@intel.com>,
        linux-doc@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/2] docs: networking: Add failover docs to index
Date:   Thu, 12 Jul 2018 07:42:49 +1000
Message-Id: <20180711214250.19039-2-me@tobin.cc>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180711214250.19039-1-me@tobin.cc>
References: <20180711214250.19039-1-me@tobin.cc>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we have rst format docs for the failover and net_failover
modules however these docs are not linked to within the index.

Add `failover` and `net_failover` to the networking documentation index.

Signed-off-by: Tobin C. Harding <me@tobin.cc>
---
 Documentation/networking/index.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
index fec8588a588e..6123a7e9e1da 100644
--- a/Documentation/networking/index.rst
+++ b/Documentation/networking/index.rst
@@ -15,6 +15,8 @@ Contents:
    kapi
    z8530book
    msg_zerocopy
+   failover
+   net_failover
 
 .. only::  subproject
 
-- 
2.17.1

