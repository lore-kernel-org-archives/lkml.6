Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpqx7XalWIr6Z2UncIN4xvSlohAsZ1XR+ssHo7ByKMEqY+FxcjO0kKQO1u/9+2wN7UO7FAz
ARC-Seal: i=1; a=rsa-sha256; t=1525116531; cv=none;
        d=google.com; s=arc-20160816;
        b=EG7FN+E3czzmqY+BXPpPDuw9NGvnyu+neApHiXOTR+ExJkqFzLU6YBQx00AFCaQUGV
         tDGfSC8BLSpHsNCtjuQwGfD3vGfjByL/p369k2BNf8+3s6szTY//RTSMFa48BDS3+zNa
         cJgMRmsU4x0Uaq7IWpy7n2WI7/MYNmSoQmp2mYZfRa8Bxqtl5YUoykYBJa6vGIX3iGNC
         /YoHJyFQbOEXfIPDHdDnTdQ4i+4QirHVgAZevhoXdXCSwzuHCeznF39Z/xXDqzNyW4G+
         IJA88Jg5Hz5SPcaRI337xQUQiw9aN6lJEY+Ehu8LFZ0T86HFl9DvrG6v7mVxKKpBWuWq
         JbHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=p4fyxbkXVBlarePLO1QTr/2pqlRoGUgLP103oQhFio8=;
        b=oz3KX5b2/CmZPpsGOL63q10QmQDOVCm5X7zVYXIVMlBlNUzmFLw29zKdbbfVfEZ63Z
         XWYcQ++PE02lgndaNWs/qIVvEDJ7/iNgfuou1JNNMczk53y7744nwdlZ9k/oWVN9nWqG
         SvYxZsMSn8jYA0gpbsB5R5HxNgfWtNkr0ygAamyywy+6hOwEBpeLQzmkPzepchM5uQlF
         kcIPDWOn0eoE443rNiF9wxms1y6j93j0tU5dtKux3kBEQ+HIHGIoOvGsVu0sinGcfF+N
         etwfv92KdrHiRiFnalpVyQ8JqRI7nB68NQG9fOMF7TfXMBe1Ksg/Glb5pYdWKXBJR4gP
         YJEQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2535922E01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Hans Ulli Kroll <ulli.kroll@googlemail.com>,
	Andreas Fiedler <andreas.fiedler@gmx.net>,
	Roman Yeryomin <roman@advem.lv>,
	Linus Walleij <linus.walleij@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4.16 076/113] ARM: dts: Fix NAS4220B pin config
Date: Mon, 30 Apr 2018 12:24:47 -0700
Message-Id: <20180430184018.406192527@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200592051421460?=
X-GMAIL-MSGID: =?utf-8?q?1599200592051421460?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Linus Walleij <linus.walleij@linaro.org>

commit 1c3bc8fb10c1803f8651911722ed584db3dfb0f2 upstream.

The DTS file for the NAS4220B had the pin config for the
ethernet interface set to the pins in the SL3512 SoC while
this system is using SL3516. Fix it by referencing the
right SL3516 pins instead of the SL3512 pins.

Cc: stable@vger.kernel.org
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>
Reported-by: Andreas Fiedler <andreas.fiedler@gmx.net>
Reported-by: Roman Yeryomin <roman@advem.lv>
Tested-by: Roman Yeryomin <roman@advem.lv>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/gemini-nas4220b.dts |   28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

--- a/arch/arm/boot/dts/gemini-nas4220b.dts
+++ b/arch/arm/boot/dts/gemini-nas4220b.dts
@@ -134,37 +134,37 @@
 						function = "gmii";
 						groups = "gmii_gmac0_grp";
 					};
-					/* Settings come from OpenWRT */
+					/* Settings come from OpenWRT, pins on SL3516 */
 					conf0 {
-						pins = "R8 GMAC0 RXDV", "U11 GMAC1 RXDV";
+						pins = "V8 GMAC0 RXDV", "T10 GMAC1 RXDV";
 						skew-delay = <0>;
 					};
 					conf1 {
-						pins = "T8 GMAC0 RXC", "T11 GMAC1 RXC";
+						pins = "Y7 GMAC0 RXC", "Y11 GMAC1 RXC";
 						skew-delay = <15>;
 					};
 					conf2 {
-						pins = "P8 GMAC0 TXEN", "V11 GMAC1 TXEN";
+						pins = "T8 GMAC0 TXEN", "W11 GMAC1 TXEN";
 						skew-delay = <7>;
 					};
 					conf3 {
-						pins = "V7 GMAC0 TXC";
+						pins = "U8 GMAC0 TXC";
 						skew-delay = <11>;
 					};
 					conf4 {
-						pins = "P10 GMAC1 TXC";
+						pins = "V11 GMAC1 TXC";
 						skew-delay = <10>;
 					};
 					conf5 {
 						/* The data lines all have default skew */
-						pins = "U8 GMAC0 RXD0", "V8 GMAC0 RXD1",
-						       "P9 GMAC0 RXD2", "R9 GMAC0 RXD3",
-						       "U7 GMAC0 TXD0", "T7 GMAC0 TXD1",
-						       "R7 GMAC0 TXD2", "P7 GMAC0 TXD3",
-						       "R11 GMAC1 RXD0", "P11 GMAC1 RXD1",
-						       "V12 GMAC1 RXD2", "U12 GMAC1 RXD3",
-						       "R10 GMAC1 TXD0", "T10 GMAC1 TXD1",
-						       "U10 GMAC1 TXD2", "V10 GMAC1 TXD3";
+						pins = "W8 GMAC0 RXD0", "V9 GMAC0 RXD1",
+						       "Y8 GMAC0 RXD2", "U9 GMAC0 RXD3",
+						       "T7 GMAC0 TXD0", "U6 GMAC0 TXD1",
+						       "V7 GMAC0 TXD2", "U7 GMAC0 TXD3",
+						       "Y12 GMAC1 RXD0", "V12 GMAC1 RXD1",
+						       "T11 GMAC1 RXD2", "W12 GMAC1 RXD3",
+						       "U10 GMAC1 TXD0", "Y10 GMAC1 TXD1",
+						       "W10 GMAC1 TXD2", "T9 GMAC1 TXD3";
 						skew-delay = <7>;
 					};
 					/* Set up drive strength on GMAC0 to 16 mA */
