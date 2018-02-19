Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x225T7kEa7O4yulqn57egFPmB7xvgLiuxzAgwMfb7lHpSybHCujsSwp4NtocjlSbGuT4ySYT1
ARC-Seal: i=1; a=rsa-sha256; t=1519054321; cv=none;
        d=google.com; s=arc-20160816;
        b=JsOGa6m0G1HC3vDsS+tj1DnbzZG38hzyF00RbgXygEyDZxwKHZZwPQVhFYowavsSSo
         YUN5AzmwvqRdYG14S5ZYHz47qM+N1nyXmr1GntRj+Y1DqHRYY4RA37GeJY0GFS1qEnSh
         OeF7XW/ipbrE2ml2JJ+e312cIMImdBbE0doYfgG4op2OKySkqMPa591Z32n7cuab9sap
         IHa59gZDWF20O3p/t4ZRuERT1Uky423yEz20tOa5lQ/6YHP4poGdCESV8rOjM6Cp85jk
         81e7y/BphtzAsOMQYSEg2CJjbNxrUGoX9I54sKwO38dT7RV9iR5aDg/mTSBEUKkWuGFd
         Q4JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:user-agent:in-reply-to
         :content-disposition:mime-version:references:mail-followup-to
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=PBaJNYsQjRnZDT3ZRE1VMndgqtar8tLoKf6CsRx5PJA=;
        b=hu+aUYyWXzzjzQ2PCq27HIfhjJ0M6yAyVI/9ZBCrM0HrHDFZRME1jDCSKX+fm+Nfe5
         RxlztHRJFTN8t4wC0BxMFlGckMmR8UANmSDcJR+v+CHORnCffwx6FOxZQYn4lAx3U53d
         8+xNNUQlScCpDYAYfz5y1XJXDDFGNnxWP8+QotAk/axR0x7IhGy64EzNMaC8T6FHbTdj
         mUpHB1NizI19ZLX/Eh16r0Hnwz4qWAy0o6he4qr8ddEnccbl3oFIPjAWGMwZpmPxeem0
         ybC5tPlkhoANZllMgZTJV1JVnNrUpw+6bA4vouORq+eBjxKqMnXctHeLkDds3uYRA9Ck
         VVfw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@ffwll.ch header.s=google header.b=FxQ106J5;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@ffwll.ch header.s=google header.b=FxQ106J5;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753202AbeBSPbt (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Mon, 19 Feb 2018 10:31:49 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39607 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753200AbeBSPbr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 19 Feb 2018 10:31:47 -0500
Date: Mon, 19 Feb 2018 16:31:43 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Laura Abbott <labbott@redhat.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, devel@driverdev.osuosl.org,
        Todd Kjos <tkjos@android.com>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Liam Mark <lmark@codeaurora.org>,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH 2/2] selftests: ion: Add simple test with the vgem driver
Message-ID: <20180219153143.GS22199@phenom.ffwll.local>
Mail-Followup-To: Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>, devel@driverdev.osuosl.org,
        Todd Kjos <tkjos@android.com>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Liam Mark <lmark@codeaurora.org>,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>
References: <20180216012445.17264-1-labbott@redhat.com>
 <20180216012445.17264-3-labbott@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180216012445.17264-3-labbott@redhat.com>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592518858142172103?=
