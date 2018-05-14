Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoxUz3kv7HH54nwXdbRLN2KoCRvdHvJoWPBfMweOlQRXTQcj6sB3ghlCzXCgoSSeQEBhZvO
ARC-Seal: i=1; a=rsa-sha256; t=1526280682; cv=none;
        d=google.com; s=arc-20160816;
        b=wuxXEN39AVjVOauSX+TIA3wQZ6SfCbx028uFLluFqFk+XHMplPmm2txWqODJ722gvH
         jU8IZGBXuPQakOqBOdOQlzMWVTEMGuwnGKoFscRaKO70A1Vw106k/kW05byfX2peEOSj
         1IpiUIKjLHCuv/vNMYJPuHLFh6DgvmpKhUSgkZrKIOeFr86ImPWNeZUfAValgiHdLh5Z
         vb2b/pAMy9Cnx7G8C5WmITxE62gIkaejFVzT1Miox4dU5bSvaBx82XrOnc5rePOOTU+G
         Ha3f440rJfUPQDqS8eudE2Xk+1GAqBx4jalZ2LeDMFxLISG2ZTWRj6DWbiyMu0MeUt/0
         USBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=cveebnP9pGs31nlxBWd9D7X/v+l5YOlrWbp4HvWmPzw=;
        b=Oh9YqZe6TL98HZQfMEPnrNf3V6PZ4AjLGiiz1nMhGM8iG+WHHTDeVBMw0bdmx+yu5i
         ky1pdQ+isgeuoRlImrH7sSvnZJpUDidQCGE+Je2PGI/Z4sUxzLF6Fpkpdn8FuhwRnwVX
         u9tWG7Tx0Feep+48QrRlz+vpsCSSCczxzedKBXAC5uGPKgX6zGlPRavrviYo8iEAX8ee
         RHzvaWXLGDh2/4ljTzqC4yyBhzCuGwsAE5dCAGGtnu4IP0vE33M5eepD4ZwmAcUhhAZn
         8vhx/24sN5qXkNQU8XB/VbcmSjtlN5OKvgVrcmCf+Tky0RRJdafecJkiXOdoK+gfXvoN
         VodQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=fe49x4pa;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=fe49x4pa;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Vittorio Gambaletta <linuxbugs@vittgam.net>,
	Salvatore Bellizzi <lkml@seppia.net>,
	Guenter Roeck <groeck@chromium.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.4 18/56] Input: atmel_mxt_ts - add touchpad button mapping for Samsung Chromebook Pro
Date: Mon, 14 May 2018 08:48:23 +0200
Message-Id: <20180514064756.737313511@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064754.853201981@linuxfoundation.org>
References: <20180514064754.853201981@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421292629183297?=
X-GMAIL-MSGID: =?utf-8?q?1600421292629183297?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2523,6 +2523,15 @@ static const struct dmi_system_id mxt_dm
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
