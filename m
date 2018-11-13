Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2859C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 23:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46D75223AE
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 23:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synesis-ru.20150623.gappssmtp.com header.i=@synesis-ru.20150623.gappssmtp.com header.b="PdUK3ZbP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46D75223AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synesis.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731543AbeKNJIQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 04:08:16 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33980 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbeKNJIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 04:08:16 -0500
Received: by mail-ot1-f66.google.com with SMTP id t5so13064753otk.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 15:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=synesis-ru.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DLfFA4H7xTkIEVVmh/WC/nooH+dzsolOAa+9udekV3I=;
        b=PdUK3ZbPkIQk5CgDi6PuYb5SXWVx3DJSFwz2psx06854A7GeolYSn7XMElsM55Tmp7
         dJUj9Yd8oo38oNrm9LAg55HYOXQz2hZu/mb4W3WN7YDhoEkEc8GBhY18l342LdaTzV/H
         eJR9oz4aDlHXyi6u2lg2l8V+oYgzqgg7NNE8xacNOIbSPA+qYrAsHIeneca2ztQYL20q
         NbP9P7O8BELvpu2wYRfmCFqkj12fROuV2Y+AjduFLUCYM9rP+OblbBpqsd4ZDo8dF0q8
         G+n284S/aMBynoTB9wGtBhvgQK8NwuZh8UtgSfiI7fV+edTYmJ3pA+WyCDuGLX0S2N2o
         +Uiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DLfFA4H7xTkIEVVmh/WC/nooH+dzsolOAa+9udekV3I=;
        b=SsE5fiJ3ePsJTnZpjmL2iJAfOOQ5KZnZvRbaDkjFEe3Ox+xVEMVJ7ZXKFJV4NL1fW4
         F2BJGt2azNmXVDinE6EVyk1LVkPmHHP2p5FmnMBwAjc1Fu2pwJpIk/hR9Bhkmx7lImXK
         wUsSH37562sRZavPgDWtTLVZBYJl05MH/cG4x8A+DaLDIEc9JcrLBvs1guAjPxNemrA/
         q4WlI3FcBwOlgr0t3AbRSIGqqSTnUFmabmAfB5wRDQ7nrg+eMXuse3zcDwXJK2Hrz/Rh
         yEM0DnNPVkp3aPy1r9UheJlO7QfSF1tpA1oQWws5d2CxnE+wTklP7AYFUxFdrIeTlY5P
         dQ8w==
X-Gm-Message-State: AGRZ1gK3LN/LBKsUNZclVTrPYlVUvY7xwweDE0MlWEUKqjcAAyk/NTON
        qcO9ZuTCsAYEoRVdTOVavN24IwM4dhvd+A==
X-Google-Smtp-Source: AJdET5cIiRaOv2zFfxvU2hClu28s2DbMlMErNdoI3icyjGiFtUDFEUlt+6PaVixWdrSIin4++ad53Q==
X-Received: by 2002:a9d:5205:: with SMTP id e5mr4383250oth.336.1542150469707;
        Tue, 13 Nov 2018 15:07:49 -0800 (PST)
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com. [209.85.167.172])
        by smtp.gmail.com with ESMTPSA id s64-v6sm4429130oia.30.2018.11.13.15.07.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 15:07:48 -0800 (PST)
Received: by mail-oi1-f172.google.com with SMTP id a202-v6so3825907oib.1;
        Tue, 13 Nov 2018 15:07:48 -0800 (PST)
X-Received: by 2002:aca:f5d4:: with SMTP id t203-v6mr4339529oih.98.1542150467834;
 Tue, 13 Nov 2018 15:07:47 -0800 (PST)
MIME-Version: 1.0
References: <CAG48ez0ZprqUYGZFxcrY6U3Dnwt77q1NJXzzpsn1XNkRuXVppw@mail.gmail.com>
 <d43da6ad1a3c164aa03e0f22f065591a@natalenko.name> <20181113175930.3g65rlhbaimstq7g@soleen.tm1wkky2jk1uhgkn0ivaxijq1c.bx.internal.cloudapp.net>
 <CAGqmi74gpvJv8=B-3pVSMrDssu-aYMxW9xM7mt1WNQjGLjMZqA@mail.gmail.com>
 <20181113183510.5y2hzruoi23e7o2t@soleen.tm1wkky2jk1uhgkn0ivaxijq1c.bx.internal.cloudapp.net>
 <CAGqmi763e4sZj1NHAk2fAjtPtb-kAZfcPq=KTH8B3sE-oDVvGw@mail.gmail.com>
 <20181113191653.btbzobquxtwt47z4@soleen.tm1wkky2jk1uhgkn0ivaxijq1c.bx.internal.cloudapp.net>
 <CAGqmi77JMyxU9L4bZHPv4Nt=tyQsEZDQcMVMRfQ7de_LjZg+-Q@mail.gmail.com> <20181113225334.hnz7pqoldvvg6j3w@soleen.tm1wkky2jk1uhgkn0ivaxijq1c.bx.internal.cloudapp.net>
In-Reply-To: <20181113225334.hnz7pqoldvvg6j3w@soleen.tm1wkky2jk1uhgkn0ivaxijq1c.bx.internal.cloudapp.net>
From:   Timofey Titovets <timofey.titovets@synesis.ru>
Date:   Wed, 14 Nov 2018 02:07:11 +0300
X-Gmail-Original-Message-ID: <CAGqmi75sk7A7y=urhyEJ=Wf5Dvv7y48DgPzQP-335s_JV0g+2g@mail.gmail.com>
Message-ID: <CAGqmi75sk7A7y=urhyEJ=Wf5Dvv7y48DgPzQP-335s_JV0g+2g@mail.gmail.com>
Subject: Re: [PATCH V3] KSM: allow dedup all tasks memory
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     Oleksandr Natalenko <oleksandr@natalenko.name>,
        Jann Horn <jannh@google.com>, linux-doc@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D1=81=D1=80, 14 =D0=BD=D0=BE=D1=8F=D0=B1. 2018 =D0=B3. =D0=B2 01:53, Pavel=
 Tatashin <pasha.tatashin@soleen.com>:
>
> > > > That must work, but we out of bit space in vm_flags [1].
> > > > i.e. first 32 bits already defined, and other only accessible only =
on
> > > > 64-bit machines.
> > >
> > > So, grow vm_flags_t to 64-bit, or enable this feature on 64-bit only.
> >
> > With all due respect to you, for that type of things we need
> > mm maintainer opinion.
>
> As far as I understood, you already got directions from the maintainers
> to do similar to the way THP is implemented, and THP uses two flags:
>
> VM_HUGEPAGE VM_NOHUGEPAGE, the same as I am thinking ksm should do if we
> honor MADV_UNMERGEABLE.
>
> When VM_NOHUGEPAGE is set khugepaged ignores those VMAs.
>
> There may be a way to add VM_UNMERGEABLE without extending the size of
> vm_flags, but that would be a good start point in looking how to add a
> new flag.
>
> Again, you could simply enable this feature on 64-bit only.
>
> Pasha
>

Deal!
I will try with only on 64bit machines.
