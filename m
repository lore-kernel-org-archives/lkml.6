Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751272AbeECJCp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 05:02:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54054 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751173AbeECJCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 05:02:41 -0400
Subject: Re: [PATCH 09/10] vfio: ccw: Suppressing the BOXED state
To: Cornelia Huck <cohuck@redhat.com>
Cc: pasic@linux.vnet.ibm.com, bjsdjshi@linux.vnet.ibm.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
References: <1524149293-12658-1-git-send-email-pmorel@linux.vnet.ibm.com>
 <1524149293-12658-10-git-send-email-pmorel@linux.vnet.ibm.com>
 <20180425104429.582618f8.cohuck@redhat.com>
 <32efd6b2-78b0-ae44-3a64-a092f9d412fe@linux.vnet.ibm.com>
 <20180430174718.7b1e5651.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Thu, 3 May 2018 11:02:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180430174718.7b1e5651.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18050309-0040-0000-0000-000004547720
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050309-0041-0000-0000-000020F89C4A
Message-Id: <0d95b955-1567-cead-35d2-9d784b74ffa0@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-03_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805030086
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/04/2018 17:47, Cornelia Huck wrote:
> On Wed, 25 Apr 2018 15:55:51 +0200
> Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:
>
>> On 25/04/2018 10:44, Cornelia Huck wrote:
>>> On Thu, 19 Apr 2018 16:48:12 +0200
>>> Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:
>>>   
>>>> VFIO_CCW_STATE_BOXED and VFIO_CCW_STATE_BUSY are the same
>>>> states.
>>>> Let's only keep one: VFIO_CCW_STATE_BUSY
>>>>
>>>> Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
>>>> ---
>>>>    drivers/s390/cio/vfio_ccw_fsm.c     | 9 ---------
>>>>    drivers/s390/cio/vfio_ccw_private.h | 1 -
>>>>    2 files changed, 10 deletions(-)
>>> I think they were initially supposed to cover two different things:
>>> - BUSY: we're currently dealing with an I/O request
>>> - BOXED: the device currently won't talk to us or we won't talk to it
>>>
>>> It seems we never really did anything useful with BOXED; but should we?
>>>   
>> I do not know what.
> The BUSY state is something we know that we'll get out of soon-ish
> (when the I/O request has finished). We could conceivably use a timeout
> and drop to the BOXED state if we don't get an answer.

Absolutely, timeout on requests is something I wanted to do in a second 
series.

>
> I think this plays also into the reserve/release and path handling
> questions. One of the more common reasons for devices to become boxed
> I've seen is another system doing a reserve on a dasd.
>

-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
