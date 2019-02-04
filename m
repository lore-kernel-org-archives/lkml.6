Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE64C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13E932081B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:15:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbfBDKPb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:15:31 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50954 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726928AbfBDKPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:15:31 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x14AEFWY002798
        for <linux-kernel@vger.kernel.org>; Mon, 4 Feb 2019 05:15:30 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qegg08k0s-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 05:15:29 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <freude@linux.ibm.com>;
        Mon, 4 Feb 2019 10:15:27 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 4 Feb 2019 10:15:26 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x14AFOKi49479834
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 4 Feb 2019 10:15:24 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 537A952063;
        Mon,  4 Feb 2019 10:15:24 +0000 (GMT)
Received: from [10.0.2.15] (unknown [9.152.224.114])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id CC97B52050;
        Mon,  4 Feb 2019 10:15:23 +0000 (GMT)
Subject: Re: [PATCH] zcrypt: handle AP Info notification from CHSC SEI command
To:     Cornelia Huck <cohuck@redhat.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        sebott@linux.ibm.com, oberpar@linux.ibm.com, pmorel@linux.ibm.com,
        pasic@linux.ibm.com
References: <1548870526-30595-1-git-send-email-akrowiak@linux.ibm.com>
 <20190131105555.4af6d8ea.cohuck@redhat.com>
 <2bb57977-bf03-f0c9-abd9-8baa74d31f8a@linux.ibm.com>
 <20190201153522.4f72cf00.cohuck@redhat.com>
From:   Harald Freudenberger <freude@linux.ibm.com>
Date:   Mon, 4 Feb 2019 11:15:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190201153522.4f72cf00.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19020410-0020-0000-0000-000003114975
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19020410-0021-0000-0000-000021625452
Message-Id: <26ec5e3e-de2c-ad82-825d-d20ba52c8937@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-04_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902040082
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.02.19 15:35, Cornelia Huck wrote:
> On Thu, 31 Jan 2019 18:50:57 -0500
> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
>
>> On 1/31/19 4:55 AM, Cornelia Huck wrote:
>>> On Wed, 30 Jan 2019 12:48:46 -0500
>>> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
>>> Two questions:
>>> - Does the event cover _any_ change to the AP configuration, or can the
>>>    periodic scan detect changes that are not signaled?  
>> It can detect any change, such as a change to the CRYCB masks.
> Nice. I suppose we can not rely on those messages being generated,
> though, and therefore need to keep the periodic scan...
As you wrote, I am not sure if the ap bus code can rely on this to
cover all changes. For kvm guests I think it is currently not working
as there is no such notification generated at all. So I'd like to
have the periodic scan in place.
>
>>> - Do we want to generate such an event in QEMU on plugging/unplugging
>>>    the vfio-ap device?  
>> We've discussed this quite a bit internally and decided not to implement
>> that at this time. We will address it as a future enhancement.
> Ok, but I think it would be nice to have.
>
>>>> diff --git a/drivers/s390/cio/chsc.c b/drivers/s390/cio/chsc.c
>>>> index a0baee25134c..dccccc337078 100644
>>>> --- a/drivers/s390/cio/chsc.c
>>>> +++ b/drivers/s390/cio/chsc.c
>>>> @@ -586,6 +586,15 @@ static void chsc_process_sei_scm_avail(struct chsc_sei_nt0_area *sei_area)
>>>>   			      " failed (rc=%d).\n", ret);
>>>>   }
>>>>   
>>>> +static void chsc_process_sei_ap_cfg_chg(struct chsc_sei_nt0_area *sei_area)
>>>> +{
>>>> +	CIO_CRW_EVENT(3, "chsc: ap config changed\n");
>>>> +	if (sei_area->rs != 5)
>>>> +		return;  
>>> I'm guessing that a reporting source of 5 means ap, right? (The code is
>>> silent on all those magic rs values :/)  
>> The 5 indicates the accessibility of one or more adjunct processors has
>> changed. The reason this gets called is because the CC sent with the
>> instruction indicates the AP configuration has changed, so the reporting
>> belongs where it is. There is only one RS associated with it.
> So if we'd ever get there anything but rs == 5, it would be a hardware
> or hypervisor bug? Then the code makes sense, I guess.
>
>>> If so, should the debug logging be moved after the check?  
>> covered in the response above.
>>
>>>   
>>>> +
>>>> +	ap_bus_cfg_chg();
>>>> +}
>>>> +

