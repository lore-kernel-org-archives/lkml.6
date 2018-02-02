Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2656647-1517583807-2-11901124281621411326
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='de', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517583804; b=WfeBA3C1289XWB8n8PZHnnuBsLCL1WM/28FEeRnqtWr1Pia
    6HJpq6mUaI/4gH+Z+qJE9xaMZRrcZ/wV3qBytCc2GGUsNhAit/BLjKm8Fk9BbDvL
    KEduQQ+qPS3e8J0mNL23SVA/yqO7IZvhEtH3M0IYB9U3v/NZHDum8B7M/oj5cCY1
    7U5/0JYfXtnzYw+1BNBUsKCbeZmyNZMSrnSX18bkyKlEwvQirqTXAD3L4Lf5/RsK
    OXqEfDi7ODjh4wis0j8bDHsIT5zhd3Xkxg73q7IKNIjWmJEpCZfJgvKOHoSa46wh
    2Qa8l3TRY58uGF0utgiq4HXJTzoss1lSk9Iqn5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1517583804; bh=a
    rHr1dckc1TTiD4+6JTs8rlFwxzn+p3axIDaDCrlPs4=; b=R4wVGaaMR9u/RHKXk
    uK3FMmGs0y0eVdRRP/N6cYXq/xyrXOUnk3n7j2mZMszEjoLyI1fLJvkb/E+Db6Gx
    6P7/ymmfjmyE4yN4npT6V5TzihPUg0+qsLF7sTcm2iPmwcOXgVcjp4ySMBavPofz
    G9GssPgom7BOx5I3BxXkzlUuoLCDe8m2PAgijRO2nxZ9b5BdUtcMcFyxsOTb5f/q
    RkCWiV/aSSTS2vc8GCPSVGvG4WC2dQxeEfuXerKXMKte3kVcrS3l0zn+ybXrKmNs
    VpOsKW/c2oEZpKNAYn2t/lcWNC4Su5cdca9wAQgTSbCkjeHFECkrK+gk5rSw07Ex
    10wJg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Arnd Bergmann <arnd@arndb.de>
To: Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] staging: vc04_services: merge vchiq_kern_lib.c into
 vchiq_arm.c
Date: Fri,  2 Feb 2018 16:01:46 +0100
Message-Id: <20180202150225.314435-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:wIo8k6i/Z+jxv3SRm9eWD1Aeq2AoJ8o3Az+fTjeq+G3cc0GAixL
 JuYb2rEInkmBR3w1pQixBNH5geGQt700tm4dYr7oB4ZpzVBVOPXsNQ6yLmO8mDzpA9tcqMO
 whEFFds/YNhPie75xpLLR0yj5wE/qoOMFQtUdOEODuEVllBwOfQhb6QHtG7BA+P1k+Kt9TX
 ayxgfic9pkTq4dlsrP1LA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:TkOft8op/SI=:qjaPTkXd5ghxKT7l7IDiB1
 HDnk1J6w2RSKf7eZuFZH4Qsj5Lw8Pu9kMsClADYyZlCtGsHojBxGSZ8xbPNyn9Ikc+NfCvy9C
 r0AodpgGYzxpPsUdRSD+NccH8Ae85RMB1tGGCQCQEhxVfmOZOw5OKSNlvxXUqTTMzmQKij9iy
 7BkgBsY4iDq99q7q3DcnwIfv3oiDmNcJYOFTQzwsLItDmMIdvFuxk0ZXlDtAWJQ2HydILtrD2
 NaD8gXFnzJSGzXqVHEb6ZeviUUuZBKh+uvukCbBV9uv8CP3Q5D9jSAIvgwAUX2XY/i7qWF9Ve
 99HFrdJOmCxoxGcr9BcRSAhr5OHzXvP+Vre3w2xJyavlOQ8LxbnIZEK/bsqVr4K6T88HtEmBj
 HLG8psNQN1YTjVtiBMAhbuQtgXIUR0/MHmN3c7KO5pePLEeAfmylGWfrztRmcBE//lw0+KRXQ
 gyf9hM4cxpdyXo8NiX3bdpUa996q1GeVf8vcULkP9udjUfAHDFuyuqST6o/4J8Un56Iri0ZUK
 qqZ4fFLULADQ+olfBcMYSXWDaILewOwXcGpoXx7ZSFnqk6VZIMVYZjaeCkJO7mVhGiymUItgU
 DRgvU9tsrdiqvZ8RTKz2ZvebpU8tRNlh4aOokXDAigTEZnfPwnOIVyGp4a4drxU6HZKGpMEN9
 +wqVgblhN8jHQLYk3Lryuz2XPpBfLUBxINZCG+9Io15qem365E7KjsDCGOjvA9kU/WoT8F+i8
 HmHagd1E4hlDvp/7B0dsRL1QJkUD6QOao9MRfg==
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
Cc: linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
 Andi Kleen <ak@linux.intel.com>, Mikhail Shvetsov <lameli67@gmail.com>,
 Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@linaro.org>,
 Yamanappagouda Patil <goudapatilk@gmail.com>, linux-kernel@vger.kernel.org,
 Michael Zoran <mzoran@crowfest.net>, linux-rpi-kernel@lists.infradead.org,
 simran singhal <singhalsimran0@gmail.com>,
 Dan Carpenter <dan.carpenter@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

