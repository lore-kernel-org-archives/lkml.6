Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B24EC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 06:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EE1A20673
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 06:52:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EE1A20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729889AbeG0INI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 04:13:08 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:59317 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728766AbeG0INH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 04:13:07 -0400
X-Originating-IP: 81.250.144.103
Received: from [10.30.1.20] (LNeuilly-657-1-5-103.w81-250.abo.wanadoo.fr [81.250.144.103])
        (Authenticated sender: alex@ghiti.fr)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id CE5722000A;
        Fri, 27 Jul 2018 06:52:15 +0000 (UTC)
Subject: Re: [PATCH v4 00/11] hugetlb: Factorize hugetlb architecture
 primitives
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Hocko <mhocko@kernel.org>
Cc:     linux@armlinux.org.uk, catalin.marinas@arm.com,
        will.deacon@arm.com, tony.luck@intel.com, fenghua.yu@intel.com,
        ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org,
        jejb@parisc-linux.org, deller@gmx.de, benh@kernel.crashing.org,
        paulus@samba.org, ysato@users.sourceforge.jp, dalias@libc.org,
        davem@davemloft.net, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
References: <20180705110716.3919-1-alex@ghiti.fr>
 <20180709141621.GD22297@dhcp22.suse.cz>
 <2173685f-7f85-7acb-4685-2383210c5fa2@ghiti.fr>
 <75195a7d-3d0f-4e55-92cc-4ad772683c75@oracle.com>
 <87tvomgqyv.fsf@concordia.ellerman.id.au>
 <99473e0d-12d8-bbea-fe9c-4e3738ab7f5a@oracle.com>
From:   Alexandre Ghiti <alex@ghiti.fr>
Message-ID: <a6d158b6-965d-7473-677d-13a9b7d46ba1@ghiti.fr>
Date:   Fri, 27 Jul 2018 08:51:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <99473e0d-12d8-bbea-fe9c-4e3738ab7f5a@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

Thanks for your review. I'm going to fix the 2nd patch as you said, 
you're right, no need to move the #include at the bottom of the file.
I'm going to post a v5, add -mm in cc and ask for inclusion in their tree.

Thanks again for your time,

Alex


On 07/26/2018 09:16 PM, Mike Kravetz wrote:
> On 07/26/2018 04:46 AM, Michael Ellerman wrote:
>> Mike Kravetz <mike.kravetz@oracle.com> writes:
>>
>>> On 07/20/2018 11:37 AM, Alex Ghiti wrote:
>>>> Does anyone have any suggestion about those patches ?
>>> I only took a quick look.  From the hugetlb perspective, I like the
>>> idea of moving routines to a common file.  If any of the arch owners
>>> (or anyone else) agree, I can do a review of the series.
>> The conversions look pretty good to me. If you want to give it a review
>> then from my point of view it could go in -mm to shake out any bugs.
> Nothing of significance found in a review.  As others have suggested,
> the (cross)compiler may be better at finding issues than human eyes.
>
> I also suggest it be added to -mm.

