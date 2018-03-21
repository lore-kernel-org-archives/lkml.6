Return-Path: <mcgrof@kernel.org>
X-Google-Smtp-Source: AG47ELsh1pCsPtfdsz8HTgxQEzRJJOz4+yUj8WQ5W87fkb3mzXnhdmLwnKoG3obzraAUt2EorP8N
ARC-Seal: i=1; a=rsa-sha256; t=1521671675; cv=none;
        d=google.com; s=arc-20160816;
        b=Ns2W9osMhoVzPcIxI7UXF6CrsF6ewkEjAxtWVPRJpk+UWf/FGnyKFSucO3QSZBkrCj
         lrbM6lCSdyd4t4o9sTm5zyQma/p8YA+7G/FdtRtDwKWbnxO8epTtpOpSnFmF4OUNbTF7
         jT5A/JcuFkYlIULIWjXosyeofXi8OXvHlfCBnByQuYv50H7kk9vL6NBlzAFBJXf9Qfzs
         SbhiD/1f6G21C25NLQGQom25XvTTsAk9gVVZaWMlOYrfK1VIWJZ3CuDN9fQC4qxvxJXS
         SDX40RLCvaaMahVEtyKkvYSxEqi2+sikq3wAjAbyVvCKY56m/0oh+ngIk6lujLCD4tVY
         f5fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:arc-authentication-results;
        bh=6tXFlt7KwihYFLdkPdoEucMH9eAlY9FIIz7YgE9OkFM=;
        b=hgktaLZmToIViWoeKMQOD+ZRzNQh9Cubodc7jM0haI0j9MtnBKsWnT6LTo6dH7Qwch
         MNipn2CQDKVoHsGwRdvuC/1XWuxlZ2getPr3czAQQpre9fOR8UBDaZ79ee9XpYpnqiJA
         fMA6bKQHTdoSuAnPwAvtfEg3QsBScSZficmp1MeJuIwrFedI2ACSjcZtAPtL30CXtr3y
         LBiYGR9Rw2Uq5bxevTOj9q9BnGJT8Z7bDwYACDa/m/WIhxxkhCMyHkyISHB3W79/iFOu
         mAfCFNQEF9MJ3m8tErp9EluPc9jM6HDpmlB0tAlvV0eUVJdypqNKru66qPgNZmOCvUiD
         HV/A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE7D521835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mcgrof@kernel.org
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org,
	cantabile.desu@gmail.com,
	kubakici@wp.pl,
	linux-wireless@vger.kernel.org,
	keescook@chromium.org,
	shuah@kernel.org,
	mfuzzey@parkeon.com,
	zohar@linux.vnet.ibm.com,
	dhowells@redhat.com,
	pali.rohar@gmail.com,
	tiwai@suse.de,
	arend.vanspriel@broadcom.com,
	zajec5@gmail.com,
	nbroeking@me.com,
	markivx@codeaurora.org,
	broonie@kernel.org,
	dmitry.torokhov@gmail.com,
	dwmw2@infradead.org,
	torvalds@linux-foundation.org,
	Abhay_Salunke@dell.com,
	bjorn.andersson@linaro.org,
	jewalt@lgsinnovations.com,
	oneukum@suse.com,
	ast@fb.com,
	andresx7@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH v4 1/3] firmware: fix typo on pr_info_once() when ignore_sysfs_fallback is used
Date: Wed, 21 Mar 2018 15:34:28 -0700
Message-Id: <20180321223430.21388-2-mcgrof@kernel.org>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20180321223430.21388-1-mcgrof@kernel.org>
References: <20180321223430.21388-1-mcgrof@kernel.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595588398406307739?=
X-GMAIL-MSGID: =?utf-8?q?1595588398406307739?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

When the sysctl knob is used ignore the fallback mechanism we pr_info_once()
to ensure its noted the knob was used. The print incorrectly states its a
debugfs knob, its a sysctl knob, so correct this typo.

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 drivers/base/firmware_loader/fallback.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
index d231bbcb95d7..31b5015b59fe 100644
--- a/drivers/base/firmware_loader/fallback.c
+++ b/drivers/base/firmware_loader/fallback.c
@@ -652,7 +652,7 @@ static bool fw_force_sysfs_fallback(unsigned int opt_flags)
 static bool fw_run_sysfs_fallback(unsigned int opt_flags)
 {
 	if (fw_fallback_config.ignore_sysfs_fallback) {
-		pr_info_once("Ignoring firmware sysfs fallback due to debugfs knob\n");
+		pr_info_once("Ignoring firmware sysfs fallback due to sysctl knob\n");
 		return false;
 	}
 
-- 
2.16.2
