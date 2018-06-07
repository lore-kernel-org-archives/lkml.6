Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id dcsQEswqGVv4FgAAmS7hNA
	; Thu, 07 Jun 2018 12:53:46 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id A13766089E; Thu,  7 Jun 2018 12:53:46 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id E4E2760115;
	Thu,  7 Jun 2018 12:53:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E4E2760115
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932589AbeFGMxb (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 08:53:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46764 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932418AbeFGMx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 08:53:29 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w57Chohx069875
        for <linux-kernel@vger.kernel.org>; Thu, 7 Jun 2018 08:53:28 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jf334dykm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 08:53:28 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.vnet.ibm.com>;
        Thu, 7 Jun 2018 08:53:27 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 7 Jun 2018 08:53:24 -0400
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w57CrM1s15794516
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 7 Jun 2018 12:53:22 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2F436124054;
        Thu,  7 Jun 2018 09:54:47 -0400 (EDT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 292D5124055;
        Thu,  7 Jun 2018 09:54:46 -0400 (EDT)
Received: from oc8043147753.ibm.com (unknown [9.85.135.133])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  7 Jun 2018 09:54:45 -0400 (EDT)
Subject: Re: [PATCH v5 10/13] s390: vfio-ap: sysfs interface to view matrix
 mdev matrix
To: pmorel@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
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
From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Date: Thu, 7 Jun 2018 08:53:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <4f42fa11-e9cc-20a9-3068-b103a8ead644@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18060712-0068-0000-0000-00000304C9F1
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009145; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000265; SDB=6.01043495; UDB=6.00534321; IPR=6.00822601;
 MB=3.00021511; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-07 12:53:27
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060712-0069-0000-0000-00004499D4A8
Message-Id: <525163cf-d656-b146-05b6-2efbbd2f5a9d@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-07_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806070147
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/06/2018 11:10 AM, Pierre Morel wrote:
> On 06/06/2018 16:24, Tony Krowiak wrote:
>> On 06/05/2018 08:40 AM, Pierre Morel wrote:
>>> On 30/05/2018 16:28, Tony Krowiak wrote:
>>>> On 05/24/2018 05:10 AM, Pierre Morel wrote:
>>>>> On 23/05/2018 16:38, Tony Krowiak wrote:
>>>>>> On 05/16/2018 03:55 AM, Pierre Morel wrote:
>>>>>>> On 07/05/2018 17:11, Tony Krowiak wrote:
>>>>>>>> Provides a sysfs interface to view the AP matrix configured for 
>>>>>>>> the
>>>>>>>> mediated matrix device.
>>>>>>>>
>>>>>>>> The relevant sysfs structures are:
>>>>>>>>
>>>>>>>> /sys/devices/vfio_ap
>>>>>>>> ... [matrix]
>>>>>>>> ...... [mdev_supported_types]
>>>>>>>> ......... [vfio_ap-passthrough]
>>>>>>>> ............ [devices]
>>>>>>>> ...............[$uuid]
>>>>>>>> .................. matrix
>>>>>>>>
>>>>>>>> To view the matrix configured for the mediated matrix device,
>>>>>>>> print the matrix file:
>>>>>>>
>>>>>>> This is the configured matrix, not the one used by the guest.
>>>>>>> Nothing in the patches protect against binding a queue and 
>>>>>>> assigning
>>>>>>> a new AP when the guest runs.
>>>>>>> The card and queue will be showed by this entry.
>>>>>>
>>>>>> Of course, as stated above, this is the matrix configured for the
>>>>>> mediated matrix device. Are you suggesting here that the driver
>>>>>> should prevent assigning a new adapter or domain while a guest is
>>>>>> running? Couldn't this be a step in the process for hot (un)plugging
>>>>>> AP queues?
>>>>>
>>>>> No, I mean what is the point to show this?
>>>>> It is not what the guest sees.
>>>>> Has it any use case?
>>>>
>>>> The point is to display the matrix so one can view the AP queues that
>>>> have been assigned to the mediated matrix device. This is the only way
>>>> to view the matrix. Do you not find value in being able to see what
>>>> has been assigned to the mediated matrix device?
>>>
>>> Two things:
>>> 1) I think it is better to retrieve the individual masks
>>
>> I am not certain what you mean by this. Are you suggesting we display 
>> the
>> actual mask? For example, the APM:
>>
>> 08000000000000001000000000000c0000000030000000000800000000000001
>>
>> If that is the case, I completely disagree as that would be worthless 
>> from
>> a user perspective. Trying to figure out which APs are configured 
>> would be
>> ridiculously complicated.
>
> - It is compatible with what the AP BUS shows
> - a cut and past is easy
> - you can use a userland script to translate to another format
>
>>
>> Or, are you suggesting something like this:
>>
>> 4,67,116,117,154,155,255
>
> - this is not compatible with what the AP BUS shows
> - as in the first case this is easy to parse
>
> Both propositions look better to me.
>
>>
>> Personally, I found viewing the queues to be much more valuable when
>> configuring the mediated device's matrix. I originally displayed the
>> individual adapter and domain attributes and found it cumbersome to
>> mentally configure what the matrix looked like. If you think of the
>> lszcrypt command, it outputs the adapters and queues which is the model
>> I used for this.
>
> what is the point of seeing what the matrix looks like ?
> It is interesting for the developer not for the administrator.
> What the administrator needs is:
> - To assign AP and to see what has been assigned
> - To assign domains and to see what has been assigned
>
>>
>>> 2) As I said above, what you show is not the effective mask used by 
>>> the guest
>>
>> Why would a sysfs attribute for the mediated matrix device show the 
>> effective
>> mask used by the guest?
>
> OK, bad word, "effective", replace with "really".
>
> We do not implement any kind of provisioning nor do we implement update
> of the CRYCB at any point after the first mediated device open.

I think this is a way we might be able to hot plug/unplug devices.

>
>
> Binding a queue and updating the mask can be done at any time (may be 
> we should change this ?)

As I said above, I think we can utilize this as a means of hot 
plugging/unplugging AP
adapters and domains. If the guest is running when an adapter or domain 
is assigned,
we can update the guest's CRYCB at that time.

>
>
> What is the point of showing a matrix which will never be used by the 
> guest?

That is simply not true. The matrix WILL be used by a guest the next time a
guest is configured with a vfio-ap device referencing the path to the
mediated matrix device - i.e., -device vfio-ap,sysfsdev=$PATH. The point
is to show the matrix assigned to the mediated matrix device. In my 
mind, the
mediated matrix device is a separate object from the guest. Sure it is used
to configure a guest's matrix when the guest is started, but it could be 
used
to configure the matrix for any guest; it has no direct connection to a
particular guest until a guest using the device is started. IMHO the sysfs
attributes for the mediated matrix device reflect only the attributes of
the device, not the attributes of a guest.

>
>
>
>
>>
>>>
>>>
>>>
>>>
>>>
>>
>
