Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC64AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 15:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82CBE214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 15:23:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BaELOaca"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82CBE214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731233AbeKVB5w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 20:57:52 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39922 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729656AbeKVB5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 20:57:51 -0500
Received: by mail-pl1-f195.google.com with SMTP id b5-v6so5975714pla.6;
        Wed, 21 Nov 2018 07:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=1000DmeFqdTg+Mu0xocve7T447a7Nc2Ns/PnYEoDpic=;
        b=BaELOacat28C+LKWDstPp1hvZJd4xqb48YGSEh9g6d02g06DB7O/2gZT9mirCjQqnI
         uXIWdMchVLUG326OBs53w6fspAkTau/PKleON60emg9eRw8nsqNpaML72hcxCuGd49Op
         n6XvRGY+c4xAVzEWCXCOzwSCEOXly5ieeZd63ulnzeVtPwdGk4iNXMmz3G4/jkjzSait
         VDxG2r/jKt052SoaSvYKqsnMSDfmL+SbtNUoQclB8Ax22LfdKC+0fqbTuYDwNNLvKOj7
         4izgm+Q5OACMhaR3wXyWLetMIhcTuxbvjqKvJLHTiIrlMN+9c1+S+det+VltylxMPp4F
         ZN0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1000DmeFqdTg+Mu0xocve7T447a7Nc2Ns/PnYEoDpic=;
        b=levK9fIAHrmCr0NBKN6Xw+HYXW9UlRexVV6ujXVPZd3MZl59LctmDm+jlm5H6uK2Iz
         sEcUgH0SAP8KHNzVhiawmoAejDlZ9zeu0+Wa22W4GRZhFyHGBI1DADjFH+oCotkV4WDp
         flD/goRwGMbpIMdapSAsoboV3matJzZ42QTRQEu24+K5eQUu2lxPfWVGnD82Xwyk7zOz
         TDbaswfwWfHK5MzIkTGIWXjcoeKoDazgYZ/kj/+O4Sss7ToslKxh2FdeBmb0ziOYiRNq
         KGoioi1ljaujWlnBF5CIf++UUdkC0+Tf61kdfxlxekZErAVdUWOerTwWimhaTwCckQy5
         fETg==
X-Gm-Message-State: AGRZ1gLYo1QjxiqFxevryNhYAZv4tcF8ekHXKamV3De1PMI6vh8UZZ5r
        kapT7LJKasks3EpkGSziCdX4+1pt5Yg=
X-Google-Smtp-Source: AJdET5fEHWoJttYVrxZNpRf/z3KDzNTBjT0LG08AnWO2MFtJtck8aDfKkoiBd7KMJebpBNgwQUggTA==
X-Received: by 2002:a62:440e:: with SMTP id r14-v6mr7251845pfa.185.1542813779797;
        Wed, 21 Nov 2018 07:22:59 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id l64sm54327749pge.73.2018.11.21.07.22.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 07:22:59 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     davem@davemloft.net, gregkh@linuxfoundation.org, jslaby@suse.com
Cc:     sparclinux@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] drivers/tty: add missing of_node_put()
Date:   Wed, 21 Nov 2018 10:22:54 -0500
Message-Id: <20181121152254.23480-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_find_node_by_path() acquires a reference to the node
returned by it and that reference needs to be dropped by its caller.
This place is not doing this, so fix it.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/tty/serial/suncore.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/suncore.c b/drivers/tty/serial/suncore.c
index 70a4ea4eaa6e..990376576970 100644
--- a/drivers/tty/serial/suncore.c
+++ b/drivers/tty/serial/suncore.c
@@ -112,6 +112,7 @@ void sunserial_console_termios(struct console *con, struct device_node *uart_dp)
 		mode = of_get_property(dp, mode_prop, NULL);
 		if (!mode)
 			mode = "9600,8,n,1,-";
+		of_node_put(dp);
 	}
 
 	cflag = CREAD | HUPCL | CLOCAL;
-- 
2.17.0

