Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D890C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 03:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E97AB223BC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 03:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mvY6///0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E97AB223BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727373AbeHJFtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 01:49:17 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:43707 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725725AbeHJFtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 01:49:16 -0400
Received: by mail-pl0-f68.google.com with SMTP id x6-v6so3417047plv.10
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 20:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iVX4+7Pc6vDVmq9Ge3LdDl4JfRygKih8H3dk2/uzXJg=;
        b=mvY6///0PYeYxNjV6Y4hzzBPGWrBkLCy0jzb/43GOiYvvjhMp9hvSRecfVFRV1ROpM
         7SZtp9YpSZkDMBlLKKM3e8MRZsqiKTH6+Vr65gmkEdTXxzPCAzEQqQxRzo9C1UydpbM/
         iQwFrMrWjb/Uh7m0lyKtOUv2opDnUp1FK/JyWl6zYpBD9FujXcfMppl/UFTqe09/shz9
         7Nt70AWTHr1u5uP5KAPUe7DhJENJafHh15FK5AP25clc++bNEwHEdeZfK+r4iJAcyn65
         Dnx0OR2LeS06okiv3aGO+tGsb8ooEacL0gQYGE9MPItaaw3eOR15n44x1E3DKDp6nnig
         uzeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iVX4+7Pc6vDVmq9Ge3LdDl4JfRygKih8H3dk2/uzXJg=;
        b=fPEEVuTgLE4hQQRG3ZnQL1YOasoNzU28V1Su/bGZKxGnNG0PE1TvZkpQzFfa5vW4uC
         XChtxsy4pGKrN+NsHX2WdhSn40aq5wJAETDHcAauLmUkrzTYyTIQ1oxR8HQ20vE+5LFh
         hl5YR4YFB39blAd3PlB8r4ZdlcSFSPNojVm+COnvxmGcu/UdAkIXevs3WYrYketUnNbZ
         NWvc18tF8EZDWZRiPVHncRK7VgK01Tfka9GvdiPTGzP2XMwLshxDicFNyw3nk9ty0l2W
         Nt7LUAX01Ni0g0uyTuu02H7G0edgR5qMEUa4JLQfHpqg3TiNcDBouR0aRWWKmmq1nbFl
         kd8A==
X-Gm-Message-State: AOUpUlESXZqXiHJKp/V7pswcgIHimRs11QlbbQZNSRLmpjW/ajvt7n5S
        YmYKQLu2UWZw2pj/VaXLKTBYcajR
X-Google-Smtp-Source: AA+uWPzV0M5x99dKd9dXpAGpceTdpbgcf7qeixbbBhzdJcgH9VnubOfHkZeKiXNCn9DGFXvtgqqhVw==
X-Received: by 2002:a17:902:1001:: with SMTP id b1-v6mr4359669pla.155.1533871283711;
        Thu, 09 Aug 2018 20:21:23 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id p73-v6sm16130871pfk.186.2018.08.09.20.21.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 20:21:23 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 01/16] MAINTAINERS: Switch a maintainer for drivers/staging/gasket
Date:   Thu,  9 Aug 2018 20:20:56 -0700
Message-Id: <20180810032111.197743-2-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
In-Reply-To: <20180810032111.197743-1-toddpoynor@gmail.com>
References: <20180810032111.197743-1-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Todd Poynor takes over for John Joseph.

Signed-off-by: John Joseph <jnjoseph@google.com>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index af64fe0f0b41f..f3466b5c50482 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5939,7 +5939,7 @@ F:	Documentation/gcc-plugins.txt
 
 GASKET DRIVER FRAMEWORK
 M:	Rob Springer <rspringer@google.com>
-M:	John Joseph <jnjoseph@google.com>
+M:	Todd Poynor <toddpoynor@google.com>
 M:	Ben Chan <benchan@chromium.org>
 S:	Maintained
 F:	drivers/staging/gasket/
-- 
2.18.0.597.ga71716f1ad-goog

