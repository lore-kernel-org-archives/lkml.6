Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E39ADC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B638620656
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NHgG99MY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbfANUm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 15:42:56 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35295 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbfANUmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 15:42:54 -0500
Received: by mail-wr1-f67.google.com with SMTP id 96so486562wrb.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 12:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E3RDm4cp9pJKRirL2B+fJTRx6kDvqJxtCFN2G5HelHM=;
        b=NHgG99MYHnbCjpF3H6HBpplXKBEQCeRVjf2lwdrTkeuGbobffP8EaEYY/V2V8tmS+E
         +ryfG14bRjJbkk0JH9H1iLEIF4vdJgczj7i+dXSI1tyz0fPKZI4bTUEgbLERDWNc8XlI
         wp3jiQZCBAgKnBhWg5lyqR1PguT2N+7l6IqIYwf9q+sLrCPu1OqTgvPVkmwT45NTHJ6N
         aWfJPopeweAJLjHH4sNb+VeOXgvnzdBRr23v2u5nWVv7jH0SbFj2AGDJhFiE6KyEhIgt
         LSFgcYJOM1uXUEHzby41K6ynqP1EQQQ2NCGxJZ5HlA7plf9Vp2VSO2y4gw8/7cyys8mS
         kxdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=E3RDm4cp9pJKRirL2B+fJTRx6kDvqJxtCFN2G5HelHM=;
        b=Dtv7m99q45PkR8DQkXeWBFa5yCcXf5kFdZ4Ey03dRgPIRM7OjB3PPiYi42okGiayOs
         aEe/KBZ77iYPLcy+fhfjFI9IAEABpl1yLp3wncHaDwLIimwhFV8xAyx5wjbJaMtxOWPV
         GbRklj9cDXtnlovC11HIND4dl9X9f2LN9xbY2HOd9ACvTFnp9ltJn1rW/ZV1VPWXsRfA
         kPbKsNqs5QQtGYnqYYSdNyv9gu27hGgAbb80+FN3bBIiyjJ+Lx3BVMN91KpGcODNWgs5
         n5Zq0GDn/VIGP9KiCF7zAMVFcXKEIQ/HfeisZ1wwr6BN9dMtw7ZKoz857ImXgmQAd+BC
         wgRg==
X-Gm-Message-State: AJcUukfClUmyj2IWSyVVNSOzcs6+xc6J7txtY5dPN1+uvglCbxSd86ao
        0M+TkkGsAMn05gejji4LheQ=
X-Google-Smtp-Source: ALg8bN7CXPr1eoPwrSVPvmGluEj97pmJ+uHF5cRoTwB0IGIuPGYXDO1pEHdR51c6QnyCO+SmBzTH+g==
X-Received: by 2002:a05:6000:1287:: with SMTP id f7mr241767wrx.302.1547498571875;
        Mon, 14 Jan 2019 12:42:51 -0800 (PST)
Received: from macbookpro.malat.net (bru31-1-78-225-224-134.fbx.proxad.net. [78.225.224.134])
        by smtp.gmail.com with ESMTPSA id e17sm123330378wri.36.2019.01.14.12.42.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 12:42:50 -0800 (PST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id E46D911422AD; Mon, 14 Jan 2019 21:42:49 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc:     Mathieu Malaterre <malat@debian.org>,
        linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] firewire: annotate implicit fall through
Date:   Mon, 14 Jan 2019 21:42:41 +0100
Message-Id: <20190114204241.21712-2-malat@debian.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190114204241.21712-1-malat@debian.org>
References: <20190114204241.21712-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a plan to build the kernel with -Wimplicit-fallthrough and
this place in the code produced a warning (W=1).

In this particular case add a ‘-’ so as to match the regular expression
expected by GCC.

This commit remove the following warning:

/drivers/firewire/core-device.c: In function 'set_broadcast_channel':
../drivers/firewire/core-device.c:969:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
    if (data & cpu_to_be32(1 << 31)) {

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 drivers/firewire/core-device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firewire/core-device.c b/drivers/firewire/core-device.c
index 7c2eed76011e..e41d55b04940 100644
--- a/drivers/firewire/core-device.c
+++ b/drivers/firewire/core-device.c
@@ -970,7 +970,7 @@ static void set_broadcast_channel(struct fw_device *device, int generation)
 				device->bc_implemented = BC_IMPLEMENTED;
 				break;
 			}
-			/* else fall through to case address error */
+			/* else fall through - to case address error */
 		case RCODE_ADDRESS_ERROR:
 			device->bc_implemented = BC_UNIMPLEMENTED;
 		}
-- 
2.19.2

