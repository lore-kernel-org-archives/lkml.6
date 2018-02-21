Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2582833-1519251964-2-11932225163530672430
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519251963; b=kkxylzQm6HKDCxYpGrn/g+mAuVDPN/t4w+DHH3yLguC83mU
    Dd8PYZ9vXoqhc9c4hO0Hk3y6eIHDphggxaX+nliUUxxz0HG8vVwRULLiBiQQhPfV
    EC+bpVLS95w+VlQctKYt7CSU3uodvW8D/wqUieu1w5YTLn4BsnGwsqBVmoKF86IK
    WLzjPpdCZoqO95KjhgnZd93DAH4ZIvZfHbok7bmziQ77620/727wwWaLDFkelK/p
    33xYDh9NmYY9zpMy0SpTw7rVZAWtE321w5OWrR8ymE7gSEe0IhV6LpcKiW4rrfp7
    jHz9EQMBKBURQv3UIMperT2zoF9Yzd/PfN/CxSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1519251963; bh=o
    YSUO48D86+QMmGf86rjKV/mKUNaeECTgw1CRJQlTEQ=; b=DphknXGHlHhQEj09e
    soMRUTwp2rWrb/ScgJCzPUwkFGVmT24QF+ZtDu32HlmRYuxFQw89aZCXmpqIdn6l
    wW49Z7TP8tRS5Zms3nh3Aop4gdWZP+TeJ9wBibobqUMXc2hI2haa4jP2nnQLDa2Q
    LwV3ZhULmZH3P0jVbX6n8I2htoF1BGAvwYTb+xUWfXB+AjHuywUNKiwMsrueEzg2
    to18B3jZdAM25PLfvAZNqgDU+KDioHxXKN+/HaVL4KhueOglYUC61cjXHb1+N5Kv
    H9nx82P+X2ZaO52PyR6qAyEc3h3LUxoCTpR9mFbqtN1k9GqRMAvGKR3FQeXUaBc4
    bkODA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=JYxcPC2h;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=JYxcPC2h;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AH8x227iH8BdkQWqjSdpRhDfSopGnjwmPRsou3gASMrRGIYx+4KNQMSi92aMyN3svawZNx0RUlXFyw==
From: Laura Abbott <labbott@redhat.com>
To: Sumit Semwal <sumit.semwal@linaro.org>,
	Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCHv2 2/2] selftests: ion: Add simple test with the vgem driver
Date: Wed, 21 Feb 2018 14:25:43 -0800
Message-Id: <20180221222543.13633-3-labbott@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180221222543.13633-1-labbott@redhat.com>
References: <20180221222543.13633-1-labbott@redhat.com>
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, Todd Kjos <tkjos@android.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Chris Wilson <chris@chris-wilson.co.uk>, linux-kselftest@vger.kernel.org,
 Shuah Khan <shuah@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Ion is designed to be a framework used by other clients who perform
operations on the buffer. Use the DRM vgem client as a simple consumer.
In conjunction with the dma-buf sync ioctls, this tests the full attach/map
path for the system heap.

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Laura Abbott <labbott@redhat.com>
---
v2: Introduce drmIoctl wrapper per suggestion of Daniel Vetter to better
match how DRM ioctls actually work.
---
 tools/testing/selftests/android/ion/Makefile      |   3 +-
 tools/testing/selftests/android/ion/config        |   1 +
 tools/testing/selftests/android/ion/ionmap_test.c | 149 ++++++++++++++++++++++
 3 files changed, 152 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/android/ion/ionmap_test.c

diff --git a/tools/testing/selftests/android/ion/Makefile b/tools/testing/selftests/android/ion/Makefile
index 96e0c448b39d..d23b6d537d8b 100644
--- a/tools/testing/selftests/android/ion/Makefile
+++ b/tools/testing/selftests/android/ion/Makefile
@@ -2,7 +2,7 @@
 INCLUDEDIR := -I. -I../../../../../drivers/staging/android/uapi/
 CFLAGS := $(CFLAGS) $(INCLUDEDIR) -Wall -O2 -g
 
-TEST_GEN_FILES := ionapp_export ionapp_import
+TEST_GEN_FILES := ionapp_export ionapp_import ionmap_test
 
 all: $(TEST_GEN_FILES)
 
@@ -14,3 +14,4 @@ include ../../lib.mk
 
 $(OUTPUT)/ionapp_export: ionapp_export.c ipcsocket.c ionutils.c
 $(OUTPUT)/ionapp_import: ionapp_import.c ipcsocket.c ionutils.c
+$(OUTPUT)/ionmap_test: ionmap_test.c ionutils.c
diff --git a/tools/testing/selftests/android/ion/config b/tools/testing/selftests/android/ion/config
index 19db6ca9aa2b..b4ad748a9dd9 100644
--- a/tools/testing/selftests/android/ion/config
+++ b/tools/testing/selftests/android/ion/config
@@ -2,3 +2,4 @@ CONFIG_ANDROID=y
 CONFIG_STAGING=y
 CONFIG_ION=y
 CONFIG_ION_SYSTEM_HEAP=y
