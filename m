Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7389CC04EBA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 17:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39812214F1
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 17:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qv27V1nH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39812214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732305AbeKVELt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 23:11:49 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:32811 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730480AbeKVELt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 23:11:49 -0500
Received: by mail-pl1-f196.google.com with SMTP id z23so6489897plo.0;
        Wed, 21 Nov 2018 09:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=IaBTxksEkaU0YRi0Qg1Tj0SlP1yQnbMietLP1eUgU58=;
        b=qv27V1nHJ8pj5Fp3OI5Ny4Bmd8Rq7yWTlaJD2C4PDCjZJRGhpUxnOgwxQl8y29ugnR
         MK0a2f9m09jsCk61dpPqpDC02t4BLzN/xfkfONTspZltlgjK11xXTG0VVZ0Ldyf46B42
         CZk60zO4fXa8JM9xMiQ2HB0QZuTFeaOL55WRWY8TkgKDR+5XcTo5L+y1zeSkefs+huYa
         Gm9mZERU24tcD4o/zXUkY5byDjrLnl0KOp4hSqmfsRQGV7umG7qWFQsL5cEompOodn+c
         fLxnvpVlKeAulPN9LzUTZ6EvNiK/TWkNNk9qYbP8DcAN1da6mbgx+vnAF9N+hwN61NFB
         kZRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=IaBTxksEkaU0YRi0Qg1Tj0SlP1yQnbMietLP1eUgU58=;
        b=nwMkgtrfiWk8VyUh8o1nd/WeqJSlXKEcGxQj6ctMizR4rorJtmn2qw81MCXZypRnpJ
         uSe9rb+tSfARgH8Gu3MP2Bb3Gc01sgyFVHelgb9D62PH/g/otRJj5msjEkCm19ZUS+xc
         Rn/q40dENCpDRGQhelauAlcOBcwlj0ISMstdRiQe8+hh1OvXcxdVunDzfi2Fy/cqpY9H
         Cd7m2+LDdEM3MhGqrLOYZBDZMW/im0H9uHm5DpOEsspiUHiZl6YtRSv6hWYRzB6qRv/U
         xbDjUVgKfPPkmOe8drPdrx6ricy0rU5UYazt1YtGRURkFxEocAVcCsiJyuX8zyDgYF+0
         tXXg==
X-Gm-Message-State: AGRZ1gKBb8CICuNbfMmjMiGJgBHk3sMqNWUUoXcEuy6q0dpqBEpuauKi
        bRMAmSvrAV0xw+yR0TBSy7U=
X-Google-Smtp-Source: AJdET5dgOWpCmXJXljr59N32j12oi862zcwTFK/P13CLIP3miMFt9Y+xITRgXAKO9IsbQXhRxa/jxQ==
X-Received: by 2002:a62:37c7:: with SMTP id e190-v6mr7612388pfa.145.1542821789785;
        Wed, 21 Nov 2018 09:36:29 -0800 (PST)
Received: from [10.33.114.204] ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id l63-v6sm49264741pfb.75.2018.11.21.09.36.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 09:36:29 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.1 \(3445.101.1\))
Subject: Re: [PATCH 10/17] prmem: documentation
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <1166e55c-0c06-195c-a501-383b4055ea46@gmail.com>
Date:   Wed, 21 Nov 2018 09:36:27 -0800
Cc:     Andy Lutomirski <luto@kernel.org>,
        Igor Stoppa <igor.stoppa@huawei.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        James Morris <jmorris@namei.org>,
        Michal Hocko <mhocko@kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Laura Abbott <labbott@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <03E199F6-FD90-4B88-838E-C3702F982F78@gmail.com>