There are two incompatible definitions of 'vchiq_instance_struct', so
passing them through vchiq_initialise(), vchiq_connect() or another
such interface is broken, as shown by building the driver with link-time
optimizations:

drivers/staging/vc04_services/interface/vchiq_arm/vchiq_if.h:129:0: error: type of 'vchiq_initialise' does not match original declaration [-Werror=lto-type-mismatch]
 extern VCHIQ_STATUS_T vchiq_initialise(VCHIQ_INSTANCE_T *pinstance);

drivers/staging/vc04_services/interface/vchiq_arm/vchiq_kern_lib.c:68:0: note: 'vchiq_initialise' was previously declared here
 VCHIQ_STATUS_T vchiq_initialise(VCHIQ_INSTANCE_T *instance_out)

drivers/staging/vc04_services/interface/vchiq_arm/vchiq_kern_lib.c:68:0: note: code may be misoptimized unless -fno-strict-aliasing is used
drivers/staging/vc04_services/interface/vchiq_arm/vchiq_if.h:131:0: error: type of 'vchiq_connect' does not match original declaration [-Werror=lto-type-mismatch]
 extern VCHIQ_STATUS_T vchiq_connect(VCHIQ_INSTANCE_T instance);

drivers/staging/vc04_services/interface/vchiq_arm/vchiq_kern_lib.c:168:0: note: 'vchiq_connect' was previously declared here
 VCHIQ_STATUS_T vchiq_connect(VCHIQ_INSTANCE_T instance)

It's possible that only one of the two sides actually access the members,
but it's clear that they need to agree on the layout. The easiest way
to achieve this appears to be to merge the two files into one. I tried
moving the structure definition into a shared header first, but ended
up running into too many interdependencies that way.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/staging/vc04_services/Makefile             |   1 -
 .../vc04_services/interface/vchiq_arm/vchiq_arm.c  | 369 ++++++++++++++++++
 .../interface/vchiq_arm/vchiq_kern_lib.c           | 431 ---------------------
 3 files changed, 369 insertions(+), 432 deletions(-)
 delete mode 100644 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_kern_lib.c

diff --git a/drivers/staging/vc04_services/Makefile b/drivers/staging/vc04_services/Makefile
index 1ecb261e04ae..fb26b826e640 100644
--- a/drivers/staging/vc04_services/Makefile
+++ b/drivers/staging/vc04_services/Makefile
@@ -4,7 +4,6 @@ obj-$(CONFIG_BCM2835_VCHIQ)	+= vchiq.o
 vchiq-objs := \
    interface/vchiq_arm/vchiq_core.o  \
    interface/vchiq_arm/vchiq_arm.o \
