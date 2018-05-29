Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754948AbeE2Hol (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 03:44:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35074 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754794AbeE2Hoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 03:44:39 -0400
Subject: Re: [PATCH] perf docu: Update section on cpu topology
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, Andi Kleen <andi@firstfloor.org>
References: <20180528074433.16652-1-tmricht@linux.ibm.com>
 <20180528195412.GI25467@kernel.org>
From: Thomas-Mich Richter <tmricht@linux.ibm.com>
Organization: IBM LTC
Date: Tue, 29 May 2018 09:44:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180528195412.GI25467@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18052907-0040-0000-0000-0000043ECF7A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052907-0041-0000-0000-000026441CF5
Message-Id: <7a8d7174-0fe5-5492-9c40-8cf65a65bab9@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-29_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805290093
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/28/2018 09:54 PM, Arnaldo Carvalho de Melo wrote:
> Em Mon, May 28, 2018 at 09:44:33AM +0200, Thomas Richter escreveu:
>> Add an explanation of each cpu's core and socket
>> identifier to the documentation.
> 
> Thanks, applying. I guess it is not that worth to mention that older
> files may have just the string lists, right?
> 
> - Arnaldo

Ah, sorry but that did not cross my mind....

It was introduced with commit 
2bb00d2f95193 ("perf tools: Store the cpu socket and core ids in the perf.data header")
and is available since Linux 4.4

Hope this helps...

>  
>> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
>> ---
>>  tools/perf/Documentation/perf.data-file-format.txt | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
>> index d00f0d51cab8..c57904a526ce 100644
>> --- a/tools/perf/Documentation/perf.data-file-format.txt
>> +++ b/tools/perf/Documentation/perf.data-file-format.txt
>> @@ -153,10 +153,18 @@ struct {
>>  	HEADER_CPU_TOPOLOGY = 13,
>>  
>>  String lists defining the core and CPU threads topology.
>> +The string lists are followed by a variable length array
>> +which contains core_id and socket_id of each cpu.
>> +The number of entries can be determined by the size of the
>> +section minus the sizes of both string lists.
>>  
>>  struct {
>>         struct perf_header_string_list cores; /* Variable length */
>>         struct perf_header_string_list threads; /* Variable length */
>> +       struct {
>> +	      uint32_t core_id;
>> +	      uint32_t socket_id;
>> +       } cpus[nr]; /* Variable length records */
>>  };
>>  
>>  Example:
>> -- 
>> 2.14.3
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
