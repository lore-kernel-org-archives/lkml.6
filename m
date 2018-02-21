Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225p9QdC+Voe8H8WRqCjW/1wPjg3StPXavJHhjr3NksfE8pLjq8Js7E5U+W7Cw6dloHeeS88
ARC-Seal: i=1; a=rsa-sha256; t=1519217725; cv=none;
        d=google.com; s=arc-20160816;
        b=mx+5cmD1oAQ4iwuXNXekIeSLk1S4DihtojSjiNHb4AvtZnyfIxg8S39bBckQH7TYN9
         kt0rE6OPJvg+mWfLUODdJEJDz3pWFi16L4Nou/Ao42oeEkzElbZGx/IwTqRkae48T9Kr
         tmBsdrqnX2HGrOXEHsKCg6juUCdqicRVy8LulCV93aURDw6M6h0A/0UvXe+2b5xgqknL
         IB7+oug6j7+oOqd5sUeRSZRfzWO81w/xgYDsXhocZbHpNzi+P1J/mVHl8B7sLdgKVcBH
         7z43buTq95+U5GkiTM8hKuhg9uazwfeFpycTMKFEDgSBJl7lc8i8q1t8yKpFNNTs3mXE
         7vTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Dm7YY+uyO6TVF6lEJ5EEbwjvq6DZSuK2lmexJM9Kw1A=;
        b=yAnyoboucjPOeDVo5P217jbtN1PQJPFYuHFByZhf6j70nzA18gFTZeTryFg9Hbo7WX
         Nd0kjaVG7KgM03Sf+Bbk8R5dsjXnpK6mWsyhCxLPXoimGGTDaVI/h73R2wxEv1VpsDuV
         gTT+JkyetZL/T+rQKadYk5lJhlQ3cWg/zx1OBnuKim4nnm6FceTKZ9afAjjoUuPOUviJ
         fAwrOlwnO/ao86imlUUi01ILzUh2qFQECveGmYmVefpdi8anYKbhWcjIdgtVzaxKPE4A
         i2iweu4jdsPuufdPKtIy6N2xiJ9xkogAy0W1j1ioZHTO9MvmMsBXCSBrsDfS+rmh6EqP
         A8zA==
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
Subject: [PATCH 4.9 32/77] usb: Move USB_UHCI_BIG_ENDIAN_* out of USB_SUPPORT
Date: Wed, 21 Feb 2018 13:48:41 +0100
Message-Id: <20180221124433.539558108@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124432.172390020@linuxfoundation.org>
References: <20180221124432.172390020@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015246018600835?=
X-GMAIL-MSGID: =?utf-8?q?1593015246018600835?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -628,14 +628,6 @@ config USB_UHCI_PLATFORM
 	bool
 	default y if ARCH_VT8500
 
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