References: <20181023213504.28905-1-igor.stoppa@huawei.com>
 <20181023213504.28905-11-igor.stoppa@huawei.com>
 <20181026092609.GB3159@worktop.c.hoisthospitality.com>
 <CAGXu5jKCs01jvtvpEFS7R8qCR-5iRqK11kJxLJY99NicGWc4aQ@mail.gmail.com>
 <20181028183126.GB744@hirez.programming.kicks-ass.net>
 <40cd77ce-f234-3213-f3cb-0c3137c5e201@gmail.com>
 <20181030152641.GE8177@hirez.programming.kicks-ass.net>
 <CAGXu5jJftJ+Hq+jrZGHX5CTDLWOog7kGsd_Ne=yMvrRs__skSg@mail.gmail.com>
 <0A7AFB50-9ADE-4E12-B541-EC7839223B65@amacapital.net>
 <6f60afc9-0fed-7f95-a11a-9a2eef33094c@gmail.com>
 <CALCETrXNckT9W288VXx-6inO5qYn-6dUPocKGcBT0GCO3xi3ZQ@mail.gmail.com>
 <386C0CB1-C4B1-43E2-A754-DA8DBE4FB3CB@gmail.com>
 <CALCETrWWcfLK4W3mn0bavzejmMBVKMX29aAUA3+VPQ8m9vmfhw@mail.gmail.com>
 <9373ccf0-f51b-4bfa-2b16-e03ebf3c670d@huawei.com>
 <2e52e103-15d0-0c26-275f-894dfd07e8ec@huawei.com>
 <CALCETrV0sPgf4ZgG1joF_5hM-ycPsWM9DWGO=diQ_LQKin4VuA@mail.gmail.com>
 <1166e55c-0c06-195c-a501-383b4055ea46@gmail.com>
To:     Igor Stoppa <igor.stoppa@gmail.com>
X-Mailer: Apple Mail (2.3445.101.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Nov 21, 2018, at 8:34 AM, Igor Stoppa <igor.stoppa@gmail.com> =
wrote:
>=20
> Hi,
>=20
> On 13/11/2018 20:36, Andy Lutomirski wrote:
>> On Tue, Nov 13, 2018 at 10:33 AM Igor Stoppa <igor.stoppa@huawei.com> =
wrote:
>>> I forgot one sentence :-(
>>>=20
>>> On 13/11/2018 20:31, Igor Stoppa wrote:
>>>> On 13/11/2018 19:47, Andy Lutomirski wrote:
>>>>=20
>>>>> For general rare-writish stuff, I don't think we want IRQs running
>>>>> with them mapped anywhere for write.  For AVC and IMA, I'm less =
sure.
>>>>=20
>>>> Why would these be less sensitive?
>>>>=20
>>>> But I see a big difference between my initial implementation and =
this one.
>>>>=20
>>>> In my case, by using a shared mapping, visible to all cores, =
freezing
>>>> the core that is performing the write would have exposed the =
writable
>>>> mapping to a potential attack run from another core.
>>>>=20
>>>> If the mapping is private to the core performing the write, even if =
it
>>>> is frozen, it's much harder to figure out what it had mapped and =
where,
>>>> from another core.
>>>>=20
>>>> To access that mapping, the attack should be performed from the =
ISR, I
>>>> think.
>>>=20
>>> Unless the secondary mapping is also available to other cores, =
through
>>> the shared mm_struct ?
>> I don't think this matters much.  The other cores will only be able =
to
>> use that mapping when they're doing a rare write.
>=20
>=20
> I'm still mulling over this.
> There might be other reasons for replicating the mm_struct.
>=20
> If I understand correctly how the text patching works, it happens =
sequentially, because of the text_mutex used by =
arch_jump_label_transform
>=20
> Which might be fine for this specific case, but I think I shouldn't =
introduce a global mutex, when it comes to data.
> Most likely, if two or more cores want to perform a write rare =
operation, there is no correlation between them, they could proceed in =
parallel. And if there really is, then the user of the API should =
introduce own locking, for that specific case.

I think that if you create per-CPU temporary mms as you proposed, you do =
not
need a global lock. You would need to protect against module unloading, =
and
maybe refactor the code. Specifically, I=E2=80=99m not sure whether =
protection
against IRQs is something that you need. I=E2=80=99m also not familiar =
with this
patch-set so I=E2=80=99m not sure what atomicity guarantees do you need.

> A bit unrelated question, related to text patching: I see that each =
patching operation is validated, but wouldn't it be more robust to first =
validate  all of then, and only after they are all found to be =
compliant, to proceed with the actual modifications?
>=20
> And about the actual implementation of the write rare for the =
statically allocated variables, is it expected that I use Nadav's =
function?

It=E2=80=99s not =E2=80=9Cmy=E2=80=9D function. ;-)

IMHO the code is in relatively good and stable state. The last couple of
versions were due to me being afraid to add BUG_ONs as Peter asked me =
to.

The code is rather simple, but there are a couple of pitfalls that =
hopefully
I avoided correctly.

Regards,
Nadav=
