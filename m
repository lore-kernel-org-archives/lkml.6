Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA44BC43382
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 21:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FDC920C0A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 21:43:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ag7C++pz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FDC920C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbeIYDrX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 23:47:23 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33837 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbeIYDrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 23:47:23 -0400
Received: by mail-pg1-f194.google.com with SMTP id d19-v6so9894253pgv.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 14:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MZ/wHdnaPG7c0PMmxvJ1i/rjMvQ196LVFVHt8ececvA=;
        b=ag7C++pzJCeJm56BYkYS9BdSLIvmJfcTpomaAyJkzhSBp3CNPgb684t6YRk3vIeyWX
         pS+tfVTPpxyx2881OwmwVkhwH1iayE/YHAMd34TSzgDlTdRE2UjPuveJd04dHoReBNBt
         L7x3ajSjfiHa7EQ4wek2Nyvd5TNt0SJzXZkuEjULo4qDxN8vm3OdPoiEIhdqEynjkRLJ
         XncmEh8PiaN8XFV89vDooDhHtjXaKrlRQOhAXMiQXGifdO667aQ/c3oU0N+8NnsrEzTB
         jRkx1oOrXaYMcdDQNvnsJuvNAOxryQNAPupLgKoip//8T2ad9hlvfNxbrKyH592R4+iQ
         MVXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MZ/wHdnaPG7c0PMmxvJ1i/rjMvQ196LVFVHt8ececvA=;
        b=Hq4tL7iKGt+4u83zPuNl4Z9oa+TPlzJBwqR+4rkv6Vsbcbsm7NFGCxGeoridSMW82I
         Ul+HnD1Fef90hK39IRNY7eJ64BFRNasagQMxopHyPK7YQah03mLWbGJpBMt4d0Ez/LNp
         aXCzxbstVODVnKg8OSOJQb3h6MnpQK9hrV30aBLvKbKT2DDa/189mrE17pEpDVnZF2Lt
         dTTxeDiTDOb7Vx4u5kPFNELBrhF2ZEco8E89s3p+kblFZij2oTvA+QjTv10+LIRm6T2T
         H9fa42u14EL14qePtfia5TIK9QbasFIoBXQNP+qb0iEpEq8za8+zt4ikGaLJCXlSfevN
         LgRg==
X-Gm-Message-State: ABuFfojgYc7n8mbE7s25Yjfo+YCoW2PauGu7ZZNoW31I5LlRNt63cPJQ
        2YHZW0bjYrVQM8xvmQb25c9gC0TND0zLpCKgZDZOIw==
X-Google-Smtp-Source: ACcGV63vw8I9d0BxIq/FiCWaRCbaj3HdgRDRHgG6uZAQh1ef+2hyohYI0XWPuzxbRf3HnRIEtQKR/U5Jr/fdTa7gxN0=
X-Received: by 2002:a62:4b14:: with SMTP id y20-v6mr581091pfa.93.1537825387688;
 Mon, 24 Sep 2018 14:43:07 -0700 (PDT)
MIME-Version: 1.0
References: <20180924172615.25591-1-natechancellor@gmail.com>
 <33c9afa7-ea62-1248-1da4-381f93238627@amd.com> <20180924194040.GA17672@flashbox>
 <9cbc1f67-719e-de75-8b0c-2de4da71b2f8@amd.com>
In-Reply-To: <9cbc1f67-719e-de75-8b0c-2de4da71b2f8@amd.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 24 Sep 2018 14:42:56 -0700
Message-ID: <CAKwvOdkOp5eV-o9++y=5b=5NS4fG_snT3OA8DGBnsZWtD60cUA@mail.gmail.com>
Subject: Re: [PATCH] crypto: ccp: Remove forward declaration
To:     ghook@amd.com
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Thomas.Lendacky@amd.com, Gary.Hook@amd.com,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-crypto@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 2:22 PM Gary R Hook <ghook@amd.com> wrote:
>
> On 09/24/2018 02:40 PM, Nathan Chancellor wrote:
> > On Mon, Sep 24, 2018 at 07:18:23PM +0000, Gary R Hook wrote:
> >> On 09/24/2018 12:26 PM, Nathan Chancellor wrote:
> >>> Clang emits a warning about this construct:
> >>>
> >>> drivers/crypto/ccp/sp-platform.c:36:36: warning: tentative array
> >>> definition assumed to have one element
> >>> static const struct acpi_device_id sp_acpi_match[];
> >>>                                      ^
> >>> 1 warning generated.
> >>>
> >>> Just remove the forward declarations and move the initializations up
> >>> so that they can be used in sp_get_of_version and sp_get_acpi_version.
> >>
> >> I'm not going to out and out object to this just yet.
> >>
> >> I am not a clang expert. Can you please provide a make command that
> >> would explain how you precipitated this complaint?
> >>
> >
> > Hi Gary,
> >
> > I can produce the warning with Clang 6.0 using the following set of
> > commands:
> >
> > make ARCH=arm64 CC=clang CROSS_COMPILE=aarch64-linux-gnu- allyesconfig
> > ./scripts/config -d CONFIG_CPU_BIG_ENDIAN
> > make ARCH=arm64 CC=clang CROSS_COMPILE=aarch64-linux-gnu- olddefconfig
> > make ARCH=arm64 CC=clang CROSS_COMPILE=aarch64-linux-gnu- drivers/crypto/ccp/sp-platform.o
>
> No, I"m not getting a warning on my system. I get this:
>
> ghook@taos:~/src/cryptodev-2.6/src$ make ARCH=arm64 CC=clang
> CROSS_COMPILE=aarch64-linux-gnu- CFLAGS=-v
> arch/arm64/Makefile:27: ld does not support --fix-cortex-a53-843419;
> kernel may be susceptible to erratum
> arch/arm64/Makefile:40: LSE atomics not supported by binutils

./scripts/config -d CONFIG_ARM64_LSE_ATOMICS

> arch/arm64/Makefile:48: Detected assembler with broken .inst;
> disassembly will be unreliable
>    CALL    scripts/checksyscalls.sh
>    VDSOA   arch/arm64/kernel/vdso/gettimeofday.o
> arch/arm64/kernel/vdso/gettimeofday.S: Assembler messages:
> arch/arm64/kernel/vdso/gettimeofday.S:28: Error: no such instruction:
> `vdso_data .req x6'
> arch/arm64/kernel/vdso/gettimeofday.S:29: Error: no such instruction:
> `seqcnt .req w7'
> arch/arm64/kernel/vdso/gettimeofday.S:30: Error: no such instruction:
> `w_tmp .req w8'
> ...
>
> The only reason I bring this up is that it would be helpful to be able
> to recreate results. I figure I'm not set up for this.
>
> That said... please see my response to Nick.



-- 
Thanks,
~Nick Desaulniers
