Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3286258-1519664846-2-17173761739144456642
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519664845; b=LR/bsiTaoU/qbmKtVCtTtZTqHARQeFO82eHyAprBd77BEn4
    6qTpHPYtsYIc4YFkisWaIb4+AmJA5bgxZu9KFHV8AYYPNH2DIUNTGoNypWuTTXvT
    9lSXr2O+NWZgM8sF4xbt9GJGyWGFLon7euDAyv4UiDaI0axHziBuG0SlTCTKZssG
    Fo1R9NeqUpHezgvh1fjiTOnm64q/Rk1t8nnB4UrB/ZN1fXZBEms9NqP2pveQMgDR
    OoaoWLMuNbxLSj85PbgCaF8fKgTwHE5EiMNG7ovvvrmXVJvPo25e9w6LsXPKdfqv
    HoKgUvB9uPNjystIHyGWcT8Rpglx7n/DW/rsU+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:reply-to
    :content-type:content-transfer-encoding:sender; s=arctest; t=
    1519664845; bh=YUEEMvA8JFAJHFk2KWs6WyDybHbZ8/rUyVnCMJ6bsNw=; b=C
    BNEn0Wejh3ZNRNGChGAYWiCE5xsxru/awrbLxyRwztGvsVrlOuEM0AMwDTX+5j2w
    32y+fcoy3FE/MkikyoQphnKsGbgK6QCdbCFxVe+WlLM7Rrvxn4fvDBMy4BHm/wo+
    B6Zw3wyfhUyZV6+dkl0Hn4w+jPrgQsO63m0VuEfj6kzpHXDtM7fYijP//n3QFfGl
    xCscDv9laZ1OxQSAy4vz7Jox39Np/sBBQ25aUtAEx1JvYL2/X15vPn9Kp+cJvsmJ
    0ExqpDBkKbPVgBU/KN9MpH1zbz6nZmKHKmT+Tak+ocjiyRunchrNdY7wLN9OgtU6
    6FmnQgIgB4nA4RzWV44rw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Subject: Re: [PATCH 2/2] selftests: ion: Add simple test with the vgem driver
To: Laura Abbott <labbott@redhat.com>, Sumit Semwal
 <sumit.semwal@linaro.org>, devel@driverdev.osuosl.org,
 Todd Kjos <tkjos@android.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Liam Mark <lmark@codeaurora.org>,
 linux-kselftest@vger.kernel.org, Shuah Khan <shuahkh@osg.samsung.com>,
 Shuah Khan <shuah@kernel.org>
References: <20180216012445.17264-1-labbott@redhat.com>
 <20180216012445.17264-3-labbott@redhat.com>
 <20180219153143.GS22199@phenom.ffwll.local>
 <feb5e4c5-b5c2-e235-c952-70c38e185080@redhat.com>
 <20180219183333.GD22199@phenom.ffwll.local>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <c16895d9-7285-b997-de68-19f9f09613db@kernel.org>
