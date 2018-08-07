Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8741C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 17:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AF172083C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 17:15:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AF172083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390175AbeHGTa3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 15:30:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49930 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727354AbeHGTa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 15:30:29 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w77H9l6N070998
        for <linux-kernel@vger.kernel.org>; Tue, 7 Aug 2018 13:15:09 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kqe30cep1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 13:15:09 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Tue, 7 Aug 2018 18:15:07 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 7 Aug 2018 18:15:05 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w77HF31V24183028
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 7 Aug 2018 17:15:03 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6BD5F4C050;
        Tue,  7 Aug 2018 20:15:12 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 296824C046;
        Tue,  7 Aug 2018 20:15:12 +0100 (BST)
Received: from [9.152.224.92] (unknown [9.152.224.92])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  7 Aug 2018 20:15:12 +0100 (BST)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH RFC 0/2] KVM: s390: vsie: support VCPU requests
To:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-s390@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
References: <20180807125131.3606-1-david@redhat.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Tue, 7 Aug 2018 19:15:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180807125131.3606-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18080717-0028-0000-0000-000002E7821A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18080717-0029-0000-0000-000023A088A7
Message-Id: <65aefa0e-275f-1a30-2237-904aa4c6d63b@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-07_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808070172
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/08/2018 14:51, David Hildenbrand wrote:
> While discussing AP changes, we discovered that we will have to force
> a CPU using the vSIE to regenerate/reload shadow data structures. For now,
> we have no mechanism for that.
>
> E.g. when clearing AP masks later, we could still have a vSIE CPU making
> use of AP adapters as the masks might not be considered yet in the vSIE
> data structures. We need a way to block entering the vSIE and regenerate
> all shadow data structures once done.
>
> Looks like we can achieve that by simply simulating an ordinary SIE
> entry/exit in the VCPU sie control block (while entering the vSIE loop).
>
> This way, we can support blocking and also synchronous CPU requests.
>
> Only compile tested.
>
> David Hildenbrand (2):
>    KVM: s390: vsie: simulate VCPU SIE entry/exit
>    KVM: s390: introduce and use KVM_REQ_VSIE_RESTART
>
>   arch/s390/include/asm/kvm_host.h |  1 +
>   arch/s390/kvm/kvm-s390.c         | 16 ++++++++++++++--
>   arch/s390/kvm/kvm-s390.h         |  1 +
>   arch/s390/kvm/vsie.c             | 20 ++++++++++++++++++--
>   4 files changed, 34 insertions(+), 4 deletions(-)
>
Thanks David for your patches.

Following my tests, they work fine for our AP use case.

Best regards,

Pierre


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

