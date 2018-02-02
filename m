Return-Path: <arnd@arndb.de>
X-Google-Smtp-Source: AH8x225D7xSbKsRkPHA3J2JetcYq13atZosbFLlxVY1Bie1y9VpyVcmJtrYQ43YRm2YVMzyVrEdW
ARC-Seal: i=1; a=rsa-sha256; t=1517586441; cv=none;
        d=google.com; s=arc-20160816;
        b=IZgS+m0Odakw7cBWq1pB2YR1/G6nj06nWe+y6Rhjlz6kwkXBMoIpDfqLOjtWuO5lvV
         dlrvIv49MwStQ3hplsAGEUxQA85S5s42sKkg0vGi41AOE0QZXl2vxRctxv1vv5ReJ/fD
         aRYGyUBx6ojLGjAb9RG+cIdH+QzZTUh8btehv4VNo1bQakL34xuwxq/WS6JG7PkOSVNE
         C/lI+NeBQmg0KE7zc+ZhVzffjvzbTVCkNMEvsiGNMQAPHAcFXfMpWFD3Ab3t9lgffb92
         eauOIdKIsBaoyANNSeH5O8mJBwdQceAJcWP2G9i6FCWYKcxlZ66JB4CcPVt4WI4tl5Sf
         ocgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=Q7DjYA3e3CjwJf1VpamycqG0KMYW5FaKeHvV4QX2AuU=;
        b=GY4svXPEDcuyyxY9lhoTyxRlJPBm2DA6SlVzyl6V/4Dzijbjs3Z0RbZOT0tDfhA80X
         YwmVDO9guTgwt47ic6Nn2Y5ffqEBFGzmquDr9npBl9S/+K2fOUfYZCTbTga0WTwZV2bK
         RPACfglR1g3qKLg9G8pFJpJvCI741XFfGSnfuS+EhT+cIGk+1RvOA7CdI0HRyHpOJ0mC
         a3azdHFxNd8GLpPUCAeqN2XEnDGUUJqHr7u9SwlcDWRNNr8mUoMqWHKH3CvDVbp8a/L5
         fSPqL35aqZOCqKaML+D1DSYSi+rgPWkKwJQKsZT6PG2tPy1KTFMdhi9BUGFM9tTmzUuU
         7pcw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 212.227.17.10 is neither permitted nor denied by best guess record for domain of arnd@arndb.de) smtp.mailfrom=arnd@arndb.de
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 212.227.17.10 is neither permitted nor denied by best guess record for domain of arnd@arndb.de) smtp.mailfrom=arnd@arndb.de
From: Arnd Bergmann <arnd@arndb.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Nicolas Pitre <nico@linaro.org>,
	Andi Kleen <ak@linux.intel.com>,
	Babu Moger <babu.moger@oracle.com>,
	Will Deacon <will.deacon@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Masahiro Yamada <yamada.masahiro@socionext.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] Kbuild: always define endianess in kconfig.h
Date: Fri,  2 Feb 2018 16:40:45 +0100
Message-Id: <20180202154104.1522809-2-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180202154104.1522809-1-arnd@arndb.de>
References: <20180202154104.1522809-1-arnd@arndb.de>
X-Provags-ID: V03:K0:X/7eTYrqugOU9bM6mqNY6K6nTSV0VVsJLJvlKxDwf/GMH+O5eZM
 uGGA6McIsDzR50W6IlS2105k5VchDJ37lQrR0QThfvlbLZU2QMXBy5P5syD0Ziu22jB4Y9b
 gRYMnhY7IyRgtH3ctscVZNfOgkBwX2oMMv9KwiWTjgZbQI3idtc77ItvM1hTT4h1HtXuh2i
 +RD+MQMLXKpG6Y0Jvea4g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:AaEfF5ptO7I=:sL9RZIYzVZzkBQAwzi31Rx
 K0+9pRlI1WlU4OlMHccl2+QERFMv7kAO1Abbhv/f7t9W7v9Tru/wJ/Nc5xivV7ZUoSXG/wRs3
 kWrQFRJOK6DeEqTiGv70evjH7XQyROFP6bKq+EHxGXCIJ33RoX2Hnwt+ljGO01sEa/7zHrsmC
 TRY8hdsUj39VjSHQnT6GyPxAUGFx1poddXJBQfsE/azBf0y862N/ZOxndEJBkJrz65+fLBcib
 yP21hxe1m4EWypOrI8g2zo/EO9LrZ4q9E90G9u0EaCIznbR/uT7IQ0/SgX8n3ufDhTXGFxvbR
 yHtL4Kgw5maowQ4bN90XYbJCspJ6rQMZaDow29M//HgbPKJ44ywhr01HIGRfTAA8pjVb3Vc++
 BwW831WlX2/waQNx3cSs8rsMKLUOrfSKtGAfZmP26+C998xXN2zWkUAX5B9HYDMOgpLrMvsdi
 OjIp3u3T/4B2pkWhNhb3s6LXxrD+LGIKNJJYIXJdduZ9RFFedtUwSA4bfXmwtWtRypJA+u1si
 t6y1E9DaUtVYrsRA9N54ncgjvbnywZEVKgPmGhr8nfIYKTnQYHBtSli/iCapbyO6cTvxLgJ4b
 ew3BtF3te9gxBx5n7RyqY0d6t0zZRj1Nnj3ZbgXWBgwZCKY4oQDJKoJ6A8l3oN73/CP07Qch+
 ZriSHfm+w7hayt3eK5IoBBbUYtwhiw1aGNUoVjyyiNrSTTNNCvaCpcRIt5iCVrWmehN6ddu9r
 /AY+6HqzafWIhDQXzCat2pIgBk3P1SsqL2usvw==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591304720690698857?=
