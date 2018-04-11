Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1894899-1523433962-2-3811153197797931010
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, UNPARSEABLE_RELAY 0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523433961; b=oJKvhN1oFoySAdFrShIgMo07kaYdKg+VKPE0+C1XleC5rNwJH9
    EJ0iJ/P0tXwrvHZvPNerUXqg8x9B5W6XNFJAy7lVPmefG1JnNG9wUwmZX4B6fHNU
    Mt9sycofCw6NWjqtLsjVd8j+J2PMNiFu7std/YLj2eXssvLfcQcseJfS/9JoORCP
    eIL6nSAdtDFJzK1apuOhbJd4cC3PxTEUpolfaRsXYmXXT7uCoVFdPZjkBXWfl78l
    WNIYx80OwN7eyt92EmE4O7u8RkGAeQnibtE38ehOE9SqrQ4SjE7pB6KTc9v5vzBW
    r1vf8+W9SqANw4UKHkYYEu9zLT6+qWaIwOzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523433961; bh=Hn42N
    6gTA5JjmDVM0BPKRpV8u8wrfTaabe4nAZo0smw=; b=JfCLugw/Yt7nNgbJbJNQJ
    +dQU0IKIy6Ghk2WBWqJu6HXIyVaNNWAOHQltYQyJaYV46mxL1elBd936iV6kjaay
    9JPAFw0iC4NB+g2OdckjLonRA8/aEtIx32sv4C5/NrsamicgZws4iq8qwwVBvV12
    LXa5On1tT290Zgg3rFARferCfXM49Nn6wbPOGJqr1xoaIlMXa/FLi+fsZ2ijv3jc
    uEF+EujFTBEqTl6ec5prbRNGvrAb5/5fRsYWdzQTsUFUppnN+KaYAthIFZqIILRl
    yWy976KETMeYMGIVwxkfpPFMj59yL35stIxS4DLgA8bWOCsRUiVSNnRIUa1gj6YG
    w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=ZCzB/C/m x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=ZCzB/C/m x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDfZ/YKFiHz+pATCnNNOSRr5vSrJLABoF5QF510wKWNXNQPObcjLgTo/uJNh2+EjLUxK061C36NdBu7/6dDLHP1x8nJ9YqhrMSJ6wPkUmhL3r+HzRrHK
    k+M7kjXiQKbJIt6n64hm7tiNKNCVpLmNaoNrI2oCT/Quv2L7b0DRf4CPziZrEf1HBtC6kfdNp4t6kJe09BPrBiqw14ctUVVB94InMe2ec7gnAqAI6TnvRrri
    HYLN58dTvTfSk3otmidPRw==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=RlllKwerePyQsyTXGx8A:9
    a=qfJXd2scf06WVth5:21 a=nuIpKOJg8D7P40o_:21 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Wed, 11 Apr 2018 11:05:36 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Alistair Strachan <astrachan@google.com>
Subject: Re: [PATCH] staging: Android: Add 'vsoc' driver for cuttlefish.
Message-ID: <20180411080536.sw6tesgi3vqgxxpn@mwanda>
References: <20180410190647.82986-1-astrachan@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180410190647.82986-1-astrachan@google.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8859
 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804110079
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
Cc: devel@driverdev.osuosl.org, kernel-team@android.com, tkjos@android.com,
 gregkh@linuxfoundation.org, ghartman@google.com, linux-kernel@vger.kernel.org,
 arve@android.com, maco@android.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 10, 2018 at 12:06:47PM -0700, Alistair Strachan wrote:
