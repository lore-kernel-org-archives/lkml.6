Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2ACFC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 20:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D5DF218F0
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 20:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KD3gCJPm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731488AbfBAU2R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 15:28:17 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:32863 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727935AbfBAU2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 15:28:15 -0500
Received: by mail-it1-f195.google.com with SMTP id m8so5873960itk.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 12:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+xJgRBWrO4u3UVM+/vTwAue1laEzjseGMoWnH/BLjic=;
        b=KD3gCJPmhAuu2EpmLSnleLLVU7EUCilgQULU6n84IkTlKG4iG1lJrFoCbBc17iQmZ5
         A4qk+YEzOaPQkVzy2TUUXDvYKRR4Mx0a+QEepcJEFPgOcPDcdY5jAva2bV00oygWpy9i
         0BntrIL6s8NWCuNdkdOlvOC3yfy617L+wlfDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+xJgRBWrO4u3UVM+/vTwAue1laEzjseGMoWnH/BLjic=;
        b=RewAaRCcn5C+swKyvbYZ9c10RdDWEMdPdv6HwMKehuLoSHWEDTrUzp90MDQLFlDVsd
         uwdILZ9tZcUzzJ+xoriUbvpMNeeJhs4iqSaZ3qPE2VytBjzVpKkS4FhKqftfmGk3xaZ0
         6BTdQoodWOKWogmZPvmDStoeq5B0SwI1wp3UzWsO6E3nIaqy3jtntQhhwseC5D317J1q
         8/fYbjry/oL1eHJKcj3ZyIX7jq3QbzcyrAKlFnYXdLPatbfrOSEwD6X65j3kusZERwkt
         yCtjaUuwyxcFH35WR9zoxFciw3bQGQZojTJa9pni5QyiuVtwXXabOwM1arrGZPJ9SKjQ
         ezuQ==
X-Gm-Message-State: AHQUAuazwnjgVKNW2RDgEcUv7L8POCbYMurUR1XVQzLlmW34Lgt8hq4C
        5ME4gLC4Bw9FmeWPaLfLmQ/4cxHwb/0=
X-Google-Smtp-Source: AHgI3IaTPB5QfZGRQRp8Y9P8Ghl/iR8PiGJpMdgTpRLGft4SfjCnDrufKvG4hHSBEarpkVYjPchdRQ==
X-Received: by 2002:a24:2e94:: with SMTP id i142mr2833885ita.157.1549052894932;
        Fri, 01 Feb 2019 12:28:14 -0800 (PST)
Received: from mail-it1-f178.google.com (mail-it1-f178.google.com. [209.85.166.178])
        by smtp.gmail.com with ESMTPSA id e10sm3681398ioa.65.2019.02.01.12.28.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 12:28:14 -0800 (PST)
Received: by mail-it1-f178.google.com with SMTP id z7so11291631iti.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 12:28:14 -0800 (PST)
X-Received: by 2002:a24:4d05:: with SMTP id l5mr2628668itb.147.1549052516512;
 Fri, 01 Feb 2019 12:21:56 -0800 (PST)
MIME-Version: 1.0
References: <20190131192533.34130-1-thgarnie@chromium.org> <20190131192533.34130-21-thgarnie@chromium.org>
 <CALCETrVcU_9cczwbfVg6E2cey5B8O9k4j+jYgp0T-CiX9HELtA@mail.gmail.com>
In-Reply-To: <CALCETrVcU_9cczwbfVg6E2cey5B8O9k4j+jYgp0T-CiX9HELtA@mail.gmail.com>
From:   Thomas Garnier <thgarnie@chromium.org>
Date:   Fri, 1 Feb 2019 12:21:44 -0800
X-Gmail-Original-Message-ID: <CAJcbSZH3-TVxDsoRLKSuFLU2bHVV9FgDXtUaZFMim3k+4QU8Cg@mail.gmail.com>
Message-ID: <CAJcbSZH3-TVxDsoRLKSuFLU2bHVV9FgDXtUaZFMim3k+4QU8Cg@mail.gmail.com>
Subject: Re: [PATCH v6 20/27] x86: Support global stack cookie
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Juergen Gross <jgross@suse.com>,
        Joerg Roedel <jroedel@suse.de>,
        Jia Zhang <qianyue.zj@alibaba-inc.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 1, 2019 at 11:27 AM Andy Lutomirski <luto@kernel.org> wrote:
>
> On Thu, Jan 31, 2019 at 11:29 AM Thomas Garnier <thgarnie@chromium.org> wrote:
> >
> > Add an off-by-default configuration option to use a global stack cookie
> > instead of the default TLS. This configuration option will only be used
> > with PIE binaries.
> >
> > For kernel stack cookie, the compiler uses the mcmodel=kernel to switch
> > between the fs segment to gs segment. A PIE binary does not use
> > mcmodel=kernel because it can be relocated anywhere, therefore the
> > compiler will default to the fs segment register. This is fixed on the
> > latest version of gcc.
>
> I hate all these gcc-sucks-so-we-hack-it-and-change-nasty-semantics
> options.  How about just preventing use of both stack protector and
> PIE unless the version of gcc in use is new enough.

So fail the build in this scenario?

>
> Also, does -mstack-protector-guard-reg not solve this?  See
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=81708.  Or is there
> another bug?  Or are you worried about gcc versions that don't have
> that feature yet?

I am worried about gcc versions that don't have this feature, yes.
