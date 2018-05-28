Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165487AbeE1NnM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:43:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:34654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937413AbeE1Kno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:43:44 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ulf Magnusson <ulfalizer@gmail.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 059/496] ARC: Fix malformed ARC_EMUL_UNALIGNED default
Date: Mon, 28 May 2018 11:57:24 +0200
Message-Id: <20180528100322.285219779@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ulf Magnusson <ulfalizer@gmail.com>

[ Upstream commit 827cc2fa024dd6517d62de7a44c7b42f32af371b ]

'default N' should be 'default n', though they happen to have the same
effect here, due to undefined symbols (N in this case) evaluating to n
in a tristate sense.

Remove the default from ARC_EMUL_UNALIGNED instead of changing it. bool
and tristate symbols implicitly default to n.

Discovered with the
https://urldefense.proofpoint.com/v2/url?u=https-3A__github.com_ulfalizer_Kconfiglib_blob_master_examples_list-5Fundefined.py&d=DwIBAg&c=DPL6_X_6JkXFx7AXWqB0tg&r=c14YS-cH-kdhTOW89KozFhBtBJgs1zXscZojEZQ0THs&m=WxxD8ozR7QQUVzNCBksiznaisBGO_crN7PBOvAoju8s&s=1LmxsNqxwT-7wcInVpZ6Z1J27duZKSoyKxHIJclXU_M&e=
script.

Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arc/Kconfig |    1 -
 1 file changed, 1 deletion(-)

--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -487,7 +487,6 @@ config ARC_CURR_IN_REG
 
 config ARC_EMUL_UNALIGNED
 	bool "Emulate unaligned memory access (userspace only)"
-	default N
 	select SYSCTL_ARCH_UNALIGN_NO_WARN
 	select SYSCTL_ARCH_UNALIGN_ALLOW
 	depends on ISA_ARCOMPACT
