Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A541C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 02:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2F6620843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 02:45:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KxounjR/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2F6620843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbeIDHIF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 03:08:05 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33915 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbeIDHIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 03:08:04 -0400
Received: by mail-pl1-f193.google.com with SMTP id f6-v6so896416plo.1;
        Mon, 03 Sep 2018 19:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Cdxdf1nldZEi8RFCj/e5+/wKGAi8Yvs7ozh1di1NMpo=;
        b=KxounjR/JZhvaF6qG4+wwjyny2S175AVYEOKwqlvVqOSceE1lDEHish/yEn6xJWOuR
         nRdSShqUEIefZGOlsW+rf1scndPm3AIFIjVEl4Xj/6FW+LN4yCGb/C1qKogP25wLzB5T
         MQSnSjXoqxwzF24ZIeu3hD9EiqPi7tD6GK/SFksbYf0VCDnPTQvMlmc/jn5llW2vF17q
         nrN0Z1YIjztsSFstU2ZkMbuRL9iW1/ej0CJ09DupJxc6aF1kz2GNOI4GLUMyj2i3G7ZR
         n1CqNysGqlAGfIXJpiyHCBVEp04yj7t9s2QlNN9/zuxSHsHPweFRyGfpMCJ8XeyCoU2a
         7w6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Cdxdf1nldZEi8RFCj/e5+/wKGAi8Yvs7ozh1di1NMpo=;
        b=jBj5vC4sTVKkSZw5pyMdOD5AlX0yTNs4FeDfyJZtdQLGEnviF4mNtKGSQW1/2KIond
         XXSJEtN/ko8eX1G9zQckru3LUofi9BLyZ6XquxNuJBl2YGkRZV9cKslQbWU4ixQWuWli
         RBA/mdyU+9+mgpem6ITsNVgWhQFq76O2kyz7oM8NrkEFp+2HoCzmUeUz8dT/6KVeskwZ
         +GE6jMVdFnHeYEvAphwVJqV6W2UP1zILAtMaQfqCFUgSF4gu2ho1hscT2AGjKH6mwY2Q
         25IAl8vW9ombnQZ1QTNWCjoEQNynSmvuNBbDLXxHR8keO4SeXuAgZRhmeHO8SAmeX7SA
         oIlw==
X-Gm-Message-State: APzg51D0FSY8Arr/8Eg2EOU6yS9l5HD6gO58ZbLlWj6UDgLbnrH9TSBt
        Q0WoCfoMoLsMvx0h5qjXCak=
X-Google-Smtp-Source: ANB0VdbN8FZcq3Z2mFtnAJPf/iOgVpWnqizHc8ffHszeHAoQKhBevaIn/eL/Dxx5QH6nAsbg8ERTZw==
X-Received: by 2002:a17:902:981:: with SMTP id 1-v6mr26346204pln.60.1536029109928;
        Mon, 03 Sep 2018 19:45:09 -0700 (PDT)
Received: from climb.lge.net ([27.122.242.77])
        by smtp.gmail.com with ESMTPSA id w16-v6sm33663284pfi.101.2018.09.03.19.45.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 03 Sep 2018 19:45:09 -0700 (PDT)
From:   Jaejoong Kim <climbbb.kim@gmail.com>
To:     linux-um@lists.infradead.org, netdev@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-s390@vger.kernel.org,
        devel@driverdev.osuosl.org, greybus-dev@lists.linaro.org,
        linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCH 02/25] isdn: i4l: isdn_tty: Change return type to void
Date:   Tue,  4 Sep 2018 11:44:28 +0900
Message-Id: <1536029091-4426-3-git-send-email-climbbb.kim@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536029091-4426-1-git-send-email-climbbb.kim@gmail.com>
References: <1536029091-4426-1-git-send-email-climbbb.kim@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since tty_port_install() always returns 0, the return type has changed
to void. Now apply this and remove the obsolete error check.

Signed-off-by: Jaejoong Kim <climbbb.kim@gmail.com>
---
 drivers/isdn/i4l/isdn_tty.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/isdn/i4l/isdn_tty.c b/drivers/isdn/i4l/isdn_tty.c
index b730037..3d6b24e 100644
--- a/drivers/isdn/i4l/isdn_tty.c
+++ b/drivers/isdn/i4l/isdn_tty.c
@@ -1481,8 +1481,9 @@ static int isdn_tty_install(struct tty_driver *driver, struct tty_struct *tty)
 		return -ENODEV;
 
 	tty->driver_data = info;
+	tty_port_install(&info->port, driver, tty);
 
-	return tty_port_install(&info->port, driver, tty);
+	return 0;
 }
 
 /*
-- 
2.7.4

