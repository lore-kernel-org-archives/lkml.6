Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37300C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 21:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA31E21916
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 21:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q7eebrHj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438000AbfBNVwt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 16:52:49 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37938 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391048AbfBNVws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 16:52:48 -0500
Received: by mail-ot1-f66.google.com with SMTP id m1so13223212otf.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 13:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DbuOOVJM2wi9bnUw4pC9FyprNA/Yen3KGZHX/2w/up8=;
        b=q7eebrHjjL98ZBva7V6SwUfWD31B+ajgbmYBjgFXdphG89u4+C21sxZuLPoVfm01hy
         UdOpn4i4WL3+YZ0Z8rjqIdBsoeXhITtwABJlaIMVAjmQ+bY4yYlScENv7fM3QdUh/cVZ
         IYo0pNL1h1ebd6p6mqZgn7zV49YXedqZvTIYwTi8gR24f3dtiDd5yjgcsOogVFmP6dQp
         CULJQ5WlcvZJo/iUD8GLf2BjmKf4JFXHYYZ91EasSrj8sy06JVyFQ/7E+2kq8voqbgVO
         zQNMrM0y4SuBxcXc4bsbK4PfITG6sUUiosVuPT/uAysxHobUT5q1B/KYy49vmkbsVVgN
         l1hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DbuOOVJM2wi9bnUw4pC9FyprNA/Yen3KGZHX/2w/up8=;
        b=R3gwNvDqMlNMZWg9FcNrJKXp9BPQSTElDsHPdcFpw1uAF2QHtvE1IIjv7n6CMOFN6X
         WYiGET55Anh+s8vU+OWFmKZ7JRZkUZeaRQ2jYwaTF5F2le9W16GoHwpZ9nJDojrhYToN
         yIrdCPSE1ucnrXSGNsovpVDzQ4KH3D8cRQxIvwB2CfSpT5VqHsP6zmuBhDUG9Z6wdc7j
         JLuKT+PxhhaUDlru7wWKOo6ncralwxyIVyzJTFl0H0TMXLB7rcme7i6XXZGbGOLcC7Q+
         dMheLaI0YeC1dL5WxlJ34GlBkMmIWXSdV2ZXWyxOmAz+Zl23xvaKLXvqJmzbkoQy2H34
         N/tg==
X-Gm-Message-State: AHQUAuZVLlYLpcZvO6SEQy5IY0xthcbqKUPZu1GYsry3bHOpTi+Wk8+I
        HGHxy2vvaJILTuwYKHcAFAp6CvH87SHsBUnX6YHllA==
X-Google-Smtp-Source: AHgI3Ia8FTQLnYJoMJ9oFtOEX74Bfe2F4CWZpgi9CpkpvkaKPLyc5GtizbortOk26RyJ/iGcUEGCnpx5PyRiAztPAno=
X-Received: by 2002:aca:56ca:: with SMTP id k193mr3899681oib.59.1550181167280;
 Thu, 14 Feb 2019 13:52:47 -0800 (PST)
MIME-Version: 1.0
References: <20181128193636.254378-1-brendanhiggins@google.com>
 <20181128193636.254378-18-brendanhiggins@google.com> <CAL_Jsq+09Kx7yMBC_Jw45QGmk6U_fp4N6HOZDwYrM4tWw+_dOA@mail.gmail.com>
 <CAFd5g46NehKo=TT4reQ8r74bDTG9BkR=ELg+Q3n5YooUxFwBmA@mail.gmail.com> <CAL_JsqL=NthWW6q==TXjado83AAWuC1jYZ9CR+T9wPtgQLC4hw@mail.gmail.com>
