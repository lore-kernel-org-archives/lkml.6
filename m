Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id i/w7BunDGFvzSgAAmS7hNA
	; Thu, 07 Jun 2018 05:34:33 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 05CA06089E; Thu,  7 Jun 2018 05:34:33 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 8ADF9607DC;
	Thu,  7 Jun 2018 05:34:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8ADF9607DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752986AbeFGFea (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 01:34:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54610 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751122AbeFGFe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 01:34:28 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w575TO5h079258
        for <linux-kernel@vger.kernel.org>; Thu, 7 Jun 2018 01:34:28 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jevuxbuu5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 01:34:27 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Thu, 7 Jun 2018 06:34:26 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 7 Jun 2018 06:34:21 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w575YKLL29098106
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 7 Jun 2018 05:34:20 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7931411C054;
        Thu,  7 Jun 2018 06:25:05 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 23BAC11C052;
        Thu,  7 Jun 2018 06:25:03 +0100 (BST)
Received: from [9.124.31.114] (unknown [9.124.31.114])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  7 Jun 2018 06:25:02 +0100 (BST)
Subject: Re: [PATCH 42/46] perf script powerpc: Python script for hypervisor
 call statistics
To: Paul Clarke <pc@us.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Namhyung Kim <namhyung@kernel.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20180605175030.32549-1-acme@kernel.org>
 <20180605175030.32549-43-acme@kernel.org>
 <c58ba06a-2a1b-a981-b9a5-27708ea2479a@us.ibm.com>
From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date: Thu, 7 Jun 2018 11:04:17 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <c58ba06a-2a1b-a981-b9a5-27708ea2479a@us.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18060705-0028-0000-0000-000002CE1A2E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060705-0029-0000-0000-000023851B43
Message-Id: <5856a13c-7a34-f4f4-d5f2-100f626a213f@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-07_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806070066
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On 06/06/2018 08:23 PM, Paul Clarke wrote:
> On 06/05/2018 12:50 PM, Arnaldo Carvalho de Melo wrote:
>> From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
>>
>> Add python script to show hypervisor call statistics. Ex,
>>
>>   # perf record -a -e "{powerpc:hcall_entry,powerpc:hcall_exit}"
>>   # perf script -s scripts/python/powerpc-hcalls.py
>>     hcall                            count   min(ns)   max(ns)   avg(ns)
>>     --------------------------------------------------------------------
>>     H_RANDOM                            82       838      1164       904
>>     H_PUT_TCE                           47      1078      5928      2003
>>     H_EOI                              266      1336      3546      1654
>>     H_ENTER                             28      1646      4038      1952
>>     H_PUT_TCE_INDIRECT                 230      2166     18168      6109
>>     H_IPI                              238      1072      3232      1688
>>     H_SEND_LOGICAL_LAN                  42      5488     21366      7694
>>     H_STUFF_TCE                        294       986      6210      3591
>>     H_XIRR                             266      2286      6990      3783
>>     H_PROTECT                           10      2196      3556      2555
>>     H_VIO_SIGNAL                       294      1028      2784      1311
>>     H_ADD_LOGICAL_LAN_BUFFER            53      1978      3450      2600
>>     H_SEND_CRQ                          77      1762      7240      2447
> 
> This translation from HCALL code to mnemonic is more generally useful.  Is there a good way to make the "hcall_table_lookup" function more generally available, like "syscall_name" in scripts/python/Perf-Trace-Util/lib/Perf/Trace/Util.py ?  It's even simpler than the syscall ID-to-name mapping, because the HCALL codes are constant, unlike syscall IDs which vary between arches.
> 

Right, but I don't see any other python script for hcalls. So, I thought
to add it in the script itself. Let me know if you are planning to add
any :) We will move it in a generic module.

Ravi
