Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id rqPzCcQwGVsDMgAAmS7hNA
	; Thu, 07 Jun 2018 13:19:15 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id EC2B7607DC; Thu,  7 Jun 2018 13:19:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 750D9601D2;
	Thu,  7 Jun 2018 13:19:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 750D9601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932565AbeFGNTM (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 09:19:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51526 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751037AbeFGNTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 09:19:10 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w57DIcWc074640
        for <linux-kernel@vger.kernel.org>; Thu, 7 Jun 2018 09:19:10 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jf260s3ns-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 09:19:09 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pasic@linux.ibm.com>;
        Thu, 7 Jun 2018 14:16:30 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 7 Jun 2018 14:16:26 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w57DGOxc30867590
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 7 Jun 2018 13:16:24 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 130EA42041;
        Thu,  7 Jun 2018 14:06:44 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CD06C4203F;
        Thu,  7 Jun 2018 14:06:42 +0100 (BST)
Received: from oc3836556865.ibm.com (unknown [9.152.98.255])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  7 Jun 2018 14:06:42 +0100 (BST)
Subject: Re: [PATCH v5 10/13] s390: vfio-ap: sysfs interface to view matrix
 mdev matrix
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, pmorel@linux.ibm.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, borntraeger@de.ibm.com,
        cohuck@redhat.com, kwankhede@nvidia.com,
        bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
        alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com,
        alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com,
        jjherne@linux.vnet.ibm.com, thuth@redhat.com,
        pasic@linux.vnet.ibm.com, berrange@redhat.com,
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
References: <1525705912-12815-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1525705912-12815-11-git-send-email-akrowiak@linux.vnet.ibm.com>
 <a6bba129-8a3c-a848-65aa-b67816bf2d25@linux.ibm.com>
 <53275110-45fb-d50f-c97e-93141378f094@linux.vnet.ibm.com>
 <89bda651-d465-af50-a737-1900a54b01c8@linux.ibm.com>
 <6f67a282-773d-3fca-5b36-cc23ad49ba5b@linux.vnet.ibm.com>
 <32340d2a-bea6-bdb1-38a6-76afe3d54672@linux.ibm.com>
 <624dcbbf-5f40-6f27-b173-a4c533dd7781@linux.vnet.ibm.com>
 <4f42fa11-e9cc-20a9-3068-b103a8ead644@linux.ibm.com>
 <525163cf-d656-b146-05b6-2efbbd2f5a9d@linux.vnet.ibm.com>
From: Halil Pasic <pasic@linux.ibm.com>
Date: Thu, 7 Jun 2018 15:16:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <525163cf-d656-b146-05b6-2efbbd2f5a9d@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18060713-0016-0000-0000-000001D92B38
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060713-0017-0000-0000-0000322C40C3
Message-Id: <adc6b4cd-e104-98fa-6d1b-29bd2a638e5c@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-07_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806070151
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/07/2018 02:53 PM, Tony Krowiak wrote:
>>>> 2) As I said above, what you show is not the effective mask used by the guest
>>>
>>> Why would a sysfs attribute for the mediated matrix device show the effective
>>> mask used by the guest?
>>
>> OK, bad word, "effective", replace with "really".
>>
>> We do not implement any kind of provisioning nor do we implement update
>> of the CRYCB at any point after the first mediated device open.
> 
> I think this is a way we might be able to hot plug/unplug devices.
> 
>>
>>
>> Binding a queue and updating the mask can be done at any time (may be we should change this ?)
> 
> As I said above, I think we can utilize this as a means of hot plugging/unplugging AP
> adapters and domains. If the guest is running when an adapter or domain is assigned,
> we can update the guest's CRYCB at that time.
> 
>>
>>
>> What is the point of showing a matrix which will never be used by the guest?
> 
> That is simply not true. The matrix WILL be used by a guest the next time a
> guest is configured with a vfio-ap device referencing the path to the
> mediated matrix device - i.e., -device vfio-ap,sysfsdev=$PATH. The point
> is to show the matrix assigned to the mediated matrix device. In my mind, the
> mediated matrix device is a separate object from the guest. Sure it is used
> to configure a guest's matrix when the guest is started, but it could be used
> to configure the matrix for any guest; it has no direct connection to a
> particular guest until a guest using the device is started. IMHO the sysfs
> attributes for the mediated matrix device reflect only the attributes of
> the device, not the attributes of a guest.

So bottom line is what? Is the interface going to change so that modifications
to the mdev's matrix will be reflected immediately -- to support hotplug of
domains and ap cards?

Or are you intending to keep the interface as is?

If the matrix assigned to the mediated device can differ from the matrix
of the guest (that is the masks in the CRYCB, and I'm talking about a running
guest) do you provide a way for the host admin to examine the matrix of the
guest? If not, why do you think that information is irrelevant to the host
admin?

Regards,
Halil
