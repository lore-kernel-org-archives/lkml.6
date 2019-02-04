Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC00C282CC
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7AC7217FA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549277604;
	bh=IjPbw/RTXQukJA9NFitgn0gjwyzYeoLj+aqqGzt91nY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mqi73tFAxJyg39xm9Z6YxsGmBVc9bh/QIf60pfZmvH+ir/0UGzCLfCjp1nrO77F9p
	 nKWgfWLM3DoiokyaBSYMi/5JG7WqHhE+M3dM61EuxAXbl/TCJ4PWBsx9Veeus2W4k5
	 3YgI4QX6p1lbJtjloPbDTKBM1GpegdKw29YgYPTQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732361AbfBDKxW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:53:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:50892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731517AbfBDKxS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:53:18 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12C15217D6;
        Mon,  4 Feb 2019 10:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549277597;
        bh=IjPbw/RTXQukJA9NFitgn0gjwyzYeoLj+aqqGzt91nY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GL29/x4roKFVpyxCPiqDmABmIXtFJV460sG7RhnP8WyqCKd0a2xjPk3TiUFE85vfx
         5HhuKFbC1sZrtg53XdyXtww2eRruxF6oN/A7+qL0UE1GxjAcsReWsqnsKd3gNJOL2X
         WHwrQjwerW8vNlpMAFWWfNSlxyEuar9ursn8aSGA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@endlessm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 65/80] platform/x86: asus-nb-wmi: Drop mapping of 0x33 and 0x34 scan codes
Date:   Mon,  4 Feb 2019 11:37:25 +0100
Message-Id: <20190204103629.145149526@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103620.287366543@linuxfoundation.org>
References: <20190204103620.287366543@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 71b12beaf12f21a53bfe100795d0797f1035b570 ]

According to Asus firmware engineers, the meaning of these codes is only
to notify the OS that the screen brightness has been turned on/off by
the EC. This does not match the meaning of KEY_DISPLAYTOGGLE /
KEY_DISPLAY_OFF, where userspace is expected to change the display
brightness.

Signed-off-by: João Paulo Rechi Vita <jprvita@endlessm.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/asus-nb-wmi.c |    2 --
 1 file changed, 2 deletions(-)

--- a/drivers/platform/x86/asus-nb-wmi.c
+++ b/drivers/platform/x86/asus-nb-wmi.c
@@ -442,8 +442,6 @@ static const struct key_entry asus_nb_wm
 	{ KE_KEY, 0x30, { KEY_VOLUMEUP } },
 	{ KE_KEY, 0x31, { KEY_VOLUMEDOWN } },
 	{ KE_KEY, 0x32, { KEY_MUTE } },
-	{ KE_KEY, 0x33, { KEY_DISPLAYTOGGLE } }, /* LCD on */
-	{ KE_KEY, 0x34, { KEY_DISPLAY_OFF } }, /* LCD off */
 	{ KE_KEY, 0x35, { KEY_SCREENLOCK } },
 	{ KE_KEY, 0x40, { KEY_PREVIOUSSONG } },
 	{ KE_KEY, 0x41, { KEY_NEXTSONG } },


