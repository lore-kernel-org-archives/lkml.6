Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75EDEECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 22:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C4EA2086E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 22:20:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="hlArz64c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C4EA2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730176AbeGTXKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 19:10:43 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35180 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728297AbeGTXKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 19:10:43 -0400
Received: by mail-pg1-f195.google.com with SMTP id e6-v6so7936404pgv.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 15:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=jOEkLYXr9tHhZqe36sS26gXuMIDwzLc8OryBqDYo7Ls=;
        b=hlArz64cbo9kTip7u4B3ayORsmjaDiPEl9jayNpPMfTlJQE8GErvaQM3E3qvATHW2l
         Fc6mEsYmnSBNiT9Ah3aYmrinDGuWHxn+xc4HFHAoDH54l3yz0e0iw9v83ROzEcqBbI4O
         PPVpclnSVG/Wt/+V/aFeJ2tsgGQl8f5VCL4FXPjaYoRDlqHEAqOjd4+JfD2qmVNXz9vn
         BccHOjlQcWosLuremRFKYBk0c3QKK1pucfHi6k8sh2u78WADYC3AHWrb8lKGIsj15bBC
         tBlPijx5nmwJEAfkp2QJvk6YuvVdEdFwWbnOHEBvzNRgqiyO53Cyvvu07IcDMmap8yOk
         mbQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=jOEkLYXr9tHhZqe36sS26gXuMIDwzLc8OryBqDYo7Ls=;
        b=MUHGsP02O6FV3aeKIOPdOkxdDrI6GOGjUL0vnKp7D43YCGGZeUev9qBTzXgQaFTWNV
         y8ojV0S2IM+7ZuS0ASt+j56eD9whEIUXnORfiZbBQWwrZgMGYyQ0A5FuF8c+ySmSmxBM
         GFmTEDbTLpVnF21zuxyPg3hLbd6R/2zByzvQi4t1zsQ9jXzTzXbDKJ/XtujThZ3C1pwi
         8X1J8PwDDgzkG5dsNLYHNlcxnwr35eu+1wZw9jUkP7ptShDZpXGbbAqVDgEMHDV2qgPf
         V3MulR+H3iyqipnFk+uLC61TZE2puk2mMDL1LtSy5KMLmWIODPIUIZlvpLgJ61Qhb1KP
         I7IA==
X-Gm-Message-State: AOUpUlHcNv5k4CKBViTmbx62wYL56+fJMzHjWB9BlUs7fjmGd8TahAey
        lDTItIPJ5R6JPwYejsSVXlxvQQ==
X-Google-Smtp-Source: AAOMgpdtefPyp/GU8UVM1Qibzdzv4v8qTYWEUPCZulwMhMepmVmQTPgCPIkNjN/4e4jwXWMtUWYXXQ==
X-Received: by 2002:a62:3cd7:: with SMTP id b84-v6mr3852431pfk.183.1532125227629;
        Fri, 20 Jul 2018 15:20:27 -0700 (PDT)
Received: from ?IPv6:2600:1013:b011:182c:6ca7:9bfd:ed3e:df03? ([2600:1013:b011:182c:6ca7:9bfd:ed3e:df03])
        by smtp.gmail.com with ESMTPSA id 75-v6sm4781756pfr.115.2018.07.20.15.20.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jul 2018 15:20:26 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 1/3] perf/core: Make sure the ring-buffer is mapped in all page-tables
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15G77)
In-Reply-To: <20180720213700.gh6d2qd2ck6nt4ax@suse.de>
Date:   Fri, 20 Jul 2018 12:20:24 -1000
Cc:     Andy Lutomirski <luto@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Brian Gerst <brgerst@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Eduardo Valentin <eduval@amazon.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>,
        "Liguori, Anthony" <aliguori@amazon.com>,
        Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
        Hugh Dickins <hughd@google.com>,
        Kees Cook <keescook@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        "David H . Gutteridge" <dhgutteridge@sympatico.ca>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D89602E9-E620-4AF0-822C-206D7F0BA071@amacapital.net>
References: <1532103744-31902-1-git-send-email-joro@8bytes.org> <1532103744-31902-2-git-send-email-joro@8bytes.org> <CALCETrXJX8tPVgD=Ce41534uneAAobm-HyjeGwVYgJDJ_+-bDw@mail.gmail.com> <20180720174846.GF18541@8bytes.org> <CALCETrUj4cLpOKUbJUfLqKJFkjAgeraE=ORQ-e-bKU+AHda0=Q@mail.gmail.com> <20180720213700.gh6d2qd2ck6nt4ax@suse.de>
To:     Joerg Roedel <jroedel@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Jul 20, 2018, at 11:37 AM, Joerg Roedel <jroedel@suse.de> wrote:
>=20
>> On Fri, Jul 20, 2018 at 12:32:10PM -0700, Andy Lutomirski wrote:
>> I'm just reading your changelog, and you said the PMDs are no longer
>> shared between the page tables.  So this presumably means that
>> vmalloc_fault() no longer actually works correctly on PTI systems.  I
>> didn't read the code to figure out *why* it doesn't work, but throwing
>> random vmalloc_sync_all() calls around is wrong.
>=20
> Hmm, so the whole point of vmalloc_fault() fault is to sync changes from
> swapper_pg_dir to process page-tables when the relevant parts of the
> kernel page-table are not shared, no?
>=20
> That is also the reason we don't see this on 64 bit, because there these
> parts *are* shared.
>=20
> So with that reasoning vmalloc_fault() works as designed, except that
> a warning is issued when it's happens in the NMI path. That warning comes
> from
>=20
>    ebc8827f75954 x86: Barf when vmalloc and kmemcheck faults happen in NMI=

>=20
> which went into 2.6.37 and was added because the NMI handler were not
> nesting-safe back then. Reason probably was that the handler on 64 bit
> has to use an IST stack and a nested NMI would overwrite the stack of
> the upper handler.  We don't have this problem on 32 bit as a nested NMI
> will not do another stack-switch there.
>=20

Thanks for digging!  The problem was presumably that vmalloc_fault() will IR=
ET and re-enable NMIs on the way out.  But we=E2=80=99ve supported page faul=
ts on user memory in NMI handlers on 32-bit and 64-bit for quite a while, an=
d it=E2=80=99s fine now.

I would remove the warning, re-test, and revert the other patch.

The one case we can=E2=80=99t handle in vmalloc_fault() is a fault on a stac=
k access. I don=E2=80=99t expect this to be a problem for PTI. It was a prob=
lem for CONFIG_VMAP_STACK, though.

> I am not sure about 64 bit, but there is a lot of assembly magic to make
> NMIs nesting-safe, so I guess the problem should be gone there too.
>=20
>=20
> Regards,
>=20
>    Joerg
