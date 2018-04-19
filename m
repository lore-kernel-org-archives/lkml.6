Return-Path: <baolin.wang@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1524122511; cv=none;
        d=google.com; s=arc-20160816;
        b=Ya4jo/qP9XYHohV1LVAPLrameV+9/oXOHCa4rFkttjF9K4PvSYymjNAy0G6DuV9OHt
         eaLQCcG+SQT4gud+ZPyWMxA7t3qATvaCVrmI/lQXGlVDHCptUZGK7RBgLnXdHgI/+5pb
         +a0TgVseIfk8TbKxIFCXwkVxrHd7BJ162Rn/xG18GuxRKBwyZPnauzrdB617lqEUy8Lp
         eNeprdZo7cSjPfIbl3ugTtTTtT77zLguZ2JjscA9LzPSPwzOHsDz5IIwMNd0Jt8AUUyt
         OyAQEfS2V4v9RWWv5xUgLjTGspv72Gh0F4egHg7+ROONeF0MI+YAzY24gwbqeqKpkdff
         eIcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=7r+KtxN1R28gezIYKxrrUmkWNugOgbH+sxaaoijsp4Q=;
        b=gBynj1cdceVDI7kjRu6QPSZB/rZRKTUKTGdrCh3MdIU+nee3GsTvmITGO2entOTXDO
         V3wYZcuXKzlBmx5TopTAo7ujp8e/6tGfzlJ/E5LrI/mFBPaMAS3uvksIss98pkGHY2yD
         tNmDlLShgF4QrXqeCAAMdHf6+n4dOsKSoGYZXgNFw5XE/1VSGl/mhgKl+fdA8OTppvb2
         4ooB0m0iAim+Th5Ipvt7k1SpTCL+ELEaTR0sIKdffLjXcK4S0eza5RIE8fFMbAUq8CCR
         OfUZbjsh86ovJ3fiWwjCTMuk/aQD+WDAorKOdbSqrnF1ue92M1aRi5lItZRTjzjRXnCq
         K2/w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=W9NdpcJf;
       spf=pass (google.com: domain of baolin.wang@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=baolin.wang@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=W9NdpcJf;
       spf=pass (google.com: domain of baolin.wang@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=baolin.wang@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AIpwx49OMwymCF76D8asjRdAokaBddwR/v/tJME9fuLcEe6q6CbOJde/yvGzPT7klWn6mO8Uljsivw==
From: Baolin Wang <baolin.wang@linaro.org>
To: ralf@linux-mips.org,
	jhogan@kernel.org
Cc: kstewart@linuxfoundation.org,
	gregkh@linuxfoundation.org,
	tglx@linutronix.de,
	pombredanne@nexb.com,
	arnd@arndb.de,
	broonie@kernel.org,
	linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org,
	baolin.wang@linaro.org
Subject: [PATCH] MIPS: sni: Remove the read_persistent_clock()
Date: Thu, 19 Apr 2018 15:21:06 +0800
Message-Id: <0b52cfd4def5dd0287a1fd48c632a32e7cc3117b.1524122311.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598158286152327391?=
X-GMAIL-MSGID: =?utf-8?q?1598158286152327391?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The dummy read_persistent_clock() uses a timespec, which is not year 2038
safe on 32bit systems. Thus remove this obsolete interface.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 arch/mips/sni/time.c |    6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/mips/sni/time.c b/arch/mips/sni/time.c
index 0eb7d1e..dbace1f 100644
--- a/arch/mips/sni/time.c
+++ b/arch/mips/sni/time.c
@@ -171,9 +171,3 @@ void __init plat_time_init(void)
 	}
 	setup_pit_timer();
 }
-
-void read_persistent_clock(struct timespec *ts)
-{
-	ts->tv_sec = -1;
-	ts->tv_nsec = 0;
-}
-- 
1.7.9.5
