Return-Path: <giulio.benetti@micronovasrl.com>
X-Google-Smtp-Source: AB8JxZoIRppbUKjY6YDa1qJgdEoeQuOfnWvEkXo7fzuZJf1i3onSZTUCohM17siuSWsBV2iPKNlz
ARC-Seal: i=1; a=rsa-sha256; t=1526485441; cv=none;
        d=google.com; s=arc-20160816;
        b=OrMFhlIvRbsh1EU6sL3NLUUvzc6iRPNP7XIt8QH21ljEsXeViwzVxmIS3jahN4VJhM
         2A4P9Z7BdsFRFsVagpXTxemeCl1VBBBBXlURGK6eXoOnfuVaM/AD5Yo2ibacSh2Ddl9w
         K0EvQPBI2pPbNefDOaMRG3vNrG5mAnXG8H/6vl6FzR3OFiCST6JyRCnf8VEukWfx9XRd
         0h3U2Xpbz4rBbyi2Pu8EbhLoa43zqgWmnw7WaelSHKp94+/klsV8RA05ld+18XbKEmMV
         qzAG8EfCktG71L1qpL3hQh5Y2bmfL7FY/JLjT+XIeSFMvLqY3Z6cmdBGEn98D32/04tt
         yowA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=KiFg0fkB1t+Cm+cd0PA8qkXgMBSBLvaZ3xUgL+ihEqc=;
        b=TDqQAeAv/Amh9H/gSzw/ecQkyd/tZGGP+11zrxu+mLCp4czsf1IJqQDUS46fANQ2BB
         P1G75MiE2BUfF19Dgh9dlW7vjZ3UB6GEtrM2Xf4EAVsxZ5SJydok1gvgDZCEe9WPZE8B
         Ft4rarZs+Gnd2/Fms+D/CxZCS8scJkCYTFoEbvWLn50fDL7h1XY8+k116Ti0LXAE3cHp
         LUDUVrWZhcXpMZBtGu+dqhmY2xhKvdq5Dy6bUYin3k1SE/v93hFj+9+2fKEkoJTVMmNQ
         cCEpWgbzF5kNNhfDx2hSnc72vmtj0bUxdoJwctnMA0qio6Kt88bsFxyQJQIBXPXstimX
         uwrg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=temperror (no key for signature) header.i=@micronovasrl.com header.s=dkim header.b=fPAY1pZf;
       spf=pass (google.com: domain of giulio.benetti@micronovasrl.com designates 212.103.203.10 as permitted sender) smtp.mailfrom=giulio.benetti@micronovasrl.com
Authentication-Results: mx.google.com;
       dkim=temperror (no key for signature) header.i=@micronovasrl.com header.s=dkim header.b=fPAY1pZf;
       spf=pass (google.com: domain of giulio.benetti@micronovasrl.com designates 212.103.203.10 as permitted sender) smtp.mailfrom=giulio.benetti@micronovasrl.com
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)" header.d=micronovasrl.com
X-Spam-Flag: NO
X-Spam-Score: -2.9
From: Giulio Benetti <giulio.benetti@micronovasrl.com>
To: tglx@linutronix.de
Cc: pombredanne@nexb.com,
	gregkh@linuxfoundation.org,
	kstewart@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	Giulio Benetti <giulio.benetti@micronovasrl.com>
Subject: [PATCH v2] tty: fix typo in ASYNCB_FOURPORT comment
Date: Wed, 16 May 2018 17:43:54 +0200
Message-Id: <20180516154354.93727-1-giulio.benetti@micronovasrl.com>
X-Mailer: git-send-email 2.17.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600631959743697096?=
X-GMAIL-MSGID: =?utf-8?q?1600635997907524129?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On #define ASYNCB_FOURPORT there's an ortography error on comment:
"Set OU1, OUT2 per AST Fourport settings"

Change it into:
"Set OUT1, OUT2 per AST Fourport settings"

Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
---
V1 => V2:
* add commit log

 include/uapi/linux/tty_flags.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/tty_flags.h b/include/uapi/linux/tty_flags.h
index 6ac609a00dea..900a32e63424 100644
--- a/include/uapi/linux/tty_flags.h
+++ b/include/uapi/linux/tty_flags.h
@@ -13,7 +13,7 @@
  */
 #define ASYNCB_HUP_NOTIFY	 0 /* Notify getty on hangups and closes
 				    * on the callout port */
-#define ASYNCB_FOURPORT		 1 /* Set OU1, OUT2 per AST Fourport settings */
+#define ASYNCB_FOURPORT		 1 /* Set OUT1, OUT2 per AST Fourport settings */
 #define ASYNCB_SAK		 2 /* Secure Attention Key (Orange book) */
 #define ASYNCB_SPLIT_TERMIOS	 3 /* [x] Separate termios for dialin/callout */
 #define ASYNCB_SPD_HI		 4 /* Use 57600 instead of 38400 bps */
-- 
2.17.0
