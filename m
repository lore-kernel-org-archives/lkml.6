Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C39CC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 07:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5D1E214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 07:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LSJeWQKi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727424AbfAJHkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 02:40:33 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36177 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbfAJHkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 02:40:32 -0500
Received: by mail-pg1-f196.google.com with SMTP id n2so4491001pgm.3;
        Wed, 09 Jan 2019 23:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:cc:subject:mime-version:content-disposition
         :user-agent;
        bh=TZSJFESl6hz2tj++XbHwRucvB2gmaPcYbSwLF4JZvVU=;
        b=LSJeWQKi4Qw3WWF2rpfHzYtKJFGac9WZisI0Z7ICZh4InlxmvpUCtpgZeq07/QU8EM
         9nRSF0g0vapvHK8pZa6GL3NsSvE7xLgG0rrW7IpEdEmUbIcTCiJE2LsLjOoO1+Garnes
         mwrMYr2d+ahKxtUoe+z4ZUBMFMOwEeT05y3GBnLjkyWr/OB67fuklKTeMyYI44jO1wHv
         NMzJ7wB/c//es8rECm9VXH8J4opgvkS17D4lxT/oDtfEmmm6iGBSMjyzGhhFki29GMKt
         HhbxxU93clQ6hw/HZ7PdVdkKsg0ME9AHQAXrM72834GnqttwyKGxGwhIpvLDpK5UFAWc
         ndNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:mime-version
         :content-disposition:user-agent;
        bh=TZSJFESl6hz2tj++XbHwRucvB2gmaPcYbSwLF4JZvVU=;
        b=OHkHhgrEqomTj1VmKeVpwzG3tvUh0mm4boZ4reDTiEyOyp5SHNOhzbteLazZYRdjDn
         +qTHsaW5+uP2PGKgA0cKb8di1PPScX68fXFpJO+HE4nOPmMyrpwzzRkn1ebNB9/AWj36
         w2vo0Wjy3z6kslnffFOkP3YAQ6idlBCJ5kOjNr9U2whXhcJiN3kwnfKTTj58xG2eQHKd
         u4zz03fvxZosJURzQ0Bh0N7LyrlMDXCge70JRinlqHuO13bPtz3pb0Ne2G/w6DRhIK1r
         S8p1RvcwdZr9quUdzaeHulfWslOHSxjD+atQsEdDhBTbK3b7jINVPu7pd88Ts36zxrS4
         Dg6A==
X-Gm-Message-State: AJcUukeUURJoLgxZfR8FnGkPWjvn19/hpjZPBYH06OAtwRJLQCV6sb0j
        ju9pbxIduaP0M7zprjrRshOdhOe0
X-Google-Smtp-Source: ALg8bN5BsPCTep8Uwhb3k0XTULHaWMx4wIvwsTC1vJriCFzry7XxVQ6lb+KAdFT6zO2kganXk4JarQ==
X-Received: by 2002:a63:6506:: with SMTP id z6mr8379695pgb.334.1547106031781;
        Wed, 09 Jan 2019 23:40:31 -0800 (PST)
Received: from sabyasachi ([2409:4061:2019:ef6:e468:6878:1f4b:258a])
        by smtp.gmail.com with ESMTPSA id d6sm104739218pgc.89.2019.01.09.23.40.29
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 09 Jan 2019 23:40:31 -0800 (PST)
Message-ID: <5c36f6ef.1c69fb81.9d82d.5592@mx.google.com>
X-Google-Original-Message-ID: <20190110074025.GA26188@sabyasachi.linux@gmail.com>
Date:   Thu, 10 Jan 2019 13:10:25 +0530
From:   Sabyasachi Gupta <sabyasachi.linux@gmail.com>
To:     stern@rowland.harvard.edu, gregkh@linuxfoundation.org
Cc:     jrdr.linux@gmail.com, linux-usb@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org,
        brajeswar.linux@gmail.com
Subject: [PATCH] drivers/usb/storage/sddr55.c: Remove duplicate header
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unusual_sddr55.h which is included more than once

Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
---
 drivers/usb/storage/sddr55.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/storage/sddr55.c b/drivers/usb/storage/sddr55.c
index b8527c5..96bf7ee 100644
--- a/drivers/usb/storage/sddr55.c
+++ b/drivers/usb/storage/sddr55.c
@@ -62,7 +62,6 @@ MODULE_DEVICE_TABLE(usb, sddr55_usb_ids);
 }
 
 static struct us_unusual_dev sddr55_unusual_dev_list[] = {
-#	include "unusual_sddr55.h"
 	{ }		/* Terminating entry */
 };
 
-- 
2.7.4

