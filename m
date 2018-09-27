Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC01C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3978D216C4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:19:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3978D216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbeI1Bjk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 21:39:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38076 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728213AbeI1Bjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 21:39:40 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8RJJmC7085416
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 15:19:52 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ms277gmqe-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 15:19:51 -0400
Received: from localhost
        by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Thu, 27 Sep 2018 13:19:50 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com (9.17.130.18)
        by e35.co.us.ibm.com (192.168.1.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 27 Sep 2018 13:19:46 -0600
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8RJJhO639125180
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 27 Sep 2018 12:19:43 -0700
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F3ECC7805C;
        Thu, 27 Sep 2018 13:19:42 -0600 (MDT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 866BB78063;
        Thu, 27 Sep 2018 13:19:39 -0600 (MDT)
Received: from oc8043147753.ibm.com (unknown [9.85.201.36])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 27 Sep 2018 13:19:39 -0600 (MDT)
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
        frankja@linux.ibm.com
References: <20180925231641.4954-1-akrowiak@linux.vnet.ibm.com>
 <20180925231641.4954-27-akrowiak@linux.vnet.ibm.com>
 <20180926164222.74731b74@t450s.home>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Thu, 27 Sep 2018 15:19:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180926164222.74731b74@t450s.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18092719-0012-0000-0000-000016BD0A05
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009782; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000267; SDB=6.01094523; UDB=6.00565795; IPR=6.00874558;
 MB=3.00023533; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-27 19:19:49
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092719-0013-0000-0000-0000548E20F2
Message-Id: <a9b69a08-e415-4f76-d36c-73fc2a354f9e@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-27_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809270179
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/26/2018 06:42 PM, Alex Williamson wrote:
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
>>   Documentation/s390/vfio-ap.txt | 782 +++++++++++++++++++++++++++++++++
>>   MAINTAINERS                    |   1 +
>>   2 files changed, 783 insertions(+)
>>   create mode 100644 Documentation/s390/vfio-ap.txt
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
>                                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
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
> 
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
> 
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
> 
> Other than the bit ordering confusion, I like this +/- scheme.

The following fixup attempts to clarify the bit ordering confusion,
hopefully this is acceptable.

-----------------------------------8<-----------------------------------

From: Tony Krowiak <akrowiak@linux.ibm.com>
Date: Thu, 27 Sep 2018 14:51:12 -0400
Subject: [FIXUP v10] fixup! s390: doc: detailed specifications for AP
  virtualization

Better explains mask bit ordering.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
---
  Documentation/s390/vfio-ap.txt | 127 +++++++++++++++++++++++----------
  1 file changed, 91 insertions(+), 36 deletions(-)

diff --git a/Documentation/s390/vfio-ap.txt b/Documentation/s390/vfio-ap.txt
index bec67eb7141c..599eb0f75c07 100644
--- a/Documentation/s390/vfio-ap.txt
+++ b/Documentation/s390/vfio-ap.txt
@@ -123,21 +123,24 @@ to identify the adapters, usage domains and 
control domains assigned to the KVM
  guest:

  * The AP Mask (APM) field is a bit mask that identifies the AP 
adapters assigned
-  to the KVM guest. Each bit in the mask, from most significant to least
-  significant bit, corresponds to an APID from 0-255. If a bit is set, the
-  corresponding adapter is valid for use by the KVM guest.
+  to the KVM guest. Each bit in the mask, from left to right (i.e. from 
most
+  significant to least significant bit in big endian order), corresponds to
+  an APID from 0-255. If a bit is set, the corresponding adapter is 
valid for
+  use by the KVM guest.

  * The AP Queue Mask (AQM) field is a bit mask identifying the AP usage 
domains
-  assigned to the KVM guest. Each bit in the mask, from most significant to
-  least significant bit, corresponds to an AP queue index (APQI) from 
0-255. If
-  a bit is set, the corresponding queue is valid for use by the KVM guest.
+  assigned to the KVM guest. Each bit in the mask, from left to right 
(i.e. from
+  most significant to least significant bit in big endian order), 
corresponds to
+  an AP queue index (APQI) from 0-255. If a bit is set, the 
corresponding queue
+  is valid for use by the KVM guest.

  * The AP Domain Mask field is a bit mask that identifies the AP 
control domains
    assigned to the KVM guest. The ADM bit mask controls which domains 
can be
    changed by an AP command-request message sent to a usage domain from the
-  guest. Each bit in the mask, from least significant to most 
significant bit,
-  corresponds to a domain from 0-255. If a bit is set, the 
corresponding domain
-  can be modified by an AP command-request message sent to a usage domain.
+  guest. Each bit in the mask, from left to right (i.e. from most 
significant to
+  least significant bit in big endian order), corresponds to a domain from
+  0-255. If a bit is set, the corresponding domain can be modified by an AP
+  command-request message sent to a usage domain.

  If you recall from the description of an AP Queue, AP instructions include
  an APQN to identify the AP queue to which an AP command-request 
message is to be
@@ -503,23 +506,34 @@ These are the steps:
     access them. To secure them, there are two sysfs files that specify
     bitmasks marking a subset of the APQN range as 'usable by the 
default AP
     queue device drivers' or 'not usable by the default device drivers' 
and thus
-   available for use by the vfio_ap device driver'. The sysfs files 
containing
-   the sysfs locations of the masks are:
+   available for use by the vfio_ap device driver'. The location of the 
sysfs
+   files containing the masks are:

     /sys/bus/ap/apmask
     /sys/bus/ap/aqmask

     The 'apmask' is a 256-bit mask that identifies a set of AP adapter IDs
-   (APID). Each bit in the mask, from most significant to least 
significant bit,
-   corresponds to an APID from 0-255. If a bit is set, the APID is 
marked as
-   usable only by the default AP queue device drivers; otherwise, the 
APID is
-   usable by the vfio_ap device driver.
+   (APID). Each bit in the mask, from left to right (i.e., from most 
significant
+   to least significant bit in big endian order), corresponds to an 
APID from
+   0-255. If a bit is set, the APID is marked as usable only by the 
default AP
+   queue device drivers; otherwise, the APID is usable by the vfio_ap
+   device driver.

     The 'aqmask' is a 256-bit mask that identifies a set of AP queue 
indexes
-   (APQI). Each bit in the mask, from most significant to least 
significant bit,
-   corresponds to an APQI from 0-255. If a bit is set, the APQI is 
marked as
-   usable only by the default AP queue device drivers; otherwise, the 
APQI is
-   usable by the vfio_ap device driver.
+   (APQI). Each bit in the mask, from left to right (i.e., from most 
significant
+   to least significant bit in big endian order), corresponds to an 
APQI from
+   0-255. If a bit is set, the APQI is marked as usable only by the 
default AP
+   queue device drivers; otherwise, the APQI is usable by the vfio_ap 
device
+   driver.
+
+   Take, for example, the following mask:
+
+      0x7dffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
+
+    It indicates:
+
+      1, 2, 3, 4, 5, and 7-255 belong to the default drivers' pool, and 
0 and 6
+      belong to the vfio_ap device driver's pool.

     The APQN of each AP queue device assigned to the linux host is 
checked by the
     AP bus against the set of APQNs derived from the cross product of APIDs
@@ -530,38 +544,79 @@ These are the steps:
     By default, the two masks are set to reserve all APQNs for use by 
the default
     AP queue device drivers. There are two ways the default masks can 
be changed:

-   1. The masks can be changed at boot time with the kernel command line
-      like this:
+   1. The sysfs mask files can be edited by echoing a string into the
+      respective sysfs mask file in one of two formats:
+
+      * An absolute hex string starting with 0x - like "0x12345678" - sets
+        the mask. If the given string is shorter than the mask, it is 
padded
+        with 0s on the right; for example, specifying a mask value of 
0x41 is
+        the same as specifying:
+
+ 
0x4100000000000000000000000000000000000000000000000000000000000000
+
+        Keep in mind that the mask reads from left to right (i.e., most
+        significant to least significant bit in big endian order), so 
the mask
+        above identifies device numbers 1 and 7 (01000001).
+
+        If the string is longer than the mask, the operation is 
terminated with
+        an error (EINVAL).
+
+      * Individual bits in the mask can be switched on and off by 
specifying
+        each bit number to be switched in a comma separated list. Each bit
+        number string must be prepended with a ('+') or minus ('-') to 
indicate
+        the corresponding bit is to be switched on ('+') or off ('-'). Some
+        valid values are:
+
+           "+0"    switches bit 0 on
+           "-13"   switches bit 13 off
+           "+0x41" switches bit 65 on
+           "-0xff" switches bit 255 off
+
+           The following example:
+              +0,-6,+0x47,-0xf0
+
+              Switches bits 0 and 71 (0x47) on
+              Switches bits 6 and 240 (0xf0) off
+
+        Note that the bits not specified in the list remain as they 
were before
+        the operation.
+
+   2. The masks can also be changed at boot time via parameters on the 
kernel
+      command line like this:

           ap.apmask=0xffff ap.aqmask=0x40

-         This would give these two pools:
+         This would create the following masks:

-            default drivers pool:    adapter 0-15, domain 1
-            alternate drivers pool:  adapter 16-255, domains 2-255
+            apmask:
+ 
0xffff000000000000000000000000000000000000000000000000000000000000

-   2. The sysfs mask files can also be edited by echoing a string into the
-      respective file in one of two formats:
+            aqmask:
+ 
0x4000000000000000000000000000000000000000000000000000000000000000

-      * An absolute hex string starting with 0x - like "0x12345678" - sets
-        the mask. If the given string is shorter than the mask, it is 
padded
-        with 0s on the right. If the string is longer than the mask, the
-        operation is terminated with an error (EINVAL).
+         Resulting in these two pools:

-      * A plus ('+') or minus ('-') followed by a numerical value. Valid
-        examples are "+1", "-13", "+0x41", "-0xff" and even "+0" and 
"-0". Only
-        the corresponding bit in the mask is switched on ('+') or off 
('-'). The
-        values may also be specified in a comma-separated list to 
switch more
-        than one bit on or off.
+            default drivers pool:    adapter 0-15, domain 1
+            alternate drivers pool:  adapter 16-255, domains 0, 2-255

+   Securing the APQNs for our example:
+   ----------------------------------
     To secure the AP queues 05.0004, 05.0047, 05.00ab, 05.00ff, 
06.0004, 06.0047,
     06.00ab, and 06.00ff for use by the vfio_ap device driver, the 
corresponding
-   APQNs must be removed from the masks as follows:
+   APQNs can either be removed from the default masks:

        echo -5,-6 > /sys/bus/ap/apmask

        echo -4,-0x47,-0xab,-0xff > /sys/bus/ap/aqmask

+   Or the masks can be set as follows:
+
+      echo 
0xf9ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff \
+      > apmask
+
+      echo 
0xf7fffffffffffffffeffffffffffffffffffffffffeffffffffffffffffffffe \
+      > aqmask
+
     This will result in AP queues 05.0004, 05.0047, 05.00ab, 05.00ff, 
06.0004,
     06.0047, 06.00ab, and 06.00ff getting bound to the vfio_ap device 
driver. The
     sysfs directory for the vfio_ap device driver will now contain 
symbolic links
-- 
2.19.0.221.g150f307

