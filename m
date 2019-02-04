Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAFA9C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EA202075C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549278481;
	bh=Zq8xtN60fOCYJg9tBeTOu1C1ofMh+RNz2iRLG3FA358=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kuo8Dc8gSeubbptPX5SWT3xelPg9KS6pmffehnUbxyuuMn8xUOqMwu2mVXE52poFY
	 HWTOd16ICFyAzIFC4RChSEZpzZS8pA4L//FJXzznbe4jHSZ8OX72or6FJ1rMQmFTXs
	 MfTZSKt2MumGtu4NycLxCGjGLxSAj37KzhwlfAzM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731117AbfBDLHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 06:07:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:40286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728505AbfBDKmV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:42:21 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 310452075B;
        Mon,  4 Feb 2019 10:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549276940;
        bh=Zq8xtN60fOCYJg9tBeTOu1C1ofMh+RNz2iRLG3FA358=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Thj7cE/ajd/J5TYXlWt9nX+Rh+X0YXTobQuq+jZ7sRyrEu1QYNAv2+dpwz0iSuIBT
         7p1n389mEc8y234ig1yJhVKZ/KZck6Age/t8A1rYQ4IF012+SKFmgsywAtAIotmkYA
         ytO5ZgJbNMXYT7MSlbOHHACokL4MNbRxsvLuAl4M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@endlessm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 48/65] platform/x86: asus-nb-wmi: Drop mapping of 0x33 and 0x34 scan codes
Date:   Mon,  4 Feb 2019 11:36:41 +0100
Message-Id: <20190204103618.657373584@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103610.583715954@linuxfoundation.org>
References: <20190204103610.583715954@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -339,8 +339,6 @@ static const struct key_entry asus_nb_wm
 	{ KE_KEY, 0x30, { KEY_VOLUMEUP } },
 	{ KE_KEY, 0x31, { KEY_VOLUMEDOWN } },
 	{ KE_KEY, 0x32, { KEY_MUTE } },
-	{ KE_KEY, 0x33, { KEY_DISPLAYTOGGLE } }, /* LCD on */
-	{ KE_KEY, 0x34, { KEY_DISPLAY_OFF } }, /* LCD off */
 	{ KE_KEY, 0x35, { KEY_SCREENLOCK } },
 	{ KE_KEY, 0x40, { KEY_PREVIOUSSONG } },
 	{ KE_KEY, 0x41, { KEY_NEXTSONG } },


