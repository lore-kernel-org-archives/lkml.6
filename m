Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965981AbeCAFIn (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 00:08:43 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40744 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932086AbeCAFIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 00:08:41 -0500
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: Re: [RFC 0/4] trace_uprobe: Support SDT markers having semaphore
To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, ananth@linux.vnet.ibm.com,
        naveen.n.rao@linux.vnet.ibm.com, oleg@redhat.com,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
References: <20180228075345.674-1-ravi.bangoria@linux.vnet.ibm.com>
 <20180228120617.GA63063@linux.vnet.ibm.com>
Date: Thu, 1 Mar 2018 10:40:43 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180228120617.GA63063@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18030105-0016-0000-0000-0000052B4502
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18030105-0017-0000-0000-000028684789
Message-Id: <e8011c4b-0fce-c8e5-897b-7b15eba43eaa@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-01_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803010064
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/28/2018 05:36 PM, Srikar Dronamraju wrote:
> * Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com> [2018-02-28 13:23:41]:
>
>>   # readelf -n ./tick
>>   Provider: tick
>>   Name: loop2
>>   ... Semaphore: 0x0000000010020036
>>
>>   # readelf -SW ./tick | grep probes
>>   [25] .probes           PROGBITS        0000000010020034 010034
>>
>>
>> Semaphore offset is 0x10036. I don't have educated 'perf probe'
>> about semaphore. So instead of using 'perf probe' command, I'm
>> manually adding entry in the <tracefs>/uprobe_events file.
>> Special char * denotes semaphore offset.
>>
>>
>>   # echo "p:sdt_tick/loop2 /tmp/tick:0x6e4 *0x10036" > uprobe_events
>>
>>   # perf stat -e sdt_tick:loop2 -- /tmp/tick
>>   hi: 0
>>   hi: 1
>>   hi: 2
>>   hi: 3
>>   ^C
>>   Performance counter stats for '/tmp/tick':
>>               4      sdt_tick:loop2                                              
>>      3.359047827 seconds time elapsed
>>
>>
>> Feedback?
>>
>> TODO:
>>  - Educate perf tool about semaphore.
>>
> Is it possible to extend perf buildcache with a new option to work with
> semaphore?

Yes, that should be fairly easy to do. Will add a patch for that.

Thanks for the review,
Ravi
