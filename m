Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B8BC04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1454F20660
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:58:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b8jq4ugW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1454F20660
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbeLDQ6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 11:58:40 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:54260 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727293AbeLDQ6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 11:58:37 -0500
Received: by mail-it1-f193.google.com with SMTP id g85so16491091ita.3;
        Tue, 04 Dec 2018 08:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IajMFN6Ort/d7StaYxafHcMyREqwcvnTcj/7voIaHxo=;
        b=b8jq4ugWLY6Qw+kN3/ba6ylV1g71EUBOne+PCrgMzyjHectMZuGI0leSNf5uMlvCb7
         HLuPyTF2sasTaMK6qko2IqF0k5HJtV9MJo9AA2sau+DveHZYHew8/K6lDcwouUqdF9Fp
         bL/9Cmpsw97NjzdyGTC3zC0LkeHH8L0oYjw2zxsLextsYmseqUOE5hT/4yNFg3OkPozn
         weIPUUvVPeuJmH2UZSsnov61zof6p7pFKs0kHga0GOd9rC/BPAOdu2pXvSKyzdQsDhJ+
         8xtU9/gNPis/l3GgTukyoPtAzmqiAFV6ilshCalUyyYZqkCLW+joxwh9+GK16Rns187+
         gajg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IajMFN6Ort/d7StaYxafHcMyREqwcvnTcj/7voIaHxo=;
        b=mgx8CBbooLcPL/nmYJ5OgkDOODKacEyH7xjQQT+osOM0uwQGGz8GhNfVWoU2+VHT5s
         3GbyzxcVN1Dti/2KUdWU6OMI/TKDYM9h0PY2vY1iH6SlA2TGSMQJOci8p2r36cb2xtYK
         w3JkMnzyq+YzpihYXo96ZTaLovkAzkQr7N8ADZSZyn0BLyyRgO6J0v4G7kN2PXQZwWgK
         GahVqj4dmllQUwflfXaGxxfKNAmnuAO7cs0bzACzbhT32thvZZXqo86WbgS3qU9xeQ3a
         xtnXoPo5MHBS0o1jEep8FTp34UXnIl1lRURGpqTKqJr/WdBvzPDZBNgUpzsuzEKk4IZG
         77dg==
X-Gm-Message-State: AA+aEWZwHK/3d48zNizyxaMgBbhyj0I0KVgEURbN50eueUUEAW+yJ9PY
        9hmEveDyeXpfyUCZm2EbVxb3c7s/UtUa0kDQKbn81WcV0o0=
X-Google-Smtp-Source: AFSGD/VGEE6HW+JGvznIpDDj/fiiK/PLznJRKUvWsesE/Os/RTB4FfbJKhcAQpKh4XXbL7lx7fqJ6sJpra4CfrshFvA=
X-Received: by 2002:a05:660c:250:: with SMTP id t16mr11725914itk.78.1543942716774;
 Tue, 04 Dec 2018 08:58:36 -0800 (PST)
MIME-Version: 1.0
References: <20181201155229.8532-1-tiny.windzz@gmail.com> <CAHp75VdEbr9YfaCgHXNqScZC-KMobF2fU8rZb29nhZPBJvm2gg@mail.gmail.com>
 <CAEExFWvRFrS-ZTSkrS5Npe7g-rxtxfCfk+AyTz00Lx4oAWhQ_g@mail.gmail.com>
 <CAHp75VcSVEakAK4MeoG8zA7MaCWNoL2fOr48iFmxTsjbBpa5XA@mail.gmail.com>
 <CAEExFWtE7Yi8D+Dr=J7B3zqBRet0AX=ABHnUrJkZ2LO3aHdNeg@mail.gmail.com> <CAHp75Vc7Xfqnid9WLvQMPPWcFnRG0T4ZoHweA6Q-1ypWn29J2Q@mail.gmail.com>
In-Reply-To: <CAHp75Vc7Xfqnid9WLvQMPPWcFnRG0T4ZoHweA6Q-1ypWn29J2Q@mail.gmail.com>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Wed, 5 Dec 2018 00:58:14 +0800
Message-ID: <CAEExFWso=uBKj4geVTr2zWOd74V1p5EWq=7r6AATSPh63MQ=mg@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: convert to DEFINE_SHOW_ATTRIBUTE
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     rajneesh.bhardwaj@intel.com, vishwanath.somayaji@intel.com,
        dvhart@infradead.org, andy@infradead.org,
        David Box <david.e.box@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 5, 2018 at 12:18 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Tue, Dec 4, 2018 at 5:30 PM Frank Lee <tiny.windzz@gmail.com> wrote:
> > On Tue, Dec 4, 2018 at 8:40 PM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Tue, Dec 4, 2018 at 5:59 AM Frank Lee <tiny.windzz@gmail.com> wrote:
> > > > On Tue, Dec 4, 2018 at 3:09 AM Andy Shevchenko
> > > > <andy.shevchenko@gmail.com> wrote:
> > > > > On Sat, Dec 1, 2018 at 5:52 PM Yangtao Li <tiny.windzz@gmail.com> wrote:
> > > > > > Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
>
> > > I like your patch, but...
> > >
> > > > > By some reason it's not applicable.
> > > > > Please, rebase on top of our for-next branch, thanks!
> > >
> > > > For what reason?
> > >
> > > ...because I can't apply it, it fails with conflicts.
> > >
> > > >  I thought that for-next branch has not changed much.
> > >
> > > That's correct, it's updated only by approved patch series which is
> > > not many _this_ cycle.
> > I am confused about what you said.
> > Because I pulled your .git down, there is no conflicts when apply it.......
>
> linux(for-next)
> $ git pw patch apply 10707735 -s
> error: patch failed: drivers/platform/x86/intel_pmc_core.c:602
> error: drivers/platform/x86/intel_pmc_core.c: patch does not apply
> hint: Use 'git am --show-current-patch' to see the failed patch
> Applying: platform/x86: convert to DEFINE_SHOW_ATTRIBUTE
> Patch failed at 0001 platform/x86: convert to DEFINE_SHOW_ATTRIBUTE
> When you have resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".
$ git br -r
  origin/HEAD -> origin/master
  origin/fixes
  origin/for-next
  origin/master
  origin/review-andy
$ git remote set-branches --add origin for-next
$ git br -vv
* for-next 651022382c7f [origin/for-next] Linux 4.20-rc1
$ git apply ../../0001-platform-x86-convert-to-DEFINE_SHOW_ATTRIBUTE.patch
$ git st
On branch for-next
Your branch is up to date with 'origin/for-next'.

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

        modified:   drivers/platform/x86/intel_pmc_core.c
        modified:   drivers/platform/x86/intel_telemetry_debugfs.c

no changes added to commit (use "git add" and/or "git commit -a")

Andy,I don't know why.
Is there a problem with my operation?

Thanks,
Yangtao
>
> --
> With Best Regards,
> Andy Shevchenko
