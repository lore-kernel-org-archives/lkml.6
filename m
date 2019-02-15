Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 080E4C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC054222D0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550259881;
	bh=JK29Q39fiSwoZaHcnoTGhvUEmEYahFBdbQGssW0nU5s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=PHFoXkKyCap15pDOgp6f2vsEaqbZtzeVzH3z3LWAke6R/kVoiHOjsQiDY4s08sTsw
	 Ma4VwrSlFVhJIxlYKY+SWR7DgywxWDSmuVcgT+n/FS6ST2tgOMxGKyOWKftBCHH0na
	 kFdF1YYR6/5A9xz3EeqHOHL0p4/X5je7bNJ9juGE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732120AbfBOTok (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 14:44:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:55902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729324AbfBOTok (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 14:44:40 -0500
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47D2F222D0;
        Fri, 15 Feb 2019 19:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550259879;
        bh=JK29Q39fiSwoZaHcnoTGhvUEmEYahFBdbQGssW0nU5s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZbjScxZr0+x8BQOBxcTBHk7+ujjXGVblld/G3TANS1xPFuHGVx9vFJSFHBVgmkOPT
         QtCCdVoBnwkpwybqknK/Cl+mhqcuUyJFbguNAAJkvtDF6NC/e7Jk+niTBr7BhflBka
         MIaWcXCSaKQO1QbM5073xSlQJ93h7RTr7yrDuc1g=
Received: by mail-qt1-f181.google.com with SMTP id y20so12189386qtm.13;
        Fri, 15 Feb 2019 11:44:39 -0800 (PST)
X-Gm-Message-State: AHQUAubgCLopxbcX5RffyIN+j09iAPX9W3OGK0j1k6k/fFc0RC4cZZi5
        XC+hx8sXz9R/hgovacat3lnmhyxn7XyTEy1m8A==
X-Google-Smtp-Source: AHgI3IawBsytk/xTAbcvMlsA61VaA21L0YYyND0QGBdH6hhjHlyEXkokdur3YxB8UWESAE23npLDY+9nOjV7M7Oftyk=
X-Received: by 2002:ac8:2f4e:: with SMTP id k14mr8801359qta.76.1550259878502;
 Fri, 15 Feb 2019 11:44:38 -0800 (PST)
MIME-Version: 1.0
References: <20190212185305.112847-1-brendanhiggins@google.com>
 <20190212185305.112847-2-brendanhiggins@google.com> <4cb7ca12-ce60-7516-b7eb-aef08f607acc@gmail.com>
 <CAFd5g441+6ATUKcNz7OstAB6Qd2BqeDh77SNnGUpZGBNvgysmg@mail.gmail.com>
 <bfa00740-9b67-58f9-6273-3de98de952f6@gmail.com> <CAFd5g44HkBLJmK8e4F+iaGPg1FEzubGtcUW-251GAOv1UmE5rg@mail.gmail.com>
In-Reply-To: <CAFd5g44HkBLJmK8e4F+iaGPg1FEzubGtcUW-251GAOv1UmE5rg@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 15 Feb 2019 13:44:26 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ8967v0-1scuWY0nMngiO=TxNL_bxgsP=hzO9SU-n2NQ@mail.gmail.com>
Message-ID: <CAL_JsqJ8967v0-1scuWY0nMngiO=TxNL_bxgsP=hzO9SU-n2NQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] of: unittest: unflatten device tree on UML when testing
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 3:49 AM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> On Thu, Feb 14, 2019 at 6:48 PM Frank Rowand <frowand.list@gmail.com> wrote:
> >
> > On 2/14/19 5:26 PM, Brendan Higgins wrote:
> > > On Thu, Feb 14, 2019 at 4:10 PM Frank Rowand <frowand.list@gmail.com> wrote:
> > >>
> > >> On 2/12/19 10:53 AM, Brendan Higgins wrote:
> > >>> UML supports enabling OF, and is useful for running the device tree
> > >>> tests, so add support for unflattening device tree blobs so we can
> > >>> actually use it.
> > >>>
> > >>> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > >>> ---
> > >>>  drivers/of/unittest.c | 3 +++
> > >>>  1 file changed, 3 insertions(+)
> > >>>
> > >>> diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
> > >>> index 84427384654d5..effa4e2b9d992 100644
> > >>> --- a/drivers/of/unittest.c
> > >>> +++ b/drivers/of/unittest.c
> > >>> @@ -2527,6 +2527,9 @@ static int __init of_unittest(void)
> > >>>       }
> > >>>       of_node_put(np);
> > >>>
> > >>> +     if (IS_ENABLED(CONFIG_UML))
> > >>> +             unflatten_device_tree();
> > >>> +
> > >>>       pr_info("start of unittest - you will see error messages\n");
> > >>>       of_unittest_check_tree_linkage();
> > >>>       of_unittest_check_phandles();
> > >>>
> > >>
> > >> (Insert my usual disclaimer that I am clueless about UML, I still need to learn
> > >> about it...)
> > >>
> > >> This does not look correct to me.
> > >>
> > >> A few lines earlier in of_unittest(), the live devicetree needs to exist for
> > >> unittest_data_data() and a few of_*() functions to succeed.  So it seems
> > >> that the unflatten_device_tree() for uml should be at the beginning of
> > >> of_unittest().
> > >
> > > It is true that other functions ahead of it depend on the presence of
> > > a device tree, but an unflattened tree does get linked in somewhere
> > > else. Despite that, this is needed for overlay_base_root. I got
> > > similar behavior if you don't link in a flattened device tree on x86.
> > > Thus, the order in which you call them doesn't actually seem to
> > > matter. I found no difference from changing the order in UML myself.
> > >
> > > Without my patch we get the following error,
> > > ### dt-test ### FAIL of_unittest_overlay_high_level():2372
> > > overlay_base_root not initialized
> > > ### dt-test ### end of unittest - 219 passed, 1 failed
> > >
> > > With my patch we get:
> > > ### dt-test ### end of unittest - 224 passed, 0 failed
> >
> > Thanks for reporting both the failure and the success cases,
> > that helps me understand a little bit better.
> >
> > If instead of the above patch, if you add the following (untested,
> > not even compile tested) to the beginning of of_unittest():
> >
> >         if (IS_ENABLED(CONFIG_UML))
> >                 unittest_unflatten_overlay_base();
> >
> > does that also result in a good test result of:
> >
> >         ### dt-test ### end of unittest - 224 passed, 0 failed
>
> Yep, I just tried it. It works as you suspected.
>
> >
> > I think I need to find some time to build and boot a UML kernel soon.
>
> It's really no big deal, just copy the .config I sent and build with
> `make ARCH=um` then you "boot" the kernel with `./linux` (note this
> will mess up your terminal settings); that's it! (Shameless plug: you
> can also try it out with the KUnit patchset with
> `./tools/testing/kunit/kunit.py --timeout=30 --jobs=12 --defconfig`,
> which builds the kernel with a pretty similar config, boots the
> kernel, and then parses the output for you. ;-) )
>
> >
> > My current _guess_ is that the original problem was not a failure to
> > unflatten any present devicetree in UML but instead that the UML
> > kernel does not call unflatten_device_tree() and thus fails to
> > indirectly call unittest_unflatten_overlay_base(), which is
> > called by unflatten_device_tree().
>
> I think you are right. Sorry for not noticing this before making my
> change. Since it was pretty much the only architecture (the only one I
> care about) that does not unflatten DT, I assumed that was the
> problem. I didn't put too much thought into it after that point beyond
> making sure that it did what I wanted.
>
> >
> > unittest_unflatten_overlay_base() is an unfortunate wart that I
> > added, but I don't have a better alternative yet.
>
> Hey, I get it. No worries.
>
> In any case, it seems like unittest_unflatten_overlay_base() is the
> right function to call there. I will send out patch. Do you want me to
> send a patch on top of this one, or do you want to revert this one and
> for me to send a v2 follow up to this patch? I don't care either way,
> whatever you guys prefer.

I'll drop or revert the existing one, so against mainline is good.

Rob