Date: Mon, 26 Feb 2018 10:07:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180219183333.GD22199@phenom.ffwll.local>
Content-Language: en-US
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
Reply-To: shuah@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/19/2018 11:33 AM, Daniel Vetter wrote:
> On Mon, Feb 19, 2018 at 10:18:21AM -0800, Laura Abbott wrote:
>> On 02/19/2018 07:31 AM, Daniel Vetter wrote:
>>> On Thu, Feb 15, 2018 at 05:24:45PM -0800, Laura Abbott wrote:
>>>> Ion is designed to be a framework used by other clients who perform
>>>> operations on the buffer. Use the DRM vgem client as a simple consumer.
>>>> In conjunction with the dma-buf sync ioctls, this tests the full attach/map
>>>> path for the system heap.
>>>>
>>>> Signed-off-by: Laura Abbott <labbott@redhat.com>
>>>> ---
>>>>   tools/testing/selftests/android/ion/Makefile      |   3 +-
>>>>   tools/testing/selftests/android/ion/config        |   1 +
>>>>   tools/testing/selftests/android/ion/ionmap_test.c | 136 ++++++++++++++++++++++
>>>>   3 files changed, 139 insertions(+), 1 deletion(-)
>>>>   create mode 100644 tools/testing/selftests/android/ion/ionmap_test.c
>>>>
>>>> diff --git a/tools/testing/selftests/android/ion/Makefile b/tools/testing/selftests/android/ion/Makefile
>>>> index 96e0c448b39d..d23b6d537d8b 100644
>>>> --- a/tools/testing/selftests/android/ion/Makefile
>>>> +++ b/tools/testing/selftests/android/ion/Makefile
>>>> @@ -2,7 +2,7 @@
>>>>   INCLUDEDIR := -I. -I../../../../../drivers/staging/android/uapi/
>>>>   CFLAGS := $(CFLAGS) $(INCLUDEDIR) -Wall -O2 -g
>>>> -TEST_GEN_FILES := ionapp_export ionapp_import
>>>> +TEST_GEN_FILES := ionapp_export ionapp_import ionmap_test
>>>>   all: $(TEST_GEN_FILES)
>>>> @@ -14,3 +14,4 @@ include ../../lib.mk
>>>>   $(OUTPUT)/ionapp_export: ionapp_export.c ipcsocket.c ionutils.c
>>>>   $(OUTPUT)/ionapp_import: ionapp_import.c ipcsocket.c ionutils.c
>>>> +$(OUTPUT)/ionmap_test: ionmap_test.c ionutils.c
>>>> diff --git a/tools/testing/selftests/android/ion/config b/tools/testing/selftests/android/ion/config
>>>> index 19db6ca9aa2b..b4ad748a9dd9 100644
>>>> --- a/tools/testing/selftests/android/ion/config
>>>> +++ b/tools/testing/selftests/android/ion/config
>>>> @@ -2,3 +2,4 @@ CONFIG_ANDROID=y
>>>>   CONFIG_STAGING=y
>>>>   CONFIG_ION=y
>>>>   CONFIG_ION_SYSTEM_HEAP=y
>>>> +CONFIG_DRM_VGEM=y
>>>> diff --git a/tools/testing/selftests/android/ion/ionmap_test.c b/tools/testing/selftests/android/ion/ionmap_test.c
>>>> new file mode 100644
>>>> index 000000000000..dab36b06b37d
>>>> --- /dev/null
>>>> +++ b/tools/testing/selftests/android/ion/ionmap_test.c
>>>> @@ -0,0 +1,136 @@
>>>> +#include <errno.h>
>>>> +#include <fcntl.h>
>>>> +#include <stdio.h>
>>>> +#include <stdint.h>
>>>> +#include <string.h>
>>>> +#include <unistd.h>
>>>> +
>>>> +#include <sys/ioctl.h>
>>>> +#include <sys/types.h>
>>>> +#include <sys/stat.h>
>>>> +
>>>> +#include <linux/dma-buf.h>
>>>> +
>>>> +#include <drm/drm.h>
>>>> +
>>>> +#include "ion.h"
>>>> +#include "ionutils.h"
>>>> +
>>>> +int check_vgem(int fd)
>>>> +{
>>>> +	drm_version_t version = { 0 };
>>>> +	char name[5];
>>>> +	int ret;
>>>> +
>>>> +	version.name_len = 4;
>>>> +	version.name = name;
>>>> +
>>>> +	ret = ioctl(fd, DRM_IOCTL_VERSION, &version);
>>>> +	if (ret)
>>>> +		return 1;
>>>> +
>>>> +	return strcmp(name, "vgem");
>>>> +}
>>>> +
>>>> +int open_vgem(void)
>>>> +{
>>>> +	int i, fd;
>>>> +	const char *drmstr = "/dev/dri/card";
>>>> +
>>>> +	fd = -1;
>>>> +	for (i = 0; i < 16; i++) {
>>>> +		char name[80];
>>>> +
>>>> +		sprintf(name, "%s%u", drmstr, i);
>>>> +
>>>> +		fd = open(name, O_RDWR);
>>>> +		if (fd < 0)
>>>> +			continue;
>>>> +
>>>> +		if (check_vgem(fd)) {
>>>> +			close(fd);
>>>> +			continue;
>>>> +		} else {
>>>> +			break;
>>>> +		}
>>>> +
>>>> +	}
>>>> +	return fd;
>>>> +}
>>>> +
>>>> +int import_vgem_fd(int vgem_fd, int dma_buf_fd, uint32_t *handle)
>>>> +{
>>>> +	struct drm_prime_handle import_handle = { 0 };
>>>> +	int ret;
>>>> +
>>>> +	import_handle.fd = dma_buf_fd;
>>>> +	import_handle.flags = 0;
>>>> +	import_handle.handle = 0;
>>>> +
>>>> +	ret = ioctl(vgem_fd, DRM_IOCTL_PRIME_FD_TO_HANDLE, &import_handle);
>>>> +	if (ret == 0)
>>>> +		*handle = import_handle.handle;
>>>> +	return ret;
>>>> +}
>>>> +
>>>> +void close_handle(int vgem_fd, uint32_t handle)
>>>> +{
>>>> +	struct drm_gem_close close = { 0 };
>>>> +
>>>> +	close.handle = handle;
>>>> +	ioctl(vgem_fd, DRM_IOCTL_GEM_CLOSE, &close);
>>>> +}
>>>> +
>>>> +int main()
>>>> +{
>>>> +	int ret, vgem_fd;
>>>> +	struct ion_buffer_info info;
>>>> +	uint32_t handle = 0;
>>>> +	struct dma_buf_sync sync = { 0 };
>>>> +
>>>> +	info.heap_type = ION_HEAP_TYPE_SYSTEM;
>>>> +	info.heap_size = 4096;
>>>> +	info.flag_type = ION_FLAG_CACHED;
>>>> +
>>>> +	ret = ion_export_buffer_fd(&info);
>>>> +	if (ret < 0) {
>>>> +		printf("ion buffer alloc failed\n");
>>>> +		return -1;
>>>> +	}
>>>> +
>>>> +	vgem_fd = open_vgem();
>>>> +	if (vgem_fd < 0) {
>>>> +		ret = vgem_fd;
>>>> +		printf("Failed to open vgem\n");
>>>> +		goto out_ion;
>>>> +	}
>>>> +
>>>> +	ret = import_vgem_fd(vgem_fd, info.buffd, &handle);
>>>> +
>>>> +	if (ret < 0) {
>>>> +		printf("Failed to import buffer\n");
>>>> +		goto out_vgem;
>>>> +	}
>>>> +
>>>> +	sync.flags = DMA_BUF_SYNC_START | DMA_BUF_SYNC_RW;
>>>> +	ret = ioctl(info.buffd, DMA_BUF_IOCTL_SYNC, &sync);
>>>> +	if (ret)
>>>> +		printf("sync start failed %d\n", errno);
>>>> +
>>>> +	memset(info.buffer, 0xff, 4096);
>>>> +
>>>> +	sync.flags = DMA_BUF_SYNC_END | DMA_BUF_SYNC_RW;
>>>> +	ret = ioctl(info.buffd, DMA_BUF_IOCTL_SYNC, &sync);
>>>> +	if (ret)
>>>> +		printf("sync end failed %d\n", errno);
>>>
>>> At least in drm we require that userspace auto-restarts all ioctls when
>>> they get interrupt. See
>>>
>>> https://cgit.freedesktop.org/drm/libdrm/tree/xf86drm.c#n186
>>>
>>> not really an issue with vgem (which can't wait for hw or anything else).
>>> But good to make sure we don't spread bad copypastas.
>>>
>>> Actual use of the ioctls looks all good. With the drmIoctl wrapper added
>>> and used this is:
>>>
>>> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>>
>> Thanks for the review. The reason I didn't use the standard drmIoctl was
>> because I didn't want to introduce a dependency on libdrm. I don't see
>> an example of another selftest having a dependency on an external
>> library.
>>
>> Is adding a dependencies on fairly standard but still external userspace
>> libraries okay for kernel self tests?

We have cases where external libraries are used. fuse test probably is one
example.

> 
> Yeah adding a dependency isn't good, I'd just copypaste a local static
> version into the test file. That's good enough, the point isn't to use the
> libdrm one, but a wrapper that automatically restarts (every other
> userspace for gfx has their own copy of it since it's so trivial).

Let's go ahead and use libdrm - It is important to keep them in sync. Maybe
we can check dependency in the ion Makefile and not compile the test. As long
as the rest of the tests run even when libdrm dependency isn't met, we should
be good.

thanks,
-- Shuah


_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
