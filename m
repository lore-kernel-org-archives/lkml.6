Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E68C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 07:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A64E214C2
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 07:04:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A64E214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbeHVK15 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 06:27:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40220 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726736AbeHVK14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 06:27:56 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7M6sUFe049317
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 03:04:21 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m0x421mqm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 03:04:21 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <freude@linux.ibm.com>;
        Wed, 22 Aug 2018 08:04:19 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 22 Aug 2018 08:04:15 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7M74DYT41353446
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 22 Aug 2018 07:04:13 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8AF6B52057;
        Wed, 22 Aug 2018 10:04:13 +0100 (BST)
Received: from [10.0.2.15] (unknown [9.152.224.107])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id A98855204E;
        Wed, 22 Aug 2018 10:04:12 +0100 (BST)
Subject: Re: [PATCH v9 22/22] s390: doc: detailed specifications for AP
 virtualization
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
        frankja@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>
References: <1534196899-16987-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1534196899-16987-23-git-send-email-akrowiak@linux.vnet.ibm.com>
 <20180820180359.38cc4af3.cohuck@redhat.com>
 <6b83b4da-00eb-c690-e965-a4398dadd0e5@linux.ibm.com>
 <20180821175309.55b774ca.cohuck@redhat.com>
From:   Harald Freudenberger <freude@linux.ibm.com>
Date:   Wed, 22 Aug 2018 09:04:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180821175309.55b774ca.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18082207-4275-0000-0000-000002AD7DEA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082207-4276-0000-0000-000037B68191
Message-Id: <856de167-478f-f6e0-c706-1f9b87bed7f5@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-22_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808220071
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.08.2018 17:53, Cornelia Huck wrote:
> On Tue, 21 Aug 2018 11:00:00 +0200
> Harald Freudenberger <freude@linux.ibm.com> wrote:
>
>> On 20.08.2018 18:03, Cornelia Huck wrote:
>>> On Mon, 13 Aug 2018 17:48:19 -0400
>>> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>>>> +* AP Instructions:
>>>> +
>>>> +  There are three AP instructions:
>>>> +
>>>> +  * NQAP: to enqueue an AP command-request message to a queue
>>>> +  * DQAP: to dequeue an AP command-reply message from a queue
>>>> +  * PQAP: to administer the queues  
>>> So, NQAP/DQAP need usage domains, while PQAP needs a control domain? Or
>>> is it that all of them need usage domains, but PQAP can target a control
>>> domain as well?
>>>
>>> [I don't want to dive deeply into the AP architecture here, just far
>>> enough to really understand the design implications.]  
>> Well, to be honest, nobody ever tried this under Linux. Theoretically
>> one should be able to send a CPRB to a usage domain where inside
>> the CPRB another domain (the control domain) is addressed. However,
>> as of now I am only aware of applications controlling the same usage
>> domain. I don't know any application which is able to address another
>> control domain and I am not sure if the zcrypt device driver would
>> handle such a CPRB correctly. NQAP, DQAP and PQAP always address
>> a usage domain. But the CPRB send down the pipe via NQAP may
>> address some control thing on another domain. I am not sure which
>> code and where do the sorting out here. There are two candidates:
>> the firmware layer in the CEC and the crypto card code.
> OK, so it's possible as by the architecture, but at least Linux does
> not (currently) do it?
>
> Perhaps we should simply not overthink that whole control domain
> thingy :) It's mostly yet another knob, and as long as the design does
> not go against the general architecture, it's probably fine, I guess.
Well, sooner or later this has to work. Yesterday we tested the control
domain thing with trying to pull some simple data from a 'controlled' domain
to the TKE - doesn't work with a Linux LPAR. I will investigate the details in the
next weeks. However, long-term it should be possible to run scenarios
like having one KVM guest control all the domains used by other KVM guests.
With respect to the KVM vfio driver, currently there should be just the
rule that for a guest the control domain mask should be equal or a superset
of the usage domain mask. This is by convention as the architecture is
not so clear here, but this is enforced on every place which deals with
usage and control domains (SE, TKE).

regards Harald Freudenberger

