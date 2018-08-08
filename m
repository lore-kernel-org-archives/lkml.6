Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 902B9C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 22:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3435021A86
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 22:53:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3435021A86
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731498AbeHIBOs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 21:14:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53494 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727530AbeHIBOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 21:14:47 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w78MiRG3020736
        for <linux-kernel@vger.kernel.org>; Wed, 8 Aug 2018 18:52:58 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kr6f4fk30-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 18:52:58 -0400
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Wed, 8 Aug 2018 16:52:57 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com (9.17.130.15)
        by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 8 Aug 2018 16:52:54 -0600
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w78MqpFM14090564
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 8 Aug 2018 15:52:51 -0700
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ACE406A04D;
        Wed,  8 Aug 2018 16:52:51 -0600 (MDT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 872886A047;
        Wed,  8 Aug 2018 16:52:48 -0600 (MDT)
Received: from oc8043147753.ibm.com (unknown [9.85.187.56])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed,  8 Aug 2018 16:52:48 -0600 (MDT)
Subject: Re: [PATCH v8 00/22] vfio-ap: guest dedicated crypto adapters
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
References: <1533739472-7172-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <20180808182513.557b09cb.cohuck@redhat.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Wed, 8 Aug 2018 18:52:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180808182513.557b09cb.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18080822-0036-0000-0000-00000A1EBE5A
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009509; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01071097; UDB=6.00551463; IPR=6.00850676;
 MB=3.00022597; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-08 22:52:57
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18080822-0037-0000-0000-000048839AFA
Message-Id: <c80d526c-dfcc-1055-eb25-7c208b1b6ecb@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-08_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808080226
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08/2018 12:25 PM, Cornelia Huck wrote:
> On Wed,  8 Aug 2018 10:44:10 -0400
> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>
>> From: Tony Krowiak <akrowiak@linux.ibm.com>
>>
>> Several major objections were raised to design changes introduced in the v7
>> patch series, so in order to avoid an extended discussion around these
>> objections and to expedite acceptance of the series, the following changes
>> have been made for v8:
>>
>> 1. Removed the AP bus's ability to designate queues as 'used by host' or as
>>     'used by alternate driver(s)'. The bind/unbind sysfs interfaces will be
>>     used for managing the connection of AP queue devices to a zcrypt driver
>>     or the VFIO AP driver.
> I don't think the idea of pools is bad per se; I mainly did not like
> the sysfs interface and the dynamic interactions.
>
> We can probably reintroduce something like that later on, if it is
> still useful.

That may very well be the case, but we decided on bare bones expedite
acceptance.

>
>> 2. Removed the 'activate' sysfs interfaces which allowed for over
>>     provisioning of the mediated device as well as creation of mdevs with
>>     overlapping matrixes. It was pointed out that both of these enhancements
>>     break the mdev model. Consistency checking of the mdev matrix has
>>     therefore been returned to the mediated matrix device's sysfs interfaces
>>     for assigning adapters and domains:
>>
>>     * Verify that APQNs assigned to the mediated device are bound to the
>>       VFIO AP device driver
>>
>>     * Verify that no APQN assigned to the mediated matrix device is assigned
>>       to any other mediated matrix device.
> Ok, that makes sense.
>
> Where's point 3? :)

That is the invisible point. Only the all-knowing, all-seeing can 
discern its
presence ;)

>
>> 4. Reworked the handling of the CRYCB in vSIE based upon patches introduced
>>     by David in the mainline.
> I had reviewed David's patches and they looked good to me.

Excellent!

>
>> Notes:
>> =====
>>
>> Patches 1-4 (by Harald) posted with this series are forthcoming via
>> Martins tree and are based on changes in the ap driver/bus that we use as a
>> foundation. They have been included here because some of the functions
>> in this patch series are dependent upon them.
> I don't remember anything contentious in these.

There weren't any issues. They are included here solely because they are 
needed to
build the kernel and are not yet available in our master branch.

>
>> Patches 5-6 (by David) are posted with this series because they are not
>> currently in our master branch. Patches 19 and 20 of this series are
>> dependent upon them. I believe David's patches are available in the
>> mainline now.
> I don't see them queued yet, but as said, they looked fine to me.

I was told they are available in the mainline, but I'm not entirely sure 
what that means
and I didn't verify it. They are included here precisely
because they are not yet available in our master branch and our code is 
dependent upon
them.

>
>> This patch series works with the v6 QEMU patches. There is no new QEMU
>> patchset version yet because there have been no review comments worthy of
>> creating a new series; only a couple of extremely minor nits.
> Once the kernel part is merged, I'd need a respin anyway due to the
> kernel headers updates.

Got it.

>

