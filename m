Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF3F7C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 06:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ACDD2156D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 06:54:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ACDD2156D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbeI0NKs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 09:10:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55764 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727008AbeI0NKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 09:10:48 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8R6lsWB056975
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 02:54:03 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2mrrqs434c-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 02:54:03 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <freude@linux.ibm.com>;
        Thu, 27 Sep 2018 07:54:01 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 27 Sep 2018 07:53:56 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8R6rsKt66125826
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 27 Sep 2018 06:53:54 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6B9BBA4053;
        Thu, 27 Sep 2018 09:53:35 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8DB86A4057;
        Thu, 27 Sep 2018 09:53:34 +0100 (BST)
Received: from [10.0.2.15] (unknown [9.152.224.41])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 27 Sep 2018 09:53:34 +0100 (BST)
Subject: Re: [PATCH v11 26/26] s390: doc: detailed specifications for AP
 virtualization
To:     Alex Williamson <alex.williamson@redhat.com>,
        Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, borntraeger@de.ibm.com,
        cohuck@redhat.com, kwankhede@nvidia.com,
        bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
        pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com,
        mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com,
        thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com,
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com,
        frankja@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>
References: <20180925231641.4954-1-akrowiak@linux.vnet.ibm.com>
 <20180925231641.4954-27-akrowiak@linux.vnet.ibm.com>
 <20180926164222.74731b74@t450s.home>