X-GMAIL-MSGID: =?utf-8?q?1591304720690698857?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Build testing with LTO found a couple of files that get compiled
differently depending on whether asm/byteorder.h gets included early
enough or not. In particular, include/asm-generic/qrwlock_types.h is
affected by this, but there are probably others as well.

The symptom is a series of LTO link time warnings, including these:

net/netlabel/netlabel_unlabeled.h:223: error: type of 'netlbl_unlhsh_add' does not match original declaration [-Werror=lto-type-mismatch]
 int netlbl_unlhsh_add(struct net *net,
net/netlabel/netlabel_unlabeled.c:377: note: 'netlbl_unlhsh_add' was previously declared here

include/net/ipv6.h:360: error: type of 'ipv6_renew_options_kern' does not match original declaration [-Werror=lto-type-mismatch]
 ipv6_renew_options_kern(struct sock *sk,
net/ipv6/exthdrs.c:1162: note: 'ipv6_renew_options_kern' was previously declared here

net/core/dev.c:761: note: 'dev_get_by_name_rcu' was previously declared here
 struct net_device *dev_get_by_name_rcu(struct net *net, const char *name)
net/core/dev.c:761: note: code may be misoptimized unless -fno-strict-aliasing is used

drivers/gpu/drm/i915/i915_drv.h:3377: error: type of 'i915_gem_object_set_to_wc_domain' does not match original declaration [-Werror=lto-type-mismatch]
 i915_gem_object_set_to_wc_domain(struct drm_i915_gem_object *obj, bool write);
drivers/gpu/drm/i915/i915_gem.c:3639: note: 'i915_gem_object_set_to_wc_domain' was previously declared here

include/linux/debugfs.h:92:9: error: type of 'debugfs_attr_read' does not match original declaration [-Werror=lto-type-mismatch]
 ssize_t debugfs_attr_read(struct file *file, char __user *buf,
fs/debugfs/file.c:318: note: 'debugfs_attr_read' was previously declared here

include/linux/rwlock_api_smp.h:30: error: type of '_raw_read_unlock' does not match original declaration [-Werror=lto-type-mismatch]
 void __lockfunc _raw_read_unlock(rwlock_t *lock) __releases(lock);
kernel/locking/spinlock.c:246:26: note: '_raw_read_unlock' was previously declared here

include/linux/fs.h:3308:5: error: type of 'simple_attr_open' does not match original declaration [-Werror=lto-type-mismatch]
 int simple_attr_open(struct inode *inode, struct file *file,
fs/libfs.c:795: note: 'simple_attr_open' was previously declared here

All of the above are caused by include/asm-generic/qrwlock_types.h failing
to include asm/byteorder.h after commit e0d02285f16e ("locking/qrwlock:
Use 'struct qrwlock' instead of 'struct __qrwlock'") in linux-4.15.

Similar bugs may or may not exist in older kernels as well, but there
is no easy way to test those with link-time optimizations, and kernels
before 4.14 are harder to fix because they don't have Babu's patch series

We had similar issues with CONFIG_ symbols in the past and ended up
always including the configuration headers though linux/kconfig.h.
This works around the issue through that same file, defining either
__BIG_ENDIAN or __LITTLE_ENDIAN depending on CONFIG_CPU_BIG_ENDIAN,
which is now always set on all architectures since commit 4c97a0c8fee3
("arch: define CPU_BIG_ENDIAN for all fixed big endian archs").

Cc: stable@vger.kernel.org
Cc: Babu Moger <babu.moger@oracle.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/kconfig.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/kconfig.h b/include/linux/kconfig.h
index fec5076eda91..cc8fa109cfa3 100644
--- a/include/linux/kconfig.h
+++ b/include/linux/kconfig.h
@@ -4,6 +4,12 @@
 
 #include <generated/autoconf.h>
 
+#ifdef CONFIG_CPU_BIG_ENDIAN
+#define __BIG_ENDIAN 4321
+#else
+#define __LITTLE_ENDIAN 1234
+#endif
+
 #define __ARG_PLACEHOLDER_1 0,
 #define __take_second_arg(__ignored, val, ...) val
 
-- 
2.9.0
