Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF007C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 20:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F36B2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 20:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544645356;
	bh=Up4QSoGGtDSeM9LKvXeYN0szRM/NuBsJRcn32KRHA9g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=pmds6F0cdN+HkscS5aunj43Ne5zodR8aaEaZHh10LRZ2Jsew+frVKmsIUluncz6Yy
	 flLy2b0x4Gk0HR0IpYSK6FzrLH7GbUl32BzXEcaOmv/bHOT2X8tGRubOQWHAM0a+gv
	 sbifouUeVZGvUXejELuIFOhg99pvruXoR7S1lHJs=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F36B2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbeLLUJP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 15:09:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:48034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbeLLUJO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 15:09:14 -0500
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09C8A20873
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 20:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544645354;
        bh=Up4QSoGGtDSeM9LKvXeYN0szRM/NuBsJRcn32KRHA9g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ylT647h2lU5ShSs5JQqe3zpQUtUHp+akfSFl6OoGHNzSuJCVXY8OaYjX282MyhtIc
         n5xTMz4/3WAWC6+VtOsvUPIamHxk8KNNuq3q8u5/oGLJlocC3tGc1GpFUQ9NtDYTpR
         LbxCWO0FO1WkfckGeDM5XszMVtZvzy003M56BSlM=
Received: by mail-wr1-f51.google.com with SMTP id u3so18989695wrs.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 12:09:13 -0800 (PST)
X-Gm-Message-State: AA+aEWYE2FRUWmuqP39NqT6F1qEsAMyOxWayP0P/IPdCt8T1lqlA2yoT
        jRWfh0AHzfT/sP7PztBYVzDyghBqEsspjABmZnt/eg==
X-Google-Smtp-Source: AFSGD/UT41J+eXuJxOLja786KsvRF5E8tXo/3dNvNewDKZ5xUEwQElBthbA+zv82U4erNwwmsRVXjn78QHuwUiMqlwc=
X-Received: by 2002:adf:e08c:: with SMTP id c12mr17509289wri.199.1544645352500;
 Wed, 12 Dec 2018 12:09:12 -0800 (PST)
MIME-Version: 1.0
References: <20181211222326.14581-1-bp@alien8.de> <20181211222326.14581-5-bp@alien8.de>
 <CALCETrVArfAAbQKJ-g_5pOy6dMVgx-FC_mjdC9xzL1jU9T07jw@mail.gmail.com>
 <59aad362-4a5b-dd8b-642f-0dc3f83cf7ee@amd.com> <20181211233901.GV27375@zn.tnic>
 <CALCETrXvZ4avdUh2bTLVTTz3Jxogo3zK5akWTsJ=rkJpf1XiDg@mail.gmail.com>
 <20181212100814.GB6653@zn.tnic> <CALCETrWSG5825HrxwEJGqbSoRz=A_2O-GSBD+K_q9YPHu2TB6A@mail.gmail.com>
 <20181212184459.GE6653@zn.tnic> <CALCETrXcBa3eUN2okedig+sECnQ8zuSWojahqWLR4vWqD8mEhg@mail.gmail.com>
 <20181212200005.GF6653@zn.tnic>
In-Reply-To: <20181212200005.GF6653@zn.tnic>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 12 Dec 2018 12:09:00 -0800
X-Gmail-Original-Message-ID: <CALCETrWnYT1P0yPRkbubigvYRxesqYi4OJV-YxO9jzWqgCJBdg@mail.gmail.com>
Message-ID: <CALCETrWnYT1P0yPRkbubigvYRxesqYi4OJV-YxO9jzWqgCJBdg@mail.gmail.com>
Subject: Re: [RFC PATCH 4/4] x86/TSC: Use RDTSCP
To:     Borislav Petkov <bp@alien8.de>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 12:00 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Wed, Dec 12, 2018 at 10:50:30AM -0800, Andy Lutomirski wrote:
> > As far as I know, RDTSCP gets the job done, as does LFENCE, RDTSC on
> > Intel.
>
> Same on AMD when LFENCE has been made dispatch-serializing.
>
> > There was a big discussion a few years ago where we changed it
> > from LFENCE;RDTSC;LFENCE to just LFENCE;RDTSC after everyone was
> > reasonably convinced that the uarch would not dispatch two RDTSCs
> > backwards if the first one was immediately preceeded by LFENCE.
>
> Yeah, the second one won't pass the LFENCE so you won't see time going
> backwards, sure.
>

Also that the uarch doesn't turn:

LFENCE
RDTSC
load some memory

into a load followed a cycle later by RDTSC.  If that happened, then
some cooperating CPUs could observe time going backwards.

But RDTSC has no dependencies, so, barring odd register renaming
effects or similar, this isn't going to be a problem in practice.
Also, the actual clock reading code is complicated enough that we have
several cycles of wiggle room :)
