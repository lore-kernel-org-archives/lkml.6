Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id DBK/Igw2GVsgWgAAmS7hNA
	; Thu, 07 Jun 2018 13:41:58 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id E15D6608BA; Thu,  7 Jun 2018 13:41:57 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 303A0607DC;
	Thu,  7 Jun 2018 13:41:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 303A0607DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=us.ibm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932617AbeFGNlz convert rfc822-to-8bit (ORCPT
        <rfc822;monsieuricon@codeaurora.org> + 25 others);
        Thu, 7 Jun 2018 09:41:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59100 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932188AbeFGNlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 09:41:53 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w57DbxHP007316
        for <linux-kernel@vger.kernel.org>; Thu, 7 Jun 2018 09:41:53 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jf5f19ecj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 09:41:53 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pc@us.ibm.com>;
        Thu, 7 Jun 2018 09:41:52 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 7 Jun 2018 09:41:49 -0400
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w57DfmOM17432894
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 7 Jun 2018 13:41:48 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4CC53AE05C;
        Thu,  7 Jun 2018 09:42:04 -0400 (EDT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 26179AE068;
        Thu,  7 Jun 2018 09:42:03 -0400 (EDT)
Received: from oc3272150783.ibm.com (unknown [9.85.134.143])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTPS;
        Thu,  7 Jun 2018 09:42:03 -0400 (EDT)
Subject: Re: [PATCH 42/46] perf script powerpc: Python script for hypervisor
 call statistics
To: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Namhyung Kim <namhyung@kernel.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
References: <20180605175030.32549-1-acme@kernel.org>
 <20180605175030.32549-43-acme@kernel.org>
 <c58ba06a-2a1b-a981-b9a5-27708ea2479a@us.ibm.com>
 <5856a13c-7a34-f4f4-d5f2-100f626a213f@linux.ibm.com>
From: Paul Clarke <pc@us.ibm.com>
Date: Thu, 7 Jun 2018 08:41:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
In-Reply-To: <5856a13c-7a34-f4f4-d5f2-100f626a213f@linux.ibm.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18060713-0064-0000-0000-00000317A6AE
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009146; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000265; SDB=6.01043511; UDB=6.00534326; IPR=6.00822614;
 MB=3.00021511; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-07 13:41:52
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060713-0065-0000-0000-000039838A91
Message-Id: <d4b791e1-28ca-cd19-467b-a59e28a14f99@us.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-07_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806070154
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/07/2018 12:34 AM, Ravi Bangoria wrote:
> On 06/06/2018 08:23 PM, Paul Clarke wrote:
>> On 06/05/2018 12:50 PM, Arnaldo Carvalho de Melo wrote:
>>> From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
>>>
>>> Add python script to show hypervisor call statistics. Ex,
>>>
>>>   # perf record -a -e "{powerpc:hcall_entry,powerpc:hcall_exit}"
>>>   # perf script -s scripts/python/powerpc-hcalls.py
>>>     hcall                            count   min(ns)   max(ns)   avg(ns)
>>>     --------------------------------------------------------------------
>>>     H_RANDOM                            82       838      1164       904
>>>     H_PUT_TCE                           47      1078      5928      2003
>>>     H_EOI                              266      1336      3546      1654
>>>     H_ENTER                             28      1646      4038      1952
>>>     H_PUT_TCE_INDIRECT                 230      2166     18168      6109
>>>     H_IPI                              238      1072      3232      1688
>>>     H_SEND_LOGICAL_LAN                  42      5488     21366      7694
>>>     H_STUFF_TCE                        294       986      6210      3591
>>>     H_XIRR                             266      2286      6990      3783
>>>     H_PROTECT                           10      2196      3556      2555
>>>     H_VIO_SIGNAL                       294      1028      2784      1311
>>>     H_ADD_LOGICAL_LAN_BUFFER            53      1978      3450      2600
>>>     H_SEND_CRQ                          77      1762      7240      2447
>>
>> This translation from HCALL code to mnemonic is more generally useful.  Is there a good way to make the "hcall_table_lookup" function more generally available, like "syscall_name" in scripts/python/Perf-Trace-Util/lib/Perf/Trace/Util.py ?  It's even simpler than the syscall ID-to-name mapping, because the HCALL codes are constant, unlike syscall IDs which vary between arches.
>>
> 
> Right, but I don't see any other python script for hcalls. So, I thought
> to add it in the script itself. Let me know if you are planning to add
> any :) We will move it in a generic module.

We're already doing the same thing in an external script.  (https://github.com/open-power-sdk/curt/blob/master/curt.py#L264 revision 107c97c3aadba3177bc8cf35b06ba165e6ac557f.)

...which reminds me that I should consider sending that script to linux-perf-users to see if it's interesting enough to be included upstream.

PC
