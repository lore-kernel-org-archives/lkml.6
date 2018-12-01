Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B76C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 02:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6151620660
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 02:57:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6151620660
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbeLAOJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 09:09:07 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44599 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbeLAOJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 09:09:07 -0500
Received: by mail-pf1-f196.google.com with SMTP id u6so3696199pfh.11;
        Fri, 30 Nov 2018 18:57:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QLcEJrCCB75V4RnwTZXoZTykV2mXOm9SEte7UNEyYB0=;
        b=UzziRl42HNtgI/uC9xf8IWBxM5PkASqU2EpXbSMCoKM6e1BSTqyGB2rKXmV07ZbfE7
         hCOalu4g0Fs3MIKCvOpH9+M/udn1eZv+TshUHs1H/oHJGVEdqsvHj0mEKHNk1jvO7QXn
         ebUC1qdLgkvNtpWVyOWCfx6+cDuY8plI9OqdksJ1iXOLUabWF9Qzpfp6k23SRF+J08aM
         uyaAxYlN3Sa3lvPWvBk3sJphKODHTqEI8V1gY0SRyfDcxdBq6kzBOQIiJspmOSuQ0YK+
         ZDy/kdSQO2D+1KLau2jogD12gvBqTG+jdw0TRDmnR7Qa64V5tDSRtHD1PKJadIYESLKm
         KNbA==
X-Gm-Message-State: AA+aEWbHgocY/8+X5B3fzxFUdcLtPqkKd3xC7CS/EJW/3GDtTA0YEwwn
        cAJ4kHIVYZnZCuBH8gqLRq0=
X-Google-Smtp-Source: AFSGD/XcKmYX4EeYN6lpBZBFsETruJowu2rm6HKsk2VpHOd+Nz7L/9UpBBEzHyq67157CyvYh0WIDg==
X-Received: by 2002:a63:d34a:: with SMTP id u10mr6902847pgi.301.1543633060238;
        Fri, 30 Nov 2018 18:57:40 -0800 (PST)
Received: from garbanzo.do-not-panic.com (c-73-71-40-85.hsd1.ca.comcast.net. [73.71.40.85])
        by smtp.gmail.com with ESMTPSA id d68sm8588091pfa.64.2018.11.30.18.57.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 18:57:38 -0800 (PST)
Received: by garbanzo.do-not-panic.com (sSMTP sendmail emulation); Fri, 30 Nov 2018 18:57:35 -0800
Date:   Fri, 30 Nov 2018 18:57:35 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@google.com>, shuah@kernel.org,
        Joel Stanley <joel@jms.id.au>, mpe@ellerman.id.au,
        joe@perches.com, brakmo@fb.com, rostedt@goodmis.org,
        Tim.Bird@sony.com, khilman@baylibre.com,
        Julia Lawall <julia.lawall@lip6.fr>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jdike@addtoit.com, richard@nod.at, linux-um@lists.infradead.org,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, Rob Herring <robh@kernel.org>,
        dan.j.williams@intel.com, linux-nvdimm@lists.01.org,
        kieran.bingham@ideasonboard.com,
        Frank Rowand <frowand.list@gmail.com>,
        Knut Omang <knut.omang@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        levinsasha928@gmail.com
Subject: Re: [RFC v3 01/19] kunit: test: add KUnit test runner core
Message-ID: <20181201025735.GI28501@garbanzo.do-not-panic.com>
References: <20181128193636.254378-1-brendanhiggins@google.com>
 <20181128193636.254378-2-brendanhiggins@google.com>
 <20181130031438.GQ4922@garbanzo.do-not-panic.com>
 <CAFd5g47t94RR78_sZ7Xr7ArDh+hJGYHNwmmG2HJb7AW+i=u3ew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFd5g47t94RR78_sZ7Xr7ArDh+hJGYHNwmmG2HJb7AW+i=u3ew@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 05:51:11PM -0800, Brendan Higgins wrote:
