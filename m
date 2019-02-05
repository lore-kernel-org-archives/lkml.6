Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 170E9C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 20:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4A992175B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 20:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729474AbfBEU1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 15:27:11 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37766 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726927AbfBEU1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 15:27:10 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x15KK1tY135084
        for <linux-kernel@vger.kernel.org>; Tue, 5 Feb 2019 15:27:09 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qfgmvajsy-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 15:27:09 -0500
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Tue, 5 Feb 2019 20:27:08 -0000
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 5 Feb 2019 20:27:06 -0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x15KR2mV23396482
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 5 Feb 2019 20:27:02 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AFB1CAC065;
        Tue,  5 Feb 2019 20:27:02 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 315ACAC059;
        Tue,  5 Feb 2019 20:27:02 +0000 (GMT)
Received: from [9.80.215.235] (unknown [9.80.215.235])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  5 Feb 2019 20:27:02 +0000 (GMT)
Subject: Re: [PATCH] zcrypt: handle AP Info notification from CHSC SEI command
To:     Sebastian Ott <sebott@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        oberpar@linux.ibm.com, freude@linux.ibm.com, pmorel@linux.ibm.com,
        pasic@linux.ibm.com, cohuck@redhat.com
References: <1548870526-30595-1-git-send-email-akrowiak@linux.ibm.com>
 <alpine.LFD.2.21.1901301912380.2372@schleppi>
 <88b72363-9dca-4653-c326-9c37b6349a32@linux.ibm.com>
 <alpine.LFD.2.21.1902041056190.1862@schleppi.aag-de.ibmmobiledemo.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Tue, 5 Feb 2019 15:27:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <alpine.LFD.2.21.1902041056190.1862@schleppi.aag-de.ibmmobiledemo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19020520-0068-0000-0000-0000038E5135
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010543; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000279; SDB=6.01156796; UDB=6.00603458; IPR=6.00937321;
 MB=3.00025448; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-05 20:27:08
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19020520-0069-0000-0000-00004765E039
Message-Id: <685a08b6-6cbb-04c1-0b73-f07e4c329246@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-05_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=864 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902050152
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/4/19 5:01 AM, Sebastian Ott wrote:
> On Thu, 31 Jan 2019, Tony Krowiak wrote:
>> On 1/30/19 1:32 PM, Sebastian Ott wrote:
>>> On Wed, 30 Jan 2019, Tony Krowiak wrote:
>>>> +++ b/drivers/s390/cio/chsc.h
>>>> @@ -9,6 +9,7 @@
>>>>    #include <asm/chsc.h>
>>>>    #include <asm/schid.h>
>>>>    #include <asm/qdio.h>
>>>> +#include <asm/ap.h>
>>>
>>> This should be moved to chsc.c
>>
>> I can do that, but I'm curious why.
> 
> You only need to include ap.h because of the ap_bus_cfg_chg definition and
> you only use that in chsc.c . Other users of chsc.h don't call that
> function.
> 
> Regards,
> Sebastian

Thanks Sebastian, I've made the change and it will be in v2 when I post
it.

> 

