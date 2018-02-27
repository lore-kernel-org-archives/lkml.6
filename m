Return-Path: <keescook@chromium.org>
ARC-Seal: i=1; a=rsa-sha256; t=1519689869; cv=none;
        d=google.com; s=arc-20160816;
        b=uu4uEE+zOyjqkWKXsR4xxBlscGQS2Sw/4+OHTZx59mPQhYnN8qEwo+oGbORnSdHQEO
         M8zM5RT0rfU4ar7KKaqsLFj+PU6XcepzCDNpilYfaTOS48cop7swEWOJ5VR3nOi9UffS
         uAKGv8pkxji4H0rAkEFDxczkuAMY2XoATKMh3v35TZEUNbvKjzPcHttgyNx/H4en3uZQ
         BBz3+ngetnl9aud6cKSnV5h71WnGcLIsRIJTZZl+GHZ0eAPonkr76VCn1n4ef6xqija9
         ZT+wIeqIErKnORZ5KpGUuPom125r6wc1jIhGy4cBWIjsbxpdq1uWYl1vtRgfF2ZGE03w
         cjWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=YkbTZUnKK79uTL4ubxkilDrq9E2x+xrlbCGIag8e3uc=;
        b=0k8IjTfvnK5wnPPDelOw0YYijtvF8aNE/8s4VQ5cR7ZjzxphQZId/B8DG7wz27+p1c
         4uF+6YDNDySX1NxAQjIgxzOly9kclAPpsAFNX4XC/qfLBZZaU401MQqJevYX32gPCyDQ
         n3TfvAJEXkmLK7ehvZCaxfZMP4g0ck8PYqmCXL8+yrSWW4BEGKXSLchKjt3Dgcnih2U2
         1KYycdhWmM/55mvtrkOyaJWA0E5ZzhLYdaH5yFFFXu1n7fgyKHqpc7DxACSfNrzQ5xxO
         VJa/jTDEHwk190NhUD5jmkUw6Z+m7X1Bscr6WWOLYqjqDeu0JR0DHfLDzGlb4DBBR0/y
         M9EQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=dilLDk/1;
       spf=pass (google.com: domain of keescook@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=dilLDk/1;
       spf=pass (google.com: domain of keescook@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AH8x225DZnPH69ivn88Z8Ty50ojAgav9QLgiG8dhNxhQ5R3D8Q90QMy7+8hpm/0xFfrq1YNXDAs8sg==
From: Kees Cook <keescook@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kees Cook <keescook@chromium.org>,
	Thomas Winischhofer <thomas@winischhofer.net>,
	Sami Tolvanen <samitolvanen@google.com>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Nicolas Pitre <nicolas.pitre@linaro.org>,
	linux-usb@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] console: SisUSB2VGA: Drop dummy con_font_get()
Date: Mon, 26 Feb 2018 16:04:18 -0800
Message-Id: <1519689860-7421-2-git-send-email-keescook@chromium.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519689860-7421-1-git-send-email-keescook@chromium.org>
References: <1519689860-7421-1-git-send-email-keescook@chromium.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593510324872113157?=
X-GMAIL-MSGID: =?utf-8?q?1593510324872113157?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

As done in commit:

  724ba8b30b04 ("console/dummy: leave .con_font_get set to NULL")

This drops the dummy .con_font_get(), as it could leave arguments
uninitialized.

Cc: Thomas Winischhofer <thomas@winischhofer.net>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/usb/misc/sisusbvga/sisusb_con.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/misc/sisusbvga/sisusb_con.c b/drivers/usb/misc/sisusbvga/sisusb_con.c
index 73f7bde78e11..998df891bdde 100644
--- a/drivers/usb/misc/sisusbvga/sisusb_con.c
+++ b/drivers/usb/misc/sisusbvga/sisusb_con.c
@@ -1358,7 +1358,6 @@ static const struct consw sisusb_dummy_con = {
 	.con_switch =		SISUSBCONDUMMY,
 	.con_blank =		SISUSBCONDUMMY,
 	.con_font_set =		SISUSBCONDUMMY,
-	.con_font_get =		SISUSBCONDUMMY,
 	.con_font_default =	SISUSBCONDUMMY,
 	.con_font_copy =	SISUSBCONDUMMY,
 };
-- 
2.7.4
