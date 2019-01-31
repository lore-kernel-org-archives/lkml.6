Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A11C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 07:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 329F320870
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 07:57:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730187AbfAaH5B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 02:57:01 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39296 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725880AbfAaH5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 02:57:01 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0V7uLTk091461
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 02:56:59 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qbw2h0132-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 02:56:59 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Thu, 31 Jan 2019 07:56:57 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 31 Jan 2019 07:56:54 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0V7urwn6029626
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 31 Jan 2019 07:56:53 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9864DA4060;
        Thu, 31 Jan 2019 07:56:53 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0141DA405F;
        Thu, 31 Jan 2019 07:56:52 +0000 (GMT)
Received: from [9.124.31.24] (unknown [9.124.31.24])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 31 Jan 2019 07:56:51 +0000 (GMT)
Subject: Re: System crash with perf_fuzzer (kernel: 5.0.0-rc3)
To:     Andi Kleen <ak@linux.intel.com>
Cc:     lkml <linux-kernel@vger.kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        eranian@google.com, vincent.weaver@maine.edu,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <7c7ec3d9-9af6-8a1d-515d-64dcf8e89b78@linux.ibm.com>
 <20190125160056.GG6118@tassilo.jf.intel.com>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date:   Thu, 31 Jan 2019 13:28:34 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190125160056.GG6118@tassilo.jf.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19013107-0012-0000-0000-000002EF4FE2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19013107-0013-0000-0000-0000212699D6
Message-Id: <33d300b5-f8b0-4987-4d4c-b5175b6b6c60@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-31_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=828 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901310063
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,

On 1/25/19 9:30 PM, Andi Kleen wrote:
>> [Fri Jan 25 10:28:53 2019] perf: interrupt took too long (2501 > 2500), lowering kernel.perf_event_max_sample_rate to 79750
>> [Fri Jan 25 10:29:08 2019] perf: interrupt took too long (3136 > 3126), lowering kernel.perf_event_max_sample_rate to 63750
>> [Fri Jan 25 10:29:11 2019] perf: interrupt took too long (4140 > 3920), lowering kernel.perf_event_max_sample_rate to 48250
>> [Fri Jan 25 10:29:11 2019] perf: interrupt took too long (5231 > 5175), lowering kernel.perf_event_max_sample_rate to 38000
>> [Fri Jan 25 10:29:11 2019] perf: interrupt took too long (6736 > 6538), lowering kernel.perf_event_max_sample_rate to 29500
> 
> These are fairly normal.

I understand that throttling mechanism is designed exactly to do this.
But I've observed that, everytime I run the fuzzer, max_sample_rates is
been throttled down to 250 (which is CONFIG_HZ I guess). Doesn't this
mean the interrupt time is somehow increasing gradually? Is that fine?

Here is the sample dmesg:

[Thu Jan 31 09:25:40 2019] perf: interrupt took too long (2928 > 2500), lowering kernel.perf_event_max_sample_rate to 68250
[Thu Jan 31 09:25:40 2019] perf: interrupt took too long (4363 > 3660), lowering kernel.perf_event_max_sample_rate to 45750
[Thu Jan 31 09:25:40 2019] INFO: NMI handler (perf_event_nmi_handler) took too long to run: 2.183 msecs
[Thu Jan 31 09:25:40 2019] perf: interrupt took too long (21382 > 5453), lowering kernel.perf_event_max_sample_rate to 9250
[Thu Jan 31 09:25:40 2019] perf: interrupt took too long (34548 > 26727), lowering kernel.perf_event_max_sample_rate to 5750
[Thu Jan 31 09:25:40 2019] INFO: NMI handler (perf_event_nmi_handler) took too long to run: 3.509 msecs
[Thu Jan 31 09:25:40 2019] perf: interrupt took too long (61682 > 43185), lowering kernel.perf_event_max_sample_rate to 3000
[Thu Jan 31 09:25:40 2019] INFO: NMI handler (perf_event_nmi_handler) took too long to run: 3.593 msecs
[Thu Jan 31 09:25:40 2019] perf: interrupt took too long (89206 > 77102), lowering kernel.perf_event_max_sample_rate to 2000
[Thu Jan 31 09:25:40 2019] INFO: NMI handler (perf_event_nmi_handler) took too long to run: 3.619 msecs
[Thu Jan 31 09:25:40 2019] perf: interrupt took too long (120188 > 111507), lowering kernel.perf_event_max_sample_rate to 1500
[Thu Jan 31 09:25:40 2019] INFO: NMI handler (perf_event_nmi_handler) took too long to run: 3.782 msecs
[Thu Jan 31 09:25:40 2019] perf: interrupt took too long (171065 > 150235), lowering kernel.perf_event_max_sample_rate to 1000
[Thu Jan 31 09:25:40 2019] INFO: NMI handler (perf_event_nmi_handler) took too long to run: 4.066 msecs
[Thu Jan 31 09:25:40 2019] perf: interrupt took too long (226815 > 213831), lowering kernel.perf_event_max_sample_rate to 750
[Thu Jan 31 09:25:40 2019] INFO: NMI handler (perf_event_nmi_handler) took too long to run: 5.364 msecs
[Thu Jan 31 09:25:40 2019] perf: interrupt took too long (300844 > 283518), lowering kernel.perf_event_max_sample_rate to 500
[Thu Jan 31 09:33:43 2019] INFO: NMI handler (perf_event_nmi_handler) took too long to run: 6.136 msecs
[Thu Jan 31 09:50:35 2019] perf: interrupt took too long (378352 > 376055), lowering kernel.perf_event_max_sample_rate to 500
[Thu Jan 31 09:53:47 2019] INFO: NMI handler (perf_event_nmi_handler) took too long to run: 6.456 msecs
[Thu Jan 31 09:57:31 2019] INFO: NMI handler (perf_event_nmi_handler) took too long to run: 11.002 msecs
[Thu Jan 31 10:01:30 2019] perf: interrupt took too long (478447 > 472940), lowering kernel.perf_event_max_sample_rate to 250
[Thu Jan 31 12:28:31 2019] perf: interrupt took too long (601630 > 598058), lowering kernel.perf_event_max_sample_rate to 250
[Thu Jan 31 12:28:31 2019] perf: interrupt took too long (754288 > 752037), lowering kernel.perf_event_max_sample_rate to 250
[Thu Jan 31 12:43:13 2019] INFO: NMI handler (perf_event_nmi_handler) took too long to run: 12.781 msecs
[Thu Jan 31 12:43:13 2019] INFO: NMI handler (perf_event_nmi_handler) took too long to run: 13.583 msecs

Thanks,
Ravi

