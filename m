Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 113ADECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 17:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A118420883
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 17:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MX+3wk9j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A118420883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbeIPWic (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 18:38:32 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:35953 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727394AbeIPWib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 18:38:31 -0400
Received: by mail-vs1-f68.google.com with SMTP id z19-v6so2075650vso.3;
        Sun, 16 Sep 2018 10:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i49dArdacxzzu8mTgtYAt2Lt9rDnQ/ZSCIiSJxCGWlo=;
        b=MX+3wk9jI1x4BUh0L2xKi1sn519FzP5eNS8aWubNVh84+JJtcNrHX1eSLA9tinNuAb
         Stx718y6D8SdsSbafhfwVcsmpmGkjdlIG7ua6P2iTcE5PWW6Nws5AYRsrST24cyH1Wy3
         iviyJiC/2OTxBRsQdn7nSgZu0a8uoeclKFUHbUt+QHJX0t0v2ETwYdZvMNCSlccXXtHN
         +rd2JKmaZLPwleZ8hqL6lGaE7L5fHaunKy76LQW4GihdeTwODTRBIOaOaQIeKlgUk2+D
         j/ePl4kEjQ0wm3+mbZFmmeehaFqxiPWSiBupBwTNAuuRZBXToSQdWtyR7Unmh9qGuW0H
         8Rmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i49dArdacxzzu8mTgtYAt2Lt9rDnQ/ZSCIiSJxCGWlo=;
        b=B14QwpWrILGKMDoUDHCshm94qET5TDu83GiCqiDn7Q+VpuFckFWujr5VOSPs70Hdo8
         VrRb+0wOrCLqis+zmCbeAGp9dFTnvUWn/pd70yxP1vawS3f+sZNvcw5d3dyVyFESR61X
         xfG5OtdVHW+6X7woSsJtHlWm/XHtE7XJoDPPeAKMst8Qb9KoiyVBT4n4pUCgmezDCLBY
         bXdOM6c+yboL+gPufiE4MkfcFT/HW2MCpjywQXb1Fln7yYqRVfCXsWVeaJRIprkBf5Xs
         mwlgf1Zo3sckmbyoms1HSEnMmSInzCPMhjtahzLSgyCRne2VPI4G+iPQG7LY2q541+gz
         EsDA==
X-Gm-Message-State: APzg51DSGGl75R+u5u4FYUpHKFv2SOZ7jx+/lM7KiJ820VupCebEyVMO
        h6HPr7pAw6sRSV3j+LMbfYk368SHdIwsOJa9I0k=
X-Google-Smtp-Source: ANB0VdaNWPCNZm/8OJEVdBUDIVJeWRLX0lfbqdcl2kOFaf4015gsI3ohbtbFi1YYQ/i/krF/OK8r/yBWNmHzbgTc74Q=
X-Received: by 2002:a67:4991:: with SMTP id d17-v6mr6917673vsg.41.1537118095964;
 Sun, 16 Sep 2018 10:14:55 -0700 (PDT)
MIME-Version: 1.0
References: <1536516257-30871-1-git-send-email-s.mesoraca16@gmail.com> <20180909191903.GA2344@ravnborg.org>
In-Reply-To: <20180909191903.GA2344@ravnborg.org>
From:   Salvatore Mesoraca <s.mesoraca16@gmail.com>
Date:   Sun, 16 Sep 2018 19:14:44 +0200
Message-ID: <CAJHCu1++7sJv88Qg4wtx-AhfmQCbjy2psxuoePz2YViLNu-ahA@mail.gmail.com>
Subject: Re: [PATCH v2] kconfig: add hardened defconfig helpers
To:     sam@ravnborg.org
Cc:     Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        corbet@lwn.net, keescook@chromium.org, labbott@redhat.com,
        yamada.masahiro@socionext.com, michal.lkml@markovi.net,
        ebiederm@xmission.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Hi Salvatore.

Hi Sam

> On Sun, Sep 09, 2018 at 08:04:17PM +0200, Salvatore Mesoraca wrote:
> > Adds 4 new defconfig helpers (hardenedlowconfig, hardenedmediumconfig,
> > hardenedhighconfig, hardenedextremeconfig) to enable various hardening
> > features.
> > The list of config options to enable is based on KSPP's Recommended
> > Settings and on kconfig-hardened-check, with some modifications.
> > These options are divided into 4 levels (low, medium, high, extreme)
> > based on their negative side effects, not on their usefulness.
> > 'Low' level collects all those protections that have (almost) no
> > negative side effects.
> > 'Extreme' level collects those protections that may have so many
> > negative side effects that most people wouldn't want to enable them.
> > Every feature in each level is briefly documented in
> > Documentation/security/hardenedconfig.rst, this file also contain a
> > better explanation of what every level means.
> > To prevent this file from drifting from what the various defconfigs
> > actually do, it is used to dynamically generate the config fragments.
>
> In the above you nicely describes what is done.
> But there is nothing about the target group for this feature.
> Who will benefit from this?

Sometimes people ask about kernel hardening features, that's the
reason why the KSPP's list and the kconfig-hardened-check script were
written.
Unfortunately, kernel features with security implications have often
misleading names and descriptions and are scattered around the
menuconfig.
This patchset will help anyone who want to have an "hardened kernel"
but isn't following kernel development closely enough to know about
all the features.
On one hand, this will provide an official and understandable list of
hardening features inside the kernel doc, on the other hand it also
provide a fast and easy way to enable those features all at once.

> With respect to the actual implmentation we now
> have two ways to handle config fragments.
> Current solution is to save the config fragments in kernel/configs.
> And the new solution is to parse the config fragments from an rst file.
> The changelog fails to mentions why we need a new way to handle
> the config fragments.

The reason why I'm doing it like this is that I want both the config
fragments and the doc in the kernel.
Generating the fragments from the doc is the best way to make sure
that they will always do what the doc says.

> If we want to go the "parse from rst file" way - can it then
> be abstracted in a way so this is the only way to handle
> these in-kernel config fragments?
> And then move the current config fragment to the new way.
>
> It most be possible with a little careful design to make this
> a general solution and not a hardening thing only.

I don't know if maintainers of the other fragments care at all about
having every single option documented in detail.
For hardening features it makes sense, because people may want to just
learn about them and enable them manually.
I don't know if this is common or desirable for other config fragments.

Thank you for you comment,

Salvatore
