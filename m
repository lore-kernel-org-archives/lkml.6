Return-Path: <hdegoede@redhat.com>
X-Google-Smtp-Source: AIpwx4/+r38gn6OUIbcR4fvSHYnlTLbqqOx7ZA2TAcFrwjtfNjEccUfr0K4paiPIBYdbkyR1dEDm
ARC-Seal: i=1; a=rsa-sha256; t=1523208421; cv=none;
        d=google.com; s=arc-20160816;
        b=KI4ShMPCgBpHSAwcMq2Bqm9YMnVYGNwQ9DtYDkZsI2MgDi10Bid/bfJaL+rVqV+2IM
         cD20BNxx3YDUDKge92lqgcnjT/mvErC3b+vnzX6yskjqIPgjsZzbAH7Lo0enFqsUVgrg
         DwubWlUlXRknEJ7BpGpWZGT8Hw2Qv+dw8Uq9u+YAcRw/pjIRSiqC77F6L24OFvJWLBVj
         hNrKdHFbaSpvHiZaKC7um3+uy6woR6ZS8x7mD9Z8IBqugqYxTAsFDCfCMLQ4H0zzPiQF
         el3mmn9wQmlpjKLTsAJDemYCx4nD2hAJQnNMnDiNt6c5VgCKn3ddeLsdXAV0oVuxVUoH
         TOWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=TNkGNBzecSHPR4+7tnPddEvJKxrapeQ3VAZbUqu0Dj8=;
        b=Ic9YBHbE4DgvyFcOCzJyiILz4B1/sjekh3aiJZVA4+bejrGzZgPOzGUVgz1TkudTN2
         8+bYvOKlg4NQ5tX3rPEuTZiw8GI9FwA226OurShYABsuk7A2+kQo01cxF6dTHguPJZje
         zf6Vvp6BnM/nzN8raC3gL8ufgv6FN4bzkHOI5iYOKEeQfp02Hix89jnUbiDIbxh0FDBC
         tAnAJDmICaA0XaaEYbhr3s//mfmY3gH9sW5fXj+8RBaJu6z6JwPV99Zrs+/g+R8XeUzp
         J0qWUPe5hJKTVRiibMqysCIHRxbmd+ESSSxt9NPzRuiSQPaMR2GFjSP8BhKszE8C6DQm
         kvPg==
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
Subject: [PATCH v2 5/5] platform/x86: touchscreen_dmi: Add info for the Chuwi Vi8 Plus tablet
Date: Sun,  8 Apr 2018 19:26:36 +0200
Message-Id: <20180408172636.13926-6-hdegoede@redhat.com>
In-Reply-To: <20180408172636.13926-1-hdegoede@redhat.com>
References: <20180408172636.13926-1-hdegoede@redhat.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597199794097798684?=
X-GMAIL-MSGID: =?utf-8?q?1597199794097798684?=
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
