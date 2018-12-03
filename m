Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB35C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 06:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7687E20834
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 06:46:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="s4lueP4X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7687E20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725830AbeLCGq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 01:46:29 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37598 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbeLCGq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 01:46:29 -0500
Received: by mail-pl1-f195.google.com with SMTP id b5so5958319plr.4
        for <linux-kernel@vger.kernel.org>; Sun, 02 Dec 2018 22:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=NzrGkHPfMw5PpRz7JX5QXHjmYPGlb8Ry+SBoB6V49Io=;
        b=s4lueP4Xt7kL0VZh1u9KdXTuMLDIPsNFuuRkiQYz7bXfxUALSuUYiGL3kjKpcz8sRH
         gfR7dizrzh5ExJ7nwmrd+24yt5SsEKGjX/LCelaie3i2Mg8/5SFuDMGCPDAL+1IZDUFI
         k+CHVv2Bb+QV6G6K21N4OotDq3USPmsYMtuuMfYjrR2OwTh7nMcSivZ8GvH1xTEqkn/n
         vLN77UZjSFghiHWblrWuxkGBb3JJkXPKpEBxserWOO5PM738yT7LPjsL1qEj7o5VACNA
         jj98Q1KAmVvIcotQL+yYqIu/unf6+bMQnOKgnnc8V0UBh/XcAGUSGHAgfoRc/bkEyp8a
         0mUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NzrGkHPfMw5PpRz7JX5QXHjmYPGlb8Ry+SBoB6V49Io=;
        b=tLoGkKW3+EMb9Y/cD0ALIsg6fjsVEq4XBW+CiTedsRN8k2DdERzmD2ptTuiU7RA5k6
         rC+vrsIeTf/8p12/cvI8TjaQhOAnIV81al+B22jYBA+SK6Ywps5zC3GIOsqIvqb/5/vT
         ity5PQgt6Ej/x2jm0jtC53W4OFqG1m5zISq62q/CRpCX19d53DHOrneDIurFYcvbQOx2
         ob8HvoSTqoVlSiiAwD9kYQPFLdqqjmmidloLa3DCpVX3PHqgs3PflPyaWQPb8fZ9Y4A/
         v/iKvhatMQel/rxFOP79d1XWgzAREDZ0O+Fg7uOHRa0+OLS0as8O3DQOIGTfggh/xXRm
         thMA==
X-Gm-Message-State: AA+aEWZUPCDpn7H9GH69l+2jpiR4wxBK8WMWyAnz5m4q9FaEGBpMwK2S
        +YZAmHuqq7LLkU3YeqmKEha9Ag==
X-Google-Smtp-Source: AFSGD/WoDaFCDw3AFwYAPtqQi4WV1jGAHocJGNRVPpMvxEFKZdjU5cjcr3pOuFJw/1vhHFuBRHlvGg==
X-Received: by 2002:a17:902:a58a:: with SMTP id az10mr15260269plb.151.1543819587140;
        Sun, 02 Dec 2018 22:46:27 -0800 (PST)
Received: from localhost.localdomain (220-133-8-225.HINET-IP.hinet.net. [220.133.8.225])
        by smtp.gmail.com with ESMTPSA id v70sm22692874pfa.152.2018.12.02.22.46.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 02 Dec 2018 22:46:26 -0800 (PST)
From:   Chris Chiu <chiu@endlessm.com>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        rydberg@bitmath.org
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@endlessm.com
Subject: [PATCH 1/2] HID: use macros in IS_INPUT_APPLICATION
Date:   Mon,  3 Dec 2018 14:46:20 +0800
Message-Id: <20181203064621.69876-1-chiu@endlessm.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing definition for HID_DG_WHITEBOARD then replace the hid
usage hex with macros for better readibility.

Signed-off-by: Chris Chiu <chiu@endlessm.com>
---
 include/linux/hid.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/hid.h b/include/linux/hid.h
index a355d61940f2..ce5f996c8d3d 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -238,6 +238,7 @@ struct hid_item {
 #define HID_DG_LIGHTPEN		0x000d0003
 #define HID_DG_TOUCHSCREEN	0x000d0004
 #define HID_DG_TOUCHPAD		0x000d0005
+#define HID_DG_WHITEBOARD	0x000d0006
 #define HID_DG_STYLUS		0x000d0020
 #define HID_DG_PUCK		0x000d0021
 #define HID_DG_FINGER		0x000d0022
@@ -836,7 +837,10 @@ static inline bool hid_is_using_ll_driver(struct hid_device *hdev,
 
 /* Applications from HID Usage Tables 4/8/99 Version 1.1 */
 /* We ignore a few input applications that are not widely used */
-#define IS_INPUT_APPLICATION(a) (((a >= 0x00010000) && (a <= 0x00010008)) || (a == 0x00010080) || (a == 0x000c0001) || ((a >= 0x000d0002) && (a <= 0x000d0006)))
+#define IS_INPUT_APPLICATION(a) \
+		(((a >= HID_UP_GENDESK) && (a <= HID_GD_MULTIAXIS)) \
+		|| ((a >= HID_DG_PEN) && (a <= HID_DG_WHITEBOARD)) \
+		|| (a == HID_GD_SYSTEM_CONTROL) || (a == HID_CP_CONSUMER_CONTROL))
 
 /* HID core API */
 
-- 
2.19.1