-   interface/vchiq_arm/vchiq_kern_lib.o \
    interface/vchiq_arm/vchiq_2835_arm.o \
    interface/vchiq_arm/vchiq_debugfs.o \
    interface/vchiq_arm/vchiq_shim.o \
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index c2c440009cac..f5cefda49b22 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -193,6 +193,375 @@ static const char *const ioctl_names[] = {
 vchiq_static_assert(ARRAY_SIZE(ioctl_names) ==
 		    (VCHIQ_IOC_MAX + 1));
 
+static VCHIQ_STATUS_T
+vchiq_blocking_bulk_transfer(VCHIQ_SERVICE_HANDLE_T handle, void *data,
+	unsigned int size, VCHIQ_BULK_DIR_T dir);
+
+#define VCHIQ_INIT_RETRIES 10
+VCHIQ_STATUS_T vchiq_initialise(VCHIQ_INSTANCE_T *instance_out)
+{
+	VCHIQ_STATUS_T status = VCHIQ_ERROR;
+	VCHIQ_STATE_T *state;
+	VCHIQ_INSTANCE_T instance = NULL;
+	int i;
+
+	vchiq_log_trace(vchiq_core_log_level, "%s called", __func__);
+
+	/* VideoCore may not be ready due to boot up timing.
+	 * It may never be ready if kernel and firmware are mismatched,so don't
+	 * block forever.
+	 */
+	for (i = 0; i < VCHIQ_INIT_RETRIES; i++) {
+		state = vchiq_get_state();
+		if (state)
+			break;
+		udelay(500);
+	}
+	if (i == VCHIQ_INIT_RETRIES) {
+		vchiq_log_error(vchiq_core_log_level,
+			"%s: videocore not initialized\n", __func__);
+		goto failed;
+	} else if (i > 0) {
+		vchiq_log_warning(vchiq_core_log_level,
+			"%s: videocore initialized after %d retries\n",
+			__func__, i);
+	}
+
+	instance = kzalloc(sizeof(*instance), GFP_KERNEL);
+	if (!instance) {
+		vchiq_log_error(vchiq_core_log_level,
+			"%s: error allocating vchiq instance\n", __func__);
+		goto failed;
+	}
+
+	instance->connected = 0;
+	instance->state = state;
+	mutex_init(&instance->bulk_waiter_list_mutex);
+	INIT_LIST_HEAD(&instance->bulk_waiter_list);
+
+	*instance_out = instance;
+
+	status = VCHIQ_SUCCESS;
+
+failed:
+	vchiq_log_trace(vchiq_core_log_level,
+		"%s(%p): returning %d", __func__, instance, status);
+
+	return status;
+}
+EXPORT_SYMBOL(vchiq_initialise);
+
+VCHIQ_STATUS_T vchiq_shutdown(VCHIQ_INSTANCE_T instance)
+{
+	VCHIQ_STATUS_T status;
+	VCHIQ_STATE_T *state = instance->state;
+
+	vchiq_log_trace(vchiq_core_log_level,
+		"%s(%p) called", __func__, instance);
+
+	if (mutex_lock_killable(&state->mutex) != 0)
+		return VCHIQ_RETRY;
+
+	/* Remove all services */
+	status = vchiq_shutdown_internal(state, instance);
+
+	mutex_unlock(&state->mutex);
+
+	vchiq_log_trace(vchiq_core_log_level,
+		"%s(%p): returning %d", __func__, instance, status);
+
+	if (status == VCHIQ_SUCCESS) {
+		struct list_head *pos, *next;
+
+		list_for_each_safe(pos, next,
+				&instance->bulk_waiter_list) {
+			struct bulk_waiter_node *waiter;
+
+			waiter = list_entry(pos,
+					struct bulk_waiter_node,
+					list);
+			list_del(pos);
+			vchiq_log_info(vchiq_arm_log_level,
+					"bulk_waiter - cleaned up %pK for pid %d",
+					waiter, waiter->pid);
+			kfree(waiter);
+		}
+		kfree(instance);
+	}
+
+	return status;
+}
+EXPORT_SYMBOL(vchiq_shutdown);
+
+static int vchiq_is_connected(VCHIQ_INSTANCE_T instance)
+{
+	return instance->connected;
+}
+
+VCHIQ_STATUS_T vchiq_connect(VCHIQ_INSTANCE_T instance)
+{
+	VCHIQ_STATUS_T status;
+	VCHIQ_STATE_T *state = instance->state;
+
+	vchiq_log_trace(vchiq_core_log_level,
+		"%s(%p) called", __func__, instance);
+
+	if (mutex_lock_killable(&state->mutex) != 0) {
+		vchiq_log_trace(vchiq_core_log_level,
+			"%s: call to mutex_lock failed", __func__);
+		status = VCHIQ_RETRY;
+		goto failed;
+	}
+	status = vchiq_connect_internal(state, instance);
+
+	if (status == VCHIQ_SUCCESS)
+		instance->connected = 1;
+
+	mutex_unlock(&state->mutex);
+
+failed:
+	vchiq_log_trace(vchiq_core_log_level,
+		"%s(%p): returning %d", __func__, instance, status);
+
+	return status;
+}
+EXPORT_SYMBOL(vchiq_connect);
+
+VCHIQ_STATUS_T vchiq_add_service(
+	VCHIQ_INSTANCE_T              instance,
+	const VCHIQ_SERVICE_PARAMS_T *params,
+	VCHIQ_SERVICE_HANDLE_T       *phandle)
+{
+	VCHIQ_STATUS_T status;
+	VCHIQ_STATE_T *state = instance->state;
+	VCHIQ_SERVICE_T *service = NULL;
+	int srvstate;
+
+	vchiq_log_trace(vchiq_core_log_level,
+		"%s(%p) called", __func__, instance);
+
+	*phandle = VCHIQ_SERVICE_HANDLE_INVALID;
+
+	srvstate = vchiq_is_connected(instance)
+		? VCHIQ_SRVSTATE_LISTENING
+		: VCHIQ_SRVSTATE_HIDDEN;
+
+	service = vchiq_add_service_internal(
+		state,
+		params,
+		srvstate,
+		instance,
+		NULL);
+
+	if (service) {
+		*phandle = service->handle;
+		status = VCHIQ_SUCCESS;
+	} else
+		status = VCHIQ_ERROR;
+
+	vchiq_log_trace(vchiq_core_log_level,
+		"%s(%p): returning %d", __func__, instance, status);
+
+	return status;
+}
+EXPORT_SYMBOL(vchiq_add_service);
+
+VCHIQ_STATUS_T vchiq_open_service(
+	VCHIQ_INSTANCE_T              instance,
+	const VCHIQ_SERVICE_PARAMS_T *params,
+	VCHIQ_SERVICE_HANDLE_T       *phandle)
+{
+	VCHIQ_STATUS_T   status = VCHIQ_ERROR;
+	VCHIQ_STATE_T   *state = instance->state;
+	VCHIQ_SERVICE_T *service = NULL;
+
+	vchiq_log_trace(vchiq_core_log_level,
+		"%s(%p) called", __func__, instance);
+
+	*phandle = VCHIQ_SERVICE_HANDLE_INVALID;
+
+	if (!vchiq_is_connected(instance))
+		goto failed;
+
+	service = vchiq_add_service_internal(state,
+		params,
+		VCHIQ_SRVSTATE_OPENING,
+		instance,
+		NULL);
+
+	if (service) {
+		*phandle = service->handle;
+		status = vchiq_open_service_internal(service, current->pid);
+		if (status != VCHIQ_SUCCESS) {
+			vchiq_remove_service(service->handle);
+			*phandle = VCHIQ_SERVICE_HANDLE_INVALID;
+		}
+	}
+
+failed:
+	vchiq_log_trace(vchiq_core_log_level,
+		"%s(%p): returning %d", __func__, instance, status);
+
+	return status;
+}
+EXPORT_SYMBOL(vchiq_open_service);
+
+VCHIQ_STATUS_T
+vchiq_queue_bulk_transmit(VCHIQ_SERVICE_HANDLE_T handle,
+	const void *data, unsigned int size, void *userdata)
+{
+	return vchiq_bulk_transfer(handle,
+		VCHI_MEM_HANDLE_INVALID, (void *)data, size, userdata,
+		VCHIQ_BULK_MODE_CALLBACK, VCHIQ_BULK_TRANSMIT);
+}
+EXPORT_SYMBOL(vchiq_queue_bulk_transmit);
+
+VCHIQ_STATUS_T
+vchiq_queue_bulk_receive(VCHIQ_SERVICE_HANDLE_T handle, void *data,
+	unsigned int size, void *userdata)
+{
+	return vchiq_bulk_transfer(handle,
+		VCHI_MEM_HANDLE_INVALID, data, size, userdata,
+		VCHIQ_BULK_MODE_CALLBACK, VCHIQ_BULK_RECEIVE);
+}
+EXPORT_SYMBOL(vchiq_queue_bulk_receive);
+
+VCHIQ_STATUS_T
+vchiq_bulk_transmit(VCHIQ_SERVICE_HANDLE_T handle, const void *data,
+	unsigned int size, void *userdata, VCHIQ_BULK_MODE_T mode)
+{
+	VCHIQ_STATUS_T status;
+
+	switch (mode) {
+	case VCHIQ_BULK_MODE_NOCALLBACK:
+	case VCHIQ_BULK_MODE_CALLBACK:
+		status = vchiq_bulk_transfer(handle,
+			VCHI_MEM_HANDLE_INVALID, (void *)data, size, userdata,
+			mode, VCHIQ_BULK_TRANSMIT);
+		break;
+	case VCHIQ_BULK_MODE_BLOCKING:
+		status = vchiq_blocking_bulk_transfer(handle,
+			(void *)data, size, VCHIQ_BULK_TRANSMIT);
+		break;
+	default:
+		return VCHIQ_ERROR;
+	}
+
+	return status;
+}
+EXPORT_SYMBOL(vchiq_bulk_transmit);
+
+VCHIQ_STATUS_T
+vchiq_bulk_receive(VCHIQ_SERVICE_HANDLE_T handle, void *data,
+	unsigned int size, void *userdata, VCHIQ_BULK_MODE_T mode)
+{
+	VCHIQ_STATUS_T status;
+
+	switch (mode) {
+	case VCHIQ_BULK_MODE_NOCALLBACK:
+	case VCHIQ_BULK_MODE_CALLBACK:
+		status = vchiq_bulk_transfer(handle,
+			VCHI_MEM_HANDLE_INVALID, data, size, userdata,
+			mode, VCHIQ_BULK_RECEIVE);
+		break;
+	case VCHIQ_BULK_MODE_BLOCKING:
+		status = vchiq_blocking_bulk_transfer(handle,
+			(void *)data, size, VCHIQ_BULK_RECEIVE);
+		break;
+	default:
+		return VCHIQ_ERROR;
+	}
+
+	return status;
+}
+EXPORT_SYMBOL(vchiq_bulk_receive);
+
+static VCHIQ_STATUS_T
+vchiq_blocking_bulk_transfer(VCHIQ_SERVICE_HANDLE_T handle, void *data,
+	unsigned int size, VCHIQ_BULK_DIR_T dir)
+{
+	VCHIQ_INSTANCE_T instance;
+	VCHIQ_SERVICE_T *service;
+	VCHIQ_STATUS_T status;
+	struct bulk_waiter_node *waiter = NULL;
+	struct list_head *pos;
+
+	service = find_service_by_handle(handle);
+	if (!service)
+		return VCHIQ_ERROR;
+
+	instance = service->instance;
+
+	unlock_service(service);
+
+	mutex_lock(&instance->bulk_waiter_list_mutex);
+	list_for_each(pos, &instance->bulk_waiter_list) {
+		if (list_entry(pos, struct bulk_waiter_node,
+				list)->pid == current->pid) {
+			waiter = list_entry(pos,
+				struct bulk_waiter_node,
+				list);
+			list_del(pos);
+			break;
+		}
+	}
+	mutex_unlock(&instance->bulk_waiter_list_mutex);
+
+	if (waiter) {
+		VCHIQ_BULK_T *bulk = waiter->bulk_waiter.bulk;
+
+		if (bulk) {
+			/* This thread has an outstanding bulk transfer. */
+			if ((bulk->data != data) ||
+				(bulk->size != size)) {
+				/* This is not a retry of the previous one.
+				 * Cancel the signal when the transfer
+				 * completes.
+				 */
+				spin_lock(&bulk_waiter_spinlock);
+				bulk->userdata = NULL;
+				spin_unlock(&bulk_waiter_spinlock);
+			}
+		}
+	}
+
+	if (!waiter) {
+		waiter = kzalloc(sizeof(struct bulk_waiter_node), GFP_KERNEL);
+		if (!waiter) {
+			vchiq_log_error(vchiq_core_log_level,
+				"%s - out of memory", __func__);
+			return VCHIQ_ERROR;
+		}
+	}
+
+	status = vchiq_bulk_transfer(handle, VCHI_MEM_HANDLE_INVALID,
+		data, size, &waiter->bulk_waiter, VCHIQ_BULK_MODE_BLOCKING,
+		dir);
+	if ((status != VCHIQ_RETRY) || fatal_signal_pending(current) ||
+		!waiter->bulk_waiter.bulk) {
+		VCHIQ_BULK_T *bulk = waiter->bulk_waiter.bulk;
+
+		if (bulk) {
+			/* Cancel the signal when the transfer
+			 * completes.
+			 */
+			spin_lock(&bulk_waiter_spinlock);
+			bulk->userdata = NULL;
+			spin_unlock(&bulk_waiter_spinlock);
+		}
+		kfree(waiter);
+	} else {
+		waiter->pid = current->pid;
+		mutex_lock(&instance->bulk_waiter_list_mutex);
+		list_add(&waiter->list, &instance->bulk_waiter_list);
+		mutex_unlock(&instance->bulk_waiter_list_mutex);
+		vchiq_log_info(vchiq_arm_log_level,
+				"saved bulk_waiter %pK for pid %d",
+				waiter, current->pid);
+	}
+
+	return status;
+}
 /****************************************************************************
 *
 *   add_completion
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_kern_lib.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_kern_lib.c
deleted file mode 100644
index 43c89a08bda9..000000000000
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_kern_lib.c
+++ /dev/null
@@ -1,431 +0,0 @@
-/**
- * Copyright (c) 2010-2012 Broadcom. All rights reserved.
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions
- * are met:
- * 1. Redistributions of source code must retain the above copyright
- *    notice, this list of conditions, and the following disclaimer,
- *    without modification.
- * 2. Redistributions in binary form must reproduce the above copyright
- *    notice, this list of conditions and the following disclaimer in the
- *    documentation and/or other materials provided with the distribution.
- * 3. The names of the above-listed copyright holders may not be used
- *    to endorse or promote products derived from this software without
- *    specific prior written permission.
- *
- * ALTERNATIVELY, this software may be distributed under the terms of the
- * GNU General Public License ("GPL") version 2, as published by the Free
- * Software Foundation.
- *
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
- * IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
- * THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
- * PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
- * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
- * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
- * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
- * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
- * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
- * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
- * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- */
-
-/* ---- Include Files ---------------------------------------------------- */
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/mutex.h>
-
-#include "vchiq_core.h"
-#include "vchiq_arm.h"
-#include "vchiq_killable.h"
-
-/* ---- Public Variables ------------------------------------------------- */
-
-/* ---- Private Constants and Types -------------------------------------- */
-
-struct bulk_waiter_node {
-	struct bulk_waiter bulk_waiter;
-	int pid;
-	struct list_head list;
-};
-
-struct vchiq_instance_struct {
-	VCHIQ_STATE_T *state;
-
-	int connected;
-
-	struct list_head bulk_waiter_list;
-	struct mutex bulk_waiter_list_mutex;
-};
-
-static VCHIQ_STATUS_T
-vchiq_blocking_bulk_transfer(VCHIQ_SERVICE_HANDLE_T handle, void *data,
-	unsigned int size, VCHIQ_BULK_DIR_T dir);
-
-#define VCHIQ_INIT_RETRIES 10
-VCHIQ_STATUS_T vchiq_initialise(VCHIQ_INSTANCE_T *instance_out)
-{
-	VCHIQ_STATUS_T status = VCHIQ_ERROR;
-	VCHIQ_STATE_T *state;
-	VCHIQ_INSTANCE_T instance = NULL;
-	int i;
-
-	vchiq_log_trace(vchiq_core_log_level, "%s called", __func__);
-
-	/* VideoCore may not be ready due to boot up timing.
-	 * It may never be ready if kernel and firmware are mismatched,so don't
-	 * block forever.
-	 */
-	for (i = 0; i < VCHIQ_INIT_RETRIES; i++) {
-		state = vchiq_get_state();
-		if (state)
-			break;
-		udelay(500);
-	}
-	if (i == VCHIQ_INIT_RETRIES) {
-		vchiq_log_error(vchiq_core_log_level,
-			"%s: videocore not initialized\n", __func__);
-		goto failed;
-	} else if (i > 0) {
-		vchiq_log_warning(vchiq_core_log_level,
-			"%s: videocore initialized after %d retries\n",
-			__func__, i);
-	}
-
-	instance = kzalloc(sizeof(*instance), GFP_KERNEL);
-	if (!instance) {
-		vchiq_log_error(vchiq_core_log_level,
-			"%s: error allocating vchiq instance\n", __func__);
-		goto failed;
-	}
-
-	instance->connected = 0;
-	instance->state = state;
-	mutex_init(&instance->bulk_waiter_list_mutex);
-	INIT_LIST_HEAD(&instance->bulk_waiter_list);
-
-	*instance_out = instance;
-
-	status = VCHIQ_SUCCESS;
-
-failed:
-	vchiq_log_trace(vchiq_core_log_level,
-		"%s(%p): returning %d", __func__, instance, status);
-
-	return status;
-}
-EXPORT_SYMBOL(vchiq_initialise);
-
-VCHIQ_STATUS_T vchiq_shutdown(VCHIQ_INSTANCE_T instance)
-{
-	VCHIQ_STATUS_T status;
-	VCHIQ_STATE_T *state = instance->state;
-
-	vchiq_log_trace(vchiq_core_log_level,
-		"%s(%p) called", __func__, instance);
-
-	if (mutex_lock_killable(&state->mutex) != 0)
-		return VCHIQ_RETRY;
-
-	/* Remove all services */
-	status = vchiq_shutdown_internal(state, instance);
-
-	mutex_unlock(&state->mutex);
-
-	vchiq_log_trace(vchiq_core_log_level,
-		"%s(%p): returning %d", __func__, instance, status);
-
-	if (status == VCHIQ_SUCCESS) {
-		struct list_head *pos, *next;
-
-		list_for_each_safe(pos, next,
-				&instance->bulk_waiter_list) {
-			struct bulk_waiter_node *waiter;
-
-			waiter = list_entry(pos,
-					struct bulk_waiter_node,
-					list);
-			list_del(pos);
-			vchiq_log_info(vchiq_arm_log_level,
-					"bulk_waiter - cleaned up %pK for pid %d",
-					waiter, waiter->pid);
-			kfree(waiter);
-		}
-		kfree(instance);
-	}
-
-	return status;
-}
-EXPORT_SYMBOL(vchiq_shutdown);
-
-static int vchiq_is_connected(VCHIQ_INSTANCE_T instance)
-{
-	return instance->connected;
-}
-
-VCHIQ_STATUS_T vchiq_connect(VCHIQ_INSTANCE_T instance)
-{
-	VCHIQ_STATUS_T status;
-	VCHIQ_STATE_T *state = instance->state;
-
-	vchiq_log_trace(vchiq_core_log_level,
-		"%s(%p) called", __func__, instance);
-
-	if (mutex_lock_killable(&state->mutex) != 0) {
-		vchiq_log_trace(vchiq_core_log_level,
-			"%s: call to mutex_lock failed", __func__);
-		status = VCHIQ_RETRY;
-		goto failed;
-	}
-	status = vchiq_connect_internal(state, instance);
-
-	if (status == VCHIQ_SUCCESS)
-		instance->connected = 1;
-
-	mutex_unlock(&state->mutex);
-
-failed:
-	vchiq_log_trace(vchiq_core_log_level,
-		"%s(%p): returning %d", __func__, instance, status);
-
-	return status;
-}
-EXPORT_SYMBOL(vchiq_connect);
-
-VCHIQ_STATUS_T vchiq_add_service(
-	VCHIQ_INSTANCE_T              instance,
-	const VCHIQ_SERVICE_PARAMS_T *params,
-	VCHIQ_SERVICE_HANDLE_T       *phandle)
-{
-	VCHIQ_STATUS_T status;
-	VCHIQ_STATE_T *state = instance->state;
-	VCHIQ_SERVICE_T *service = NULL;
-	int srvstate;
-
-	vchiq_log_trace(vchiq_core_log_level,
-		"%s(%p) called", __func__, instance);
-
-	*phandle = VCHIQ_SERVICE_HANDLE_INVALID;
-
-	srvstate = vchiq_is_connected(instance)
-		? VCHIQ_SRVSTATE_LISTENING
-		: VCHIQ_SRVSTATE_HIDDEN;
-
-	service = vchiq_add_service_internal(
-		state,
-		params,
-		srvstate,
-		instance,
-		NULL);
-
-	if (service) {
-		*phandle = service->handle;
-		status = VCHIQ_SUCCESS;
-	} else
-		status = VCHIQ_ERROR;
-
-	vchiq_log_trace(vchiq_core_log_level,
-		"%s(%p): returning %d", __func__, instance, status);
-
-	return status;
-}
-EXPORT_SYMBOL(vchiq_add_service);
-
-VCHIQ_STATUS_T vchiq_open_service(
-	VCHIQ_INSTANCE_T              instance,
-	const VCHIQ_SERVICE_PARAMS_T *params,
-	VCHIQ_SERVICE_HANDLE_T       *phandle)
-{
-	VCHIQ_STATUS_T   status = VCHIQ_ERROR;
-	VCHIQ_STATE_T   *state = instance->state;
-	VCHIQ_SERVICE_T *service = NULL;
-
-	vchiq_log_trace(vchiq_core_log_level,
-		"%s(%p) called", __func__, instance);
-
-	*phandle = VCHIQ_SERVICE_HANDLE_INVALID;
-
-	if (!vchiq_is_connected(instance))
-		goto failed;
-
-	service = vchiq_add_service_internal(state,
-		params,
-		VCHIQ_SRVSTATE_OPENING,
-		instance,
-		NULL);
-
-	if (service) {
-		*phandle = service->handle;
-		status = vchiq_open_service_internal(service, current->pid);
-		if (status != VCHIQ_SUCCESS) {
-			vchiq_remove_service(service->handle);
-			*phandle = VCHIQ_SERVICE_HANDLE_INVALID;
-		}
-	}
-
-failed:
-	vchiq_log_trace(vchiq_core_log_level,
-		"%s(%p): returning %d", __func__, instance, status);
-
-	return status;
-}
-EXPORT_SYMBOL(vchiq_open_service);
-
-VCHIQ_STATUS_T
-vchiq_queue_bulk_transmit(VCHIQ_SERVICE_HANDLE_T handle,
-	const void *data, unsigned int size, void *userdata)
-{
-	return vchiq_bulk_transfer(handle,
-		VCHI_MEM_HANDLE_INVALID, (void *)data, size, userdata,
-		VCHIQ_BULK_MODE_CALLBACK, VCHIQ_BULK_TRANSMIT);
-}
-EXPORT_SYMBOL(vchiq_queue_bulk_transmit);
-
-VCHIQ_STATUS_T
-vchiq_queue_bulk_receive(VCHIQ_SERVICE_HANDLE_T handle, void *data,
-	unsigned int size, void *userdata)
-{
-	return vchiq_bulk_transfer(handle,
-		VCHI_MEM_HANDLE_INVALID, data, size, userdata,
-		VCHIQ_BULK_MODE_CALLBACK, VCHIQ_BULK_RECEIVE);
-}
-EXPORT_SYMBOL(vchiq_queue_bulk_receive);
-
-VCHIQ_STATUS_T
-vchiq_bulk_transmit(VCHIQ_SERVICE_HANDLE_T handle, const void *data,
-	unsigned int size, void *userdata, VCHIQ_BULK_MODE_T mode)
-{
-	VCHIQ_STATUS_T status;
-
-	switch (mode) {
-	case VCHIQ_BULK_MODE_NOCALLBACK:
-	case VCHIQ_BULK_MODE_CALLBACK:
-		status = vchiq_bulk_transfer(handle,
-			VCHI_MEM_HANDLE_INVALID, (void *)data, size, userdata,
-			mode, VCHIQ_BULK_TRANSMIT);
-		break;
-	case VCHIQ_BULK_MODE_BLOCKING:
-		status = vchiq_blocking_bulk_transfer(handle,
-			(void *)data, size, VCHIQ_BULK_TRANSMIT);
-		break;
-	default:
-		return VCHIQ_ERROR;
-	}
-
-	return status;
-}
-EXPORT_SYMBOL(vchiq_bulk_transmit);
-
-VCHIQ_STATUS_T
-vchiq_bulk_receive(VCHIQ_SERVICE_HANDLE_T handle, void *data,
-	unsigned int size, void *userdata, VCHIQ_BULK_MODE_T mode)
-{
-	VCHIQ_STATUS_T status;
-
-	switch (mode) {
-	case VCHIQ_BULK_MODE_NOCALLBACK:
-	case VCHIQ_BULK_MODE_CALLBACK:
-		status = vchiq_bulk_transfer(handle,
-			VCHI_MEM_HANDLE_INVALID, data, size, userdata,
-			mode, VCHIQ_BULK_RECEIVE);
-		break;
-	case VCHIQ_BULK_MODE_BLOCKING:
-		status = vchiq_blocking_bulk_transfer(handle,
-			(void *)data, size, VCHIQ_BULK_RECEIVE);
-		break;
-	default:
-		return VCHIQ_ERROR;
-	}
-
-	return status;
-}
-EXPORT_SYMBOL(vchiq_bulk_receive);
-
-static VCHIQ_STATUS_T
-vchiq_blocking_bulk_transfer(VCHIQ_SERVICE_HANDLE_T handle, void *data,
-	unsigned int size, VCHIQ_BULK_DIR_T dir)
-{
-	VCHIQ_INSTANCE_T instance;
-	VCHIQ_SERVICE_T *service;
-	VCHIQ_STATUS_T status;
-	struct bulk_waiter_node *waiter = NULL;
-	struct list_head *pos;
-
-	service = find_service_by_handle(handle);
-	if (!service)
-		return VCHIQ_ERROR;
-
-	instance = service->instance;
-
-	unlock_service(service);
-
-	mutex_lock(&instance->bulk_waiter_list_mutex);
-	list_for_each(pos, &instance->bulk_waiter_list) {
-		if (list_entry(pos, struct bulk_waiter_node,
-				list)->pid == current->pid) {
-			waiter = list_entry(pos,
-				struct bulk_waiter_node,
-				list);
-			list_del(pos);
-			break;
-		}
-	}
-	mutex_unlock(&instance->bulk_waiter_list_mutex);
-
-	if (waiter) {
-		VCHIQ_BULK_T *bulk = waiter->bulk_waiter.bulk;
-
-		if (bulk) {
-			/* This thread has an outstanding bulk transfer. */
-			if ((bulk->data != data) ||
-				(bulk->size != size)) {
-				/* This is not a retry of the previous one.
-				 * Cancel the signal when the transfer
-				 * completes.
-				 */
-				spin_lock(&bulk_waiter_spinlock);
-				bulk->userdata = NULL;
-				spin_unlock(&bulk_waiter_spinlock);
-			}
-		}
-	}
-
-	if (!waiter) {
-		waiter = kzalloc(sizeof(struct bulk_waiter_node), GFP_KERNEL);
-		if (!waiter) {
-			vchiq_log_error(vchiq_core_log_level,
-				"%s - out of memory", __func__);
-			return VCHIQ_ERROR;
-		}
-	}
-
-	status = vchiq_bulk_transfer(handle, VCHI_MEM_HANDLE_INVALID,
-		data, size, &waiter->bulk_waiter, VCHIQ_BULK_MODE_BLOCKING,
-		dir);
-	if ((status != VCHIQ_RETRY) || fatal_signal_pending(current) ||
-		!waiter->bulk_waiter.bulk) {
-		VCHIQ_BULK_T *bulk = waiter->bulk_waiter.bulk;
-
-		if (bulk) {
-			/* Cancel the signal when the transfer
-			 * completes.
-			 */
-			spin_lock(&bulk_waiter_spinlock);
-			bulk->userdata = NULL;
-			spin_unlock(&bulk_waiter_spinlock);
-		}
-		kfree(waiter);
-	} else {
-		waiter->pid = current->pid;
-		mutex_lock(&instance->bulk_waiter_list_mutex);
-		list_add(&waiter->list, &instance->bulk_waiter_list);
-		mutex_unlock(&instance->bulk_waiter_list_mutex);
-		vchiq_log_info(vchiq_arm_log_level,
-				"saved bulk_waiter %pK for pid %d",
-				waiter, current->pid);
-	}
-
-	return status;
-}
-- 
2.9.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
