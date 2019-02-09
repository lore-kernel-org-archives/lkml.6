Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E4DBC169C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C602520855
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sRYdcdA8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbfBIA4r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 19:56:47 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44205 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbfBIA4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 19:56:47 -0500
Received: by mail-ot1-f67.google.com with SMTP id e24so8912225otp.11
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 16:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yp7edThPT1PyrBkFC38ySq+JVx70JcEvihKyDRoM37Q=;
        b=sRYdcdA8OhrfMS/N6X63JZP6zOjqS3E3XLAAOSDezNKjC5uNOTsJu1iAUIycOw8QWn
         K7pSO3vA5MMWzpCsJYB+KYv7HCM2iiTdU/Sd5IdIUIaDrD+ehH1ANCcmT3Z7EWn88J1c
         apLKEbM/Rvat/f6aqZWsto+oucmfmMwNjDvZaP+Wa0WnG6yFn6pEnkfXmdIqhfh3+3aj
         WMdE6jlFa+VqbLKpPqYPCN/+vUKQpvg/sNnUT64kexpLsJtGkiVvrT3H/SQ2fbsBZvgj
         xYFsgsOjQ9FL4nWTKdu7F+mnfmNruUzGfGNXX2SrnAzclWa8WoS89FYou5jxZbOwWv6a
         gHeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yp7edThPT1PyrBkFC38ySq+JVx70JcEvihKyDRoM37Q=;
        b=BmBs5dZb4UwL/K8zVazfdBJUwGWT1KTMwePpTZ27EkGimzX06zGtgVuFlfKdMuRy2Z
         hZbKL4ziyKf0TsfDCwrQWLNX/S82OO180jak7W1jaVz03rDqSId3AgdOIWcSLEDEnKTd
         3EuztzNv7SLerKzCsEN5I1jHRO5ZEUPd+ENCJ0IYqwtQx4j80xdlb3utshVfhzd9830T
         acZjDfjlXuR/6SU4Oggo7DqYnwXFqgVi7SrQ8LdS3296dsbuFdWo4X5oKgPWv3naTlaK
         iziKTVbhxvNGxXkKIQMbBoI8yQ8xeXBhBs1NjP4Y1cwEunAudIgEKvKAFCA2pLQcWpdO
         grBA==
X-Gm-Message-State: AHQUAuZj5uBUVSOSioyPEcN7KCpNNhWcKTkCsZJWpfJ7t5G9cXl8iPaW
        mTfGCpLMPrALSmabGnGOhW5a3c8WoewdHtnZXp+JDA==
X-Google-Smtp-Source: AHgI3IaZv6BiTnKhgi/TvLOxXsUYoA8irM4f1hTtn3rPa3uO8HK9R4qf4/idQZSOFJmSsS0zRDYdUE0DHryQTpqx7K4=
X-Received: by 2002:a9d:7285:: with SMTP id t5mr16514861otj.228.1549673805806;
 Fri, 08 Feb 2019 16:56:45 -0800 (PST)
MIME-Version: 1.0
References: <20181128193636.254378-1-brendanhiggins@google.com>
 <20181128193636.254378-15-brendanhiggins@google.com> <b4c72234-8c56-6efa-8003-f89d99a9779e@ideasonboard.com>
 <20181130034525.GP18410@garbanzo.do-not-panic.com> <CAFd5g47Cew6pmebsopjzmkd4RpnnC3zLAUfxCybjdhrO35OBpQ@mail.gmail.com>
 <0927c42a-8e65-f410-e6ed-27576572577f@ideasonboard.com>
In-Reply-To: <0927c42a-8e65-f410-e6ed-27576572577f@ideasonboard.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 8 Feb 2019 16:56:34 -0800
Message-ID: <CAFd5g44fKzriEs_pGyANxe7GuC9Ji2SD7EEz76__h8q9jjg8yA@mail.gmail.com>
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

On Thu, Dec 6, 2018 at 4:16 AM Kieran Bingham
<kieran.bingham@ideasonboard.com> wrote:
>
> Hi Brendan,
>
> On 03/12/2018 23:53, Brendan Higgins wrote:
> > On Thu, Nov 29, 2018 at 7:45 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >>
> >> On Thu, Nov 29, 2018 at 01:56:37PM +0000, Kieran Bingham wrote:
> >>> Hi Brendan,
> >>>
> >>> Please excuse the top posting, but I'm replying here as I'm following
> >>> the section "Creating a kunitconfig" in Documentation/kunit/start.rst.
> >>>
> >>> Could the three line kunitconfig file live under say
> >>>        arch/um/configs/kunit_defconfig?
>
>
> Further consideration to this topic - I mentioned putting it in
>   arch/um/configs
>
> - but I think this is wrong.
>
> We now have a location for config-fragments, which is essentially what
> this is, under kernel/configs
>
> So perhaps an addition as :
>
>  kernel/configs/kunit.config
>
> Would be more appropriate - and less (UM) architecture specific.

Sorry for the long radio silence.

I just got around to doing this and I found that there are some
configs that are desirable to have when running KUnit under x86 in a
VM, but not UML. So should we have one that goes in with
config-fragments and others that go into architectures? Another idea,
it would be nice to have a KUnit config that runs all known tests
(this probably won't work in practice once we start testing mutually
exclusive things or things with lots of ifdeffery, but it probably
something we should try to maintain as best as we can?); this probably
shouldn't go in with the fragments, right?

I will be sending another revision out soon, but I figured I might be
able to catch you before I did so.
