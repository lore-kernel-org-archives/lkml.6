Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZriyqFYtrdskSwuojvS7MJ+mO18chA+lcMI+OyuwFezwkG1ljnfhoBbbEwQEiZlFaIg5O3q
ARC-Seal: i=1; a=rsa-sha256; t=1525767110; cv=none;
        d=google.com; s=arc-20160816;
        b=Or1B8R+7OxvLnD79ynk1sXIWcxwGRQU3LQpSjPRXe44FhUwW6jJVAF/85WzgRO8mPM
         QH33wlV54IdOHkjLXXDbjMusrLJtP9VJ1geYpS+ZiFlxszgCd4szp8FlvHQDXDAsJyxE
         7+p+DtGSlU7TtriRD/DVVwUOyvV/LYRslxPHs13rANkCkt24dAnDfkk5QVTIIomBj8n+
         gem6MbIvFXJIQYz5QD0p29+kOlP1UnBINBiqst5Cq7aClXzMkweJwc1E9l+R9Y+uDK/N
         0nnfF+RLofgg8XMVUqjN737sicvycW1pscdVTdwVH/e++nT0KnDf9ETLNmE21kyj4lpq
         hbjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=6w4w1q7XIMc1b+sZNRpnShuUfFKrGmMsZuE7Os01V2g=;
        b=jcPJPtHZcfa2uX37qClICTvr69i6jg1a3FADuoCzhuft4ycwMgZPz+OZ6wnlzy/Hza
         z5hHqxX3UXUwYnoTkGj+GxuRG82KsCB2TQ15k7o3U61OXIURFUW7jP1zNvx/56DvZZpX
         pqgHi5kW+cI8fb11tipRr/ncCBMqnlJ2b7XYnnaevxpAw1BvrYFtBaKkzAxDZwJcv3QI
         5Q2ShAzlscY37vBo0rVMIX4NIPTHE7qXuUryq7Rn59Q8esGtHoR8ziELngjVt9zXptNV
         Hkj1fC3PXYWBGx0VEiUeOnEX//vyOckndGT5saWGKImLqBXb847EA2xdIMFEJzzR629f
         d9+w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=scd4naVY;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=scd4naVY;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Vittorio Gambaletta <linuxbugs@vittgam.net>,
	Salvatore Bellizzi <lkml@seppia.net>,
	Guenter Roeck <groeck@chromium.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.16 13/52] Input: atmel_mxt_ts - add touchpad button mapping for Samsung Chromebook Pro
Date: Tue,  8 May 2018 10:10:11 +0200
Message-Id: <20180508073929.795192227@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508073928.058320984@linuxfoundation.org>
References: <20180508073928.058320984@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599882773685082917?=
X-GMAIL-MSGID: =?utf-8?q?1599882773685082917?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
