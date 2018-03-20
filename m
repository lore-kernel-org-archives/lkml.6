Return-Path: <hariprasath.elango@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521531973; cv=none;
        d=google.com; s=arc-20160816;
        b=B3grzXjBi3qJ7LuyCqCgbtFpaY6jhFZSbwKng+HxFXvy+JlWHkIdkjhgXui2/dryLh
         p5i2y0fUB05hhShPezwBDiOS8zuWOGEA4l42Zhxb7YYDFn73wLyv5sj3Q5GQ5DF3yWb+
         7zTz6UDVSKq5vpm03RwX/7ClcfwjAGpVGW6ShxVT0EMzqf2mXJ9oVJd8Wi4mLoDnLxpg
         uGKb2t7uNHDvmZn/b4klJ40owPSg3ANsDZWUMIlb4RDDLxBAcDXF8jqI84g4Z8GmbYCP
         yIS9E+qDSqZoD8ZM+dFzfWiHf5OvKSS98A6r1RH4Sa308xh1WitOHtL6HDBieAymHKc2
         junA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=/2CuedqQmtnHoMwZLHSqTstB5C02wPBQqkGXN1mpc3s=;
        b=nGjM4iSO6J9TCZ3VRvTulUta6Fjp94KXiIfUhjGtZfqfS6mFHgTh8GL3+jTXpt4iHX
         y1N7Z7eOyLSx6LRKZsBg8EQk6Jw6+pZnZDrsFo4NSk6q0umcvO7847otc+jAIYl1QoQA
         DqrkAeJM8fWGa8wvDe3f+V299zuKzylJho36Q0uj5RAlW1yZcMoV+ZLM8EqducTOg+WM
         DzdAGGRNAuWX4AnKAwT4oEUdHgKYS15gkw0TeTqB/YCZ9DrpFzwee4YgWZgL9A6q9XR7
         H29txn2I83nuP50bQySa0uMv1juB8LzXxwdm5U5b0iari20v86sxLgLXaigBaeQivB6K
         AKRA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=FJUbnMYZ;
       spf=pass (google.com: domain of hariprasath.elango@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=hariprasath.elango@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=FJUbnMYZ;
       spf=pass (google.com: domain of hariprasath.elango@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=hariprasath.elango@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELv/3zzHqhA8xioAwQbJI5oMXGM7BBfBBVolJELQ8YCnPDFpMlFBep6FGFP4lpJx2PgEZwPC2A==
From: hariprasath.elango@gmail.com
To: blogic@openwrt.org,
	gregkh@linuxfoundation.org
Cc: gehariprasath@gmail.com,
	HariPrasath Elango <hariprasath.elango@gmail.com>,
	NeilBrown <neil@brown.name>,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: mt7621-gpio: remove redundant owner assignments of drivers
Date: Tue, 20 Mar 2018 13:15:54 +0530
Message-Id: <20180320074558.7851-1-hariprasath.elango@gmail.com>
X-Mailer: git-send-email 2.10.0.GIT
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595441910626833274?=
X-GMAIL-MSGID: =?utf-8?q?1595441910626833274?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: HariPrasath Elango <hariprasath.elango@gmail.com>

Remove the reduntant owner initialization from this platform driver as
the platform_driver_register() takes care of it.

Signed-off-by: HariPrasath Elango <hariprasath.elango@gmail.com>
Reviewed-by: NeilBrown <neil@brown.name>
---
 drivers/staging/mt7621-gpio/gpio-mt7621.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/mt7621-gpio/gpio-mt7621.c b/drivers/staging/mt7621-gpio/gpio-mt7621.c
index 5c57abe..830d429 100644
--- a/drivers/staging/mt7621-gpio/gpio-mt7621.c
+++ b/drivers/staging/mt7621-gpio/gpio-mt7621.c
@@ -339,7 +339,6 @@ static struct platform_driver mediatek_gpio_driver = {
 	.probe = mediatek_gpio_probe,
 	.driver = {
 		.name = "mt7621_gpio",
-		.owner = THIS_MODULE,
 		.of_match_table = mediatek_gpio_match,
 	},
 };
-- 
2.10.0.GIT
