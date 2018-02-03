Return-Path: <stefan.wahren@i2se.com>
X-Google-Smtp-Source: AH8x22560dm0omH5EIOg+ujVYs1ZDmk9hqVefMMl3f+RV9axpijaakiFR4LCZgK43XW+H0Kq3wpV
ARC-Seal: i=1; a=rsa-sha256; t=1517654888; cv=none;
        d=google.com; s=arc-20160816;
        b=gjjO4YJwOhOegMQVnjt6ZtdyODQhdVIEC3o/qsx16ez9oVr74Sdrch5munqVoPBcQ/
         jfh0kIv1USD3TYGNzt8lkTKExrgvJVM1zOuzSJStQSz6LsyqImSZJ4v3zDY3TG+suFry
         CAUnPleij8fYpMuL+RQLFO2fj90vks4BhuEQ8kNBexLdcI18KSl7Vzx10CrH4d+jeEd0
         4BJXgnaV6gOWHgU9mmP2YonfYJVOVp92owPFJPB2VNoXbeg+SqnmllqBcq/NoukK4o+v
         dn9Vd8Tch9E1Ynp1Y8VbcLA0Tr8yIlZVwpwph/x+4JzoH/RNpkBU/pnQiJ8ICXZH4HSU
         VRNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=importance:content-transfer-encoding:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date
         :arc-authentication-results;
        bh=hcQ3t4gJ0MKd9qJ7ffMCOarzJ7FfzXWBbqVBlMIhnIk=;
        b=OaujMaw9qpKh3t4MWWD10cCF0pRXPhklZMZ/hDPq+FSR+36uChLRsf3hbuLWX0qZnU
         D3O2r9g1SzIzumkV4C6m7Yp/dbptwIomNBWgcW4kDeQWulkA+otX4/mkwUFwLmQkmZhq
         5+98iUyTLwD3JlZu6QZ6b7J6vKC8jTv+EBwsp/n8/5GbJrANDG7bZxaz7525d93AGzeu
         95yOBi5yV9IeEBuYCG6RLJPJ1BjV5PEgUdKf0/41hcCHx5e54lKUue/R9hifAzCGtNad
         /B3YMRgtsXb9Qja1R1g8wLESc7lp9OYp5mS2FnkK2jYgGydlX17QPSPA1l/MsHXaRmi2
         wtMw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 212.227.126.130 is neither permitted nor denied by best guess record for domain of stefan.wahren@i2se.com) smtp.mailfrom=stefan.wahren@i2se.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 212.227.126.130 is neither permitted nor denied by best guess record for domain of stefan.wahren@i2se.com) smtp.mailfrom=stefan.wahren@i2se.com
Date: Sat, 3 Feb 2018 11:48:01 +0100 (CET)
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Eric Anholt <eric@anholt.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>, Phil Elwell <phil@raspberrypi.org>
Cc: linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Message-ID: <618573530.47611.1517654881535@email.1und1.de>
In-Reply-To: <20180202150225.314435-1-arnd@arndb.de>
References: <20180202150225.314435-1-arnd@arndb.de>
Subject: Re: [PATCH] staging: vc04_services: merge vchiq_kern_lib.c into
 vchiq_arm.c
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev21
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K0:+rHWqa3Hd4IezXKxtPD2Ho9ibvhOT+kZAmi2rxoj50mWGodCEEl
 2UKUE+v19cOal8XF05jKiuwFcf1YmghC/pdMi4jEZPZ/RbGSJs8TH6hrVTXXUdmYBIpTSLU
 7PsDzqzztFNPdhOd9qMX7KNSfn/8jx5sr6XKC2/EBAya46Z0qVeuhy3d5MX4u3XmwNvOOZu
 P7dOxw6MGkkHsYJqMWQwA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/R9E/j6CoGQ=:RRpBsYiEKyIRXFx1RTR1GO
 fVT7W1z0eWl64GpaO+3CpojnY7tl7+vxK5RmNm+NvkZ8IQJMcdyMjCp99GrwFoNvX3EdJKgzr
 Z9/x4CWzqAgiSnKsDiQ1F16vLkaHuLm9Ri7iZ9w/PdVMqFDqFhCiQA0nPrbJRUiYzmt21sDfk
 HYzNAzUqpnqVlGpMyeRlZOUKak8q22WTb+bbOsjl2YaMF22CetztjvwGTrYEsE9tmqalKtzvB
 P8G3Y/5RVAa0/fB+cI/opTEBbvIWV2XB8vV5KIv+i9lnxFHD6hgT7A4seCetF66RziD2jW0VU
 sQoJmdoDCAVqbMoqokMSrqXjn8v/xchTtzNRc9i5QFl6NG4vxsbrjmn9or+jkXP6m9Ux7ZZKb
 T/XjcsLjGm3d6n9AFCMA8DrIbfTidpETCqp1hW8C9MxCd2ClIF54nv+HK6h1ySIAk8GENgiKh
 n3UjOY09WJuY8KbElg3XlrviYEg3d2ehMbnM+FE5feCfAlP2AxQXoeFNarLqV9sjJQVggjv9T
 1YXz8gr/mZgTpLiiSVkCr/stcd4rNvfUjXFQOmkM+RAOd2d77g2vMB8bORnEvEKBte+UyDkjO
 Gc7sJHhteDqff1/Sa/8vlEbgBLZkyroQMBImbbvWDpaoywu7nYAiObfqIxi+myw3P/g4vqrzP
 rnPh33iFJ/Uw5ytAlzOrspIQejDcnymZYFuH5Rxz/N5HBQXbLnNWDcPAgdSVIoHK0Z426fhY+
 aLso5ppNrPGdTWBRiEHfQuSIp+aowy19EbvoEaAgXJuMbAVUTFHJDxVo3HI=
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591301905554073062?=
X-GMAIL-MSGID: =?utf-8?q?1591376492197661707?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

