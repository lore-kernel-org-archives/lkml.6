Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C950FC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 23:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97DEE2175B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 23:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="wv+zMIMz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfBGXF6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 18:05:58 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46161 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726764AbfBGXF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 18:05:58 -0500
Received: by mail-pg1-f196.google.com with SMTP id w7so641196pgp.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 15:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Hbh0Z7jJli/j8fxkLyIff0lCnoNIUyy+mbEp9mh9KvU=;
        b=wv+zMIMzqWzSZpqQ6r/bcyKwlo08rPF64Y1Xw+rxw1tjg/51nbe9kDFxLIHNdExFqE
         JaMfDi1BgpMlB4vNmJC8u+YWZxErg2KABz8thwwh1DbDbFjdvyBVwHjX10j9IC2m0jKC
         man59TBE2X18m2UAchZt6Tzywq8tXDVHXq/5JTY++v1ShE68JlX70Zj3WzlIgrTDzE9a
         VrzX1z3NqIXkB9lCLpz5N48S+Co/kNTCUVKpVDqww8q+jP6/0BJ9E1OkyuHAMIWPaV/a
         vot7WWS/kGUjQyP9HGCLb3t8gZUPgZa2H14ZvbNRf7eMJejIEzSc20E+jOMi4oF3zOnU
         yrlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Hbh0Z7jJli/j8fxkLyIff0lCnoNIUyy+mbEp9mh9KvU=;
        b=ICEL7NF+LhFy52xob+Fe2SOK1fkOLM4WUVcLE0xB7JM1dvt81NYWN7CTQ6uJyF+WmK
         RpsnfVoiPIK0LtthfYeCOFynbBrlgEeMxkdjxIRA2ONJolzYRHK9vJA1SBjvTo5HDerh
         fxTN0n8+9tFHdop+hjXUEo4RV6FSPg43R2m1dJ/nHtN7CHZwhzGWc2NT/QWXio/XJwDE
         ZpEVtynWWxqB5HVZqyBqpOrVl42iyzF78p9hgYofS2T7ebqSVRLdA6/KONxCW8wfLIIV
         oxT8R7z+L5qexxSzrQBp2XVoLLBnEoJa05+Yy2P3EshTYJQL/xiXuzwHl0RqMIrkSRW+
         4XGA==
X-Gm-Message-State: AHQUAuZ7uDhr7pPkWDxDTma/NVYaZvwQXj53a1fDR+zxxQEOI2eT8wjS
        oA2V40bMZRrNDfEv7UAY2RHrIdUus6o=
X-Google-Smtp-Source: AHgI3IZxez6y36JVCLK5UpEsKXMnxjQOpDXmqq/NNcdINRi4vT6RiPgJP1VsP3hIRE5FOrpNcKfWrA==
X-Received: by 2002:a62:2a4b:: with SMTP id q72mr18569959pfq.61.1549580756843;
        Thu, 07 Feb 2019 15:05:56 -0800 (PST)
Received: from ?IPv6:2601:646:c200:7429:5ddb:7cae:f29e:d77a? ([2601:646:c200:7429:5ddb:7cae:f29e:d77a])
        by smtp.gmail.com with ESMTPSA id k15sm228041pfb.147.2019.02.07.15.05.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 15:05:55 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [GIT PULL] x86/mm changes for v4.21
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16C101)
In-Reply-To: <CAHk-=wiZ3t_YbtRz1tLTEvF0JS1DH07DdDR3FP-FHcZW8wfSAw@mail.gmail.com>
Date:   Thu, 7 Feb 2019 15:05:54 -0800
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rik van Riel <riel@surriel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <42A9C88A-DFA3-4936-BA4E-F853E5871ACF@amacapital.net>
References: <20181224231106.GA27438@gmail.com> <20190207001737.GA32096@agluck-desk> <20190207101846.GB32511@hirez.programming.kicks-ass.net> <CAHk-=whSRGDk9437PvMFEvDvc5hr73fXj+CvNHZu=vNE=GFDFg@mail.gmail.com> <20190207140131.GB32477@hirez.programming.kicks-ass.net> <20190207173600.GA15682@agluck-desk> <20190207175720.GE32511@hirez.programming.kicks-ass.net> <8D8DF81C-3331-4105-8594-9600281010EF@amacapital.net> <20190207184606.GB17049@agluck-desk> <22E08A6D-5180-42F1-B94B-6B6DB832F953@amacapital.net> <CAHk-=wiZ3t_YbtRz1tLTEvF0JS1DH07DdDR3FP-FHcZW8wfSAw@mail.gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 7, 2019, at 2:53 PM, Linus Torvalds <torvalds@linux-foundation.org>=
 wrote:
>=20
>> On Thu, Feb 7, 2019 at 1:24 PM Andy Lutomirski <luto@amacapital.net> wrot=
e:
>>=20
>> How bad would it be to set CR0.CD while fiddling with the page tables rat=
her than masking the address?
>=20
> I would suggest against it. When you disable caching, things don't
> just go "slightly slower". Everything comes to a screeching halt, with
> instruction fetch etc becoming a serious problem.
>=20
> So disabling caching for a few instructions in a very simple asm
> snippet might be reasonable (particularly since you could pre-fetch
> the cache and just rely on CR0.CD not fetching *new* lines). But doing
> it in C code that might have things like tracing enabled etc? I'd be
> very very leery.
>=20
>=20

In principle, it=E2=80=99s just the code that walks the page tables and chan=
ges the mode.  But we could get a perf NMI and take who knows how long to pr=
ocess it if caching is off.=
