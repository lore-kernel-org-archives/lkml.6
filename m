Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id rhl5Cj1CGVtHeQAAmS7hNA
	; Thu, 07 Jun 2018 14:33:59 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id A5520607E7; Thu,  7 Jun 2018 14:33:59 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 05C59601D2;
	Thu,  7 Jun 2018 14:33:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 05C59601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933935AbeFGOd5 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:33:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49134 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933398AbeFGOdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:33:53 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w57EXpRa072536
        for <linux-kernel@vger.kernel.org>; Thu, 7 Jun 2018 10:33:53 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jf4n5f305-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 10:33:52 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.vnet.ibm.com>;
        Thu, 7 Jun 2018 10:33:51 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 7 Jun 2018 10:33:47 -0400
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w57EXjse65929268
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 7 Jun 2018 14:33:45 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1CE93124058;
        Thu,  7 Jun 2018 11:35:10 -0400 (EDT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0A1EA12405A;
        Thu,  7 Jun 2018 11:35:09 -0400 (EDT)
Received: from oc8043147753.ibm.com (unknown [9.85.135.133])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  7 Jun 2018 11:35:08 -0400 (EDT)
Subject: Re: [PATCH v5 10/13] s390: vfio-ap: sysfs interface to view matrix
 mdev matrix
To: Halil Pasic <pasic@linux.ibm.com>, pmorel@linux.ibm.com,
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
 <adc6b4cd-e104-98fa-6d1b-29bd2a638e5c@linux.ibm.com>
From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Date: Thu, 7 Jun 2018 10:33:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <adc6b4cd-e104-98fa-6d1b-29bd2a638e5c@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18060714-0060-0000-0000-00000279CC30
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009146; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000265; SDB=6.01043529; UDB=6.00534332; IPR=6.00822627;
 MB=3.00021513; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-07 14:33:49
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060714-0061-0000-0000-0000455F14CE
Message-Id: <93e5df44-8f31-7a3e-227e-8e6425062892@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-07_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806070165
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/07/2018 09:16 AM, Halil Pasic wrote:
>
>
> On 06/07/2018 02:53 PM, Tony Krowiak wrote:
>>>>> 2) As I said above, what you show is not the effective mask used 
>>>>> by the guest
>>>>
>>>> Why would a sysfs attribute for the mediated matrix device show the 
>>>> effective
>>>> mask used by the guest?
>>>
>>> OK, bad word, "effective", replace with "really".
>>>
>>> We do not implement any kind of provisioning nor do we implement update
>>> of the CRYCB at any point after the first mediated device open.
>>
>> I think this is a way we might be able to hot plug/unplug devices.
>>
>>>
>>>
>>> Binding a queue and updating the mask can be done at any time (may 
>>> be we should change this ?)
>>
>> As I said above, I think we can utilize this as a means of hot 
>> plugging/unplugging AP
>> adapters and domains. If the guest is running when an adapter or 
>> domain is assigned,
>> we can update the guest's CRYCB at that time.
>>
>>>
>>>
>>> What is the point of showing a matrix which will never be used by 
>>> the guest?
>>
>> That is simply not true. The matrix WILL be used by a guest the next time a 
>>
>> guest is configured with a vfio-ap device referencing the path to the
>> mediated matrix device - i.e., -device vfio-ap,sysfsdev=$PATH. The point
>> is to show the matrix assigned to the mediated matrix device. In my 
>> mind, the
>> mediated matrix device is a separate object from the guest. Sure it is used 
>>
>> to configure a guest's matrix when the guest is started, but it could 
>> be used
>> to configure the matrix for any guest; it has no direct connection to a
>> particular guest until a guest using the device is started. IMHO the sysfs 
>>
>> attributes for the mediated matrix device reflect only the attributes of
>> the device, not the attributes of a guest.
>
> So bottom line is what? Is the interface going to change so that 
> modifications
> to the mdev's matrix will be reflected immediately -- to support 
> hotplug of
> domains and ap cards?
>
>
> Or are you intending to keep the interface as is?


I have been looking in to hot plug/unplug. I am in the exploratory phase and
have not yet come up with a concrete plan, but I believe we will be able to
hot plug/unplug adapters and domains using the sysfs attributes interfaces
for the mediated matrix device.

>
>
> If the matrix assigned to the mediated device can differ from the matrix
> of the guest (that is the masks in the CRYCB, and I'm talking about a 
> running
> guest) do you provide a way for the host admin to examine the matrix 
> of the
> guest? If not, why do you think that information is irrelevant to the 
> host
> admin?

I never said the information contained in the CRYCB is irrelevant to the 
host
admin. What I said was that the sysfs attributes apply to the mediated 
device,
not the guest. There may or may not be a guest using the mediated device at
any given point in time. I do not currently provide a way to examine the 
matrix
of the guest. I'm not sure whether a sysfs attribute of the mediated
device is the appropriate venue for displaying what's in the guest's CRYCB.
I suppose we could use the mediated device matrix attribute for this purpose
if you and Pierre insist, but I think we still need to
display the matrix or devices configured for the mediated device. It 
does beg
the question, are there interfaces an admin can use to display all of 
the other
devices being used by a guest? The only surefire way to see which AP devices
are actually used by the guest is to execute lszcrypt on the guest itself.

>
>
> Regards,
> Halil
