Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227T1TNKa7zl7vFS6hT3pKKSFXWLODl/54TKPX/2XGyMB/JKnamaPmDh2Fsu4AetKARCcKu0
ARC-Seal: i=1; a=rsa-sha256; t=1519218344; cv=none;
        d=google.com; s=arc-20160816;
        b=ekpgk/nOKHNhLuk9yYY5LwA8mvovIUyyg2zoLlygBqpuwExGEaKXkNsBVbj8xrd+FJ
         NEzVEW0ki7/rWaf1Hoqaair+M3BIzbSB1lAPwDRkUxmlLfS4RdNjqwQ0+HSA0P9P0cHS
         sbdmR0coUWR2uWCmuqBVVkwqaSjSUjwSDIQmLv0uasVSw0O4GYziWGnhB6edX4H7ptBb
         sRG5HpCYAGG3R6lcIhUrThvt8E0tNViYJ+i0IWBML0S8H9gmWoD9+z654ouIiL0zEacR
         TkKPOmR9ixSvtbdJkO2vZXPHVA65VW2/JbnwcOVsqNnlfVdBHRcQjltm6LPOwle6WCV1
         BA4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=28u55Ujy9BX5tBebhR1wqMJukLn5DhV6sH0cDA1NDS0=;
        b=YX/pFZVhJRWKTNqakteFapIqJaGOydqUW5GQ6CON9u0n+mIUcg+7NeMtdqf4rx74Iw
         L2MeWXjiwj4J5/VqbDhPQX3mY068h2B96s2YnOaJyMVw36tGnGt3x3eXuue7T23MzT5H
         fklXjw8VZDyfVWh/a+Z4AyagaHvvldwQxPCo/l4z/zMvz1If+Cd+miv5B2oKgDrBDUJt
         kILtfd7k+o/loc0LSEncXZBIOMhS0URS+bNtTCC7Y1Uppl0JG669eQY4gWbDUGcf0K8N
         6nz/wXw5IvUJLyPbi8kcubwxweJ3YWSNQCHfjQJcxlpuNvD9vM76FmRhbEF7OKAUegXB
         7Q3A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	James Hogan <jhogan@kernel.org>,
	Corentin Labbe <clabbe.montjoie@gmail.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	Paul Burton <paul.burton@mips.com>,
	linux-usb@vger.kernel.org,
	linux-mips@linux-mips.org
Subject: [PATCH 4.14 151/167] usb: Move USB_UHCI_BIG_ENDIAN_* out of USB_SUPPORT
Date: Wed, 21 Feb 2018 13:49:22 +0100
Message-Id: <20180221124533.069049354@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015246018600835?=
X-GMAIL-MSGID: =?utf-8?q?1593015894538940334?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Hogan <jhogan@kernel.org>

commit ec897569ad7dbc6d595873a487c3fac23f463f76 upstream.

Move the Kconfig symbols USB_UHCI_BIG_ENDIAN_MMIO and
USB_UHCI_BIG_ENDIAN_DESC out of drivers/usb/host/Kconfig, which is
conditional upon USB && USB_SUPPORT, so that it can be freely selected
by platform Kconfig symbols in architecture code.

For example once the MIPS_GENERIC platform selects are fixed in commit
2e6522c56552 ("MIPS: Fix typo BIG_ENDIAN to CPU_BIG_ENDIAN"), the MIPS
32r6_defconfig warns like so:

warning: (MIPS_GENERIC) selects USB_UHCI_BIG_ENDIAN_MMIO which has unmet direct dependencies (USB_SUPPORT && USB)
warning: (MIPS_GENERIC) selects USB_UHCI_BIG_ENDIAN_DESC which has unmet direct dependencies (USB_SUPPORT && USB)

Fixes: 2e6522c56552 ("MIPS: Fix typo BIG_ENDIAN to CPU_BIG_ENDIAN")
Signed-off-by: James Hogan <jhogan@kernel.org>
Cc: Corentin Labbe <clabbe.montjoie@gmail.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: linux-usb@vger.kernel.org
Cc: linux-mips@linux-mips.org
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Patchwork: https://patchwork.linux-mips.org/patch/18559/
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/Kconfig      |    8 ++++++++
 drivers/usb/host/Kconfig |    8 --------
 2 files changed, 8 insertions(+), 8 deletions(-)

--- a/drivers/usb/Kconfig
+++ b/drivers/usb/Kconfig
@@ -19,6 +19,14 @@ config USB_EHCI_BIG_ENDIAN_MMIO
 config USB_EHCI_BIG_ENDIAN_DESC
 	bool
 
+config USB_UHCI_BIG_ENDIAN_MMIO
+	bool
+	default y if SPARC_LEON
+
+config USB_UHCI_BIG_ENDIAN_DESC
+	bool
+	default y if SPARC_LEON
+
 menuconfig USB_SUPPORT
 	bool "USB support"
 	depends on HAS_IOMEM
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -637,14 +637,6 @@ config USB_UHCI_ASPEED
        bool
        default y if ARCH_ASPEED
 
-config USB_UHCI_BIG_ENDIAN_MMIO
-	bool
-	default y if SPARC_LEON
-
-config USB_UHCI_BIG_ENDIAN_DESC
-	bool
-	default y if SPARC_LEON
-
 config USB_FHCI_HCD
 	tristate "Freescale QE USB Host Controller support"
 	depends on OF_GPIO && QE_GPIO && QUICC_ENGINE
