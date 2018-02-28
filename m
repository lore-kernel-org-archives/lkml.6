Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751950AbeB1AQt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 19:16:49 -0500
Received: from conuserg-09.nifty.com ([210.131.2.76]:24306 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751706AbeB1AQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 19:16:47 -0500
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com w1S0Fahn000353
X-Nifty-SrcIP: [125.199.20.195]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Marc Herbert <marc.herbert@intel.com>,
        Ulf Magnusson <ulfalizer@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/6] kconfig: remove redundant input_mode test for check_conf() loop
Date: Wed, 28 Feb 2018 09:15:23 +0900
Message-Id: <1519776926-30459-4-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519776926-30459-1-git-send-email-yamada.masahiro@socionext.com>
References: <1519776926-30459-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

check_conf() never increments conf_cnt for listnewconfig, so conf_cnt
is always zero.

In other words, conf_cnt is not zero, "input_mode != listnewconfig"
is met.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Reviewed-by: Ulf Magnusson <ulfalizer@gmail.com>
---

Changes in v2: None

 scripts/kconfig/conf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/kconfig/conf.c b/scripts/kconfig/conf.c
index 1faa55f..59656d3 100644
--- a/scripts/kconfig/conf.c
+++ b/scripts/kconfig/conf.c
@@ -669,7 +669,7 @@ int main(int ac, char **av)
 		do {
 			conf_cnt = 0;
 			check_conf(&rootmenu);
-		} while (conf_cnt && input_mode != listnewconfig);
+		} while (conf_cnt);
 		break;
 	case olddefconfig:
 	default:
-- 
2.7.4