[add Phil]

> Arnd Bergmann <arnd@arndb.de> hat am 2. Februar 2018 um 16:01 geschrieben:
> 
> 
> There are two incompatible definitions of 'vchiq_instance_struct', so
> passing them through vchiq_initialise(), vchiq_connect() or another
> such interface is broken, as shown by building the driver with link-time
> optimizations:
> 
> drivers/staging/vc04_services/interface/vchiq_arm/vchiq_if.h:129:0: error: type of 'vchiq_initialise' does not match original declaration [-Werror=lto-type-mismatch]
>  extern VCHIQ_STATUS_T vchiq_initialise(VCHIQ_INSTANCE_T *pinstance);
> 
> drivers/staging/vc04_services/interface/vchiq_arm/vchiq_kern_lib.c:68:0: note: 'vchiq_initialise' was previously declared here
>  VCHIQ_STATUS_T vchiq_initialise(VCHIQ_INSTANCE_T *instance_out)
> 
> drivers/staging/vc04_services/interface/vchiq_arm/vchiq_kern_lib.c:68:0: note: code may be misoptimized unless -fno-strict-aliasing is used
> drivers/staging/vc04_services/interface/vchiq_arm/vchiq_if.h:131:0: error: type of 'vchiq_connect' does not match original declaration [-Werror=lto-type-mismatch]
>  extern VCHIQ_STATUS_T vchiq_connect(VCHIQ_INSTANCE_T instance);
> 
> drivers/staging/vc04_services/interface/vchiq_arm/vchiq_kern_lib.c:168:0: note: 'vchiq_connect' was previously declared here
>  VCHIQ_STATUS_T vchiq_connect(VCHIQ_INSTANCE_T instance)
> 
> It's possible that only one of the two sides actually access the members,
> but it's clear that they need to agree on the layout. The easiest way
> to achieve this appears to be to merge the two files into one. I tried
> moving the structure definition into a shared header first, but ended
> up running into too many interdependencies that way.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/staging/vc04_services/Makefile             |   1 -
>  .../vc04_services/interface/vchiq_arm/vchiq_arm.c  | 369 ++++++++++++++++++
>  .../interface/vchiq_arm/vchiq_kern_lib.c           | 431 ---------------------
>  3 files changed, 369 insertions(+), 432 deletions(-)
>  delete mode 100644 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_kern_lib.c
> 
> diff --git a/drivers/staging/vc04_services/Makefile b/drivers/staging/vc04_services/Makefile
> index 1ecb261e04ae..fb26b826e640 100644
> --- a/drivers/staging/vc04_services/Makefile
> +++ b/drivers/staging/vc04_services/Makefile
> @@ -4,7 +4,6 @@ obj-$(CONFIG_BCM2835_VCHIQ)	+= vchiq.o
>  vchiq-objs := \
>     interface/vchiq_arm/vchiq_core.o  \
>     interface/vchiq_arm/vchiq_arm.o \
> -   interface/vchiq_arm/vchiq_kern_lib.o \
>     interface/vchiq_arm/vchiq_2835_arm.o \
>     interface/vchiq_arm/vchiq_debugfs.o \
>     interface/vchiq_arm/vchiq_shim.o \
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> index c2c440009cac..f5cefda49b22 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> @@ -193,6 +193,375 @@ static const char *const ioctl_names[] = {
>  vchiq_static_assert(ARRAY_SIZE(ioctl_names) ==
>  		    (VCHIQ_IOC_MAX + 1));
>  
> +static VCHIQ_STATUS_T
> +vchiq_blocking_bulk_transfer(VCHIQ_SERVICE_HANDLE_T handle, void *data,
> +	unsigned int size, VCHIQ_BULK_DIR_T dir);
> +
> +#define VCHIQ_INIT_RETRIES 10
> +VCHIQ_STATUS_T vchiq_initialise(VCHIQ_INSTANCE_T *instance_out)
> +{
> +	VCHIQ_STATUS_T status = VCHIQ_ERROR;
> +	VCHIQ_STATE_T *state;
> +	VCHIQ_INSTANCE_T instance = NULL;
> +	int i;
> +
> +	vchiq_log_trace(vchiq_core_log_level, "%s called", __func__);
> +
> +	/* VideoCore may not be ready due to boot up timing.
> +	 * It may never be ready if kernel and firmware are mismatched,so don't
> +	 * block forever.
> +	 */
> +	for (i = 0; i < VCHIQ_INIT_RETRIES; i++) {
> +		state = vchiq_get_state();
> +		if (state)
> +			break;
> +		udelay(500);
> +	}
> +	if (i == VCHIQ_INIT_RETRIES) {
> +		vchiq_log_error(vchiq_core_log_level,
> +			"%s: videocore not initialized\n", __func__);
> +		goto failed;
> +	} else if (i > 0) {
> +		vchiq_log_warning(vchiq_core_log_level,
> +			"%s: videocore initialized after %d retries\n",
> +			__func__, i);
> +	}
> +
> +	instance = kzalloc(sizeof(*instance), GFP_KERNEL);
> +	if (!instance) {
> +		vchiq_log_error(vchiq_core_log_level,
> +			"%s: error allocating vchiq instance\n", __func__);
> +		goto failed;
> +	}
> +
> +	instance->connected = 0;
> +	instance->state = state;
> +	mutex_init(&instance->bulk_waiter_list_mutex);
> +	INIT_LIST_HEAD(&instance->bulk_waiter_list);
> +
> +	*instance_out = instance;
> +
> +	status = VCHIQ_SUCCESS;
> +
> +failed:
> +	vchiq_log_trace(vchiq_core_log_level,
> +		"%s(%p): returning %d", __func__, instance, status);
> +
> +	return status;
> +}
> +EXPORT_SYMBOL(vchiq_initialise);
> +
> +VCHIQ_STATUS_T vchiq_shutdown(VCHIQ_INSTANCE_T instance)
> +{
> +	VCHIQ_STATUS_T status;
> +	VCHIQ_STATE_T *state = instance->state;
> +
> +	vchiq_log_trace(vchiq_core_log_level,
> +		"%s(%p) called", __func__, instance);
> +
> +	if (mutex_lock_killable(&state->mutex) != 0)
> +		return VCHIQ_RETRY;
> +
> +	/* Remove all services */
> +	status = vchiq_shutdown_internal(state, instance);
> +
> +	mutex_unlock(&state->mutex);
> +
> +	vchiq_log_trace(vchiq_core_log_level,
> +		"%s(%p): returning %d", __func__, instance, status);
> +
> +	if (status == VCHIQ_SUCCESS) {
> +		struct list_head *pos, *next;
> +
> +		list_for_each_safe(pos, next,
> +				&instance->bulk_waiter_list) {
> +			struct bulk_waiter_node *waiter;
> +
> +			waiter = list_entry(pos,
> +					struct bulk_waiter_node,
> +					list);
> +			list_del(pos);
> +			vchiq_log_info(vchiq_arm_log_level,
> +					"bulk_waiter - cleaned up %pK for pid %d",
> +					waiter, waiter->pid);
> +			kfree(waiter);
> +		}
> +		kfree(instance);
> +	}
> +
> +	return status;
> +}
> +EXPORT_SYMBOL(vchiq_shutdown);
> +
> +static int vchiq_is_connected(VCHIQ_INSTANCE_T instance)
> +{
> +	return instance->connected;
> +}
> +
> +VCHIQ_STATUS_T vchiq_connect(VCHIQ_INSTANCE_T instance)
> +{
> +	VCHIQ_STATUS_T status;
> +	VCHIQ_STATE_T *state = instance->state;
> +
> +	vchiq_log_trace(vchiq_core_log_level,
> +		"%s(%p) called", __func__, instance);
> +
> +	if (mutex_lock_killable(&state->mutex) != 0) {
> +		vchiq_log_trace(vchiq_core_log_level,
> +			"%s: call to mutex_lock failed", __func__);
> +		status = VCHIQ_RETRY;
> +		goto failed;
> +	}
> +	status = vchiq_connect_internal(state, instance);
> +
> +	if (status == VCHIQ_SUCCESS)
> +		instance->connected = 1;
> +
> +	mutex_unlock(&state->mutex);
> +
> +failed:
> +	vchiq_log_trace(vchiq_core_log_level,
> +		"%s(%p): returning %d", __func__, instance, status);
> +
> +	return status;
> +}
> +EXPORT_SYMBOL(vchiq_connect);
> +
> +VCHIQ_STATUS_T vchiq_add_service(
> +	VCHIQ_INSTANCE_T              instance,
> +	const VCHIQ_SERVICE_PARAMS_T *params,
> +	VCHIQ_SERVICE_HANDLE_T       *phandle)
> +{
> +	VCHIQ_STATUS_T status;
> +	VCHIQ_STATE_T *state = instance->state;
> +	VCHIQ_SERVICE_T *service = NULL;
> +	int srvstate;
> +
> +	vchiq_log_trace(vchiq_core_log_level,
> +		"%s(%p) called", __func__, instance);
> +
> +	*phandle = VCHIQ_SERVICE_HANDLE_INVALID;
> +
> +	srvstate = vchiq_is_connected(instance)
> +		? VCHIQ_SRVSTATE_LISTENING
> +		: VCHIQ_SRVSTATE_HIDDEN;
> +
> +	service = vchiq_add_service_internal(
> +		state,
> +		params,
> +		srvstate,
> +		instance,
> +		NULL);
> +
> +	if (service) {
> +		*phandle = service->handle;
> +		status = VCHIQ_SUCCESS;
> +	} else
> +		status = VCHIQ_ERROR;
> +
> +	vchiq_log_trace(vchiq_core_log_level,
> +		"%s(%p): returning %d", __func__, instance, status);
> +
> +	return status;
> +}
> +EXPORT_SYMBOL(vchiq_add_service);
> +
> +VCHIQ_STATUS_T vchiq_open_service(
> +	VCHIQ_INSTANCE_T              instance,
> +	const VCHIQ_SERVICE_PARAMS_T *params,
> +	VCHIQ_SERVICE_HANDLE_T       *phandle)
> +{
> +	VCHIQ_STATUS_T   status = VCHIQ_ERROR;
> +	VCHIQ_STATE_T   *state = instance->state;
> +	VCHIQ_SERVICE_T *service = NULL;
> +
> +	vchiq_log_trace(vchiq_core_log_level,
> +		"%s(%p) called", __func__, instance);
> +
> +	*phandle = VCHIQ_SERVICE_HANDLE_INVALID;
> +
> +	if (!vchiq_is_connected(instance))
> +		goto failed;
> +
> +	service = vchiq_add_service_internal(state,
> +		params,
> +		VCHIQ_SRVSTATE_OPENING,
> +		instance,
> +		NULL);
> +
> +	if (service) {
> +		*phandle = service->handle;
> +		status = vchiq_open_service_internal(service, current->pid);
> +		if (status != VCHIQ_SUCCESS) {
> +			vchiq_remove_service(service->handle);
> +			*phandle = VCHIQ_SERVICE_HANDLE_INVALID;
> +		}
> +	}
> +
> +failed:
> +	vchiq_log_trace(vchiq_core_log_level,
> +		"%s(%p): returning %d", __func__, instance, status);
> +
> +	return status;
> +}
> +EXPORT_SYMBOL(vchiq_open_service);
> +
> +VCHIQ_STATUS_T
> +vchiq_queue_bulk_transmit(VCHIQ_SERVICE_HANDLE_T handle,
> +	const void *data, unsigned int size, void *userdata)
> +{
> +	return vchiq_bulk_transfer(handle,
> +		VCHI_MEM_HANDLE_INVALID, (void *)data, size, userdata,
> +		VCHIQ_BULK_MODE_CALLBACK, VCHIQ_BULK_TRANSMIT);
> +}
> +EXPORT_SYMBOL(vchiq_queue_bulk_transmit);
> +
> +VCHIQ_STATUS_T
> +vchiq_queue_bulk_receive(VCHIQ_SERVICE_HANDLE_T handle, void *data,
> +	unsigned int size, void *userdata)
> +{
> +	return vchiq_bulk_transfer(handle,
> +		VCHI_MEM_HANDLE_INVALID, data, size, userdata,
> +		VCHIQ_BULK_MODE_CALLBACK, VCHIQ_BULK_RECEIVE);
> +}
> +EXPORT_SYMBOL(vchiq_queue_bulk_receive);
> +
> +VCHIQ_STATUS_T
> +vchiq_bulk_transmit(VCHIQ_SERVICE_HANDLE_T handle, const void *data,
> +	unsigned int size, void *userdata, VCHIQ_BULK_MODE_T mode)
> +{
> +	VCHIQ_STATUS_T status;
> +
> +	switch (mode) {
> +	case VCHIQ_BULK_MODE_NOCALLBACK:
> +	case VCHIQ_BULK_MODE_CALLBACK:
> +		status = vchiq_bulk_transfer(handle,
> +			VCHI_MEM_HANDLE_INVALID, (void *)data, size, userdata,
> +			mode, VCHIQ_BULK_TRANSMIT);
> +		break;
> +	case VCHIQ_BULK_MODE_BLOCKING:
> +		status = vchiq_blocking_bulk_transfer(handle,
> +			(void *)data, size, VCHIQ_BULK_TRANSMIT);
> +		break;
> +	default:
> +		return VCHIQ_ERROR;
> +	}
> +
> +	return status;
> +}
> +EXPORT_SYMBOL(vchiq_bulk_transmit);
> +
> +VCHIQ_STATUS_T
> +vchiq_bulk_receive(VCHIQ_SERVICE_HANDLE_T handle, void *data,
> +	unsigned int size, void *userdata, VCHIQ_BULK_MODE_T mode)
> +{
> +	VCHIQ_STATUS_T status;
> +
> +	switch (mode) {
> +	case VCHIQ_BULK_MODE_NOCALLBACK:
> +	case VCHIQ_BULK_MODE_CALLBACK:
> +		status = vchiq_bulk_transfer(handle,
> +			VCHI_MEM_HANDLE_INVALID, data, size, userdata,
> +			mode, VCHIQ_BULK_RECEIVE);
> +		break;
> +	case VCHIQ_BULK_MODE_BLOCKING:
> +		status = vchiq_blocking_bulk_transfer(handle,
> +			(void *)data, size, VCHIQ_BULK_RECEIVE);
> +		break;
> +	default:
> +		return VCHIQ_ERROR;
> +	}
> +
> +	return status;
> +}
> +EXPORT_SYMBOL(vchiq_bulk_receive);
> +
> +static VCHIQ_STATUS_T
> +vchiq_blocking_bulk_transfer(VCHIQ_SERVICE_HANDLE_T handle, void *data,
> +	unsigned int size, VCHIQ_BULK_DIR_T dir)
> +{
> +	VCHIQ_INSTANCE_T instance;
> +	VCHIQ_SERVICE_T *service;
> +	VCHIQ_STATUS_T status;
> +	struct bulk_waiter_node *waiter = NULL;
> +	struct list_head *pos;
> +
> +	service = find_service_by_handle(handle);
> +	if (!service)
> +		return VCHIQ_ERROR;
> +
> +	instance = service->instance;
> +
> +	unlock_service(service);
> +
> +	mutex_lock(&instance->bulk_waiter_list_mutex);
> +	list_for_each(pos, &instance->bulk_waiter_list) {
> +		if (list_entry(pos, struct bulk_waiter_node,
> +				list)->pid == current->pid) {
> +			waiter = list_entry(pos,
> +				struct bulk_waiter_node,
> +				list);
> +			list_del(pos);
> +			break;
> +		}
> +	}
> +	mutex_unlock(&instance->bulk_waiter_list_mutex);
> +
> +	if (waiter) {
> +		VCHIQ_BULK_T *bulk = waiter->bulk_waiter.bulk;
> +
> +		if (bulk) {
> +			/* This thread has an outstanding bulk transfer. */
> +			if ((bulk->data != data) ||
> +				(bulk->size != size)) {
> +				/* This is not a retry of the previous one.
> +				 * Cancel the signal when the transfer
> +				 * completes.
> +				 */
> +				spin_lock(&bulk_waiter_spinlock);
> +				bulk->userdata = NULL;
> +				spin_unlock(&bulk_waiter_spinlock);
> +			}
> +		}
> +	}
> +
> +	if (!waiter) {
> +		waiter = kzalloc(sizeof(struct bulk_waiter_node), GFP_KERNEL);
> +		if (!waiter) {
> +			vchiq_log_error(vchiq_core_log_level,
> +				"%s - out of memory", __func__);
> +			return VCHIQ_ERROR;
> +		}
> +	}
> +
> +	status = vchiq_bulk_transfer(handle, VCHI_MEM_HANDLE_INVALID,
> +		data, size, &waiter->bulk_waiter, VCHIQ_BULK_MODE_BLOCKING,
> +		dir);
> +	if ((status != VCHIQ_RETRY) || fatal_signal_pending(current) ||
> +		!waiter->bulk_waiter.bulk) {
> +		VCHIQ_BULK_T *bulk = waiter->bulk_waiter.bulk;
> +
> +		if (bulk) {
> +			/* Cancel the signal when the transfer
> +			 * completes.
> +			 */
> +			spin_lock(&bulk_waiter_spinlock);
> +			bulk->userdata = NULL;
> +			spin_unlock(&bulk_waiter_spinlock);
> +		}
> +		kfree(waiter);
> +	} else {
> +		waiter->pid = current->pid;
> +		mutex_lock(&instance->bulk_waiter_list_mutex);
> +		list_add(&waiter->list, &instance->bulk_waiter_list);
> +		mutex_unlock(&instance->bulk_waiter_list_mutex);
> +		vchiq_log_info(vchiq_arm_log_level,
> +				"saved bulk_waiter %pK for pid %d",
> +				waiter, current->pid);
> +	}
> +
> +	return status;
> +}
>  /****************************************************************************
>  *
>  *   add_completion
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_kern_lib.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_kern_lib.c
> deleted file mode 100644
> index 43c89a08bda9..000000000000
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_kern_lib.c
> +++ /dev/null
> @@ -1,431 +0,0 @@
> -/**
> - * Copyright (c) 2010-2012 Broadcom. All rights reserved.
> - *
> - * Redistribution and use in source and binary forms, with or without
> - * modification, are permitted provided that the following conditions
> - * are met:
> - * 1. Redistributions of source code must retain the above copyright
> - *    notice, this list of conditions, and the following disclaimer,
> - *    without modification.
> - * 2. Redistributions in binary form must reproduce the above copyright
> - *    notice, this list of conditions and the following disclaimer in the
> - *    documentation and/or other materials provided with the distribution.
> - * 3. The names of the above-listed copyright holders may not be used
> - *    to endorse or promote products derived from this software without
> - *    specific prior written permission.
> - *
> - * ALTERNATIVELY, this software may be distributed under the terms of the
> - * GNU General Public License ("GPL") version 2, as published by the Free
> - * Software Foundation.
> - *
> - * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
> - * IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
> - * THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
> - * PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
> - * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
> - * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
> - * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
> - * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
> - * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
> - * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
> - * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> - */
> -
> -/* ---- Include Files ---------------------------------------------------- */
> -
> -#include <linux/kernel.h>
> -#include <linux/module.h>
> -#include <linux/mutex.h>
> -
> -#include "vchiq_core.h"
> -#include "vchiq_arm.h"
> -#include "vchiq_killable.h"
> -
> -/* ---- Public Variables ------------------------------------------------- */
> -
> -/* ---- Private Constants and Types -------------------------------------- */
> -
> -struct bulk_waiter_node {
> -	struct bulk_waiter bulk_waiter;
> -	int pid;
> -	struct list_head list;
> -};
> -
> -struct vchiq_instance_struct {
> -	VCHIQ_STATE_T *state;
> -
> -	int connected;
> -
> -	struct list_head bulk_waiter_list;
> -	struct mutex bulk_waiter_list_mutex;
> -};
> -
> -static VCHIQ_STATUS_T
> -vchiq_blocking_bulk_transfer(VCHIQ_SERVICE_HANDLE_T handle, void *data,
> -	unsigned int size, VCHIQ_BULK_DIR_T dir);
> -
> -#define VCHIQ_INIT_RETRIES 10
> -VCHIQ_STATUS_T vchiq_initialise(VCHIQ_INSTANCE_T *instance_out)
> -{
> -	VCHIQ_STATUS_T status = VCHIQ_ERROR;
> -	VCHIQ_STATE_T *state;
> -	VCHIQ_INSTANCE_T instance = NULL;
> -	int i;
> -
> -	vchiq_log_trace(vchiq_core_log_level, "%s called", __func__);
> -
> -	/* VideoCore may not be ready due to boot up timing.
> -	 * It may never be ready if kernel and firmware are mismatched,so don't
> -	 * block forever.
> -	 */
> -	for (i = 0; i < VCHIQ_INIT_RETRIES; i++) {
> -		state = vchiq_get_state();
> -		if (state)
> -			break;
> -		udelay(500);
> -	}
> -	if (i == VCHIQ_INIT_RETRIES) {
> -		vchiq_log_error(vchiq_core_log_level,
> -			"%s: videocore not initialized\n", __func__);
> -		goto failed;
> -	} else if (i > 0) {
> -		vchiq_log_warning(vchiq_core_log_level,
> -			"%s: videocore initialized after %d retries\n",
> -			__func__, i);
> -	}
> -
> -	instance = kzalloc(sizeof(*instance), GFP_KERNEL);
> -	if (!instance) {
> -		vchiq_log_error(vchiq_core_log_level,
> -			"%s: error allocating vchiq instance\n", __func__);
> -		goto failed;
> -	}
> -
> -	instance->connected = 0;
> -	instance->state = state;
> -	mutex_init(&instance->bulk_waiter_list_mutex);
> -	INIT_LIST_HEAD(&instance->bulk_waiter_list);
> -
> -	*instance_out = instance;
> -
> -	status = VCHIQ_SUCCESS;
> -
> -failed:
> -	vchiq_log_trace(vchiq_core_log_level,
> -		"%s(%p): returning %d", __func__, instance, status);
> -
> -	return status;
> -}
> -EXPORT_SYMBOL(vchiq_initialise);
> -
> -VCHIQ_STATUS_T vchiq_shutdown(VCHIQ_INSTANCE_T instance)
> -{
> -	VCHIQ_STATUS_T status;
> -	VCHIQ_STATE_T *state = instance->state;
> -
> -	vchiq_log_trace(vchiq_core_log_level,
> -		"%s(%p) called", __func__, instance);
> -
> -	if (mutex_lock_killable(&state->mutex) != 0)
> -		return VCHIQ_RETRY;
> -
> -	/* Remove all services */
> -	status = vchiq_shutdown_internal(state, instance);
> -
> -	mutex_unlock(&state->mutex);
> -
> -	vchiq_log_trace(vchiq_core_log_level,
> -		"%s(%p): returning %d", __func__, instance, status);
> -
> -	if (status == VCHIQ_SUCCESS) {
> -		struct list_head *pos, *next;
> -
> -		list_for_each_safe(pos, next,
> -				&instance->bulk_waiter_list) {
> -			struct bulk_waiter_node *waiter;
> -
> -			waiter = list_entry(pos,
> -					struct bulk_waiter_node,
> -					list);
> -			list_del(pos);
> -			vchiq_log_info(vchiq_arm_log_level,
> -					"bulk_waiter - cleaned up %pK for pid %d",
> -					waiter, waiter->pid);
> -			kfree(waiter);
> -		}
> -		kfree(instance);
> -	}
> -
> -	return status;
> -}
> -EXPORT_SYMBOL(vchiq_shutdown);
> -
> -static int vchiq_is_connected(VCHIQ_INSTANCE_T instance)
> -{
> -	return instance->connected;
> -}
> -
> -VCHIQ_STATUS_T vchiq_connect(VCHIQ_INSTANCE_T instance)
> -{
> -	VCHIQ_STATUS_T status;
> -	VCHIQ_STATE_T *state = instance->state;
> -
> -	vchiq_log_trace(vchiq_core_log_level,
> -		"%s(%p) called", __func__, instance);
> -
> -	if (mutex_lock_killable(&state->mutex) != 0) {
> -		vchiq_log_trace(vchiq_core_log_level,
> -			"%s: call to mutex_lock failed", __func__);
> -		status = VCHIQ_RETRY;
> -		goto failed;
> -	}
> -	status = vchiq_connect_internal(state, instance);
> -
> -	if (status == VCHIQ_SUCCESS)
> -		instance->connected = 1;
> -
> -	mutex_unlock(&state->mutex);
> -
> -failed:
> -	vchiq_log_trace(vchiq_core_log_level,
> -		"%s(%p): returning %d", __func__, instance, status);
> -
> -	return status;
> -}
> -EXPORT_SYMBOL(vchiq_connect);
> -
> -VCHIQ_STATUS_T vchiq_add_service(
> -	VCHIQ_INSTANCE_T              instance,
> -	const VCHIQ_SERVICE_PARAMS_T *params,
> -	VCHIQ_SERVICE_HANDLE_T       *phandle)
> -{
> -	VCHIQ_STATUS_T status;
> -	VCHIQ_STATE_T *state = instance->state;
> -	VCHIQ_SERVICE_T *service = NULL;
> -	int srvstate;
> -
> -	vchiq_log_trace(vchiq_core_log_level,
> -		"%s(%p) called", __func__, instance);
> -
> -	*phandle = VCHIQ_SERVICE_HANDLE_INVALID;
> -
> -	srvstate = vchiq_is_connected(instance)
> -		? VCHIQ_SRVSTATE_LISTENING
> -		: VCHIQ_SRVSTATE_HIDDEN;
> -
> -	service = vchiq_add_service_internal(
> -		state,
> -		params,
> -		srvstate,
> -		instance,
> -		NULL);
> -
> -	if (service) {
> -		*phandle = service->handle;
> -		status = VCHIQ_SUCCESS;
> -	} else
> -		status = VCHIQ_ERROR;
> -
> -	vchiq_log_trace(vchiq_core_log_level,
> -		"%s(%p): returning %d", __func__, instance, status);
> -
> -	return status;
> -}
> -EXPORT_SYMBOL(vchiq_add_service);
> -
> -VCHIQ_STATUS_T vchiq_open_service(
> -	VCHIQ_INSTANCE_T              instance,
> -	const VCHIQ_SERVICE_PARAMS_T *params,
> -	VCHIQ_SERVICE_HANDLE_T       *phandle)
> -{
> -	VCHIQ_STATUS_T   status = VCHIQ_ERROR;
> -	VCHIQ_STATE_T   *state = instance->state;
> -	VCHIQ_SERVICE_T *service = NULL;
> -
> -	vchiq_log_trace(vchiq_core_log_level,
> -		"%s(%p) called", __func__, instance);
> -
> -	*phandle = VCHIQ_SERVICE_HANDLE_INVALID;
> -
> -	if (!vchiq_is_connected(instance))
> -		goto failed;
> -
> -	service = vchiq_add_service_internal(state,
> -		params,
> -		VCHIQ_SRVSTATE_OPENING,
> -		instance,
> -		NULL);
> -
> -	if (service) {
> -		*phandle = service->handle;
> -		status = vchiq_open_service_internal(service, current->pid);
> -		if (status != VCHIQ_SUCCESS) {
> -			vchiq_remove_service(service->handle);
> -			*phandle = VCHIQ_SERVICE_HANDLE_INVALID;
> -		}
> -	}
> -
> -failed:
> -	vchiq_log_trace(vchiq_core_log_level,
> -		"%s(%p): returning %d", __func__, instance, status);
> -
> -	return status;
> -}
> -EXPORT_SYMBOL(vchiq_open_service);
> -
> -VCHIQ_STATUS_T
> -vchiq_queue_bulk_transmit(VCHIQ_SERVICE_HANDLE_T handle,
> -	const void *data, unsigned int size, void *userdata)
> -{
> -	return vchiq_bulk_transfer(handle,
> -		VCHI_MEM_HANDLE_INVALID, (void *)data, size, userdata,
> -		VCHIQ_BULK_MODE_CALLBACK, VCHIQ_BULK_TRANSMIT);
> -}
> -EXPORT_SYMBOL(vchiq_queue_bulk_transmit);
> -
> -VCHIQ_STATUS_T
> -vchiq_queue_bulk_receive(VCHIQ_SERVICE_HANDLE_T handle, void *data,
> -	unsigned int size, void *userdata)
> -{
> -	return vchiq_bulk_transfer(handle,
> -		VCHI_MEM_HANDLE_INVALID, data, size, userdata,
> -		VCHIQ_BULK_MODE_CALLBACK, VCHIQ_BULK_RECEIVE);
> -}
> -EXPORT_SYMBOL(vchiq_queue_bulk_receive);
> -
> -VCHIQ_STATUS_T
> -vchiq_bulk_transmit(VCHIQ_SERVICE_HANDLE_T handle, const void *data,
> -	unsigned int size, void *userdata, VCHIQ_BULK_MODE_T mode)
> -{
> -	VCHIQ_STATUS_T status;
> -
> -	switch (mode) {
> -	case VCHIQ_BULK_MODE_NOCALLBACK:
> -	case VCHIQ_BULK_MODE_CALLBACK:
> -		status = vchiq_bulk_transfer(handle,
> -			VCHI_MEM_HANDLE_INVALID, (void *)data, size, userdata,
> -			mode, VCHIQ_BULK_TRANSMIT);
> -		break;
> -	case VCHIQ_BULK_MODE_BLOCKING:
> -		status = vchiq_blocking_bulk_transfer(handle,
> -			(void *)data, size, VCHIQ_BULK_TRANSMIT);
> -		break;
> -	default:
> -		return VCHIQ_ERROR;
> -	}
> -
> -	return status;
> -}
> -EXPORT_SYMBOL(vchiq_bulk_transmit);
> -
> -VCHIQ_STATUS_T
> -vchiq_bulk_receive(VCHIQ_SERVICE_HANDLE_T handle, void *data,
> -	unsigned int size, void *userdata, VCHIQ_BULK_MODE_T mode)
> -{
> -	VCHIQ_STATUS_T status;
> -
> -	switch (mode) {
> -	case VCHIQ_BULK_MODE_NOCALLBACK:
> -	case VCHIQ_BULK_MODE_CALLBACK:
> -		status = vchiq_bulk_transfer(handle,
> -			VCHI_MEM_HANDLE_INVALID, data, size, userdata,
> -			mode, VCHIQ_BULK_RECEIVE);
> -		break;
> -	case VCHIQ_BULK_MODE_BLOCKING:
> -		status = vchiq_blocking_bulk_transfer(handle,
> -			(void *)data, size, VCHIQ_BULK_RECEIVE);
> -		break;
> -	default:
> -		return VCHIQ_ERROR;
> -	}
> -
> -	return status;
> -}
> -EXPORT_SYMBOL(vchiq_bulk_receive);
> -
> -static VCHIQ_STATUS_T
> -vchiq_blocking_bulk_transfer(VCHIQ_SERVICE_HANDLE_T handle, void *data,
> -	unsigned int size, VCHIQ_BULK_DIR_T dir)
> -{
> -	VCHIQ_INSTANCE_T instance;
> -	VCHIQ_SERVICE_T *service;
> -	VCHIQ_STATUS_T status;
> -	struct bulk_waiter_node *waiter = NULL;
> -	struct list_head *pos;
> -
> -	service = find_service_by_handle(handle);
> -	if (!service)
> -		return VCHIQ_ERROR;
> -
> -	instance = service->instance;
> -
> -	unlock_service(service);
> -
> -	mutex_lock(&instance->bulk_waiter_list_mutex);
> -	list_for_each(pos, &instance->bulk_waiter_list) {
> -		if (list_entry(pos, struct bulk_waiter_node,
> -				list)->pid == current->pid) {
> -			waiter = list_entry(pos,
> -				struct bulk_waiter_node,
> -				list);
> -			list_del(pos);
> -			break;
> -		}
> -	}
> -	mutex_unlock(&instance->bulk_waiter_list_mutex);
> -
> -	if (waiter) {
> -		VCHIQ_BULK_T *bulk = waiter->bulk_waiter.bulk;
> -
> -		if (bulk) {
> -			/* This thread has an outstanding bulk transfer. */
> -			if ((bulk->data != data) ||
> -				(bulk->size != size)) {
> -				/* This is not a retry of the previous one.
> -				 * Cancel the signal when the transfer
> -				 * completes.
> -				 */
> -				spin_lock(&bulk_waiter_spinlock);
> -				bulk->userdata = NULL;
> -				spin_unlock(&bulk_waiter_spinlock);
> -			}
> -		}
> -	}
> -
> -	if (!waiter) {
> -		waiter = kzalloc(sizeof(struct bulk_waiter_node), GFP_KERNEL);
> -		if (!waiter) {
> -			vchiq_log_error(vchiq_core_log_level,
> -				"%s - out of memory", __func__);
> -			return VCHIQ_ERROR;
> -		}
> -	}
> -
> -	status = vchiq_bulk_transfer(handle, VCHI_MEM_HANDLE_INVALID,
> -		data, size, &waiter->bulk_waiter, VCHIQ_BULK_MODE_BLOCKING,
> -		dir);
> -	if ((status != VCHIQ_RETRY) || fatal_signal_pending(current) ||
> -		!waiter->bulk_waiter.bulk) {
> -		VCHIQ_BULK_T *bulk = waiter->bulk_waiter.bulk;
> -
> -		if (bulk) {
> -			/* Cancel the signal when the transfer
> -			 * completes.
> -			 */
> -			spin_lock(&bulk_waiter_spinlock);
> -			bulk->userdata = NULL;
> -			spin_unlock(&bulk_waiter_spinlock);
> -		}
> -		kfree(waiter);
> -	} else {
> -		waiter->pid = current->pid;
> -		mutex_lock(&instance->bulk_waiter_list_mutex);
> -		list_add(&waiter->list, &instance->bulk_waiter_list);
> -		mutex_unlock(&instance->bulk_waiter_list_mutex);
> -		vchiq_log_info(vchiq_arm_log_level,
> -				"saved bulk_waiter %pK for pid %d",
> -				waiter, current->pid);
> -	}
> -
> -	return status;
> -}
> -- 
> 2.9.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
