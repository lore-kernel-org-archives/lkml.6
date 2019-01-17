Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B1DC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 21:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A606620859
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 21:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GsFg+OtO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbfAQV6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 16:58:47 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40119 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbfAQV6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 16:58:42 -0500
Received: by mail-wm1-f65.google.com with SMTP id f188so2653425wmf.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 13:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VZIjDarfLCA3ThU2E8+eOGJiNH4Czyf2iM8xpjRpyB8=;
        b=GsFg+OtOEgJNAVlMlwjDdRnjdzTaYBmNdo2YNdudpBjXvBt34wn6L4wZlmoLTVXsg4
         1lgN8OG5e724X6WqFyH0Emr7xqNGaT5ZN2mwEQCm5wj/UycHhBY0CdsxuBsyidXUTOu4
         w4OLD6sqSNsLgOhbbQW4gJWRNcUJGqq9XgdYOZOPhQKcJ5nC1eKzfW4yPikB/uk72auX
         9FdgMimWHNjfn7h0gaLwvvVHaQqXSH+uwNkgUg1lQLpevVcUy1uPuFZDGvXM3kGWsabv
         gXoEKHntmI8mChEDdR3YJ3/Zo4tRKRYibZ6zt6f4Glkrdkee9OwP5hF1G9Z52bYKgUkv
         GPKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VZIjDarfLCA3ThU2E8+eOGJiNH4Czyf2iM8xpjRpyB8=;
        b=JkMs4crBB3GkBwvIpRFYDWL2ustp5Aj52Oz8IUlSL9sb6bS1sq3cUHwysIGHWy3wY8
         5Xr6mv9xap6rZBe3ZClyjKiZ3ulOkZod3Wb6B73OjeF3ljcLX4Hy11hsxTqUb3PvliGQ
         Wi3dcisG79LWz/aJbhRc5l3BeiWq7OoLYNu7yyw/unBkiFZ0CtqtbsNRcDsFDedBSpKV
         koQOfmww7x3encYDkm1oukxBU4t/W+lGQJhecMIP8kv8Xa3gl/6ualh6aT3pp5bqMUtN
         VPyQexX7GeKjKsQOTJStbpo+Ky9AP5vYuA2ylhafbQgqLtvdjKcZjEx5CnKLYRCOR5vX
         HSow==
X-Gm-Message-State: AJcUuke/SZLiHT14vqXCaqkvwSV+xbbHMgUIbMRmQ/T28pe0VTQDeIOh
        avdn0TfmzL9fihC+Pl7ZneQ/vqkd
X-Google-Smtp-Source: ALg8bN6sVY07pLpDLBbHrhVcpqCY2+atwF96kiHk5IY++fV7TgH8iixb2sqJf9E/kvrkJFyD1ND5RA==
X-Received: by 2002:a1c:cbcb:: with SMTP id b194mr12403601wmg.64.1547762320624;
        Thu, 17 Jan 2019 13:58:40 -0800 (PST)
Received: from nbbrfq.loc (85-127-81-11.dsl.dynamic.surfer.at. [85.127.81.11])
        by smtp.gmail.com with ESMTPSA id b13sm76598246wrn.28.2019.01.17.13.58.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 13:58:39 -0800 (PST)
Received: from b by nbbrfq.loc with local (Exim 4.92-RC4)
        (envelope-from <b@nbbrfq.loc>)
        id 1gkFgM-0006oS-Jd; Thu, 17 Jan 2019 22:58:38 +0100
From:   Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>
Subject: [PATCH 1/2] checkstack.pl: Add blackfin support
Date:   Thu, 17 Jan 2019 22:58:35 +0100
Message-Id: <20190117215836.26137-1-rep.dot.nop@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We've been carrying this since some time now.. Original submission:
http://lists.busybox.net/pipermail/busybox/2007-August/028420.html

Signed-off-by: Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>
---
 scripts/checkstack.pl | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/checkstack.pl b/scripts/checkstack.pl
index 122aef5e4e14..8946fc99ad83 100755
--- a/scripts/checkstack.pl
+++ b/scripts/checkstack.pl
@@ -13,6 +13,7 @@
 #	sh64 port by Paul Mundt
 #	Random bits by Matt Mackall <mpm@selenic.com>
 #	M68k port by Geert Uytterhoeven and Andreas Schwab
+#	blackfin port by Alex Landau
 #	AArch64, PARISC ports by Kyle McMartin
 #	sparc port by Martin Habets <errandir_news@mph.eclipse.co.uk>
 #	ppc64le port by Breno Leitao <leitao@debian.org>
@@ -54,6 +55,9 @@ my (@stack, $re, $dre, $x, $xs, $funcre);
 	} elsif ($arch eq 'arm') {
 		#c0008ffc:	e24dd064	sub	sp, sp, #100	; 0x64
 		$re = qr/.*sub.*sp, sp, #(([0-9]{2}|[3-9])[0-9]{2})/o;
+	} elsif ($arch eq 'blackfin') {
+		#      52:       00 e8 03 00     LINK 0xc;
+		$re = qr/.*LINK (0x$x{1,5});$/o;
 	} elsif ($arch =~ /^x86(_64)?$/ || $arch =~ /^i[3456]86$/) {
 		#c0105234:       81 ec ac 05 00 00       sub    $0x5ac,%esp
 		# or
-- 
2.20.1

