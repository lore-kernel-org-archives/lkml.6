Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753346AbeDPG5n (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 02:57:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41856 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751325AbeDPG5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 02:57:42 -0400
Subject: Re: [PATCH 2/3] perf/buildid-cache: Support --list option
To: Jiri Olsa <jolsa@redhat.com>
Cc: acme@redhat.com, mhiramat@kernel.org, kstewart@linuxfoundation.org,
        tglx@linutronix.de, pombredanne@nexb.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        uneedsihyeon@gmail.com, kjlx@templeofstupid.com,
        ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20180409110633.20767-1-ravi.bangoria@linux.vnet.ibm.com>
 <20180409110633.20767-3-ravi.bangoria@linux.vnet.ibm.com>
 <20180413125801.GG28241@krava>
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Date: Mon, 16 Apr 2018 12:27:32 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180413125801.GG28241@krava>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18041606-0020-0000-0000-00000412504E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041606-0021-0000-0000-000042A688DE
Message-Id: <51d5e4fc-1c8c-96d1-6b60-390d84f2f960@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-16_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804160064
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Jiri for the reviews. Will post v2 soon.

-Ravi

On 04/13/2018 06:28 PM, Jiri Olsa wrote:
> On Mon, Apr 09, 2018 at 04:36:32PM +0530, Ravi Bangoria wrote:
>
> SNIP
>
>> -		     !remove_name_list_str && !purge_name_list_str &&
>> -		     !missing_filename && !update_name_list_str))
>> +	opts_flag = add_name_list_str || kcore_filename ||
>> +		remove_name_list_str || purge_name_list_str ||
>> +		missing_filename || update_name_list_str;
>> +
>> +	if (argc || !(list_files || opts_flag))
>>  		usage_with_options(buildid_cache_usage, buildid_cache_options);
>>  
>> +	/* -l is exclusive. It can not be used with other options. */
>> +	if (list_files && opts_flag)
>> +		usage_with_options_msg(buildid_cache_usage,
>> +			buildid_cache_options, "-l is exclusive.\n");
>> +
>>  	if (ns_id > 0)
>>  		nsi = nsinfo__new(ns_id);
>>  
>> @@ -366,6 +396,11 @@ int cmd_buildid_cache(int argc, const char **argv)
>>  
>>  	setup_pager();
>>  
>> +	if (list_files) {
>> +		build_id_cache__show_all();
>> +		goto out;
> make build_id_cache__show_all return value and store it to ret before going out
>
> jirka
>