In-Reply-To: <CAL_JsqL=NthWW6q==TXjado83AAWuC1jYZ9CR+T9wPtgQLC4hw@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 14 Feb 2019 13:52:35 -0800
Message-ID: <CAFd5g44dn-w5s4npCY-8kwj3EvqvFmMP_3SzDzNpHVjiB35fXQ@mail.gmail.com>
Subject: Re: [RFC v3 17/19] of: unittest: migrate tests to run on KUnit
To:     Rob Herring <robh@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@google.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>, shuah@kernel.org,
        Joel Stanley <joel@jms.id.au>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Joe Perches <joe@perches.com>, brakmo@fb.com,
        Steven Rostedt <rostedt@goodmis.org>,
        "Bird, Timothy" <Tim.Bird@sony.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        linux-um@lists.infradead.org, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Knut Omang <knut.omang@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 12:10 PM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Feb 12, 2019 at 7:44 PM Brendan Higgins
> <brendanhiggins@google.com> wrote:
> >
> > On Wed, Nov 28, 2018 at 12:56 PM Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Wed, Nov 28, 2018 at 1:38 PM Brendan Higgins
> > > <brendanhiggins@google.com> wrote:
> > > >
> > > > Migrate tests without any cleanup, or modifying test logic in anyway to
> > > > run under KUnit using the KUnit expectation and assertion API.
> > >
> > > Nice! You beat me to it. This is probably going to conflict with what
> > > is in the DT tree for 4.21. Also, please Cc the DT list for
> > > drivers/of/ changes.
> > >
> > > Looks good to me, but a few mostly formatting comments below.
> >
> > I just realized that we never talked about your other comments, and I
> > still have some questions. (Sorry, it was the last thing I looked at
> > while getting v4 ready.) No worries if you don't get to it before I
> > send v4 out, I just didn't want you to think I was ignoring you.
> >
> > >
> > > >
> > > > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > > > ---
> > > >  drivers/of/Kconfig    |    1 +
> > > >  drivers/of/unittest.c | 1405 ++++++++++++++++++++++-------------------
> > > >  2 files changed, 752 insertions(+), 654 deletions(-)
> > > >
> > <snip>
> > > > diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
> > > > index 41b49716ac75f..a5ef44730ffdb 100644
> > > > --- a/drivers/of/unittest.c
> > > > +++ b/drivers/of/unittest.c
> > <snip>
> > > > -
> > > > -static void __init of_unittest_find_node_by_name(void)
> > > > +static void of_unittest_find_node_by_name(struct kunit *test)
> > >
> > > Why do we have to drop __init everywhere? The tests run later?
> >
> > From the standpoint of a unit test __init doesn't really make any
> > sense, right? I know that right now we are running as part of a
> > kernel, but the goal should be that a unit test is not part of a
> > kernel and we just include what we need.
>
> Well, the test only runs during boot and better to free the space when
> done with it. There was some desire to make it a kernel module and
> then we'd also need to get rid of __init too.
>
> > Even so, that's the future. For now, I did not put the KUnit
> > infrastructure in the .init section because I didn't think it belonged
> > there. In practice, KUnit only knows how to run during the init phase
> > of the kernel, but I don't think it should be restricted there. You
> > should be able to run tests whenever you want because you should be
> > able to test anything right? I figured any restriction on that is
> > misleading and will potentially get in the way at worst, and
> > unnecessary at best especially since people shouldn't build a
> > production kernel with all kinds of unit tests inside.
>
> More folks will run things if they can be enabled on production
> kernels. If size is the only issue, modules mitigate that. However,
> there's probably APIs to test which we don't want to export to
> modules.
>
> I think in general, we change things in the kernel when needed, not
> for something in the future. Changing __init is simple enough to do
> later.
>
> OTOH, things get copied and maybe this we don't want copied, so we can
> remove it if you want to.

Mmmm...I just realized that the patch I sent you the other day makes
this patch unhappy because unflatten_device_tree is in the .init
section. So I will need to fix that. I still think that the correct
course of action is to make KUnit non init. Luis pointed out in
another thread that to be 100% sure that everything will be properly
initialized, KUnit must be able to run after all initialization takes
place.

