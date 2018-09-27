Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E10C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 11:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4916D215E4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 11:29:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4916D215E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbeI0Rro (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 13:47:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56458 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727262AbeI0Rrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 13:47:43 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8RBP8h2124343
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 07:29:51 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mrwh12sxw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 07:29:51 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pasic@linux.ibm.com>;
        Thu, 27 Sep 2018 12:29:48 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 27 Sep 2018 12:29:46 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8RBTiYG52101218
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 27 Sep 2018 11:29:44 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9B95611C058;
        Thu, 27 Sep 2018 14:29:24 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E70F011C04C;
        Thu, 27 Sep 2018 14:29:23 +0100 (BST)
Received: from oc0155643701.ibm.com (unknown [9.152.224.49])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 27 Sep 2018 14:29:23 +0100 (BST)
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
From:   Halil Pasic <pasic@linux.ibm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pasic@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Date:   Thu, 27 Sep 2018 13:29:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180926164222.74731b74@t450s.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18092711-0008-0000-0000-00000277BE76
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092711-0009-0000-0000-000021E0C673
Message-Id: <c4caf272-f9ef-ce61-bb0d-0b94bbf3ea84@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-27_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809270115
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/27/2018 12:42 AM, Alex Williamson wrote:
> On Tue, 25 Sep 2018 19:16:41 -0400
> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
> 
>> From: Tony Krowiak <akrowiak@linux.ibm.com>
[..]
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
> What happened to domain 0?  

Right, domain 0 is also 'alternate'. So it should have been
            alternate drivers pool:  adapter 16-255, domains 0,2-255

> I'm also a little confused by the bit
> ordering.  If 0x40 is bit 1 and 0xffff is bits 0-15, then the least
> significant bit is furthest left?  Did I miss documentation of that?
> 

Harald already tried to explain this, let me give it a try too.

Yes it is a bit confusing. I would try to describe it like this: the big endian mask,
which is of fixed length of 256 bytes is specified byte-wise using hexadecimal
notation. If only a prefix of the whole mask is specified, the not explicitly
specified bytes are specified are as if they were specified as zero.

I didn't quite get this thing with 'the least significant bit is furthest left'.
I think it is to the right if we assume we are reading left-to-right. It is big
endian, so we consider the most significant bit of a byte to be the first bit,
and the byte with the lowest address to be the first byte of the mask (that holds the
first 8 bits of the mask).

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

The zero padding on the right is about the non specified bytes of the mask.

While this bullet is about specifying a whole mask, the next butlet is about
changing a mask by setting the value of  bits at a certain position. So in the
context of the next bullet point, the hex string here specifies an integer
value -- plainly a number written in hexadecimal notation (pure math with no
significant bits whatsoever) - in the range 0-256: the index of the bit to be
set ('+') or cleared ('-').


I hope that makes some sense. As I said it's indeed a bit confusing.
 
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
> 
> I'm curious why this interface didn't adopt the +/- notation invented
> above for consistency.  Too difficult to do rollbacks with a string on
> entries?
> 

I remember that we did discuss that possibility around v9, but I can't
tell why did we decide to not implement it. Maybe Tony has an answer.

Anyway, if we were to do that, we would use different attribute names
(e.g. just domain_mask, or something similar instead of
(assign|unassign)_xxx). So I think such an interface can still be added
on top of the existing one. Having that said having multiple interfaces
for the very same thing is usually not so nice IMHO.

Regards,
Halil

