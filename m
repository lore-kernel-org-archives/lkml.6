Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5339CECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 12:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DA1420844
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 12:25:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DA1420844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731306AbeGMMj1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 08:39:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48720 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729653AbeGMMj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 08:39:27 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6DCOKuf044634
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 08:25:00 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k6r4csujt-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 08:24:59 -0400
Received: from localhost
        by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Fri, 13 Jul 2018 06:24:59 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com (9.17.130.20)
        by e36.co.us.ibm.com (192.168.1.136) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 13 Jul 2018 06:24:55 -0600
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6DCOqkc12976500
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 13 Jul 2018 05:24:52 -0700
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5F3D6C605A;
        Fri, 13 Jul 2018 06:24:52 -0600 (MDT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 670FFC6057;
        Fri, 13 Jul 2018 06:24:48 -0600 (MDT)
Received: from oc8043147753.ibm.com (unknown [9.152.224.124])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 13 Jul 2018 06:24:48 -0600 (MDT)
Subject: Re: [PATCH v6 13/21] s390: vfio-ap: sysfs interface to view matrix
 mdev matrix
To:     pmorel@linux.ibm.com, Tony Krowiak <akrowiak@linux.vnet.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     freude@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, borntraeger@de.ibm.com,
        cohuck@redhat.com, kwankhede@nvidia.com,
        bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
        alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com,
        alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com,
        jjherne@linux.vnet.ibm.com, thuth@redhat.com,
        pasic@linux.vnet.ibm.com, berrange@redhat.com,
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
References: <1530306683-7270-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1530306683-7270-14-git-send-email-akrowiak@linux.vnet.ibm.com>
 <ef3d480b-29b3-d184-4fb2-14f88961d97d@linux.ibm.com>
 <d105f5a6-b555-bc8d-6a1f-cc3cf57b9f35@linux.ibm.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Fri, 13 Jul 2018 14:24:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <d105f5a6-b555-bc8d-6a1f-cc3cf57b9f35@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18071312-0020-0000-0000-00000E3D6F96
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009362; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01060734; UDB=6.00544508; IPR=6.00838652;
 MB=3.00022128; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-13 12:24:58
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071312-0021-0000-0000-000062448D5B
Message-Id: <2ebe297c-79e7-1cfd-05a9-1ab8943a0203@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-13_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807130099
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/2018 04:38 PM, Pierre Morel wrote:
> On 09/07/2018 14:20, Pierre Morel wrote:
>> On 29/06/2018 23:11, Tony Krowiak wrote:
>>> Provides a sysfs interface to view the AP matrix configured for the
>>> mediated matrix device.
>>>
>>> The relevant sysfs structures are:
>>>
>>> /sys/devices/vfio_ap
>>> ... [matrix]
>>> ...... [mdev_supported_types]
>>> ......... [vfio_ap-passthrough]
>>> ............ [devices]
>>> ...............[$uuid]
>>> .................. matrix
>>>
>>> To view the matrix configured for the mediated matrix device,
>>> print the matrix file:
>>>
>>>     cat matrix
>>>
>>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>>> ---
>>>   drivers/s390/crypto/vfio_ap_ops.c |   31 
>>> +++++++++++++++++++++++++++++++
>>>   1 files changed, 31 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c 
>>> b/drivers/s390/crypto/vfio_ap_ops.c
>>> index c8f31f3..bc7398d 100644
>>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>>> @@ -697,6 +697,36 @@ static ssize_t control_domains_show(struct 
>>> device *dev,
>>>   }
>>>   DEVICE_ATTR_RO(control_domains);
>>>
>>> +static ssize_t matrix_show(struct device *dev, struct 
>>> device_attribute *attr,
>>> +               char *buf)
>>> +{
>>> +    struct mdev_device *mdev = mdev_from_dev(dev);
>>> +    struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
>>> +    char *bufpos = buf;
>>> +    unsigned long apid;
>>> +    unsigned long apqi;
>>> +    unsigned long napm = matrix_mdev->matrix.apm_max + 1;
>>> +    unsigned long naqm = matrix_mdev->matrix.aqm_max + 1;
>>> +    int nchars = 0;
>>> +    int n;
>>> +
>>> +    for_each_set_bit_inv(apid, matrix_mdev->matrix.apm, napm) {
>>> +        n = sprintf(bufpos, "%02lx\n", apid);
>>> +        bufpos += n;
>>> +        nchars += n;
>>> +
>>> +        for_each_set_bit_inv(apqi, matrix_mdev->matrix.aqm, naqm) {
>>> +            n = sprintf(bufpos, "%02lx.%04lx\n", apid, apqi);
>>> +            bufpos += n;
>>> +            nchars += n;
>>> +        }
>>> +    }
>>> +
>>> +    return nchars;
>>> +}
>>> +DEVICE_ATTR_RO(matrix);
>>> +
>>> +
>>>   static struct attribute *vfio_ap_mdev_attrs[] = {
>>>       &dev_attr_assign_adapter.attr,
>>>       &dev_attr_unassign_adapter.attr,
>>> @@ -705,6 +735,7 @@ static ssize_t control_domains_show(struct 
>>> device *dev,
>>>       &dev_attr_assign_control_domain.attr,
>>>       &dev_attr_unassign_control_domain.attr,
>>>       &dev_attr_control_domains.attr,
>>> +    &dev_attr_matrix.attr,
>>>       NULL,
>>>   };
>>>
>>
>> I have still the same remark: what you show here is not what is 
>> currently
>> used by the SIE.
>> It is not irrelevant but what the guest really use may be more 
>> interesting
>> for the admin.
>>
>>
> OK, you implement the right view it in patch 16/21.
>
> Still, what is the purpose of showing this view?

I find it to have great value when configuring the mdev. It provides a 
view of
what has been configured thus far.

>
>
>

