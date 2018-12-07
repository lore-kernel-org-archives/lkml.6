Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89187C64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 19:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46DBD20868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 19:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Q9GsWmYc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46DBD20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbeLGT7e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 14:59:34 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34229 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbeLGT7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 14:59:33 -0500
Received: by mail-qt1-f196.google.com with SMTP id r14so5881997qtp.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 11:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=mBbPSj085jzCFMMqKG3CT4/VTT3TFX+DDXRHOtHVaWU=;
        b=Q9GsWmYcI3O+PhWImwaT32H2r1YYtZPVZM466MMuEjCf6DTvcH3P+v6r1eyJMUoWDc
         ep50z0whA8SaoDzCxMhGx38gSune3ESInpFAl+rMpC0CJx6P2W88B4hZTVZVqETI7m7x
         5wu868OKK34EZLmED9vkVDs0byHpKVMgPM6Z/i4lNZ2IDPSVP7IOXXA+xJqf4Al2aIx5
         rB3jcCCNXAWOtfCRgW4eGfIfGebMkMNScVVAD7ZSOoqkCidC8Ec2JMSweuYxicN0TJkX
         HaMu6QR3ElEQBxI5QbhaToSff7HYVhcUfDxsB/gDA9x+9ts08oaCDqJ6H+5YA+0ADIJE
         kL0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mBbPSj085jzCFMMqKG3CT4/VTT3TFX+DDXRHOtHVaWU=;
        b=sHtR6yGtQNI2IJbiZJrTEK6Ej/LS2FlddXyXUr5NrtyDQHyhqStg6Y2u7/rEaP0DuR
         SXGxOA9AoiWf042nLnOaJiWxrEfP0lMU+CcHqDNo2SziOdZZe8XsYED+4uYZNSW055hc
         fQEkGmmSLi7FrBBOy0G8hcgcDOhn9PEkkvnIAdE9KrQ2uAX2L+KE6VRkt6XAyyBl7D5e
         5vrUv1GCFev7Ow6WZYynGDX+/Lq1vpIUVqkK0htU08cLXYnnO4QgB6Hb/ZwiOii/T5dM
         jlzgLNyJBwarWh4Kgdv3qS0f4V46Z0Oz+gxmjb5vB4HcZY8Dc2Ar6AoFbFIN71/0N+RZ
         e8fg==
X-Gm-Message-State: AA+aEWaO2qq5kNi5KjkW0LgyAu7aa8rrvw+LUkO5iA8y0ABS446EuxIH
        1YfhDNaWd2MJcXEGMFWD/knVmiBBmDI=
X-Google-Smtp-Source: AFSGD/UnyczyPvm6WWEmLJNKZWXSRRB38iVLAhWVJBjOuAwTJxANZ5ZqX3M4yHKdZ9X5CkR9Z+OVQw==
X-Received: by 2002:a0c:8d8d:: with SMTP id t13mr3352829qvb.242.1544212772666;
        Fri, 07 Dec 2018 11:59:32 -0800 (PST)
Received: from ovpn-121-90.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id v10sm2165277qkb.57.2018.12.07.11.59.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 11:59:32 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH] checkstack.pl: fix for aarch64
Date:   Fri,  7 Dec 2018 14:58:43 -0500
Message-Id: <20181207195843.38528-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is actually a space after "sp," like this,

ffff2000080813c8:       a9bb7bfd        stp     x29, x30, [sp, #-80]!

Signed-off-by: Qian Cai <cai@lca.pw>
---
 scripts/checkstack.pl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/checkstack.pl b/scripts/checkstack.pl
index 8081b6cf67d2..34414c6efad6 100755
--- a/scripts/checkstack.pl
+++ b/scripts/checkstack.pl
@@ -47,8 +47,8 @@ my (@stack, $re, $dre, $x, $xs, $funcre);
 	$xs	= "[0-9a-f ]";	# hex character or space
 	$funcre = qr/^$x* <(.*)>:$/;
 	if ($arch eq 'aarch64') {
-		#ffffffc0006325cc:       a9bb7bfd        stp     x29, x30, [sp,#-80]!
-		$re = qr/^.*stp.*sp,\#-([0-9]{1,8})\]\!/o;
+		#ffffffc0006325cc:       a9bb7bfd        stp     x29, x30, [sp, #-80]!
+		$re = qr/^.*stp.*sp, \#-([0-9]{1,8})\]\!/o;
 	} elsif ($arch eq 'arm') {
 		#c0008ffc:	e24dd064	sub	sp, sp, #100	; 0x64
 		$re = qr/.*sub.*sp, sp, #(([0-9]{2}|[3-9])[0-9]{2})/o;
-- 
2.17.2 (Apple Git-113)

