Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F90DC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 02:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 086E020843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 02:48:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PXyyYhk3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 086E020843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbeIDHJE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 03:09:04 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33253 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbeIDHJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 03:09:03 -0400
Received: by mail-pf1-f196.google.com with SMTP id d4-v6so924620pfn.0;
        Mon, 03 Sep 2018 19:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=u9q+PugGhdQhGarX8q9kMwfv+0Mo7mXRGcKR8a2BaTY=;
        b=PXyyYhk33i805zIS2aA59nRTGDtwF+CDarkOC9F4jkZYmUKdYi3GgXqdykMhJORpnx
         1PuOviGt94zEDjZwLHox2pgql6mjOuAamxup/lk1vHjIh6KQlPtx9gJTcrzNTfDMhaV3
         oaJg4n05S4mifCF+h8YtbxMDK3NsEiPNSRxRcQJXsY4diejj2ZI2T99BJZOPLcpcfxnO
         Wals1yRiAB2so+4HbbhrTpEtpNfcLYZ/cfkQw1CUZrq5xlZGYq6p+fOp/Chx0vOYCbCg
         D709/UnvKJvNeIw5bWlOGlGuiHFvpLRhg024l6wHctO6rXG6ZqtjE1JVPIkC92gj1/Ea
         Rq6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=u9q+PugGhdQhGarX8q9kMwfv+0Mo7mXRGcKR8a2BaTY=;
        b=EglBV+7fO3mJWeDiEpq7uGt1hiHOPaSMkpgmB7YbYaqzRt/3PtFGKWouf0DVi7BGXe
         y19WgVX9jCuihN/s+R8eLyEcKfYhqZVXnXXFY7iTf+NJOfjFtwsVfOdNZ3dyFxPX8MEg
         q6ui2RUsc/i0y6Nmo7pW+O1MhEYLjJj8RKyleRIqt/ozZUl5SYnQ6CaHOqMdylyX52NJ
         ce6LJMXJYLqu7C+mevSefnOAtwANS+vfE/piHY9OYESi/ggITg2wjS65cVSsLdimsWvm
         bXqnhkuyWaZX08KFkBsJkrVzofoQTJ4Zs73VQMp29ZpMpAwzWgSx3ZP3zzDnOnTVO1Zd
         cS+w==
X-Gm-Message-State: APzg51CgedXcvndqsZTnmLJB4ASi9Jr5b+svJqCncKQRw67N1JauFemC
        ahSQe48DOTaXlpi+mc7mq00=
X-Google-Smtp-Source: ANB0VdbsLJ9z5I32SoZw2TFN21sIPiArDJxjlR6vvLE40oQnc0l5LaGiT8TkNtPPo/MJ5vP+6ePh4g==
X-Received: by 2002:aa7:818f:: with SMTP id g15-v6mr32498472pfi.71.1536029168566;
        Mon, 03 Sep 2018 19:46:08 -0700 (PDT)
Received: from climb.lge.net ([27.122.242.77])
        by smtp.gmail.com with ESMTPSA id w16-v6sm33663284pfi.101.2018.09.03.19.46.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 03 Sep 2018 19:46:08 -0700 (PDT)
From:   Jaejoong Kim <climbbb.kim@gmail.com>
To:     linux-um@lists.infradead.org, netdev@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-s390@vger.kernel.org,
        devel@driverdev.osuosl.org, greybus-dev@lists.linaro.org,
        linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCH 15/25] um: Change return type to void
Date:   Tue,  4 Sep 2018 11:44:41 +0900
Message-Id: <1536029091-4426-16-git-send-email-climbbb.kim@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536029091-4426-1-git-send-email-climbbb.kim@gmail.com>
References: <1536029091-4426-1-git-send-email-climbbb.kim@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since tty_standard_install() always returns 0, the return type has changed
to void. Now apply this and remove the obsolete error check.

Signed-off-by: Jaejoong Kim <climbbb.kim@gmail.com>
---
 arch/um/drivers/line.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/um/drivers/line.c b/arch/um/drivers/line.c
index 8d80b27..47058cf 100644
--- a/arch/um/drivers/line.c
+++ b/arch/um/drivers/line.c
@@ -338,12 +338,7 @@ int line_open(struct tty_struct *tty, struct file *filp)
 int line_install(struct tty_driver *driver, struct tty_struct *tty,
 		 struct line *line)
 {
-	int ret;
-
-	ret = tty_standard_install(driver, tty);
-	if (ret)
-		return ret;
-
+	tty_standard_install(driver, tty);
 	tty->driver_data = line;
 
 	return 0;
-- 
2.7.4

