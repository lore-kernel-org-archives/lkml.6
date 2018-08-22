Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 725A0C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 18:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32A652087B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 18:59:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32A652087B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbeHVWZs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 18:25:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49130 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727877AbeHVWZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 18:25:47 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7MIxZYm157457
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 14:59:42 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2m1c1mkmqe-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 14:59:42 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Wed, 22 Aug 2018 14:59:41 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 22 Aug 2018 14:59:38 -0400
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7MIxaHe57934068
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 22 Aug 2018 18:59:36 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6F02228059;
        Wed, 22 Aug 2018 14:58:06 -0400 (EDT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1F4B028058;
        Wed, 22 Aug 2018 14:58:05 -0400 (EDT)
Received: from oc8043147753.ibm.com (unknown [9.60.75.213])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 22 Aug 2018 14:58:05 -0400 (EDT)
Subject: Re: [PATCH v9 00/22] guest dedicated crypto adapters
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
 <20180822121955.6767f8d3.cohuck@redhat.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Wed, 22 Aug 2018 14:59:34 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180822121955.6767f8d3.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18082218-0060-0000-0000-000002A271C0
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009593; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01077325; UDB=6.00555438; IPR=6.00857300;
 MB=3.00022872; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-22 18:59:40
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082218-0061-0000-0000-00004641B85A
Message-Id: <ea19cee1-a958-a076-1dd7-43105bc0aaf4@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-22_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808220187
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/22/2018 06:19 AM, Cornelia Huck wrote:
> On Mon, 13 Aug 2018 17:47:57 -0400
> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>
>> From: Tony Krowiak <akrowiak@linux.ibm.com>
>>
>> Notes:
>> =====
>>
>> Patches 1-4 (by Harald) posted with this series are forthcoming via
>> Martins tree and are based on changes in the ap driver/bus that we use as a
>> foundation. They have been included here because some of the functions
>> in this patch series are dependent upon them.
>>
>> Patches 5-6 (by David) are posted with this series because they are not
>> currently in our master branch. Patches 19 and 20 of this series are
>> dependent upon them. I believe David's patches are available in the
>> mainline now.
> What's the current status of David's patches, BTW?
>
> It's probably easiest to rebase this upon master when the patches have
> hit mainline.
>
> I don't have any comments beyond what I already wrote; we'll hopefully
> be able to figure out that control domain stuff soon.
>
> Would be great to get some LGTM from the vfio-mdev folks :)
>
> I believe Pierre is also doing some fixing in the existing crypto vsie
> code right now?
Yes. I will roll his patches into my branch when available prior to
posting v10.

>
>> This patch series works with the v6 QEMU patches. There is no new QEMU
>> patchset version yet because there have been no review comments worthy of
>> creating a new series; only a couple of extremely minor nits.
> Probably best to repost that once the kernel part is basically through,
> if just to solicit more comments.

Will do.

>

