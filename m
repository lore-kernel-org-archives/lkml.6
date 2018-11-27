Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2724C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 17:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB19C20817
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 17:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="gxl/9Gfo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB19C20817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730577AbeK1EE4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 23:04:56 -0500
Received: from smtprelay4.synopsys.com ([198.182.47.9]:47036 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbeK1EEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 23:04:55 -0500
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id D539024E07F3;
        Tue, 27 Nov 2018 09:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1543338371; bh=c67KAe9hAUBgHJB89mR4wt1Ya0rCHH4epWI2vEHz+nY=;
        h=From:To:CC:Subject:Date:References:From;
        b=gxl/9GfofjenqqexWsj5Ir+9PRurA+CrAzgQZVepvyzoo8OOnkG5c+L+cK/V+7hYO
         qKc9tugV7AAO8ASLF2T81dDTCaWXmwc3EulN/bFV8oe2jVtvG7S6xwzMZCK13omT3X
         /4kzx2KDa5UzX/7HkL8uZqNfSoXWfvyT6RHnLgV6fkQ5VENsu8I7xPHSEJsCSb2yYg
         XYRtSkDPglkADEKBt4WhxnNIzTqwHgyAYmaMvXHQEY8YnOfBa8EhNVGyC8O1yWAi8e
         wFMWfxqnayQsJO0SdyHQMloZLKpSniC/HbtG7ZE4hxIogJ8IoAYfT+DuPV8KDlKYe0
         HS9a59eQqfgMA==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2-vip.internal.synopsys.com [10.12.239.238])
        by mailhost.synopsys.com (Postfix) with ESMTP id 78E7A5392;
        Tue, 27 Nov 2018 09:06:10 -0800 (PST)
Received: from US01WEMBX2.internal.synopsys.com ([fe80::e4b6:5520:9c0d:250b])
 by US01WEHTC2.internal.synopsys.com ([10.12.239.237]) with mapi id
 14.03.0415.000; Tue, 27 Nov 2018 09:06:10 -0800
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
To:     Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>
Subject: Re: 'branches' perf event mapping differs on ARC and ARM
Thread-Topic: 'branches' perf event mapping differs on ARC and ARM
Thread-Index: AQHUhl6UMI9IICATOUqAlhDukujZmA==
Date:   Tue, 27 Nov 2018 17:06:10 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA2307501464172A6@US01WEMBX2.internal.synopsys.com>
References: <1543329386.13651.13.camel@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.144.199.106]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/18 6:36 AM, Eugeniy Paltsev wrote:=0A=
> Hi,=0A=
>=0A=
> While playing with perf tool on ARMv7 and ARCv2 processors and profiling =
the=0A=
> same application I got interesting results. Even if we got pretty=0A=
> similar total=0A=
> execution time and instructions number the number of branches on ARC is a=
bout=0A=
> three times more then on ARM.=0A=
>=0A=
> I dug into architecture=0A=
> specific perf sources and found that we map different=0A=
> HW counters into generic 'branches' event on ARC and ARM.=0A=
> - We use "ijmp" event on ARC which=0A=
> counts all jump and branch instructions (regardless=0A=
> of real execution flow - even if no real jump happens)=0A=
=0A=
That doesn't seem correct IMO. A NOT taken conditional branch doesn't chang=
e=0A=
control flow, so semantically doesn't qualify as a branch.=0A=
On ARC, the generic branches event should be mapped to "actually taken bran=
ches"=0A=
condition i.e.  ijmptak=0A=
=0A=
=0A=
> - We use "pc_write_retired" event on ARM=0A=
> which counts only taken branches (Instruction=0A=
> architecturally executed, condition check pass - software change of the P=
C)=0A=
=0A=
That seems correct.=0A=
=0A=
> I guess counting all jump and branch instructions is correct because we u=
se=0A=
> 'branches' event value to calculate relative value of 'branch-misses' usi=
ng=0A=
>=0A=
> following formula:=0A=
> ----------------------------8----------------------------=0A=
> branch-misses-ration =3D 'branch-misses' / 'branches' * 100.0=0A=
> ----------------=0A=
> ------------8----------------------------=0A=
> And using only taken branches here is incorrect IMHO.=0A=
=0A=
Why ? branch-misses is a CPU specific micro-arch state where the a changed =
control=0A=
flow was NOT predicted. If an implementation mispredicts NOT taken branches=
, those=0A=
should actually get counted and be fed to hardware folks to improve the mic=
ro-arch.=0A=
=0A=
=0A=
>  So I guess we should=0A=
> map 'br_immed_retired' instead of=0A=
> "pc_write_retired" into generic 'branches'=0A=
> event on ARM.=0A=
=0A=
