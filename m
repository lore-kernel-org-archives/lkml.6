Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62984C4321E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 04:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05A672075A
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 04:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="QRj0ysrg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05A672075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbeIHI5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 04:57:22 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:14883 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbeIHI5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 04:57:22 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5b934c430000>; Fri, 07 Sep 2018 21:12:53 -0700
Received: from HQMAIL105.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 07 Sep 2018 21:13:05 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 07 Sep 2018 21:13:05 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Sat, 8 Sep
 2018 04:13:03 +0000
Received: from [10.110.48.28] (10.110.48.28) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Sat, 8 Sep 2018
 04:13:02 +0000
Subject: Re: Plumbers 2018 - Performance and Scalability Microconference
To:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
CC:     Aaron Lu <aaron.lu@intel.com>, <alex.kogan@oracle.com>,
        <akpm@linux-foundation.org>, <boqun.feng@gmail.com>,
        <brouer@redhat.com>, <dave@stgolabs.net>, <dave.dice@oracle.com>,
        Dhaval Giani <dhaval.giani@oracle.com>, <ktkhai@virtuozzo.com>,
        <ldufour@linux.vnet.ibm.com>, <Pavel.Tatashin@microsoft.com>,
        <paulmck@linux.vnet.ibm.com>, <shady.issa@oracle.com>,
        <tariqt@mellanox.com>, <tglx@linutronix.de>,
        <tim.c.chen@intel.com>, <vbabka@suse.cz>, <longman@redhat.com>,
        <yang.shi@linux.alibaba.com>, <shy828301@gmail.com>,
        Huang Ying <ying.huang@intel.com>,
        <subhra.mazumdar@oracle.com>,
        "Steven Sistare" <steven.sistare@oracle.com>, <jwadams@google.com>,
        <ashwinch@google.com>, <sqazi@google.com>,
        Shakeel Butt <shakeelb@google.com>, <walken@google.com>,
        <rientjes@google.com>, <junaids@google.com>,
        Neha Agarwal <nehaagarwal@google.com>
References: <1dc80ff6-f53f-ae89-be29-3408bf7d69cc@oracle.com>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <35c2c79f-efbe-f6b2-43a6-52da82145638@nvidia.com>
Date:   Fri, 7 Sep 2018 21:13:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <1dc80ff6-f53f-ae89-be29-3408bf7d69cc@oracle.com>
X-Originating-IP: [10.110.48.28]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US-large
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1536379973; bh=lH2zyiKvuhMiFdmRZqOjIYRa74EllMfamTb07ue177w=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=QRj0ysrgFlgGIDmHLokWaPtvxiZbht4ptiIw/HxI6FxC47K0vzg2aKwMjOGcmoyRg
         BLrOREpg47JLqEtS4PVu+AK/NKbHWylJ8w1Lyifk3KU3f6ZIHKMvEiV2UQZXys/EvY
         P3OAFTD93D2W7xTB5KJrPJYQXsROadJEs7fk/4W6WM5gEin5fYlzEo27XTjhGmy603
         A/dKv1Q7o0EwNc7ZoLNvRGQWdRJsGFJ0SGHNPGwLBL6sRqwZi0gyB67/uX14N4QEMD
         cUF7QzlTBL18Rby4oItsDcL7JBEBmOXLuNTzbtg9bzhZ0Vc4U2iwoX3wtKh7DT1jep
         AW1oMGIHHWAnA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/4/18 2:28 PM, Daniel Jordan wrote:
> Pavel Tatashin, Ying Huang, and I are excited to be organizing a performa=
nce and scalability microconference this year at Plumbers[*], which is happ=
ening in Vancouver this year.=C2=A0 The microconference is scheduled for th=
e morning of the second day (Wed, Nov 14).
>=20
> We have a preliminary agenda and a list of confirmed and interested atten=
dees (cc'ed), and are seeking more of both!
>=20
> Some of the items on the agenda as it stands now are:
>=20
> =C2=A0- Promoting huge page usage:=C2=A0 With memory sizes becoming ever =
larger, huge pages are becoming more and more important to reduce TLB misse=
s and the overhead of memory management itself--that is, to make the system=
 scalable with the memory size.=C2=A0 But there are still some remaining ga=
ps that prevent huge pages from being deployed in some situations, such as =
huge page allocation latency and memory fragmentation.
>=20
> =C2=A0- Reducing the number of users of mmap_sem:=C2=A0 This semaphore is=
 frequently used throughout the kernel.=C2=A0 In order to facilitate scalin=
g this longstanding bottleneck, these uses should be documented and unneces=
sary users should be fixed.
>=20
> =C2=A0- Parallelizing cpu-intensive kernel work:=C2=A0 Resolve problems o=
f past approaches including extra threads interfering with other processes,=
 playing well with power management, and proper cgroup accounting for the e=
xtra threads.=C2=A0 Bonus topic: proper accounting of workqueue threads run=
ning on behalf of cgroups.
>=20
> =C2=A0- Preserving userland during kexec with a hibernation-like mechanis=
m.
>=20
> These center around our interests, but having lots of topics to choose fr=
om ensures we cover what's most important to the community, so we would lik=
e to hear about additional topics and extensions to those listed here.=C2=
=A0 This includes, but is certainly not limited to, work in progress that w=
ould benefit from in-person discussion, real-world performance problems, an=
d experimental and academic work.
>=20
> If you haven't already done so, please let us know if you are interested =
in attending, or have suggestions for other attendees.

Hi Daniel and all,

I'm interested in the first 3 of those 4 topics, so if it doesn't conflict =
with HMM topics or
fix-gup-with-dma topics, I'd like to attend. GPUs generally need to access =
large chunks of
memory, and that includes migrating (dma-copying) pages around. =20

So for example a multi-threaded migration of huge pages between normal RAM =
and GPU memory is an=20
intriguing direction (and I realize that it's a well-known topic, already).=
 Doing that properly
(how many threads to use?) seems like it requires scheduler interaction.

It's also interesting that there are two main huge page systems (THP and Hu=
getlbfs), and I sometimes
wonder the obvious thing to wonder: are these sufficiently different to war=
rant remaining separate,
long-term?  Yes, I realize they're quite different in some ways, but still,=
 one wonders. :)


thanks,
--=20
John Hubbard
NVIDIA
