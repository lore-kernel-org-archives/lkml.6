Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D845C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 14:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB704206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 14:17:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB704206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731973AbeHWRrC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 13:47:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47894 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730226AbeHWRrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 13:47:02 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7NEEWoO031663
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 10:17:08 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m1utkycw4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 10:17:08 -0400
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Thu, 23 Aug 2018 08:17:07 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com (9.17.130.19)
        by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Thu, 23 Aug 2018 08:17:04 -0600
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7NEH2mT49610786;
        Thu, 23 Aug 2018 07:17:02 -0700
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 566B913605E;
        Thu, 23 Aug 2018 08:17:02 -0600 (MDT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 040EC136066;
        Thu, 23 Aug 2018 08:16:59 -0600 (MDT)
Received: from oc8043147753.ibm.com (unknown [9.60.75.213])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 23 Aug 2018 08:16:59 -0600 (MDT)
Subject: Re: [PATCH v9 12/22] s390: vfio-ap: sysfs interfaces to configure
 control domains
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        pmorel@linux.ibm.com, Tony Krowiak <akrowiak@linux.vnet.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, kwankhede@nvidia.com,
        bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
        alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com,
        alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com,
        jjherne@linux.vnet.ibm.com, thuth@redhat.com,
        pasic@linux.vnet.ibm.com, berrange@redhat.com,
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com,
        frankja@linux.ibm.com
References: <1534196899-16987-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1534196899-16987-13-git-send-email-akrowiak@linux.vnet.ibm.com>
 <20180820162317.08bd7d23.cohuck@redhat.com>
 <660de00a-c403-28c1-4df4-82a973ab3ad5@linux.ibm.com>
 <20180821172548.57a6c758.cohuck@redhat.com>
 <82a391ee-85b1-cdc7-0f9b-d37fd8ba8e47@linux.ibm.com>
 <a43ef10f-aa91-cb4c-a8aa-cd3ce9cfebf2@linux.ibm.com>
 <20180822114250.59a250aa.cohuck@redhat.com>
 <8bc5f207-f913-825c-f9fc-0a2c7fd280aa@linux.ibm.com>
 <e36abc22-9daf-e0f4-c6b3-7adbb28db4c3@de.ibm.com>
 <f84dbcc0-f627-be02-9933-3baa953adc09@linux.ibm.com>
 <219b352b-d5a2-189c-e205-82e7f9ae3d64@de.ibm.com>
 <dbb74c9c-93ab-ed05-fad4-ea2aa5f2b71e@linux.ibm.com>
 <9ef5fcb9-02e0-88e3-007c-eedb14e6db80@linux.ibm.com>
 <20180823122525.02fc4af3.cohuck@redhat.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Thu, 23 Aug 2018 10:16:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180823122525.02fc4af3.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18082314-0036-0000-0000-00000A287140
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009598; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01077711; UDB=6.00555670; IPR=6.00857684;
 MB=3.00022888; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-23 14:17:06
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082314-0037-0000-0000-000048AF891C
Message-Id: <decfe307-4449-2c85-0b7e-6f2fcdb1164f@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-23_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808230151
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/23/2018 06:25 AM, Cornelia Huck wrote:
> On Wed, 22 Aug 2018 15:16:19 -0400
> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
>
>> One of the things I suggested in a private conversation with Christian
>> earlier
>> today was to provide an additional rw sysfs attribute - a boolean - that
>> indicates
>> whether all usage domains should also be control domains. The default
>> could be
>> true. This would allow one to configure guests with usage-only domains
>> as well
>> as satisfy the convention.
> Would this additional attribute then control "add usage domains to the
> list of control domains automatically", or "don't allow to add a usage
> domain if it has not already been added as a control domain"?

It was just a proposal that wasn't really discussed at all, but this
attribute would add usage domains to the list of control domains
automatically if set to one. That would be the default behavior which
would be turned off by manually setting it to zero.

>
> One thing I'm still unsure about is how libvirt comes into the picture
> here. Will it consume the setting, or actively manipulate it?

libvirt is not in the picture. The only thing libvirt does is identify
which mediated matrix device (i.e., UUID) is to be used by the guest.

>
> [In general, I'm not very clear about how libvirt will interact with the
> whole infrastructure...]

The libvirt domain XML will only specify the UUID of the matrix device
to be used by the guest. Consequently, libvirt will insert the device
statement for the vfio-ap device into the QEMU command line:

-device vfio-ap,syfsdev={path-to-mdev}

All configuration of the mediated device, including the proposed attribute
above, is handled via sysfs attributes.

>

