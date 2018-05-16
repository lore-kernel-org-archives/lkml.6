Return-Path: <sabin.rapan@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1526495242; cv=none;
        d=google.com; s=arc-20160816;
        b=FnzwJJRiin8AUTLMHUya24bmiAqSBCAZ09PCcobB0s/VqP3Gmh42qPmOky/m6wozEV
         eKZkQJAqgU8bw3qck6/XENVRRGamDb/rd3THWSWwrLxoZ3PfaO7eQ+rVeHNwNhdMaANr
         PF9NXTX49+bhysURZZemcPo+ru83J5A/eMG6MYAoL+5Ko03Fl9Bp3jsCDqKo8fSKiZih
         eVNI1c0z65T1CDIDg+PDSZgxUhg/WSMWie0O9+Sw9zHdFXjV+AObpUd9jUQjwt3nBti3
         rxUzDt9FmrG2gsRHt18k8YIzG828P/kzayz+/pqUPME2ujdUNAhYvxEqjgg1jL0QG5tG
         BexQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=X9gxwzWSJKSMxF3GcOs0TXZ2+iY82OaN8xHcROhxcTg=;
        b=hdVnuRxmufR4/QqN79o4WvHTmeJZCi+WGxD7migDUKkE7S6UBPYG2od+PiINeRIP/r
         623dcp7usIMUDyZGapJPsyU1y2owzeRkaMjXVTJ38avRMCUVdCm5fxPLXUMwmS23HyGf
         0T+hXa4/ZITH7oXCtc1DQOzKZzGShi10JB1KtPPxn1NaHI/IPIzhLHBJdxIbfvol9aGo
         RbGaSg9VYftpKdg7Az39Cs+wpoBPbIyml5T3n49MVdzRTEFtWS1qpjNzj2beA0mFMU/d
         ncac7uyc1Z04GZVmk4V0uVoJjhIHw8EWfAihtitnqmxw2X54E2pVsomNzy6PJUVTbM4B
         2trQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=EUKOKU73;
       spf=pass (google.com: domain of sabin.rapan@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=sabin.rapan@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=EUKOKU73;
       spf=pass (google.com: domain of sabin.rapan@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=sabin.rapan@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZqFiCyTNYmB4WpMbj2qdorP0RY2L9WEZ3VNtwNyZ6tSYHZPhtFBWlc6El5EoxqcQ8nRcxGWXw==
From: Sabin Mihai Rapan <sabin.rapan@gmail.com>
To: gregkh@linuxfoundation.org,
	jsimmons@infradead.org,
	andreas.dilger@intel.com,
	oleg.drokin@intel.com,
	lustre-devel@lists.lustre.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sabin Mihai Rapan <sabin.rapan@gmail.com>
Subject: [PATCH 3/5] staging: lustre: Fix "unsigned"->"unsigned int"
Date: Wed, 16 May 2018 20:27:17 +0200
Message-Id: <20180516182717.5240-1-sabin.rapan@gmail.com>
X-Mailer: git-send-email 2.17.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600646275651835975?=
X-GMAIL-MSGID: =?utf-8?q?1600646275651835975?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch fixes the checkpatch.pl warning:

WARNING:UNSPECIFIED_INT: Prefer 'unsigned int' to bare use of 'unsigned'

Signed-off-by: Sabin Mihai Rapan <sabin.rapan@gmail.com>
---
 .../staging/lustre/include/uapi/linux/lustre/lustre_fiemap.h    | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/lustre/include/uapi/linux/lustre/lustre_fiemap.h b/drivers/staging/lustre/include/uapi/linux/lustre/lustre_fiemap.h
index f5214dc33c60..d375a476f5ea 100644
--- a/drivers/staging/lustre/include/uapi/linux/lustre/lustre_fiemap.h
+++ b/drivers/staging/lustre/include/uapi/linux/lustre/lustre_fiemap.h
@@ -51,7 +51,7 @@ static inline size_t fiemap_count_to_size(size_t extent_count)
 				       sizeof(struct fiemap_extent);
 }
 
-static inline unsigned fiemap_size_to_count(size_t array_size)
+static inline unsigned int fiemap_size_to_count(size_t array_size)
 {
 	return (array_size - sizeof(struct fiemap)) /
 		sizeof(struct fiemap_extent);
-- 
2.17.0