X-GMAIL-MSGID: =?utf-8?q?1592843904156806511?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 15, 2018 at 05:24:45PM -0800, Laura Abbott wrote:
> Ion is designed to be a framework used by other clients who perform
> operations on the buffer. Use the DRM vgem client as a simple consumer.
> In conjunction with the dma-buf sync ioctls, this tests the full attach/map
> path for the system heap.
> 
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---
>  tools/testing/selftests/android/ion/Makefile      |   3 +-
>  tools/testing/selftests/android/ion/config        |   1 +
>  tools/testing/selftests/android/ion/ionmap_test.c | 136 ++++++++++++++++++++++
>  3 files changed, 139 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/android/ion/ionmap_test.c
> 
> diff --git a/tools/testing/selftests/android/ion/Makefile b/tools/testing/selftests/android/ion/Makefile
> index 96e0c448b39d..d23b6d537d8b 100644
> --- a/tools/testing/selftests/android/ion/Makefile
> +++ b/tools/testing/selftests/android/ion/Makefile
> @@ -2,7 +2,7 @@
>  INCLUDEDIR := -I. -I../../../../../drivers/staging/android/uapi/
>  CFLAGS := $(CFLAGS) $(INCLUDEDIR) -Wall -O2 -g
>  
> -TEST_GEN_FILES := ionapp_export ionapp_import
> +TEST_GEN_FILES := ionapp_export ionapp_import ionmap_test
>  
>  all: $(TEST_GEN_FILES)
>  
> @@ -14,3 +14,4 @@ include ../../lib.mk
>  
>  $(OUTPUT)/ionapp_export: ionapp_export.c ipcsocket.c ionutils.c
>  $(OUTPUT)/ionapp_import: ionapp_import.c ipcsocket.c ionutils.c
> +$(OUTPUT)/ionmap_test: ionmap_test.c ionutils.c
> diff --git a/tools/testing/selftests/android/ion/config b/tools/testing/selftests/android/ion/config
> index 19db6ca9aa2b..b4ad748a9dd9 100644
> --- a/tools/testing/selftests/android/ion/config
> +++ b/tools/testing/selftests/android/ion/config
> @@ -2,3 +2,4 @@ CONFIG_ANDROID=y
>  CONFIG_STAGING=y
>  CONFIG_ION=y
>  CONFIG_ION_SYSTEM_HEAP=y
> +CONFIG_DRM_VGEM=y
> diff --git a/tools/testing/selftests/android/ion/ionmap_test.c b/tools/testing/selftests/android/ion/ionmap_test.c
> new file mode 100644
> index 000000000000..dab36b06b37d
> --- /dev/null
> +++ b/tools/testing/selftests/android/ion/ionmap_test.c
> @@ -0,0 +1,136 @@
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <stdio.h>
> +#include <stdint.h>
> +#include <string.h>
> +#include <unistd.h>
> +
> +#include <sys/ioctl.h>
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +
> +#include <linux/dma-buf.h>
> +
> +#include <drm/drm.h>
> +
> +#include "ion.h"
> +#include "ionutils.h"
> +
> +int check_vgem(int fd)
> +{
> +	drm_version_t version = { 0 };
> +	char name[5];
> +	int ret;
> +
> +	version.name_len = 4;
> +	version.name = name;
> +
> +	ret = ioctl(fd, DRM_IOCTL_VERSION, &version);
> +	if (ret)
> +		return 1;
> +
> +	return strcmp(name, "vgem");
> +}
> +
> +int open_vgem(void)
> +{
> +	int i, fd;
> +	const char *drmstr = "/dev/dri/card";
> +
> +	fd = -1;
> +	for (i = 0; i < 16; i++) {
> +		char name[80];
> +
> +		sprintf(name, "%s%u", drmstr, i);
> +
> +		fd = open(name, O_RDWR);
> +		if (fd < 0)
> +			continue;
> +
> +		if (check_vgem(fd)) {
> +			close(fd);
> +			continue;
> +		} else {
> +			break;
> +		}
> +
> +	}
> +	return fd;
> +}
> +
> +int import_vgem_fd(int vgem_fd, int dma_buf_fd, uint32_t *handle)
> +{
> +	struct drm_prime_handle import_handle = { 0 };
> +	int ret;
> +
> +	import_handle.fd = dma_buf_fd;
> +	import_handle.flags = 0;
> +	import_handle.handle = 0;
> +
> +	ret = ioctl(vgem_fd, DRM_IOCTL_PRIME_FD_TO_HANDLE, &import_handle);
> +	if (ret == 0)
> +		*handle = import_handle.handle;
> +	return ret;
> +}
> +
> +void close_handle(int vgem_fd, uint32_t handle)
> +{
> +	struct drm_gem_close close = { 0 };
> +
> +	close.handle = handle;
> +	ioctl(vgem_fd, DRM_IOCTL_GEM_CLOSE, &close);
> +}
> +
> +int main()
> +{
> +	int ret, vgem_fd;
> +	struct ion_buffer_info info;
> +	uint32_t handle = 0;
> +	struct dma_buf_sync sync = { 0 };
> +
> +	info.heap_type = ION_HEAP_TYPE_SYSTEM;
> +	info.heap_size = 4096;
> +	info.flag_type = ION_FLAG_CACHED;
> +
> +	ret = ion_export_buffer_fd(&info);
> +	if (ret < 0) {
> +		printf("ion buffer alloc failed\n");
> +		return -1;
> +	}
> +
> +	vgem_fd = open_vgem();
> +	if (vgem_fd < 0) {
> +		ret = vgem_fd;
> +		printf("Failed to open vgem\n");
> +		goto out_ion;
> +	}
> +
> +	ret = import_vgem_fd(vgem_fd, info.buffd, &handle);
> +
> +	if (ret < 0) {
> +		printf("Failed to import buffer\n");
> +		goto out_vgem;
> +	}
> +
> +	sync.flags = DMA_BUF_SYNC_START | DMA_BUF_SYNC_RW;
> +	ret = ioctl(info.buffd, DMA_BUF_IOCTL_SYNC, &sync);
> +	if (ret)
> +		printf("sync start failed %d\n", errno);
> +
> +	memset(info.buffer, 0xff, 4096);
> +
> +	sync.flags = DMA_BUF_SYNC_END | DMA_BUF_SYNC_RW;
> +	ret = ioctl(info.buffd, DMA_BUF_IOCTL_SYNC, &sync);
> +	if (ret)
> +		printf("sync end failed %d\n", errno);

At least in drm we require that userspace auto-restarts all ioctls when
they get interrupt. See

https://cgit.freedesktop.org/drm/libdrm/tree/xf86drm.c#n186

not really an issue with vgem (which can't wait for hw or anything else).
But good to make sure we don't spread bad copypastas.

Actual use of the ioctls looks all good. With the drmIoctl wrapper added
and used this is:

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> +
> +	close_handle(vgem_fd, handle);
> +	ret = 0;
> +
> +out_vgem:
> +	close(vgem_fd);
> +out_ion:
> +	ion_close_buffer_fd(&info);
> +	printf("done.\n");
> +	return ret;
> +}
> -- 
> 2.14.3
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
