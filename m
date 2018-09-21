Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E024AECE566
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 14:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B0FB21523
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 14:07:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B0FB21523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390352AbeIUT4T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 15:56:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53404 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390103AbeIUT4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 15:56:19 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8LE5ndv144120
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 10:07:15 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mn0cycxve-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 10:07:14 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Fri, 21 Sep 2018 10:07:12 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 21 Sep 2018 10:07:09 -0400
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8LE77ms42991854
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 21 Sep 2018 14:07:07 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D7285112065;
        Fri, 21 Sep 2018 10:06:34 -0400 (EDT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0AA20112066;
        Fri, 21 Sep 2018 10:06:34 -0400 (EDT)
Received: from oc8043147753.ibm.com (unknown [9.60.75.213])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 21 Sep 2018 10:06:33 -0400 (EDT)
Subject: Re: [PATCH v10 06/26] s390: vfio-ap: sysfs interfaces to configure
 adapters
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
References: <1536781396-13601-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1536781396-13601-7-git-send-email-akrowiak@linux.vnet.ibm.com>
 <20180921114009.24e928d9.cohuck@redhat.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Fri, 21 Sep 2018 10:07:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180921114009.24e928d9.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18092114-0072-0000-0000-000003A7D9F5
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009746; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01091556; UDB=6.00564007; IPR=6.00871580;
 MB=3.00023434; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-21 14:07:12
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092114-0073-0000-0000-0000497FAAA5
Message-Id: <f4033331-4bdf-53fb-6000-b70b36652102@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-21_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809210143
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/21/2018 05:40 AM, Cornelia Huck wrote:
> On Wed, 12 Sep 2018 15:42:56 -0400
> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>
>> From: Tony Krowiak <akrowiak@linux.ibm.com>
>>
>> Introduces two new sysfs attributes for the VFIO mediated
>> matrix device for assigning AP adapters to and unassigning
>> AP adapters from a mediated matrix device. The IDs of the
>> AP adapters assigned to the mediated matrix device will be
>> stored in an AP mask (APM).
>>
>> The bits in the APM, from most significant to least significant
>> bit, correspond to AP adapter IDs (APID) 0 to 255. On
>> some systems, the maximum allowable adapter number may be less
>> than 255 - depending upon the host's AP configuration - and
>> assignment may be rejected if the input adapter ID exceeds the
>> limit.
>>
>> When an adapter is assigned, the bit corresponding to the APID
>> will be set in the APM. Likewise, when an adapter is
>> unassigned, the bit corresponding to the APID will be cleared
>> from the APM.
>>
>> In order to successfully assign an adapter, the APQNs derived from
>> the adapter ID being assigned and the queue indexes of all domains
>> previously assigned:
>>
>> 1. Must be bound to the vfio_ap device driver.
>>
>> 2. Must not be assigned to any other mediated matrix device
>>
>> If there are no domains assigned to the mdev, then there must
>> be an AP queue bound to the vfio_ap device driver with an
>> APQN containing the APID, otherwise all domains
>> subsequently assigned will fail because there will be no
>> AP queues bound with an APQN containing the adapter ID.
>>
>> Assigning or un-assigning an AP adapter will be rejected if
>> a guest using the mediated matrix device is running.
>>
>> The relevant sysfs structures are:
>>
>> /sys/devices/vfio_ap/matrix/
>> ...... [mdev_supported_types]
>> ......... [vfio_ap-passthrough]
>> ............ [devices]
>> ...............[$uuid]
>> .................. assign_adapter
>> .................. unassign_adapter
>>
>> To assign an adapter to the $uuid mediated matrix device's APM,
>> write the APID to the assign_adapter file. To unassign an adapter,
>> write the APID to the unassign_adapter file. The APID is specified
>> using conventional semantics: If it begins with 0x the number will
>> be parsed as a hexadecimal number; if it begins with a 0 the number
>> will be parsed as an octal number; otherwise, it will be parsed as a
>> decimal number.
>>
>> For example, to assign adapter 173 (0xad) to the mediated matrix
>> device $uuid:
>>
>> 	echo 173 > assign_adapter
>>
>> 	or
>>
>> 	echo 0xad > assign_adapter
>>
>> 	or
>>
>> 	echo 0255 > assign_adapter
>>
>> To unassign adapter 173 (0xad):
>>
>> 	echo 173 > unassign_adapter
>>
>> 	or
>>
>> 	echo 0xad > unassign_adapter
>>
>> 	or
>>
>> 	echo 0255 > unassign_adapter
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
>> Tested-by: Michael Mueller <mimu@linux.ibm.com>
>> Tested-by: Farhan Ali <alifm@linux.ibm.com>
>> Tested-by: Pierre Morel <pmorel@linux.ibm.com>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>   drivers/s390/crypto/vfio_ap_ops.c |  295 +++++++++++++++++++++++++++++++++++++
>>   1 files changed, 295 insertions(+), 0 deletions(-)
> (...)
>
>> +/**
>> + * vfio_ap_mdev_verify_no_sharing
>> + *
>> + * Verifies that the APQNs derived from the cross product of the AP adapter IDs
>> + * and AP queue indexes comprising the AP matrix are not configured for another
>> + * mediated device. AP queue sharing is not allowed.
>> + *
>> + * @kvm: the KVM guest
>> + * @matrix: the AP matrix
>> + *
>> + * Returns 0 if the APQNs are not shared, otherwise; returns -EADDRINUSE.
>> + */
>> +static int vfio_ap_mdev_verify_no_sharing(struct ap_matrix_mdev *matrix_mdev)
>> +{
>> +	int nbits;
>> +	struct ap_matrix_mdev *lstdev;
>> +	unsigned long apm[BITS_TO_LONGS(matrix_mdev->matrix.apm_max + 1)];
>> +	unsigned long aqm[BITS_TO_LONGS(matrix_mdev->matrix.aqm_max + 1)];
> Can you please convert this to use a fixed-size array? I think
> {apm,aqm}_max has an upper bound of 255?

Sure

>
> (Also, this can use DECLARE_BITMAP.)

Indeed it can.

>
>> +
>> +	list_for_each_entry(lstdev, &matrix_dev->mdev_list, node) {
>> +		if (matrix_mdev == lstdev)
>> +			continue;
>> +
>> +		memset(apm, 0, sizeof(apm));
>> +		memset(aqm, 0, sizeof(aqm));
>> +
>> +		/*
>> +		 * We work on full longs, as we can only exclude the leftover
>> +		 * bits in non-inverse order. The leftover is all zeros.
>> +		 */
>> +		nbits = sizeof(apm) * BITS_PER_BYTE;
>> +		if (!bitmap_and(apm, matrix_mdev->matrix.apm,
>> +				lstdev->matrix.apm, nbits))
>> +			continue;
>> +
>> +		nbits = sizeof(aqm) * BITS_PER_BYTE;
>> +		if (!bitmap_and(aqm, matrix_mdev->matrix.aqm,
>> +				lstdev->matrix.aqm, nbits))
>> +			continue;
>> +
>> +		return -EADDRINUSE;
>> +	}
>> +
>> +	return 0;
>> +}


