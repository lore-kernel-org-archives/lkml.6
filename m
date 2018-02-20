Return-Path: <arnd@arndb.de>
X-Google-Smtp-Source: AH8x224WrxIBlGfdj0/1yYiuqIysFjaIi1UzA1GxxlbkapB7doPkihlZGFhSW5paEQ2qryOTKjSj
ARC-Seal: i=1; a=rsa-sha256; t=1519127980; cv=none;
        d=google.com; s=arc-20160816;
        b=pGitAhQkgPnIhxjf7BxCGfUiSgrPPX7q4nPvfJnIf83ncZ+HTU2HIJH8yREU86RfPt
         YIZ4lb2tpbl77+yXGV9+s85q2mLozfgTPtrGt31HHFiUWkZ3TrVDSwby+OGw7Gk+oiIb
         C8ScJreoRSdcA9GQKPBf8VD5vD06h+YNgRozYelGz0IN986Zq3nmTUBjTSfkyZ1bU1w7
         bFdzt56MkL2Xs8UeDpTyckzmMfN70cZhk10W+JulG4hcALURuY7yj66H7h8QQ+6y2jpi
         JEWotn+trcPSOdjs427U9XydlgDvuzz1I6khHhL2lzgEQgeePYKxyePRRxeLoz7/fGTk
         EuSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=BSMY3QHYJVeiTCS8YsbcByc2ivKYqApa3wqOoW8mehU=;
        b=ueoCAnijPKrFW6lZAGzm0c3+55+6RX4RbDSVrobaf13NHSjFmK8SYHcv+0rymTR6U5
         oI8M6HbCvrjwj/r6zG1AkSMzRJTwpn7y2+LKlspzUvcydXaR9g4d7hTJb7BsZiytATTG
         blbEoW/V8iFhKpkADAXxJ9beDwdLUvg/w1SKFPtPiOKvMDBVoRcwLBaeF8czLSe8x6VR
         Z/ErGaCdlH9PsltDtnSc8jX0p5+BpNVxEUgjOtm4gmurO6t8vphcU1kPci3GtAoEhFCk
         nJKetBRWF7qrJYdOKzaDyMpac7ueTpfGMh85vRgcpzIzy3fmxVt/D9aFNbfzUTPQAh18
         0HHw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 217.72.192.73 is neither permitted nor denied by best guess record for domain of arnd@arndb.de) smtp.mailfrom=arnd@arndb.de
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 217.72.192.73 is neither permitted nor denied by best guess record for domain of arnd@arndb.de) smtp.mailfrom=arnd@arndb.de
From: Arnd Bergmann <arnd@arndb.de>
To: stable@vger.kernel.org
Cc: Greg KH <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	Jun Nie <jun.nie@linaro.org>,
	Vinod Koul <vinod.koul@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Shawn Guo <shawn.guo@linaro.org>,
	Sasha Levin <alexander.levin@verizon.com>,
	dmaengine@vger.kernel.org
Subject: [4.4-stable 16/22] dmaengine: zx: fix build warning
Date: Tue, 20 Feb 2018 12:55:03 +0100
Message-Id: <20180220115527.1806578-17-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180220115527.1806578-1-arnd@arndb.de>
References: <20180220115527.1806578-1-arnd@arndb.de>
X-Provags-ID: V03:K0:tc+AkfOPIj+mbEMAmdIVXHozh5l7Chf65N3urJFqVsks5T7RYDh
 +cED9PmjxbruYoGzjmlEw6dM9fRafibBqI/6zsGpjFmWI/HUeWrA1seiHns2YjHUpIEWTBM
 dnrKI1MxCUDG1EebyHzKeEGOza58KP5an265IRrI/0TQ4m/8SPZz0FwYZFaVasnHvxEUAQ1
 fPisZh1ernhpvFdior7Kg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:A27fwyVOJN4=:pGHD7iCr1oftl9xxeLztwu
 WfCkVPzeRKFZuhidyIDrn0ln3aYZa57G8RlITvXCYbEwk5RH/iu4Xj/fgBk+7lXhLD1XSpZC7
 NYCaFmg6pSV0gYM0p8AR9uSdxJqp6lUelhevyl1S0s9AG9w/0x5iS+Q2481LUq68tEQjmA37A
 MA3BtD2sclVLSTiwD/TVGt1mKnDTIcMFi/FfWgj/PSBDBDQxpdpYuAu5PC1QyuTw2etxWHKxc
 5l/lWzvWpW8HEA0Ynuq6xgcpVdDguo9Iwkr+cOM4n/DpuPc36jsKvCd+md+l6TA2J/ug+9uTS
 7Dx3GNkwy+qLH8FLyRVt/K/ZWjI1veC8RUSoU4l2ng+f8l+rcTGxMFB2MGuG1bOKUKrcM5Ht0
 Ht0b7Gc2tuG2oxJoMNGQzQiZBu42LIBKVTv5YeBc4xt6Be5CPjbct2P0g3oYC7s0ND6hZNn3d
 YDqAbdSsD6t0+oiiZIJII8jg/inZTe5AFwgIMa6Txxwso6Mddndv3PHXK3PW64UxUuJJWPvWF
 vvi8KG/NkztRzG8ZgiFOfap9tNp/ssiuyLnifrkJE1Z0MFosRIpyleUFvGCi2TySrekdnWXxx
 SWaaNPOg0CM1f1YAgl6vvC09fEOTnbaonfKR1w7AoZIpDTsoxqvyAf/2UDAofoM3i6em6+X/p
 pJh1HwCnXbNuCZpi7g71fVqXBKtMlQ7xSbNx0QgnlmUDXaI8CYIEzrybdFcIiOAv+og6cOZ27
 mkMhBWRLov1ucLcKU/g/NbNjpwFv1vjB19DoKA==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592921141734722140?=
X-GMAIL-MSGID: =?utf-8?q?1592921141734722140?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jun Nie <jun.nie@linaro.org>

commit 067fdeb2f391bfa071f741a2b3eb74b8ff3785cd upstream.

Fix build warning that related to PAGE_SIZE. The maximum DMA
length has nothing to do with PAGE_SIZE, just use a fix number
for the definition.

drivers/dma/zx_dma.c: In function 'zx_dma_prep_memcpy':
drivers/dma/zx_dma.c:523:8: warning: division by zero [-Wdiv-by-zero]
drivers/dma/zx_dma.c: In function 'zx_dma_prep_slave_sg':
drivers/dma/zx_dma.c:567:11: warning: division by zero [-Wdiv-by-zero]

Signed-off-by: Jun Nie <jun.nie@linaro.org>
Tested-by: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
[arnd: rebased to 4.4-stable]
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/dma/zx296702_dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/zx296702_dma.c b/drivers/dma/zx296702_dma.c
index 6059d81e701a..8e55403847b2 100644
--- a/drivers/dma/zx296702_dma.c
+++ b/drivers/dma/zx296702_dma.c
@@ -26,7 +26,7 @@
 
 #define DRIVER_NAME		"zx-dma"
 #define DMA_ALIGN		4
-#define DMA_MAX_SIZE		(0x10000 - PAGE_SIZE)
+#define DMA_MAX_SIZE		(0x10000 - 512)
 #define LLI_BLOCK_SIZE		(4 * PAGE_SIZE)
 
 #define REG_ZX_SRC_ADDR			0x00
-- 
2.9.0
