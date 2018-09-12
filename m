Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8116AC46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 17:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45C8B20882
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 17:01:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45C8B20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbeILWGu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 18:06:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51794 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726454AbeILWGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 18:06:50 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8CH0m8x089011
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 13:01:24 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mf632hy2p-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 13:01:22 -0400
Received: from localhost
        by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Wed, 12 Sep 2018 11:01:19 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com (9.17.130.19)
        by e36.co.us.ibm.com (192.168.1.136) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 12 Sep 2018 11:01:16 -0600
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8CH1D1G51511398
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 Sep 2018 10:01:13 -0700
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 24575136053;
        Wed, 12 Sep 2018 11:01:13 -0600 (MDT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D9BAB136059;
        Wed, 12 Sep 2018 11:01:09 -0600 (MDT)
Received: from oc8043147753.ibm.com (unknown [9.80.213.181])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 12 Sep 2018 11:01:09 -0600 (MDT)
Subject: Re: [PATCH v9 13/22] s390: vfio-ap: sysfs interface to view matrix
 mdev matrix
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
 <1534196899-16987-14-git-send-email-akrowiak@linux.vnet.ibm.com>
 <20180820160802.1fe8f704.cohuck@redhat.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Wed, 12 Sep 2018 13:01:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180820160802.1fe8f704.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18091217-0020-0000-0000-00000E633290
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009708; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01087317; UDB=6.00561456; IPR=6.00867329;
 MB=3.00023256; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-12 17:01:19
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18091217-0021-0000-0000-00006300A3C6
Message-Id: <0e8bac2b-31a0-a1de-c6cf-e824cd256af6@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-12_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809120171
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/20/2018 10:08 AM, Cornelia Huck wrote:
> I find this output to be a bit confusing; but OTOH, I'm probably not
> the person to parse it :) Still, some comments.
>
>  From previous discussions, ISTR that this is mainly supposed to be a
> debugging/administration aid. Of course, this generates some questions:
> - Should this be in sysfs (sysfs attributes are supposed to follow the
>    "one value per file" rule, at least for the most part), or would
>    debugfs be a better fit?
> - Should userspace code be able to introspect the current
>    configuration? If yes, it might be better to have some
>    not-so-nice-but-easily-parsable output, possibly one attribute for
>    the assigned adapters and one for the assigned domains, and a tool
>    which distills that into a nice "matrix" with labeled rows and
>    columns for human consumption.
>
> That said, I don't really have major objections to that interface.

For now, I will leave it in, but we could conceivably simplify configuration
of the matrix and adhere to sysfs rules by modeling this after the AP bus
apmask and aqmask sysfs interfaces. If we did that, there would need to 
be only
three RW sysfs interfaces:

apm or apmask or ap_mask or adapter_mask or apid_mask
aqm or aqmask or aq_mask or domains or usage_domain_mask or apqi_mask
adm or admask or ad_mask or control_domains or control_domain_mask or 
domain_mask

To assign a device, either a bitmask or a comma separated list of IDs 
prepended
with a '+' could be passed in. To unassign a device, either a bitmask in 
or a
comma-separated list of IDs prepended with a '-' could be passed in.

Reading an attribute would return the mask. As you suggested, tools could be
provided to parse the output and display it in a human-readable format.

>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
>> Tested-by: Michael Mueller <mimu@linux.ibm.com>
>> Tested-by: Farhan Ali <alifm@linux.ibm.com>
>> Tested-by: Pierre Morel <pmorel@linux.ibm.com>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>   drivers/s390/crypto/vfio_ap_ops.c |   52 +++++++++++++++++++++++++++++++++++++
>>   1 files changed, 52 insertions(+), 0 deletions(-)


