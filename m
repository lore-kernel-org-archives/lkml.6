Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AG47ELvTtpL1YYONc7Or4Oc3excOJYNiXWjIU7XC6AHJ0yxxYeaWU0ScDC3d2jQkG9CJb7HyT7sG
ARC-Seal: i=1; a=rsa-sha256; t=1522128618; cv=none;
        d=google.com; s=arc-20160816;
        b=ltw61w14nuRynBO4uyebBfpJvwdg95MgHTwbUHXXq270oZFgXkOjJRTf+8AfC/YRDX
         E2bYFqj5/BvuZ1vy4MW+gnIrpfb1UJbOkYkuEDX6/Qb3vZcCkFSIm3NMcwi6a6+4zoZU
         lvNOa/ZHL3vHYHDIOQa72/KbF2N0PU1y7Bu9sIgr0pqh0hdWbfeB4+eNBL8DsTE4sCAM
         OAtXTqRaN7/lr99RsAv468OidElAL9+DC1DjS1tT0Y2XUzT2Bv5CtPRZpwM5WjV/KaQd
         W8XygsxTMRtILMMPE67EmDNlEJKLPYkVZLJjOAh4ZL0hJY7oPhxhZ1EuOtoQyVSR71D6
         9y/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-filter:arc-authentication-results;
        bh=J2BgIXcZwp3hlOWfk/Pju/0FbwUbeEepiJU9WiBDX5g=;
        b=SMRQ0f438NwbnRexeWa+qNQAYI/HZkya6MkFcgIem12TUdtYy1vUO1tVQ/N6S8609M
         07FlDGnmv1ha/w3H+ju/YfgTnQwPA7nhdtoYWlaPi349+Iloy+rjND66tIxxYc7H4k6f
         J6BD1Fi6hVvNZTy342MITKDc+LFGCZvECKiTtFS1GApRjUUr62K9RgM0GHi4a6+gcK+i
         s/iSFM3cQWSPIsEFOmgx0Jy1cTXMzng64E6/ERPRzPeUce1sj0FYo1yJdCSwFOjTcodR
         oAoWTjngjozKxZa3h1Mu6cG4wmQxfj1NY4u90n0bBysBsydwEPMi874KT4fUcyu98CDS
         ULfQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=yAGX2yST;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.76 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=yAGX2yST;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.76 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com w2R5TaLr011947
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Ulf Magnusson <ulfalizer@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Nicolas Pitre <nico@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/21] kconfig: replace $UNAME_RELEASE with function call
Date: Tue, 27 Mar 2018 14:29:22 +0900
Message-Id: <1522128575-5326-9-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522128575-5326-1-git-send-email-yamada.masahiro@socionext.com>
References: <1522128575-5326-1-git-send-email-yamada.masahiro@socionext.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596067537399690417?=
X-GMAIL-MSGID: =?utf-8?q?1596067537399690417?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Now that 'shell' function is supported, this can be self-contained in
Kconfig.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2: None

 Makefile     | 3 +--
 init/Kconfig | 4 ++--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 4ae1486..5c395ed 100644
--- a/Makefile
+++ b/Makefile
@@ -284,8 +284,7 @@ include scripts/Kbuild.include
 # Read KERNELRELEASE from include/config/kernel.release (if it exists)
 KERNELRELEASE = $(shell cat include/config/kernel.release 2> /dev/null)
 KERNELVERSION = $(VERSION)$(if $(PATCHLEVEL),.$(PATCHLEVEL)$(if $(SUBLEVEL),.$(SUBLEVEL)))$(EXTRAVERSION)
-UNAME_RELEASE := $(shell uname --release)
-export VERSION PATCHLEVEL SUBLEVEL KERNELRELEASE KERNELVERSION UNAME_RELEASE
+export VERSION PATCHLEVEL SUBLEVEL KERNELRELEASE KERNELVERSION
 
 # SUBARCH tells the usermode build what the underlying arch is.  That is set
 # first, and if a usermode build is happening, the "ARCH=um" on the command
diff --git a/init/Kconfig b/init/Kconfig
index b4814e6..0d6fe20 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -2,9 +2,9 @@ config DEFCONFIG_LIST
 	string
 	depends on !UML
 	option defconfig_list
-	default "/lib/modules/$UNAME_RELEASE/.config"
+	default "/lib/modules/$(shell uname --release)/.config"
 	default "/etc/kernel-config"
-	default "/boot/config-$UNAME_RELEASE"
+	default "/boot/config-$(shell uname --release)"
 	default ARCH_DEFCONFIG
 	default "arch/$ARCH/defconfig"
 
-- 
2.7.4
