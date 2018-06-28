Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDBC5C43145
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 15:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B34827638
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 15:47:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B34827638
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hxt-semitech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030230AbeF1Prg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 11:47:36 -0400
Received: from mx01.hxt-semitech.com.96.203.223.in-addr.arpa ([223.203.96.7]:34790
        "EHLO barracuda.hxt-semitech.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S966965AbeF1Pp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 11:45:28 -0400
X-ASG-Debug-ID: 1530200670-093b7e43b2a9fe0001-xx1T2L
Received: from HXTBJIDCEMVIW01.hxtcorp.net (localhost [10.128.0.14]) by barracuda.hxt-semitech.com with ESMTP id bCfyYoARDnZtbTms (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NO); Thu, 28 Jun 2018 23:44:30 +0800 (CST)
X-Barracuda-Envelope-From: shunyong.yang@hxt-semitech.com
Received: from HXTBJIDCEMVIW01.hxtcorp.net (10.128.0.14) by
 HXTBJIDCEMVIW01.hxtcorp.net (10.128.0.14) with Microsoft SMTP Server (TLS) id
 15.0.847.32; Thu, 28 Jun 2018 23:44:33 +0800
Received: from HXTBJIDCEMVIW01.hxtcorp.net ([fe80::f451:a443:c0b5:87d1]) by
 HXTBJIDCEMVIW01.hxtcorp.net ([fe80::f451:a443:c0b5:87d1%12]) with mapi id
 15.00.0847.030; Thu, 28 Jun 2018 23:44:33 +0800
From:   "Yang, Shunyong" <shunyong.yang@hxt-semitech.com>
To:     Andrew Jones <drjones@redhat.com>
CC:     Sudeep Holla <sudeep.holla@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Zheng, Joey" <yu.zheng@hxt-semitech.com>
Subject: Re: [RFC PATCH] arm64: topology: Map PPTT node offset to logic
 physical package id
Thread-Topic: [RFC PATCH] arm64: topology: Map PPTT node offset to logic
 physical package id
X-ASG-Orig-Subj: Re: [RFC PATCH] arm64: topology: Map PPTT node offset to logic
 physical package id
Thread-Index: AQHUDsGU1koi4KlNakibmAYxryVeeqR04+QAgAAm8wCAAAQNAIAAEsIAgAAN8ICAAAvDgIAAlPT9
Date:   Thu, 28 Jun 2018 15:44:32 +0000
Message-ID: <C872769E-A591-4569-9AB9-3EB602D9DCDB@hxt-semitech.com>
References: <1530177508-15298-1-git-send-email-shunyong.yang@hxt-semitech.com>
 <cb057c6a-0eb4-581e-c259-7a31545e0ae7@arm.com>
 <20180628115748.kprobde6c3joc6ll@kamzik.brq.redhat.com>
 <f9376e47-e2ae-b2f4-db23-07698364f1bb@arm.com>
 <b9b537e7-8f7b-07cc-a99d-bcaa8f5d60d5@arm.com>
 <e5b44e41-6d5b-2587-2628-3bcfbee4e00b@arm.com>,<20180628145125.2psdmymtuueiv4xn@kamzik.brq.redhat.com>
In-Reply-To: <20180628145125.2psdmymtuueiv4xn@kamzik.brq.redhat.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Barracuda-Connect: localhost[10.128.0.14]
X-Barracuda-Start-Time: 1530200670
X-Barracuda-Encrypted: ECDHE-RSA-AES256-SHA
X-Barracuda-URL: https://192.168.50.101:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at hxt-semitech.com
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.7616 1.0000 1.8731
X-Barracuda-Spam-Score: 1.87
X-Barracuda-Spam-Status: No, SCORE=1.87 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.52522
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, All

> On Jun 28, 2018, at 22:51, Andrew Jones <drjones@redhat.com> wrote:
> 
>> On Thu, Jun 28, 2018 at 03:09:19PM +0100, Sudeep Holla wrote:
>> 
>> 
>>> On 28/06/18 14:19, Jeremy Linton wrote:
>>> Hi,
>>> 
>>> On 06/28/2018 07:12 AM, Sudeep Holla wrote:
>> 
>> [...]
>> 
>>>> 
>>>> OK sure. I liked the approach in Shunyong's patch. I was thinking if we
>>>> can avoid the list and dynamic allocation on each addition and make it
>>>> more simpler.
>>>> 
>>> 
>>> This one reads simpler, but yes I agree we should try to avoid the
>>> dynamic allocation.
>>> 
>>> OTOH, I think that dropping the dynamic allocation leads to an algorithm
>>> that picks a value and replaces all the matches. Which of course is
>>> Andrew's patch, although I did have to read it a couple times to get a
>>> grasp how it works. I'm guessing that is due to the fact that he seems
>>> to have optimized 3 double loops into a single loop with two individual
>>> nested loops. AKA its probably more efficient than the naive
>>> implementation, but readability seems to have suffered a bit in the
>>> initial version he posted. I'm not sure the optimization is worth it,
>>> but I'm guessing there is a middle ground which makes it more readable.
>>> 
>> 
>> Completely agree. RFC from Andrew is not so readable and easy to understand.
> 
> Middle ground coming up. At the expense of a triple-nested loop (which
> will never be N^3 iterations due to conditions at the start of each loop),
> we can avoid dynamic allocations and list iterations and still gain
> readability.
> 
> Thanks,
> drew

I have a new approach. As we've already got the offset of the node with physical package bit set, which is the parent of the cpu we are querying. We can iterate from the begining of PPTT to count the nodes with physical package bit set till we reach the offset we've got. Then, the count value is the package id. This avoid list and dynamic allocation. And PPTT provides length for each node, iteration should be easy.
I think this may implemented in pptt.c. 
I am writing this mail on my phone. Maybe I should try to write a patch to test in office tomorrow if you think it's feasible.

Thanks.
Shunyong.



