Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18542C282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 01:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD395222BB
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 01:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fhAWYiON"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733157AbfBMBoi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 20:44:38 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36637 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbfBMBoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 20:44:37 -0500
Received: by mail-ot1-f68.google.com with SMTP id k98so1332651otk.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 17:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZcEVQ0rih+Ua5myx5j0QjsCKlTkTUlQBIlThoIKCq+g=;
        b=fhAWYiONWH4pggQr7BU7UCTLun9AZSdiSAL8CYbN/7qThVORaqUXn8CV82IRcRjaz4
         TprDTfqYfmlYQfVOZsIRG9CgMG0sZsdIsFxg4n+EqznTmmKBEauTEIdSN3a1t0EHFhgL
         mwHg9rh1ZfNDM8XKDdsqVZ0JNLRDLNPat/QSZj26aAlwVCKIvsLGSpcYzLgU5f7ikpw6
         QjZfvY4WzSYhv+7KTLVGUa6jc49F78tPT5MA0gZl1QmnkldKTaYPnnTdX4U9z9222c9C
         4Uw7+ThHQNUUkJnJkBtV9RKyA6wLAh+W2mELgdmpBSl34gStSvUC7QZetWX3SErwO8hp
         dXMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZcEVQ0rih+Ua5myx5j0QjsCKlTkTUlQBIlThoIKCq+g=;
        b=A77NDQtyGxAd/F65pBjV7D/e7QmSOKkc04LL9RK0Nv1mXvKKR9Inl1RFPbWME2zYFq
         qW0coDTcJ9jajbJNv7OzX6HxN/I/nry980bXZH2GtxE36akkqir4OQx8nPJfwGF0u/Bc
         Z0bHMcW37vO/9cRE+hn0TOoueQ8T2LdonpfPweyIBvIkXF9QODchVXMJfQWcGeKDVew1
         XJexVVuaNBBzXZQ49Yq9UHZKAH/iJiD50mGgkjQezbJkaSWck1Ft0k5UWXTEj2m0ZFrw
         Mp+YK2uk5vhYf/ubiZI3ZkeVmxL+b5xSCnKKU4w8H8wZGTjLrtQvQxMStAzYP3AQhYUe
         LYpg==
X-Gm-Message-State: AHQUAuaJ9VrUGQkKTcYkhY8onuzal4iqYw0uyKTh35/os/bqo78aOM6G
        jA8nanciu1VaC/F3euE6HCmt4jIBtyTipouXP4CF2A==
X-Google-Smtp-Source: AHgI3IZqt+RT7Qagg1cEv6AN5mVJFpOq9N32AL9TPm5x1UXPLqAj8MzLtwMddtpaX4bhXAqhVZWfTVvpNyasN5sZ8lw=
X-Received: by 2002:a9d:6401:: with SMTP id h1mr3174261otl.230.1550022275846;
 Tue, 12 Feb 2019 17:44:35 -0800 (PST)
MIME-Version: 1.0
References: <20181128193636.254378-1-brendanhiggins@google.com>
 <20181128193636.254378-18-brendanhiggins@google.com> <CAL_Jsq+09Kx7yMBC_Jw45QGmk6U_fp4N6HOZDwYrM4tWw+_dOA@mail.gmail.com>
In-Reply-To: <CAL_Jsq+09Kx7yMBC_Jw45QGmk6U_fp4N6HOZDwYrM4tWw+_dOA@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 12 Feb 2019 17:44:23 -0800
Message-ID: <CAFd5g46NehKo=TT4reQ8r74bDTG9BkR=ELg+Q3n5YooUxFwBmA@mail.gmail.com>
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

On Wed, Nov 28, 2018 at 12:56 PM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Nov 28, 2018 at 1:38 PM Brendan Higgins
> <brendanhiggins@google.com> wrote:
> >
> > Migrate tests without any cleanup, or modifying test logic in anyway to
> > run under KUnit using the KUnit expectation and assertion API.
>
> Nice! You beat me to it. This is probably going to conflict with what
> is in the DT tree for 4.21. Also, please Cc the DT list for
> drivers/of/ changes.
>
> Looks good to me, but a few mostly formatting comments below.

I just realized that we never talked about your other comments, and I
still have some questions. (Sorry, it was the last thing I looked at
while getting v4 ready.) No worries if you don't get to it before I
send v4 out, I just didn't want you to think I was ignoring you.

