Return-Path: <hdegoede@redhat.com>
X-Google-Smtp-Source: AB8JxZqwr/bwIZNDzXRUUg6IfPoAgPivvFsMBoLQchyamGwsYGFDfIWHHqkdprPLP0Vzjw0Toe78
ARC-Seal: i=1; a=rsa-sha256; t=1524994581; cv=none;
        d=google.com; s=arc-20160816;
        b=r0myA68pV2quBfuanhmPhrrUAWRtAaJfhcAPtGRKYFt7YOQJJ5tSwrCXGvQ/DDt8t3
         noepOGihmYRJqWqPdze/dKKAt75Cz6Up5bPpl+g/F7fZmAiJvKBCX0AKxtWGzvnDbsF/
         31BzOS+2Go2x9SJrOhj5tuX7Jf4zE3Go8L1TQD7z+lvs43jaeooV8TZeHAxLO1ha9qka
         ykjEibQYDjaStIIklzPufXKA9+tPmF41cDNtyQm2F86Uzhg7d5C7NPn28jnzHOqTmZd7
         TA4EJhG/RsvQG7DQrgkdNTghRcrwSXACGFT/MHwkPTYE60nbITZmcmTPmhkGpjal3wKA
         RMug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=tX7xHUZE9sjOHWOewoJwLTQwl6rqNAny7H/FR8esXwY=;
        b=mPBQGm8tWo2g49c727B3ztYMD7BqBiqnJm4gseVnvm+1UQlK+Yr0u0VU6dA1utx73M
         RxD7+OoXbxPwr5NpokM132hQgH1xyx9wk26rXnlzDxF/HW8alnMpJ8MmPXDdDx5t24QC
         ENVAqr2gAyhDiW8mpjXaarScAHwTFLPAc0hs8gs5lXAbSmcBQL+7GyStm0jHw7NspqQt
         TtVfAY1hgQeox+HeRAZDOCc5vROZl/HHnALC/OMDLN2tUWGSNl6APA5XgldRjCqpjUQ2
         pm2qKvv+dzqdDNl7fg7XjtU1ioYrvNlTyut4k5ytDdmlYXmEgVEVqjF1rW6sqpOp41Xn
         hsGw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of hdegoede@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=hdegoede@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of hdegoede@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=hdegoede@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
From: Hans de Goede <hdegoede@redhat.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	"Luis R . Rodriguez" <mcgrof@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H . Peter Anvin" <hpa@zytor.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
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
	Kalle Valo <kvalo@codeaurora.org>,
	Arend Van Spriel <arend.vanspriel@broadcom.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	nbroeking@me.com,
	bjorn.andersson@linaro.org,
	Torsten Duwe <duwe@suse.de>,
	Kees Cook <keescook@chromium.org>,
	x86@kernel.org,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 5/5] platform/x86: touchscreen_dmi: Add info for the Chuwi Vi8 Plus tablet
Date: Sun, 29 Apr 2018 11:35:58 +0200
Message-Id: <20180429093558.5411-6-hdegoede@redhat.com>
In-Reply-To: <20180429093558.5411-1-hdegoede@redhat.com>
References: <20180429093558.5411-1-hdegoede@redhat.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599072718546647819?=
X-GMAIL-MSGID: =?utf-8?q?1599072718546647819?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add touchscreen info for the Chuwi Vi8 Plus tablet. This tablet uses a
Chipone ICN8505 touchscreen controller, with the firmware used by the
touchscreen embedded in the EFI firmware.

Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
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
