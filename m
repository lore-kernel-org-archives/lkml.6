Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40842C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 04:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD9822084C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 04:36:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD9822084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbeLEEg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 23:36:29 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38560 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725909AbeLEEg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 23:36:29 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wB54Z3rj141667
        for <linux-kernel@vger.kernel.org>; Tue, 4 Dec 2018 23:36:28 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2p63surde7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 23:36:28 -0500
Received: from localhost
        by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <aneesh.kumar@linux.ibm.com>;
        Wed, 5 Dec 2018 04:36:27 -0000
Received: from b03cxnp08025.gho.boulder.ibm.com (9.17.130.17)
        by e35.co.us.ibm.com (192.168.1.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 5 Dec 2018 04:36:21 -0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wB54aKUm22020198
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 5 Dec 2018 04:36:20 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 124BD6E056;
        Wed,  5 Dec 2018 04:36:20 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 911376E04C;
        Wed,  5 Dec 2018 04:36:04 +0000 (GMT)
Received: from [9.85.73.253] (unknown [9.85.73.253])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed,  5 Dec 2018 04:36:04 +0000 (GMT)
Subject: Re: [RFC PATCH 02/14] mm/hms: heterogenenous memory system (HMS)
 documentation
To:     Jerome Glisse <jglisse@redhat.com>, Andi Kleen <ak@linux.intel.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Haggai Eran <haggaie@mellanox.com>,
        Balbir Singh <balbirs@au1.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Felix Kuehling <felix.kuehling@amd.com>,
        Philip Yang <Philip.Yang@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Paul Blinzer <Paul.Blinzer@amd.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>
References: <20181203233509.20671-1-jglisse@redhat.com>
 <20181203233509.20671-3-jglisse@redhat.com> <875zw98bm4.fsf@linux.intel.com>
 <20181204182421.GC2937@redhat.com>
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Date:   Wed, 5 Dec 2018 10:06:02 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181204182421.GC2937@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18120504-0012-0000-0000-000016E4A024
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010173; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01127161; UDB=6.00585442; IPR=6.00907296;
 MB=3.00024452; MTD=3.00000008; XFM=3.00000015; UTC=2018-12-05 04:36:25
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18120504-0013-0000-0000-00005557B37A
Message-Id: <72f1141b-ffb5-71cb-8404-b55510b30267@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-05_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812050041
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/4/18 11:54 PM, Jerome Glisse wrote:
> On Tue, Dec 04, 2018 at 09:06:59AM -0800, Andi Kleen wrote:
>> jglisse@redhat.com writes:
>>
>>> +
>>> +To help with forward compatibility each object as a version value and
>>> +it is mandatory for user space to only use target or initiator with
>>> +version supported by the user space. For instance if user space only
>>> +knows about what version 1 means and sees a target with version 2 then
>>> +the user space must ignore that target as if it does not exist.
>>
>> So once v2 is introduced all applications that only support v1 break.
>>
>> That seems very un-Linux and will break Linus' "do not break existing
>> applications" rule.
>>
>> The standard approach that if you add something incompatible is to
>> add new field, but keep the old ones.
> 
> No that's not how it is suppose to work. So let says it is 2018 and you
> have v1 memory (like your regular main DDR memory for instance) then it
> will always be expose a v1 memory.
> 
> Fast forward 2020 and you have this new type of memory that is not cache
> coherent and you want to expose this to userspace through HMS. What you
> do is a kernel patch that introduce the v2 type for target and define a
> set of new sysfs file to describe what v2 is. On this new computer you
> report your usual main memory as v1 and your new memory as v2.
> 
> So the application that only knew about v1 will keep using any v1 memory
> on your new platform but it will not use any of the new memory v2 which
> is what you want to happen. You do not have to break existing application
> while allowing to add new type of memory.
> 

So the knowledge that v1 is coherent and v2 is non-coherent is within 
the application? That seems really complicated from application point of 
view. Rill that v1 and v2 definition be arch and system dependent?

if we want to encode properties of a target and initiator we should do 
that as files within these directory. Something like 'is_cache_coherent'
in the target director can be used to identify whether the target is 
cache coherent or not?

-aneesh

