Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B37C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 16:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78B18206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 16:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y1mLwZHn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbfB0Quh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 11:50:37 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41276 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfB0Qug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 11:50:36 -0500
Received: by mail-ed1-f66.google.com with SMTP id x7so14452205eds.8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 08:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=smfytoK1YrOrQodt+CIZ8wrxJHMoZVPL7SHmk3SXECo=;
        b=Y1mLwZHn9gQ/CppnqZM/nk4h7i5UaskrvXi74hlNNs1vsdEttDndcGUKB25pCHJmhF
         ZYd0Yl0Bwtmsne4V91yZ0xVTOGlFs2nBQs5q/AbI2YzWJwiYzRbdQK0M9DKLNEzHMCzv
         SC0U0aKu9YHZtKNwdOzgdIEBQxbhajxpbH2NI6FI2l8WeJjPOz5NxgKLAl3V7+n97BQj
         OjE8ZQf7kKI96/S4uV2KrFRrdpSjME7l5INqIFhtsaFVVd0xL3Sw39o8EqTUi9ecHATA
         wXA5MAmn2Quk9Ac05XzdlQIqpPZAot9YLrL0EE5NLP/XkLTt1mYd/NSudYCywCPJ8qHn
         iVew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=smfytoK1YrOrQodt+CIZ8wrxJHMoZVPL7SHmk3SXECo=;
        b=k1GK/I+kUby8nTnLa/2ky60ICYzgx8Tc9p2cqWMLs9PH10Bmv13o0ZWJuF6EtjLCkT
         8ulAKYNzUqjmWA/aoaRcSjueUj8XmW3uEn4GMUv8bFs5eLqpOLj6dMEj7vOdpH5vyPpj
         Kq887ke4V6KFUwVEAVanIZefkrRhFWlswrYw59BOVPUkHhaIjHUV+eLyKRIoEyS+fz6M
         xAPj6trPUJCzUh7/vfo6q40zhWdDkzBA3rT+evpKYkxmGJZ0imwlEFRF/Ztfa7/erq1A
         rOqChfOqxnNlGEvpfRmB2AWDU0VCMcGJONBdPsIXtQuqIZ6RFG3FZm1T3eH45ilCgof1
         UlNg==
X-Gm-Message-State: AHQUAuZMq8UlJdykFl/jJZ/qWmW7oVqHyzSGdjYCIBiB13zWXm+9odux
        5HY/f8AbTxkXc5fH62RIDoE=
X-Google-Smtp-Source: AHgI3IaKpn6iR5tHGpOuQJTwovtPzBxM7dVYflSHy4rKSDYNP2KPPqu9tnyebDj8q81lAlm7fsxD9w==
X-Received: by 2002:a50:ac6d:: with SMTP id w42mr3165151edc.122.1551286235068;
        Wed, 27 Feb 2019 08:50:35 -0800 (PST)
Received: from ahersrvbspbld01.lgs-net.com ([193.8.40.126])
        by smtp.gmail.com with ESMTPSA id z42sm4398136edd.29.2019.02.27.08.50.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Feb 2019 08:50:34 -0800 (PST)
From:   Andrey Zhizhikin <andrey.z@gmail.com>
To:     dinguyen@kernel.org
Cc:     linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Andrey Zhizhikin <andrey.z@gmail.com>
Subject: [PATCH v2] ARM: socfpga_defconfig: enable support for large block devices
Date:   Wed, 27 Feb 2019 16:50:18 +0000
Message-Id: <20190227165018.12911-1-andrey.z@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable CONFIG_LBDAF, which is required by ext4 fs. This option could
handle both ext3 and ext4, with ext4 requires this option to be enabled,
otherwise the filesystem is mounted RO mode.

Since the LBDAF is enabled by default for 32-bit systems, simply
removing the current "not set" entry enables the support.

Signed-off-by: Andrey Zhizhikin <andrey.z@gmail.com>
---
 arch/arm/configs/socfpga_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/socfpga_defconfig b/arch/arm/configs/socfpga_defconfig
index 08d1b3e11d68..c96d93fb68c6 100644
--- a/arch/arm/configs/socfpga_defconfig
+++ b/arch/arm/configs/socfpga_defconfig
@@ -21,7 +21,6 @@ CONFIG_NEON=y
 CONFIG_OPROFILE=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
-# CONFIG_LBDAF is not set
 # CONFIG_BLK_DEV_BSG is not set
 CONFIG_NET=y
 CONFIG_PACKET=y
-- 
2.17.1

