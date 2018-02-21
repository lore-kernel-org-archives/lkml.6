Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226a+R1lPZgtvlQxRpLLtc/dhvrv005J4utBKYzOGUhYyYCzvLN+ofnVlWkaxcIXBVzIwY7B
ARC-Seal: i=1; a=rsa-sha256; t=1519218671; cv=none;
        d=google.com; s=arc-20160816;
        b=DDAExBRKzMGJ8kaaRqo/mpCd9jQw1Mgjvs9NoDCJsLxpgplmlUorzno2K+ibNBnozW
         46zdbF45KsiF6ZqYfi0ckIdi+5Vbsy5fU5d0/jq3Lpvd0Bj6sLiAwr9udXysyeJobQ8K
         K5x4jSiR2pVBcm+d4l9nsy0QB9qNxlbU1x4vWZtpjfpMOBHrEzjP2VBqNszZlyC3ujJ1
         LWBS12jimyfwQymbDh3fcF+Grc9iFnP+m0WmaEVNPblg6R8nryFaj7ANdETwdch95mry
         sdR6FjyVO59S+pBrrp4fDa27udbyjpDIuOHpyn4TjBvLvo8x/qistTtEriQs2d1iHjm8
         hnjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=cBPOvVLXVweDnDlCpZO4FAXHEzWOrc9WuYLjXZW2Yrs=;
        b=myxwLQ5y+AVMitGST7wa+xDFr2CV7tke/EfwRGqOatR/BzXjwvnc1v2gpeSnCUz8GE
         kTGz/UfWy4UUAJPFYNMbgcRlNdkwwNvBIAoXlY89FLTE6CGp07GgyEQr7SMAsLWmAR2X
         uszLmERtGYiPtf4IMoqp8aBWbBgz2CoZM+Zz2O8I4UeFDPyhjjdQjvNpu3Wya7ia1510
         DTqk107k6WNB9vcRdxa6SlQRLH+LU+hRSAtZgpKDNsiuhWNBppAO6uovgdMQDVZu2ntI
         wdPeKab+94nB0E/1z6vu+0qenov3szgIs5tTtf/WH1Q6pVFCYAvw5CrQqEbSdyrUyvjg
         nNsw==
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
Subject: [PATCH 4.15 112/163] MIPS: Fix typo BIG_ENDIAN to CPU_BIG_ENDIAN
Date: Wed, 21 Feb 2018 13:49:01 +0100
Message-Id: <20180221124536.358919398@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015291930892901?=
X-GMAIL-MSGID: =?utf-8?q?1593016237550883653?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
