Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C4BC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 16:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C5D820C0F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 16:43:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C5D820C0F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbeHTUAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 16:00:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42092 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726077AbeHTUAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 16:00:05 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7KGTsba076989
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 12:43:42 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2kyxhd7cvf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 12:43:42 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pasic@linux.ibm.com>;
        Mon, 20 Aug 2018 17:43:40 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 20 Aug 2018 17:43:37 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7KGhZCD39125092
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 Aug 2018 16:43:36 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 686EB42047;
        Mon, 20 Aug 2018 19:43:38 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 828A042041;
        Mon, 20 Aug 2018 19:43:36 +0100 (BST)
Received: from oc0155643701.ibm.com (unknown [9.145.20.101])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 20 Aug 2018 19:43:36 +0100 (BST)
Subject: Re: [PATCH v9 12/22] s390: vfio-ap: sysfs interfaces to configure
 control domains
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
        frankja@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>
References: <1534196899-16987-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1534196899-16987-13-git-send-email-akrowiak@linux.vnet.ibm.com>
 <20180820162317.08bd7d23.cohuck@redhat.com>
From:   Halil Pasic <pasic@linux.ibm.com>
Date:   Mon, 20 Aug 2018 18:43:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180820162317.08bd7d23.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18082016-0028-0000-0000-000002ED4BED
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082016-0029-0000-0000-000023A685DF
Message-Id: <6a7aa016-d116-b0d8-9cce-71245cad2f16@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-20_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808200174
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/20/2018 04:23 PM, Cornelia Huck wrote:
> On Mon, 13 Aug 2018 17:48:09 -0400
> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
> 
>> From: Tony Krowiak <akrowiak@linux.ibm.com>
>>
>> Provides the sysfs interfaces for:
>>
>> 1. Assigning AP control domains to the mediated matrix device
>>
>> 2. Unassigning AP control domains from a mediated matrix device
>>
>> 3. Displaying the control domains assigned to a mediated matrix
>>     device
>>
>> The IDs of the AP control domains assigned to the mediated matrix
>> device are stored in an AP domain mask (ADM). The bits in the ADM,
>> from most significant to least significant bit, correspond to
>> AP domain numbers 0 to 255. On some systems, the maximum allowable
>> domain number may be less than 255 - depending upon the host's
>> AP configuration - and assignment may be rejected if the input
>> domain ID exceeds the limit.
> 
> Please remind me of the relationship between control domains and usage
> domains... IIRC, usage domains allow both requests and configuration,
> while control domains allow only configuration, and are by convention a
> superset of usage domains.
> 

The whole terminology with control and usage domains is IMHO a bit
confusing. With the HMC one can assign a domain either as a 'Control'
or as a 'Control and Usage' domain.

Regarding the masks in the CRYCB, the AQM controls 'using' the domain
(e.g. if AQM bit is zero NQAP will refuse to enqueue on that queue)
while ADM tells if the guest is allowed to 'change' the given domain.
Whether a command-request is of type 'using' or 'changing' is a property
of the command request.

You can think of 'using' a domain like signing stuff with a key residing
within the domain, and of 'changing' a domain like issuing a command to
generate a new key for the given domain.


> Is there a hard requirement somewhere in there, or can the admin
> cheerfully use different masks for usage domains and control domains
> without the SIE choking on it?
> 

It is a convention. AFAIR it ain't architecture. SIE won't choke on it
I've tried it out. I was arguing along the lines that the kernel should
not enforce this convention -- tooling can still do that if we want this
enforced.

Regards,
Halil

