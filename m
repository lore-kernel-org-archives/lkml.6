Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B582C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 629C92081B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M9cQe1Ll"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 629C92081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbeLDQTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 11:19:02 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39348 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726367AbeLDQS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 11:18:56 -0500
Received: by mail-qk1-f195.google.com with SMTP id q70so9947518qkh.6;
        Tue, 04 Dec 2018 08:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S4v31HNE5B2n47BVY3oeeA1RkI3LeyytTKnB7KmWdI0=;
        b=M9cQe1LlAekp46aS2KmEhkl4R150eKVB+yUQ/YIZnfErgXnv7R8Vb6WJ42K07TfACl
         i8e/Au3l+3/UopgNW/xj1NqHaYEtlc2KlvUZX7L93RzmMd4YOwx5flFsaXnlvvKr3zbH
         WExwZ+0z1kiGb4ycfwbyAUdykfhBp9ooQtwR7TzeJRpejgHh50m48NmTT6L1qfQn5XgQ
         evn9FblQQ1oNWtS+nSWEoyB5u9QsMSNNf6En/cl6xPzsVVR/OOyiS8AmBARRBxqpYogc
         pFI0KbJ9wGqyHLAqeJ9ly7muApsEyeoexdgLfImaF/J+Xk4SCUd7VAsaB/LImaHWXxXQ
         h4/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S4v31HNE5B2n47BVY3oeeA1RkI3LeyytTKnB7KmWdI0=;
        b=dVNW9jt+GcQuxr1jGww88JSaSY6xx2eLvun3rGz+Xn0lfHZqAAydgKtXXMEjSorMnZ
         9tvToD3+dicjZX7IiQZI1DZbxUuMrj+jicsWC93mBIyt4OUldrFkqo6X9URmCTbyBCFX
         6stsUkQ2BdJyqjfZJXI4nYJRAtI7sV7Oe1FzceWGVZoGHy9RiNw6UnEQ96rpTH6kjhXl
         YWu9fxapIMruLSo2hGtU/NDq3P7k6SakZZXuIESTlSzqxpkgAt3G7rnKcQnYbVEx07V+
         RvJf0ukNOSnG+LbpWrkn4cVMWGdXCMU8HHAMU4LSTB5gsLdZ6r+ZoWgN+pC2ZW0wycLW
         oRSA==
X-Gm-Message-State: AA+aEWYIcXstoWo/Z1EZvMUcDBfBPOq1yVa1zA8rINa52GUHaFXHQ5oB
        q3g5yVjDqoAcPf4Oj9SwlNAC7WeiZGZ5cU36g3YXWJrVuxI=
X-Google-Smtp-Source: AFSGD/VfWrnpQ6F0LDonH8frsZ1SO8buL9MxYr1JWI5Ji20+5ilXDyS7yEVCbo2JWL6GSsfnpWSdZusx7uJVX4nLi60=
X-Received: by 2002:a37:1f44:: with SMTP id f65mr18552895qkf.33.1543940334953;
 Tue, 04 Dec 2018 08:18:54 -0800 (PST)
MIME-Version: 1.0
References: <20181201155229.8532-1-tiny.windzz@gmail.com> <CAHp75VdEbr9YfaCgHXNqScZC-KMobF2fU8rZb29nhZPBJvm2gg@mail.gmail.com>
 <CAEExFWvRFrS-ZTSkrS5Npe7g-rxtxfCfk+AyTz00Lx4oAWhQ_g@mail.gmail.com>
 <CAHp75VcSVEakAK4MeoG8zA7MaCWNoL2fOr48iFmxTsjbBpa5XA@mail.gmail.com> <CAEExFWtE7Yi8D+Dr=J7B3zqBRet0AX=ABHnUrJkZ2LO3aHdNeg@mail.gmail.com>
In-Reply-To: <CAEExFWtE7Yi8D+Dr=J7B3zqBRet0AX=ABHnUrJkZ2LO3aHdNeg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 4 Dec 2018 18:18:43 +0200
Message-ID: <CAHp75Vc7Xfqnid9WLvQMPPWcFnRG0T4ZoHweA6Q-1ypWn29J2Q@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: convert to DEFINE_SHOW_ATTRIBUTE
To:     tiny.windzz@gmail.com
Cc:     Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Vishwanath Somayaji <vishwanath.somayaji@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        David Box <david.e.box@linux.intel.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 4, 2018 at 5:30 PM Frank Lee <tiny.windzz@gmail.com> wrote:
> On Tue, Dec 4, 2018 at 8:40 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Tue, Dec 4, 2018 at 5:59 AM Frank Lee <tiny.windzz@gmail.com> wrote:
> > > On Tue, Dec 4, 2018 at 3:09 AM Andy Shevchenko
> > > <andy.shevchenko@gmail.com> wrote:
> > > > On Sat, Dec 1, 2018 at 5:52 PM Yangtao Li <tiny.windzz@gmail.com> wrote:
> > > > > Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

> > I like your patch, but...
> >
> > > > By some reason it's not applicable.
> > > > Please, rebase on top of our for-next branch, thanks!
> >
> > > For what reason?
> >
> > ...because I can't apply it, it fails with conflicts.
> >
> > >  I thought that for-next branch has not changed much.
> >
> > That's correct, it's updated only by approved patch series which is
> > not many _this_ cycle.
> I am confused about what you said.
> Because I pulled your .git down, there is no conflicts when apply it.......

linux(for-next)
$ git pw patch apply 10707735 -s
error: patch failed: drivers/platform/x86/intel_pmc_core.c:602
error: drivers/platform/x86/intel_pmc_core.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch
Applying: platform/x86: convert to DEFINE_SHOW_ATTRIBUTE
Patch failed at 0001 platform/x86: convert to DEFINE_SHOW_ATTRIBUTE
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

-- 
With Best Regards,
Andy Shevchenko
