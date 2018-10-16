Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17067C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 08:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E6E820881
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 08:35:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E6E820881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbeJPQYz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 12:24:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58680 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726453AbeJPQYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 12:24:55 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9G8YmBc109113
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 04:35:36 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2n57pwtqqx-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 04:35:35 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <aneesh.kumar@linux.ibm.com>;
        Tue, 16 Oct 2018 09:35:33 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 16 Oct 2018 09:35:28 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9G8ZSkE4391236
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 16 Oct 2018 08:35:28 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C8E17A404D;
        Tue, 16 Oct 2018 11:34:57 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2204AA4057;
        Tue, 16 Oct 2018 11:34:56 +0100 (BST)
Received: from skywalker (unknown [9.199.58.69])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Tue, 16 Oct 2018 11:34:55 +0100 (BST)
Received: (nullmailer pid 25992 invoked by uid 1000);
        Tue, 16 Oct 2018 08:35:25 -0000
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>, akpm@linux-foundation.org,
        Michal Hocko <mhocko@kernel.org>, mpe@ellerman.id.au
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V3 1/2] mm: Add get_user_pages_cma_migrate
In-Reply-To: <485adcad-4996-ae2c-c098-9dc7bcd2d29a@ozlabs.ru>
References: <20180918115839.22154-1-aneesh.kumar@linux.ibm.com> <20180918115839.22154-2-aneesh.kumar@linux.ibm.com> <6112386d-65cd-fc1f-b012-e33da2c3b8fe@ozlabs.ru> <87murewecs.fsf@linux.ibm.com> <485adcad-4996-ae2c-c098-9dc7bcd2d29a@ozlabs.ru>
Date:   Tue, 16 Oct 2018 14:05:25 +0530
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 18101608-0012-0000-0000-000002B79DEA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18101608-0013-0000-0000-000020EC1312
Message-Id: <87in22wape.fsf@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-16_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=44 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=824 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810160076
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Kardashevskiy <aik@ozlabs.ru> writes:

> On 16/10/2018 18:16, Aneesh Kumar K.V wrote:
>> Alexey Kardashevskiy <aik@ozlabs.ru> writes:
>> 
>>> +			}
>>>> +		}
>>>> +	}
>>>> +	if (!list_empty(&cma_page_list)) {
>>>> +		/*
>>>> +		 * drop the above get_user_pages reference.
>>>> +		 */
>
>
> btw, can these pages be used by somebody else in this short window
> before we migrated and pinned them?

isolate lru page make sure that we remove them from lru list. So lru
walkers won't find the page. If somebody happen to increment the page
reference count in that window, the migrate_pages will fail. That is
handled via migrate_page_move_mapping returning EAGAIN

>
>
>>>> +		for (i = 0; i < ret; ++i)
>>>> +			put_page(pages[i]);
>>>> +
>>>> +		if (migrate_pages(&cma_page_list, new_non_cma_page,
>>>> +				  NULL, 0, MIGRATE_SYNC, MR_CONTIG_RANGE)) {
>>>> +			/*
>>>> +			 * some of the pages failed migration. Do get_user_pages
>>>> +			 * without migration.
>>>> +			 */
>>>> +			migrate_allow = false;
>>>
>>>
>>> migrate_allow seems useless, simply calling get_user_pages_fast() should
>>> make the code easier to read imho. And the comment says
>>> get_user_pages(), where does this guy hide?
>> 
>> I didn't get that suggestion. What we want to do here is try to migrate pages as
>> long as we find CMA pages in the result of get_user_pages_fast. If we
>> failed any migration attempt, don't try to migrate again.
>
>
> Setting migrate_allow to false here means you jump up, call
> get_user_pages_fast() and then run the loop which will do nothing just
> because if(...migrate_allow) is false. Instead of jumping up you could
> just call get_user_pages_fast().

ok, that is coding preference I guess, I prefer to avoid multiple
get_user_pages_fast there. Since we droped the page reference, we need
to _go back_ and get the page reference without attempting to migrate. That
is the way I was looking at this.

>
> btw what is migrate_pages() leaves something in cma_page_list (I cannot
> see it removing pages)? Won't it loop indefinitely?
>

putback_movable_pages take care of that. The below hunk.

			if (!list_empty(&cma_page_list))
				putback_movable_pages(&cma_page_list);

-aneesh

