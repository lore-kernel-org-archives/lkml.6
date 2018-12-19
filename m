Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 198BEC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 18:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEF1A217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 18:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OmwtQoHI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730139AbeLSSz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 13:55:59 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35539 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730113AbeLSSz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 13:55:59 -0500
Received: by mail-lf1-f67.google.com with SMTP id e26so15849661lfc.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 10:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=aNpSYGTJBPe+B6DOcNVyZqo0sJTGOuZ2mVZRPnS37yY=;
        b=OmwtQoHITzrvP0OEF3vyZFhB9tYDQvz0ozN0KuIaFKvFbwq5VlOTvfJoxlWjUv2TyP
         NXpnSJbk2YSZ7Mw6pP6kjngfSnkRqFrD1yCuFTclF7g8i+XWQNXmmoIhwfn3ICH5Sme5
         5fsFhZBrZaZuhdupGzRjz2zb65V/7T6AdoNi2A4B6Sd8ncVNzvjZaorsR1GafuD6WXUk
         Bcg7i7tQ7MkVPm4i5bN7+/JU0nK1YhnM3bshZlBSODRcly/piyKeciXuwFitBKcjrqeQ
         4ppXTl6isrGcSP4ugWnTc0zizQ2OZqHlbo/CwD9QY0os8gfjvbdsf8greUA90ygw98YD
         LHqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=aNpSYGTJBPe+B6DOcNVyZqo0sJTGOuZ2mVZRPnS37yY=;
        b=kne3Iq3HpAPVp7OwIhY0TweG24Ea7i1az+POERuO2QAoOzQcI0k1kyifC5B/JVYhpa
         T1bbIB5ao/TCtJHLnYzyMD4G+n6xg8MfckDTv7a62bEYU3nXJegKIs25tqUTDjAReWXU
         etEotedRhEDapptSIpHqdUClLk4UdC77SUmkDnIM/g2/vcI/JduR+FLOE8uY8yW/ioeh
         vVaHNLS4sP3hshlIZ6qcMY4FnECkschjQrl3cn38cFXIMiaSGdU05V2f4UHboGb7jWnd
         ZPZ3QwZfQ5wJuXGVb3Za5kQOUk7pvl1q3HwKitiBw+i3l/njIxbLnbHVZ1ox1y8ULC+F
         PQCg==
X-Gm-Message-State: AA+aEWYR3aYnRx6kr+myeu6RWsHx194X8wqokp7eveVI8HRGULXW/xw+
        TfLxlPVb9kk1czS68Z8Ch0s=
X-Google-Smtp-Source: AFSGD/XVeCEAcK8kAPGoZjWkfG8fXPsvrR22QSDqyrhOuME7K1SkLkqVBAyu3W9zC9PBJ1oahUXltQ==
X-Received: by 2002:a19:3809:: with SMTP id f9mr2676549lfa.148.1545245757194;
        Wed, 19 Dec 2018 10:55:57 -0800 (PST)
Received: from localhost.localdomain (dmhwpt3bffxn8z3-j6k-4.rev.dnainternet.fi. [2001:14bb:51:a4c8:5c24:24d7:ca5f:e7d2])
        by smtp.gmail.com with ESMTPSA id p77-v6sm4352963lja.0.2018.12.19.10.55.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 10:55:56 -0800 (PST)
From:   Igor Stoppa <igor.stoppa@gmail.com>
X-Google-Original-From: Igor Stoppa <igor.stoppa@huawei.com>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
Cc:     igor.stoppa@huawei.com, linux-kernel@vger.kernel.org
Subject: [PATCH] checkpatch.pl: Improve WARNING on Kconfig help
Date:   Wed, 19 Dec 2018 20:55:44 +0200
Message-Id: <20181219185544.6720-1-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <0fcf870749cae85490aa17cd637e2c933a792c90.camel@perches.com>
References: <0fcf870749cae85490aa17cd637e2c933a792c90.camel@perches.com>
Reply-To: Igor Stoppa <igor.stoppa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The checkpatch.pl script complains when the help section of a Kconfig
entry is too short, but it doesn't really explain what it is looking
for. Instead, it gives a generic warning that one should consider writing
a paragraph.

But what it *really* checks is that the help section is at least
.$min_conf_desc_length lines long.

Since the definition of what is a paragraph is not really carved in
stone (and actually the primary descriptions is "5 sentences"), make the
warning less ambiguous by expliciting the actual test condition, so that
one doesn't have to read checkpatch.pl sources, to figure out the actual
test.

Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
CC: Andy Whitcroft <apw@canonical.com>
CC: Joe Perches <joe@perches.com>
CC: linux-kernel@vger.kernel.org
---
 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index c883ec55654f..33568d7e28d1 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2931,7 +2931,7 @@ sub process {
 			}
 			if ($is_start && $is_end && $length < $min_conf_desc_length) {
 				WARN("CONFIG_DESCRIPTION",
-				     "please write a paragraph that describes the config symbol fully\n" . $herecurr);
+				     "expecting a 'help' section of " .$min_conf_desc_length . "+ lines\n" . $herecurr);
 			}
 			#print "is_start<$is_start> is_end<$is_end> length<$length>\n";
 		}
-- 
2.19.1

