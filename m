Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F394FC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 16:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B77332082E
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 16:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AATcQtgw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B77332082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729164AbeKBBfu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 21:35:50 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34468 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728372AbeKBBfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 21:35:50 -0400
Received: by mail-pf1-f195.google.com with SMTP id f78-v6so9598297pfe.1;
        Thu, 01 Nov 2018 09:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=nX6+O2gcmN+wf5wYI35jSqSfPHK0o+mAaMNAqvcu52I=;
        b=AATcQtgw4OgBirkGwvnev1NHDLu20mOrNOBTk3mtc8rtBaSE7Rb1gc9g+oGWLVauTy
         bC5LUZf64mIdb5FT1gqpKHTxXhQeTaaGUOmhyGfJzfWQ9nOMLPfSQgWKQ5chJEls2bNz
         x6cTy4F0mA4fiKKhEFX16FkS/1U7a+pZPPfCD6pk0h+VxN0Uv+L2a015nfDLvpUJlTRO
         pbVyzv/j4vNsdLtGTsq9DtZJ/IQN5ub2PnGDUqhO4NxSYNoA8kvkcPiJ3/Mf6e+zdUEw
         VoHNbDZbexpieUNxDjQrya2xUCNW4zhk5nbE3zqXsoMnz/PQ14UmKipJQGaHrzIMFAFp
         6Clg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=nX6+O2gcmN+wf5wYI35jSqSfPHK0o+mAaMNAqvcu52I=;
        b=j6VIoGe9nXMOC8jnzLO51R5Av0NYSe0D0xLZ3AitxamzyyP23m88jiBwLEMkQcN7+0
         oUpkGvuDbKdmqWKjR7CXYJfjBHx5OdMRR5NAhrKGKIblsufZ2KpaXLp8gLi5ZvEE1F/q
         Id0p2MDJ6fcls53ECB54En3TmceiBtvZxebrZbc2VHP5sTWXnPxbvjqk2L2S1L2tbQ5r
         Krfw8CZAaFQuerYLeNwTOmwAX8776FjPsWqqVZZjKq4wsWOu/J/RqsYNXBEM2CIy99+p
         C5dmMeJj8JIAZTkirbWwUuBOHdhymUs+2y/1qS8+/hwz+RECcivsy6iis6t8RLz0tDxK
         AKfA==
X-Gm-Message-State: AGRZ1gLdHnbS0K5GYzXyVGCrm3GGbmixQULP72xcz+NaWMPLXSr+Nqbn
        nxU74/qV/hCYSjdZRMbU54k=
X-Google-Smtp-Source: AJdET5fgJblcobbtWN43vziOs7OA7inJWEFOO1N2KO5+PVOr8+1H0QPwzWqA786ws/jd50RrRywtsg==
X-Received: by 2002:a63:e918:: with SMTP id i24-v6mr7767635pgh.64.1541089928101;
        Thu, 01 Nov 2018 09:32:08 -0700 (PDT)
Received: from [172.20.5.66] (rrcs-24-227-212-35.sw.biz.rr.com. [24.227.212.35])
        by smtp.gmail.com with ESMTPSA id d67-v6sm9436155pfg.2.2018.11.01.09.32.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 09:32:06 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH 10/17] prmem: documentation
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20181031090835.GG744@hirez.programming.kicks-ass.net>
Date:   Thu, 1 Nov 2018 11:31:59 -0500
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Igor Stoppa <igor.stoppa@gmail.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dave Chinner <david@fromorbit.com>,
        James Morris <jmorris@namei.org>,
        Michal Hocko <mhocko@kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Igor Stoppa <igor.stoppa@huawei.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Laura Abbott <labbott@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <59E8A6FB-9762-499F-89AC-D85E1498BE38@gmail.com>
References: <20181026092609.GB3159@worktop.c.hoisthospitality.com>
 <CAGXu5jKCs01jvtvpEFS7R8qCR-5iRqK11kJxLJY99NicGWc4aQ@mail.gmail.com>
 <20181028183126.GB744@hirez.programming.kicks-ass.net>
 <40cd77ce-f234-3213-f3cb-0c3137c5e201@gmail.com>
 <20181030152641.GE8177@hirez.programming.kicks-ass.net>
 <CAGXu5jJftJ+Hq+jrZGHX5CTDLWOog7kGsd_Ne=yMvrRs__skSg@mail.gmail.com>
 <0A7AFB50-9ADE-4E12-B541-EC7839223B65@amacapital.net>
 <20181030175814.GB10491@bombadil.infradead.org>
 <28C8CD2A-BDC0-49A5-854E-1E18968528B8@amacapital.net>
 <CAC99157-7A9B-4AC6-BA41-EAA7A99FE53D@gmail.com>
 <20181031090835.GG744@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra
Sent: October 31, 2018 at 9:08:35 AM GMT
> To: Nadav Amit <nadav.amit@gmail.com>
> Cc: Andy Lutomirski <luto@amacapital.net>, Matthew Wilcox =
<willy@infradead.org>, Kees Cook <keescook@chromium.org>, Igor Stoppa =
<igor.stoppa@gmail.com>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Dave =
Chinner <david@fromorbit.com>, James Morris <jmorris@namei.org>, Michal =
Hocko <mhocko@kernel.org>, Kernel Hardening =
<kernel-hardening@lists.openwall.com>, linux-integrity =
<linux-integrity@vger.kernel.org>, linux-security-module =
<linux-security-module@vger.kernel.org>, Igor Stoppa =
<igor.stoppa@huawei.com>, Dave Hansen <dave.hansen@linux.intel.com>, =
Jonathan Corbet <corbet@lwn.net>, Laura Abbott <labbott@redhat.com>, =
Randy Dunlap <rdunlap@infradead.org>, Mike Rapoport =
<rppt@linux.vnet.ibm.com>, open list:DOCUMENTATION =
<linux-doc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Thomas =
Gleixner <tglx@linutronix.de>
> Subject: Re: [PATCH 10/17] prmem: documentation
>=20
>=20
> On Tue, Oct 30, 2018 at 04:18:39PM -0700, Nadav Amit wrote:
>>> Nadav, want to resubmit your series? IIRC the only thing wrong with =
it was
>>> that it was a big change and we wanted a simpler fix to backport. =
But
>>> that=E2=80=99s all done now, and I, at least, rather liked your =
code. :)
>>=20
>> I guess since it was based on your ideas=E2=80=A6
>>=20
>> Anyhow, the only open issue that I have with v2 is Peter=E2=80=99s =
wish that I would
>> make kgdb use of poke_text() less disgusting. I still don=E2=80=99t =
know exactly
>> how to deal with it.
>>=20
>> Perhaps it (fixing kgdb) can be postponed? In that case I can just =
resend
>> v2.
>=20
> Oh man, I completely forgot about kgdb :/
>=20
> Also, would it be possible to entirely remove that kmap fallback path?

Let me see what I can do about it.=
