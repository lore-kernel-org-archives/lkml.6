Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7BB8C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 12:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BA3D214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 12:30:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BA3D214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbeIZSnR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 14:43:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53938 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726602AbeIZSnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 14:43:17 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8QCT5VW101375
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 08:30:27 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2mr9qnhh50-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 08:30:26 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Wed, 26 Sep 2018 13:30:24 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 26 Sep 2018 13:30:21 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8QCUJnw57016404
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Sep 2018 12:30:20 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 08B76A405D;
        Wed, 26 Sep 2018 15:30:01 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4B06FA4040;
        Wed, 26 Sep 2018 15:30:00 +0100 (BST)
Received: from oc7455500831.ibm.com (unknown [9.152.224.212])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 26 Sep 2018 15:30:00 +0100 (BST)
Subject: Re: [PATCH v11 00/26] guest dedicated crypto adapters
To:     Tony Krowiak <akrowiak@linux.vnet.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     freude@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com,
        bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
        alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com,
        alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com,
        jjherne@linux.vnet.ibm.com, thuth@redhat.com,
        pasic@linux.vnet.ibm.com, berrange@redhat.com,
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com,
        frankja@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>
References: <20180925231641.4954-1-akrowiak@linux.vnet.ibm.com>
From:   Christian Borntraeger <borntraeger@de.ibm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=borntraeger@de.ibm.com; prefer-encrypt=mutual; keydata=
 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
 syiRa+UVlsKmx1hsEg==
Date:   Wed, 26 Sep 2018 14:30:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
In-Reply-To: <20180925231641.4954-1-akrowiak@linux.vnet.ibm.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18092612-0016-0000-0000-0000020AD317
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092612-0017-0000-0000-00003261F258
Message-Id: <0a8946df-3c8a-b202-c109-95c3f9a309bc@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-26_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809260124
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I added the series (with a small fixup for 25 and added one Acked-by)
to 
git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git apv11

I can still add Rb and Acks.

I will probably merge this in kvms390/next at the end of the week.

