Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A98C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB38625D3C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RgO/cuxc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB38625D3C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752327AbeFYPtm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 11:49:42 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:37129 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752409AbeFYPtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 11:49:40 -0400
Received: by mail-ot0-f193.google.com with SMTP id u6-v6so7398548otk.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 08:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NoS0ok1bAXskwpovG53rYkrEL1Xt1iCufkDRQQ4sxyQ=;
        b=RgO/cuxcAzcvcvjteTEX92r591rYlFkOCb7wt3WoFC+spYOr2lZY4bgfySqpPljoL/
         3a3SoOsb6V1WaVQluOivW4ZcOhWCk24TbOoaDD0h7kRSYSkevzOgzpiBzXOReCHym7cj
         3UYtFTKx76i1hypyzH7S/aQWKMTT2jfR+AJx6HNoAgAu/02Hd2uzCYpGgLcdTRH/BrTX
         ThhnDk/b3wC/pkKJd8m64ufhfXszMZDRBge7I2XO2+PSsT1GOAr0wuHSYu71yVoiikAk
         eZCQWNTbuEjMqxITmjodM/3JRNFTeNzvC4/58NdO1r4enJIIzgnl63UFB698+Zgh4AM1
         9Xsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NoS0ok1bAXskwpovG53rYkrEL1Xt1iCufkDRQQ4sxyQ=;
        b=EKuJkat4OkgOvaZ/u6NXCdu9UC2KWXLIDiKsvIrwpfTYr77t4uzTR6Fn+Axek1fLYx
         FCDMV4zkd9n2M2Y/c7vTGvCtdTWgPpD9A0tBMCAVlhLj05cwk/NRT8637IQR4qsReI9k
         /RgtBhMnUClVYiSyNtrzFZJn2nuUuhlMoRM0PWHIz95SWhovmlNXhLCYcywhR3rgr3Dg
         a0G/xisUXu4UX8CyGljWeCZX+YG3j9/MlyA96wfC7BFq8XAZ0a1lR8HMt5YNuwCliJmG
         qrIAMCN/UudGInZXxZnxU+7//h+EjuRwT4TE2Ua5KDAEG1I1xHZ6vzT/WuDlho4soY9M
         np9Q==
X-Gm-Message-State: APt69E2bDXITAo6vIwhwcLeRUT2U2nj8FwVNgbCh9eNvZDKeNuHA2XZG
        yVACApbeQf0n33cyO0wMel+SkKeKs4v6oEvbPUa/IzsuDL0=
X-Google-Smtp-Source: ADUXVKJgEUVGUm1E5ywcLzYbMfnUBbtpQdxzftt+OzB0k98NUG+tATBBtUKAh5KcjlO12PA9osW6ynar3LNh0QUsmQo=
X-Received: by 2002:a9d:7608:: with SMTP id k8-v6mr7406369otl.297.1529941779642;
 Mon, 25 Jun 2018 08:49:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAG48ez02K0N6h-nfbnY81QAZoX1_gi4DTxuHxf1bSYiifu2v7g@mail.gmail.com>
 <35b62e21e0de223acae0f9f468212ee9638c3544.camel@perches.com>
 <CAG48ez3ZD3+j2oBJ7XHW9ycbi9_H8QsKGg8A84tOTisjeZGgiw@mail.gmail.com> <8f2948baf460575cde975a2cb5d11b960e8ae30f.camel@perches.com>
In-Reply-To: <8f2948baf460575cde975a2cb5d11b960e8ae30f.camel@perches.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 25 Jun 2018 17:49:28 +0200
Message-ID: <CAG48ez2y_T5RfjF8sjM=vQBzoTBgeXenwMdc=-DB9XE-Vi73-w@mail.gmail.com>
Subject: Re: checkpatch false positive (IMO): typo detected in truncated
 commit message
To:     Joe Perches <joe@perches.com>
Cc:     Andy Whitcroft <apw@canonical.com>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 5:37 PM Joe Perches <joe@perches.com> wrote:
>
> On Mon, 2018-06-25 at 17:32 +0200, Jann Horn wrote:
> > On Mon, Jun 25, 2018 at 5:23 PM Joe Perches <joe@perches.com> wrote:
> > >
> > > On Mon, 2018-06-25 at 17:22 +0200, Jann Horn wrote:
> > > > Hello!
> > > >
> > > > I got the following message from checkpatch:
> > > >
> > > > =======
> > > > $ scripts/checkpatch.pl
> > > > 0001-netfilter-nf_log-don-t-hold-nf_log_mutex-during-user.patch
> > > > WARNING: 'calle' may be misspelled - perhaps 'called'?
> > > > #15:
> > > > Fixes: 266d07cb1c9a ("netfilter: nf_log: fix sleeping function calle[...]")
> > > >
> > > > total: 0 errors, 1 warnings, 0 checks, 20 lines checked
> > > >
> > > > NOTE: For some of the reported defects, checkpatch may be able to
> > > >       mechanically convert to the typical style using --fix or --fix-inplace.
> > > >
> > > > 0001-netfilter-nf_log-don-t-hold-nf_log_mutex-during-user.patch has
> > > > style problems, please review.
> > > >
> > > > NOTE: If any of the errors are false positives, please report
> > > >       them to the maintainer, see CHECKPATCH in MAINTAINERS.
> > > > =======
> > > >
> > > > I believe that it is appropriate here to truncate the commit message
> > > > of the fixed commit.
> > >
> > > It's not.
> >
> > Looking at a bunch of other recent commits, I'm guessing that the
> > accepted format is to use the complete commit message, without
> > linebreaks, even if it goes over 75 columns?
>
> More common is to wrap the commit message on multiple lines.

Really? Even in the "Fixes:" line?

> For instance, the first commit match in -next:
>
> $ git log --format=email --grep=commit -1
> From 1421f2b6b1aac2379844ba27ba09b0dc37ec2daa Mon Sep 17 00:00:00 2001
> From: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Date: Fri, 15 Jun 2018 09:43:47 +1000
> Subject: [PATCH] kernel/kexec_file.c: add walk_system_ram_res_rev()
>
> This function, being a variant of walk_system_ram_res() introduced in
> commit 8c86e70acead ("resource: provide new functions to walk through
> resources"), walks through a list of all the resources of System RAM in
> [...]

I just grepped through Linus' tree for precedent on the "Fixes:" line;
these are the first couple I found:

f5e350f021e04ea41d2e5d58487c33b05ba3d25b: overlong "Fixes:" line
6c6da92808442908287fae8ebb0ca041a52469f4: overlong "Fixes:" line
964d978433a4b9aa1368ff71227ca0027dd1e32f: overlong "Fixes:" line
71c8fc0c96abf8e53e74ed4d891d671e585f9076: overlong "Fixes:" line
b5b7dd647f2d21b93f734ce890671cd908e69b0a: overlong "Fixes:" line

So it looks like the consensus is to use the full commit message
without truncation or linebreaks there?

The first commit I found that wraps the commit message there is
6e88f01206edab0e5bc105d8f35fac10f4ee14c5, from June 8.
