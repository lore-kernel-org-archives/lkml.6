Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966001AbeCAFJb (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 00:09:31 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40820 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S965984AbeCAFJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 00:09:30 -0500
Subject: Re: [RFC 1/4] Uprobe: Rename map_info to uprobe_map_info
To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, ananth@linux.vnet.ibm.com,
        naveen.n.rao@linux.vnet.ibm.com, oleg@redhat.com,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
References: <20180228075345.674-1-ravi.bangoria@linux.vnet.ibm.com>
 <20180228075345.674-2-ravi.bangoria@linux.vnet.ibm.com>
 <20180228120929.GB63063@linux.vnet.ibm.com>
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Date: Thu, 1 Mar 2018 10:41:30 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180228120929.GB63063@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18030105-0040-0000-0000-000004394527
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18030105-0041-0000-0000-000020DC4796
Message-Id: <221509ff-12ae-5348-bb17-6073198717b6@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-01_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803010065
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/28/2018 05:39 PM, Srikar Dronamraju wrote:
>> -static inline struct map_info *free_map_info(struct map_info *info)
>> +static inline struct uprobe_map_info *
>> +free_uprobe_map_info(struct uprobe_map_info *info)
>>  {
>> -	struct map_info *next = info->next;
>> +	struct uprobe_map_info *next = info->next;
>>  	kfree(info);
>>  	return next;
>>  }
>>
>> -static struct map_info *
>> -build_map_info(struct address_space *mapping, loff_t offset, bool is_register)
>> +static struct uprobe_map_info *
>> +build_uprobe_map_info(struct address_space *mapping, loff_t offset,
>> +		      bool is_register)
> Imho, uprobe_build_map_info may be better than build_uprobe_map_info,
> similarly uprobe_free_map_info.

Sure, Will change it.

Thanks,
Ravi
