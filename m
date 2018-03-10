Return-Path: <mathieu.malaterre@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520705235; cv=none;
        d=google.com; s=arc-20160816;
        b=OgayI+2F7MHfHag01p3ydLiW5bo40RdnNW7OPT2AWxjijUsVZXz6rksnqo45CIAXB9
         gy1xDZhMDj9wLcMCsjkjH6CUb0u7FpFVc6L7FyWpc4L6FS+A6VbXRdzuTCSCNmkYWROk
         OoUZeafsxiV9WUGsoLnoVvCV2P+1yAJvQsDZpFdxwQMiDQeHIKGfW4c39+WqgE0ZLD8+
         BVJVhDgVC0RHik32gYoJdZyP93Sjad26WIxQ4MubGjdiPoHWqoJY9hUZ//aGw3lDNpFb
         OTgsdi6cIabKTazknAyrSVqBDSc7B4+1EJTUJDUuffCogY3dYtfYOZen6/QklKJu3wuE
         J0VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:dkim-signature:arc-authentication-results;
        bh=5xyIAtWit3saSnYf8qXkPiyHk7gO+xkDoCcTM1SKbA8=;
        b=WUfY1VbiVhAk7+J++VbhL6Y4p7DMGuC4Xsp1D/bmdj0ssL5iTDovn6C5Ymq4dyBP4y
         0lVRNQuuIZc71tEI+UkQPWuGOHoPfnAzbJLKTyRdO2S7HTlLIDiehqNFGIJJDE2I9RW4
         3bY2AmMYGPyyFuGciYo8o3c+WPB/Ue8dUVvFNaOAL7SGYGnP44uZuH82JC+mxvQtqut2
         7dwR7sWK84QBgMPQDXwc0ljqutsOAAVySZw8IYCHT90yZSwra+We5ZwEd8oxPoAQbOnK
         NWeGwjsBO8RDn2bv/ieUeBNizojsKzs7GXFKwkEWGrj3yS8MGpiSdhecRCV6/feoBcmW
         0FEw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=NxQzfaSB;
       spf=pass (google.com: domain of mathieu.malaterre@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=mathieu.malaterre@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=NxQzfaSB;
       spf=pass (google.com: domain of mathieu.malaterre@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=mathieu.malaterre@gmail.com
X-Google-Smtp-Source: AG47ELt/kXHJoCE7RrtS30bpHjzec5Sy8DeMyrMtrK4g1OC+Kyka4Bp/VvuXjcWKdc2PKjt36chIvQ==
Sender: Mathieu Malaterre <mathieu.malaterre@gmail.com>
From: Mathieu Malaterre <malat@debian.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Mathieu Malaterre <malat@debian.org>,
	Jiri Slaby <jslaby@suse.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: Mark the variable earlycon_acpi_spcr_enable maybe_unused
Date: Sat, 10 Mar 2018 19:06:45 +0100
Message-Id: <20180310180645.7014-1-malat@debian.org>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594575013229600361?=
X-GMAIL-MSGID: =?utf-8?q?1594575013229600361?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Re-use the object-like macro EARLYCON_USED_OR_UNUSED to mark
`earlycon_acpi_spcr_enable` as maybe_unused.

Fix the following warning (treated as error in W=1)

  CC      arch/powerpc/kernel/setup-common.o
In file included from ./include/linux/serial_8250.h:14:0,
                 from arch/powerpc/kernel/setup-common.c:33:
./include/linux/serial_core.h:382:19: error: ‘earlycon_acpi_spcr_enable’ defined but not used [-Werror=unused-const-variable=]
 static const bool earlycon_acpi_spcr_enable;
                   ^~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 include/linux/serial_core.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index b32df49a3bd5..1d356105f25a 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -379,7 +379,7 @@ extern int of_setup_earlycon(const struct earlycon_id *match,
 extern bool earlycon_acpi_spcr_enable __initdata;
 int setup_earlycon(char *buf);
 #else
-static const bool earlycon_acpi_spcr_enable;
+static const bool earlycon_acpi_spcr_enable EARLYCON_USED_OR_UNUSED;
 static inline int setup_earlycon(char *buf) { return 0; }
 #endif
 
-- 
2.11.0
