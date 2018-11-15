Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC8FC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 07:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21B2421582
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 07:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=birdec.tech header.i=@birdec.tech header.b="UL9F8l9+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21B2421582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=birdec.tech
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728763AbeKORSk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 12:18:40 -0500
Received: from host.euro-space.net ([87.117.239.2]:49874 "EHLO
        host.euro-space.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbeKORSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 12:18:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=birdec.tech
        ; s=default; h=Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=sCmAKiKJu59sACgmj3seeQw2pfDdH3bZAwVAgFcLffk=; b=UL9F8l9+7c7TUoTvN9eqUskHCB
        Gzm7IYg6yANduYlDzvPxs9J0jfnS1F7N6JqZXGeM/1vT1mpNXkjfvEkCmtmfsO1SzbnnmNXFoY/Tx
        SU8I5xlMY6zHRSlFpoUGpy3BFHrlkz7aydgUohxSZnhq5FrnEuk8yfW7dkPwSc/5PGmBsE+iNh+0f
        9WjCyx9OYVlgNFTF+A0o8oTUI3t7PgfqbJbjRzK2kuPPiKutfZmqxWQTHZsfS3mLgwe9lzRvM3/sp
        2zNVaehlnN5iyz7hbYte9NYWKhnUYi5y4QHF1EJIOpqeEXPjF/YyV8Bn9/hGnlT05bouKdvS9T5/m
        3PU8g2WA==;
Received: from xd52789b9.dyn.telefonica.de ([213.39.137.185]:58262 helo=gentoo0.localdomain)
        by host.euro-space.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <kmarinushkin@birdec.tech>)
        id 1gNBog-0007kv-J5; Thu, 15 Nov 2018 07:11:54 +0000
From:   Kirill Marinushkin <kmarinushkin@birdec.tech>
To:     Mark Brown <broonie@kernel.org>
Cc:     Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Kirill Marinushkin <kmarinushkin@birdec.tech>,
        devicetree@vger.kernel.org
Subject: [resend PATCH] dt-bindings: sound: Add documentation for pcm3060 property out-single-ended
Date:   Thu, 15 Nov 2018 08:12:53 +0100
Message-Id: <20181115071253.22558-1-kmarinushkin@birdec.tech>
X-Mailer: git-send-email 2.13.6
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - host.euro-space.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - birdec.tech
X-Get-Message-Sender-Via: host.euro-space.net: authenticated_id: kmarinushkin@birdec.tech
X-Authenticated-Sender: host.euro-space.net: kmarinushkin@birdec.tech
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Output of pcm3060 codec may be configured as single-ended or differential

Signed-off-by: Kirill Marinushkin <kmarinushkin@birdec.tech>
Cc: devicetree@vger.kernel.org
---
Hello Mark,

yesterday there was a misunderstanding: when I wrote you

> I think you forgot one patch in the series

you accidently applied the already-applied patch instead of the forgotten
one. To avoid the confusion, in this e-mail I resend you the proper
forgotten patch in a separate mailing thread.

Please apply this patch for-next.

Best Regards,
Kirill
---
 Documentation/devicetree/bindings/sound/pcm3060.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/pcm3060.txt b/Documentation/devicetree/bindings/sound/pcm3060.txt
index 90fcb8523099..97de66932d44 100644
--- a/Documentation/devicetree/bindings/sound/pcm3060.txt
+++ b/Documentation/devicetree/bindings/sound/pcm3060.txt
@@ -9,9 +9,15 @@ Required properties:
 - reg : the I2C address of the device for I2C, the chip select
         number for SPI.
 
+Optional properties:
+
+- ti,out-single-ended: "true" if output is single-ended;
+                       "false" or not specified if output is differential.
+
 Examples:
 
 	pcm3060: pcm3060@46 {
 		 compatible = "ti,pcm3060";
 		 reg = <0x46>;
+		 ti,out-single-ended = "true";
 	};
-- 
2.13.6

