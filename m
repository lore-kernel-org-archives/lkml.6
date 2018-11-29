Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 252B6C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D47EE20863
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:31:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="pw1+k+pp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D47EE20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730162AbeK3EhP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 23:37:15 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38799 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728588AbeK3EhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 23:37:14 -0500
Received: by mail-pf1-f193.google.com with SMTP id q1so1355105pfi.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 09:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=2tQ5huMkLzakExYysCtmqa5Z9VUiuD9pirjYV/w5OS0=;
        b=pw1+k+ppP/qWxqBmXUDWYRmYBPHR8sPhVInoGl/J5tapoWxwEpiblouy+6+D+MWg4j
         YoctUZ3w8usb+vghH5Koc3+yjtR+KsrSrXIJNw+SXIfdDbaEsgso/KmiLktEemHol9xj
         BtHLXb8ZKLydtlee+5epF8YkXZDi1AFZFYJGKmNT0f+CZPdl1nU6o6FW+Uaq4phkaU9d
         h2HltHdbdUX3gCY5vJ7dBuDDgvowwlRXrct2bW25tOkl5CSjv/8fIQy04B8xCBRovbVr
         oKpkW946nJeprSmz5khX2rwTWxwVsdBp/HdBjLTVPimxIVb7rxb9tBGYT0Sg5oFhpi+j
         4O7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=2tQ5huMkLzakExYysCtmqa5Z9VUiuD9pirjYV/w5OS0=;
        b=QTSl/lftrAFXMOksAkLos8/qp14nrpVFrIyLYp2l2XHTtbWfJWIQTxOfBKEPw1rccm
         ETAd0Kr/Q9ViUUbgQm8nxpGMntPVq+J1p93tOj+md9ZAF9bpDik0uLVElXfWvUoeN5wf
         XJmBVap0WH2DhkQyIkqwQmfceJEoKdHgvgcu1ZRIZfSMepE0DBKd6KAOLoxYAJKP4Bz2
         llTOoO19PrOdF0Auoa0ejAQugin+Hr87fUdqVWDROUtnMiJrAf/8xBPQ6OhZ8tsUkgtt
         KRedPx9j4eC+pTCRQCos2KiRrjjUApItl9A8SgK/s1BvbUP56x+ZBYxCAFw4M4aDuHrC
         z0QA==
X-Gm-Message-State: AA+aEWYO8cQgCjzBfON2ChNNNcmmwGLZr5XvsYIdjNfqOVUbp4HMa2W/
        ycoFbv0/9iUD8Zko1QOMwPpp4Q==
X-Google-Smtp-Source: AFSGD/Xc+vZVEOo4YbqR1N9Y/GBAyIwnFWx+Nr99GzV7HwSeuMz2KKWg+ayHqPTlw2YJxQwxPpqBoQ==
X-Received: by 2002:a62:7a8b:: with SMTP id v133mr2290515pfc.159.1543512666935;
        Thu, 29 Nov 2018 09:31:06 -0800 (PST)
Received: from ?IPv6:2600:1010:b054:ff26:3849:a65d:14d0:f668? ([2600:1010:b054:ff26:3849:a65d:14d0:f668])
        by smtp.gmail.com with ESMTPSA id h124sm3485936pfg.143.2018.11.29.09.31.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 09:31:06 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 4/4] x86/static_call: Add inline static call implementation for x86-64
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16B92)
In-Reply-To: <20181129170742.GC9027@hirez.programming.kicks-ass.net>
Date:   Thu, 29 Nov 2018 09:31:04 -0800
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, mhiramat@kernel.org,
        jbaron@akamai.com, Jiri Kosina <jkosina@suse.cz>,
        David.Laight@aculab.com, bp@alien8.de, julia@ni.com,
        jeyu@kernel.org, Peter Anvin <hpa@zytor.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6C359EF7-B2B6-4FED-96EB-CB7C91918763@amacapital.net>
References: <20181126200801.GW2113@hirez.programming.kicks-ass.net> <20181126212628.4apztfazichxnt7r@treble> <20181127084330.GX2113@hirez.programming.kicks-ass.net> <CALCETrXam8JBtXE3S97Vyb_=+pmjgr23SoZ-Dm5pmYtwZYA+7Q@mail.gmail.com> <20181129094210.GC2131@hirez.programming.kicks-ass.net> <ECF632D9-581B-40B7-9F0A-6B5607A4D0E3@amacapital.net> <20181129143853.GO2131@hirez.programming.kicks-ass.net> <20181129163342.tp5wlfcyiazwwyoh@treble> <CAHk-=wg5wUXJX5mF+22WXWM_vPESb+p6-z-ZrG7rC1k2O7u=NQ@mail.gmail.com> <0A629D30-ADCF-4159-9443-E5727146F65F@amacapital.net> <20181129170742.GC9027@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 29, 2018, at 9:07 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
> On Thu, Nov 29, 2018 at 09:02:23AM -0800, Andy Lutomirski wrote:
>>> On Nov 29, 2018, at 8:50 AM, Linus Torvalds <torvalds@linux-foundation.o=
rg> wrote:
>=20
>>> So no. Do *not* try to change %rsp on the stack in the bp handler.
>>> Instead, I'd suggest:
>>>=20
>>> - just restart the instruction (with the suggested "ptregs->rip --")
>>>=20
>>> - to avoid any "oh, we're not making progress" issues, just fix the
>>> instruction yourself to be the right call, by looking it up in the
>>> "what needs to be fixed" tables.
>>>=20
>>> No?
>=20
>> Or do you think we can avoid the IPI while the int3 is there?
>=20
> I'm thinking Linus is suggesting the #BP handler does the text write too
> (as a competing store) and then sync_core() and restarts.
>=20
> But I think that is broken, because then there is no telling what the
> other CPUs will observe.

Does anyone know what the actual hardware semantics are?  The SDM is not par=
ticularly informative unless I looked at the wrong section.=
