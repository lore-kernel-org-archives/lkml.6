Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB595C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 20:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E5CF21721
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 20:24:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="K8qwLPwT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbfBGUYV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 15:24:21 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37942 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbfBGUYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 15:24:20 -0500
Received: by mail-pg1-f195.google.com with SMTP id g189so450146pgc.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 12:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=xSDbE82RQuhxtIOqN+QQMMwheps2PFZF9+GFCiEfYm0=;
        b=K8qwLPwTfzQQVQR32xRkVo7RZG8QlfjEqdqZCWq9EI1tWwwOLvfwAiOGofDyQ20F2Z
         RiAAxRxbQ5/j/7xQEKyU7GSKfZ1cA3MQGZPTxwiE/GrPVnD+9i6trl+pd86/8Jaa1bsd
         XB9qpf9Y5fs9yFQx2ZG8I1cCi4DJXjv+cWBXxrreRqSW9bQFV1YJzCP79LrsKkX87e+w
         fqmxTs8Yv19cuCzuGWdUEKO2qwryaHIQ0b1sffDdMe2fQLVXrZPUWsfCvIIgoPnb2D0a
         Ut5wdsryhStftkoNV4buyvYH8VblVaNuN4QxiqEKfceWmyInBp+ksO4R5NyrW6T3H3Ty
         4gmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=xSDbE82RQuhxtIOqN+QQMMwheps2PFZF9+GFCiEfYm0=;
        b=Tslv0CVHOP6xlt0jGqyWuv4pAQcV9O+Zt7P4e7Enaecu7Sk1tuRTII7UOxZxa+dyO2
         c7QtqYy6Arlh693S0/dMdVqcvLeMYJTflbJVQIGCd/fkYX1WutPrHoHlpBMICrsqK8zt
         fM5sl2pUmFPE6wTsGUxKJhag2bV6McqA0DKWH0CXrZDDy3+vBqXgb3tkQRcN/IdTjP++
         WfbqPp3NHnay06Jaj6J51aT/zhbh6uEDsPXa3Xzs3dsaYTT18VCIUEegbQL8drFJ1oMJ
         V4dLl7uD5VXcIdif+hFEJrmfhSMoHocPSRbhKlkhH5hb1VW4HUpkMuZ1gk14lYMqoBBX
         WOcA==
X-Gm-Message-State: AHQUAuZtehbFt3NKTIu2UGxatguUnOfItF2QChqJ3Up6foUDAD967Jtc
        E7mDkW4ct5cABerT1s3ZiicfAw==
X-Google-Smtp-Source: AHgI3IZZuyXMz6ZjRvudA/tWG+CkO6REQSSQnoeXHKbnnwEL0CiLrHjfBkMBkjwsLOAQcPd06rSSig==
X-Received: by 2002:a62:dbc2:: with SMTP id f185mr17992381pfg.235.1549571060197;
        Thu, 07 Feb 2019 12:24:20 -0800 (PST)
Received: from ?IPv6:2601:646:c200:7429:802a:c653:76a4:cb6c? ([2601:646:c200:7429:802a:c653:76a4:cb6c])
        by smtp.gmail.com with ESMTPSA id 64sm13580437pff.101.2019.02.07.12.24.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 12:24:19 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [GIT PULL] x86/mm changes for v4.21
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16C101)
In-Reply-To: <20190207184606.GB17049@agluck-desk>
Date:   Thu, 7 Feb 2019 12:24:18 -0800
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rik van Riel <riel@surriel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <22E08A6D-5180-42F1-B94B-6B6DB832F953@amacapital.net>
References: <20181224231106.GA27438@gmail.com> <20190207001737.GA32096@agluck-desk> <20190207101846.GB32511@hirez.programming.kicks-ass.net> <CAHk-=whSRGDk9437PvMFEvDvc5hr73fXj+CvNHZu=vNE=GFDFg@mail.gmail.com> <20190207140131.GB32477@hirez.programming.kicks-ass.net> <20190207173600.GA15682@agluck-desk> <20190207175720.GE32511@hirez.programming.kicks-ass.net> <8D8DF81C-3331-4105-8594-9600281010EF@amacapital.net> <20190207184606.GB17049@agluck-desk>
To:     "Luck, Tony" <tony.luck@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 7, 2019, at 10:46 AM, Luck, Tony <tony.luck@intel.com> wrote:
>=20
>> On Thu, Feb 07, 2019 at 10:07:28AM -0800, Andy Lutomirski wrote:
>> Joining this thread late...
>>=20
>> This is all IMO rather crazy.  How about we fiddle with CR0 to turn off
>> the cache, then fiddle with page tables, then turn caching on?  Or, heck,=

>> see if there=E2=80=99s some chicken bit we can set to improve the situati=
on
>> while we=E2=80=99re in the MCE handler.
>=20
>> Also, since I don=E2=80=99t really want
>> to dig into the code to answer this, how exactly do we do a broadcast TLB=

>> flush from MCE context?  We=E2=80=99re super-duper-atomic, and locks migh=
t be
>> held on various CPUs.  Shouldn=E2=80=99t we be telling the cpa code to sk=
ip
>> the flush and then just have the MCE code do a full flush manually?
>> The MCE code has already taken over all CPUs on non-LMCE systems.
>=20
> MCE code doesn't do this while still in MCE context. You helped
> restructure this code so the recovery bits happen after we call
>=20
>    ist_begin_non_atomic(regs);
>=20
> on just the CPU that hit the error (in the broadcast case we've
> let the other out of MCE jail by this point).
>=20
> So there is a small window where we know the broken page is still
> mapped WB in the kernel 1:1 map. But we just live dangerously for
> a few more microseconds until we can fix the map.

Hmm.

How bad would it be to set CR0.CD while fiddling with the page tables rather=
 than masking the address?

>=20
>> Or, better yet, get Intel to fix the hardware. A failed speculative
>> access while already in MCE context should just be ignored.
>=20
> Good idea.
>=20
> -Tony
