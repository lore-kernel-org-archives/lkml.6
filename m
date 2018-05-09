Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755905AbeEIGA4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 02:00:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33042 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751922AbeEIGAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 02:00:54 -0400
Subject: Re: [PATCH v2 3/3] perf/buildid-cache: Support --purge-all option
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: jolsa@redhat.com, acme@redhat.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, pombredanne@nexb.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        uneedsihyeon@gmail.com, kjlx@templeofstupid.com,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20180417041346.5617-1-ravi.bangoria@linux.vnet.ibm.com>
 <20180417041346.5617-4-ravi.bangoria@linux.vnet.ibm.com>
 <20180423160219.b58fdc600e5d6927105ba57b@kernel.org>
 <b72d8419-2933-d241-2662-899a72032aa8@linux.ibm.com>
 <20180509004257.9ad74de57b9e0f90ad5e7e81@kernel.org>
From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date: Wed, 9 May 2018 11:30:43 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180509004257.9ad74de57b9e0f90ad5e7e81@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18050906-0020-0000-0000-0000041AA215
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050906-0021-0000-0000-000042AFDF8B
Message-Id: <60b9c453-72a2-3fc7-71c7-e03eabd819ce@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-09_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805090060
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/08/2018 09:12 PM, Masami Hiramatsu wrote:
> On Thu, 3 May 2018 14:24:04 +0530
> Ravi Bangoria <ravi.bangoria@linux.ibm.com> wrote:
>
>> Hi Masami,
>>
>> On 04/23/2018 12:32 PM, Masami Hiramatsu wrote:
>>> On Tue, 17 Apr 2018 09:43:46 +0530
>>> Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com> wrote:
>>>
>>>> +	pr_debug("Purged all: %s\n", err ? "FAIL" : "Ok");
>>> Hmm, I think this should use pr_info(or pr_warning), at least for Failure case.
>> Actually, I followed what is already there for other options.
> Please see cmd_buildid_cache(), if we failed to purge one buildid-cache,
> it is warned with pr_warning.

Oh ok. I thought you are asking me to change pr_debug().
I'll quickly prepare and send a patch.

Thanks,
Ravi

>
> 	if (purge_name_list_str) {
> 		list = strlist__new(purge_name_list_str, NULL);
> 		if (list) {
> 			strlist__for_each_entry(pos, list)
> 				if (build_id_cache__purge_path(pos->s, nsi)) {
> 					if (errno == ENOENT) {
> 						pr_debug("%s wasn't in the cache\n",
> 							 pos->s);
> 						continue;
> 					}
> 					pr_warning("Couldn't remove %s: %s\n",
> 						   pos->s, str_error_r(errno, sbuf, sizeof(sbuf)));
> 				}
>
> 			strlist__delete(list);
> 		}
> 	}
>
> Thank you,
>
