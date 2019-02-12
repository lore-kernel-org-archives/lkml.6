Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B138C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 22:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB5D8222C9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 22:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LLaMH6EK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732621AbfBLWKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 17:10:23 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42804 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727957AbfBLWKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 17:10:23 -0500
Received: by mail-ot1-f68.google.com with SMTP id i5so474406oto.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 14:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9O2/IkWyIfgJRGgQaZRRzXiWeHa5Jq+fWzEMjBFagns=;
        b=LLaMH6EKK8IqTY6MIsKK1Gzh2Oltxex09z0iIEmJvPpBG6B05cRACzIK3Xi1Xy2bFl
         WSFRxCAgWoSTlHsItukVXBWRXL3jdi3M5T/XnNiI2Ep6PiAyO5QObLMEw6mLMekXSE6u
         4tmy9gbS5qUfHx73fWqKC4vKRTiKtQE5nAkJqj8UHhUcYwhqDE4sk+I/g42TjZQ7th93
         wS10IQ1Ylw4OBh/xlkGJlCevhipDjc/r0cBcfqbl5b0Yy8F8z6Bwg+OFBG9AA8uGZBxF
         8AJNRJDMS5jjk5VtNeFagtbew5lz3w17B5oN5k3S6JUlbeTHuUOLJ2B9kyvOKmFS8mmz
         uiMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9O2/IkWyIfgJRGgQaZRRzXiWeHa5Jq+fWzEMjBFagns=;
        b=AiVeBH0486vXURIP18SGI2eW7PXdXhbpne55DOmrtfQl1WBolL54avisZ08JCh7Uo3
         Ttg57xZwyxum7GZ1MRqz2Qj+lIdM/HNrmmMEI5o9RjmRgCQAxcsfmq7iJuO3CpCzBHLy
         4Ar9efEWH58eIsQ8D+7PG+tAjU7SPq2HtJb8MKHp5LSWT4QjpmJDeL8lzU27vrKA6P+r
         DQfeq1xGe7l9TPzj/YFEvK8nIyZ3/WaGcUpiqS229R6ha/KQC0dDvo+0t0swTGcdZ/NM
         Ovp5YqVhgvB9H7UK8s+SjUUuYuD2HTVtfPPawvrNpYvYld+tgGi1Q68R6CA81kBRF1C9
         ZcuA==
X-Gm-Message-State: AHQUAuYHmV+GpiFc3DJg8L//6QOpYMSRT5J6cI/zg/R0LkEsQYix2uLl
        KLWgoIFPwTBHnXZUCRf8mThvXKG1hYScLXdrecltLg==
X-Google-Smtp-Source: AHgI3IYBBmG3TCH4XkT+5DZwsuKBNFRN8kKQXFRKC31Zeug6iGjfLsc6/s/zPjPxAq6NF3z6g2/i6bzHeYH0al60TD8=
X-Received: by 2002:a9d:58cd:: with SMTP id s13mr5964252oth.25.1550009421323;
 Tue, 12 Feb 2019 14:10:21 -0800 (PST)
MIME-Version: 1.0
References: <20181128193636.254378-1-brendanhiggins@google.com>
 <20181128193636.254378-15-brendanhiggins@google.com> <b4c72234-8c56-6efa-8003-f89d99a9779e@ideasonboard.com>
 <20181130034525.GP18410@garbanzo.do-not-panic.com> <CAFd5g47Cew6pmebsopjzmkd4RpnnC3zLAUfxCybjdhrO35OBpQ@mail.gmail.com>
 <0927c42a-8e65-f410-e6ed-27576572577f@ideasonboard.com> <CAFd5g44fKzriEs_pGyANxe7GuC9Ji2SD7EEz76__h8q9jjg8yA@mail.gmail.com>
 <57c3dc86-236f-e981-249a-8bbfe5c19f0e@ideasonboard.com>
In-Reply-To: <57c3dc86-236f-e981-249a-8bbfe5c19f0e@ideasonboard.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 12 Feb 2019 14:10:09 -0800
Message-ID: <CAFd5g46AEquMKzfrjLDVi+PP5-7aGs6C6pCunGAXDn3VRkJP+g@mail.gmail.com>
Subject: Re: [RFC v3 14/19] Documentation: kunit: add documentation for KUnit
To:     Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@google.com>, shuah@kernel.org,
        Joel Stanley <joel@jms.id.au>, mpe@ellerman.id.au,
        joe@perches.com, brakmo@fb.com,
        Steven Rostedt <rostedt@goodmis.org>, Tim.Bird@sony.com,
        khilman@baylibre.com, Julia Lawall <julia.lawall@lip6.fr>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jdike@addtoit.com, richard@nod.at, linux-um@lists.infradead.org,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, Rob Herring <robh@kernel.org>,
        dan.j.williams@intel.com, linux-nvdimm@lists.01.org,
        Frank Rowand <frowand.list@gmail.com>,
        Knut Omang <knut.omang@oracle.com>,
        Felix Guo <felixguoxiuping@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 4:16 AM Kieran Bingham
