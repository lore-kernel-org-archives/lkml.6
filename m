Return-Path: <cmc@babblebit.net>
X-Google-Smtp-Source: AIpwx49wlFkqw7JLNZjfSteLAzA1SFRPTl4snfTd3rHdSW9Dpic4kRlL5XbgqJFBoB36IoUJjoaX
ARC-Seal: i=1; a=rsa-sha256; t=1522327725; cv=none;
        d=google.com; s=arc-20160816;
        b=FMBUHOorMhLK63JzDhue39NHLE0/3plIC/7cokf6WuJPzEM2teCBBKlnkDAeh0TuZZ
         XvNHvQfZdokKpfETy3zHehNw2JA0XT3eO0XFLokreZLGnLQHjmxujFQEp8kgm3it6ykF
         cDMrGIhI54HfdxrJr+eoZaxISxF843o3wz1vCOIn4qAwFwTiQhCeRvydhFkWzMC2TOcl
         ug0YlCvo8BreYSdWJZP9TYYn6p7ZdjBWuJ5s5zNao4wiDk8JUOVeVmYyweuWchPGIAmh
         SrxP+zibUmSrN7b0Jpqd7UcRzT3RHrseK1Nt2Arbu8Jdj6+AltXkqOC37S9ER+e4fsya
         MwjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=jdQwwZQzanoC0dC079dR1oW0RxLgrHNxIO411KxUnw4=;
        b=LN5KXf/iUep9FRUDdkQh1/MhIKV0Ru/n3LQQqI2s5k57Vq1S4NEvnd0wT1jezhsG+a
         k/LEbvPCpAplGaqKPIw7tmEoHmgIYJmpc1jrv3vzImwwwO+exMC+NkCLdc4MXpuZbtEQ
         8iqJxw8XSr7WB7t/+veoCfqV8bbajPf+ay7IbDiEQKG1kRupcNde7lvpP7FH3A9kDvL6
         bCAwBy/XUEQqbpHTdrV2xDb6uPceRZ0SZnyOfBRX1+cAmKql+ZPh2t1CJCUv7s2NbJdF
         PF2AoMIZvq8ctI0yzSuXYfIon6Gr19BByoBnsb00/G8MSI0hPLiI+7ALMP2Y7X4rxgpr
         OLCg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@babblebit.net header.s=mail header.b=QpKoU/Vn;
       spf=pass (google.com: domain of cmc@babblebit.net designates 37.139.8.208 as permitted sender) smtp.mailfrom=cmc@babblebit.net;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=babblebit.net
Authentication-Results: mx.google.com;
       dkim=pass header.i=@babblebit.net header.s=mail header.b=QpKoU/Vn;
       spf=pass (google.com: domain of cmc@babblebit.net designates 37.139.8.208 as permitted sender) smtp.mailfrom=cmc@babblebit.net;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=babblebit.net
From: Chris Coffey <cmc@babblebit.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	NeilBrown <neil@brown.name>,
	Matthias Brugger <matthias.bgg@gmail.com>
Cc: devel@driverdev.osuosl.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Chris Coffey <cmc@babblebit.net>
Subject: [PATCH v2] staging: mt7621-eth: Fix sparse warning in ethtool.c
Date: Thu, 29 Mar 2018 13:47:45 +0100
Message-Id: <20180329124745.24694-1-cmc@babblebit.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180329095637.GA16778@kroah.com>
References: <20180329095637.GA16778@kroah.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596276317072561882?=
X-GMAIL-MSGID: =?utf-8?q?1596276317072561882?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This fixes the following sparse warning:

drivers/staging/mt7621-eth/ethtool.c:213:6: warning: symbol
'mtk_set_ethtool_ops' was not declared. Should it be static?

Signed-off-by: Chris Coffey <cmc@babblebit.net>
Reviewed-by: NeilBrown <neil@brown.name>
---
Changes in v2:
 - Per GregKH's feedback (thanks!), don't add unnecessary new .h file
 dependencies. This patch version reverts those changes and fixes the
 problem directly in ethtool.c (which is that it didn't include
 ethtool.h anywhere -- mtk_set_ethtool_ops is not static).

 drivers/staging/mt7621-eth/ethtool.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/mt7621-eth/ethtool.c b/drivers/staging/mt7621-eth/ethtool.c
index 38ba0c040a..5268c5ca09 100644
--- a/drivers/staging/mt7621-eth/ethtool.c
+++ b/drivers/staging/mt7621-eth/ethtool.c
@@ -13,6 +13,7 @@
  */
 
 #include "mtk_eth_soc.h"
+#include "ethtool.h"
 
 static const char mtk_gdma_str[][ETH_GSTRING_LEN] = {
 #define _FE(x...)	# x,
-- 
2.11.0
