Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17ED6C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5D072087F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:21:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5D072087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932519AbeGIJVa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 05:21:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60748 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932278AbeGIJV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 05:21:28 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w699KR8o046818
        for <linux-kernel@vger.kernel.org>; Mon, 9 Jul 2018 05:21:28 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k40c7ewe4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 05:21:27 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Mon, 9 Jul 2018 10:21:22 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 9 Jul 2018 10:21:18 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w699LGEh23199836
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 9 Jul 2018 09:21:17 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DD4824203F;
        Mon,  9 Jul 2018 12:21:39 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F0EBC4204B;
        Mon,  9 Jul 2018 12:21:38 +0100 (BST)
Received: from [9.152.224.92] (unknown [9.152.224.92])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  9 Jul 2018 12:21:38 +0100 (BST)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v6 21/21] s390: doc: detailed specifications for AP
 virtualization
To:     Halil Pasic <pasic@linux.ibm.com>,
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
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com,
        Tony Krowiak <akrowiak@linux.ibm.com>
References: <1530306683-7270-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1530306683-7270-22-git-send-email-akrowiak@linux.vnet.ibm.com>
 <753c5e17-c241-580d-6e3a-a3c3159d44a8@linux.ibm.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Mon, 9 Jul 2018 11:21:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <753c5e17-c241-580d-6e3a-a3c3159d44a8@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18070909-0020-0000-0000-000002A48007
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070909-0021-0000-0000-000020F0B81A
Message-Id: <0580735b-8813-f860-a2ac-654d82203b35@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-09_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807090110
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/07/2018 01:10, Halil Pasic wrote:
>
>
> On 06/29/2018 11:11 PM, Tony Krowiak wrote:
>> This patch provides documentation describing the AP architecture and
>> design concepts behind the virtualization of AP devices. It also
>> includes an example of how to configure AP devices for exclusive
>> use of KVM guests.
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>
> I don't like the design of external interfaces except for:
> * cpu model features, and
> * reset handling.
>
> In particular:
>
>
...snip...

> 4) If I were to act out the role of the administrator, I would prefer 
> to think of
> specifying or changing the access controls of a guest in respect to AP 
> (that is
> setting the AP matrix) as a single atomic operation -- which either 
> succeeds or fails.
>
> The operation should succeed for any valid configuration, and fail for 
> any invalid
> on.
>
> The current piecemeal approach seems even less fitting if we consider 
> changing the
> access controls of a running guest. AFAIK changing access controls for 
> a running
> guest is possible, and I don't see a reason why should we artificially 
> prohibit this.
>
> I think the current sysfs interface for manipulating the matrix is 
> good for
> manual playing around, but I would prefer having an interface that is 
> better
> suited for programs (e.g. ioctl).

I disagree with using ioctl.
I agree that the current implementation is not right.
The configuration of APM and AQM should always be guarantied as coherent
within the host but it can be done doing the right checks when using the 
sysfs.

Regards,

Pierre

-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

