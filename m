Return-Path: <gilad@benyossef.com>
X-Google-Smtp-Source: AG47ELsbxnYuVaQ3LiJJBHN+ltfxV62nO1Snn0W1DMCnsUQyshrEd8tgaMG/0hsE7umBkTIo9K2n
ARC-Seal: i=1; a=rsa-sha256; t=1520498688; cv=none;
        d=google.com; s=arc-20160816;
        b=QrJL2yoophlc9sEQAuNp1iSLujAVcsLasSuYSSdMeWKULqeWRluclFHdxxRQ6jNQni
         4flPPk6THSdu9825W3vfncOcgUMYETmwBVKmJM317xRP+EVJBEwy51r3E2BLmNcP1LBz
         Vl+fWSVZrsc/Y4hhRCIODCV3XPhM08e8JkDxDhYcrV4U6dTeY55LoW5+NeXf/VQNwR6y
         gblRmAeKos+OxibSMfah6Y63YpjXMi1y1QMYrLbHmYFvTJXDMD7aAV8kYPDhBj1CaAMb
         U2G/Dn2dm0lA1XYUHoxtkt2wEFnEITn6xm8awDGFjSxJBo55LG3Be+MWBZufvau/YY4n
         XiPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=FTGJg+bdzgWZz4A6A3qpV/TEpeBgufAN67kNlsLQfvE=;
        b=icYtjlGVMhposL82ckbnNhS1SVVgUCiwIwgGsi1bTUYFY1s9VFfpH2L5O08EpSHYV1
         K4bqEmccfo43HR1g/SRpNP+/UbLmAt/Ct/igj2q0gGcZ4JB1xk4aJ7+eldR+1SamoWBr
         f0Wm9ZheqHw50VuqWb7gXJWcpcaLV09aeFHcVSMuQbrlBHu5Q97b51jMEqsNyK9fzZxx
         6iwhBjUzEX5apTtWMUvgCCNntDUEE16T9D5BQMo4oV+hAcmOBXkU02+8Faf8gtuB6FP1
         vQsadi9J8+WWpL7o7W5JruhUy+5uWmf9TwfTzxQT4B+/yhLJ4/59vv9FQ5bAQPt/XUgO
         OQyw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 217.140.101.70 is neither permitted nor denied by best guess record for domain of gilad@benyossef.com) smtp.mailfrom=gilad@benyossef.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 217.140.101.70 is neither permitted nor denied by best guess record for domain of gilad@benyossef.com) smtp.mailfrom=gilad@benyossef.com
From: Gilad Ben-Yossef <gilad@benyossef.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ofir Drang <ofir.drang@arm.com>,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: ccree: remove ccree staging copy
Date: Thu,  8 Mar 2018 08:44:38 +0000
Message-Id: <1520498678-32175-1-git-send-email-gilad@benyossef.com>
X-Mailer: git-send-email 2.7.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594358433276712536?=
X-GMAIL-MSGID: =?utf-8?q?1594358433276712536?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Now when the ccree driver has been accepted into the cryptodev tree
we can remove the staging tree copy.