>
> >
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > ---
> >  drivers/of/Kconfig    |    1 +
> >  drivers/of/unittest.c | 1405 ++++++++++++++++++++++-------------------
> >  2 files changed, 752 insertions(+), 654 deletions(-)
> >
<snip>
> > diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
> > index 41b49716ac75f..a5ef44730ffdb 100644
> > --- a/drivers/of/unittest.c
> > +++ b/drivers/of/unittest.c
<snip>
> > -
> > -static void __init of_unittest_find_node_by_name(void)
> > +static void of_unittest_find_node_by_name(struct kunit *test)
>
> Why do we have to drop __init everywhere? The tests run later?

From the standpoint of a unit test __init doesn't really make any
sense, right? I know that right now we are running as part of a
kernel, but the goal should be that a unit test is not part of a
kernel and we just include what we need.

Even so, that's the future. For now, I did not put the KUnit
infrastructure in the .init section because I didn't think it belonged
there. In practice, KUnit only knows how to run during the init phase
of the kernel, but I don't think it should be restricted there. You
should be able to run tests whenever you want because you should be
able to test anything right? I figured any restriction on that is
misleading and will potentially get in the way at worst, and
unnecessary at best especially since people shouldn't build a
production kernel with all kinds of unit tests inside.

>
> >  {
> >         struct device_node *np;
> >         const char *options, *name;
> >
<snip>
> >
> >
> > -       np = of_find_node_by_path("/testcase-data/missing-path");
> > -       unittest(!np, "non-existent path returned node %pOF\n", np);
> > +       KUNIT_EXPECT_EQ_MSG(test,
> > +                           of_find_node_by_path("/testcase-data/missing-path"),
> > +                           NULL,
> > +                           "non-existent path returned node %pOF\n", np);
>
> 1 tab indent would help with less vertical code (in general, not this
> one so much).

Will do.

>
> >         of_node_put(np);
> >
> > -       np = of_find_node_by_path("missing-alias");
> > -       unittest(!np, "non-existent alias returned node %pOF\n", np);
> > +       KUNIT_EXPECT_EQ_MSG(test, of_find_node_by_path("missing-alias"), NULL,
> > +                           "non-existent alias returned node %pOF\n", np);
> >         of_node_put(np);
> >
> > -       np = of_find_node_by_path("testcase-alias/missing-path");
> > -       unittest(!np, "non-existent alias with relative path returned node %pOF\n", np);
> > +       KUNIT_EXPECT_EQ_MSG(test,
> > +                           of_find_node_by_path("testcase-alias/missing-path"),
> > +                           NULL,
> > +                           "non-existent alias with relative path returned node %pOF\n",
> > +                           np);
> >         of_node_put(np);
> >
<snip>
> >
> > -static void __init of_unittest_property_string(void)
> > +static void of_unittest_property_string(struct kunit *test)
> >  {
> >         const char *strings[4];
> >         struct device_node *np;
> >         int rc;
> >
> >         np = of_find_node_by_path("/testcase-data/phandle-tests/consumer-a");
> > -       if (!np) {
> > -               pr_err("No testcase data in device tree\n");
> > -               return;
> > -       }
> > -
> > -       rc = of_property_match_string(np, "phandle-list-names", "first");
> > -       unittest(rc == 0, "first expected:0 got:%i\n", rc);
> > -       rc = of_property_match_string(np, "phandle-list-names", "second");
> > -       unittest(rc == 1, "second expected:1 got:%i\n", rc);
> > -       rc = of_property_match_string(np, "phandle-list-names", "third");
> > -       unittest(rc == 2, "third expected:2 got:%i\n", rc);
> > -       rc = of_property_match_string(np, "phandle-list-names", "fourth");
> > -       unittest(rc == -ENODATA, "unmatched string; rc=%i\n", rc);
> > -       rc = of_property_match_string(np, "missing-property", "blah");
> > -       unittest(rc == -EINVAL, "missing property; rc=%i\n", rc);
> > -       rc = of_property_match_string(np, "empty-property", "blah");
> > -       unittest(rc == -ENODATA, "empty property; rc=%i\n", rc);
> > -       rc = of_property_match_string(np, "unterminated-string", "blah");
> > -       unittest(rc == -EILSEQ, "unterminated string; rc=%i\n", rc);
> > +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, np);
> > +
> > +       KUNIT_EXPECT_EQ(test,
> > +                       of_property_match_string(np,
> > +                                                "phandle-list-names",
> > +                                                "first"),
> > +                       0);
> > +       KUNIT_EXPECT_EQ(test,
> > +                       of_property_match_string(np,
> > +                                                "phandle-list-names",
> > +                                                "second"),
> > +                       1);
>
> Fewer lines on these would be better even if we go over 80 chars.

On the of_property_match_string(...), I have no opinion. I will do
whatever you like best.

Nevertheless, as far as the KUNIT_EXPECT_*(...), I do have an opinion: I am
trying to establish a good, readable convention. Given an expect statement
structured as
```
KUNIT_EXPECT_*(
    test,
    expect_arg_0, ..., expect_arg_n,
    fmt_str, fmt_arg_0, ..., fmt_arg_n)
```
where `test` is the `struct kunit` context argument, `expect_arg_{0, ..., n}`
are the arguments the expectations is being made about (so in the above example,
`of_property_match_string(...)` and `1`), and `fmt_*` is the optional format
string that comes at the end of some expectations.

The pattern I had been trying to promote is the following:

1) If everything fits on 1 line, do that.
2) If you must make a line split, prefer to keep `test` on its own line,
`expect_arg_{0, ..., n}` should be kept together, if possible, and the format
string should follow the conventions already most commonly used with format
strings.
3) If you must split up `expect_arg_{0, ..., n}` each argument should get its
own line and should not share a line with either `test` or any `fmt_*`.

