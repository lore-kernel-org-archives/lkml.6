Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38280C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 11:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3A562168B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 11:42:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3A562168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729567AbeI1SFr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 14:05:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36444 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729308AbeI1SFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 14:05:46 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8SBdtHL121767
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 07:42:23 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mskggghh6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 07:42:23 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Fri, 28 Sep 2018 12:42:21 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 28 Sep 2018 12:42:17 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8SBgFpq56885490
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 28 Sep 2018 11:42:15 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CF273AE053;
        Fri, 28 Sep 2018 14:41:12 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 74E29AE04D;
        Fri, 28 Sep 2018 14:41:11 +0100 (BST)
Received: from oc7455500831.ibm.com (unknown [9.152.224.92])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 28 Sep 2018 14:41:11 +0100 (BST)
Subject: Re: [PATCH v11 26/26] s390: doc: detailed specifications for AP
 virtualization
To:     Tony Krowiak <akrowiak@linux.ibm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com,
        bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
        pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com,
        mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com,
        thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com,
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com,
        frankja@linux.ibm.com
References: <20180925231641.4954-1-akrowiak@linux.vnet.ibm.com>
 <20180925231641.4954-27-akrowiak@linux.vnet.ibm.com>
 <20180926164222.74731b74@t450s.home>
 <a9b69a08-e415-4f76-d36c-73fc2a354f9e@linux.ibm.com>
From:   Christian Borntraeger <borntraeger@de.ibm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=borntraeger@de.ibm.com; prefer-encrypt=mutual; keydata=
 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
 syiRa+UVlsKmx1hsEg==
Date:   Fri, 28 Sep 2018 13:42:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <a9b69a08-e415-4f76-d36c-73fc2a354f9e@linux.ibm.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18092811-0008-0000-0000-000002783CB0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092811-0009-0000-0000-000021E1499A
Message-Id: <2c045dc8-6b73-6b9d-5d1a-c256ca20685b@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-28_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809280119
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/27/2018 09:19 PM, Tony Krowiak wrote:

> The following fixup attempts to clarify the bit ordering confusion,
> hopefully this is acceptable.
> 

looks good to me, I will fold in.

