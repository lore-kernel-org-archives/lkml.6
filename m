Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AADFC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 23:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3EF62082F
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 23:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="Dup2epzI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3EF62082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbeKZJ4t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 04:56:49 -0500
Received: from mail-pf1-f172.google.com ([209.85.210.172]:33264 "EHLO
        mail-pf1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbeKZJ4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 04:56:48 -0500
Received: by mail-pf1-f172.google.com with SMTP id c123so4915829pfb.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 15:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/4aDE9ihAEIORlpRetXDVtJmf/QKIgFjKPM953lu8EI=;
        b=Dup2epzIbVbzGQ+tvRduX44zsS7aEvVgZClojGuU50/DYLkKKaQyrVi7w9KmHuoQVI
         rErczr7WtTNwSBGF8G9AHoCi0NdujySuA7nSIP/jCm5Ws5mkyjHqbA3VkAuaS9xkZTR2
         UPGd70lJ1WNar/oJpTAZa9nqMJ3r7KC4bkJ6/qs0rEDbXPoIg7Rw/kePWAkO4DTF74O5
         iHxfONAXUJbyYH+/QwMmlLj/vc8tcPzpq3VeMVOewLtu/BYW4LtFwftzJhYvF5G+bfIq
         LszlUWSi0a4nv5XO0lfVIumjtQWWCoR5XiVtYtqN4XEp2T39VxWxW/Aul1Mqdx+8yfTc
         KBqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/4aDE9ihAEIORlpRetXDVtJmf/QKIgFjKPM953lu8EI=;
        b=U/1kYhhjDmQmG0cE7dFHtU4YTM2kPAZzOCExd0X0ERmGJQpFheOrueARTPqD53+sHB
         LcDTukI3xf+ZHaFH5w2Jx4sCavtQxQcY2ePZKm/YsyEbrj6UgLbPg0VulRGtLivhY4eV
         Bcdj+ivHaQLvSxBmjuQyyhH1MT5YwwLiE5pfO7sU4Rx/uJK+7pDzzgwQty43aLOATvZE
         g3Xs0xg6CulKKg3MxKwUD7fj0/QZxgCrFGSn2ErSmQ+FJz7tEYBN2hIeEzrco5iG6anj
         YQzwt8Lu1Ts5jD/iws6n+pBCdsFSPeLK4drUlLIh0FQOkCQKfTVfD3U+4EcRJ+9bZ1VJ
         R8+w==
X-Gm-Message-State: AA+aEWZFryWSP2n6EQN45GKspn87qsspnYVVjmLLzNb+YHFArdVVMcSB
        FNuAUr4d4PNmpksj7LeuxHg2Uw==
X-Google-Smtp-Source: AFSGD/WWY4vGEGizShSiG66oI4/58+HuS6x/RcZbFiWYh2g+og6zjImAZ6VKxyBDjzElqXu2kTDbHQ==
X-Received: by 2002:a63:24c2:: with SMTP id k185mr21810568pgk.406.1543187075558;
        Sun, 25 Nov 2018 15:04:35 -0800 (PST)
Received: from ?IPv6:2601:646:c200:7429:7069:da99:d9d2:c355? ([2601:646:c200:7429:7069:da99:d9d2:c355])
        by smtp.gmail.com with ESMTPSA id f193-v6sm89516464pfc.74.2018.11.25.15.04.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Nov 2018 15:04:34 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [patch V2 21/28] x86/speculation: Prepare for conditional IBPB in switch_mm()
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16B92)
In-Reply-To: <alpine.DEB.2.21.1811252316560.1684@nanos.tec.linutronix.de>
Date:   Sun, 25 Nov 2018 15:04:33 -0800
Cc:     Andi Kleen <ak@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>,
        Waiman Long <longman9394@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Dave Stewart <david.c.stewart@intel.com>,
        Kees Cook <keescook@chromium.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <92833780-41BE-446E-A676-925BA1EC93D9@amacapital.net>
References: <20181125183328.318175777@linutronix.de> <20181125185005.466447057@linutronix.de> <20181125205330.GO13936@tassilo.jf.intel.com> <alpine.DEB.2.21.1811252316560.1684@nanos.tec.linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 25, 2018, at 2:20 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
>=20
> On Sun, 25 Nov 2018, Andi Kleen wrote:
>=20
>>> The current check whether two tasks belong to the same context is using t=
he
>>> tasks context id. While correct, it's simpler to use the mm pointer beca=
use
>>> it allows to mangle the TIF_SPEC_IB bit into it. The context id based
>>> mechanism requires extra storage, which creates worse code.
>>=20
>> [We tried similar in some really early versions, but it was replaced
>> with the context id later.]
>>=20
>> One issue with using the pointer is that the pointer can be reused
>> when the original mm_struct is freed, and then gets reallocated
>> immediately to an attacker. Then the attacker may avoid the IBPB.
>>=20
>> Given it's probably hard to generate any reasonable leak bandwidth with
>> such a complex scenario, but it still seemed better to close the hole.
>=20
> Sorry, but that's really a purely academic exercise.=20
>=20
>=20

I would guess that it=E2=80=99s actually very easy to force mm_struct* reuse=
.  Don=E2=80=99t the various allocators try to allocate hot memory?  There=E2=
=80=99s nothing hotter than a just-freed allocation of the same size.

Can someone explain the actual problem with ctx_id?  If you just need an ext=
ra bit, how about:

2*ctx_id vs 2*ctx_id+1

Or any of the many variants of approximately the same thing?

=E2=80=94Andy=
