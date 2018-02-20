Return-Path: <arnd@arndb.de>
X-Google-Smtp-Source: AH8x2250OqCMgGtG6055K5D9WJCp3cE8gCLyPzWHMrpgJI1d5tMOJd8vcoPGhra7q1Nz6bnq3yVx
ARC-Seal: i=1; a=rsa-sha256; t=1519127875; cv=none;
        d=google.com; s=arc-20160816;
        b=dAWWodvA1cLU9HrE4gIi7QHlwq330uYOPWvREexhd/cNFsQsjTYjUGfdinRvjzCWqr
         WwN5LlfAvxQtJBZg7to/A4KvBCYGTS7XW8Ga/qauFh9TIBSiQDUqAUMvCSj4QLWw+YUV
         3/8LY+zbVT+b7/CzGYViYaDqjU0EATT1mSFgXfXID7/gALI5rchP1ACkMedaSHLqUU17
         Jr1flD11SoLnWTzv8aTZgYouMSTgi8v0pGbEhx+hCfXkpRHEtU/Ri88hH5Ji4/z9YcBW
         g8oY66V3FTAc4bQerEWAmMDUqWJXXWDNYvP8s5Inbn/oMJ7JTiP3K3K4HsN/M9XNeVKM
         igug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=Fl7fdk2G+f0AMLPfy21mEwUJ81kbdXfmKKtoeRJptLo=;
        b=RUvPI/szwpZ8egK/6Tvi9OTUnUksYN6c2GVG96ghfiaLbLhTp/V11y1byJkmRjJsJz
         EeMVLX9/TbU6OsgKbumnsSrlFSDK8RjDnw0dTL7/75UL3iR2F4BOUGrx3NVixQWzuzRX
         oP31iWOMmC4KJ1FnRqA9xVPA/fvKObKnoSisF3xEn1qsdt8LMRMQpTV1lX6U53te4xK+
         wrhrZCd16Q8RVvyL3Ow3q4RXmSSkQlR+VC87bX8Y9xVnYxtTEaqfWG0nzvi6wvHIBRSS
         RC+ZvIF24xWxscEiw7I5lj7+/4AvtsyElg87V0M4F9kZtinLZquOZElcHyqSnIoe67Ht
         Tn/A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 217.72.192.75 is neither permitted nor denied by best guess record for domain of arnd@arndb.de) smtp.mailfrom=arnd@arndb.de
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 217.72.192.75 is neither permitted nor denied by best guess record for domain of arnd@arndb.de) smtp.mailfrom=arnd@arndb.de
From: Arnd Bergmann <arnd@arndb.de>
To: stable@vger.kernel.org
Cc: Greg KH <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Karsten Keil <isdn@linux-pingi.de>,
	netdev@vger.kernel.org
