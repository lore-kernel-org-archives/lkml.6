Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFFB4C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 21:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A32C821104
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 21:45:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A32C821104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbeK1IpJ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 03:45:09 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35900 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726286AbeK1IpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 03:45:09 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wARLjJVP030135
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 16:45:52 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2p1cgrkujx-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 16:45:51 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Tue, 27 Nov 2018 21:45:49 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 27 Nov 2018 21:45:44 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wARLjhwB61210818
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 27 Nov 2018 21:45:43 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0918EA4065;
        Tue, 27 Nov 2018 21:45:43 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B5B4AA4054;
        Tue, 27 Nov 2018 21:45:42 +0000 (GMT)
Received: from [9.148.204.175] (unknown [9.148.204.175])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 27 Nov 2018 21:45:42 +0000 (GMT)
Date:   Tue, 27 Nov 2018 23:45:40 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <alpine.LSU.2.11.1811271258070.4506@eggly.anvils>
References: <alpine.LSU.2.11.1811241858540.4415@eggly.anvils> <CAHk-=wjeqKYevxGnfCM4UkxX8k8xfArzM6gKkG3BZg1jBYThVQ@mail.gmail.com> <alpine.LSU.2.11.1811251900300.1278@eggly.anvils> <alpine.LSU.2.11.1811261121330.1116@eggly.anvils> <20181127105848.GD16502@rapoport-lnx> <alpine.LSU.2.11.1811271258070.4506@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCHi v2] mm: put_and_wait_on_page_locked() while page is migrated
To:     Hugh Dickins <hughd@google.com>
CC:     Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>, Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        David Herrmann <dh.herrmann@gmail.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Kan Liang <kan.liang@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Christoph Lameter <cl@linux.com>,
        Nick Piggin <npiggin@gmail.com>, pifang@redhat.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
From:   Mike Rapoport <rppt@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18112721-0008-0000-0000-000002997382
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18112721-0009-0000-0000-00002203B8E6
Message-Id: <E1C5FE6D-7BF7-40F5-85F9-BBD86D53EFC2@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-27_18:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=675 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811270183
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On November 27, 2018 11:08:50 PM GMT+02:00, Hugh Dickins <hughd@google.com> wrote:
>On Tue, 27 Nov 2018, Mike Rapoport wrote:
>> On Mon, Nov 26, 2018 at 11:27:07AM -0800, Hugh Dickins wrote:
>> > 
>> > +/*
>> > + * A choice of three behaviors for wait_on_page_bit_common():
>> > + */
>> > +enum behavior {
>> > +	EXCLUSIVE,	/* Hold ref to page and take the bit when woken, like
>> > +			 * __lock_page() waiting on then setting PG_locked.
>> > +			 */
>> > +	SHARED,		/* Hold ref to page and check the bit when woken, like
>> > +			 * wait_on_page_writeback() waiting on PG_writeback.
>> > +			 */
>> > +	DROP,		/* Drop ref to page before wait, no check when woken,
>> > +			 * like put_and_wait_on_page_locked() on PG_locked.
>> > +			 */
>> > +};
>> 
>> Can we please make it:
>> 
>> /**
>>  * enum behavior - a choice of three behaviors for
>wait_on_page_bit_common()
>>  */
>> enum behavior {
>> 	/**
>> 	 * @EXCLUSIVE: Hold ref to page and take the bit when woken,
>> 	 * like __lock_page() waiting on then setting %PG_locked.
>> 	 */
>> 	EXCLUSIVE,
>> 	/**
>> 	 * @SHARED: Hold ref to page and check the bit when woken,
>> 	 * like wait_on_page_writeback() waiting on %PG_writeback.
>> 	 */
>> 	SHARED,
>> 	/**
>> 	 * @DROP: Drop ref to page before wait, no check when woken,
>> 	 * like put_and_wait_on_page_locked() on %PG_locked.
>> 	 */
>> 	DROP,
>> };
>
>I'm with Matthew, I'd prefer not: the first looks a more readable,
>less cluttered comment to me than the second: this is just an arg
>to an internal helper in mm/filemap.c, itself not kernel-doc'ed.

Hmm, indeed, making this kernel-doc would be premature.
I was thinking about including this in a future description of the filemap internals, but until that would get written lot of things may change.

>But the comment is not there for me: if consensus is that the
>second is preferable, then sure, we can change it over.
>
>Hugh

-- 
Sincerely yours,
Mike.

