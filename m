Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751820AbeFEMk6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 08:40:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57574 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751687AbeFEMky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 08:40:54 -0400
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v5 10/13] s390: vfio-ap: sysfs interface to view matrix
 mdev matrix
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com,
        bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
        alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com,
        alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com,
        jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com,
        berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
References: <1525705912-12815-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1525705912-12815-11-git-send-email-akrowiak@linux.vnet.ibm.com>
 <a6bba129-8a3c-a848-65aa-b67816bf2d25@linux.ibm.com>
 <53275110-45fb-d50f-c97e-93141378f094@linux.vnet.ibm.com>
 <89bda651-d465-af50-a737-1900a54b01c8@linux.ibm.com>
 <6f67a282-773d-3fca-5b36-cc23ad49ba5b@linux.vnet.ibm.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Tue, 5 Jun 2018 14:40:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <6f67a282-773d-3fca-5b36-cc23ad49ba5b@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18060512-4275-0000-0000-0000028A5C02
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060512-4276-0000-0000-00003791603C
Message-Id: <32340d2a-bea6-bdb1-38a6-76afe3d54672@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-05_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=797 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806050147
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/05/2018 16:28, Tony Krowiak wrote:
> On 05/24/2018 05:10 AM, Pierre Morel wrote:
>> On 23/05/2018 16:38, Tony Krowiak wrote:
>>> On 05/16/2018 03:55 AM, Pierre Morel wrote:
>>>> On 07/05/2018 17:11, Tony Krowiak wrote:
>>>>> Provides a sysfs interface to view the AP matrix configured for the
>>>>> mediated matrix device.
>>>>>
>>>>> The relevant sysfs structures are:
>>>>>
>>>>> /sys/devices/vfio_ap
>>>>> ... [matrix]
>>>>> ...... [mdev_supported_types]
>>>>> ......... [vfio_ap-passthrough]
>>>>> ............ [devices]
>>>>> ...............[$uuid]
>>>>> .................. matrix
>>>>>
>>>>> To view the matrix configured for the mediated matrix device,
>>>>> print the matrix file:
>>>>
>>>> This is the configured matrix, not the one used by the guest.
>>>> Nothing in the patches protect against binding a queue and assigning
>>>> a new AP when the guest runs.
>>>> The card and queue will be showed by this entry.
>>>
>>> Of course, as stated above, this is the matrix configured for the
>>> mediated matrix device. Are you suggesting here that the driver
>>> should prevent assigning a new adapter or domain while a guest is
>>> running? Couldn't this be a step in the process for hot (un)plugging
>>> AP queues?
>>
>> No, I mean what is the point to show this?
>> It is not what the guest sees.
>> Has it any use case?
>
> The point is to display the matrix so one can view the AP queues that
> have been assigned to the mediated matrix device. This is the only way
> to view the matrix. Do you not find value in being able to see what
> has been assigned to the mediated matrix device?

Two things:
1) I think it is better to retrieve the individual masks
2) As I said above, what you show is not the effective mask used by the 
guest




-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