>
> > <snip>
> > > >
> > > > -static void __init of_unittest_property_string(void)
> > > > +static void of_unittest_property_string(struct kunit *test)
> > > >  {
> > > >         const char *strings[4];
> > > >         struct device_node *np;
> > > >         int rc;
> > > >
> > > >         np = of_find_node_by_path("/testcase-data/phandle-tests/consumer-a");
> > > > -       if (!np) {
> > > > -               pr_err("No testcase data in device tree\n");
> > > > -               return;
> > > > -       }
> > > > -
> > > > -       rc = of_property_match_string(np, "phandle-list-names", "first");
> > > > -       unittest(rc == 0, "first expected:0 got:%i\n", rc);
> > > > -       rc = of_property_match_string(np, "phandle-list-names", "second");
> > > > -       unittest(rc == 1, "second expected:1 got:%i\n", rc);
> > > > -       rc = of_property_match_string(np, "phandle-list-names", "third");
> > > > -       unittest(rc == 2, "third expected:2 got:%i\n", rc);
> > > > -       rc = of_property_match_string(np, "phandle-list-names", "fourth");
> > > > -       unittest(rc == -ENODATA, "unmatched string; rc=%i\n", rc);
> > > > -       rc = of_property_match_string(np, "missing-property", "blah");
> > > > -       unittest(rc == -EINVAL, "missing property; rc=%i\n", rc);
> > > > -       rc = of_property_match_string(np, "empty-property", "blah");
> > > > -       unittest(rc == -ENODATA, "empty property; rc=%i\n", rc);
> > > > -       rc = of_property_match_string(np, "unterminated-string", "blah");
> > > > -       unittest(rc == -EILSEQ, "unterminated string; rc=%i\n", rc);
> > > > +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, np);
> > > > +
> > > > +       KUNIT_EXPECT_EQ(test,
> > > > +                       of_property_match_string(np,
> > > > +                                                "phandle-list-names",
> > > > +                                                "first"),
> > > > +                       0);
> > > > +       KUNIT_EXPECT_EQ(test,
> > > > +                       of_property_match_string(np,
> > > > +                                                "phandle-list-names",
> > > > +                                                "second"),
> > > > +                       1);
> > >
> > > Fewer lines on these would be better even if we go over 80 chars.
> >
> > On the of_property_match_string(...), I have no opinion. I will do
> > whatever you like best.
> >
> > Nevertheless, as far as the KUNIT_EXPECT_*(...), I do have an opinion: I am
> > trying to establish a good, readable convention. Given an expect statement
> > structured as
> > ```
> > KUNIT_EXPECT_*(
> >     test,
> >     expect_arg_0, ..., expect_arg_n,
> >     fmt_str, fmt_arg_0, ..., fmt_arg_n)
> > ```
> > where `test` is the `struct kunit` context argument, `expect_arg_{0, ..., n}`
> > are the arguments the expectations is being made about (so in the above example,
> > `of_property_match_string(...)` and `1`), and `fmt_*` is the optional format
> > string that comes at the end of some expectations.
> >
> > The pattern I had been trying to promote is the following:
> >
> > 1) If everything fits on 1 line, do that.
> > 2) If you must make a line split, prefer to keep `test` on its own line,
> > `expect_arg_{0, ..., n}` should be kept together, if possible, and the format
> > string should follow the conventions already most commonly used with format
> > strings.
> > 3) If you must split up `expect_arg_{0, ..., n}` each argument should get its
> > own line and should not share a line with either `test` or any `fmt_*`.
>
> You'd better write a checkpatch.pl check or else good luck enforcing that. :)

Absolutely. Well I already had to touch checkpatch.pl for something
else, so at least I know roughly what I am getting myself into.

>
> > The reason I care about this so much is because expectations should be
> > extremely easy to read; they are the most important part of a unit
> > test because they tell you what the test is verifying. I am not
> > married to the formatting I proposed above, but I want something that
> > will be extremely easy to identify the arguments that the expectation
> > is on. Maybe that means that I need to add some syntactic fluff to
> > make it clearer, I don't know, but this is definitely something we
> > need to get right, especially in the earliest examples.
>
> Makes sense. I think putting the test (of_property_match_string) on
> one line furthers the readability.

Fair enough, I tried to apply your comments the best that I could on
v4, but I think I will probably need to make another pass (especially
given the init thing).

Anyway, let's continue the discussion on v4.

Cheers