> +static int do_create_fd_scoped_permission(
> +	struct vsoc_device_region *region_p,
> +	struct fd_scoped_permission_node *np,
> +	struct fd_scoped_permission_arg *__user arg)
> +{
> +	struct file *managed_filp;
> +	s32 managed_fd;
> +	atomic_t *owner_ptr = NULL;
> +	struct vsoc_device_region *managed_region_p;
> +
> +	if (copy_from_user(&np->permission, &arg->perm, sizeof(*np)) ||
> +	    copy_from_user(&managed_fd,
> +			   &arg->managed_region_fd, sizeof(managed_fd))) {
> +		return -EFAULT;
> +	}
> +	managed_filp = fdget(managed_fd).file;
> +	/* Check that it's a valid fd, */
> +	if (!managed_filp || vsoc_validate_filep(managed_filp))
> +		return -EPERM;
> +	/* EEXIST if the given fd already has a permission. */
> +	if (((struct vsoc_private_data *)managed_filp->private_data)->
> +	    fd_scoped_permission_node)
> +		return -EEXIST;
> +	managed_region_p = vsoc_region_from_filep(managed_filp);
> +	/* Check that the provided region is managed by this one */
> +	if (&vsoc_dev.regions[managed_region_p->managed_by] != region_p)
> +		return -EPERM;
> +	/* The area must be well formed and have non-zero size */
> +	if (np->permission.begin_offset >= np->permission.end_offset)
> +		return -EINVAL;
> +	/* The area must fit in the memory window */
> +	if (np->permission.end_offset >
> +	    vsoc_device_region_size(managed_region_p))
> +		return -ERANGE;
> +	/* The area must be in the region data section */
> +	if (np->permission.begin_offset <
> +	    managed_region_p->offset_of_region_data)
> +		return -ERANGE;
> +	/* The area must be page aligned */
> +	if (!PAGE_ALIGNED(np->permission.begin_offset) ||
> +	    !PAGE_ALIGNED(np->permission.end_offset))
> +		return -EINVAL;
> +	/* The owner flag must reside in the owner memory */
> +	if (np->permission.owner_offset + sizeof(np->permission.owner_offset) >
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
There is a potential integer overflow here

> +	    vsoc_device_region_size(region_p))
> +		return -ERANGE;
> +	/* The owner flag must reside in the data section */
> +	if (np->permission.owner_offset < region_p->offset_of_region_data)
> +		return -EINVAL;
> +	/* Owner offset must be naturally aligned in the window */
> +	if (np->permission.owner_offset &
> +	    (sizeof(np->permission.owner_offset) - 1))
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
but then we prevent it here so that's fine.  But it would be better to
reverse these checks so that it's easier to review.

> +		return -EINVAL;
> +	/* The owner value must change to claim the memory */
> +	if (np->permission.owned_value == VSOC_REGION_FREE)
> +		return -EINVAL;
> +	owner_ptr =
> +	    (atomic_t *)shm_off_to_virtual_addr(region_p->region_begin_offset +
> +						np->permission.owner_offset);
> +	/* We've already verified that this is in the shared memory window, so
> +	 * it should be safe to write to this address.
> +	 */
> +	if (atomic_cmpxchg(owner_ptr,
> +			   VSOC_REGION_FREE,
> +			   np->permission.owned_value) != VSOC_REGION_FREE) {
> +		return -EBUSY;
> +	}
> +	((struct vsoc_private_data *)managed_filp->private_data)->
> +	    fd_scoped_permission_node = np;
> +	/* The file offset needs to be adjusted if the calling
> +	 * process did any read/write operations on the fd
> +	 * before creating the permission.
> +	 */
> +	if (managed_filp->f_pos) {
> +		if (managed_filp->f_pos > np->permission.end_offset) {
> +			/* If the offset is beyond the permission end, set it
> +			 * to the end.
> +			 */
> +			managed_filp->f_pos = np->permission.end_offset;
> +		} else {
> +			/* If the offset is within the permission interval
> +			 * keep it there otherwise reset it to zero.
> +			 */
> +			if (managed_filp->f_pos < np->permission.begin_offset) {
> +				managed_filp->f_pos = 0;
> +			} else {
> +				managed_filp->f_pos -=
> +				    np->permission.begin_offset;
> +			}
> +		}
> +	}
> +	return 0;
> +}
> +

[ snip ]

