Return-Path: <mcgrof@kernel.org>
X-Google-Smtp-Source: AB8JxZpoWdGBPvJWUgEuxzPMXtuNHn3ypvKkj9C4zBGcIE4sXaucNWB7MbAxsu/OSMxhrekmNplv
ARC-Seal: i=1; a=rsa-sha256; t=1525982955; cv=none;
        d=google.com; s=arc-20160816;
        b=MOHw+3DDNMYwnrWCeyphKWg0aQDbm3x++gLpX9w5pi5iGQDvYJCb7zc2pIF4GprlNC
         eVSIwbq6g0eMFt70VmVAU4VFZJXUe7GyWiE31CHLq3yQRRt2h2YOCGBv2fP0LKX7/Mzw
         imZrlnje9nx47FhAr+2x6ZIz6FmyqsQnt2+Yo06Ys+7hF66vdaJs33ZAgWKh4L+EJhI+
         CjaASbdmwWvI9bhnXzZhe8Iz24aILJvK4XiFbrtciLWf4bsUhMRUxlXqZIAmZtTh+VHd
         5/pgTc+x8Lb7CxNlJc/eIcDt6d0Y03NUWfsG3dvvN+rQaTdL8utL6DkK/5vYAAL6idYh
         tTTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=8jbAyWIOlRXGXzJ8IZ1FPR2qezUZbf8peOkbJNQBNJQ=;
        b=WOwMM9l5U4K68ysquoUsd/yeo5Nj7urB+h8ds+Y46Da12UJdc/l8d7TMOGPRbpwVbn
         MuaM/Y2GLbXDDCx9oGL68ZxyiJqtAzJwMDaWrAUdSApt677UND2Z3xGFAA5hABv1g8VU
         ajkK8RcZxTJX9Som57mgSabzAHulEu1l0Qv7NxLOgJZYrii+5Nh11rFWEz/1dLUMmixx
         y1vI0uiUlzmkmrPZpPiUAru/EWTc2t6x3mX0qZHg5YDrLDjKvHZVJBvo2S+EuzKPeSrj
         cFA8inVHACLymjscHI7MrV86SocKLIURZuntgs8VabZi0fSu77wVib/g95oMh7iJZc1k
         a5yA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=EdLNaJQ+;
       spf=pass (google.com: domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=EdLNaJQ+;
       spf=pass (google.com: domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org,
	keescook@chromium.org,
	josh@joshtriplett.org,
	maco@android.com,
	andy.gross@linaro.org,
	david.brown@linaro.org,
	bjorn.andersson@linaro.org,
	teg@jklm.no,
	wagi@monom.org,
	hdegoede@redhat.com,
	andresx7@gmail.com,
	zohar@linux.vnet.ibm.com,
	kubakici@wp.pl,
	shuah@kernel.org,
	mfuzzey@parkeon.com,
	dhowells@redhat.com,
	pali.rohar@gmail.com,
	tiwai@suse.de,
	kvalo@codeaurora.org,
	arend.vanspriel@broadcom.com,
	zajec5@gmail.com,
	nbroeking@me.com,
	markivx@codeaurora.org,
	broonie@kernel.org,
	dmitry.torokhov@gmail.com,
	dwmw2@infradead.org,
	torvalds@linux-foundation.org,
	Abhay_Salunke@dell.com,
	jewalt@lgsinnovations.com,
	oneukum@suse.com,
	cantabile.desu@gmail.com,
	khc@pm.waw.pl,
	arve@android.com,
	tkjos@android.com,
	corbet@lwn.net,
	mchehab+samsung@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH v7 14/14] Documentation: clarify firmware_class provenance and why we can't rename the module
Date: Thu, 10 May 2018 13:08:50 -0700
Message-Id: <20180510200850.5958-15-mcgrof@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180510200850.5958-1-mcgrof@kernel.org>
References: <20180510200850.5958-1-mcgrof@kernel.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600109103158788127?=
X-GMAIL-MSGID: =?utf-8?q?1600109103158788127?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Clarify the provenance of the firmware loader firmware_class module name
and why we cannot rename the module in the future.

Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 .../driver-api/firmware/fallback-mechanisms.rst          | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/driver-api/firmware/fallback-mechanisms.rst b/Documentation/driver-api/firmware/fallback-mechanisms.rst
index a39323ef7d29..d35fed65eae9 100644
--- a/Documentation/driver-api/firmware/fallback-mechanisms.rst
+++ b/Documentation/driver-api/firmware/fallback-mechanisms.rst
@@ -72,9 +72,12 @@ the firmware requested, and establishes it in the device hierarchy by
 associating the device used to make the request as the device's parent.
 The sysfs directory's file attributes are defined and controlled through
 the new device's class (firmware_class) and group (fw_dev_attr_groups).
-This is actually where the original firmware_class.c file name comes from,
-as originally the only firmware loading mechanism available was the
-mechanism we now use as a fallback mechanism.
+This is actually where the original firmware_class module name came from,
+given that originally the only firmware loading mechanism available was the
+mechanism we now use as a fallback mechanism, which registers a struct class
+firmware_class. Because the attributes exposed are part of the module name, the
+module name firmware_class cannot be renamed in the future, to ensure backward
+compatibility with old userspace.
 
 To load firmware using the sysfs interface we expose a loading indicator,
 and a file upload firmware into:
-- 
2.17.0
