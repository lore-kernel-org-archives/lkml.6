Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrGlYQJK5UXxfduhv62EWyAX3fGFeRhoCF7itAsSEk0RmcRi4p1E6MWBrR1E0bksSq1N/+l
ARC-Seal: i=1; a=rsa-sha256; t=1525767327; cv=none;
        d=google.com; s=arc-20160816;
        b=UC4/a+aoZyTjpQwLqdXwp6+rSeUHsgrVYbSnx2iVsGedi4sroSO4OxWrlqQ5aAfgqv
         R9LXXy9wIGc6EzkiI8wnq/xfD1el1C8n81TNyuPiLDZeS3XlFscGZkZaSpcpsGtsmLvk
         iaO/O/jwCP/4LFbOb8gB1EYGTF3RsZ6bqnaKdjgnaDuBfDhfOIM20cj1O9lrUgZuULgU
         B1e9bBmvv1jzQNUHslJXSbQFpYh1GFu3/08n1HVyQ9nxqRtYfnjQYhvOvJZwQvDiXO14
         USn8MwiTMOU1+WszggREzKBabkxib3hM3sDeHQz2ognOC95j8Aras5bUOn96MjTCcv5T
         tNnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=AsjLbaLi5tKn1lopw0DWh608IpdHBBIuNoHAhSjoj3E=;
        b=yxBD4GDOtFYuHZFUnM2atLW0q+AuQ9rxafVsE/LlbrDwpna4M/c2ymwIZlXkT/6KC3
         pjJfPIB+SBKkC3AFcRBYak8ml5ePsx785Rz0/p1qIdQdLRj3FzklJD1D2FHRvMoz8d6s
         M8floJbLtMgPvlBxYbLRlg1lAWMyqp65N1Kf27kLnsz+DyXSmNoDjhqwW87gJlkyjjYy
         t/PvTv5zJPXFlRQaw0obXj3fKuH1Oqg8kiQ7+fIfGV88GPr8F+IQQPhk2JpPtZaa4hS1
         tP0OHx2vlp+yTXGzFRStLKmKxAlZGtuYbPsoBixDs8M5JqvVVUjSitlLxHFIpOMhi4+J
         JPrQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=1aHaYDy1;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=1aHaYDy1;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Vittorio Gambaletta <linuxbugs@vittgam.net>,
	Salvatore Bellizzi <lkml@seppia.net>,
	Guenter Roeck <groeck@chromium.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.14 16/43] Input: atmel_mxt_ts - add touchpad button mapping for Samsung Chromebook Pro
Date: Tue,  8 May 2018 10:10:35 +0200
Message-Id: <20180508074006.666745209@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508074003.984433784@linuxfoundation.org>
References: <20180508074003.984433784@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599882773685082917?=
X-GMAIL-MSGID: =?utf-8?q?1599883001572961360?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vittorio Gambaletta (VittGam) <linuxbugs@vittgam.net>

commit f372b81101e6895252298e563d634d5e44ae81e7 upstream.

This patch adds the correct platform data information for the Caroline
Chromebook, so that the mouse button does not get stuck in pressed state
after the first click.

The Samus button keymap and platform data definition are the correct
ones for Caroline, so they have been reused here.

Signed-off-by: Vittorio Gambaletta <linuxbugs@vittgam.net>
Signed-off-by: Salvatore Bellizzi <lkml@seppia.net>
Tested-by: Guenter Roeck <groeck@chromium.org>
Cc: stable@vger.kernel.org
[dtor: adjusted vendor spelling to match shipping firmware]
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/touchscreen/atmel_mxt_ts.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -3031,6 +3031,15 @@ static const struct dmi_system_id mxt_dm
 		.driver_data = samus_platform_data,
 	},
 	{
+		/* Samsung Chromebook Pro */
+		.ident = "Samsung Chromebook Pro",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Google"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Caroline"),
+		},
+		.driver_data = samus_platform_data,
+	},
+	{
 		/* Other Google Chromebooks */
 		.ident = "Chromebook",
 		.matches = {