Please note that this commit may cause a merge conflict with the
cryptodev tree since we needed to disable the staging copy in order
to get the new copy to compile but the resolution is trivial.

Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
---
 drivers/staging/Kconfig                  |    2 -
 drivers/staging/Makefile                 |    1 -
 drivers/staging/ccree/Kconfig            |   27 -
 drivers/staging/ccree/Makefile           |    7 -
 drivers/staging/ccree/TODO               |   10 -
 drivers/staging/ccree/cc_aead.c          | 2704 ------------------------------
 drivers/staging/ccree/cc_aead.h          |  109 --
 drivers/staging/ccree/cc_buffer_mgr.c    | 1651 ------------------
 drivers/staging/ccree/cc_buffer_mgr.h    |   74 -
 drivers/staging/ccree/cc_cipher.c        | 1165 -------------
 drivers/staging/ccree/cc_cipher.h        |   74 -
 drivers/staging/ccree/cc_crypto_ctx.h    |  170 --
 drivers/staging/ccree/cc_debugfs.c       |  101 --
 drivers/staging/ccree/cc_debugfs.h       |   32 -
 drivers/staging/ccree/cc_driver.c        |  474 ------
 drivers/staging/ccree/cc_driver.h        |  194 ---
 drivers/staging/ccree/cc_fips.c          |  111 --
 drivers/staging/ccree/cc_fips.h          |   37 -
 drivers/staging/ccree/cc_hash.c          | 2296 -------------------------
 drivers/staging/ccree/cc_hash.h          |  114 --
 drivers/staging/ccree/cc_host_regs.h     |  142 --
 drivers/staging/ccree/cc_hw_queue_defs.h |  590 -------
 drivers/staging/ccree/cc_ivgen.c         |  280 ----
 drivers/staging/ccree/cc_ivgen.h         |   55 -
 drivers/staging/ccree/cc_kernel_regs.h   |  167 --
 drivers/staging/ccree/cc_lli_defs.h      |   59 -
 drivers/staging/ccree/cc_pm.c            |  122 --
 drivers/staging/ccree/cc_pm.h            |   57 -
 drivers/staging/ccree/cc_request_mgr.c   |  713 --------
 drivers/staging/ccree/cc_request_mgr.h   |   51 -
 drivers/staging/ccree/cc_sram_mgr.c      |  107 --
 drivers/staging/ccree/cc_sram_mgr.h      |   65 -
 32 files changed, 11761 deletions(-)
 delete mode 100644 drivers/staging/ccree/Kconfig
 delete mode 100644 drivers/staging/ccree/Makefile
 delete mode 100644 drivers/staging/ccree/TODO
 delete mode 100644 drivers/staging/ccree/cc_aead.c
 delete mode 100644 drivers/staging/ccree/cc_aead.h
 delete mode 100644 drivers/staging/ccree/cc_buffer_mgr.c
 delete mode 100644 drivers/staging/ccree/cc_buffer_mgr.h
 delete mode 100644 drivers/staging/ccree/cc_cipher.c
 delete mode 100644 drivers/staging/ccree/cc_cipher.h
 delete mode 100644 drivers/staging/ccree/cc_crypto_ctx.h
 delete mode 100644 drivers/staging/ccree/cc_debugfs.c
 delete mode 100644 drivers/staging/ccree/cc_debugfs.h
 delete mode 100644 drivers/staging/ccree/cc_driver.c
 delete mode 100644 drivers/staging/ccree/cc_driver.h
 delete mode 100644 drivers/staging/ccree/cc_fips.c
 delete mode 100644 drivers/staging/ccree/cc_fips.h
 delete mode 100644 drivers/staging/ccree/cc_hash.c
 delete mode 100644 drivers/staging/ccree/cc_hash.h
 delete mode 100644 drivers/staging/ccree/cc_host_regs.h
 delete mode 100644 drivers/staging/ccree/cc_hw_queue_defs.h
 delete mode 100644 drivers/staging/ccree/cc_ivgen.c
 delete mode 100644 drivers/staging/ccree/cc_ivgen.h
 delete mode 100644 drivers/staging/ccree/cc_kernel_regs.h
 delete mode 100644 drivers/staging/ccree/cc_lli_defs.h
 delete mode 100644 drivers/staging/ccree/cc_pm.c
 delete mode 100644 drivers/staging/ccree/cc_pm.h
 delete mode 100644 drivers/staging/ccree/cc_request_mgr.c
 delete mode 100644 drivers/staging/ccree/cc_request_mgr.h
 delete mode 100644 drivers/staging/ccree/cc_sram_mgr.c
 delete mode 100644 drivers/staging/ccree/cc_sram_mgr.h

diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
index e95ab68..7802c26 100644
--- a/drivers/staging/Kconfig
+++ b/drivers/staging/Kconfig
@@ -114,8 +114,6 @@ source "drivers/staging/greybus/Kconfig"
 
 source "drivers/staging/vc04_services/Kconfig"
 
-source "drivers/staging/ccree/Kconfig"
-
 source "drivers/staging/typec/Kconfig"
 
 source "drivers/staging/vboxvideo/Kconfig"
diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
index af8cd6a..56afa21 100644
--- a/drivers/staging/Makefile
+++ b/drivers/staging/Makefile
@@ -49,6 +49,5 @@ obj-$(CONFIG_MOST)		+= most/
 obj-$(CONFIG_KS7010)		+= ks7010/
 obj-$(CONFIG_GREYBUS)		+= greybus/
 obj-$(CONFIG_BCM2835_VCHIQ)	+= vc04_services/
-obj-$(CONFIG_CRYPTO_DEV_CCREE)	+= ccree/
 obj-$(CONFIG_DRM_VBOXVIDEO)	+= vboxvideo/
 obj-$(CONFIG_PI433)		+= pi433/
