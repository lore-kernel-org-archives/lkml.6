Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F18C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 22:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A28420665
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 22:37:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t6vCh9lE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729848AbfAHWhw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 17:37:52 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43191 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728617AbfAHWhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 17:37:51 -0500
Received: by mail-pf1-f196.google.com with SMTP id w73so2604719pfk.10
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 14:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=G+t/O1ELjBLEBBBsDmJXREgcMLTIWAYtBGNLhxBHo08=;
        b=t6vCh9lEnH2SNgS8RuQ8h56OJCXt5sxw1vDNhObrCk7bZ6ugFb6FGLoSeLEThy1F+v
         NXaRPTTDqw8mz7Q63gLjusueIN7uwXQdedqn8i6la/+CJqwg4lxoU/n2f5rgxPvWCNIg
         5ZNK9dRjJoYIVHZ1+jO8jb4IYuedj/nEXmskeH+v6XjMbo3gydDcEeRlZTnLNkIMrLnQ
         +OzjhUTa5oGoo1/HxtzupxnftQuUWEEItZCDs9j1cxf/mNoOpl3vIxlDf+fnkbXu5sPp
         jCZuh/ZRfvgtwtmVp5maapI1pLaMCAcNcnhoW2qc63sjkiM/eAwfo/DRnn0pgswp9Q94
         dhGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=G+t/O1ELjBLEBBBsDmJXREgcMLTIWAYtBGNLhxBHo08=;
        b=E5KOdu4LIqh+VVXe6ZdfDNR5QapOQmZwCne3lkcMhlbWnhqGBat0YVn7weeeV3xRq2
         qHpMYjK5jlXTvCL2AEBQMXkX/a10epKJnRLAta1ZMMA0ghjrYDCFXzKJUWDyn8YsKZGE
         pLdVFLoKXfChSYC31YFBe7va+F0OHDSp2xjiafccQWE+z+oEMz6VB6ktymWGrbo4cubi
         cs0kOzu4/RwKPSKPuG3XB/gyMh1upKpkjioluA+0It0rKOtfpH43oAtXxVFuEWWuzlzw
         jgh3nrlCu1DVlM4zH/s3JQOB89W0kfuF7SrqaF7pgFH9aUdldIqr8zkAcjC2158c60ce
         DrXg==
X-Gm-Message-State: AJcUukdDLA1DGjlDOXXmba7Kh5IhRsXBy/DixZrQfajvtkXbqgro0Und
        S0SGxyOCVjh7PMuu2kh1FeE=
X-Google-Smtp-Source: ALg8bN5LFbZGlr2Dk/dwPqacRhGe3pspmn0Hnf+SvFv5XGcz6c4wCbI3/eOlPdaM5o/HVIUndggsRg==
X-Received: by 2002:a63:a112:: with SMTP id b18mr3193252pgf.440.1546987070352;
        Tue, 08 Jan 2019 14:37:50 -0800 (PST)
Received: from localhost (g206.124-44-15.ppp.wakwak.ne.jp. [124.44.15.206])
        by smtp.gmail.com with ESMTPSA id d25sm113129172pfe.40.2019.01.08.14.37.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Jan 2019 14:37:49 -0800 (PST)
Date:   Wed, 9 Jan 2019 07:37:48 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        openrisc@lists.librecores.org
Subject: Re: [PATCH] arch/openrisc: Fix issues with access_ok()
Message-ID: <20190108223748.GR3235@lianli.shorne-pla.net>
References: <20190108131516.27903-1-shorne@gmail.com>
 <CAHk-=whR9UX8wG0CKp87sNQkNdtMPVmAmi-gjGRwWTYYAJ9v_w@mail.gmail.com>
 <CAHk-=wic8HES0M_KgB3Tfaufb36r42ZKw4a0t96Xq_efCoR02Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wic8HES0M_KgB3Tfaufb36r42ZKw4a0t96Xq_efCoR02Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 10:16:39AM -0800, Linus Torvalds wrote:
> On Tue, Jan 8, 2019 at 10:10 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Tue, Jan 8, 2019 at 5:15 AM Stafford Horne <shorne@gmail.com> wrote:
> > >
> > > The commit 594cc251fdd0 ("make 'user_access_begin()' do 'access_ok()'")
> > > exposed incorrect implementations of access_ok() macro in several
> > > architectures.  This change fixes 2 issues found in OpenRISC.
> >
> > Looks good to me. Should I apply this directly, or expect a pull
> > request with it later?
> 
> Oh, and replying to myself with a quick note: it might also be a good
> idea to just make it an inline function.
> 
> The only reason I did alpha and SH as those macros with a statement
> expression was that because I don't have a cross-build environment,
> continuing to do it as a macro was the safest thing from a build
> standpoint.
> 
> One big difference between a macro and an inline function is that the
> inline function requires everything to be declared at the point of the
> function definition, while the macro can use things that get declared
> only later (like "get_fs()"). So a macro can use functions and other
> macros that aren't declared yet, but will be declared by the time the
> macro is actually _used_.
> 
> So when changing the macro "blind", it was simply safer to just keep
> it a macro and just make it a bit more complex. But since you can
> build-test your changes, making (for example) __range_ok() be an
> inline function might have been the cleaner solution to the "use
> twice" issue.
> 
> But your existing patch looks fine to me too, so don't worry too much
> about it. I just wanted to point out that the reason I did alpha and
> SH the way I did was not some "macros are better", but rather "Linus
> is weak and lazy".

Hi Linus,

Please take this patch directly.

The inline's are a good point.  I will take some time to address this and some
other cleanups.

Note (for others) I had to apply patches from Masahiro Yamada to test this as
v5.0-rc1 build was broken for OpenRISC.  Those patches are already on Linus'
master.

-Stafford
