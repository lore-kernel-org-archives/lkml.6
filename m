Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA43C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 04:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B4C5216FE
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 04:34:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B4C5216FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbeI1K4M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 06:56:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39878 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726271AbeI1K4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 06:56:11 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8S4YMOi057633
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 00:34:23 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2msbfv3kst-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 00:34:23 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Fri, 28 Sep 2018 05:34:00 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 28 Sep 2018 05:33:57 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8S4XuD964815142
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 28 Sep 2018 04:33:56 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AB0B64C04E;
        Fri, 28 Sep 2018 07:33:39 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1B9684C04A;
        Fri, 28 Sep 2018 07:33:38 +0100 (BST)
Received: from [9.124.35.65] (unknown [9.124.35.65])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 28 Sep 2018 07:33:37 +0100 (BST)
Subject: Re: [PATCH v3 1/1] perf: Sharing PMU counters across compatible
 events
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Tejun Heo <tj@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
References: <20180924222517.197296-1-songliubraving@fb.com>
 <20180924222517.197296-2-songliubraving@fb.com>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date:   Fri, 28 Sep 2018 10:03:54 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180924222517.197296-2-songliubraving@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18092804-0008-0000-0000-000002780EF4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092804-0009-0000-0000-000021E119B6
Message-Id: <0b57307e-b75c-5df8-1ea7-27d527577489@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-28_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809280048
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Song,

On 09/25/2018 03:55 AM, Song Liu wrote:
> This patch tries to enable PMU sharing. To make perf event scheduling
> fast, we use special data structures.
> 
> An array of "struct perf_event_dup" is added to the perf_event_context,
> to remember all the duplicated events under this ctx. All the events
> under this ctx has a "dup_id" pointing to its perf_event_dup. Compatible
> events under the same ctx share the same perf_event_dup. The following
> figure shows a simplified version of the data structure.
> 
>       ctx ->  perf_event_dup -> master
>                      ^
>                      |
>          perf_event /|
>                      |
>          perf_event /
> 

I've not gone through the patch in detail, but I was specifically
interested in scenarios where one perf instance is counting event
systemwide and thus other perf instance fails to count the same
event for a specific workload because that event can be counted
in one hw counter only.

Ex: https://lkml.org/lkml/2018/3/12/1011

Seems this patch does not solve this issue. Please let me know if
I'm missing anything.

Thanks,
Ravi

