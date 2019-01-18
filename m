Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB17BC43612
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8710B20652
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:03:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cPe1W2uk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbfARODl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 09:03:41 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51449 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727285AbfARODj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 09:03:39 -0500
Received: by mail-wm1-f65.google.com with SMTP id b11so4618190wmj.1;
        Fri, 18 Jan 2019 06:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sEQntTSMSzloJbJKItQL/Y0eCsx+0HRyKgqFsac2X4A=;
        b=cPe1W2ukeE/BxfcSLkU4cf2uNzCL4X2WMZ6EcEj/Q8GTgGYMJf8XxHolt76sPRzxsN
         gkVeLuJi3fsmr3N0pcCcnUi1zl0xlVcQytXZJjcfkmB6BVUfytc3x+Df9jb4ikgcYsBZ
         rTW1zsNY5Faq9hvvQIWR8pFJu43sLi5zXu0wi1tb1xYtaS+GvPBsh0t8XxgVqOpJYukK
         dkiYAFWmSVTFeZ8MsLooULG2ogeLquVjU595O6zag6IXUItjouX9A3eOTpXulR62FRVi
         Xtnh4Hydt5lfgqMNwXUwJgm4b0fk9NE7k4aPYfSS8wB4bQAiZ6qz3fhyBg6OWkS4Us0L
         sCIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sEQntTSMSzloJbJKItQL/Y0eCsx+0HRyKgqFsac2X4A=;
        b=K+ZC1Yzq7vLO0w1wflGlw9xwfym9eOX/KyGB+frptYPTKVhcInvM0gKUoHivIiCj0t
         tJQ3Z1ZvPfm3eu8E7Zc+CBNtKmOOvAgGlsyiHhGhK2ifwe6xLLZuS3BzooPbW/dzMNqq
         1D9TfLxECvbQt9DR/uFGdoPBiKmE2HToSdluN37YhkhQelmZaLUNhEBiReG8CrkrfQWl
         yEmFhqAURFlgU+W7bzcDK+3us+Jw6y258NnfB1O++kNNDV83wNbvpIwaBG/sx/xbDpGz
         WKa3WXDWjr9xIeRpN5zVFG/1N/4lzSrZ4pDPvTL1jeTmwxlZjqZETUZL9TdLSlbhDrGA
         v9HA==
X-Gm-Message-State: AJcUukfowuAeHchoXkX4ONcfmdeZho5enUvNMXOEjBDF/Bw+yO2/6gYS
        pIWvin6UIBxdWQsFJ0wdOAM=
X-Google-Smtp-Source: ALg8bN6CBfjl98Yk5c5w8yTwqnQVs4NK7yvhHiHIWNK4Esfs2hBofypR91EnZNxQUEbEFm91/bCGYw==
X-Received: by 2002:a1c:4108:: with SMTP id o8mr15369849wma.91.1547820217059;
        Fri, 18 Jan 2019 06:03:37 -0800 (PST)
Received: from Red.local ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id g197sm8464676wmd.29.2019.01.18.06.03.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 06:03:36 -0800 (PST)
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: [PATCH 1/7] hwmon: adm1029: Remove write to FFF paragraph
Date:   Fri, 18 Jan 2019 15:03:23 +0100
Message-Id: <20190118140329.18970-2-clabbe.montjoie@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190118140329.18970-1-clabbe.montjoie@gmail.com>
References: <20190118140329.18970-1-clabbe.montjoie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As suggested by checkpatch, remove the "write to FFF" paragraph.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 drivers/hwmon/adm1029.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/hwmon/adm1029.c b/drivers/hwmon/adm1029.c
index 8c5cdb560258..3dd4c84ec89e 100644
--- a/drivers/hwmon/adm1029.c
+++ b/drivers/hwmon/adm1029.c
@@ -19,10 +19,6 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
 #include <linux/module.h>
-- 
2.19.2