> On Thu, Nov 29, 2018 at 7:14 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > On Wed, Nov 28, 2018 at 11:36:18AM -0800, Brendan Higgins wrote:
> > > +#define module_test(module) \
> > > +             static int module_kunit_init##module(void) \
> > > +             { \
> > > +                     return kunit_run_tests(&module); \
> > > +             } \
> > > +             late_initcall(module_kunit_init##module)
> >
> > Here in lies an assumption that suffices. I'm inclined to believe we
> > need new initcall level here so to ensure we *do* run after all the
> > respective kernels iniut calls. Otherwise we're left at the whims of
> > link order for kunit. For instance if a kunit test relies on frameworks
> > which are also late_initcall() we'd have complete incompatibility with
> > anything linked *after* kunit.
> 
> Yep, I have some patches that address this, but I thought this is
> sufficient for the initial patchset (I figured that's the type of
> thing that people will have opinions about so best to get it out of
> the critical path). Do you want me to add those in the next revision?
> 
> >
> > > diff --git a/kunit/Kconfig b/kunit/Kconfig
> > > new file mode 100644
> > > index 0000000000000..49b44c4f6630a
> > > --- /dev/null
> > > +++ b/kunit/Kconfig
> > > @@ -0,0 +1,17 @@
> > > +#
> > > +# KUnit base configuration
> > > +#
> > > +
> > > +menu "KUnit support"
> > > +
> > > +config KUNIT
> > > +     bool "Enable support for unit tests (KUnit)"
> > > +     depends on UML
> >
> > Consider using:
> >
> > if UML
> >    ...
> > endif
> >
> > That allows the depends to be done once.
> 
> If you want to eliminate depends, wouldn't it be best to have KUNIT
> depend on whatever it needs, and then do `if KUNIT` below that? That
> seems cleaner over the long term. Anyway, Kees actually asked me to
> change it to the way it is now; I really don't care either way.

Yes, that works better. The idea is to just avoid having to write in
depends on over and over again.

> > I'm a bit conflicted here. This currently depends on UML but yet you
> > noted on RFC v2 that your intention is to liberate kunit from UML and
> > ideally allow unit tests to depend only on userspace. I've addressed
> > tests using both selftests kernels drivers and also re-written kernel
> > APIs to userspace to test there. I think we may need to live with both.
> 
> I am not entirely opposed. The greater isolation we can achieve, the
> fewer dependencies, and barriers to setting up test fixtures the
> better. I think the best way to do that in most cases is allowing
> minimal test binaries to be built that have the absolute minimum
> amount of code necessary to test the desired property. That being
> said, integration tests are a thing and drawing a line between them
> and unit tests is not always possible, so supporting other
> architectures might be necessary.

Then lets pave the way for it to be done easily.

> > Then for the UML stuff, I think if we *really* accept that UML will
> > always be a viable option we should probably consider now throwing these
> > things under drivers/platform/uml/. This follows the pattern of arch
> > specific drivers. Whether or not we end up with a complete userspace
> > component independent of UML may implicate having a shared component
> > somewhere else.
> 
> Fair enough. What specifically are you suggesting should go in
> `drivers/platform/uml`? Just the bits that are completely tied to UML
> or a concrete architecture?

The bits that are UML specific. As I see it, with the above intention
clarified, kunit is a framework for architectures and UML is supported
first. The code doesn't currently reflect this.

> > Likewise, I realize the goal is to *avoid* using a virtual machine for
> > these tests, but would it in any way make sense to share kunit to be
> > supported for other architectures to allow easier-to-write tests as
> > well?
> 
> You are not the first person to ask for this.
> 
> For the vast majority of tests, I think we can (and consequently
> should) make them run without any external dependencies. Doing so
> makes it such that someone can run a test without knowing anything
> about it, which allows you to do a lot of things. For one, I, as a
> developer, don't have to hunt down somebody's QEMU patches, or
> whatever. But it also means I, as someone maintaining part of the
> kernel, can make nice test runners and build things like presubmit
> servers on top of them.
> 
> Nevertheless, I accept that there are things which are just easier to
> do with hardware or a VM (for integration tests it is necessary).
> Still, I think we need to make sure the vast majority of unit tests do
> not depend on real hardware or a VM.

When possible, sure.

  Luis
