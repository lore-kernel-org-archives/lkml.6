Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74064C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 392D42070B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RyGyPXZD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729599AbfAHUry (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 15:47:54 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37354 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728559AbfAHUrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 15:47:53 -0500
Received: by mail-wr1-f66.google.com with SMTP id s12so5473418wrt.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 12:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ZjoZV6IPjVL8g6UaeWt8waJl3GwrN5iFIB5otsE0ekw=;
        b=RyGyPXZDTUUHqWv1OL3ssNdUUYkGpMpA+y3Qn/RJtiCVkswVi/whRkYlSYz3pMo+zM
         Mo1BvjMm+KPxdpeUSCyRzhkPsOD30KcYFESKzONpha0cXj2DY2Txmq0xA4m4l4kgn0p4
         pxAIEMB7sq3RZqZUlu6AOP8cGMiMfnT4MWt9RX5JJD9bHXI+HaiWK+CQ8yy3KzfNsT/I
         xU+DatXtqqfCuNcf35ypa8zqOSRCCzOkDBk+foeHytcJV9kjSKr1ZOUqPZ7GXnis8/zD
         c5CW4xtUDLEZcVpdycws0fK9gmt061XQHdup9AJKVMgX40wodbmTA/Up0K3mBK2j+Q6+
         +3MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ZjoZV6IPjVL8g6UaeWt8waJl3GwrN5iFIB5otsE0ekw=;
        b=XMDymeAPR8m2vFe0ZuqBUyyX1knmY3bALIBQNguUaIJdyEe+9XVlfk2JtX8ofdGxEB
         Hozo0rMxwP5V7IqLNxEQkiFwCi2A6qnrzFsik0iOzkTW1oKv70hbAn44Z/FC5EiXfi2g
         BPtlsammkkBkgvRtyc2YH9XTVPoT3tmiuTKHygFuWHmlhqM7//Ufk3YtWx8GOGRcDdLO
         hHeruCJvpoU7wsFkiUf/QbxdBOZCByrh4RJhld8cgIdlgtW5dTBGkHPGUkLt5kh/TYnH
         Khjo3injNAh3Fd7iS0ZLaQv5pTERdFmLI9g7SurNxb7iDNjvdREx6yw63Yk1l9ot7Bk/
         eaWA==
X-Gm-Message-State: AJcUukfSsqoMUtjFFuT3rVjI9dOIIz6eUPMWlF7SF5hHI6coIzyJTfC5
        69Vg2m0MI8uGR9yYUUeB4YQ=
X-Google-Smtp-Source: ALg8bN4Zt/YnHHQ66A74+3lrSFQZBQueIKF4r257k4Dx8tq3Kli+5h0k+C8GlLk1PaIbk5j16tG/hA==
X-Received: by 2002:adf:91c3:: with SMTP id 61mr2478656wri.324.1546980471531;
        Tue, 08 Jan 2019 12:47:51 -0800 (PST)
Received: from [10.2.13.140] ([208.91.2.1])
        by smtp.gmail.com with ESMTPSA id 133sm11271932wme.9.2019.01.08.12.47.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 12:47:48 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [RFC v2 0/6] x86: dynamic indirect branch promotion
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20190108190104.GC1900@hirez.programming.kicks-ass.net>
Date:   Tue, 8 Jan 2019 12:47:42 -0800
Cc:     Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Edward Cree <ecree@solarflare.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        songliubraving@fb.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <7EB5F9ED-8743-4225-BE97-8D5C8D8E0F84@gmail.com>
References: <20181231072112.21051-1-namit@vmware.com>
 <87zhshe66w.fsf@linux.intel.com>
 <20190107163227.GH14122@hirez.programming.kicks-ass.net>
 <c4e836e8-1949-27f5-f6a0-ed860f590ec5@intel.com>
 <20190108092559.GA6808@hirez.programming.kicks-ass.net>
 <306d38fb-7ce6-a3ec-a351-6c117559ebaa@intel.com>
 <20190108101058.GB6808@hirez.programming.kicks-ass.net>
 <20190108172721.GN6118@tassilo.jf.intel.com>
 <D1A153D5-D23B-45E6-9E7A-EB9CBAE84B7E@gmail.com>
 <20190108190104.GC1900@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Jan 8, 2019, at 11:01 AM, Peter Zijlstra <peterz@infradead.org> =
wrote:
>=20
> On Tue, Jan 08, 2019 at 10:28:02AM -0800, Nadav Amit wrote:
>> Is it really that important for debugging to get the instructions at =
the
>> time of execution? Wouldn=E2=80=99t it be easier to annotate the =
instructions that
>> might change? After all, it is not as if any instruction can change =
to any
>> other instruction.
>=20
> I think PT has a bitstream encoding of branch-taken; to decode and
> follow the actual code-flow you then need to have the actual and
> accurate branch target from the code. If we go muck about with the =
code
> and change that, decoding gets somewhat 'tricky'.
>=20
> Or something along those lines..

Thanks for the explanation (I now see it in the SDM and sources).

Basically, the updates should not be done too frequently, and I can =
expose
an interface to suspend them (this will not affect correctness). I think
this can be the easiest solution, which should not affect the workload
execution too much.

A general solution is more complicated, however, due to the racy nature =
of
cross-modifying code. There would need to be TSC recording of the time
before the modifications start and after they are done.

BTW: I am not sure that static-keys are much better. Their change also
affects the control flow, and they do affect the control flow.

