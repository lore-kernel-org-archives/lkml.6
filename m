Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FEAFC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 17:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D2C92086A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 17:34:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="cBxITDHj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D2C92086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728696AbeIJW3a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 18:29:30 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:5110 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbeIJW33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 18:29:29 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5b96ab0f0000>; Mon, 10 Sep 2018 10:34:08 -0700
Received: from HQMAIL107.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 10 Sep 2018 10:34:20 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 10 Sep 2018 10:34:20 -0700
Received: from [10.2.168.25] (10.2.168.25) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 10 Sep
 2018 17:34:19 +0000
Subject: Re: Plumbers 2018 - Performance and Scalability Microconference
To:     Waiman Long <longman@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Aaron Lu <aaron.lu@intel.com>, <alex.kogan@oracle.com>,
        <akpm@linux-foundation.org>, <boqun.feng@gmail.com>,
        <brouer@redhat.com>, <dave.dice@oracle.com>,
        Dhaval Giani <dhaval.giani@oracle.com>, <ktkhai@virtuozzo.com>,
        <ldufour@linux.vnet.ibm.com>, <Pavel.Tatashin@microsoft.com>,
        <paulmck@linux.vnet.ibm.com>, <shady.issa@oracle.com>,
        <tariqt@mellanox.com>, <tglx@linutronix.de>,
        <tim.c.chen@intel.com>, <vbabka@suse.cz>,
        <yang.shi@linux.alibaba.com>, <shy828301@gmail.com>,
        Huang Ying <ying.huang@intel.com>,
        <subhra.mazumdar@oracle.com>,
        Steven Sistare <steven.sistare@oracle.com>,
        <jwadams@google.com>, <ashwinch@google.com>, <sqazi@google.com>,
        Shakeel Butt <shakeelb@google.com>, <walken@google.com>,
        <rientjes@google.com>, <junaids@google.com>,
        Neha Agarwal <nehaagarwal@google.com>
References: <1dc80ff6-f53f-ae89-be29-3408bf7d69cc@oracle.com>
 <35c2c79f-efbe-f6b2-43a6-52da82145638@nvidia.com>
 <55b44432-ade5-f090-bfe7-ea20f3e87285@redhat.com>
 <20180910172011.GB3902@linux-r8p5>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <78fa0507-4789-415b-5b9c-18e3fcefebab@nvidia.com>
Date:   Mon, 10 Sep 2018 10:34:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180910172011.GB3902@linux-r8p5>
X-Originating-IP: [10.2.168.25]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US-large
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1536600848; bh=913e9w6+MwrfP7pSfhrCpUf57Z9sVA5EQ8ZeeFqf+vA=;
        h=X-PGP-Universal:Subject:To:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=cBxITDHjxkYJaMYv6jdBDEHKO9IoUC5B6TOep55hQZGoDd5ee1dM1vFtQsh9xuP9D
         fTA8FRZXuq8s/MJ2z71BRea3owuNs2NLNAVE1FFZLSLaonLvI974qaVVw1O88y8jC3
         m/ajkM75y/ZOE8yoPv8a0d7ls58MxsPskggmJzXSRlzsB/9x9CP70chahJUpL/jzA8
         lbHBHFUWh9+ao7dB2AAPbns8RsOkM5e4u5tLD8gOm1Vl71+XMHUdXe/4gLQohD8+hD
         GFvwnCC+iIoaxWa+AGkU860kkIwsPeH4GRxtkqnBYdkvg+d+Uj0mfNx5GD083eedUA
         THm7a7e5n/eCQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/10/18 10:20 AM, Davidlohr Bueso wrote:
> On Mon, 10 Sep 2018, Waiman Long wrote:
>> On 09/08/2018 12:13 AM, John Hubbard wrote:
[...]
>>> It's also interesting that there are two main huge page systems (THP an=
d Hugetlbfs), and I sometimes
>>> wonder the obvious thing to wonder: are these sufficiently different to=
 warrant remaining separate,
>>> long-term?=C2=A0 Yes, I realize they're quite different in some ways, b=
ut still, one wonders. :)
>>
>> One major difference between hugetlbfs and THP is that the former has to
>> be explicitly managed by the applications that use it whereas the latter
>> is done automatically without the applications being aware that THP is
>> being used at all. Performance wise, THP may or may not increase
>> application performance depending on the exact memory access pattern,
>> though the chance is usually higher that an application will benefit
>> than suffer from it.
>>
>> If an application know what it is doing, using hughtblfs can boost
>> performance more than it can ever achieved by THP. Many large enterprise
>> applications, like Oracle DB, are using hugetlbfs and explicitly disable
>> THP. So unless THP can improve its performance to a level that is
>> comparable to hugetlbfs, I won't see the later going away.
>=20
> Yep, there are a few non-trivial workloads out there that flat out discou=
rage
> thp, ie: redis to avoid latency issues.
>=20

Yes, the need for guaranteed, available-now huge pages in some cases is=20
understood. That's not the quite same as saying that there have to be two d=
ifferent
subsystems, though. Nor does it even necessarily imply that the pool has to=
 be
reserved in the same way as hugetlbfs does it...exactly.

So I'm wondering if THP behavior can be made to mimic hugetlbfs enough (per=
haps
another option, in addition to "always, never, madvise") that we could just=
 use
THP in all cases. But the "transparent" could become a sliding scale that c=
ould
go all the way down to "opaque" (hugetlbfs behavior).


thanks,
--=20
John Hubbard
NVIDIA
