Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B3F2C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E333821872
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729416AbfBAPuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 10:50:23 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39438 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726172AbfBAPuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 10:50:23 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x11FTMK6023805
        for <linux-kernel@vger.kernel.org>; Fri, 1 Feb 2019 10:50:21 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qcrfuaddn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 10:50:21 -0500
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Fri, 1 Feb 2019 15:50:20 -0000
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 1 Feb 2019 15:50:17 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x11FoEF715401074
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 1 Feb 2019 15:50:14 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5E66CB2065;
        Fri,  1 Feb 2019 15:50:14 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DEFF6B2066;
        Fri,  1 Feb 2019 15:50:13 +0000 (GMT)
Received: from [9.80.198.122] (unknown [9.80.198.122])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  1 Feb 2019 15:50:13 +0000 (GMT)
Subject: Re: [PATCH] zcrypt: handle AP Info notification from CHSC SEI command
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        sebott@linux.ibm.com, oberpar@linux.ibm.com, freude@linux.ibm.com,
        pmorel@linux.ibm.com, pasic@linux.ibm.com
References: <1548870526-30595-1-git-send-email-akrowiak@linux.ibm.com>
 <20190131105555.4af6d8ea.cohuck@redhat.com>
 <2bb57977-bf03-f0c9-abd9-8baa74d31f8a@linux.ibm.com>
 <20190201153522.4f72cf00.cohuck@redhat.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Fri, 1 Feb 2019 10:50:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190201153522.4f72cf00.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19020115-0072-0000-0000-000003F365F8
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010516; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000277; SDB=6.01154869; UDB=6.00602252; IPR=6.00935310;
 MB=3.00025389; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-01 15:50:19
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19020115-0073-0000-0000-00004B065356
Message-Id: <f89b4a46-3d95-6481-5cd3-1db52794153e@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-01_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902010116
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/1/19 9:35 AM, Cornelia Huck wrote:
> On Thu, 31 Jan 2019 18:50:57 -0500
> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
> 
>> On 1/31/19 4:55 AM, Cornelia Huck wrote:
>>> On Wed, 30 Jan 2019 12:48:46 -0500
>>> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
> 
>>> Two questions:
>>> - Does the event cover _any_ change to the AP configuration, or can the
>>>     periodic scan detect changes that are not signaled?
>>
>> It can detect any change, such as a change to the CRYCB masks.
> 
> Nice. I suppose we can not rely on those messages being generated,
> though, and therefore need to keep the periodic scan...

I don't know how the CRYCB can be changed dynamically on the host, but
hot plug for a guest changes it dynamically. Down the road, we may
send a CHSC SEI AP Configuration event to let the guest know. I don't 
know if there may be other AP config changes that can occur without this
event being posted, so it is probably a good idea to keep the scan. It
certainly doesn't hurt anything to do so.

> 
>>
>>> - Do we want to generate such an event in QEMU on plugging/unplugging
>>>     the vfio-ap device?
>>
>> We've discussed this quite a bit internally and decided not to implement
>> that at this time. We will address it as a future enhancement.
> 
> Ok, but I think it would be nice to have.

Duly noted, but that discussion is outside of scope for this patch.

> 
>>>> diff --git a/drivers/s390/cio/chsc.c b/drivers/s390/cio/chsc.c
>>>> index a0baee25134c..dccccc337078 100644
>>>> --- a/drivers/s390/cio/chsc.c
>>>> +++ b/drivers/s390/cio/chsc.c
>>>> @@ -586,6 +586,15 @@ static void chsc_process_sei_scm_avail(struct chsc_sei_nt0_area *sei_area)
>>>>    			      " failed (rc=%d).\n", ret);
>>>>    }
>>>>    
>>>> +static void chsc_process_sei_ap_cfg_chg(struct chsc_sei_nt0_area *sei_area)
>>>> +{
>>>> +	CIO_CRW_EVENT(3, "chsc: ap config changed\n");
>>>> +	if (sei_area->rs != 5)
>>>> +		return;
>>>
>>> I'm guessing that a reporting source of 5 means ap, right? (The code is
>>> silent on all those magic rs values :/)
>>
>> The 5 indicates the accessibility of one or more adjunct processors has
>> changed. The reason this gets called is because the CC sent with the
>> instruction indicates the AP configuration has changed, so the reporting
>> belongs where it is. There is only one RS associated with it.
> 
> So if we'd ever get there anything but rs == 5, it would be a hardware
> or hypervisor bug? Then the code makes sense, I guess.

I have no idea if that is possible, but this follows the architecture.

> 
>>
>>>
>>> If so, should the debug logging be moved after the check?
>>
>> covered in the response above.
>>
>>>    
>>>> +
>>>> +	ap_bus_cfg_chg();
>>>> +}
>>>> +
> 

