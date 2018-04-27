Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqLQoq+ratMpzCkjtDfWWz9maHfhXn2TPMaGAaa4PpX7pw0z4DVdhYHmiJ7rV8jcMAtNwYI
ARC-Seal: i=1; a=rsa-sha256; t=1524838101; cv=none;
        d=google.com; s=arc-20160816;
        b=kpzxdWiStFv1HWJy+r44DSbptH7LgnClxhHq2HWrfB6OzQLtA05yWvuw+qMKT3uMbq
         IlsWmYO+cXFWFOe09KkaADILSs8iPjBV7QhHFqceu6jBOTwdeiQ4O6selIy4bVoQzwL1
         NuGnJM25s//XRtMOjdH9wjrLIkIfKLKhMOpc9LxNKhI0n0NRqShYx+TTl7lDlQR6d/kA
         ZIsJwvSpxtTHspkih7ADu751EdGefNzO/zBaasfJMqF6VBTnMu2xFD9tH9HwMjPIKh5N
         Iabp96AoCx4VSluE3+3jdXTvlrl1RrVs2w6t057FNR2iHb6Aflw8Js/dx6InfnbA2wYK
         C0Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=L2qk19awW6h0P3DQfk9t+1WuqqGfNlX5lfe8n289KyM=;
        b=hpA+hSuk+banD/iAMpzDQu+qkADJtBok6j+mNsk69TqGbdjxODBdn+2Amwfm3XMOI4
         L071FMphP3ygilwHlQwbDByoisiesX0EwukhOgmfy1fIb2PATtSwcaBbCwz37AQNH/eq
         u47zS2DOuAgzjO/IDshKwFAaRgE0GUF4lz9sbPaIR+qFXqvSEBWQ4rq22afOgxMKNDOv
         +DzNJwW9CGVHhtPEaiMGhhmXjXe3FoXt8A+f7LzyuQ2s6ExFFzUq8kTt6hJ+S05D2bRW
         YdtUHAzprf9XRDU0tcsWJVTv6yY5/DMQgvxxqSm3zn8aw41RtBFfz+v4q5UYjmc8IgCt
         +j1Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1117221892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	kbuild test robot <fengguang.wu@intel.com>,
	Michal Simek <michal.simek@xilinx.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4.14 61/80] microblaze: Setup dependencies for ASM optimized lib functions
Date: Fri, 27 Apr 2018 15:58:54 +0200
Message-Id: <20180427135736.043358702@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135732.928644313@linuxfoundation.org>
References: <20180427135732.928644313@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908637402675980?=
X-GMAIL-MSGID: =?utf-8?q?1598908637402675980?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michal Simek <michal.simek@xilinx.com>

commit 18ffc0cce4ff947a2acc9b2e06ae5309a6e6fb43 upstream.

The patch:
"microblaze: Setup proper dependency for optimized lib functions"
(sha1: 7b6ce52be3f86520524711a6f33f3866f9339694)
didn't setup all dependencies properly.
Optimized lib functions in C are also present for little endian
and optimized library functions in assembler are implemented only for
big endian version.

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/microblaze/Kconfig.platform |    1 +
 arch/microblaze/lib/fastcopy.S   |    4 ----
 2 files changed, 1 insertion(+), 4 deletions(-)

--- a/arch/microblaze/Kconfig.platform
+++ b/arch/microblaze/Kconfig.platform
@@ -20,6 +20,7 @@ config OPT_LIB_FUNCTION
 config OPT_LIB_ASM
 	bool "Optimalized lib function ASM"
 	depends on OPT_LIB_FUNCTION && (XILINX_MICROBLAZE0_USE_BARREL = 1)
+	depends on CPU_BIG_ENDIAN
 	default n
 	help
 	  Allows turn on optimalized library function (memcpy and memmove).
--- a/arch/microblaze/lib/fastcopy.S
+++ b/arch/microblaze/lib/fastcopy.S
@@ -29,10 +29,6 @@
  *	between mem locations with size of xfer spec'd in bytes
  */
 
-#ifdef __MICROBLAZEEL__
-#error Microblaze LE not support ASM optimized lib func. Disable OPT_LIB_ASM.
-#endif
-
 #include <linux/linkage.h>
 	.text
 	.globl	memcpy
