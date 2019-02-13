Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A7BC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2726221934
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:15:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ud8rkiaf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404847AbfBMSPQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:15:16 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45082 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390786AbfBMSPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:15:15 -0500
Received: by mail-pg1-f193.google.com with SMTP id y4so1504232pgc.12;
        Wed, 13 Feb 2019 10:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SfEncYhqIgv8QWbtASSyPQiljg92yAybpKHi5yHaEVI=;
        b=Ud8rkiaf5L2ZeFPFCZn590tqITNBzKG+pLfxv7F/hP2/Cef0jqFQP0+qV0ew83I908
         02WtnmKnw7ttIMYQ29sCr/X42VdAu5Ympp31FtZeZc8mjK4ZdgLtw1khzOYJyQT7mRw3
         NpIg56AJVsqpf3hf7WT8t77MZREIR6E/hKfZihxtKStBNJenLgyQtkyfWOW3eEsqY4pO
         vrjeeAEZEnP6n+OPqRxyWFyqJ6tzR4JTOBlsfw8y0/wC5mS3Wofs5G61fNaifgVuvZrj
         FaIc21vIA8bgMSKLDTxeV7rj50svPAJId/tWWXMtiYjHEymO2VCKdzookQlUhHiUBejS
         oTNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SfEncYhqIgv8QWbtASSyPQiljg92yAybpKHi5yHaEVI=;
        b=WmhO9zq3kU1p/zmm2/Hb/Ev/Jd/eLjDH2uVCxR25ZFFpkFGITdEzEKLEfVxhN+01Mg
         k9o5CYdZNM0rkDo348Q//BldaOAnq21A+lLd9EN/ieID6fTxmQkQPpvDaEdMCZJoYkQt
         Eo7HFiR9567z4SPtJf0v6rwF/5hp//Bp9Rhiag6mrxg3/Fp0axQ9YSscTjm6ovMCCqzd
         8t2dqMvGeyVVPbClsgIqyWwQWlvTov2gQ+EDlvZ+c0QjP+9S8og9lipyl/Kpz5a+n7S0
         7k2BIjywlq5tsMmUb7JkOb198mSYo8irku4ju4Lvnw3x1u6QmJkaks1lqkgAeXh+EgHf
         j9aQ==
X-Gm-Message-State: AHQUAuaVVXgteA9+FDR18e6Zi+s9htRAsTsyJnWROF0AKQjaCvhKuBei
        4YCbfg+gROLkqiqOCEQhxnI6FIGyE7Wdjund+OM=
X-Google-Smtp-Source: AHgI3IYgU89KdT4FGS6zRcvnCcVwHGzwxKwikk1c//NHTQ6Sh4mbTcKiGcWqQN0L28wjeP17zTGlD/+w1ThiVUVVF1M=
X-Received: by 2002:aa7:854d:: with SMTP id y13mr1680062pfn.175.1550081714663;
 Wed, 13 Feb 2019 10:15:14 -0800 (PST)
MIME-Version: 1.0
References: <20190213150810.32750-1-rajneesh.bhardwaj@linux.intel.com>
 <CAHp75VeTwjbdjAXPZfB5B7oataarjG0epV1SzokdYnCj8xcPhA@mail.gmail.com>
 <63bb8cc7-4feb-f69c-33be-ba5308c441d1@linux.intel.com> <CAHp75VdH8G+FfvznZePEG1F5A1Eyh8XF=a-MqpNooLWnBbP+gA@mail.gmail.com>
 <6db89a43-8c69-fc33-a777-61250433fcaa@linux.intel.com> <CAHp75VfF_fWtDG=jWJx_-ASCCjV2VGP4hh3HM8LOCEmv3q=K7w@mail.gmail.com>
In-Reply-To: <CAHp75VfF_fWtDG=jWJx_-ASCCjV2VGP4hh3HM8LOCEmv3q=K7w@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 13 Feb 2019 20:15:03 +0200
Message-ID: <CAHp75VefBpoE_PMuExh+92RvPFT4n+YWX5kyFwuWVr4a70RAvg@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] ICL support and other enhancements for PMC Core
To:     "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@linux.intel.com>
Cc:     Platform Driver <platform-driver-x86@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 8:13 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Wed, Feb 13, 2019 at 8:02 PM Bhardwaj, Rajneesh
> <rajneesh.bhardwaj@linux.intel.com> wrote:
> > On 13-Feb-19 10:58 PM, Andy Shevchenko wrote:
> > > On Wed, Feb 13, 2019 at 5:50 PM Bhardwaj, Rajneesh
> > > <rajneesh.bhardwaj@linux.intel.com> wrote:
> > >> On 13-Feb-19 9:03 PM, Andy Shevchenko wrote:
>
> > > We don't do rebasing for published changes. Only in rear cases when
> > > otherwise would be worse.
> > > Darren didn't respond to my question what he thinks about this case,
> > > but at least it's not related to the code itself which, in my opinion,
> > > decreases a severity.
> >
> > Thanks Andy. So if i understand correctly, you are suggesting that i
> > should ignore those patches that made to "for-next" branch already?
>
> I suggest you to rebase your local branch against latest subsystem tip
> branch, resolve conflicts if any, test, and only after that send a new
> version.

To clarify: "subsystem tip branch" in our case means for-next. The
above is a generic process which would work with Linux kernel
development.

-- 
With Best Regards,
Andy Shevchenko
