Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB06C7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 20:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23D4220835
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 20:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U1/XKBdO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23D4220835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbeJOD45 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 23:56:57 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:37693 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbeJOD44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 23:56:56 -0400
Received: by mail-it1-f196.google.com with SMTP id e74-v6so24842699ita.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Oct 2018 13:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RAQ38ah8uCjsVHqzg+gh4nwD8zCj5gMLSbXY2BCKheA=;
        b=U1/XKBdO0Vtv5kmRktMewrWS9PdXwME0wFtHkEAjLvEsC7HmxZSHeXUWhvft9SHALi
         vEztysjO0uT87XW3T8OisLxqAiUuRbi+c5XPgiL+MjAGKVG4jpe7LLo2CEvX0cyBjqpm
         55ufkTmEgvL6z1WFbWst6AdKMcE5ls1WvWY+Bfzx4VG6U8BSI0wd2lEgl9HusSagonqW
         RYuxgK/NwN1Ee8jiCiZMPDSwCCpm5GYlPKTv5Jorr7Ro04M8FJxRNM5oplyeDfE1CKV0
         W/UXFQ9Pq4Hw2/7HQrZgAj9RhT14YQFbZmiq3/FVm7OsFF01SfA9XCEEPoqtL85aQbhk
         M3+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RAQ38ah8uCjsVHqzg+gh4nwD8zCj5gMLSbXY2BCKheA=;
        b=gpq2RPwYboyZMwXsp80EmsnKX+lUaZdV7nhrDDhdpDaKzn/H4E87TDvZ5LfLMk4NKg
         NBSK2qjAj2g4DRoUpAAcov19oDEf34Tjxi8zFpau8oNE9zlE+QDdgXKQbn4sgWhX15ei
         L92G/AAOsaeBD7B0rbItBTevipmVWRM+kClsyNAm5YPbOpop9E7/DfIZrX9Owo5rBy+q
         U5QeoVMz/xcIImE/Ml6rHUCJnfp8YCz3u6JJo/vwSkF2laFKCVR5/VDlbkOMKEW3uEZP
         8YnufNHlEs6ms2ErRZ7of6sXv2KlF8ij7aWF5SjlzHf9XPGCCZCWu8dY6fMhBCRnz0oD
         cbrQ==
X-Gm-Message-State: ABuFfogjR+dlSmooJ1BV+hV7RCJpiZuOLXjxT0y/pQZga4o7X0wfrheU
        0JdjJkECjQ3kgK+98nuwr+VdUs6Ynik0EikjZJoQ8w==
X-Google-Smtp-Source: ACcGV60wjXun5WNzE/1FaUp0glfFmRwd9/pBUSPkj/V97LO38MRj3GMXAM3x1996rZyO7pLprzfcbuxRpLZ30DCXo0c=
X-Received: by 2002:a02:85a3:: with SMTP id d32-v6mr11904073jai.69.1539548087190;
 Sun, 14 Oct 2018 13:14:47 -0700 (PDT)
MIME-Version: 1.0
References: <20181014183510.18908-1-ubizjak@gmail.com> <20181014184735.GC7667@zn.tnic>
 <CAFULd4YZyQUjdVbLiM-HUCL_dbvA_oKNhDCXbAKr2L8y0cvSrA@mail.gmail.com> <20181014200241.GD7667@zn.tnic>
In-Reply-To: <20181014200241.GD7667@zn.tnic>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Sun, 14 Oct 2018 22:14:35 +0200
Message-ID: <CAFULd4ZDh5p8MY63-fQLFuXv90k6fa=o+8eP+gcSSND9G1Y0CA@mail.gmail.com>
Subject: Re: [PATCH] x86: Use assembly instruction mnemonics instead of .byte
 streams in arch_hweight.h
To:     bp@alien8.de
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 14, 2018 at 10:02 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Sun, Oct 14, 2018 at 09:15:00PM +0200, Uros Bizjak wrote:
> > The ChangeLog says "real INSTRUCTION mnemonics", e.g. POPCNTQ and POPCNTL.
>
> Right, INSTRUCTION.
>
> > The compiler will generate the register name with the correct implied
> > width (e.g. %rax for long, %eax for int), so the assembler will be
> > able to cross check if operands fit the instruction
>
> The __arch_hweightXX functions already enforce the proper type and
> the inline asm() operands already place the arguments in the proper
> registers where the instruction encoding expects them.
>
> So if you're going to relax this, then you could relax the inline asm
> operand specifications too. I say you "could" because then you need to
> fix arch/x86/lib/hweight.S too, which would be at least ugly. So I think
> we're stuck with %xDI/xAX and %xAX as operands, where 'x' is either 'r'
> or 'e'.
>
> > And there will be a couple of ugly #defines less.
>
> That's the only advantage of this change AFAICT. How about you reflect
> that in your commit message?

No problem, will send v2 with amended message.

Uros.
