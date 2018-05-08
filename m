Return-Path: <mcgrof@kernel.org>
X-Google-Smtp-Source: AB8JxZrQzEJokKv1GdLljo8CN7Q30I5FcNFGCdfd7SqXJW/xkR1bQIDTNPgDJwicS54WaHK0MotH
ARC-Seal: i=1; a=rsa-sha256; t=1525803192; cv=none;
        d=google.com; s=arc-20160816;
        b=SYfaktcW6RwXUGYGIoUJKrS3NuSwUiOiTIzUV+TYy1nKtLO3HIrjwtF8KlQw9Bi4cn
         IfW/+jFqwRy893jhAipqd1hQkcDURtL169eBk0YCnBpkBtJrTzNoXVgUIy7rtT/GdTBo
         Om67jeS2o51XBbMck2AZ3FhBsotjRl4z0Mt6xGHGHS4Rrx0VJghmRn+Kx7pdGi4LORZb
         XdqqxugC/N8JvtoN8JSUi+xsTJn2ZfH3ZoplsA1LbSJhZlULP2LlsqqfHBBwfO3WAzBT
         36V7WDeMXWz0Sj6ixS/zGeM8FGAAsvymfO/PTN4gpjespp8HpKYvOJniIQ0uWVX9z79K
         PQXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=GjIFnNJrzX4gy6IfvXuffxkWPt88/LNyc9+qTJk+b08=;
        b=WZhE7cbuIuS5Sh4vMZMpsGyguqT+BOpWWQIX2ccIlFiYBP+cMQgOphYawwtLClGwQQ
         zC/87S3kFMavPWXVqUku0mSw2coYu+TLU7LdqzjLMXiDHkChpo4DJORWpd/AkHbCD0ew
         kgsSnS2ntigVODx53fAZdVA0ZYnOh8zLMeuVaXB93fGd3vzZO51OzKg3mupsPrP8XElm
         LhtIvcB2lFdkr0I13fKSe3Bn/+eufKCf4vVkEjOdbaBu70MkpWlrNY8WYyW3ei0SSZRJ
         5pEVs6Gtt0rc16CPcJRx5VvY4EVhwx+E2N/AL1fEdp39WDzqr97kvXgzPIo1jPDLEGAA
         3AQA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=cLJck5I0;
       spf=pass (google.com: domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=cLJck5I0;
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
	ast@fb.com,
	hare@suse.com,
	jejb@linux.vnet.ibm.com,
	martin.petersen@oracle.com,
	khc@pm.waw.pl,
	davem@davemloft.net,
	arve@android.com,
	tkjos@android.com,
	corbet@lwn.net,
	mchehab+samsung@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH v6 13/13] Documentation: clarify firmware_class provenance and why we can't rename the module
Date: Tue,  8 May 2018 11:12:47 -0700
Message-Id: <20180508181247.19431-14-mcgrof@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508181247.19431-1-mcgrof@kernel.org>
References: <20180508181247.19431-1-mcgrof@kernel.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599920608674205681?=
X-GMAIL-MSGID: =?utf-8?q?1599920608674205681?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Clarify the provenance of the firmware loader firmware_class module name
and why we cannot rename the module in the future.

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 .../driver-api/firmware/fallback-mechanisms.rst          | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/driver-api/firmware/fallback-mechanisms.rst b/Documentation/driver-api/firmware/fallback-mechanisms.rst
index a39323ef7d29..a8047be4a96e 100644
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
+mechanism we now use as a fallback mechanism, which which registers a
+struct class firmware_class. Because the attributes exposed are part of the
+module name, the module name firmware_class cannot be renamed in the future, to
+ensure backward compatibilty with old userspace.
 
 To load firmware using the sysfs interface we expose a loading indicator,
 and a file upload firmware into:
-- 
2.17.0
