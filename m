Return-Path: <kernel-hardening-return-12314-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELtnq2mF9BkJC6YFEAmldi1kAxSSK1BKRl1j/P++6udvYbB16r2LeX6L2ovf0sIuBYw2ZjKJ
ARC-Seal: i=1; a=rsa-sha256; t=1520599140; cv=none;
        d=google.com; s=arc-20160816;
        b=ZbTIfvrxBNCTOUu6U9sxFW6NnDCnwJgn5legsQJsacvofRvVxrCM4U0sXR3Bwo1c/k
         0L2BK/Pv4bz8FVTrHei7dYyNtil4oAELIsSsJ+HnAkhjIzGeMRu7IfhkFO8ztD7CbD6D
         4sCplKXuvyI9Kl7PkEOEY3k74TwzJhvAlH8LbisWQko8J160EAIwKtlJQCoQ1wqae6F4
         l3C4cg6gBMU6s2SZ2hB+xOfpmoBHKcKuzPHEvlQx5qgFeVBeIcWRP3vyTIvXNNl/K6kH
         1srLEQYhyDA0GC1jec/R3myJyYL/61Fa9SxV98EbyDdM3nFFAD9j+++r9Pf5rhOWb+w5
         SDXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature:delivered-to
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=xtiuWI9Z0HSwYgxn85GAlokiz4gHR8q1NAKsDgqQoD4=;
        b=eJfOCETm4WleUJ3Bx4DHUqti5gs5HdVyiEOIm6mW80ONicIfvUsAzt3TCa0vIH4So+
         0qNuHRDxejPFM8IfnMv7b00kd+CA6EPJHpLY2HCa45a2kmfjyRueKGNeCyxJb6Widhe+
         NjT3ca5Vl/BfA2vOF6SXDNiuvlaaEBkifHMC+6Wgy0yT/F5gJsetLB0BeYXOtaysaOU4
         1GTmk3q+S1lm9TGFedXC4gERHLVvZnoV5PO9INHZXQR5jxO4KDi7724ul1x4Koyri9Hx
         GTdlwEFYDSX7JITY6iftEd8uCuuwZ1gxzUrXjg9c52xfJfHoDPBICB8iuFh7wzpaP9b8
         4HGQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=tEASLpdP;
       spf=pass (google.com: domain of kernel-hardening-return-12314-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12314-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=tEASLpdP;
       spf=pass (google.com: domain of kernel-hardening-return-12314-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12314-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: Andreas Christoforou <andreaschristofo@gmail.com>
To: keescook@chromium.org
Cc: kernel-hardening@lists.openwall.com,
	Andreas Christoforou <andreaschristofo@gmail.com>,
	QCA ath9k Development <ath9k-devel@qca.qualcomm.com>,
	Kalle Valo <kvalo@codeaurora.org>,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: net: wireless: ath: ath9: dfs: remove VLA usage
Date: Fri,  9 Mar 2018 14:30:12 +0200
Message-Id: <1520598613-3641-1-git-send-email-andreaschristofo@gmail.com>
X-Mailer: git-send-email 2.7.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594463764603415966?=
X-GMAIL-MSGID: =?utf-8?q?1594463764603415966?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The kernel would like to have all stack VLA usage removed.

Signed-off-by: Andreas Christoforou <andreaschristofo@gmail.com>
---
 drivers/net/wireless/ath/ath9k/dfs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/dfs.c b/drivers/net/wireless/ath/ath9k/dfs.c
index 6fee9a4..cfb0f84 100644
--- a/drivers/net/wireless/ath/ath9k/dfs.c
+++ b/drivers/net/wireless/ath/ath9k/dfs.c
@@ -41,7 +41,6 @@ static const int BIN_DELTA_MAX		= 10;
 
 /* we need at least 3 deltas / 4 samples for a reliable chirp detection */
 #define NUM_DIFFS 3
-static const int FFT_NUM_SAMPLES	= (NUM_DIFFS + 1);
 
 /* Threshold for difference of delta peaks */
 static const int MAX_DIFF		= 2;
@@ -101,7 +100,7 @@ static bool ath9k_check_chirping(struct ath_softc *sc, u8 *data,
 				 int datalen, bool is_ctl, bool is_ext)
 {
 	int i;
-	int max_bin[FFT_NUM_SAMPLES];
+	int max_bin[NUM_DIFFS + 1];
 	struct ath_hw *ah = sc->sc_ah;
 	struct ath_common *common = ath9k_hw_common(ah);
 	int prev_delta;
-- 
2.7.4
