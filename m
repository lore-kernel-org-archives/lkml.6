Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DDA9C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 02:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8DF820834
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 02:14:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c3uRybvE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8DF820834
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbeLANZu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 08:25:50 -0500
Received: from mail-ot1-f47.google.com ([209.85.210.47]:43980 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbeLANZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 08:25:50 -0500
Received: by mail-ot1-f47.google.com with SMTP id a11so6889930otr.10
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 18:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YzeU1Ye4+oHzQyr/YW+6VEBlXSN0V4JOdZWyjaPCZI0=;
        b=c3uRybvEyYWdvNiNFl2CqNH2PaUd+jrW0/3HGbBJmdTe7vMyIuZv6UDqmViBTlUYJ8
         0ksthYdYjVPGxRF57H9dYlTbhygbOlT7hKa3trw7STa3xpis2kf3yzg0VW4mvCRbOn/g
         D3p3nrxRZg/arHbMkFUeHymu2COF2i0ORbU3OFaFdBSfY9GjG0jkI2+xSXg3+s9uUlIs
         lJpX8xDoPGAhpPddDVgZMeK5GQhRO0tIw7+wgKe/BqGwlmuaui0HJdVKeO3o55itycBP
         QesMbp/s7JTuM+LBUaUYXmisgxL5BAoWrMUyhyLG5lTTWOXcL/uh2enJUL8lyVIcywEW
         +HkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YzeU1Ye4+oHzQyr/YW+6VEBlXSN0V4JOdZWyjaPCZI0=;
        b=mC76uHlhLIzv/J4cXtQj2nJ9vwLnO8OQ1I1vwZTn/lpUQloZ27l+hA3/eQN2w64sbx
         5Mzwp0a8anFOTLLg18Vd4YMaA7m4ysrvcuJiOuyYyt4gUZj2rT8TWm96s7UqudWBOvQl
         ziCfgOpjzC+BgXtmchNTDmrdMl3Fs245Fwvi7xv7C6/78HPrMl+bFEewYszWdpCG3279
         1phNZ9Q5VXEZFgGrZuUwuddyoflfKC5IVRg7Q7j5DPGRrK9oQdOkYHnBn7XtGhAcdKLJ
         ZrYI85Ij2MYEqM5Krp7GJbSBgBkpVEAo2mh6LB6DQylGw5zoQxt+anUXXjTEunSQehpt
         DoJA==
X-Gm-Message-State: AA+aEWZx7Jx2UOmnYECvbaEV7CpQezBhfuwEDQg9qGwJhAQMkvzPLS6U
        3+Bui24UpTBQRPNw7EedIVt0QV/VoUg9gmAjNCCDuA==
X-Google-Smtp-Source: AFSGD/UgUXHnTsOu2XJDv5cK0zMUzTIZBNvLRM6OS4Y2Yeyvslmt/YuRYKVHwv3Ru7/qwdD3Cm2XMeIpgUjWdboXSnk=
X-Received: by 2002:a05:6830:1005:: with SMTP id a5mr4713308otp.113.1543630468498;
 Fri, 30 Nov 2018 18:14:28 -0800 (PST)
MIME-Version: 1.0
References: <20181128193636.254378-1-brendanhiggins@google.com>
 <20181128193636.254378-4-brendanhiggins@google.com> <20181130032924.GH18410@garbanzo.do-not-panic.com>
In-Reply-To: <20181130032924.GH18410@garbanzo.do-not-panic.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 30 Nov 2018 18:14:17 -0800
Message-ID: <CAFd5g46AXpnoWpm+aFNfvNm2-As5RCO7QdMPhcOMXWRPwHqrGg@mail.gmail.com>
Subject: Re: [RFC v3 03/19] kunit: test: add string_stream a std::stream like
 string builder
To:     mcgrof@kernel.org
Cc:     pmladek@suse.com, Greg KH <gregkh@linuxfoundation.org>,
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

On Thu, Nov 29, 2018 at 7:29 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Wed, Nov 28, 2018 at 11:36:20AM -0800, Brendan Higgins wrote:
> > A number of test features need to do pretty complicated string printing
> > where it may not be possible to rely on a single preallocated string
> > with parameters.
> >
> > So provide a library for constructing the string as you go similar to
> > C++'s std::string.
>
> Hrm, what's the potential for such thing actually being eventually
> generically useful for printk folks, I wonder? Petr?

Are you saying you think this is applicable for other things? Or are
you saying that you are afraid that somebody might try to use this
elsewhere?

In the former case, this doesn't belong here. In the latter case, it
explicitly depends on KUnit, so it is only available when running
tests.

Cheers
