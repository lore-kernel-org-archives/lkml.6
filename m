Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 687D2C04EBF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 06:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D9E82146D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 06:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544077415;
	bh=QMTglh0QtYfO2aqbC8Jxg5FMZ1UYECkqcx6WmeauVzY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=nBL7FfMOdDyes04bsiywIt3tkOuD4nD9Nutwx7wMqECnDKCHtuWt2kaB08Kxcs0yO
	 CgdhvECXv/TdumCM8Ip9FPLwJnrHoczHdgAUtq1hkWo566geNaG/kIsPkkY/3nY8b0
	 C2mcq3pFu5mAT0zSUR2ulE7Y+IiGI5HfK6ZMcO0g=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D9E82146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729096AbeLFGXb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 01:23:31 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36486 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728904AbeLFGX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 01:23:27 -0500
Received: by mail-lf1-f65.google.com with SMTP id a16so16598712lfg.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 22:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8HvUSduV/gR2iF8hBm9E28XKNnRmw86jkHFr5bz25MA=;
        b=LG5L7bw1ISwlmCLSsQ5Ff/keDKvx8CON5vcoYaHU0xmC+8vQ1TE4WIP92Vf5JhEEtF
         PotQRRUiNS7MXGpnKXsGqfcX1T8L7S4RA/Ugf7EEafy4l3vi4A/BEpYEG04IILmu/CGP
         gh/4ps2srJwQZRKtZ0IW0Z4LSSNtXJLcL0K2qQyqVLXEEFCUtacL+5ga+NpGckgGwG5R
         ClPf/FPHz07WfJo0yzXJ7ZwOi1w2kTPFmPXzwlozRBPWYWRgmfPbzD2NLwyyEEoJGZlt
         6a45y627Gh+ZQXNXj8DxJeESiqYugOvhw4IquQ69UeGmB1f0asC3aqosoq/8zAr+p7Fc
         RVFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=8HvUSduV/gR2iF8hBm9E28XKNnRmw86jkHFr5bz25MA=;
        b=WYWYrrGGip46Av+WRaD/wZ+aUZ+sivun1tH3YzQxHP71Q2GzvIWdw5j+6zOXl8VoQA
         /dCwtJhiHQp8Azt+xDY+3JZTAM1nJxILb5uETCnQ7UTc3uYUBxPKfpjxz4RKslhEWEBW
         XRMbYLAu6Q2gXokhs0x7BVee4YjRj+B6/F5ZoXu2J99WmEO/aN+dTXmRnPvcSCDlr8cl
         wYmGY35q06tzZxGyPKMqP+zlATPqb9H4RGVfJJ4aXp+Gt6S75d2d9M0BHdn/NZbONYHz
         mYh2xrSQhs3IOj5xUDSfQuI3OW/9851Z1IER1ED32I2Y8zzDCapBx1X8Hm6RIkselaY4
         008g==
X-Gm-Message-State: AA+aEWb1PaNaHtubCp0gdpX2+1kUsmNViP6APvDUDvprHzsc8xOk0ZdB
        cvt98c8sHe8yWS3Y9byjAyaX0VwL
X-Google-Smtp-Source: AFSGD/UIJ8CkhFDyM2IB/8KeA+9171dJOEaSZ614bciqsJvn9ta/ocr82/WYIVNb/jhN3GR0K66L4A==
X-Received: by 2002:a19:3b9c:: with SMTP id d28mr16963394lfl.30.1544077405354;
        Wed, 05 Dec 2018 22:23:25 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id y12-v6sm4131379ljy.76.2018.12.05.22.23.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 22:23:24 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@xi.terra>)
        id 1gUn4K-0006gP-RC; Thu, 06 Dec 2018 07:23:28 +0100
From:   Johan Hovold <johan@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Johan Hovold <johan@kernel.org>
Subject: [PATCH 1/2] MAINTAINERS: add gnss scm tree
Date:   Thu,  6 Dec 2018 07:23:17 +0100
Message-Id: <20181206062318.25648-1-johan@kernel.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SCM tree for the gnss subsystem.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6682420421c1..03766ddf95a3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6316,6 +6316,7 @@ F:	include/uapi/linux/gigaset_dev.h
 
 GNSS SUBSYSTEM
 M:	Johan Hovold <johan@kernel.org>
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/johan/gnss.git
 S:	Maintained
 F:	Documentation/ABI/testing/sysfs-class-gnss
 F:	Documentation/devicetree/bindings/gnss/
-- 
2.19.2

