Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A0BFC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 15:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B43F920BF2
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 15:19:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B43F920BF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729121AbeHVSoT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 14:44:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50432 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728568AbeHVSoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 14:44:19 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7MFEbJF111301
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 11:18:59 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2m18gydn41-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 11:18:59 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Wed, 22 Aug 2018 11:18:58 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 22 Aug 2018 11:18:55 -0400
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7MFIrSm4981206
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 22 Aug 2018 15:18:53 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E7B6028060;
        Wed, 22 Aug 2018 11:17:23 -0400 (EDT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5485D28064;
        Wed, 22 Aug 2018 11:17:23 -0400 (EDT)
Received: from oc8043147753.ibm.com (unknown [9.60.75.213])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 22 Aug 2018 11:17:23 -0400 (EDT)
Subject: Re: [PATCH v9 12/22] s390: vfio-ap: sysfs interfaces to configure
 control domains
To:     Cornelia Huck <cohuck@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>
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
 <82a391ee-85b1-cdc7-0f9b-d37fd8ba8e47@linux.ibm.com>
 <a43ef10f-aa91-cb4c-a8aa-cd3ce9cfebf2@linux.ibm.com>
 <20180822114250.59a250aa.cohuck@redhat.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Wed, 22 Aug 2018 11:18:52 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180822114250.59a250aa.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18082215-0064-0000-0000-0000033FF615
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009592; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01077252; UDB=6.00555395; IPR=6.00857227;
 MB=3.00022869; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-22 15:18:58
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082215-0065-0000-0000-00003A63E10B
Message-Id: <c2ec9629-bd52-5855-a62f-9d3e4289ecd3@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-22_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808220155
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/22/2018 05:42 AM, Cornelia Huck wrote:
> On Wed, 22 Aug 2018 01:18:20 +0200
> Halil Pasic <pasic@linux.ibm.com> wrote:
>
>> On 08/21/2018 07:07 PM, Tony Krowiak wrote:
>>> This convention has been enforced by the kernel since v1. This is also
>>> enforced by both the LPAR as well as in z/VM. The following is from the
>>> PR/SM Planning Guide:
>>>
>>> Control Domain
>>> A logical partition's control domains are those cryptographic domains for which remote secure
>>> administration functions can be established and administered from this logical partition. This
>>> logical partition’s control domains must include its usage domains. For each index selected in the
>>> usage domain index list, you must select the same index in the control domain index list
>>>    
> That's interesting.
>
>> IMHO this quote is quite a half-full half-empty cup one:
>> * it mandates the set of usage domains is a subset of the set
>> of the control domains, but
>> * it speaks of independent controls, namely about the 'usage domain index'
>> and the 'control domain index list' and makes the enforcement of the rule
>> a job of the administrator (instead of codifying it in the controls).
> I'm wondering if a configuration with a usage domain that is not also a
> control domain is rejected outright? Anybody tried that? :)

That's been tried and is not rejected.

>
>>> Consequently, I'm going to opt for ensuring this is clearly documented. Based on the fact you've
>>> requested clarification of many points described in this section of the doc, I
>>> think I'll try putting my meager skills as a wordsmith to work to hopefully clarify things.
>>> I'll run it by you when I complete that task to see if I've succeeded:)
>> I don't think just a doc update will do. Let me explain why.
>>
>> What describe as "... note that the AQM and ADM masks configured for the
>> mediated matrix device will be logically OR'd together to create the ADM
>> stored in the CRYCB referenced from the guest's SIE state description."
>> is a gotcha at best. The member of struct ap_matrix and the member of the
>> respective apcb in the crycb are both called 'adm', but ap_matrix.adm is
>> not an ADM as we know it from the architecture, but rather ~ AQM & ADM.
>>
>> I feel pretty strongly about this one. If we want to keep the enforcement
>> in the kernel, I guess, the assign_domain should set the bit corresponding
>> bit not only in ap_matrix.aqm but also in ap_matrix.adm. When the
>> ap_matrix is committed into the crycb no further manipulating the masks
>> should take place.
> Would you be fine if the control domain interface stated that it is
> used to configure _additional_ control domains and the usage domain
> interface stated that it is used to define usage and implicitly also
> control domains? (And make the usage domain interface also set the
> equivalent bit in the control domain mask.)

I think that is the better way to go and is something Halil recommended
in another post.

>
>> I don't feel strongly about whether to enforce this convention about AQM
>> and ADM in the kernel or not. Frankly, I don't know what is behind the
>> rule. Since I can't tell if any problems are to be expected if this
>> convention is violated, I would feel more comfortable if the rule was
>> accommodated higher in the management stack.
> I guess it depends:
>
> - If this is a case of: "Don't configure control domains that are not
>    also usage domains. You are likely to go through
>    {code,firmware,hardware} paths that are generally not used.",
>    configure it in the kernel.
> - If this rather is "Everybody is doing that, it's a general
>    convention.", configure it higher up in the stack (libvirt?)

I have come to the conclusion that the convention should be enforced
in the sysfs interfaces of the mediated matrix device as follows:

1. All domains assigned as usage domains will also be implicitly
    assigned as control domains.

2. Control domains that are not usage domains may be assigned via
    the assign_control_domain interface.

My reason is to maintain consistency across platforms, because:

1. The architecture doc states that control domains are a superset
    of the usage domains.

2. The HMC interface for assigning domains to the LPAR enforces
    the convention.

3. The PR/SM documentation states the same.



>

