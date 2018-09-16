Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC1EECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 17:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A27820867
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 17:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYN3NXqb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A27820867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbeIPXCq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 19:02:46 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:42969 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728108AbeIPXCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 19:02:46 -0400
Received: by mail-vs1-f65.google.com with SMTP id s188-v6so2080849vss.9;
        Sun, 16 Sep 2018 10:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lCit3YbuMsEoKKSgAnDSJgcl4i3h5GThqutwFDIqO8A=;
        b=UYN3NXqbXkgiH7tLY1+OgHu/GdT8rcTwvLeJs8MTgsPCXe6oxWXspBvOR9eh+vvOJf
         PalkUjF9YIMEBXuCqwcE1ZfW450eTAayr0BOdyns3vqWJGGDgtxhp0PHxlPZcgENIU0l
         eheG1AGda96uj37ypIoBKb08XZKRdHdUTwsKU/KSjYJj/aAsisHV369GPbq/poIlAVxf
         xWeytBBhtxgIeeP0TgQPwgG4gIeTGSGz0P5w0pz5J2ILy/jkUpAU2rEFiVmImM4d7tkH
         Nbrz/nSZG5l6HmzREu/EwCfZ0DkZuLWuvvBW5PChUTCbxefbEL2HfW5bTl2K6Mvz2wcR
         TUhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lCit3YbuMsEoKKSgAnDSJgcl4i3h5GThqutwFDIqO8A=;
        b=rnqpnYVegFkx39rbj3hJkBweuuwx8C43n0s/gtV+SvdvpnmQvMlhvgoFRV69bq7bs6
         t8J0yvlEVJSbEPrd/PCxeIjmzUDbnUSELaxZmv/8uMVx1OT1rLypPfTCfC+CZ0YJmoUv
         6FxsWTS1iGERbhKN3raxS8qGNOT0G54PzeoSJwoPefZ0LalOL+jWGqx8XFgYMduzkV4z
         8rkDc9fwV11PCeWJrM96DTbNPNZ0LmCSQL6AGeOdfFdmHhaLbZ//jFIdk+mr4u93c6EV
         DJrOv9ltehVhKMvkmF7AFsyCoyP/2j/JTUEpT2ubXZ7d8ADAA6mvfs6qimDI+/AE5aR/
         aMsQ==
X-Gm-Message-State: APzg51BL2wYvUpua0tSyCXCA0+pQU816LA6zYqfvS/ZhKGhgJymO/6bZ
        jXX58NUrEdPpjkmSwQs/6NEKR5xRQ0sudoay4EWW0FOjI5Y=
X-Google-Smtp-Source: ANB0VdZQtVLEZVZPwti12vhjyoe8J5iv8xCG7JbfBa6gOG2WN6BLDMcuBTHx2AQM3jPp0FjY2Csr2qtYyGpwqS6uS10=
X-Received: by 2002:a67:e414:: with SMTP id d20-v6mr6728946vsf.116.1537119547550;
 Sun, 16 Sep 2018 10:39:07 -0700 (PDT)
MIME-Version: 1.0
References: <1536516257-30871-1-git-send-email-s.mesoraca16@gmail.com> <20180909142741.3b87df76@lwn.net>
In-Reply-To: <20180909142741.3b87df76@lwn.net>
From:   Salvatore Mesoraca <s.mesoraca16@gmail.com>
Date:   Sun, 16 Sep 2018 19:38:56 +0200
Message-ID: <CAJHCu1J4+K3q2ce0k-hMOJdsSJ8yV+7iXROj0BjNgO87B_Hj+g@mail.gmail.com>
Subject: Re: [PATCH v2] kconfig: add hardened defconfig helpers
To:     corbet@lwn.net
Cc:     Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        keescook@chromium.org, labbott@redhat.com,
        yamada.masahiro@socionext.com, michal.lkml@markovi.net,
        ebiederm@xmission.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Corbet <corbet@lwn.net> wrote:
> [omissis]
>
> Some overall thoughts:
>
> - As Sam asked: who are the users of this feature?  Presumably you have
>   some real people out there in mind for each of these levels, or you would
>   not have created them?

In general this feature will be useful for all those people who are
interested in enabling hardening features on their kernel.
Maybe they are not so many, but they exist and are the reason why
KSPP's list and kconfig-hardened-check script were written.
Anyway, not everybody is willing to trade a lot of performance for security.
I hope that splitting features based on their negative impact will
increase the usage of those features which are more "usable", but
still not so known by many people.

> - Who will maintain it?  The list of hardening-relevant configuration
>   options is always in high flux, as our understanding of the security
>   implications of each.  This feature will require some significant ongoing
>   attention or it will quickly become stale.  I think it needs a
>   MAINTAINERS entry.

Good, I can add myself as maintainer, I also got Kees permission to
add him as designated reviewer too.

> - It's a little strange to see an RST document used as the input for the
>   kernel configuration process.  Assuming this is really the best way to do
>   this (and I worry about things like duplicated descriptions of kernel
>   configuration options), you should, at a minimum, carefully document the
>   format of this file at the beginning.  Otherwise people will surely break
>   it.  In fact, they'll break it anyway, so more checking in the processing
>   script seems indicated.

Yes, this approach is a bit "original". I think your suggestions are sensible.
I'll document better the format and add more checks to the script to
make it more resilient.

>   Without having thought it through in great depth, I suspect that a better
>   approach might be to find a way to mark the hardening level in the
>   Kconfig entries.

The reason why everything starts from an .rst is that I'd like to have
a doc page with a detailed list of all the hardening feature.
If the fragments aren't going to be generated from the doc we'll a way
to make sure that what is written in the doc is coherent with what
Kconfig is doing.
I'm don't think that it will be much better.

> - You have ordered the options alphabetically, but that is, I would argue,
>   not the best way.  My guess is that people would read this file to answer
>   the question of "just how many bullets will hardening level H put into my
>   foot?"  So I would sort them by hardening level as the primary key.

This seems reasonable, I'll change it.

Thank you for your time,

Salvatore
