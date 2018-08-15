Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F07C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 17:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5E2821530
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 17:00:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5E2821530
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730105AbeHOTxu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 15:53:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:29865 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729381AbeHOTxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 15:53:49 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7FGxWTe126673
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 13:00:51 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kvr2tg9c8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 13:00:50 -0400
Received: from localhost
        by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Wed, 15 Aug 2018 11:00:49 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com (9.17.130.15)
        by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 15 Aug 2018 11:00:45 -0600
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7FH0gIG12517404
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 15 Aug 2018 10:00:42 -0700
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A9A3E136060;
        Wed, 15 Aug 2018 11:00:42 -0600 (MDT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 854F2136051;
        Wed, 15 Aug 2018 11:00:39 -0600 (MDT)
Received: from oc8043147753.ibm.com (unknown [9.85.175.5])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 15 Aug 2018 11:00:39 -0600 (MDT)
Subject: Re: [PATCH v9 11/22] s390: vfio-ap: sysfs interfaces to configure
 domains
To:     Cornelia Huck <cohuck@redhat.com>,
        Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, borntraeger@de.ibm.com,
        kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com,
        pbonzini@redhat.com, alex.williamson@redhat.com,
        pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com,
        mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com,
        thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com,
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com,
        frankja@linux.ibm.com
References: <1534196899-16987-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1534196899-16987-12-git-send-email-akrowiak@linux.vnet.ibm.com>
 <20180815140505.36d3138e.cohuck@redhat.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Wed, 15 Aug 2018 13:00:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180815140505.36d3138e.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18081517-0016-0000-0000-0000091AFB13
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009550; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01073947; UDB=6.00553401; IPR=6.00853906;
 MB=3.00022736; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-15 17:00:48
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18081517-0017-0000-0000-000040022DCE
Message-Id: <6727d228-c225-c7cc-2074-a5c69d233caa@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-15_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808150179
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/15/2018 08:05 AM, Cornelia Huck wrote:
> On Mon, 13 Aug 2018 17:48:08 -0400
> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>
>> From: Tony Krowiak <akrowiak@linux.ibm.com>
>>
>> Introduces two new sysfs attributes for the VFIO mediated
>> matrix device for assigning AP domains to and unassigning
>> AP domains from a mediated matrix device. The IDs of the
>> AP domains assigned to the mediated matrix device will be
>> stored in an AP queue mask (AQM).
>>
>> The bits in the AQM, from most significant to least
>> significant bit, correspond to AP queue index (APQI) 0 to
>> 255 (note that an APQI is synonymous with with a domain ID).
>> On some systems, the maximum allowable domain number may be
>> less than 255 - depending upon the host's AP configuration -
>> and assignment may be rejected if the input domain ID exceeds
>> the limit.
>>
>> When a domain is assigned, the bit corresponding to the APQI
>> will be set in the AQM. Likewise, when a domain is unassigned,
>> the bit corresponding to the APQI will be cleared from the AQM.
>>
>> In order to successfully assign a domain, the APQNs derived from
>> the domain ID being assigned and the adapter numbers of all
>> adapters previously assigned:
>>
>> 1. Must be bound to the vfio_ap device driver.
>>
>> 2. Must not be assigned to any other mediated matrix device.
>>
>> If there are no adapters assigned to the mdev, then there must
>> be an AP queue bound to the vfio_ap device driver with an
>> APQN containing the domain ID (i.e., APQI), otherwise all
>> adapters subsequently assigned will fail because there will be no
>> AP queues bound with an APQN containing the APQI.
>>
>> Assigning or un-assigning an AP domain will also be rejected if
>> a guest using the mediated matrix device is running.
>>
>> The relevant sysfs structures are:
>>
>> /sys/devices/vfio_ap/matrix/
>> ...... [mdev_supported_types]
>> ......... [vfio_ap-passthrough]
>> ............ [devices]
>> ...............[$uuid]
>> .................. assign_domain
>> .................. unassign_domain
>>
>> To assign a domain to the $uuid mediated matrix device,
>> write the domain's ID to the assign_domain file. To
>> unassign a domain, write the domain's ID to the
>> unassign_domain file. The ID is specified using
>> conventional semantics: If it begins with 0x, the number
>> will be parsed as a hexadecimal (case insensitive) number;
>> if it begins with 0, it will be parsed as an octal number;
>> otherwise, it will be parsed as a decimal number.
>>
>> For example, to assign domain 173 (0xad) to the mediated matrix
>> device $uuid:
>>
>> 	echo 173 > assign_domain
>>
>> 	or
>>
>> 	echo 0255 > assign_domain
>>
>> 	or
>>
>> 	echo 0xad > assign_domain
>>
>> To unassign domain 173 (0xad):
>>
>> 	echo 173 > unassign_domain
>>
>> 	or
>>
>> 	echo 0255 > unassign_domain
>>
>> 	or
>>
>> 	echo 0xad > unassign_domain
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
>> Tested-by: Michael Mueller <mimu@linux.ibm.com>
>> Tested-by: Farhan Ali <alifm@linux.ibm.com>
>> Tested-by: Pierre Morel <pmorel@linux.ibm.com>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>   drivers/s390/crypto/vfio_ap_ops.c |   88 ++++++++++++++++++++++++++++++++++++-
>>   1 files changed, 87 insertions(+), 1 deletions(-)
> Looks sane to me.

Sanity rules!

>

