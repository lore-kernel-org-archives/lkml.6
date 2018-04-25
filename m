Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754185AbeDYNya (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 09:54:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55600 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753571AbeDYNy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 09:54:28 -0400
Subject: Re: [PATCH 03/10] vfio: ccw: new SCH_EVENT event
To: Cornelia Huck <cohuck@redhat.com>
Cc: pasic@linux.vnet.ibm.com, bjsdjshi@linux.vnet.ibm.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
References: <1524149293-12658-1-git-send-email-pmorel@linux.vnet.ibm.com>
 <1524149293-12658-4-git-send-email-pmorel@linux.vnet.ibm.com>
 <20180425102519.16e6195b.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Wed, 25 Apr 2018 15:54:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180425102519.16e6195b.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18042513-0020-0000-0000-00000415AE09
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042513-0021-0000-0000-000042AA1A8C
Message-Id: <c9dee10d-e189-6b3a-46b3-acb4baab9043@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-25_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804250132
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/04/2018 10:25, Cornelia Huck wrote:
> On Thu, 19 Apr 2018 16:48:06 +0200
> Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:
>
>> The Sub channel event callback is threaded using workqueues.
>> The work uses the FSM introducing the VFIO_CCW_EVENT_SCH_EVENT
>> event.
> I don't think this is a good name; after all, all of the events are
> events for the subchannel :)
>
> This seems to be more of a "we need to update the schib" event...
> VFIO_CCW_EVENT_SCHIB_CHANGED? _SCH_CHANGED? _UPDATE_NEEDED?
>
> Tbh, I'm not quite sure this makes sense for me yet... will continue
> reading, but this probably needs a 'why'.

SCHIB_CHANGED or something like this sounds better indeed. :)

>
>> The update of the SCHIB is now done inside the FSM function.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
>> ---
>>   drivers/s390/cio/vfio_ccw_drv.c     | 33 +++++++++++++--------------------
>>   drivers/s390/cio/vfio_ccw_fsm.c     | 23 +++++++++++++++++++++++
>>   drivers/s390/cio/vfio_ccw_private.h |  3 +++
>>   3 files changed, 39 insertions(+), 20 deletions(-)


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
