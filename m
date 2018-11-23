Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MIME_QP_LONG_LINE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD0DDC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 19:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81B3D20865
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 19:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="lI6qGoL9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81B3D20865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441311AbeKXF45 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 00:56:57 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:51101 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437213AbeKXF44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 00:56:56 -0500
Received: by mail-it1-f194.google.com with SMTP id z7so2155445iti.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 11:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=jnd2/Z9l7JPVuov0yRMK35sC+paAzZ2dIu4sX4K3+1I=;
        b=lI6qGoL9+kwQflprcXIwqWtBBuH7vrEI0FLtwK0wV+PNUM+98qfr7LVkkqvMr6ZLyY
         AHe2tseFdhz2OF7PH8MDe1SXDo2L/WPEJ40iJ5/5ULlxTvzRqnfgcshDxZALSEkcBERT
         MEsktkEuqfGgi6LZe6Bn9apofg4WUKxvxjP7yIswHfNi5LRF8Z1YQCX69lziEQI7xdOP
         b6FevqkNFUxlaJwSrU/oBuj7fHFgKIAr8kc/iCVmng0XiFf0mOfU6CL8D5p5ifYyza+j
         UBWXBsq+nSU8ddFBOZyCJio9JImfDJ/Ew2CWPH/1RlqSHw5964f19JDOvaQhRaCVpK+t
         YudA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=jnd2/Z9l7JPVuov0yRMK35sC+paAzZ2dIu4sX4K3+1I=;
        b=DJIHSiHmbLB7wZ9N4fHVwypaTomEezIw1/Qo7lInOJ+DCJoIbC3LNKeVJ0Wc7k2A+o
         14ks5BAEpFu7cNkCMv93VXfH8CsGS7/h+lUXWXo6AoSL6bBHX/vn5HKlQe3BFH+1CWeJ
         ZP15LPElG/6T1NJ7cUWtDBnpxmI6XoZvPSCUBJKiGaEoBektk1uUg8q4b247WHRcY1wF
         D36WGMoTWpVtYcDkijjJJ8p5naAiWpozqH2az7EGZjn0qmDBTciV1Qkae/30JgvpyVtW
         jlMJLR51f2WEO742hktv1PtxAoIox8sbLXLjB3PRHNsCls2ai9+WdaUus03t3YRn3yHB
         BBpA==
X-Gm-Message-State: AGRZ1gLVPNCiW3RqSbC405fbDFAgqmF/IlvSVcWojc8x7j9xEQZKbSBV
        +BX+K6HA3uxDCH5MC/6b5Rav0w==
X-Google-Smtp-Source: AFSGD/Uv1FY8S5iTSsF43963O7CIEj0hCucoKDgwcxiQAI4rxXVT+Jo9yqUNtmsgBlyegG/8jDSKnA==
X-Received: by 2002:a24:4648:: with SMTP id j69mr14453715itb.56.1543000282097;
        Fri, 23 Nov 2018 11:11:22 -0800 (PST)
Received: from ?IPv6:2600:100e:b01e:7457:896a:cc79:a4ed:4140? ([2600:100e:b01e:7457:896a:cc79:a4ed:4140])
        by smtp.gmail.com with ESMTPSA id d12sm10672700ioh.44.2018.11.23.11.11.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 11:11:21 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] x86: only use ERMS for user copies for larger sizes
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16A404)
In-Reply-To: <CAHk-=wgpmV2B=s2xE5385Jzy2tEZuiW+MSPveJBfpqUoFdGydg@mail.gmail.com>
Date:   Fri, 23 Nov 2018 12:11:19 -0700
Cc:     David.Laight@aculab.com, Andrew Lutomirski <luto@kernel.org>,
        dvlasenk@redhat.com, Jens Axboe <axboe@kernel.dk>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, bp@alien8.de,
        Peter Anvin <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>, brgerst@gmail.com,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        pabeni@redhat.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <0D9E579C-F980-4BB7-A282-42206F6636F3@amacapital.net>
References: <02bfc577-32a5-66be-64bf-d476b7d447d2@kernel.dk> <20181121063609.GA109082@gmail.com> <48e27a3a-2bb2-ff41-3512-8aeb3fd59e57@kernel.dk> <26eff539-7de7-784c-0c88-f1d30753299d@redhat.com> <7ea44458b90b4d41a08ba9012818d273@AcuMS.aculab.com> <CAHk-=wjLNuNpHRfuVTb6awstC9OOmSb3S8aP51ufep-Th4dXKw@mail.gmail.com> <CALCETrW=hMZLUM_nPEEgUW9x9Bmhm2LZ6ZRDiRRguxVT=-_BWA@mail.gmail.com> <CAHk-=wiEUVpSU-GxpKDvN9wnH2yDxkJgE7Vqh46A+fmnvhubyw@mail.gmail.com> <cd11d9423c8b46ecbf97753f8317c294@AcuMS.aculab.com> <64fd67993af04579b5262c270a7a4694@AcuMS.aculab.com> <CAHk-=wj9DA-mH8jahuEPUWxO4EgbCcPRgdOJAQD58DBtCCrHcQ@mail.gmail.com> <CAHk-=wjrdrZW5VgnKXqdayafYmQC2HBEA4kzMWYTyaj5jgURdA@mail.gmail.com> <C74CD745-0E6D-410C-B942-416AF365B492@amacapital.net> <CAHk-=wgpmV2B=s2xE5385Jzy2tEZuiW+MSPveJBfpqUoFdGydg@mail.gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 23, 2018, at 11:44 AM, Linus Torvalds <torvalds@linux-foundation.or=
g> wrote:
>=20
>> On Fri, Nov 23, 2018 at 10:39 AM Andy Lutomirski <luto@amacapital.net> wr=
ote:
>>=20
>> What is memcpy_to_io even supposed to do?  I=E2=80=99m guessing it=E2=80=99=
s defined as something like =E2=80=9Ccopy this data to IO space using at mos=
t long-sized writes, all aligned, and writing each byte exactly once, in ord=
er.=E2=80=9D  That sounds... dubiously useful.
>=20
> We've got hundreds of users of it, so it's fairly common..
>=20

I=E2=80=99m wondering if the =E2=80=9Cat most long-sizes=E2=80=9D restrictio=
n matters, especially given that we=E2=80=99re apparently accessing some of t=
he same bytes more than once. I would believe that trying to encourage 16-by=
te writes (with AVX, ugh) or 64-byte writes (with MOVDIR64B) would be safe a=
nd could meaningfully speed up some workloads.

>> I could see a function that writes to aligned memory in specified-sized c=
hunks.
>=20
> We have that. It's called "__iowrite{32,64}_copy()". It has very few users=
.
>=20
>                  Linus