> -----------------------------------8<-----------------------------------
> 
> From: Tony Krowiak <akrowiak@linux.ibm.com>
> Date: Thu, 27 Sep 2018 14:51:12 -0400
> Subject: [FIXUP v10] fixup! s390: doc: detailed specifications for AP
>  virtualization
> 
> Better explains mask bit ordering.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> ---
>  Documentation/s390/vfio-ap.txt | 127 +++++++++++++++++++++++----------
>  1 file changed, 91 insertions(+), 36 deletions(-)
> 
> diff --git a/Documentation/s390/vfio-ap.txt b/Documentation/s390/vfio-ap.txt
> index bec67eb7141c..599eb0f75c07 100644
> --- a/Documentation/s390/vfio-ap.txt
> +++ b/Documentation/s390/vfio-ap.txt
> @@ -123,21 +123,24 @@ to identify the adapters, usage domains and control domains assigned to the KVM
>  guest:
> 
>  * The AP Mask (APM) field is a bit mask that identifies the AP adapters assigned
> -  to the KVM guest. Each bit in the mask, from most significant to least
> -  significant bit, corresponds to an APID from 0-255. If a bit is set, the
> -  corresponding adapter is valid for use by the KVM guest.
> +  to the KVM guest. Each bit in the mask, from left to right (i.e. from most
> +  significant to least significant bit in big endian order), corresponds to
> +  an APID from 0-255. If a bit is set, the corresponding adapter is valid for
> +  use by the KVM guest.
> 
>  * The AP Queue Mask (AQM) field is a bit mask identifying the AP usage domains
> -  assigned to the KVM guest. Each bit in the mask, from most significant to
> -  least significant bit, corresponds to an AP queue index (APQI) from 0-255. If
> -  a bit is set, the corresponding queue is valid for use by the KVM guest.
> +  assigned to the KVM guest. Each bit in the mask, from left to right (i.e. from
> +  most significant to least significant bit in big endian order), corresponds to
> +  an AP queue index (APQI) from 0-255. If a bit is set, the corresponding queue
> +  is valid for use by the KVM guest.
> 
>  * The AP Domain Mask field is a bit mask that identifies the AP control domains
>    assigned to the KVM guest. The ADM bit mask controls which domains can be
>    changed by an AP command-request message sent to a usage domain from the
> -  guest. Each bit in the mask, from least significant to most significant bit,
> -  corresponds to a domain from 0-255. If a bit is set, the corresponding domain
> -  can be modified by an AP command-request message sent to a usage domain.
> +  guest. Each bit in the mask, from left to right (i.e. from most significant to
> +  least significant bit in big endian order), corresponds to a domain from
> +  0-255. If a bit is set, the corresponding domain can be modified by an AP
> +  command-request message sent to a usage domain.
> 
>  If you recall from the description of an AP Queue, AP instructions include
>  an APQN to identify the AP queue to which an AP command-request message is to be
> @@ -503,23 +506,34 @@ These are the steps:
>     access them. To secure them, there are two sysfs files that specify
>     bitmasks marking a subset of the APQN range as 'usable by the default AP
>     queue device drivers' or 'not usable by the default device drivers' and thus
> -   available for use by the vfio_ap device driver'. The sysfs files containing
> -   the sysfs locations of the masks are:
> +   available for use by the vfio_ap device driver'. The location of the sysfs
> +   files containing the masks are:
> 
>     /sys/bus/ap/apmask
>     /sys/bus/ap/aqmask
> 
>     The 'apmask' is a 256-bit mask that identifies a set of AP adapter IDs
> -   (APID). Each bit in the mask, from most significant to least significant bit,
> -   corresponds to an APID from 0-255. If a bit is set, the APID is marked as
> -   usable only by the default AP queue device drivers; otherwise, the APID is
> -   usable by the vfio_ap device driver.
> +   (APID). Each bit in the mask, from left to right (i.e., from most significant
> +   to least significant bit in big endian order), corresponds to an APID from
> +   0-255. If a bit is set, the APID is marked as usable only by the default AP
> +   queue device drivers; otherwise, the APID is usable by the vfio_ap
> +   device driver.
> 
>     The 'aqmask' is a 256-bit mask that identifies a set of AP queue indexes
> -   (APQI). Each bit in the mask, from most significant to least significant bit,
> -   corresponds to an APQI from 0-255. If a bit is set, the APQI is marked as
> -   usable only by the default AP queue device drivers; otherwise, the APQI is
> -   usable by the vfio_ap device driver.
> +   (APQI). Each bit in the mask, from left to right (i.e., from most significant
> +   to least significant bit in big endian order), corresponds to an APQI from
> +   0-255. If a bit is set, the APQI is marked as usable only by the default AP
> +   queue device drivers; otherwise, the APQI is usable by the vfio_ap device
> +   driver.
> +
> +   Take, for example, the following mask:
> +
> +      0x7dffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
> +
> +    It indicates:
> +
> +      1, 2, 3, 4, 5, and 7-255 belong to the default drivers' pool, and 0 and 6
> +      belong to the vfio_ap device driver's pool.
> 
>     The APQN of each AP queue device assigned to the linux host is checked by the
>     AP bus against the set of APQNs derived from the cross product of APIDs
> @@ -530,38 +544,79 @@ These are the steps:
>     By default, the two masks are set to reserve all APQNs for use by the default
>     AP queue device drivers. There are two ways the default masks can be changed:
> 
> -   1. The masks can be changed at boot time with the kernel command line
> -      like this:
> +   1. The sysfs mask files can be edited by echoing a string into the
> +      respective sysfs mask file in one of two formats:
> +
> +      * An absolute hex string starting with 0x - like "0x12345678" - sets
> +        the mask. If the given string is shorter than the mask, it is padded
> +        with 0s on the right; for example, specifying a mask value of 0x41 is
> +        the same as specifying:
> +
> + 0x4100000000000000000000000000000000000000000000000000000000000000
> +
> +        Keep in mind that the mask reads from left to right (i.e., most
> +        significant to least significant bit in big endian order), so the mask
> +        above identifies device numbers 1 and 7 (01000001).
> +
> +        If the string is longer than the mask, the operation is terminated with
> +        an error (EINVAL).
> +
> +      * Individual bits in the mask can be switched on and off by specifying
> +        each bit number to be switched in a comma separated list. Each bit
> +        number string must be prepended with a ('+') or minus ('-') to indicate
> +        the corresponding bit is to be switched on ('+') or off ('-'). Some
> +        valid values are:
> +
> +           "+0"    switches bit 0 on
> +           "-13"   switches bit 13 off
> +           "+0x41" switches bit 65 on
> +           "-0xff" switches bit 255 off
> +
> +           The following example:
> +              +0,-6,+0x47,-0xf0
> +
> +              Switches bits 0 and 71 (0x47) on
> +              Switches bits 6 and 240 (0xf0) off
> +
> +        Note that the bits not specified in the list remain as they were before
> +        the operation.
> +
> +   2. The masks can also be changed at boot time via parameters on the kernel
> +      command line like this:
> 
>           ap.apmask=0xffff ap.aqmask=0x40
> 
> -         This would give these two pools:
> +         This would create the following masks:
> 
> -            default drivers pool:    adapter 0-15, domain 1
> -            alternate drivers pool:  adapter 16-255, domains 2-255
> +            apmask:
> + 0xffff000000000000000000000000000000000000000000000000000000000000
> 
> -   2. The sysfs mask files can also be edited by echoing a string into the
> -      respective file in one of two formats:
> +            aqmask:
> + 0x4000000000000000000000000000000000000000000000000000000000000000
> 
> -      * An absolute hex string starting with 0x - like "0x12345678" - sets
> -        the mask. If the given string is shorter than the mask, it is padded
> -        with 0s on the right. If the string is longer than the mask, the
> -        operation is terminated with an error (EINVAL).
> +         Resulting in these two pools:
> 
> -      * A plus ('+') or minus ('-') followed by a numerical value. Valid
> -        examples are "+1", "-13", "+0x41", "-0xff" and even "+0" and "-0". Only
> -        the corresponding bit in the mask is switched on ('+') or off ('-'). The
> -        values may also be specified in a comma-separated list to switch more
> -        than one bit on or off.
> +            default drivers pool:    adapter 0-15, domain 1
> +            alternate drivers pool:  adapter 16-255, domains 0, 2-255
> 
> +   Securing the APQNs for our example:
> +   ----------------------------------
>     To secure the AP queues 05.0004, 05.0047, 05.00ab, 05.00ff, 06.0004, 06.0047,
>     06.00ab, and 06.00ff for use by the vfio_ap device driver, the corresponding
> -   APQNs must be removed from the masks as follows:
> +   APQNs can either be removed from the default masks:
> 
>        echo -5,-6 > /sys/bus/ap/apmask
> 
>        echo -4,-0x47,-0xab,-0xff > /sys/bus/ap/aqmask
> 
> +   Or the masks can be set as follows:
> +
> +      echo 0xf9ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff \
> +      > apmask
> +
> +      echo 0xf7fffffffffffffffeffffffffffffffffffffffffeffffffffffffffffffffe \
> +      > aqmask
> +
>     This will result in AP queues 05.0004, 05.0047, 05.00ab, 05.00ff, 06.0004,
>     06.0047, 06.00ab, and 06.00ff getting bound to the vfio_ap device driver. The
>     sysfs directory for the vfio_ap device driver will now contain symbolic links

