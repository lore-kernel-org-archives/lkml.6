Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FAC4C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 07:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA90C20873
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 07:26:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA90C20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbeGLHeh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 03:34:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45976 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725995AbeGLHeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 03:34:36 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6C7NuhH050384
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 03:26:19 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k61rsagry-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 03:26:18 -0400
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Thu, 12 Jul 2018 01:26:18 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com (9.17.130.17)
        by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 12 Jul 2018 01:26:16 -0600
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6C7QDMZ18088324
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 12 Jul 2018 00:26:13 -0700
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 35BD0C6057;
        Thu, 12 Jul 2018 01:26:13 -0600 (MDT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 50026C6055;
        Thu, 12 Jul 2018 01:26:09 -0600 (MDT)
Received: from oc8043147753.ibm.com (unknown [9.152.224.124])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 12 Jul 2018 01:26:09 -0600 (MDT)
Subject: Re: [PATCH v6 21/21] s390: doc: detailed specifications for AP
 virtualization
To:     pmorel@linux.ibm.com, Halil Pasic <pasic@linux.ibm.com>,
        Tony Krowiak <akrowiak@linux.vnet.ibm.com>,
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
 <1530306683-7270-22-git-send-email-akrowiak@linux.vnet.ibm.com>
 <753c5e17-c241-580d-6e3a-a3c3159d44a8@linux.ibm.com>
 <0580735b-8813-f860-a2ac-654d82203b35@linux.ibm.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Thu, 12 Jul 2018 09:26:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <0580735b-8813-f860-a2ac-654d82203b35@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18071207-0036-0000-0000-00000A0E0850
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009355; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01060154; UDB=6.00544160; IPR=6.00838072;
 MB=3.00022112; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-12 07:26:18
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071207-0037-0000-0000-0000481254AF
Message-Id: <89f903ad-259a-41d3-ba6a-218d2c277ffb@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-12_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807120076
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/2018 11:21 AM, Pierre Morel wrote:
> On 03/07/2018 01:10, Halil Pasic wrote:
>>
>>
>> On 06/29/2018 11:11 PM, Tony Krowiak wrote:
>>> This patch provides documentation describing the AP architecture and
>>> design concepts behind the virtualization of AP devices. It also
>>> includes an example of how to configure AP devices for exclusive
>>> use of KVM guests.
>>>
>>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>>
>> I don't like the design of external interfaces except for:
>> * cpu model features, and
>> * reset handling.
>>
>> In particular:
>>
>>
> ...snip...
>
>> 4) If I were to act out the role of the administrator, I would prefer 
>> to think of
>> specifying or changing the access controls of a guest in respect to 
>> AP (that is
>> setting the AP matrix) as a single atomic operation -- which either 
>> succeeds or fails.
>>
>> The operation should succeed for any valid configuration, and fail 
>> for any invalid
>> on.
>>
>> The current piecemeal approach seems even less fitting if we consider 
>> changing the
>> access controls of a running guest. AFAIK changing access controls 
>> for a running
>> guest is possible, and I don't see a reason why should we 
>> artificially prohibit this.
>>
>> I think the current sysfs interface for manipulating the matrix is 
>> good for
>> manual playing around, but I would prefer having an interface that is 
>> better
>> suited for programs (e.g. ioctl).
>
> I disagree with using ioctl.
> I agree that the current implementation is not right.
> The configuration of APM and AQM should always be guarantied as coherent
> within the host but it can be done doing the right checks when using 
> the sysfs.

What sysfs interfaces do you suggest?

>
>
> Regards,
>
> Pierre
>

