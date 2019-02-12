Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BDDFC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51686222C1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:36:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731289AbfBLUgQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 15:36:16 -0500
Received: from mondschein.lichtvoll.de ([194.150.191.11]:50365 "EHLO
        mail.lichtvoll.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727733AbfBLUgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 15:36:16 -0500
Authentication-Results: auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
Received: from 127.0.0.1 (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id 1CCAD45BB9C;
        Tue, 12 Feb 2019 21:36:14 +0100 (CET)
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     Ben Finney <bignose@debian.org>,
        Martin Steigerwald <Martin.Steigerwald@proact.de>
Cc:     Domenico Andreoli <cavok@debian.org>, 919356@bugs.debian.org,
        Kristian Fiskerstrand <k_f@gentoo.org>,
        Nadia Yvette Chambers <nyc@holomorphy.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        "debian-legal@lists.debian.org" <debian-legal@lists.debian.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jens Axboe <jens.axboe@oracle.com>
Subject: Re: Bug#919356: Licensing of include/linux/hash.h
Date:   Tue, 12 Feb 2019 21:36:13 +0100
Message-ID: <1812608.77Onv0mZ32@merkaba>
In-Reply-To: <86va1p7c7z.fsf@benfinney.id.au>
References: <20190115170017.5gxarqxzfezgr5ld@dumbo> <c3aa1b37-60bb-aceb-10ba-9768157a2a5a@gentoo.org> <20190211072259.GA19224@nouveau> <20190115083241.6c6ftrw73xuv26j6@dumbo> <2977287.v5rPGuGa1n@merkaba> <86va1p7c7z.fsf@benfinney.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/19 11:27 PM, Ben Finney wrote:
> Martin Steigerwald <Martin.Steigerwald@proact.de> writes:
> 
>> Well the file has in its header:
>>
>> /* Fast hashing routine for a long.
>>    (C) 2002 William Lee Irwin III, IBM */
>>
>> /*
>>  * Knuth recommends primes in approximately golden ratio to the 
maximum
>>  * integer representable by a machine word for multiplicative 
hashing.
>>  * Chuck Lever verified the effectiveness of this technique:
>>  * http://www.citi.umich.edu/techreports/reports/citi-tr-00-1.pdf
>>  *
>>  * These primes are chosen to be bit-sparse, that is operations on
>>  * them can use shifts and additions instead of multiplications for
>>  * machines where multiplications are slow.
>>  */
>>
>> It has been quite a while ago. I bet back then I did not regard this
>> as license information since it does not specify a license. Thus I
>> assumed it to be GPL-2 as the other files which have no license boiler
>> plate. I.e.: Check file is it has different license, if not, then
>> assume it has license as specified in COPYING.
>>
>> Not specifying a license can however also mean in this context that 
it
>> has no license as the file contains copyright information from another
>> author.
> 
> If a work (even one file) “has no license”, that means no special
> permissions are granted and normal copyright applies: All rights
> reserved, i.e. not redistributable. So, no license is grounds to
> consider a work non-free and non-redistributable.
> 
> If, on the other hand, the file is to be free software, there would 
need
> to be a clear grant of some free software license to that work.
> 
> Given the confusion over this file, I would consider it a significant
> risk to just assume we have GPLv2 permissions without being told that
> explicitly by the copyright holder. Rather, the reason we are seeking 
a
> clearly-granted free license for this one file, is because we are 
trying
> to replace a probably non-free file with the same code in it.
> 
> It seems we need to keep looking, and in the meantime assume we have 
no
> free license in this file.

FWIW, fio.c includes the following mention:

 * The license below covers all files distributed with fio unless 
otherwise
 * noted in the file itself.

followed by the GPL v2 license. I'll go through and add SPDX headers to
everything to avoid wasting anymore time on this nonsense.
 
-- 
Jens Axboe




