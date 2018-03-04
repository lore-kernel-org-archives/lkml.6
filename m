Return-Path: <masneyb@onstation.org>
X-Google-Smtp-Source: AG47ELsbGSSMCXBJAI+TGUNeFNKF5rT/IlvF0XU/Y05SXqQyrWwVWnFMrW8Q27ccDFlOgCM+qpNA
ARC-Seal: i=1; a=rsa-sha256; t=1520128193; cv=none;
        d=google.com; s=arc-20160816;
        b=gKuyaWpQEDsqx/owvDi0Lb9Y7wJXyaJHYqTSz7p6Ms80jMeMLZLBGnA7UxIM+ra4KW
         NlE8F2puZFvVT+wIbQuX4vNjrhJSBiCcROsTYwVgCmoPjdhL1K1F/7BSQFXe1jx46yCs
         fNt3l1yXat3+qk6hamVSnQa9bI+JCiFO1ZiVse+HzMWHQGMfV3u+Xx5Uu8O9Hraryg9N
         Dz4gX755+swvWTp1pdVK/bw/PIuH9Rr00ImIGfmrTuqG+KZ7CL5LWNvZVMqHa/ehgpr/
         ndikp35nG2Y+ktxYy5yKaMMvOXgqQ1MfuGbnyHKsrk7MTsc0OqWS0PGPLwNvcq5ohHqW
         mwkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=1EF14hVXkEDjZjvN7Wu58zAUkjQ3riIiQ53B5zIypA8=;
        b=VUcqQ4Q/gtROsOAqEXzpd2RWqdR5EOrXbIyzuC8bi4S5G052q67Qbr7aKmbWPEBCKF
         18wihoLjf6gvKoj9zTpIV0tY6oiiIj92zagKqqvB27x5dYDMLAo7n5HdzYz25vLgPAly
         vdl5+htHRMHHpgWRnAombdJaPr1fAthR4XIyF2ZIlyNprJ5UOmDkeEEve0nhohWqxJZQ
         4sZCpcQx0J42b40XDFjUM6jZRjfeldh9+vFLLVmGIp5/K8pina9FFkwGdTej9qpZANhP
         kjGr62383U6rtPEBxSd0uhF2iMHp0rcWvKFs5NqQ4gO4eim7Kl70DoSWafwgdyMMK9cS
         VXCw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@onstation.org header.s=default header.b=Hn9z1E+Q;
       spf=pass (google.com: best guess record for domain of masneyb@onstation.org designates 52.200.56.107 as permitted sender) smtp.mailfrom=masneyb@onstation.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@onstation.org header.s=default header.b=Hn9z1E+Q;
       spf=pass (google.com: best guess record for domain of masneyb@onstation.org designates 52.200.56.107 as permitted sender) smtp.mailfrom=masneyb@onstation.org
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	devel@driverdev.osuosl.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	linux-kernel@vger.kernel.org,
	Jon.Brenner@ams.com
Subject: [PATCH 07/12] staging: iio: tsl2x7x: correct 'Avoid CamelCase' warning from checkpatch
Date: Sat,  3 Mar 2018 20:49:37 -0500
Message-Id: <20180304014942.18727-8-masneyb@onstation.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180304014942.18727-1-masneyb@onstation.org>
References: <20180304014942.18727-1-masneyb@onstation.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593969940753161907?=
X-GMAIL-MSGID: =?utf-8?q?1593969940753161907?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The statP and calP variables triggered an 'Avoid CamelCase' warning
from checkpatch.pl. This patch renames these variables to stat and cal
to fix this warning.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2x7x.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
index cc209b64ed5a..380a6c96a69a 100644
--- a/drivers/staging/iio/light/tsl2x7x.c
+++ b/drivers/staging/iio/light/tsl2x7x.c
@@ -773,7 +773,7 @@ static int tsl2x7x_invoke_change(struct iio_dev *indio_dev)
 }
 
 static void tsl2x7x_prox_calculate(int *data, int length,
-				   struct tsl2x7x_prox_stat *statP)
+				   struct tsl2x7x_prox_stat *stat)
 {
 	int i;
 	int sample_sum;
@@ -783,21 +783,21 @@ static void tsl2x7x_prox_calculate(int *data, int length,
 		length = 1;
 
 	sample_sum = 0;
-	statP->min = INT_MAX;
-	statP->max = INT_MIN;
+	stat->min = INT_MAX;
+	stat->max = INT_MIN;
 	for (i = 0; i < length; i++) {
 		sample_sum += data[i];
-		statP->min = min(statP->min, data[i]);
-		statP->max = max(statP->max, data[i]);
+		stat->min = min(stat->min, data[i]);
+		stat->max = max(stat->max, data[i]);
 	}
 
-	statP->mean = sample_sum / length;
+	stat->mean = sample_sum / length;
 	sample_sum = 0;
 	for (i = 0; i < length; i++) {
-		tmp = data[i] - statP->mean;
+		tmp = data[i] - stat->mean;
 		sample_sum += tmp * tmp;
 	}
-	statP->stddev = int_sqrt((long)sample_sum / length);
+	stat->stddev = int_sqrt((long)sample_sum / length);
 }
 
 /**
@@ -812,7 +812,7 @@ static void tsl2x7x_prox_cal(struct iio_dev *indio_dev)
 	int prox_history[MAX_SAMPLES_CAL + 1];
 	int i;
 	struct tsl2x7x_prox_stat prox_stat_data[2];
-	struct tsl2x7x_prox_stat *calP;
+	struct tsl2x7x_prox_stat *cal;
 	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
 	u8 tmp_irq_settings;
 	u8 current_state = chip->tsl2x7x_chip_status;
@@ -844,13 +844,13 @@ static void tsl2x7x_prox_cal(struct iio_dev *indio_dev)
 	}
 
 	tsl2x7x_chip_off(indio_dev);
-	calP = &prox_stat_data[PROX_STAT_CAL];
+	cal = &prox_stat_data[PROX_STAT_CAL];
 	tsl2x7x_prox_calculate(prox_history,
-			       chip->settings.prox_max_samples_cal, calP);
-	chip->settings.prox_thres_high = (calP->max << 1) - calP->mean;
+			       chip->settings.prox_max_samples_cal, cal);
+	chip->settings.prox_thres_high = (cal->max << 1) - cal->mean;
 
 	dev_info(&chip->client->dev, " cal min=%d mean=%d max=%d\n",
-		 calP->min, calP->mean, calP->max);
+		 cal->min, cal->mean, cal->max);
 	dev_info(&chip->client->dev,
 		 "%s proximity threshold set to %d\n",
 		 chip->client->name, chip->settings.prox_thres_high);
-- 
2.14.3
