Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49018C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 22:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 165A221B1C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 22:07:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pZEm6UUP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393283AbfBNWHc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 17:07:32 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41702 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391475AbfBNWHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 17:07:31 -0500
Received: by mail-ot1-f66.google.com with SMTP id u16so13239443otk.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 14:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4s87I945vp3xG0mbdM3nwNX7yL1kZ/Kd3XYHc/LFqj8=;
        b=pZEm6UUPmGjv3BwZ8vq+8h8I7M5+2o42o/ZK+94rEJ+3eDeA8g1bKu6FScnnrKTpr8
         fieW+hPZeKwP0YGLMLFJAOinMdslIfzhqS86z0xACgL1eiOeFvp5qgzSgqCaP38HKnak
         Edugqn1ScawUoy5ZkH7YKlumvkv2qwaI+kGpyeYV/0386zvfefUO6U/t18IjScl5Ofgl
         uwB8Vtri1gUCEIQ6pl1onWnsTtnZAzYfrggk0lH4evwsmt/N/N1xWgrmgf690SEJejSs
         UV15mVH6l2esQ9ULvxZmvo7FCE43v9MlDCUu8E6XUV5uM5k6feSrVH5wW/sGhxz9RHCS
         y7pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4s87I945vp3xG0mbdM3nwNX7yL1kZ/Kd3XYHc/LFqj8=;
        b=SVcmdQk5BGi7oCGHcaM9UYaXkvGtqsTTUCVeOA1r0xKqbXEF48U27CLX0ib6zcByjE
         HJTbJvRjzy0MHaNOcWqCJ9Z1ks6ZaWyKeGa0HnulcdlRhHVXvwQRgMFMngm+/dCEvPZ8
         hoVrcpnkg1N558pW/MrBbHDvSPC5ggdhBMygHAemFYEJn9XMhUAgEoSNPMX2f09prrDu
         frSyLachUZf4RSILeX5aKyfOzhScZiNP0zud/Bpi0BTEtRpBaBq8ZCPRyf14+k8AEwMx
         tmkNJinn6xoumrCshNLwOwnE9u568QiOh7V7QqswqK0e6aOR/yP4Kby6jBxjd025AHb2
         0dEQ==
X-Gm-Message-State: AHQUAubtCsBc7PcjxkFL7dx42zS6EwCqiB7PHgDz8GYh9JokoVbP2KZ0
        A3IN2TTp2aVD3xqv33CNYCMPaF55FIrut5r2t4OklQ==
X-Google-Smtp-Source: AHgI3IYMELFD9PdYSOsXuSdmGNqMjB3UwWy8Ai3I49903X3bnkqhiNMg0snBsYJ0YFHfj3wZ9tIInIVO1xrENCgTfag=
X-Received: by 2002:a9d:7493:: with SMTP id t19mr3729381otk.98.1550182049939;
 Thu, 14 Feb 2019 14:07:29 -0800 (PST)
MIME-Version: 1.0
References: <20181128193636.254378-15-brendanhiggins@google.com>
 <b4c72234-8c56-6efa-8003-f89d99a9779e@ideasonboard.com> <20181130034525.GP18410@garbanzo.do-not-panic.com>
 <CAFd5g47Cew6pmebsopjzmkd4RpnnC3zLAUfxCybjdhrO35OBpQ@mail.gmail.com>
 <0927c42a-8e65-f410-e6ed-27576572577f@ideasonboard.com> <CAFd5g44fKzriEs_pGyANxe7GuC9Ji2SD7EEz76__h8q9jjg8yA@mail.gmail.com>
 <57c3dc86-236f-e981-249a-8bbfe5c19f0e@ideasonboard.com> <CAFd5g46AEquMKzfrjLDVi+PP5-7aGs6C6pCunGAXDn3VRkJP+g@mail.gmail.com>
 <eade3052-0aa4-90b4-d55b-8c44556f98bc@ideasonboard.com> <CAFd5g46cO_rZYjqKu6CooKcV-uAsCUJjuib38cQv6WHQS3ooaA@mail.gmail.com>
 <20190214172639.GD11489@garbanzo.do-not-panic.com>
In-Reply-To: <20190214172639.GD11489@garbanzo.do-not-panic.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 14 Feb 2019 14:07:18 -0800
Message-ID: <CAFd5g46BG=-sjA+ZFz_F-2wEGrD_mhU-W+kHsr1rGsKEv2YtJw@mail.gmail.com>
Subject: Re: [RFC v3 14/19] Documentation: kunit: add documentation for KUnit
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@google.com>, shuah@kernel.org,
        Joel Stanley <joel@jms.id.au>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Joe Perches <joe@perches.com>, brakmo@fb.com,
        Steven Rostedt <rostedt@goodmis.org>,
        "Bird, Timothy" <Tim.Bird@sony.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        linux-um@lists.infradead.org, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Rob Herring <robh@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Knut Omang <knut.omang@oracle.com>,
        Felix Guo <felixguoxiuping@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 9:26 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Wed, Feb 13, 2019 at 04:17:13PM -0800, Brendan Higgins wrote:
> > On Wed, Feb 13, 2019 at 1:55 PM Kieran Bingham
> > <kieran.bingham@ideasonboard.com> wrote:
> > Oh, yep, you are right. Does that mean we should bother at all with a defconfig?
>
> If one wanted a qemu enabled type of kernel and also for kuniut one
> could imply run:
>
> make kvmconfig
> make kunitconfig
>
> That would get what you suggest above of default "bells and whistles"
> and keep the kuniut as a fragment.
>
> Hm, actually the kvmconfig doesn't really enable the required fragments
> for qemu, so perhaps one would be good. It would have the serial stuff
> for instance.
>
> > Luis, I know you said you wanted one. I am thinking just stick with
> > the UML one? The downside there is we then get stuck having to
> > maintain the fragment and the defconfig. I right now (in the new
> > revision I am working on) have the Python kunit_tool copy the
> > defconfig if no kunitconfig is provided and a flag is set. It would be
> > pretty straightforward to make it merge in the fragment instead.
>
> Up to you in the end.

I don't really have any opinions on the matter; I don't really use
defconfigs in any of my workflows. So, I just want whatever is easier
for people. The thing that makes the most sense to me would be to
provide a "merge-kunitconfig" option similar to what kselftest does,
but I don't intend on doing that in the initial patchset, unless
someone really thinks that I should do it. So in the meantime, I guess
provide both since that gives people options?

In anycase, I just (finally) sent out v4, so I suggest we continue the
discussion over there.

Cheers
