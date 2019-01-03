Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C6DC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 23:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D378D20660
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 23:56:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xb1fxhBm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728978AbfACX4i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 18:56:38 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38299 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbfACX4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 18:56:38 -0500
Received: by mail-pl1-f196.google.com with SMTP id e5so16568040plb.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 15:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=7SwYmZ0oIMjQE0KO/pvJoJQbV+s3sCOCab+M0pUSV+E=;
        b=Xb1fxhBmr8pS37BigirB+qdUxUCqbCGQpbwHq9PV7ubJ48/6rGamw5jeDKE/mt875U
         CuKrB4O0Ue4wE/V93ClD515mkfk7ZrVnz8S162CFf13dcjlWtn2pMv/UXcZLLAuGtBu0
         XZqTwL12MdM49hD5yIkz+B83+IiaANCkNH30ERDtPwFIuEMk9fsf19Hv2a8C0aD014x7
         2qmiSyWQ7+SCtslU9/aF7voxXgs3cHeGZKqdzYv/K8OR9lEU6OWkspuT43Ia4bnZYeOh
         k/v2Ldk6EfTqwUcD1pxPqrO8663nIn0iTIlXTmgi2qnqAHOcBVpcInvbyfbkK/e+hh+f
         7Vsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=7SwYmZ0oIMjQE0KO/pvJoJQbV+s3sCOCab+M0pUSV+E=;
        b=VQA+ebFOLnIWKbhOfaEC50RC7JKXx6+xWM3HnilEx1lMszXD/zR2HtweOnxnw0hpBf
         6zxJyjDKzXVIhUOZZw2iJ8QDbhKXwwXxXOkW7OIFg7o5UhCgJZ6Q81DLdxAd5aAEPaMB
         4/8343Ec8TOeIdCw31z++QVw3IOtRU17VX1p9+gka8pOQzqk9aESM/+27K/PcGGiRLzK
         rh8ldykpSPtPurNqYrKRnG0IfBYOp8hLRGk41P3alWuFNCq5ecNyYwD3LEV3V17Xix6T
         BnIIFA3tVFDxmOz2yC6xnRinQTqkjNasKmBkr1N/BMWDIDWij8+ZZfQh31+ljb6ZAAAC
         tDYQ==
X-Gm-Message-State: AJcUukcqFCiuNGhk85pMQi0TdxtOBDIRUJSptrbFMbeBR6jKVHVlkG5Y
        kX3lxh3B3uJ3gG5/VoNZenM=
X-Google-Smtp-Source: ALg8bN5+MPPkKOGc6W2cfNO6C2hGiJe0VNsSjdcP+ZzmuqATwtUEll8ZYRRv1VtpNkwlr62ak64ncg==
X-Received: by 2002:a17:902:d202:: with SMTP id t2mr49596654ply.193.1546559797382;
        Thu, 03 Jan 2019 15:56:37 -0800 (PST)
Received: from [10.2.13.140] ([208.91.2.1])
        by smtp.gmail.com with ESMTPSA id o189sm92893924pfg.117.2019.01.03.15.56.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Jan 2019 15:56:36 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [RFC v2 1/6] x86: introduce kernel restartable sequence
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20190103234029.GH6118@tassilo.jf.intel.com>
Date:   Thu, 3 Jan 2019 15:56:34 -0800
Cc:     Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Edward Cree <ecree@solarflare.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        David Woodhouse <dwmw@amazon.co.uk>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B31EB4F4-99BE-4E00-8A48-BD77282A1BA8@gmail.com>
References: <20181231072112.21051-1-namit@vmware.com>
 <20181231072112.21051-2-namit@vmware.com> <87va35e61a.fsf@linux.intel.com>
 <263A441C-F062-491F-9E95-F00FA2092A99@gmail.com>
 <20190103224835.GG6118@tassilo.jf.intel.com>
 <28F28C02-1817-4A0A-B488-216FDF22169A@gmail.com>
 <20190103234029.GH6118@tassilo.jf.intel.com>
To:     Andi Kleen <ak@linux.intel.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Jan 3, 2019, at 3:40 PM, Andi Kleen <ak@linux.intel.com> wrote:
>=20
>> Thanks for the explanations. I don=E2=80=99t think it would work =
(e.g., IRQs). I can
>> avoid generalizing and just detect the "magic sequence=E2=80=9D of =
the code, but let
>> me give it some more thought.
>=20
> If you ask me I would just use compiler profile feedback or autofdo =
(if your
> compiler has a working version)
>=20
> The compiler can do a much better job at optimizing this than you ever =
could.
>=20
> Manual FDO needs some kernel patching though.

As long as you are willing to profile and build your own kernels. =
(Profiling
will not tell you if users are about to use IPv4/6).

I also don=E2=80=99t see how FDO can support modules.

