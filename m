Return-Path: <kernel-hardening-return-12321-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELuEeiEy5+6Z5MrO2O5IJcuxLyIjM+yNkAmSI/JAdC3WAOjrhSBmqwHJ5fQaDeIkDcD4Yrac
ARC-Seal: i=1; a=rsa-sha256; t=1520601873; cv=none;
        d=google.com; s=arc-20160816;
        b=zOrTWopOFnyGxzW/LzLJ2vCNWmdE5kEswOfhqBkire5nyDhGg7FoSzKU/zfeVMeQzF
         Lsc4rvecEONIMzAvr6kPDTtNR6Ig1C8UW3LFDzc2q4jnTELhIJ34hEkOZ060FnS+QMQo
         m1qOutDm/ckpazWVYxrtL4EhDIdSTVo4KcFKmL8PNVgtr/gk+AogLC87twNW3xrvGx5l
         Q4/0UCykXjVA5Os3aNTlOkkyF2MRJz5glGlb5GTyz6iP7JtWj18z4bMc/nr+TOfLFv8M
         nAL1Q9a/0sCJaOqxR6LHxysbPcQGy000quFMe/NX1j4v+dOKMl5YY2PLBKNNYvkpbPyX
         woIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=MWNXC5ofCyBb8jMDXVTy/I6933co+H5gBwlgyq57RHw=;
        b=nlZ+2+ooISJciDM6nQRZACxg2qNbwU3x/TQepIYPILUu/JGiSVw8uBPHMjwdzsZilx
         AurMoGzwa2ycAhxCt7hc0lMmg5dKKAi/YL0aJSToN0j4aD6sHscuwjGv2d4sqd02DNfx
         6iIzn6WyyRxZprcqPdUOshh5Irlyc2nMsP2jvVrYcki/fbTMluxIFvTbcfzp5NuUOgFT
         2AH393K5UN8mVQZFrrk9YGzWmyh6f/JTm+qRGRncGdkN+m3nukxz2WLdweXmVN16qbfi
         HQsE+taaNAyr6OppyPyOe0eUyCYaIGHIeMbZ3lvXJBdnS0dszQvGkXgSSOzv1jsR5jP8
         F54w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=nqBlYY5K;
       spf=pass (google.com: domain of kernel-hardening-return-12321-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12321-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=nqBlYY5K;
       spf=pass (google.com: domain of kernel-hardening-return-12321-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12321-gregkh=linuxfoundation.org@lists.openwall.com;
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
Subject: [PATCH] drivers: net: wireless: ath: ath9k: dfs: remove VLA usage
Date: Fri,  9 Mar 2018 15:23:53 +0200
Message-Id: <1520601833-4952-1-git-send-email-andreaschristofo@gmail.com>
X-Mailer: git-send-email 2.7.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594466629940454496?=
X-GMAIL-MSGID: =?utf-8?q?1594466629940454496?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The kernel would like to have all stack VLA usage removed.

This is the correct patch.

Signed-off-by: Andreas Christoforou <andreaschristofo@gmail.com>
---
 drivers/net/wireless/ath/ath9k/dfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath9k/dfs.c b/drivers/net/wireless/ath/ath9k/dfs.c
index 6fee9a4..eeb77f2 100644
--- a/drivers/net/wireless/ath/ath9k/dfs.c
+++ b/drivers/net/wireless/ath/ath9k/dfs.c
@@ -101,7 +101,7 @@ static bool ath9k_check_chirping(struct ath_softc *sc, u8 *data,
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
