Return-Path: <hdegoede@redhat.com>
X-Google-Smtp-Source: AIpwx4+JnZZHZWf0niXI7LVwFy5Me5GK9AqMPIg1LcNFEe2refA604hnYQZss4A8jZP5ATmsscP1
ARC-Seal: i=1; a=rsa-sha256; t=1523209239; cv=none;
        d=google.com; s=arc-20160816;
        b=btNKfc/BODgqMNnDuPZ5fgCFc8hpZ4jtquiZTf04SQz2LXMKiaHJ/h+uSzDRYfYNZi
         Dqwgmz22a2WaWhugM5LxT4L/WVcv65gdJnghadpki2t7DATP/zP+cJ/0lw8Z8Dy5vDSP
         u9EQjNsQL/Atvl+G4jMv07AxYX1ugWApZwkqMlx50vYxcjANJM9PTvafk7INKamezjn0
         2NYhHdXkUiNr8ZtppsoHXtsXlSB8/O22W40E/5a5XcGxKcThqqjwdjC9toxfxn1umOaH
         Fq04HnIl280hdzeUuGHTN1wnsyLfLWocCguwRM+ENhgE0u0IOi+eWsaASgkI7vYz+d/u
         6drg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=TNkGNBzecSHPR4+7tnPddEvJKxrapeQ3VAZbUqu0Dj8=;
        b=TNObh60kKOSUgYx0UFVnoYiSznwiKtqD8/XW0i9bxbqf+xJ997D/kvNVj664JEvV+F
         AKFi83meQB8I9HM7AbdO0u8X/XOBN918KXTyBriQ9bQuV7Na5Yj/v8ygoPIJnY9DOJnv
         8Fp4biJQ0bi2yBRYTan0mNyF60as7xxq8HGB46q0ckNQyHC3Uj/vitSaWA2UkVWlT2fp
         xEQVy6yzKNCyNLPYTKpOMMY/Kh+50srILjfhzhRRl/2i3OlZn2y9kuvGA/XFqoeY39Fv
         uprPuOogTN0F6N4S/76s65bQFHsf98lJEwCUdUbWYftPkLv7SMtrXZkhaYqaQRHS0UOd
         RuyA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of hdegoede@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=hdegoede@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of hdegoede@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=hdegoede@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
From: Hans de Goede <hdegoede@redhat.com>
To: Darren Hart <dvhart@infradead.org>,
	Andy Shevchenko <andy@infradead.org>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	"Luis R . Rodriguez" <mcgrof@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H . Peter Anvin" <hpa@zytor.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Peter Jones <pjones@redhat.com>,
	Dave Olsthoorn <dave@bewaar.me>,
	Will Deacon <will.deacon@arm.com>,
	Andy Lutomirski <luto@kernel.org>,
	Matt Fleming <matt@codeblueprint.co.uk>,
	David Howells <dhowells@redhat.com>,
	Mimi Zohar <zohar@linux.vnet.ibm.com>,
	Josh Triplett <josh@joshtriplett.org>,
	dmitry.torokhov@gmail.com,
	mfuzzey@parkeon.com,
	keescook@chromium.org,
	Kalle Valo <kvalo@codeaurora.org>,
	Arend Van Spriel <arend.vanspriel@broadcom.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	nbroeking@me.com,
	bjorn.andersson@linaro.org,
	Torsten Duwe <duwe@suse.de>,
	x86@kernel.org,
	linux-efi@vger.kernel.org
Subject: [PATCH v3 5/5] platform/x86: touchscreen_dmi: Add info for the Chuwi Vi8 Plus tablet
Date: Sun,  8 Apr 2018 19:40:14 +0200
Message-Id: <20180408174014.21908-6-hdegoede@redhat.com>
In-Reply-To: <20180408174014.21908-1-hdegoede@redhat.com>
References: <20180408174014.21908-1-hdegoede@redhat.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597199794097798684?=
X-GMAIL-MSGID: =?utf-8?q?1597200650520929198?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add touchscreen info for the Chuwi Vi8 Plus tablet. This tablet uses a
Chipone ICN8505 touchscreen controller, with the firmware used by the
touchscreen embedded in the EFI firmware.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/touchscreen_dmi.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x86/touchscreen_dmi.c
index 6488cd50ba79..5fdb6fe878f4 100644
--- a/drivers/platform/x86/touchscreen_dmi.c
+++ b/drivers/platform/x86/touchscreen_dmi.c
@@ -301,6 +301,22 @@ static const struct ts_dmi_data teclast_x3_plus_data = {
 	.properties	= teclast_x3_plus_props,
 };
 
+static const struct property_entry efi_embedded_fw_props[] = {
+	PROPERTY_ENTRY_BOOL("efi-embedded-firmware"),
+	{ }
+};
+
+static const struct ts_dmi_data chuwi_vi8_plus_data = {
+	.embedded_fw = {
+		.name	= "chipone/icn8505-HAMP0002.fw",
+		.prefix = { 0xb0, 0x07, 0x00, 0x00, 0xe4, 0x07, 0x00, 0x00 },
+		.length	= 35012,
+		.crc	= 0x74dfd3fc,
+	},
+	.acpi_name	= "CHPN0001:00",
+	.properties	= efi_embedded_fw_props,
+};
+
 const struct dmi_system_id touchscreen_dmi_table[] = {
 	{
 		/* CUBE iwork8 Air */
@@ -487,6 +503,15 @@ const struct dmi_system_id touchscreen_dmi_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Y8W81"),
 		},
 	},
+	{
+		/* Chuwi Vi8 Plus (CWI506) */
+		.driver_data = (void *)&chuwi_vi8_plus_data,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Hampoo"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "D2D3_Vi8A1"),
+			DMI_MATCH(DMI_BOARD_NAME, "Cherry Trail CR"),
+		},
+	},
 	{ },
 };
 
-- 
2.17.0
