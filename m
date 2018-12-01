Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC181C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 02:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8338F20834
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 02:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Sbi4dxUG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8338F20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbeLANUJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 08:20:09 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43128 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbeLANUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 08:20:08 -0500
Received: by mail-ot1-f68.google.com with SMTP id a11so6882651otr.10
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 18:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VdfIe7+VxwPLFKcKXYB9P/WieXnBdcv7g7QGMIAOBz0=;
        b=Sbi4dxUG4nwVMYT/J6jCAbUel9qcHcl3iIc4yfUCia+USkaMAEipBeMO9MMWpqew5n
         0WvExpaiRTB3TE6op+OKWYAZwEsBwNXaNEYyw0VH9flxmQ4ctaxSrIaYthTT9yV+nKBB
         a4H4y5VhyVvwCDcEPCZYjtQwcw1coWeozTL5hTRzNXov/NAjWhCu8WP6MlBXv98tTR20
         FVtJFzkvlpeykaDKn+NJlLcqTQYCqmFqpEQA6Lh7yoxB3Py//pWuwzRJaCoLL4VI1eXU
         UDTHN6qSxqSfXwkq6TG6zg/NUEKnXD5L7f5StM0WiV3h/pOIXoemC5eJR8e31iFs21xI
         TYtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VdfIe7+VxwPLFKcKXYB9P/WieXnBdcv7g7QGMIAOBz0=;
        b=TsEqG21OBLgmzCAVUi3pXAp+uA0MfENOJf1aZFcHlj65u5K2l2QhIeU0fflK7VtsJQ
         prHctVF/CRaIHSa5oCzb5XctIV9tlTQ4JnJPIhHvWkwKg3TViBbsB1phf4SdTw3AthQl
         vOLBKFOV+9aAlUCmKSNKUNanV9UhvH9FcvHJggXlhvjUaQ7kBhf+tGmVZUS2dS05ZW/1
         c/H0YMWQBiy6xHyQH3ynBaxBaF0d5o2PCrbhP6IjlCG1lYpVi5X0qTUuNWdLiGGAjRv0
         o5SQTPT5a2ZWojr2rhu0N/i55j/mXIKtZBe0u1j2RUsna4AMcAg7RhzetlvEkOJy/zfC
         52mw==
X-Gm-Message-State: AA+aEWbm3BMERc8XECEAWVbB3oqF+Yew6oUCyIeZ9EC30jx9A7mhJ96T
        gE5unJhnCk/OxUm8rGZ1NG4ZLholEbESN0/SlYyH6w==
X-Google-Smtp-Source: AFSGD/Xw0RnpyhZXqCAo4nq9zBEWU3TaFToZsu5KWDyOEUFHnytyhanjVrKFx27KXTBXPcD101ftWHTxn8UMCXJyT4U=
X-Received: by 2002:a9d:5549:: with SMTP id h9mr4631361oti.83.1543630127325;
 Fri, 30 Nov 2018 18:08:47 -0800 (PST)
MIME-Version: 1.0
References: <20181128193636.254378-1-brendanhiggins@google.com>
 <20181128193636.254378-2-brendanhiggins@google.com> <20181130032802.GG18410@garbanzo.do-not-panic.com>
In-Reply-To: <20181130032802.GG18410@garbanzo.do-not-panic.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 30 Nov 2018 18:08:36 -0800
Message-ID: <CAFd5g45F0RViYDQyXRwyxVPAU=CO_Goqy3yHz=BbcMeAT7o6-g@mail.gmail.com>
Subject: Re: [RFC v3 01/19] kunit: test: add KUnit test runner core
To:     mcgrof@kernel.org
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
        Knut Omang <knut.omang@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 7:28 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> > +static void kunit_run_case_internal(struct kunit *test,
> > +                                 struct kunit_module *module,
> > +                                 struct kunit_case *test_case)
> > +{
> > +     int ret;
> > +
> > +     if (module->init) {
> > +             ret = module->init(test);
> > +             if (ret) {
> > +                     kunit_err(test, "failed to initialize: %d", ret);
> > +                     kunit_set_success(test, false);
> > +                     return;
> > +             }
> > +     }
> > +
> > +     test_case->run_case(test);
> > +}
>
> <-- snip -->
>
> > +static bool kunit_run_case(struct kunit *test,
> > +                        struct kunit_module *module,
> > +                        struct kunit_case *test_case)
> > +{
> > +     kunit_set_success(test, true);
> > +
> > +     kunit_run_case_internal(test, module, test_case);
> > +     kunit_run_case_cleanup(test, module, test_case);
> > +
> > +     return kunit_get_success(test);
> > +}
>
> So we are running the module->init() for each test case... is that
> correct? Shouldn't the init run once? Also, typically init calls are

Yep, it's correct. `module->init()` should run once before every test
case, reason being that the kunit_module serves as a test fixture in
which each test cases should be run completely independently of every
other. init and exit is supposed to allow code common to all test
cases to run since it is so common to have dependencies needed for a
test to be common to every test case.

Maybe it is confusing that I call it kunit_module? Maybe I should call
it kunit_fixture or something?

> pegged with __init so we free them later. You seem to have skipped the
> init annotations. Why?

Like I said above, these aren't normal init functions. A
kunit_module->init() function should run once before each test case
and thus should reside in the same linker section as any other KUnit
test code.

Cheers