From:   Harald Freudenberger <freude@linux.ibm.com>
Date:   Thu, 27 Sep 2018 08:53:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180926164222.74731b74@t450s.home>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18092706-0028-0000-0000-000002FF2F36
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092706-0029-0000-0000-000023B94BE8
Message-Id: <26fba5a1-01b9-177d-2da8-6f7b58422bbc@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-27_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809270070
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.09.2018 00:42, Alex Williamson wrote:
> On Tue, 25 Sep 2018 19:16:41 -0400
> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>
>> From: Tony Krowiak <akrowiak@linux.ibm.com>
>>
>> This patch provides documentation describing the AP architecture and
>> design concepts behind the virtualization of AP devices. It also
>> includes an example of how to configure AP devices for exclusive
>> use of KVM guests.
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
>> ---
>>  Documentation/s390/vfio-ap.txt | 782 +++++++++++++++++++++++++++++++++
>>  MAINTAINERS                    |   1 +
>>  2 files changed, 783 insertions(+)
>>  create mode 100644 Documentation/s390/vfio-ap.txt
> ...
>> +Example:
>> +=======
>> +Let's now provide an example to illustrate how KVM guests may be given
>> +access to AP facilities. For this example, we will show how to configure
>> +three guests such that executing the lszcrypt command on the guests would
>> +look like this:
>> +
>> +Guest1
>> +------
>> +CARD.DOMAIN TYPE  MODE
>> +------------------------------
>> +05          CEX5C CCA-Coproc
>> +05.0004     CEX5C CCA-Coproc
>> +05.00ab     CEX5C CCA-Coproc
>> +06          CEX5A Accelerator
>> +06.0004     CEX5A Accelerator
>> +06.00ab     CEX5C CCA-Coproc
>> +
>> +Guest2
>> +------
>> +CARD.DOMAIN TYPE  MODE
>> +------------------------------
>> +05          CEX5A Accelerator
>> +05.0047     CEX5A Accelerator
>> +05.00ff     CEX5A Accelerator (5,4), (5,171), (6,4), (6,171),
>                                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> Seems like an unfinished thought here. 
>
>> +
>> +Guest2
>> +------
>> +CARD.DOMAIN TYPE  MODE
>> +------------------------------
>> +06          CEX5A Accelerator
>> +06.0047     CEX5A Accelerator
>> +06.00ff     CEX5A Accelerator
>> +
>> +These are the steps:
>> +
>> +1. Install the vfio_ap module on the linux host. The dependency chain for the
>> +   vfio_ap module is:
>> +   * iommu
>> +   * s390
>> +   * zcrypt
>> +   * vfio
>> +   * vfio_mdev
>> +   * vfio_mdev_device
>> +   * KVM
>> +
>> +   To build the vfio_ap module, the kernel build must be configured with the
>> +   following Kconfig elements selected:
>> +   * IOMMU_SUPPORT
>> +   * S390
>> +   * ZCRYPT
>> +   * S390_AP_IOMMU
>> +   * VFIO
>> +   * VFIO_MDEV
>> +   * VFIO_MDEV_DEVICE
>> +   * KVM
>> +
>> +   If using make menuconfig select the following to build the vfio_ap module:
>> +   -> Device Drivers
>> +      -> IOMMU Hardware Support
>> +         select S390 AP IOMMU Support
>> +      -> VFIO Non-Privileged userspace driver framework
>> +         -> Mediated device driver frramework
>> +            -> VFIO driver for Mediated devices
>> +   -> I/O subsystem
>> +      -> VFIO support for AP devices
>> +
>> +2. Secure the AP queues to be used by the three guests so that the host can not
>> +   access them. To secure them, there are two sysfs files that specify
>> +   bitmasks marking a subset of the APQN range as 'usable by the default AP
>> +   queue device drivers' or 'not usable by the default device drivers' and thus
>> +   available for use by the vfio_ap device driver'. The sysfs files containing
>> +   the sysfs locations of the masks are:
>> +
>> +   /sys/bus/ap/apmask
>> +   /sys/bus/ap/aqmask
>> +
>> +   The 'apmask' is a 256-bit mask that identifies a set of AP adapter IDs
>> +   (APID). Each bit in the mask, from most significant to least significant bit,
>> +   corresponds to an APID from 0-255. If a bit is set, the APID is marked as
>> +   usable only by the default AP queue device drivers; otherwise, the APID is
>> +   usable by the vfio_ap device driver.
>> +
>> +   The 'aqmask' is a 256-bit mask that identifies a set of AP queue indexes
>> +   (APQI). Each bit in the mask, from most significant to least significant bit,
>> +   corresponds to an APQI from 0-255. If a bit is set, the APQI is marked as
>> +   usable only by the default AP queue device drivers; otherwise, the APQI is
>> +   usable by the vfio_ap device driver.
>> +
>> +   The APQN of each AP queue device assigned to the linux host is checked by the
>> +   AP bus against the set of APQNs derived from the cross product of APIDs
>> +   and APQIs marked as usable only by the default AP queue device drivers. If a
>> +   match is detected,  only the default AP queue device drivers will be probed;
>> +   otherwise, the vfio_ap device driver will be probed.
>> +
>> +   By default, the two masks are set to reserve all APQNs for use by the default
>> +   AP queue device drivers. There are two ways the default masks can be changed:
>> +
>> +   1. The masks can be changed at boot time with the kernel command line
>> +      like this:
>> +
>> +         ap.apmask=0xffff ap.aqmask=0x40
>> +
>> +         This would give these two pools:
>> +
>> +            default drivers pool:    adapter 0-15, domain 1
>> +            alternate drivers pool:  adapter 16-255, domains 2-255
> What happened to domain 0?  I'm also a little confused by the bit
> ordering.  If 0x40 is bit 1 and 0xffff is bits 0-15, then the least
> significant bit is furthest left?  Did I miss documentation of that?
>
>> +
>> +   2. The sysfs mask files can also be edited by echoing a string into the
>> +      respective file in one of two formats:
>> +
>> +      * An absolute hex string starting with 0x - like "0x12345678" - sets
>> +        the mask. If the given string is shorter than the mask, it is padded
>> +        with 0s on the right. If the string is longer than the mask, the
>> +        operation is terminated with an error (EINVAL).
> And this does say zero padding on the right, but then in the next
> bullet our hex digits use normal least significant bit right notation,
> ie. 0x41 is 65, not 82, correct?
>
>> +
>> +      * A plus ('+') or minus ('-') followed by a numerical value. Valid
>> +        examples are "+1", "-13", "+0x41", "-0xff" and even "+0" and "-0". Only
>> +        the corresponding bit in the mask is switched on ('+') or off ('-'). The
>> +        values may also be specified in a comma-separated list to switch more
>> +        than one bit on or off.
>> +
>> +   To secure the AP queues 05.0004, 05.0047, 05.00ab, 05.00ff, 06.0004, 06.0047,
>> +   06.00ab, and 06.00ff for use by the vfio_ap device driver, the corresponding
>> +   APQNs must be removed from the masks as follows:
>> +
>> +      echo -5,-6 > /sys/bus/ap/apmask
>> +
>> +      echo -4,-0x47,-0xab,-0xff > /sys/bus/ap/aqmask
> Other than the bit ordering confusion, I like this +/- scheme.
>
>> +
>> +   This will result in AP queues 05.0004, 05.0047, 05.00ab, 05.00ff, 06.0004,
>> +   06.0047, 06.00ab, and 06.00ff getting bound to the vfio_ap device driver. The
>> +   sysfs directory for the vfio_ap device driver will now contain symbolic links
>> +   to the AP queue devices bound to it:
>> +
>> +   /sys/bus/ap
>> +   ... [drivers]
>> +   ...... [vfio_ap]
>> +   ......... [05.0004]
>> +   ......... [05.0047]
>> +   ......... [05.00ab]
>> +   ......... [05.00ff]
>> +   ......... [06.0004]
>> +   ......... [06.0047]
>> +   ......... [06.00ab]
>> +   ......... [06.00ff]
>> +
>> +   Keep in mind that only type 10 and newer adapters (i.e., CEX4 and later)
>> +   can be bound to the vfio_ap device driver. The reason for this is to
>> +   simplify the implementation by not needlessly complicating the design by
>> +   supporting older devices that will go out of service in the relatively near
>> +   future and for which there are few older systems on which to test.
>> +
>> +   The administrator, therefore, must take care to secure only AP queues that
>> +   can be bound to the vfio_ap device driver. The device type for a given AP
>> +   queue device can be read from the parent card's sysfs directory. For example,
>> +   to see the hardware type of the queue 05.0004:
>> +
>> +   cat /sys/bus/ap/devices/card05/hwtype
>> +
>> +   The hwtype must be 10 or higher (CEX4 or newer) in order to be bound to the
>> +   vfio_ap device driver.
>> +
>> +3. Create the mediated devices needed to configure the AP matrixes for the
>> +   three guests and to provide an interface to the vfio_ap driver for
>> +   use by the guests:
>> +
>> +   /sys/devices/vfio_ap/matrix/
>> +   --- [mdev_supported_types]
>> +   ------ [vfio_ap-passthrough] (passthrough mediated matrix device type)
>> +   --------- create
>> +   --------- [devices]
>> +
>> +   To create the mediated devices for the three guests:
>> +
>> +	uuidgen > create
>> +	uuidgen > create
>> +	uuidgen > create
>> +
>> +        or
>> +
>> +        echo $uuid1 > create
>> +        echo $uuid2 > create
>> +        echo $uuid3 > create
>> +
>> +   This will create three mediated devices in the [devices] subdirectory named
>> +   after the UUID written to the create attribute file. We call them $uuid1,
>> +   $uuid2 and $uuid3 and this is the sysfs directory structure after creation:
>> +
>> +   /sys/devices/vfio_ap/matrix/
>> +   --- [mdev_supported_types]
>> +   ------ [vfio_ap-passthrough]
>> +   --------- [devices]
>> +   ------------ [$uuid1]
>> +   --------------- assign_adapter
>> +   --------------- assign_control_domain
>> +   --------------- assign_domain
>> +   --------------- matrix
>> +   --------------- unassign_adapter
>> +   --------------- unassign_control_domain
>> +   --------------- unassign_domain
>> +
>> +   ------------ [$uuid2]
>> +   --------------- assign_adapter
>> +   --------------- assign_control_domain
>> +   --------------- assign_domain
>> +   --------------- matrix
>> +   --------------- unassign_adapter
>> +   ----------------unassign_control_domain
>> +   ----------------unassign_domain
>> +
>> +   ------------ [$uuid3]
>> +   --------------- assign_adapter
>> +   --------------- assign_control_domain
>> +   --------------- assign_domain
>> +   --------------- matrix
>> +   --------------- unassign_adapter
>> +   ----------------unassign_control_domain
>> +   ----------------unassign_domain
>> +
>> +4. The administrator now needs to configure the matrixes for the mediated
>> +   devices $uuid1 (for Guest1), $uuid2 (for Guest2) and $uuid3 (for Guest3).
>> +
>> +   This is how the matrix is configured for Guest1:
>> +
>> +      echo 5 > assign_adapter
>> +      echo 6 > assign_adapter
>> +      echo 4 > assign_domain
>> +      echo 0xab > assign_domain
>> +
>> +      Control domains can similarly be assigned using the assign_control_domain
>> +      sysfs file.
>> +
>> +      If a mistake is made configuring an adapter, domain or control domain,
>> +      you can use the unassign_xxx files to unassign the adapter, domain or
>> +      control domain.
>> +
>> +      To display the matrix configuration for Guest1:
>> +
>> +         cat matrix
>> +
>> +   This is how the matrix is configured for Guest2:
>> +
>> +      echo 5 > assign_adapter
>> +      echo 0x47 > assign_domain
>> +      echo 0xff > assign_domain
>> +
>> +   This is how the matrix is configured for Guest3:
>> +
>> +      echo 6 > assign_adapter
>> +      echo 0x47 > assign_domain
>> +      echo 0xff > assign_domain
>> +
> I'm curious why this interface didn't adopt the +/- notation invented
> above for consistency.  Too difficult to do rollbacks with a string on
> entries?
>
> Looks pretty reasonable other than the points of confusion noted.
> Thanks,
>
> Alex
>
Hello Alex

the AP bus  apmask and aqmask interface is not part of this patch series.
It's a general concept not only related to KVM and vfio but may be used
(and will) by other kernel and userspace features.
The bit ordering follows other implementations in the s390 (big endian)
realm where bit counting starts with 0 on the very left side and increases to
the right. All the AP bus stuff obeys to this (maybe historical) scheme.

Please have a look on the patches which introduced this mask API:
- s390/zcrypt: AP bus support for alternate driver(s) :
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7e0bdbe5c21cb8316a694e46ad5aad339f6894a6
- s390/zcrypt: hex string mask improvements for apmask and aqmask:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3d8f60d38e249f989a7fca9c2370c31c3d5487e1
The patch headers should describe the behavior and the syntax
of the recognized string patterns in more detail.

regards
Harald Freudenberger (maintainer of the s390 AP bus and zcrypt device driver code)