The reason I care about this so much is because expectations should be
extremely easy to read; they are the most important part of a unit
test because they tell you what the test is verifying. I am not
married to the formatting I proposed above, but I want something that
will be extremely easy to identify the arguments that the expectation
is on. Maybe that means that I need to add some syntactic fluff to
make it clearer, I don't know, but this is definitely something we
need to get right, especially in the earliest examples.

>
> > +       KUNIT_EXPECT_EQ(test,
> > +                       of_property_match_string(np,
> > +                                                "phandle-list-names",
> > +                                                "third"),
> > +                       2);
> > +       KUNIT_EXPECT_EQ_MSG(test,
> > +                           of_property_match_string(np,
> > +                                                    "phandle-list-names",
> > +                                                    "fourth"),
> > +                           -ENODATA,
> > +                           "unmatched string");
> > +       KUNIT_EXPECT_EQ_MSG(test,
> > +                           of_property_match_string(np,
> > +                                                    "missing-property",
> > +                                                    "blah"),
> > +                           -EINVAL,
> > +                           "missing property");
> > +       KUNIT_EXPECT_EQ_MSG(test,
> > +                           of_property_match_string(np,
> > +                                                    "empty-property",
> > +                                                    "blah"),
> > +                           -ENODATA,
> > +                           "empty property");
> > +       KUNIT_EXPECT_EQ_MSG(test,
> > +                           of_property_match_string(np,
> > +                                                    "unterminated-string",
> > +                                                    "blah"),
> > +                           -EILSEQ,
> > +                           "unterminated string");
<snip>
> >  /* test insertion of a bus with parent devices */
> > -static void __init of_unittest_overlay_10(void)
> > +static void of_unittest_overlay_10(struct kunit *test)
> >  {
> > -       int ret;
> >         char *child_path;
> >
> >         /* device should disable */
> > -       ret = of_unittest_apply_overlay_check(10, 10, 0, 1, PDEV_OVERLAY);
> > -       if (unittest(ret == 0,
> > -                       "overlay test %d failed; overlay application\n", 10))
> > -               return;
> > +       KUNIT_ASSERT_EQ_MSG(test,
> > +                           of_unittest_apply_overlay_check(test,
> > +                                                           10,
> > +                                                           10,
> > +                                                           0,
> > +                                                           1,
> > +                                                           PDEV_OVERLAY),
>
> I prefer putting multiple args on a line and having fewer lines.

Looking at this now, I tend to agree, but I don't think I saw a
consistent way to break them up for these functions. I figured there
should be some type of pattern.

>
> > +                           0,
> > +                           "overlay test %d failed; overlay application\n",
> > +                           10);
> >
> >         child_path = kasprintf(GFP_KERNEL, "%s/test-unittest101",
> >                         unittest_path(10, PDEV_OVERLAY));
> > -       if (unittest(child_path, "overlay test %d failed; kasprintf\n", 10))
> > -               return;
> > +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, child_path);
> >
> > -       ret = of_path_device_type_exists(child_path, PDEV_OVERLAY);
> > +       KUNIT_EXPECT_TRUE_MSG(test,
> > +                             of_path_device_type_exists(child_path,
> > +                                                        PDEV_OVERLAY),
> > +                             "overlay test %d failed; no child device\n", 10);
> >         kfree(child_path);
> > -
> > -       unittest(ret, "overlay test %d failed; no child device\n", 10);
> >  }
<snip>