On 09/26/2018 01:16 AM, Tony Krowiak wrote:
> From: Tony Krowiak <akrowiak@linux.ibm.com>
> 
> Notes:
> =====
> 
> Patches 1-2 (by David) are posted with this series because they are not
> currently available in our master branch, upon which this series is based,
> and because this series is dependent upon them.  
> 
> This patch series works with the v8 QEMU patches.
> 
> Abstract:
> ========
> 
> On s390, we have cryptographic coprocessor cards, which are modeled on
> Linux as devices on the AP bus. Each card can be partitioned into domains
> which can be thought of as a set of hardware registers for processing 
> crypto commands. Crypto commands are sent to a specific domain within a
> card is via a queue which is identified as a (card,domain) tuple. We model 
> this something like the following (assuming we have access to cards 3 and 
> 4 and domains 1 and 2):
> 
> AP -> card3 -> queue (3,1)
>             -> queue (3,2)
>    -> card4 -> queue (4,1)
>             -> queue (4,2)
> 
> If we want to virtualize this, we can use a feature provided by the
> hardware. We basically attach a satellite control block to our main
> hardware virtualization control block and the hardware takes care of
> most of the rest.
> 
> For this control block, we don't specify explicit tuples, but a list of
> cards and a list of domains. The guest will get access to the cross
> product.
> 
> Because of this, we need to take care that the lists provided to
> different guests don't overlap; i.e., we need to enforce sane
> configurations. Otherwise, one guest may get access to things like
> secret keys for another guest.
> 
> The idea of this patch set is to introduce a new device, the matrix
> device. This matrix device hangs off a different root and acts as the
> parent node for mdev devices.
> 
> If you now want to give the tuples (4,1) and (4,2), you need to do the
> following:
> 
> - Make sure the queues (4,1) and (4,2) belong to vfio_ap (see patches
>   #5 and #6)
> - Create the mediated device.
> - Assign card 4 and domains 1 and 2 to the mediated device
> - Optionally activate the mediated device.
> 
> QEMU will now simply consume the mediated device and things should work.
> 
> For a complete description of the architecture and concepts underlying
> the design, see the Documentation/s390/vfio-ap.txt file included with this
> patch set.
> 
> v10 => v11 Change log:
> =====================
> * Fixed race condition when setting KVM in the notifier
> * Removed KVM_S390_VM_CPU_FEAT_AP, no longer necessary
> * Fail vfio_ap module inti if AP instructions not available on host
> * Remove KVM_S390_VM_CPU_FEAT_AP
> * Expose VM enable/disable APIE attributes only if AP instructions
>   available on host.
> 
> v9 => v10 Change log:
> ===================
> * Replaced statically allocated with dynamically allocated matrix device
> * Made changes to drivers/iommu/Kconfig and arch/s390/Kconfig to fix the
>   dependency chain so that make menuconfig can be used to configure VFIO_AP
> * Added KVM device attributes to enable/disable hw interpretation of AP
>   instructions from userspace.
> * Return more meaningful error values from mediated matrix device
>   assignment sysfs interfaces
> * No longer enforcing convention that the ADM is a superset of the AQM at
>   for guest level 2
> * Broke 2 vSIE patches into several to make it easier to review them
> * Reworked vSIE patches to handle various CRYCB formats
> v8 => v9 Change log:
> ===================
> * Removed /sys/devices/virtual/misc/vfio_ap device and restored 
>   /sys/devices/vfio_ap/matrix device as parent of mediated matrix devices
> * Return boolean from ap_configuration_available() in ap.h instead of 0 or
>   an error.
> * Miscellaneous changes due to review comments 
> 
> v7 => v8 Change log:
> ===================
> * Removed the AP bus gained the ability to designate queues as 'used by
>   host' or as 'used by alternate driver(s)'. 
> * Removed 'activate' attribute from mediated device.
> * Do consistency checking during device assignment:
>   1. Verify that APQNs assigned to the mediated device are bound to the 
>      VFIO AP device driver
>   2. Verify that no APQN assigned to the mediated matrix device is assigned
>      to any other mediated matrix device.
> * The attributes of a mediated matrix device that is in use by a guest can
>   not be changed - i.e., no device assignment/unassignment allowed
> * A mediated matrix device that is in use by a guest can not be removed.
> * Removed all printk logging from VFIO AP driver; allowing return codes
>   from interfaces to describe the error.
> * Reworked the handling of the CRYCB in vSIE based upon patches introduced
>   by David in the mainline. 
> 
> v6 => v7 Change log:
> ===================
> * The AP bus gained the ability to designate queues as 'used by host'
>   or as 'used by alternate driver(s)'. This allows us to authorise access
>   (via the CRYCB) to queues that are not currently bound to the vfio_ap
>   driver. If a  vfio_ap owned queue diss- and reapears it's guaranteed
>   to get bound back to the vfio_ap driver.
> * The mediated device gained an 'activate' attribute. Sharing conflicts are
>   checked on activation now. If the device was not activated, the mdev
>   open still implies activation. An active ap_matrix_mdev device claims
>   it's resources -- an inactive does not.
> * An active ap_matrix_mdev device can not be removed. An ap_matrix_mdev
>   that is hooked up with a guest can not be deactivated.
> * An active ap_matrix_mdev device rejects assign_* and deassign_*
>   operations. Thus changing the CRYCB masks of a guest in order to
>   accomplys certain hotplug scenarios is planned, but not supported yet. In
>   previous versions it was possible to do those operations on a ap_matrix_mdev
>   that is hooked up to a guest, but the changes would take effect on the next
>   mdev_open. 
> * Synchronisation was reworked.
> * The sysfs path of the parent device changed from /sys/devices/vfio_ap/matrix/
>   to /sys/devices/virtual/misc/vfio_ap/. The parent device is a misc
>   device now.
> * The severity for most of the messages were reduced form error to
>   warning.
> *  We are not as thick headed about the zapq as we used to be in v6.
> 
> v5 => v6 Change log:
> ===================
> * Added VSIE support - thanks to Pierre Morel
> * Added VFIO_DEVICE_RESET ioctl
> * Zeroizing AP queues when mediated device released and when 
>   VFIO_DEVICE_RESET ioctl is invoked
> * Removed /arch/s390/kvm/kvm-ap.c and arch/s390/include/asm/kvm-ap.h and
>   moved guest matrix configuration into vfio driver
> * Removed temporary interfaces to be supplied by AP bus
> * Made the variable that keeps track of mdev instance count an atomic_t
>   type
> * Removed code iterating through vm_list to determine if another guest has
>   a queue .... not keep a list of matrix_mdev devices and verify against
>   that list. Removes the need for the kvm_lock.
> * Added a sysfs attribute for the mediated matrix device to display the
>   matrix contained in the guest's CRYCB if a guest is using the mdev.
> 
> 
> v4 => v5 Change log:
> ===================
> * Verify AP queues bound to driver in mediated device open callback, prior
>   to configuring the matrix in the CRYCB
> * Implement VFIO_DEVICE_RESET ioctl
> * Zeroize queues on guest entry and exit
> * Removed vnet from all email IBM email addresses referenced
> * Add synchronization in mdev create/remove and open/release.
> 
> v4 => v5 Change log:
> ===================
> * Added code to mdev open callback to ensure not more than one vfio-ap
>   device can be opened by a guest.
> * Interpret AP instructions by default
> * Removed patch implementing interface to enable/disable AP interpretation,
>   since that will now be done by default
> * Removed patch to reset crypto attributes for ALL vcpus. That will be 
>   submitted as a single patch since it will not be needed in this series - 
>   i.e., it was called from the interface to enable/disable AP instructions
> * All code for initializing crypto for a guest has been moved back to 
>   kvm-s390.c, kvm_s390_crypto_init(kvm) function
> * Maintaining a module reference count for the vfio_ap module so it is not
>   removed while a guest with AP devices is running.
> 
> v3 => v4 Change log:
> ===================
> * Resolved issue with enabling ZCRYPT when KVM is enabled by using
>   #ifdef ZCRYPT in relevant functions
> * Added patch with a new function for resetting the crypto attributes
>   for all vcpus to resolve the issue raised with running vcpus getting out 
>   of sync.
> * Removed KVM_S390_VM_CRYPTO_INTERPRET_AP: Setting interpretive exec mode
>   from vfio_ap driver when mdev device is opened.
> 
> v2 => v3 Change log:
> ===================
> * Set APIE in VCPU setup function
> * Renamed patch 13/15:
>     KVM: s390: Configure the guest's CRYCB
>     KVM: s390: Configure the guest's AP devices
> * Fixed problem with building arch/s390/kvm/kvm-ap.c when CONFIG_ZCRYPT
>   not selected 
> * Removed patch introducing VSIE support for AP pending further 
>   investigation
> * Initialized AP maximum mask sizes - i.e., APM, AQM and ADM - from info
>   returned from PQAP(QCI) function
> * Introduced a new device attribute to the KVM_S390_VM_CRYPTO attribute
>   group for setting a flag via the KVM_SET_DEVICE_ATTR ioctl to indicate
>   whether ECA_APIE should be set or not. The flag is used in the 
>   kvm_s390_vcpu_crypto_setup() function to set ECA_APIE in the SIE block. 
>   
> 
> v1 => v2 Change log:
> ===================
> * Added documentation vfio-ap.txt
> * Renamed vfio_ap_matrix module and device driver to vfio_ap
> * Use device core device list instead of maintaining list of matrix
>   devices in driver
> * Added VSIE support for AP
> * Create matrix device before registering VFIO AP device driver with the
>   AP bus
> * Renamed the following files in drivers/s390/crypto:
>   * vfio_ap_matrix.drv -> vfio_ap_drv
>   * vfio_ap_matrix_private.h -> vfio_ap_private.h
>   * vfio_ap_matrix_ops.c -> vfio_ap_ops.c
> * arch/s390/include/asm/kvm/ap-matrix-config.h
>   * Renamed to kvm-ap.h
>   * Changed the data type of the bit mask fields for the matrix structure
>     to unsigned long and create them with DECLARE_BITMAP 
>   * Changed #define prefixes from AP_MATRIX to KVM_AP
>   * Changed function and structure prefixes from ap_matrix to kvm_ap
>   * Added function interface to check if AP Extended Addressing (APXA)
>     facility is installedCRYCB_FORMAT_MASK
>   * Added function interface to get the maximum ID for AP mask type
>   * Added function interface to set the AP execution mode
> * arch/s390/kvm/ap-matrix-config.c
>   * Renamed to kvm-ap.c
>   * Changed function prefixes from ap_matrix to kvm_ap
>   * Added function to check if AP Extended Addressing (APXA) facility is
>     installed
>   * Added function to get the maximum ID for AP mask type
>   * Added function to set the AP execution mode
>   * Added a boolean parameter to the functions that retrieve the APM, AQM
>     and ADM bit mask fields from the CRYCB. If true, then the function
>     will clear the bits in the mask before returning a reference to it
>   * Added validation to verify that APM, AQM and ADM bits that are set do
>     not exceed the maximum ID value allowed
>   * 
> * arch/s390/include/asm/kvm_host.h
>   * Changed defined for ECA_AP to ECA_APIE - interpretive execution mode
>   * Added a flag to struct kvm_s390_crypto to indicate whether the 
>     KVM_S390_VM_CPU_FEAT_AP CPU model feature for AP facilities is set
>   * Added two CPU facilities features to set STFLE.12 and STFLE.15
> * arch/s390/kvm/kvm-s390.c
>   * Added initialization for new KVM_S390_VM_CPU_FEAT_AP CPU model feature
>   * Removed kvm_s390_apxa_installed() function
>   * Changed call to kvm_s390_apxa_installed() which has been removed to a
>     call to new kvm_ap_apxa_installed() function.
>   * Added code to kvm_s390_vcpu_crypto_setup() to set the new CPU model 
>     feature flag in the kvm_s390_crypto structure 
>   * Added CRYCB_FORMAT_MASK to mask CRYCBD
> * arch/s390/tools/gen_facilities.c
>   * Added STFLE.12 and STFLE.15 to struct facility _def
> * drivers/s390/crypto/vfio_ap_matrix_private.h
>   * Changed name of file to vfio_ap.private.h
>   * Changed #define prefixes from VFIO_AP_MATRIX to VFIO_AP
>   * struct ap_matrix: removed list fields and locks
>   * struct vfio_ap_queue: removed list field
>   * Renamed functions ap_matrix_mdev_register and ap_matrix_mdev_unregister
>     to vfio_ap_mdev_register and vfio_ap_mdev_unregister respectively
> * drivers/s390/crypto/vfio_ap_matrix_drv.c
>   * Renamed file to drivers/s390/crypto/vfio_ap_drv.c
>   * Changed all #define, structure and function prefixes to vfio_ap
>   * probe function
>     * Changed root device name for the matrix device to vfio_ap:
>       i.e., /sys/devices/vfio_ap/matrix
>     * No longer storing the AP queue device in a list, it is retrievable via
>       the device core
>     * Removed unnecessary check whether matrix device exists
>     * Store the vfio_ap_queue structure in the private field of the ap_queue
>       structure rather than using list interface
>   * remove function
>     * Retrieve vfio_ap_queue structure from the struct ap_queue private 
>       data rather than from a list
>   * Removed unnecesary check 
> * drivers/s390/crypto/vfio_ap_matrix_ops.c
>   * Renamed file to vfio_ap_ops.c
>   * Changed #define prefixes from AP_MATRIX to VFIO_AP
>   * Changed function name prefixes from ap_matrix to vfio_ap
>   * Removed ioctl to configure the CRYCB
>   * create function
>     * Removed ap_matrix_mdev_find_by_uuid() function - function is provided
>       by mdev core
>     * Removed available_instances verification, provided by mdev core
>     * Removed check to see if mediated device exists, handled by mdev core
>   * notifier function
>     * Configuring matrix here instead of via ioctl
>     * Set interpretive execution mode for all VCPUs
>    * Removed R/O attributes to display adapters and domains
>    * Added an R/O attribute to display the matrix
>   * assign_control_domain mdev attribute:
>     * Removed check to see if the domain is installed on the linux host
>     * Added check to verify the control domain ID does not exceed the max 
>       value
>   * assign_adapter mdev attribute:
>     * Added check to verify the adapter ID does not exceed the max 
>       value
>     * If any APQNs configured for the mediated matrix device that
>       have an APID matching the adapter ID being assigned are not
>       bound to the vfio_ap device driver then it is assumed that the APQN is 
>       bound to another driver and assignment will fail
>   * assign_domain mdev attribute:
>     * Added check to verify the domain ID does not exceed the max 
>       value
>     * If any APQNs configured for the mediated matrix device that
>       have an APQI matching the domain ID being assigned are not
>       bound to the vfio_ap device driver then it is assumed that the APQN is 
>       bound to another driver and assignment will fail
> * tools/arch/s390/include/uapi/asm/kvm.h
>   * removed  KVM_S390_VM_CPU_FEAT_AP feature definition
> 
> David Hildenbrand (2):
>   KVM: s390: vsie: simulate VCPU SIE entry/exit
>   KVM: s390: introduce and use KVM_REQ_VSIE_RESTART
> 
> Pierre Morel (9):
>   KVM: s390: Clear Crypto Control Block when using vSIE
>   KVM: s390: vsie: Do the CRYCB validation first
>   KVM: s390: vsie: Make use of CRYCB FORMAT2 clear
>   KVM: s390: vsie: Allow CRYCB FORMAT-2
>   KVM: s390: vsie: allow CRYCB FORMAT-1
>   KVM: s390: vsie: allow CRYCB FORMAT-0
>   KVM: s390: vsie: allow guest FORMAT-0 CRYCB on host FORMAT-1
>   KVM: s390: vsie: allow guest FORMAT-1 CRYCB on host FORMAT-2
>   KVM: s390: vsie: allow guest FORMAT-0 CRYCB on host FORMAT-2
> 
> Tony Krowiak (15):
>   KVM: s390: refactor crypto initialization
>   s390: vfio-ap: base implementation of VFIO AP device driver
>   s390: vfio-ap: register matrix device with VFIO mdev framework
>   s390: vfio-ap: sysfs interfaces to configure adapters
>   s390: vfio-ap: sysfs interfaces to configure domains
>   s390: vfio-ap: sysfs interfaces to configure control domains
>   s390: vfio-ap: sysfs interface to view matrix mdev matrix
>   KVM: s390: interfaces to clear CRYCB masks
>   s390: vfio-ap: implement mediated device open callback
>   s390: vfio-ap: implement VFIO_DEVICE_GET_INFO ioctl
>   s390: vfio-ap: zeroize the AP queues
>   s390: vfio-ap: implement VFIO_DEVICE_RESET ioctl
>   KVM: s390: device attrs to enable/disable AP interpretation
>   KVM: s390: CPU model support for AP virtualization
>   s390: doc: detailed specifications for AP virtualization
> 
>  Documentation/s390/vfio-ap.txt        | 782 +++++++++++++++++++++
>  MAINTAINERS                           |  12 +
>  arch/s390/Kconfig                     |  11 +
>  arch/s390/include/asm/kvm_host.h      |   7 +
>  arch/s390/include/uapi/asm/kvm.h      |   2 +
>  arch/s390/kvm/kvm-s390.c              | 135 ++--
>  arch/s390/kvm/kvm-s390.h              |   1 +
>  arch/s390/kvm/vsie.c                  | 208 +++++-
>  arch/s390/tools/gen_facilities.c      |   2 +
>  drivers/iommu/Kconfig                 |   8 +
>  drivers/s390/crypto/Makefile          |   4 +
>  drivers/s390/crypto/vfio_ap_drv.c     | 157 +++++
>  drivers/s390/crypto/vfio_ap_ops.c     | 960 ++++++++++++++++++++++++++
>  drivers/s390/crypto/vfio_ap_private.h |  88 +++
>  include/uapi/linux/vfio.h             |   2 +
>  15 files changed, 2319 insertions(+), 60 deletions(-)
>  create mode 100644 Documentation/s390/vfio-ap.txt
>  create mode 100644 drivers/s390/crypto/vfio_ap_drv.c
>  create mode 100644 drivers/s390/crypto/vfio_ap_ops.c
>  create mode 100644 drivers/s390/crypto/vfio_ap_private.h
> 

