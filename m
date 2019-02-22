Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BBCCC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BF8F2070D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eeKYhnTz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfBVXQF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 18:16:05 -0500
Received: from mail-oi1-f170.google.com ([209.85.167.170]:40514 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbfBVXQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 18:16:05 -0500
Received: by mail-oi1-f170.google.com with SMTP id x187so3044162oia.7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 15:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WA7a8Tig35fwhiePq7ZsZn3hoNzg95mIUWl671WDye0=;
        b=eeKYhnTz/DcDsrN2W02MRtuYPP9qEYdLRASOa8ZvIojjjhx+gpKTvFI40avoza9PBb
         EgzSXzQ4wvKKlO0CbZeJAF1mZBFfH1RJcRjAT8L218esAs6Y+4RFB6HWCRbVfJ6qg/7E
         opWA1k1ZGZdxYz3xcPir0vY1FUpI4GdbVwouEaMxPj83bHCRJj1HL7Q4o9dkVrNYDfjg
         9zomqEtsIcWHOm/umUlbq7y0wN9P+kAx03mWQbUST4p0E+QQS9jI6SA6OR3POisQUDj8
         RuoCnPdvPLrVgs4QIyt1uyuh2WaQRnL9j8mEENll+TG0QNG9Hm5jxE07XDvkIueokahA
         ZVGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WA7a8Tig35fwhiePq7ZsZn3hoNzg95mIUWl671WDye0=;
        b=GutlKDGMph2Qy9TAnIRLl+RR538g9ylo4maWgLA1IMoRKafoy9o7Wc/LR2BcX6MuPH
         XfR603IJgNovIE9SCLbMMo0KE8qNHIuUvY24eulm6Hzt2yR87mRySytoRDVCqco5691C
         FMDlCTxcpEYPMDd724olwhTQthuqt+0bicMWGLqvo8kTUj05r99QVEAXAYLRKIB0huKf
         BUAnq3d9amQpuVuihceGed+20caHSqaKb6L8m8Xe9O/FWzCTGZe0v5HN8n4Qv8e4q+Cz
         gmUeFS2ZH6o9Pz6JX0OlU7UK1XZQy+wMig4K8cctkpOG01+NkCBYfWPsIPYUDdRGzvmS
         1B/A==
X-Gm-Message-State: AHQUAuYplmCcuJiNY7VcJYOmerLMkfagVeQjMgqTsmGxmRR4TlqWabCw
        dE1kwSqIe8Ij/UKQp/dzOI2SGixnaIqXXurauA0BnQ==
X-Google-Smtp-Source: AHgI3IYCUzy6F1xAfjCCfg592pXttzHLFRoXhpSuvMiIH1X6O7oFGxjTvQfENFdjCreU4rv71gXJy1DQrUtbHUVaXd0=
X-Received: by 2002:aca:cc4d:: with SMTP id c74mr4177135oig.157.1550877364354;
 Fri, 22 Feb 2019 15:16:04 -0800 (PST)
MIME-Version: 1.0
References: <20190221133556.eqzclahgngq53s64@inn2.lkp.intel.com>
 <cdd8143b-7719-b51e-5a6a-6bdc065cc773@iogearbox.net> <14415.1550875312@turing-police.cc.vt.edu>
In-Reply-To: <14415.1550875312@turing-police.cc.vt.edu>
From:   Jann Horn <jannh@google.com>
Date:   Sat, 23 Feb 2019 00:15:38 +0100
Message-ID: <CAG48ez009feoF9=AwQ1qHSnuXeFJnAsHREmtrT-+HgPueytyCw@mail.gmail.com>
Subject: Re: [bpf] 568f196756: BUG:assuming_atomic_context_at_kernel/seccomp.c
To:     Valdis Kletnieks <valdis.kletnieks@vt.edu>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        kernel test robot <lkp@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, lkp@01.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 11:42 PM <valdis.kletnieks@vt.edu> wrote:
>
> On Thu, 21 Feb 2019 14:39:27 +0100, Daniel Borkmann said:
> > Fyi, false positive and already fixed in bpf-next.
> >
> > (https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit/?id=435b3ff5b08a99a15647be32735abf8db66cea9a)
>
> Is there a reason this commit appeared in next-20190221 but did not seem to be
> in next-20190222 (confirmed via 'git tag --contains')?
>
> [/usr/src/linux-next] git tag -l next-20190222
> next-20190222
>  [/usr/src/linux-next] git tag --contains 435b3ff5b08a99a15647be32735abf8db66cea9a
> next-20190221
>
> (I went ahead and 'git cherry-pick -n' it on top of 0222)

It was reverted by ast@, he wanted to fix it in a different way:
https://lore.kernel.org/netdev/20190221192916.2mcd4fmxbdj2j2u3@ast-mbp.dhcp.thefacebook.com/