Subject: [4.4-stable 04/22] isdn: sc: work around type mismatch warning
Date: Tue, 20 Feb 2018 12:54:51 +0100
Message-Id: <20180220115527.1806578-5-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180220115527.1806578-1-arnd@arndb.de>
References: <20180220115527.1806578-1-arnd@arndb.de>
X-Provags-ID: V03:K0:zIwe370LQLXA/9Kx1TyVFIRhjAMoHSQUdlpMtjs1cKFkA5yhYWn
 IPcY9t6RPE2MTSUkCeLYfwT2BBWYsBj7XJ0zaLh79Uk6ZtwKg+63v0J7iK7qlpzR9puF0se
 ivF4NTMCZ4xHNMoZV9jiVGk4lmPX1nlKnCf8uanfwhQWWIosQWooW6NfraPGvDhx6GKdTYW
 SWpc6noMgsNqKrYlBo1aQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BsNSwTrm9U4=:/1B547Sw7qpdamF+dRgdp/
 aRKswH94fMMoNIZkUQzqrzCc+i5exEZKVyZuCKWUBbg3cvDsAghripce3ZwJUzTQ/BbP/eflp
 N/L9so5bLiSvlpAclCP75gWs/EN22KBBz8/Gg2bksNJslQOJJkbc3i/wMyx5Y2oB5PeT4WYym
 TzRLJPgJIgzxA+mH+Du53Jugy9Vip/kzDKnzFdm14DQFiuHHwxEA1is6ikGFFs5Lzm6DRuwhw
 AqjVTlT3UPr1DucSqjIJCRj67/brD6vsKcSJrfMJkFHwH1qJ8oDH13g0iEaMgPNGQRbsNT6Tf
 VRPeDc8n/MVqz2JpiJj99NwMB7uq+K4OkDRRthJNweTnyBPtv8vsFt+/MlkBbdRiSbUFcekpS
 JK8kKoAEQ0mh3GfOYmorUxUg5Q7CbmnIWsnvR1e4NHLorAxLxD6shQ8uPHu09FC6916RuxN9u
 H8kI5FfMYJa5MKJBdmVNOWg+IqYmAaVq4oDJsuT9Ew0MEVN10PM7vDoqymn2VFjeEaGnYiZF5
 oDfU5nvKnt6GBwCbNC+W7jV55TLYCBjQfgZUjjSWc1QL4y35km14ufIyVXxieqeU8IwYK21LU
 WDmTTPnlo21O1l3pvz2i7EMh4aDq8O1L3I9WxUnb95KFZhKxmTAzvAGmYN0A9562CPu8I6sh6
 MLTDRyYIUaP/2xIn4WDOJN9YjzEWCIDW+Bt8PAMcgWtPyf4M8gzAXo9Sog31g4k0el7yFmMQ6
 AGTVm04snQSk6cTYYD7QqpI/0DmvdYuhQmisDA==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592921031090286782?=
X-GMAIL-MSGID: =?utf-8?q?1592921031090286782?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This driver shows warnings on many architectures:

drivers/isdn/sc/init.c: In function 'identify_board':
drivers/isdn/sc/init.c:484:2: error: passing argument 1 of 'readl' makes pointer from integer without a cast [-Werror]

In newer kernels, it was completely removed, but for the 4.4-stable
series, let's just shut up that warning by adding an extra variable
to do the necessary type cast.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/isdn/sc/init.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/isdn/sc/init.c b/drivers/isdn/sc/init.c
index 3597ef47b28a..09fc129ef2fa 100644
--- a/drivers/isdn/sc/init.c
+++ b/drivers/isdn/sc/init.c
@@ -441,6 +441,7 @@ static int identify_board(unsigned long rambase, unsigned int iobase)
 	RspMessage rcvmsg;
 	ReqMessage sndmsg;
 	HWConfig_pl hwci;
+	void __iomem *rambase_sig = (void __iomem *)rambase + SIG_OFFSET;
 	int x;
 
 	pr_debug("Attempting to identify adapter @ 0x%lx io 0x%x\n",
@@ -481,7 +482,7 @@ static int identify_board(unsigned long rambase, unsigned int iobase)
 	 */
 	outb(PRI_BASEPG_VAL, pgport);
 	msleep_interruptible(1000);
-	sig = readl(rambase + SIG_OFFSET);
+	sig = readl(rambase_sig);
 	pr_debug("Looking for a signature, got 0x%lx\n", sig);
 	if (sig == SIGNATURE)
 		return PRI_BOARD;
@@ -491,7 +492,7 @@ static int identify_board(unsigned long rambase, unsigned int iobase)
 	 */
 	outb(BRI_BASEPG_VAL, pgport);
 	msleep_interruptible(1000);
-	sig = readl(rambase + SIG_OFFSET);
+	sig = readl(rambase_sig);
 	pr_debug("Looking for a signature, got 0x%lx\n", sig);
 	if (sig == SIGNATURE)
 		return BRI_BOARD;
@@ -501,7 +502,7 @@ static int identify_board(unsigned long rambase, unsigned int iobase)
 	/*
 	 * Try to spot a card
 	 */
-	sig = readl(rambase + SIG_OFFSET);
+	sig = readl(rambase_sig);
 	pr_debug("Looking for a signature, got 0x%lx\n", sig);
 	if (sig != SIGNATURE)
 		return -1;
-- 
2.9.0
