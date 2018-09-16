Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72EEDECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 17:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 024C320867
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 17:44:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jc2QnJjd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 024C320867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbeIPXIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 19:08:01 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:34869 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728239AbeIPXIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 19:08:01 -0400
Received: by mail-ua1-f67.google.com with SMTP id m26-v6so9400152uap.2;
        Sun, 16 Sep 2018 10:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qyCAQBduW8usSXdIAhYZPUboQwDlVu/e443hExwHrM0=;
        b=jc2QnJjdIeDD/9OZhb6gVx2j0PeWUJ0uasnqWANcR1ST6UPJTvS0CayTTcsxoZ2H1L
         M6TA1pLvLNPlG7nRE4SORAmZ4FMJATap+Fn6omfDZLZ9nT98djWm48gi10IG5Ie8jXQO
         SEOqpb/yAOI1SYL15QHHrz2d7ify2HZyh56tje6WvqWBVIbddlJOadg+lW2wDIboMawq
         OX0BTRG5kdTrRGv37laLQp+fLxMrGiong5e79FtbowWBd3Pr5aVRTAt9Hdj1I4gyk1m6
         GKKNyX2Yy7TC3hDfIg+FR0hsbzNt9FT76j4dmA6+21Msy9sJa7NnmtZXfLV5bG1JWFg4
         QQAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qyCAQBduW8usSXdIAhYZPUboQwDlVu/e443hExwHrM0=;
        b=eO4IijVq+SC5myC8BrpSPyommkWOVSKnser6UkH7Q9nH4c9WSJLLOH9s41EiKNW7t7
         9xE5vdJTUOc1DdoA8ooGAo+nF6GRYJyy8poJPI/I/hZnf4+Gjrf9f6+uW7y79AsXpkxw
         B/DG+GOmamQ/SzjXzqjdfKR283AxAlM9y1BEholQIYBMbTNJqTz1kgFJjASSmKJOaG3G
         e5VWPFQHhTO//vX+JVW4zKjZbAkoPqtkCBoXl9lubpPYrK9+FR4k6iPS/n8mqC9b2kEK
         xCyiQCEXlShoBVNMugFMPf68+Vq5nSXtFIFzE7kXj7R+gUnoWAoM7E0PVYIkWzCOUQXe
         Yhmg==
X-Gm-Message-State: APzg51DFdHVJIY/8JUMTfUomGk8qgUZhw9HHduPN1yupaHjCWXkd07Qv
        4ESEQ0SPqxrXjPPfmUEpurNpSubmvj0COXCZQbY=
X-Google-Smtp-Source: ANB0VdZD5v2/WxE1EiiLSif+jBNqolrBizANPYceZw3tDGKP1MjslyqF9HzTohJO5xunDtR0hHPPH+0TMJRhjwIqHI0=
X-Received: by 2002:ab0:6a6:: with SMTP id g35-v6mr6448305uag.16.1537119861042;
 Sun, 16 Sep 2018 10:44:21 -0700 (PDT)
MIME-Version: 1.0
References: <1536516257-30871-1-git-send-email-s.mesoraca16@gmail.com>
 <20180909191903.GA2344@ravnborg.org> <CAK7LNATP_3K0KYyW51K3mqHs-WiReJWMeB82Uxikh+zUqDKQ6A@mail.gmail.com>
In-Reply-To: <CAK7LNATP_3K0KYyW51K3mqHs-WiReJWMeB82Uxikh+zUqDKQ6A@mail.gmail.com>
From:   Salvatore Mesoraca <s.mesoraca16@gmail.com>
Date:   Sun, 16 Sep 2018 19:44:09 +0200
Message-ID: <CAJHCu1JtS2nTaxCbSDOvUYZe2Lf2LpcOvhBE00vX6XiFEH_hZg@mail.gmail.com>
Subject: Re: [PATCH v2] kconfig: add hardened defconfig helpers
To:     yamada.masahiro@socionext.com
Cc:     sam@ravnborg.org,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        corbet@lwn.net, keescook@chromium.org, labbott@redhat.com,
        michal.lkml@markovi.net, ebiederm@xmission.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
>
> 2018-09-10 4:19 GMT+09:00 Sam Ravnborg <sam@ravnborg.org>:
> > Hi Salvatore.
> >
> > On Sun, Sep 09, 2018 at 08:04:17PM +0200, Salvatore Mesoraca wrote:
> >> Adds 4 new defconfig helpers (hardenedlowconfig, hardenedmediumconfig,
> >> hardenedhighconfig, hardenedextremeconfig) to enable various hardening
> >> features.
> >> The list of config options to enable is based on KSPP's Recommended
> >> Settings and on kconfig-hardened-check, with some modifications.
> >> These options are divided into 4 levels (low, medium, high, extreme)
> >> based on their negative side effects, not on their usefulness.
> >> 'Low' level collects all those protections that have (almost) no
> >> negative side effects.
> >> 'Extreme' level collects those protections that may have so many
> >> negative side effects that most people wouldn't want to enable them.
> >> Every feature in each level is briefly documented in
> >> Documentation/security/hardenedconfig.rst, this file also contain a
> >> better explanation of what every level means.
> >> To prevent this file from drifting from what the various defconfigs
> >> actually do, it is used to dynamically generate the config fragments.
> >
> > In the above you nicely describes what is done.
> > But there is nothing about the target group for this feature.
> > Who will benefit from this?
> >
> > With respect to the actual implmentation we now
> > have two ways to handle config fragments.
> > Current solution is to save the config fragments in kernel/configs.
> > And the new solution is to parse the config fragments from an rst file.
> > The changelog fails to mentions why we need a new way to handle
> > the config fragments.
>
>
> I agree.
>
> Another new way this patch added is,
>
>  CONFIG options are now described in the ReST document,
>  but our current way is to describe the detailed information
>  in the 'help' section in Kconfig files.

This is true, but hardening features are quite different from other
types of features or config options, because they can't be easily
found, unless you already know what you are looking for.
Many people need a single place that lists them all, clearly
explaining why they might want them or not without having to bounce
around different Kconfig parts.

Thank you for your time,

Salvatore