+CONFIG_DRM_VGEM=y
diff --git a/tools/testing/selftests/android/ion/ionmap_test.c b/tools/testing/selftests/android/ion/ionmap_test.c
new file mode 100644
index 000000000000..58ecdc3511d2
--- /dev/null
+++ b/tools/testing/selftests/android/ion/ionmap_test.c
@@ -0,0 +1,149 @@
+#include <errno.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdint.h>
+#include <string.h>
+#include <unistd.h>
+
+#include <sys/ioctl.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+
+#include <linux/dma-buf.h>
+
+#include <drm/drm.h>
+
+#include "ion.h"
+#include "ionutils.h"
+
+/* Local copy of drmIoctl to match the expected behavior */
+static int drmIoctl(int fd, unsigned long request, void *arg)
+{
+	int ret;
+
+	do {
+		ret = ioctl(fd, request, arg);
+	} while (ret == -1 && (errno == EINTR || errno == EAGAIN));
+}
+
+int check_vgem(int fd)
+{
+	drm_version_t version = { 0 };
+	char name[5];
+	int ret;
+
+	version.name_len = 4;
+	version.name = name;
+
+	ret = drmIoctl(fd, DRM_IOCTL_VERSION, &version);
+	if (ret)
+		return 1;
+
+	return strcmp(name, "vgem");
+}
+
+int open_vgem(void)
+{
+	int i, fd;
+	const char *drmstr = "/dev/dri/card";
+
+	fd = -1;
+	for (i = 0; i < 16; i++) {
+		char name[80];
+
+		sprintf(name, "%s%u", drmstr, i);
+
+		fd = open(name, O_RDWR);
+		if (fd < 0)
+			continue;
+
+		if (check_vgem(fd)) {
+			close(fd);
+			continue;
+		} else {
+			break;
+		}
+
+	}
+	return fd;
+}
+
+int import_vgem_fd(int vgem_fd, int dma_buf_fd, uint32_t *handle)
+{
+	struct drm_prime_handle import_handle = { 0 };
+	int ret;
+
+	import_handle.fd = dma_buf_fd;
+	import_handle.flags = 0;
+	import_handle.handle = 0;
+
+	ret = drmIoctl(vgem_fd, DRM_IOCTL_PRIME_FD_TO_HANDLE, &import_handle);
+	if (ret == 0)
+		*handle = import_handle.handle;
+	return ret;
+}
+
+void close_handle(int vgem_fd, uint32_t handle)
+{
+	struct drm_gem_close close = { 0 };
+
+	close.handle = handle;
+	drmIoctl(vgem_fd, DRM_IOCTL_GEM_CLOSE, &close);
+}
+
+int main()
+{
+	int ret, vgem_fd;
+	struct ion_buffer_info info;
+	uint32_t handle = 0;
+	struct dma_buf_sync sync = { 0 };
+
+	info.heap_type = ION_HEAP_TYPE_SYSTEM;
+	info.heap_size = 4096;
+	info.flag_type = ION_FLAG_CACHED;
+
+	ret = ion_export_buffer_fd(&info);
+	if (ret < 0) {
+		printf("ion buffer alloc failed\n");
+		return -1;
+	}
+
+	vgem_fd = open_vgem();
+	if (vgem_fd < 0) {
+		ret = vgem_fd;
+		printf("Failed to open vgem\n");
+		goto out_ion;
+	}
+
+	ret = import_vgem_fd(vgem_fd, info.buffd, &handle);
+
+	if (ret < 0) {
+		printf("Failed to import buffer\n");
+		goto out_vgem;
+	}
+
+	/*
+	 * While not strictly drm, the drmIoctl properly handles restarting
+	 */
+	sync.flags = DMA_BUF_SYNC_START | DMA_BUF_SYNC_RW;
+	ret = drmIoctl(info.buffd, DMA_BUF_IOCTL_SYNC, &sync);
+	if (ret)
+		printf("sync start failed %d\n", errno);
+
+	memset(info.buffer, 0xff, 4096);
+
+	sync.flags = DMA_BUF_SYNC_END | DMA_BUF_SYNC_RW;
+	ret = drmIoctl(info.buffd, DMA_BUF_IOCTL_SYNC, &sync);
+	if (ret)
+		printf("sync end failed %d\n", errno);
+
+	close_handle(vgem_fd, handle);
+	ret = 0;
+
+out_vgem:
+	close(vgem_fd);
+out_ion:
+	ion_close_buffer_fd(&info);
+	printf("done.\n");
+	return ret;
+}
-- 
2.14.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
