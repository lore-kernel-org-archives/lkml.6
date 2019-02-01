Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99736C282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 07:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F3FA20869
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 07:52:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbfBAHws (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 02:52:48 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60794 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726844AbfBAHwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 02:52:46 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x117j8OH016267
        for <linux-kernel@vger.kernel.org>; Fri, 1 Feb 2019 02:52:45 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qchsmgtxn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 02:52:45 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Fri, 1 Feb 2019 07:52:42 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 1 Feb 2019 07:52:39 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x117qcgp57475306
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 1 Feb 2019 07:52:38 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C790BA4053;
        Fri,  1 Feb 2019 07:52:38 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1D605A404D;
        Fri,  1 Feb 2019 07:52:37 +0000 (GMT)
Received: from [9.124.31.206] (unknown [9.124.31.206])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  1 Feb 2019 07:52:36 +0000 (GMT)
Subject: Re: System crash with perf_fuzzer (kernel: 5.0.0-rc3)
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andi Kleen <ak@linux.intel.com>, eranian@google.com,
        vincent.weaver@maine.edu,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <7c7ec3d9-9af6-8a1d-515d-64dcf8e89b78@linux.ibm.com>
 <20190130183648.GA24233@krava> <20190131082711.GC24233@krava>
 <20190201074353.GA8778@krava>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date:   Fri, 1 Feb 2019 13:24:19 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190201074353.GA8778@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19020107-0028-0000-0000-00000341B78E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19020107-0029-0000-0000-000023FFBDC9
Message-Id: <4e816b25-1763-ec23-0642-19e6258e6ac5@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-01_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902010058
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 2/1/19 1:13 PM, Jiri Olsa wrote:
> On Thu, Jan 31, 2019 at 09:27:11AM +0100, Jiri Olsa wrote:
>> On Wed, Jan 30, 2019 at 07:36:48PM +0100, Jiri Olsa wrote:
>>
>> SNIP
>>
>>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>>> index 280a72b3a553..22ec63a0782e 100644
>>> --- a/kernel/events/core.c
>>> +++ b/kernel/events/core.c
>>> @@ -4969,6 +4969,26 @@ static void __perf_event_period(struct perf_event *event,
>>>  	}
>>>  }
>>>  
>>> +static int check_period(struct perf_event *event, u64 value)
>>> +{
>>> +	u64 sample_period_attr = event->attr.sample_period;
>>> +	u64 sample_period_hw   = event->hw.sample_period;
>>> +	int ret;
>>> +
>>> +	if (event->attr.freq) {
>>> +		event->attr.sample_freq = value;
>>> +	} else {
>>> +		event->attr.sample_period = value;
>>> +		event->hw.sample_period = value;
>>> +	}
>>
>> hm, I think we need to check the period without changing the event,
>> because we don't disable pmu, so it might get picked up by bts code
>>
>> will check
> 
> with attached patch I did not trigger the fuzzer crash
> for over a day now, could you guys try?

I ran fuzzer for couple of hours but I didn't see any crash with
your previous patch.

I'll try this newer one as well.

Thanks.

