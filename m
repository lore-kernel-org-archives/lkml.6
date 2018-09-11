Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A55AC43143
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 00:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E474520881
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 00:29:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VYqfaXpI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E474520881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbeIKF0R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 01:26:17 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:39558 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbeIKF0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 01:26:17 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8B0SwM2081249;
        Tue, 11 Sep 2018 00:29:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=ybb3kqfhlKhGoZA/MhLCpIgDqPUG8odJiRyB19F49iw=;
 b=VYqfaXpI7r20e3U31Ffa6HwKycleyHIDtG6Z73lJQhlRIPyod9tUy63ulYJlujBuZ34G
 VBZFp4dlN50E/lyksbSsHTkxQXFxFZsgXxODRxdgyiik0oq11KjAVFiunCTp7KNV9Cxi
 Y/HEoll1XxuhczHrWRB71NlNS7Dd/Ob7rFNGp81nV0JfbkNs0GT8HT1TSaSJ7Jae9HRZ
 4FMz16ON8gQZanp51GwF5VN6GCMsG8n//HQV4B17hyh0X3QF0RuoQ+2hTXfyJlKKKVzp
 z3gpoYazelp7xfVhxYoZn+D1ishJybwB3x4/i3oREiAjIex8moaK7UqACg4NtvswFmta EQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2mc6cph0jy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Sep 2018 00:29:09 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w8B0T7sw027236
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Sep 2018 00:29:08 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w8B0T4hk008664;
        Tue, 11 Sep 2018 00:29:04 GMT
Received: from [192.168.1.218] (/73.143.71.164)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 10 Sep 2018 17:29:04 -0700
Subject: Re: Plumbers 2018 - Performance and Scalability Microconference
To:     John Hubbard <jhubbard@nvidia.com>,
        Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Aaron Lu <aaron.lu@intel.com>, alex.kogan@oracle.com,
        akpm@linux-foundation.org, boqun.feng@gmail.com, brouer@redhat.com,
        dave.dice@oracle.com, Dhaval Giani <dhaval.giani@oracle.com>,
        ktkhai@virtuozzo.com, ldufour@linux.vnet.ibm.com,
        Pavel.Tatashin@microsoft.com, paulmck@linux.vnet.ibm.com,
        shady.issa@oracle.com, tariqt@mellanox.com, tglx@linutronix.de,
        tim.c.chen@intel.com, vbabka@suse.cz, yang.shi@linux.alibaba.com,
        shy828301@gmail.com, Huang Ying <ying.huang@intel.com>,
        subhra.mazumdar@oracle.com,
        Steven Sistare <steven.sistare@oracle.com>, jwadams@google.com,
        ashwinch@google.com, sqazi@google.com,
        Shakeel Butt <shakeelb@google.com>, walken@google.com,
        rientjes@google.com, junaids@google.com,
        Neha Agarwal <nehaagarwal@google.com>
References: <1dc80ff6-f53f-ae89-be29-3408bf7d69cc@oracle.com>
 <35c2c79f-efbe-f6b2-43a6-52da82145638@nvidia.com>
 <55b44432-ade5-f090-bfe7-ea20f3e87285@redhat.com>
 <20180910172011.GB3902@linux-r8p5>
 <78fa0507-4789-415b-5b9c-18e3fcefebab@nvidia.com>
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
Message-ID: <3db2b742-9e09-a934-e4ef-c87465e6715a@oracle.com>
Date:   Mon, 10 Sep 2018 20:29:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <78fa0507-4789-415b-5b9c-18e3fcefebab@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9012 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=969
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809110004
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/10/18 1:34 PM, John Hubbard wrote:
> On 9/10/18 10:20 AM, Davidlohr Bueso wrote:
>> On Mon, 10 Sep 2018, Waiman Long wrote:
>>> On 09/08/2018 12:13 AM, John Hubbard wrote:
> [...]
>>>> It's also interesting that there are two main huge page systems (THP and Hugetlbfs), and I sometimes
>>>> wonder the obvious thing to wonder: are these sufficiently different to warrant remaining separate,
>>>> long-term?  Yes, I realize they're quite different in some ways, but still, one wonders. :)
>>>
>>> One major difference between hugetlbfs and THP is that the former has to
>>> be explicitly managed by the applications that use it whereas the latter
>>> is done automatically without the applications being aware that THP is
>>> being used at all. Performance wise, THP may or may not increase
>>> application performance depending on the exact memory access pattern,
>>> though the chance is usually higher that an application will benefit
>>> than suffer from it.
>>>
>>> If an application know what it is doing, using hughtblfs can boost
>>> performance more than it can ever achieved by THP. Many large enterprise
>>> applications, like Oracle DB, are using hugetlbfs and explicitly disable
>>> THP. So unless THP can improve its performance to a level that is
>>> comparable to hugetlbfs, I won't see the later going away.
>>
>> Yep, there are a few non-trivial workloads out there that flat out discourage
>> thp, ie: redis to avoid latency issues.
>>
> 
> Yes, the need for guaranteed, available-now huge pages in some cases is
> understood. That's not the quite same as saying that there have to be two different
> subsystems, though. Nor does it even necessarily imply that the pool has to be
> reserved in the same way as hugetlbfs does it...exactly.
> 
> So I'm wondering if THP behavior can be made to mimic hugetlbfs enough (perhaps
> another option, in addition to "always, never, madvise") that we could just use
> THP in all cases. But the "transparent" could become a sliding scale that could
> go all the way down to "opaque" (hugetlbfs behavior).

Leaving the interface aside, the idea that we could deduplicate redundant parts of the hugetlbfs and THP implementations, without user-visible change, seems promising.
