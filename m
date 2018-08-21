Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA0BC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FCE12177A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:08:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FCE12177A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbeHUU25 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 16:28:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47318 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727134AbeHUU25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 16:28:57 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7LH6p4q064120
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 13:07:58 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2m0nmmb1w1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 13:07:58 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Tue, 21 Aug 2018 13:07:57 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 21 Aug 2018 13:07:53 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7LH7pPh46399714
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 21 Aug 2018 17:07:51 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6717EB2065;
        Tue, 21 Aug 2018 13:06:58 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EEAE2B205F;
        Tue, 21 Aug 2018 13:06:56 -0400 (EDT)
Received: from oc8043147753.ibm.com (unknown [9.80.223.104])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 21 Aug 2018 13:06:56 -0400 (EDT)
Subject: Re: [PATCH v9 12/22] s390: vfio-ap: sysfs interfaces to configure
 control domains
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     Tony Krowiak <akrowiak@linux.vnet.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
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
 <1534196899-16987-13-git-send-email-akrowiak@linux.vnet.ibm.com>
 <20180820162317.08bd7d23.cohuck@redhat.com>
 <660de00a-c403-28c1-4df4-82a973ab3ad5@linux.ibm.com>
 <20180821172548.57a6c758.cohuck@redhat.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Tue, 21 Aug 2018 13:07:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180821172548.57a6c758.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18082117-0072-0000-0000-00000394B31A
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009586; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01076809; UDB=6.00555128; IPR=6.00856783;
 MB=3.00022851; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-21 17:07:55
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082117-0073-0000-0000-0000492772FC
Message-Id: <82a391ee-85b1-cdc7-0f9b-d37fd8ba8e47@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-21_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808210177
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/21/2018 11:25 AM, Cornelia Huck wrote:
> On Mon, 20 Aug 2018 13:41:32 -0400
> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
>
>> On 08/20/2018 10:23 AM, Cornelia Huck wrote:
>>> On Mon, 13 Aug 2018 17:48:09 -0400
>>> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>>>   
>>>> From: Tony Krowiak <akrowiak@linux.ibm.com>
>>>>
>>>> Provides the sysfs interfaces for:
>>>>
>>>> 1. Assigning AP control domains to the mediated matrix device
>>>>
>>>> 2. Unassigning AP control domains from a mediated matrix device
>>>>
>>>> 3. Displaying the control domains assigned to a mediated matrix
>>>>      device
>>>>
>>>> The IDs of the AP control domains assigned to the mediated matrix
>>>> device are stored in an AP domain mask (ADM). The bits in the ADM,
>>>> from most significant to least significant bit, correspond to
>>>> AP domain numbers 0 to 255. On some systems, the maximum allowable
>>>> domain number may be less than 255 - depending upon the host's
>>>> AP configuration - and assignment may be rejected if the input
>>>> domain ID exceeds the limit.
>>> Please remind me of the relationship between control domains and usage
>>> domains... IIRC, usage domains allow both requests and configuration,
>>> while control domains allow only configuration, and are by convention a
>>> superset of usage domains.
>> A usage domain is a domain to which an AP command-request message can be
>> submitted for processing. A control domain is a domain that can
>> be changed by an AP command request message submitted to a usage domain.
>> AP command request messages to configure a domain will contain the domain
>> number of the domain to be modified. The AP firmware will check the
>> control domain mask (ADM) and will allow the request to proceed only if
>> the corresponding bit in the ADM is set.
> Thanks to you and Halil for the explanation.
>
>>> Is there a hard requirement somewhere in there, or can the admin
>>> cheerfully use different masks for usage domains and control domains
>>> without the SIE choking on it?
>> There is no hard requirement that control domains must be a superset of
>> the usage domains, it is merely an architectural convention. AFAIK,
>> SIE doesn't enforce this and will not break if the convention is not
>> enforced externally. Having said that, you should note that the AQM
>> and ADM masks configured for the mediated matrix device will be logically
>> OR'd together to create the ADM stored in the CRYCB referenced from the
>> guest's SIE state description. In other words, we are enforcing the
>> convention in our software.
> Hm, that's interesting, as Halil argued that we should not enforce it
> in the kernel. Might be somewhat surprising as well. If that is really
> the way to do it, this needs to be documented clearly.

This convention has been enforced by the kernel since v1. This is also
enforced by both the LPAR as well as in z/VM. The following is from the
PR/SM Planning Guide:

Control Domain
A logical partition's control domains are those cryptographic domains 
for which remote secure
administration functions can be established and administered from this 
logical partition. This
logical partition’s control domains must include its usage domains. For 
each index selected in the
usage domain index list, you must select the same index in the control 
domain index list


Consequently, I'm going to opt for ensuring this is clearly documented. 
Based on the fact you've
requested clarification of many points described in this section of the 
doc, I
think I'll try putting my meager skills as a wordsmith to work to 
hopefully clarify things.
I'll run it by you when I complete that task to see if I've succeeded:)

>

