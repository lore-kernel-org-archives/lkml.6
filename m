Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFBA7C2F3BE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA67720861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731705AbfAUOLI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:11:08 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58180 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729708AbfAUOLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 09:11:05 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0LE4cXg067685
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 09:11:04 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2q5dqd55e3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 09:11:04 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <tmricht@linux.ibm.com>;
        Mon, 21 Jan 2019 14:11:02 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 21 Jan 2019 14:10:59 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0LEAxXq51708074
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Jan 2019 14:10:59 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F2007AE051;
        Mon, 21 Jan 2019 14:10:58 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9113CAE04D;
        Mon, 21 Jan 2019 14:10:58 +0000 (GMT)
Received: from oc3784624756.ibm.com (unknown [9.152.212.171])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 21 Jan 2019 14:10:58 +0000 (GMT)
Subject: Re: [PATCHv2 1/3] perf report: Display s390 diagnostic counter sets
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com
References: <20190117093003.96287-1-tmricht@linux.ibm.com>
 <20190117093003.96287-2-tmricht@linux.ibm.com>
 <20190117140053.GJ11922@kernel.org> <20190120181814.GB8591@krava>
 <20190121131336.GC3852@krava>
From:   Thomas-Mich Richter <tmricht@linux.ibm.com>
Organization: IBM
Date:   Mon, 21 Jan 2019 15:10:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190121131336.GC3852@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19012114-0012-0000-0000-000002EAE303
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012114-0013-0000-0000-000021220A62
Message-Id: <1277920e-4e04-88fd-9510-08ce9950da04@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-21_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901210111
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/21/2019 02:13 PM, Jiri Olsa wrote:
> On Sun, Jan 20, 2019 at 07:18:14PM +0100, Jiri Olsa wrote:
>> On Thu, Jan 17, 2019 at 11:00:53AM -0300, Arnaldo Carvalho de Melo wrote:
>>
>> SNIP
>>
>>> --- a/tools/perf/util/python-ext-sources
>>> +++ b/tools/perf/util/python-ext-sources
>>> @@ -25,6 +25,7 @@ util/parse-branch-options.c
>>>  util/rblist.c
>>>  util/counts.c
>>>  util/print_binary.c
>>> +util/s390-sample-raw.c
>>>  util/strlist.c
>>>  util/trace-event.c
>>>  ../lib/rbtree.c
>>
>> hi,
>> this change breaks the python module:
>>
>>   >>> import perf
>>   Traceback (most recent call last):
>>     File "<stdin>", line 1, in <module>
>>   ImportError: ./perf.so: undefined symbol: color_fprintf
>>
>> changelog doesn't say anything about python related change
> 
> I made some chenages and movedthat raw sample code
> under s390.. which cured the python module, but
> I haven't tested it on s390.
> 
> Could you please check if code in here works for you:
>   git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
>   perf/s390
> 
> if it works, I'll post it
> 
> thanks,
> jirka
> 

I downloaded your repository and checked out branch perf/s390. 
It works nicely, you have my tested by:
-
Tested-by: Thomas Richter <tmricht@linux.ibm.com>

PS: This looks very similar to my version 1 submitted around Jan 11th.
Arnaldo wanted a rework to be able to get these counter values on 
non-s390 platforms, that why we came up with version 2(which unfortunately
broke the perf.so python module).

PS2: This was my first encounter to python and I played around a bit
to include the necessary modules to get rid of the undefined warning.
However this ended up in a larger list of C files to include and
stopped at modules
1. util/pmu.c which refers to symbol perf_buf_in which is a FILE pointer
   used by some yacc input file.
2. perf_config_bool() which is located in util/config.c and emits a 
   compile error when included in the util/python-ext-sources file
   for python/perf.so module.

So I think this road is a dead end.

Thanks for fixing this.

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

