Return-Path: <hdegoede@redhat.com>
X-Google-Smtp-Source: AB8JxZrWiMPm7XVfzQvehfUPppVtx5EKZusnl8u58I1ucDrVg5ZY5skHTUxnGPohYYRb3gY/+xGv
ARC-Seal: i=1; a=rsa-sha256; t=1524744420; cv=none;
        d=google.com; s=arc-20160816;
        b=t9Cf+jl5VsYOZ/s89j77gBVBwhCarSs0O3+1/4V2PrTPfkmg6jCFEnxPbukexzhR8u
         A2oMNlkXqyn3UOKt3Xs5ldbTH7LDEadswU30gwb0ObSpMCp54ggIrSn0A4br3SBzjfVr
         slnHVW2crpFRDafzO0f08WZDDOff9xMk8N9benMHdbBh4dcwW67oPBgyH86oNo98VCSk
         LOkSFbGtsfqFoZCSFlpeuvrPk5o7b2FDeP0zrQox7m4gg0/c3kyq7mTQJX5Ijg5Whk9n
         e1fHtV/U8KkfZ9wTErjRjCPOQ5MvigXSVTnVimJTPGvMQ+f9A+Y61micHLVLkCvR6QNE
         Ijnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=p8JEZG5A5ZL35l7xx8IrrEgpXV3ErduEYl1FM4ZYxzI=;
        b=Yq08b5ghUIYYh37C5ASE5O6e3GdghW1H27Gr5bNV375Behhc2JfYnfomxTUU0NKf+g
         tEJ+YvlF3EqGSl8S9PblHbio7GoBtcOU7nGFfKsxMGPZ2zCY4Bi2tDZw6qsvumW4Q8w7
         2o8Z9ugWaXNGToff3KHEzPlfm/UQ0ff692Q00hx88f3EAfAJa7RB4DTqHpzymDG6zKi1
         MfmIdnmSZ0zVBKtdmbsQKU1/Lvm2JI6Phiqnmf1XL6FQ5PP6EC8lIhM4NxLPWdEgSY4P
         /EAl+rhkQQSXZcy+SOV16xA9PGBlDRFjOXOHOWiBnrsUYXxjDTZ0DVZ2Kj7HHXFqs39u
         OuwQ==
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
Subject: [PATCH v4 5/5] platform/x86: touchscreen_dmi: Add info for the Chuwi Vi8 Plus tablet
Date: Thu, 26 Apr 2018 14:06:37 +0200
Message-Id: <20180426120637.21258-6-hdegoede@redhat.com>
In-Reply-To: <20180426120637.21258-1-hdegoede@redhat.com>
References: <20180426120637.21258-1-hdegoede@redhat.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598810405459590000?=
X-GMAIL-MSGID: =?utf-8?q?1598810405459590000?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add touchscreen info for the Chuwi Vi8 Plus tablet. This tablet uses a
Chipone ICN8505 touchscreen controller, with the firmware used by the
touchscreen embedded in the EFI firmware.

Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
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