diff --git a/drivers/staging/ccree/Kconfig b/drivers/staging/ccree/Kconfig
deleted file mode 100644
index c94dfe8..0000000
diff --git a/drivers/staging/ccree/Makefile b/drivers/staging/ccree/Makefile
deleted file mode 100644
index bdc2797..0000000
diff --git a/drivers/staging/ccree/TODO b/drivers/staging/ccree/TODO
deleted file mode 100644
index b8e163d..0000000
diff --git a/drivers/staging/ccree/cc_aead.c b/drivers/staging/ccree/cc_aead.c
deleted file mode 100644
index 1a58040..0000000
diff --git a/drivers/staging/ccree/cc_aead.h b/drivers/staging/ccree/cc_aead.h
deleted file mode 100644
index 5edf3b3..0000000
diff --git a/drivers/staging/ccree/cc_buffer_mgr.c b/drivers/staging/ccree/cc_buffer_mgr.c
deleted file mode 100644
index 6dbc9b4..0000000
diff --git a/drivers/staging/ccree/cc_buffer_mgr.h b/drivers/staging/ccree/cc_buffer_mgr.h
deleted file mode 100644
index 99b752a..0000000
diff --git a/drivers/staging/ccree/cc_cipher.c b/drivers/staging/ccree/cc_cipher.c
deleted file mode 100644
index 13a7fc2..0000000
diff --git a/drivers/staging/ccree/cc_cipher.h b/drivers/staging/ccree/cc_cipher.h
deleted file mode 100644
index 4c181c7..0000000
diff --git a/drivers/staging/ccree/cc_crypto_ctx.h b/drivers/staging/ccree/cc_crypto_ctx.h
deleted file mode 100644
index eb16842..0000000
diff --git a/drivers/staging/ccree/cc_debugfs.c b/drivers/staging/ccree/cc_debugfs.c
deleted file mode 100644
index 08f8db4..0000000
diff --git a/drivers/staging/ccree/cc_debugfs.h b/drivers/staging/ccree/cc_debugfs.h
deleted file mode 100644
index 5b5320e..0000000
diff --git a/drivers/staging/ccree/cc_driver.c b/drivers/staging/ccree/cc_driver.c
deleted file mode 100644
index 3a1cb0c..0000000
diff --git a/drivers/staging/ccree/cc_driver.h b/drivers/staging/ccree/cc_driver.h
deleted file mode 100644
index 773ac59..0000000
diff --git a/drivers/staging/ccree/cc_fips.c b/drivers/staging/ccree/cc_fips.c
deleted file mode 100644
index de08af9..0000000
diff --git a/drivers/staging/ccree/cc_fips.h b/drivers/staging/ccree/cc_fips.h
deleted file mode 100644
index 0d52003..0000000
diff --git a/drivers/staging/ccree/cc_hash.c b/drivers/staging/ccree/cc_hash.c
deleted file mode 100644
index 9529f16..0000000
diff --git a/drivers/staging/ccree/cc_hash.h b/drivers/staging/ccree/cc_hash.h
deleted file mode 100644
index aa42b8f..0000000
diff --git a/drivers/staging/ccree/cc_host_regs.h b/drivers/staging/ccree/cc_host_regs.h
deleted file mode 100644
index 69ef2fa..0000000
diff --git a/drivers/staging/ccree/cc_hw_queue_defs.h b/drivers/staging/ccree/cc_hw_queue_defs.h
deleted file mode 100644
index a79f28ce..0000000
diff --git a/drivers/staging/ccree/cc_ivgen.c b/drivers/staging/ccree/cc_ivgen.c
deleted file mode 100644
index c47f419..0000000
diff --git a/drivers/staging/ccree/cc_ivgen.h b/drivers/staging/ccree/cc_ivgen.h
deleted file mode 100644
index b6ac169..0000000
diff --git a/drivers/staging/ccree/cc_kernel_regs.h b/drivers/staging/ccree/cc_kernel_regs.h
deleted file mode 100644
index fa99440..0000000
diff --git a/drivers/staging/ccree/cc_lli_defs.h b/drivers/staging/ccree/cc_lli_defs.h
deleted file mode 100644
index 64b15ac..0000000
diff --git a/drivers/staging/ccree/cc_pm.c b/drivers/staging/ccree/cc_pm.c
deleted file mode 100644
index d990f47..0000000
diff --git a/drivers/staging/ccree/cc_pm.h b/drivers/staging/ccree/cc_pm.h
deleted file mode 100644
index aac8190..0000000
diff --git a/drivers/staging/ccree/cc_request_mgr.c b/drivers/staging/ccree/cc_request_mgr.c
deleted file mode 100644
index 8a7f834..0000000
diff --git a/drivers/staging/ccree/cc_request_mgr.h b/drivers/staging/ccree/cc_request_mgr.h
deleted file mode 100644
index 573cb97..0000000
diff --git a/drivers/staging/ccree/cc_sram_mgr.c b/drivers/staging/ccree/cc_sram_mgr.c
deleted file mode 100644
index d1f8a9c..0000000
diff --git a/drivers/staging/ccree/cc_sram_mgr.h b/drivers/staging/ccree/cc_sram_mgr.h
deleted file mode 100644
index d48649f..0000000
-- 
2.7.4
