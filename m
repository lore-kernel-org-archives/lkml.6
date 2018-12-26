Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3DD6C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 01:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E34E20C01
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 01:26:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="qfKJGGYW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbeLZB0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 20:26:49 -0500
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:50962 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbeLZB0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 20:26:48 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 2495AB9D
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 01:26:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id hQBj7Dba6QJt for <linux-kernel@vger.kernel.org>;
        Tue, 25 Dec 2018 19:26:47 -0600 (CST)
Received: from mail-it1-f198.google.com (mail-it1-f198.google.com [209.85.166.198])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id E4B03BA4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 19:26:46 -0600 (CST)
Received: by mail-it1-f198.google.com with SMTP id y86so18478864ita.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 17:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=pgj+QP+TpXcP5tfNrKzXW77NAWt+jEoTz0qxJwhv64I=;
        b=qfKJGGYWJ8OuNvfG7qQ57ENTk9UUqtpsC1zJp4RzU/fUok5feQs605ifNNg4FGjYuz
         HhG3sNo6n2IXz4eGqU+Pas2w4IUGXxXk7gt7cNZ99lnOPKwg7d60SuDjwIeIXqu3Cmgj
         iuXTtrDPji8oTAhDEAOXrO5mMgrjEhbchYbXmd7npfsg+/8NkQ9xvJoeJEgM95XF7YR6
         7qaFFuy+7RvDMrZvwWHgufa9G9SRlLluWgm4KLlwvNlVfHjQjW99NGUYLlPj4Shbagfn
         aWXa0mO++Rdg9shVxGSsyXMWZJLAoZJY/nLnaAMFp/slLs4TOki5BgD87YQ4qtHFlf7G
         +QUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pgj+QP+TpXcP5tfNrKzXW77NAWt+jEoTz0qxJwhv64I=;
        b=mLdWUrFvb4KefeH3odxCm4mqqzXw9wDx1e8UdbGVhN/lffscgxNNSmHJekTWgslcVZ
         Nvs+vcGMLAGqRAajOFOOXUCmUZRmv9I9Zy4zGzGFWBiGJotJqjqVKiPAVZKxgPe1bD8N
         +ZvYYuk8IJwFFiFVjLxOUskDTUNIeNmSpv+yY1LOI9n0YblX9C/B9jnlEsTgbILEhole
         FC5esPDhmUHr3+dQg3LbOwFOVVMzlU8HOEJD0rDXMjIri3g3LoWB+8a9w8XVC1fgWI2k
         9/9ysdMmGH4WCqeTr5nDL8bluWsuPWuwmPjkyCwJd8Uqt1RBOyMJ8BcupblxVqo41RrK
         iI5g==
X-Gm-Message-State: AJcUukcYzmF9hX7f0rYwGoz1d7j1qkdf7vEBZ8X2nobHvF2icKmGSX8f
        n6WEUadJVeykpBmkakbrRdGXH/PppEbG1ufQdWuHN4YlWUH0/OODUsnhLvFfD6e0aSQ+acrY18h
        yFRZfrqZOG+J69wJRj/MJpN4b0W7o
X-Received: by 2002:a6b:2b95:: with SMTP id r143mr12638814ior.217.1545787606551;
        Tue, 25 Dec 2018 17:26:46 -0800 (PST)
X-Google-Smtp-Source: ALg8bN6bHrbXZkaQUoorKvaX66QMmR/COt6XTeywS86o4diFv7ZBC/0/Eei/qyT03w4LtLj+NA2jaA==
X-Received: by 2002:a6b:2b95:: with SMTP id r143mr12638808ior.217.1545787606337;
        Tue, 25 Dec 2018 17:26:46 -0800 (PST)
Received: from localhost.localdomain (host-173-230-104-22.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.22])
        by smtp.gmail.com with ESMTPSA id p198sm13636399itb.30.2018.12.25.17.26.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Dec 2018 17:26:45 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] tty: pass return value of spi_register_driver
Date:   Tue, 25 Dec 2018 19:26:19 -0600
Message-Id: <20181226012619.70607-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

spi_register_driver() may fail, so let's pass its return value upstream.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/tty/serial/max310x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 3db48fcd6068..55e73646fcd2 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -1470,10 +1470,10 @@ static int __init max310x_uart_init(void)
 		return ret;
 
 #ifdef CONFIG_SPI_MASTER
-	spi_register_driver(&max310x_spi_driver);
+	ret = spi_register_driver(&max310x_spi_driver);
 #endif
 
-	return 0;
+	return ret;
 }
 module_init(max310x_uart_init);
 
-- 
2.17.2 (Apple Git-113)