> +
> +/**
> + * Implements the inner logic of cond_wait. Copies to and from userspace are
> + * done in the helper function below.
> + */
> +static int handle_vsoc_cond_wait(struct file *filp, struct vsoc_cond_wait *arg)
> +{
> +	DEFINE_WAIT(wait);
> +	u32 region_number = iminor(file_inode(filp));
> +	struct vsoc_region_data *data = vsoc_dev.regions_data + region_number;
> +	struct hrtimer_sleeper timeout, *to = NULL;
> +	int ret = 0;
> +	struct vsoc_device_region *region_p = vsoc_region_from_filep(filp);
> +	atomic_t *address = NULL;
> +	struct timespec ts;
> +
> +	/* Ensure that the offset is aligned */
> +	if (arg->offset & (sizeof(uint32_t) - 1))
> +		return -EADDRNOTAVAIL;
> +	/* Ensure that the offset is within shared memory */
> +	if (((uint64_t)arg->offset) + region_p->region_begin_offset +
> +	    sizeof(uint32_t) > region_p->region_end_offset)
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This could overflow.

> +		return -E2BIG;
> +	address = shm_off_to_virtual_addr(region_p->region_begin_offset +
> +					  arg->offset);
> +
> +	/* Ensure that the type of wait is valid */
> +	switch (arg->wait_type) {
> +	case VSOC_WAIT_IF_EQUAL:
> +		break;
> +	case VSOC_WAIT_IF_EQUAL_TIMEOUT:
> +		to = &timeout;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (to) {
> +		/* Copy the user-supplied timesec into the kernel structure.
> +		 * We do things this way to flatten differences between 32 bit
> +		 * and 64 bit timespecs.
> +		 */
> +		ts.tv_sec = arg->wake_time_sec;
> +		ts.tv_nsec = arg->wake_time_nsec;
> +
> +		if (!timespec_valid(&ts))
> +			return -EINVAL;
> +		hrtimer_init_on_stack(&to->timer, CLOCK_MONOTONIC,
> +				      HRTIMER_MODE_ABS);
> +		hrtimer_set_expires_range_ns(&to->timer, timespec_to_ktime(ts),
> +					     current->timer_slack_ns);
> +
> +		hrtimer_init_sleeper(to, current);
> +	}
> +
> +	while (1) {
> +		prepare_to_wait(&data->futex_wait_queue, &wait,
> +				TASK_INTERRUPTIBLE);
> +		/*
> +		 * Check the sentinel value after prepare_to_wait. If the value
> +		 * changes after this check the writer will call signal,
> +		 * changing the task state from INTERRUPTIBLE to RUNNING. That
> +		 * will ensure that schedule() will eventually schedule this
> +		 * task.
> +		 */
> +		if (atomic_read(address) != arg->value) {
> +			ret = 0;
> +			break;
> +		}
> +		if (to) {
> +			hrtimer_start_expires(&to->timer, HRTIMER_MODE_ABS);
> +			if (likely(to->task))
> +				freezable_schedule();
> +			hrtimer_cancel(&to->timer);
> +			if (!to->task) {
> +				ret = -ETIMEDOUT;
> +				break;
> +			}
> +		} else {
> +			freezable_schedule();
> +		}
> +		/* Count the number of times that we woke up. This is useful
> +		 * for unit testing.
> +		 */
> +		++arg->wakes;
> +		if (signal_pending(current)) {
> +			ret = -EINTR;
> +			break;
> +		}
> +	}
> +	finish_wait(&data->futex_wait_queue, &wait);
> +	if (to)
> +		destroy_hrtimer_on_stack(&to->timer);
> +	return ret;
> +}
> +

[ snip ]

> +
> +static int vsoc_probe_device(struct pci_dev *pdev,
> +			     const struct pci_device_id *ent)
> +{
> +	int result;
> +	int i;
> +	resource_size_t reg_size;
> +	dev_t devt;
> +
> +	vsoc_dev.dev = pdev;
> +	result = pci_enable_device(pdev);
> +	if (result) {
> +		dev_err(&pdev->dev,
> +			"pci_enable_device failed %s: error %d\n",
> +			pci_name(pdev), result);
> +		return result;
> +	}
> +	vsoc_dev.enabled_device = 1;
> +	result = pci_request_regions(pdev, "vsoc");
> +	if (result < 0) {
> +		dev_err(&pdev->dev, "pci_request_regions failed\n");
> +		vsoc_remove_device(pdev);
> +		return -EBUSY;
> +	}
> +	vsoc_dev.requested_regions = 1;
> +	/* Set up the control registers in BAR 0 */
> +	reg_size = pci_resource_len(pdev, REGISTER_BAR);
> +	if (reg_size > MAX_REGISTER_BAR_LEN)
> +		vsoc_dev.regs =
> +		    pci_iomap(pdev, REGISTER_BAR, MAX_REGISTER_BAR_LEN);
> +	else
> +		vsoc_dev.regs = pci_iomap(pdev, REGISTER_BAR, reg_size);
> +
> +	if (!vsoc_dev.regs) {
> +		dev_err(&pdev->dev,
> +			"cannot ioremap registers of size %zu\n",
> +		       (size_t)reg_size);
> +		vsoc_remove_device(pdev);
> +		return -EBUSY;
> +	}
> +
> +	/* Map the shared memory in BAR 2 */
> +	vsoc_dev.shm_phys_start = pci_resource_start(pdev, SHARED_MEMORY_BAR);
> +	vsoc_dev.shm_size = pci_resource_len(pdev, SHARED_MEMORY_BAR);
> +
> +	dev_info(&pdev->dev, "shared memory @ DMA %p size=0x%zx\n",
> +		 (void *)vsoc_dev.shm_phys_start, vsoc_dev.shm_size);
> +	/* TODO(ghartman): ioremap_wc should work here */
> +	vsoc_dev.kernel_mapped_shm = ioremap_nocache(
> +			vsoc_dev.shm_phys_start, vsoc_dev.shm_size);
> +	if (!vsoc_dev.kernel_mapped_shm) {
> +		dev_err(&vsoc_dev.dev->dev, "cannot iomap region\n");
> +		vsoc_remove_device(pdev);
> +		return -EBUSY;
> +	}
> +
> +	vsoc_dev.layout =
> +	    (struct vsoc_shm_layout_descriptor *)vsoc_dev.kernel_mapped_shm;
> +	dev_info(&pdev->dev, "major_version: %d\n",
> +		 vsoc_dev.layout->major_version);
> +	dev_info(&pdev->dev, "minor_version: %d\n",
> +		 vsoc_dev.layout->minor_version);
> +	dev_info(&pdev->dev, "size: 0x%x\n", vsoc_dev.layout->size);
> +	dev_info(&pdev->dev, "regions: %d\n", vsoc_dev.layout->region_count);
> +	if (vsoc_dev.layout->major_version !=
> +	    CURRENT_VSOC_LAYOUT_MAJOR_VERSION) {
> +		dev_err(&vsoc_dev.dev->dev,
> +			"driver supports only major_version %d\n",
> +			CURRENT_VSOC_LAYOUT_MAJOR_VERSION);
> +		vsoc_remove_device(pdev);
> +		return -EBUSY;
> +	}
> +	result = alloc_chrdev_region(&devt, 0, vsoc_dev.layout->region_count,
> +				     VSOC_DEV_NAME);
> +	if (result) {
> +		dev_err(&vsoc_dev.dev->dev, "alloc_chrdev_region failed\n");
> +		vsoc_remove_device(pdev);
> +		return -EBUSY;
> +	}
> +	vsoc_dev.major = MAJOR(devt);
> +	cdev_init(&vsoc_dev.cdev, &vsoc_ops);
> +	vsoc_dev.cdev.owner = THIS_MODULE;
> +	result = cdev_add(&vsoc_dev.cdev, devt, vsoc_dev.layout->region_count);
> +	if (result) {
> +		dev_err(&vsoc_dev.dev->dev, "cdev_add error\n");
> +		vsoc_remove_device(pdev);
> +		return -EBUSY;
> +	}
> +	vsoc_dev.cdev_added = 1;
> +	vsoc_dev.class = class_create(THIS_MODULE, VSOC_DEV_NAME);
> +	if (!vsoc_dev.class) {
            ^^^^^^^^^^^^^^^
This should be if (IS_ERR(vsoc_dev.class)) {.  The test in
vsoc_remove_device() needs to be updated as well.

> +		dev_err(&vsoc_dev.dev->dev, "class_create failed\n");
> +		vsoc_remove_device(pdev);
> +		return -EBUSY;
> +	}
> +	vsoc_dev.regions = (struct vsoc_device_region *)
> +		(vsoc_dev.kernel_mapped_shm +
> +		 vsoc_dev.layout->vsoc_region_desc_offset);
> +	vsoc_dev.msix_entries = kcalloc(
> +			vsoc_dev.layout->region_count,
> +			sizeof(vsoc_dev.msix_entries[0]), GFP_KERNEL);
> +	if (!vsoc_dev.msix_entries) {
> +		dev_err(&vsoc_dev.dev->dev,
> +			"unable to allocate msix_entries\n");
> +		vsoc_remove_device(pdev);
> +		return -ENOSPC;
> +	}
> +	vsoc_dev.regions_data = kcalloc(
> +			vsoc_dev.layout->region_count,
> +			sizeof(vsoc_dev.regions_data[0]), GFP_KERNEL);
> +	if (!vsoc_dev.regions_data) {
> +		dev_err(&vsoc_dev.dev->dev,
> +			"unable to allocate regions' data\n");
> +		vsoc_remove_device(pdev);
> +		return -ENOSPC;
> +	}
> +	for (i = 0; i < vsoc_dev.layout->region_count; ++i)
> +		vsoc_dev.msix_entries[i].entry = i;
> +
> +	result = pci_enable_msix_exact(vsoc_dev.dev, vsoc_dev.msix_entries,
> +				       vsoc_dev.layout->region_count);
> +	if (result) {
> +		dev_info(&pdev->dev, "pci_enable_msix failed: %d\n", result);
> +		vsoc_remove_device(pdev);
> +		return -ENOSPC;
> +	}
> +	/* Check that all regions are well formed */
> +	for (i = 0; i < vsoc_dev.layout->region_count; ++i) {
> +		const struct vsoc_device_region *region = vsoc_dev.regions + i;
> +
> +		if (!PAGE_ALIGNED(region->region_begin_offset) ||
> +		    !PAGE_ALIGNED(region->region_end_offset)) {
> +			dev_err(&vsoc_dev.dev->dev,
> +				"region %d not aligned (%x:%x)", i,
> +				region->region_begin_offset,
> +				region->region_end_offset);
> +			vsoc_remove_device(pdev);
> +			return -EFAULT;
> +		}
> +		if (region->region_begin_offset >= region->region_end_offset ||
> +		    region->region_end_offset > vsoc_dev.shm_size) {
> +			dev_err(&vsoc_dev.dev->dev,
> +				"region %d offsets are wrong: %x %x %zx",
> +				i, region->region_begin_offset,
> +				region->region_end_offset, vsoc_dev.shm_size);
> +			vsoc_remove_device(pdev);
> +			return -EFAULT;
> +		}
> +		if (region->managed_by >= vsoc_dev.layout->region_count) {
> +			dev_err(&vsoc_dev.dev->dev,
> +				"region %d has invalid owner: %u",
> +				i, region->managed_by);
> +			vsoc_remove_device(pdev);
> +			return -EFAULT;
> +		}
> +	}
> +	vsoc_dev.msix_enabled = 1;
> +	for (i = 0; i < vsoc_dev.layout->region_count; ++i) {
> +		const struct vsoc_device_region *region = vsoc_dev.regions + i;
> +		size_t name_sz = sizeof(vsoc_dev.regions_data[i].name) - 1;
> +		const struct vsoc_signal_table_layout *h_to_g_signal_table =
> +			&region->host_to_guest_signal_table;
> +		const struct vsoc_signal_table_layout *g_to_h_signal_table =
> +			&region->guest_to_host_signal_table;
> +
> +		vsoc_dev.regions_data[i].name[name_sz] = '\0';
> +		memcpy(vsoc_dev.regions_data[i].name, region->device_name,
> +		       name_sz);
> +		dev_info(&pdev->dev, "region %d name=%s\n",
> +			 i, vsoc_dev.regions_data[i].name);
> +		init_waitqueue_head(
> +				&vsoc_dev.regions_data[i].interrupt_wait_queue);
> +		init_waitqueue_head(&vsoc_dev.regions_data[i].futex_wait_queue);
> +		vsoc_dev.regions_data[i].incoming_signalled =
> +			vsoc_dev.kernel_mapped_shm +
> +			region->region_begin_offset +
> +			h_to_g_signal_table->interrupt_signalled_offset;
> +		vsoc_dev.regions_data[i].outgoing_signalled =
> +			vsoc_dev.kernel_mapped_shm +
> +			region->region_begin_offset +
> +			g_to_h_signal_table->interrupt_signalled_offset;
> +
> +		result = request_irq(
> +				vsoc_dev.msix_entries[i].vector,
> +				vsoc_interrupt, 0,
> +				vsoc_dev.regions_data[i].name,
> +				vsoc_dev.regions_data + i);
> +		if (result) {
> +			dev_info(&pdev->dev,
> +				 "request_irq failed irq=%d vector=%d\n",
> +				i, vsoc_dev.msix_entries[i].vector);
> +			vsoc_remove_device(pdev);
> +			return -ENOSPC;
> +		}
> +		vsoc_dev.regions_data[i].irq_requested = 1;
> +		if (!device_create(vsoc_dev.class, NULL,
> +				   MKDEV(vsoc_dev.major, i),
> +				   NULL, vsoc_dev.regions_data[i].name)) {
> +			dev_err(&vsoc_dev.dev->dev, "device_create failed\n");
> +			vsoc_remove_device(pdev);
> +			return -EBUSY;
> +		}
> +		vsoc_dev.regions_data[i].device_created = 1;
> +	}
> +	return 0;
> +}
> +
> +/*
> + * This should undo all of the allocations in the probe function in reverse
> + * order.
> + *
> + * Notes:
> + *
> + *   The device may have been partially initialized, so double check
> + *   that the allocations happened.
> + *
> + *   This function may be called multiple times, so mark resources as freed
> + *   as they are deallocated.
> + */
> +static void vsoc_remove_device(struct pci_dev *pdev)
> +{
> +	int i;
> +	/*
> +	 * pdev is the first thing to be set on probe and the last thing
> +	 * to be cleared here. If it's NULL then there is no cleanup.
> +	 */
> +	if (!pdev || !vsoc_dev.dev)
> +		return;
> +	dev_info(&pdev->dev, "remove_device\n");
> +	if (vsoc_dev.regions_data) {
> +		for (i = 0; i < vsoc_dev.layout->region_count; ++i) {
> +			if (vsoc_dev.regions_data[i].device_created) {
> +				device_destroy(vsoc_dev.class,
> +					       MKDEV(vsoc_dev.major, i));
> +				vsoc_dev.regions_data[i].device_created = 0;
> +			}
> +			if (vsoc_dev.regions_data[i].irq_requested)
> +				free_irq(vsoc_dev.msix_entries[i].vector, NULL);
> +			vsoc_dev.regions_data[i].irq_requested = 0;
> +		}
> +		kfree(vsoc_dev.regions_data);
> +		vsoc_dev.regions_data = 0;
> +	}
> +	if (vsoc_dev.msix_enabled) {
> +		pci_disable_msix(pdev);
> +		vsoc_dev.msix_enabled = 0;
> +	}
> +	kfree(vsoc_dev.msix_entries);
> +	vsoc_dev.msix_entries = 0;
> +	vsoc_dev.regions = 0;
> +	if (vsoc_dev.class) {
> +		class_destroy(vsoc_dev.class);
> +		vsoc_dev.class = 0;
> +	}
> +	if (vsoc_dev.cdev_added) {
> +		cdev_del(&vsoc_dev.cdev);
> +		vsoc_dev.cdev_added = 0;
> +	}
> +	if (vsoc_dev.major && vsoc_dev.layout) {
> +		unregister_chrdev_region(MKDEV(vsoc_dev.major, 0),
> +					 vsoc_dev.layout->region_count);
> +		vsoc_dev.major = 0;
> +	}
> +	vsoc_dev.layout = 0;
> +	if (vsoc_dev.kernel_mapped_shm && pdev) {
                                          ^^^^
These tests can be removed since we checked at the start of the function.

> +		pci_iounmap(pdev, vsoc_dev.kernel_mapped_shm);
> +		vsoc_dev.kernel_mapped_shm = 0;
> +	}
> +	if (vsoc_dev.regs && pdev) {
                             ^^^^
> +		pci_iounmap(pdev, vsoc_dev.regs);
> +		vsoc_dev.regs = 0;
> +	}
> +	if (vsoc_dev.requested_regions && pdev) {
                                          ^^^^
> +		pci_release_regions(pdev);
> +		vsoc_dev.requested_regions = 0;
> +	}
> +	if (vsoc_dev.enabled_device && pdev) {
                                       ^^^^
> +		pci_disable_device(pdev);
> +		vsoc_dev.enabled_device = 0;
> +	}
> +	/* Do this last: it indicates that the device is not initialized. */
> +	vsoc_dev.dev = NULL;
> +}
> +

regards,
dan carpenter

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
