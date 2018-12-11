Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04246C67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 23:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCF0E2084C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 23:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544569950;
	bh=OKUSz3fk1wncHnkmLeETn7cUxXQPPoRi88bsW5T7ytQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=eqsFBIqmwCmVfjDD97lfj66ip2bqSI3h67xmClRLNK1n43G1Qe7zCR12CDRrM4o6Z
	 xmqhyd7mkBSjQ2O7br1AiGkEYYWd/KzcWrUs+QGy+bg7HiUmKLMcJA/GrKzM9k5vgj
	 P02PO/BLwrQkiLl9WrDAU4/i7/t/5mEny5e3OG24=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCF0E2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbeLKXM3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 18:12:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:50806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726158AbeLKXM3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 18:12:29 -0500
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2AD982084C
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 23:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544569948;
        bh=OKUSz3fk1wncHnkmLeETn7cUxXQPPoRi88bsW5T7ytQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UBapF1SSlTBjdbIs5S9FQJHfudA8FdaJmDpIWz0kQOwwtCtZSGGGpgUnRSzsCcTyj
         tpTp0vdRzu6OCUBpwv7S44nCXJk+9nIQmn7uDZ/VjERIJwBSfeViOo/zQqaHK1oNh9
         tmygWYZZ7jeQauHpdbw2eC66lBJ4jxlWDN54dnIY=
Received: by mail-wr1-f44.google.com with SMTP id b14so15806066wru.12
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 15:12:28 -0800 (PST)
X-Gm-Message-State: AA+aEWZUF3WMpR4MAmz7/Y95/ND2E6XUEAvXNYVD024ld10S+eFNJr/T
        DkN+wjn1ox4rKRf/lN5ny1wolQWvboNxMBeyAW95Wg==
X-Google-Smtp-Source: AFSGD/WbUHMEZv3ju+uLD4YviuGUJxg+h3Cl034KBueEPAKbA7cBi0lATxeON5v8G8XJ1zJd/9phvPh8CT0m8547Mto=
X-Received: by 2002:adf:8323:: with SMTP id 32mr14525244wrd.176.1544569946669;
 Tue, 11 Dec 2018 15:12:26 -0800 (PST)
MIME-Version: 1.0
References: <20181207165145.GB10404@linux.intel.com> <CALCETrVkEW82PzQZhJ5iS849DLY1gbd8YjH5F7P1J7hgjkjiOQ@mail.gmail.com>
 <20181207190257.GC10404@linux.intel.com> <EFA99261-BE93-49DA-9A8F-E6FD28069AFC@amacapital.net>
 <20181207200935.GE10404@linux.intel.com> <4CEB5945-9562-40FA-8CCA-A1675D55B001@amacapital.net>
 <20181207212649.GG10404@linux.intel.com> <CALCETrVBR+2HjTqX=W4r9GOq69Xg36v4gmCKqK0wUjzAqBJnrw@mail.gmail.com>
 <20181211193144.GG14731@linux.intel.com> <CALCETrXbCFRQ_8Uu8Yh9EDeWJMEzZ+Dr386XrAprz1E6g+3X+Q@mail.gmail.com>
 <20181211220010.GH14731@linux.intel.com>
In-Reply-To: <20181211220010.GH14731@linux.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 11 Dec 2018 15:12:14 -0800
X-Gmail-Original-Message-ID: <CALCETrWFHn0QrLmnUuxNC+rZ5LDdYmpVz8PSJk5Zmp+sWFM7zw@mail.gmail.com>
Message-ID: <CALCETrWFHn0QrLmnUuxNC+rZ5LDdYmpVz8PSJk5Zmp+sWFM7zw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 4/4] x86/vdso: Add __vdso_sgx_enter_enclave() to
 wrap SGX enclave transitions
To:     "Christopherson, Sean J" <sean.j.christopherson@intel.com>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Josh Triplett <josh@joshtriplett.org>,
        linux-sgx@vger.kernel.org,
        Haitao Huang <haitao.huang@linux.intel.com>,
        Jethro Beekman <jethro@fortanix.com>,
        "Dr. Greg Wettstein" <greg@enjellic.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 2:00 PM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> On Tue, Dec 11, 2018 at 12:04:15PM -0800, Andy Lutomirski wrote:
> > On Tue, Dec 11, 2018 at 11:31 AM Sean Christopherson
> > <sean.j.christopherson@intel.com> wrote:
> > >
> > > On Fri, Dec 07, 2018 at 03:33:57PM -0800, Andy Lutomirski wrote:
> > > > On Fri, Dec 7, 2018 at 1:26 PM Sean Christopherson
> > > > <sean.j.christopherson@intel.com> wrote:
> > > > >
> > > > > Running a checksum on the stack for every exit doesn't seem like it'd
> > > > > be worth the effort, especially since this type of bug should be quite
> > > > > rare, at least in production environments.
> > > > >
> > > > > If we want to pursue the checksum idea I think the easiest approach
> > > > > would be to combine it with an exit_handler and do a simple check on
> > > > > the handler.  It'd be minimal overhead in the fast path and would flag
> > > > > cases where invoking exit_handle() would explode, while deferring all
> > > > > other checks to the user.
> > > >
> > > > How about this variant?
> > > >
> > > > #define MAGIC 0xaaaabbbbccccddddul
> > > > #define RETADDR_HASH ((unsigned long)__builtin_return_address(0) ^ MAGIC)
> > > >
> > > > void foo(void)
> > > > {
> > > >     volatile unsigned long hash = RETADDR_HASH;
> > > >
> > > >     /* placeholder for your actual code */
> > > >     asm volatile ("nop");
> > > >
> > > >     if (hash != RETADDR_HASH)
> > > >         asm volatile ("ud2");
> > > > }
> > > >
> > > > But I have a real argument for dropping exit_handler: in this new age
> > > > of Spectre, the indirect call is a retpoline, and it's therefore quite
> > > > slow.
> > >
> > > Technically slower, but would the extra CALL+RET pair even be noticeable
> > > in the grand scheme of SGX?
> >
> > But it's CALL, CALL, MOV to overwrite return address, intentionally
> > midpredicted RET, and RET because Spectre.  That whole sequence seems
> > to be several tens of cycles, so it's a lot worse than just CALL+RET.
> > Whether it's noticeable overall is a fair question, though.
>
> I was thinking of the case where the handler re-entered the enclave vs.
> leaving and re-calling the vDSO, which would be RET+CALL and some other
> stuff.

Fair enough, although the case where we do an EENTER, an AEP, a kernel
entry, an IRET, and an ERESUME will be so slow that the CALL+RET seems
even less relevant.  The EENTER+EEXIT case at least avoids the round
trip through x86's amazingly performant exception handling mechanism
:)
