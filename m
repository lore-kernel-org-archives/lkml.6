Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165773AbeE1O3h (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 10:29:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:53698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161713AbeE1Kdb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:33:31 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jon Mason <jon.mason@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 164/329] ARM: dts: NSP: Fix amount of RAM on BCM958625HR
Date: Mon, 28 May 2018 12:01:33 +0200
Message-Id: <20180528100256.098282959@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100241.796630982@linuxfoundation.org>
References: <20180528100241.796630982@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Fainelli <f.fainelli@gmail.com>

[ Upstream commit 0a5aff64f20d92c5a6e9aeed7b5950b0b817bcd9 ]

Jon attempted to fix the amount of RAM on the BCM958625HR in commit
c53beb47f621 ("ARM: dts: NSP: Correct RAM amount for BCM958625HR board")
but it seems like we tripped over some poorly documented schematics.

The top-level page of the schematics says the board has 2GB, but when
you end-up scrolling to page 6, you see two chips of 4GBit (512MB) but
what the bootloader really initializes only 512MB, any attempt to use
more than that results in data aborts. Fix this again back to 512MB.

Fixes: c53beb47f621 ("ARM: dts: NSP: Correct RAM amount for BCM958625HR board")
Acked-by: Jon Mason <jon.mason@broadcom.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/bcm958625hr.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/boot/dts/bcm958625hr.dts
+++ b/arch/arm/boot/dts/bcm958625hr.dts
@@ -49,7 +49,7 @@
 
 	memory {
 		device_type = "memory";
-		reg = <0x60000000 0x80000000>;
+		reg = <0x60000000 0x20000000>;
 	};
 
 	gpio-restart {
