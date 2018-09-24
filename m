Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C1BC43382
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 21:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A3232098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 21:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bl6u0aX3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A3232098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbeIYDsq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 23:48:46 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34943 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbeIYDsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 23:48:45 -0400
Received: by mail-wm1-f66.google.com with SMTP id o18-v6so11544650wmc.0;
        Mon, 24 Sep 2018 14:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7zKE30QQ0vHAE8ldty1xGeIpWSnXRlKdIlGk716QWrQ=;
        b=bl6u0aX3QTGRMy0daFI4Vj6Bxb4md24bNWzehv2OV3YwZzAZCqoTw0IzQRq12llZK1
         1FLA9yYXEbTeVNBYJa81Q9wzw0bO70BxwDBCB6IT0D/2xz1mH+JUFkN7SI0QDvtEQTmt
         c0cdd96lBU3JXiW+IP2shNvtsrYpVXKRYAwkPZKHzJyNL6Lbh6yWsKfBEEUKQoSbc8U2
         7ZJmbKsBfnTnLQwjAEzOG1XSS+cWkkEWA7nR2D7WdBAfV9pdx4NO842n3U0xY47EMOZJ
         yzJRQETdwEC3mZOfkXfYjqSOIop0aHEVSDGBNlN7mpgo+tTz4wGdFB+JA0LLg+ERS6di
         XVcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7zKE30QQ0vHAE8ldty1xGeIpWSnXRlKdIlGk716QWrQ=;
        b=XaPzI5w+Lik1W0oKy4eRgDpQ8CDDoLtLU5MhkwZ9OHjb8myfw5S3si7V6HI04O3ZSF
         /KpK7QAxQIAjdU5Qd2IH7gmWRcUaxD9UJSzGC/nzMngodkpurnmrpcpULdk0oGEkJYjV
         JGIOn8DKsSsomOJTHBsFvmQLVwh+C5QHjxeYsV2a661YZUEIIjnGI3SGDDhRJIjVvW60
         aL0xSsWfe3KhmLgZRJnm1GN3b6um7bOaIPsQ2vIbuSm8L8fg9caTpq9Re1/nc/qyRXqV
         otqsKxGA6djEEAfM/ukOmHbioi19wmJc6j9n1kv1xI33OqFdiRlsRpwsNFXS+szZs1jo
         Li3w==
X-Gm-Message-State: ABuFfogvtkGGFyMHQyWGgGbpmSfVjHGT3AVxLTGWPw56OjxmTfaE09u/
        Vc8bO9y/PVOsLDLkaL8bgJo=
X-Google-Smtp-Source: ACcGV62rVUmgAjg9fz/haQTikWOIqsIfWmHH/BoiLfcEbWTI7aJTP/wMKZYEO5dISV/b5ir9o3WFng==
X-Received: by 2002:a1c:a386:: with SMTP id m128-v6mr159894wme.139.1537825468135;
        Mon, 24 Sep 2018 14:44:28 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id m68-v6sm387828wmb.10.2018.09.24.14.44.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 14:44:27 -0700 (PDT)
Date:   Mon, 24 Sep 2018 14:44:25 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     ghook@amd.com, Thomas.Lendacky@amd.com, Gary.Hook@amd.com,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-crypto@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] crypto: ccp: Remove forward declaration
Message-ID: <20180924214425.GA22651@flashbox>
References: <20180924172615.25591-1-natechancellor@gmail.com>
 <33c9afa7-ea62-1248-1da4-381f93238627@amd.com>
 <20180924194040.GA17672@flashbox>
 <9cbc1f67-719e-de75-8b0c-2de4da71b2f8@amd.com>
 <CAKwvOdkOp5eV-o9++y=5b=5NS4fG_snT3OA8DGBnsZWtD60cUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdkOp5eV-o9++y=5b=5NS4fG_snT3OA8DGBnsZWtD60cUA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 02:42:56PM -0700, Nick Desaulniers wrote:
> On Mon, Sep 24, 2018 at 2:22 PM Gary R Hook <ghook@amd.com> wrote:
> >
> > On 09/24/2018 02:40 PM, Nathan Chancellor wrote:
> > > On Mon, Sep 24, 2018 at 07:18:23PM +0000, Gary R Hook wrote:
> > >> On 09/24/2018 12:26 PM, Nathan Chancellor wrote:
> > >>> Clang emits a warning about this construct:
> > >>>
> > >>> drivers/crypto/ccp/sp-platform.c:36:36: warning: tentative array
> > >>> definition assumed to have one element
> > >>> static const struct acpi_device_id sp_acpi_match[];
> > >>>                                      ^
> > >>> 1 warning generated.
> > >>>
> > >>> Just remove the forward declarations and move the initializations up
> > >>> so that they can be used in sp_get_of_version and sp_get_acpi_version.
> > >>
> > >> I'm not going to out and out object to this just yet.
> > >>
> > >> I am not a clang expert. Can you please provide a make command that
> > >> would explain how you precipitated this complaint?
> > >>
> > >
> > > Hi Gary,
> > >
> > > I can produce the warning with Clang 6.0 using the following set of
> > > commands:
> > >
> > > make ARCH=arm64 CC=clang CROSS_COMPILE=aarch64-linux-gnu- allyesconfig
> > > ./scripts/config -d CONFIG_CPU_BIG_ENDIAN
> > > make ARCH=arm64 CC=clang CROSS_COMPILE=aarch64-linux-gnu- olddefconfig
> > > make ARCH=arm64 CC=clang CROSS_COMPILE=aarch64-linux-gnu- drivers/crypto/ccp/sp-platform.o
> >
> > No, I"m not getting a warning on my system. I get this:
> >
> > ghook@taos:~/src/cryptodev-2.6/src$ make ARCH=arm64 CC=clang
> > CROSS_COMPILE=aarch64-linux-gnu- CFLAGS=-v
> > arch/arm64/Makefile:27: ld does not support --fix-cortex-a53-843419;
> > kernel may be susceptible to erratum
> > arch/arm64/Makefile:40: LSE atomics not supported by binutils
> 
> ./scripts/config -d CONFIG_ARM64_LSE_ATOMICS
> 

D'oh, I keep forgetting to update my gist with my commands...

Thanks!

> > arch/arm64/Makefile:48: Detected assembler with broken .inst;
> > disassembly will be unreliable
> >    CALL    scripts/checksyscalls.sh
> >    VDSOA   arch/arm64/kernel/vdso/gettimeofday.o
> > arch/arm64/kernel/vdso/gettimeofday.S: Assembler messages:
> > arch/arm64/kernel/vdso/gettimeofday.S:28: Error: no such instruction:
> > `vdso_data .req x6'
> > arch/arm64/kernel/vdso/gettimeofday.S:29: Error: no such instruction:
> > `seqcnt .req w7'
> > arch/arm64/kernel/vdso/gettimeofday.S:30: Error: no such instruction:
> > `w_tmp .req w8'
> > ...
> >
> > The only reason I bring this up is that it would be helpful to be able
> > to recreate results. I figure I'm not set up for this.
> >
> > That said... please see my response to Nick.
> 
> 
> 
> -- 
> Thanks,
> ~Nick Desaulniers
