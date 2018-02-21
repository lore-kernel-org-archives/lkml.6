Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224QEyqQ9Qbc2jskful2XDvWnaovScxtQJ3u2XM0bCV7jONT+dOADiBDJ8G3fos/eCgjiIhl
ARC-Seal: i=1; a=rsa-sha256; t=1519218267; cv=none;
        d=google.com; s=arc-20160816;
        b=YlnBy/PjxGHVF+IXC6/dyADyWn1BI5KhS07rKejerzhatSmLybZGLHDcRG2lF8SBPt
         lljxBvJfxBy5mGiiBJbqMfrRUar1FS7v+LmS7t0bcKx50UuYx9U5go9e46Ztby8NCg1b
         jcmmM8ZNJLH5L7BdQABQbdoyizGlyc4xnT1/ocXUE2fIVPJXmiQFEK70ZJF+mL897z2o
         Itq6absCw40XE0Qe5T4YSIg+aEipxcdiOl7fA5WvgvVfg6/34b21bD0hAGVcgKFBNAPR
         E3r3qL8uqCiRu23VL7DKWdtEJQM92O5MP7LjrmIMDNgO722L24n4CXYryIX/a6k2scl6
         4WeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=5zA9RDAv94Qy15mb/VAVnbbJSLbYY+gw826SvtcBk9s=;
        b=QIbAXf2veaYmzmL/fkak41BGvPXfhPsNLEsfyxKFtpPT6Tu5oAic7Dm9pG1vbXDmxz
         NeKDTxCBc3qaAZnMAiFuXTT0F6SVrdbg+ZshxRWISa56TiPa8O6CvxZPWbVd8iUuVqSe
         G+Mlz3X7CMXQihGYHKtaGd9v22eRHH6MvOHa50OIeM4pZQWu0EpzLf/zwZjHd/PDs1ER
         xlGtlZJEk+aOYRWrZOx9OGgIiBxKHvVhmLBuUah1aX7CwSDWXJggFasSyupRdHtCzSbw
         hl6Eone56Baq7DtO0+kqC6PYTjHxTGPE3WDRsU1ealoCSpysUebqxcYWy+6IB+VY41Qh
         GtZg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Corentin Labbe <clabbe.montjoie@gmail.com>,
	James Hogan <jhogan@kernel.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	linux-mips@linux-mips.org
Subject: [PATCH 4.14 111/167] MIPS: Fix typo BIG_ENDIAN to CPU_BIG_ENDIAN
Date: Wed, 21 Feb 2018 13:48:42 +0100
Message-Id: <20180221124530.441016161@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015291930892901?=
X-GMAIL-MSGID: =?utf-8?q?1593015814502670613?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Corentin Labbe <clabbe.montjoie@gmail.com>

commit 2e6522c565522a2e18409c315c49d78c8b74807b upstream.

MIPS_GENERIC selects some options conditional on BIG_ENDIAN which does
not exist.

Replace BIG_ENDIAN with CPU_BIG_ENDIAN which is the correct kconfig
name. Note that BMIPS_GENERIC does the same which confirms that this
patch is needed.

Fixes: eed0eabd12ef0 ("MIPS: generic: Introduce generic DT-based board support")
Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
Reviewed-by: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: <stable@vger.kernel.org> # 4.9+
Patchwork: https://patchwork.linux-mips.org/patch/18495/
[jhogan@kernel.org: Clean up commit message]
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/Kconfig |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -119,12 +119,12 @@ config MIPS_GENERIC
 	select SYS_SUPPORTS_MULTITHREADING
 	select SYS_SUPPORTS_RELOCATABLE
 	select SYS_SUPPORTS_SMARTMIPS
-	select USB_EHCI_BIG_ENDIAN_DESC if BIG_ENDIAN
-	select USB_EHCI_BIG_ENDIAN_MMIO if BIG_ENDIAN
-	select USB_OHCI_BIG_ENDIAN_DESC if BIG_ENDIAN
-	select USB_OHCI_BIG_ENDIAN_MMIO if BIG_ENDIAN
-	select USB_UHCI_BIG_ENDIAN_DESC if BIG_ENDIAN
-	select USB_UHCI_BIG_ENDIAN_MMIO if BIG_ENDIAN
+	select USB_EHCI_BIG_ENDIAN_DESC if CPU_BIG_ENDIAN
+	select USB_EHCI_BIG_ENDIAN_MMIO if CPU_BIG_ENDIAN
+	select USB_OHCI_BIG_ENDIAN_DESC if CPU_BIG_ENDIAN
+	select USB_OHCI_BIG_ENDIAN_MMIO if CPU_BIG_ENDIAN
+	select USB_UHCI_BIG_ENDIAN_DESC if CPU_BIG_ENDIAN
+	select USB_UHCI_BIG_ENDIAN_MMIO if CPU_BIG_ENDIAN
 	select USE_OF
 	help
 	  Select this to build a kernel which aims to support multiple boards,
