Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69621ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1982F20693
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VTmJ1ycz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1982F20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730831AbeGQVjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 17:39:13 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:40093 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729684AbeGQVjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 17:39:13 -0400
Received: by mail-pl0-f65.google.com with SMTP id s17-v6so988036plp.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 14:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/AyrjK6mJxCWqaxrnTdbRZSjaqsy2SsJvBEmFFJsMdA=;
        b=VTmJ1ycz/KFtezAMhusvaj48DPDDKIaV+MbJI7YIdYAIWmr+biHe6WH0LeVG2P35rG
         JnWdsNJ4/KhXcDbEi/x32ABISvZjBHid1dGr78N51BzsazMigOfiycu1pwIUUViNvd87
         HBmGtHxdAubSelCl4I53FiW21DpoLlQGxExyYxOpdzY4MesWvYQQanlF4grnNaRtQwFw
         PkXIDEOhBqU7CSqZWSawa1/meSG9OUES8N6cKiitYDPxQYmxbSvo0+LIPs9gnbHf+qQo
         Q5OUSBE7VKwBSXSi6IIkfotygB7bqSUcggz8GZ0jpajqI4M2lE0FpHx9E9xsX//Ctodg
         skIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/AyrjK6mJxCWqaxrnTdbRZSjaqsy2SsJvBEmFFJsMdA=;
        b=VOc0WI9zuIRBZUVoS/K+t26+Ena0mlMkrKXHPvcHsT7H5PPEHFSuw2GjQgNat4VYFb
         +gvZ2Zv3hNm/ijhgljBMoNoINlRgR0fHbRELuN/SlteKI7SQBwD40A62C12LVhlI4loh
         gt64vPLUN6c9Ka3U0xEK6X3/UJ3W16EEJuVsmsTTVQ1929YsGjYxsj18ockcMzXsz7Xz
         sCIctm1HDB/Si6avaMyGDgLm/Ux//7jkMy0Vdm+q2qV2DnDmqN7XlWJr4KGJdroIN3y1
         ralw7SmKT3UfZB6vYgYqDNl0fXIaMKXLtGxbbdJbCweW2EYymqWox91tudIFT3B4Hl9d
         SXmQ==
X-Gm-Message-State: AOUpUlHMpclPDLbnFThwTsCwYYvDC+3j2eMUryapliMJ1qijAZyBZ+S5
        DNvRE6ilKP92j0J39TsGsjQ=
X-Google-Smtp-Source: AAOMgpdZ7kVqUutIZ06WRlTvNR25CtHgrBqtwCQ7sX/j+WfRG0fBFL0F1O6Yze72EdCuvh+EEOeO8A==
X-Received: by 2002:a17:902:9893:: with SMTP id s19-v6mr3125281plp.130.1531861485803;
        Tue, 17 Jul 2018 14:04:45 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id m86-v6sm3361487pfi.47.2018.07.17.14.04.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 14:04:45 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Zhongze Hu <frankhu@chromium.org>, Simon Que <sque@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 01/32] staging: gasket: remove X86 Kconfig restriction
Date:   Tue, 17 Jul 2018 13:56:41 -0700
Message-Id: <20180717205712.29495-2-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180717205712.29495-1-toddpoynor@gmail.com>
References: <20180717205712.29495-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

The gasket and apex drivers are to be used on other architectures
besides X86.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gasket/Kconfig b/drivers/staging/gasket/Kconfig
index c836389c1402d..ef40c4c75e0f2 100644
--- a/drivers/staging/gasket/Kconfig
+++ b/drivers/staging/gasket/Kconfig
@@ -2,7 +2,7 @@ menu "Gasket devices"
 
 config STAGING_GASKET_FRAMEWORK
 	tristate "Gasket framework"
-	depends on PCI && X86_64
+	depends on PCI
 	help
 	  This framework supports Gasket-compatible devices, such as Apex.
 	  It is required for any of the following module(s).
-- 
2.18.0.203.gfac676dfb9-goog

