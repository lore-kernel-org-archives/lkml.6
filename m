Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754371AbeDQQha (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 12:37:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37360 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753928AbeDQQh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 12:37:27 -0400
Subject: Re: [PATCH v4 15/15] s390: doc: detailed specifications for AP
 virtualization
To: Pierre Morel <pmorel@linux.vnet.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com,
        bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
        alex.williamson@redhat.com, alifm@linux.vnet.ibm.com,
        mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com,
        thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com,
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
References: <1523827345-11600-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1523827345-11600-16-git-send-email-akrowiak@linux.vnet.ibm.com>
 <04a0cf49-71a1-214a-7261-d8e55adee1de@linux.vnet.ibm.com>
 <65d3b123-7a0a-4de3-687f-5b6707e797f7@linux.vnet.ibm.com>
 <53283f8e-52b5-5653-044c-843b5b033a1e@linux.vnet.ibm.com>
From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Date: Tue, 17 Apr 2018 12:37:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <53283f8e-52b5-5653-044c-843b5b033a1e@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18041716-0040-0000-0000-0000041CFB4E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008871; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01019290; UDB=6.00519990; IPR=6.00798531;
 MB=3.00020619; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-17 16:37:25
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041716-0041-0000-0000-00000822FFC9
Message-Id: <c15ce906-70b9-0462-e6e0-0bd3b77387d0@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-17_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804170145
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/17/2018 12:25 PM, Pierre Morel wrote:
> On 17/04/2018 18:14, Tony Krowiak wrote:
>> On 04/16/2018 09:13 AM, Pierre Morel wrote:
>>> On 15/04/2018 23:22, Tony Krowiak wrote:
>>>> This patch provides documentation describing the AP architecture and
>>>> design concepts behind the virtualization of AP devices. It also
>>>>
> ...snip...
>>>> +The process for reserving an AP queue for use by a KVM guest is:
>>>> +
>>>> +* The vfio-ap driver during its initialization will perform the 
>>>> following:
>>>> +  * Create the 'vfio_ap' root device - /sys/devices/vfio_ap
>>>> +  * Create the 'matrix' device in the 'vfio_ap' root
>>>> +  * Register the matrix device with the device core
>>>> +* Register with the ap_bus for AP queue devices of type CEX4, CEX5 
>>>> and
>>>> +  CEX6 and to provide the vfio_ap driver's probe and remove 
>>>> callback interfaces.
>>>
>>> I wonder why the type of card has anything to do with this driver.
>>> It should be transparent, the driver should be able to provide the 
>>> matrix (APM/AQM/ADM)
>>> independently from the type of card in the slot.
>>
>> We've been down this road several times before. We are only 
>> supporting virtualization of
>> CEX4 and newer cards. Also, the AP bus requires registering for 
>> specific card types.
>
> Yes I know, but the AP BUS design may be not the optimal for the AP 
> Matrix.
> The AP Matrix is device independent.
> We just write/clear bits in a matrix and we do not care what is plugged.
>
> So may be make clear that this device dependence is due to the actual 
> AP BUS interface design.

Okay, will do.

>
>>
>>>
>>>
>>> Regards,
>>>
>>> Pierre
>>>
>>
>