<kieran.bingham@ideasonboard.com> wrote:
>
> Hi Brendan,
>
> On 09/02/2019 00:56, Brendan Higgins wrote:
> > On Thu, Dec 6, 2018 at 4:16 AM Kieran Bingham
> > <kieran.bingham@ideasonboard.com> wrote:
> >>
> >> Hi Brendan,
> >>
> >> On 03/12/2018 23:53, Brendan Higgins wrote:
> >>> On Thu, Nov 29, 2018 at 7:45 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >>>>
> >>>> On Thu, Nov 29, 2018 at 01:56:37PM +0000, Kieran Bingham wrote:
> >>>>> Hi Brendan,
> >>>>>
> >>>>> Please excuse the top posting, but I'm replying here as I'm following
> >>>>> the section "Creating a kunitconfig" in Documentation/kunit/start.rst.
> >>>>>
> >>>>> Could the three line kunitconfig file live under say
> >>>>>        arch/um/configs/kunit_defconfig?
> >>
> >>
> >> Further consideration to this topic - I mentioned putting it in
> >>   arch/um/configs
> >>
> >> - but I think this is wrong.
> >>
> >> We now have a location for config-fragments, which is essentially what
> >> this is, under kernel/configs
> >>
> >> So perhaps an addition as :
> >>
> >>  kernel/configs/kunit.config
> >>
> >> Would be more appropriate - and less (UM) architecture specific.
> >
> > Sorry for the long radio silence.
> >
> > I just got around to doing this and I found that there are some
> > configs that are desirable to have when running KUnit under x86 in a
> > VM, but not UML.
>
> Should this behaviour you mention be handled by the KCONFIG depends flags?
>
> depends on (KUMIT & UML)
> or
> depends on (KUNIT & !UML)
>
> or such?

Not really. Anything that is strictly necessary to run KUnit on an
architectures should of course be turned on as a dependency like you
suggest, but I am talking about stuff that you would probably want to
get yourself going, but is by no means necessary.

>
> An example of which configs you are referring to would help to
> understand the issue perhaps.
>

For example, you might want to enable a serial console that is known
to work with a fairly generic qemu setup when building for x86:
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y

Obviously not a dependency, and not even particularly useful to people
who know what they are doing, but to someone who is new or just wants
something to work out of the box would probably want that.

>
> > So should we have one that goes in with
> > config-fragments and others that go into architectures? Another idea,
> > it would be nice to have a KUnit config that runs all known tests
>
> This might also be a config option added to the tests directly like
> COMPILE_TEST perhaps?

That just allows a bunch of drivers to be compiled, it does not
actually go through and turn the configs on, right? I mean, there is
no a priori way to know that there is a configuration which spans all
possible options available under COMPILE_TEST, right? Maybe I
misunderstand what you are suggesting...

>
> (Not sure what that would be called though ... KUNIT_RUNTIME_TEST?)
>
> I think that might be more maintainable as otherwise each new test would
> have to modify the {min,def}{config,fragment} ...
>

Looking at kselftest-merge, they just start out with a set of
fragments in which the union should contain all tests and then merge
it with a base .config (probably intended to be $(ARCH)_defconfig).
However, I don't know if that is the state of the art.

>
> > (this probably won't work in practice once we start testing mutually
> > exclusive things or things with lots of ifdeffery, but it probably
> > something we should try to maintain as best as we can?); this probably
> > shouldn't go in with the fragments, right?
>
> Sounds like we agree there :)

Totally. Long term we will need something a lot more sophisticated
than anything under discussion here. I was talking about this with
Luis on another thread:
https://groups.google.com/forum/#!topic/kunit-dev/EQ1x0SzrUus (feel
free to chime in!). Nevertheless, that's a really hard problem and I
figure some variant of defconfigs and config fragments will work well
enough until we reach that point.

>
> >
> > I will be sending another revision out soon, but I figured I might be
> > able to catch you before I did so.
>
> Thanks for thinking of me.

How can I forget? You have been super helpful!

> I hope I managed to reply in time to help and not hinder your progress.

Yep, no trouble at all. You are the one helping me :-)

Thanks!
