Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2209C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 955EA20862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qdenJ8f7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 955EA20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732169AbeHAUpK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 16:45:10 -0400
Received: from mail-pf1-f172.google.com ([209.85.210.172]:45801 "EHLO
        mail-pf1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731900AbeHAUpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 16:45:09 -0400
Received: by mail-pf1-f172.google.com with SMTP id i26-v6so8315313pfo.12
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 11:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kuVctN/GQuAPPUnBvIjA3RbHquRoUy2PbM4UiFIBbwQ=;
        b=qdenJ8f7mHkvQSpR5yTEwwEyZ/JxL5GJfScEjZA/PQeBG8Knn/TMECfVJB8U//bL12
         RP5Jz691zCscmblvEJ1f8uO/8yTCtFK1UQfC+xkYWx6vzT94PqmgaM6VJgqPJhKed2Ss
         qx6jO3EIxfL7ouEDjcsUYxhugkdj9S/x7TLO/xbYqRs6biyhQoMGYaLXvCAOhEVDrSt6
         8LplfadXWYBJVxAcKMJUxHi4UM6+umtLmeiPRfaznrVfnpkyxz1TTHRCiVyI0y9v3xN/
         lLra+8u2RK7o22h5RYnDaVTbYfJr+09DuBR+dqG6XLwWqub+C/t1cUjCfL8W4J+DTwcu
         9zTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kuVctN/GQuAPPUnBvIjA3RbHquRoUy2PbM4UiFIBbwQ=;
        b=pFXA2EpSvWGz1JjjXZFI63J/2YaA6FQOY2buS0sjPpuHXQeRBa7xwAUIMMg+zA9Vlf
         ayUqfOMxSOlUuJrgqnf/6Tmy9JhhhyaH0oitJC4sRzVjZVZsNEH6PvFTlzfdd5qGgw2F
         v3XhoPucG6fXs9kYRXuOA1pDHrz0cNHBDfPng1MbB2Rjp54O8+VbBrJLIAAv8bg5QzZe
         10XJaGd11MgMExuZn9xSgkgRzFOTLK3dDYkFprxCJRB4Wvosjjs+JGIJ14CeToQy72Ej
         4udVY0hKJkagsM7EMDKTM9GVBH5B0mhNri/wbzJN4wMWf6QqFUjDy65237CD6ShGvAsH
         jtRg==
X-Gm-Message-State: AOUpUlFFH/u6IkDbqlCVab7LXn62HvAi+Ii0eS7G57rDgcH5pAKvG+dq
        zdvNVDiOLNpytpo0UqRsDUNBaFs9Ax3ALXD6mug499I8u+c=
X-Google-Smtp-Source: AAOMgpeucO+2LCWoOTT2o5KQJnbnempYoDlP5z9rTMHxqPsqsnVaZySxSqClzJk2K9y7Vrx0IXCu8OdYjJ4hwwk9KMo=
X-Received: by 2002:a62:8d7:: with SMTP id 84-v6mr28115591pfi.172.1533149879392;
 Wed, 01 Aug 2018 11:57:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdmuXvM0qF0zy15Q9yfCUNr+Kd4jDTcERWg1R-R2zDNuTA@mail.gmail.com>
 <20180801185317.ndyxtx4zwdkes2dh@angband.pl>
In-Reply-To: <20180801185317.ndyxtx4zwdkes2dh@angband.pl>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 1 Aug 2018 11:57:48 -0700
Message-ID: <CAKwvOd=V3qDqzEMa0LXHHU5_0BRSMyCK3tarASzPYhATiasFFQ@mail.gmail.com>
Subject: Re: get_maintainer.pl and change of email
To:     kilobyte@angband.pl
Cc:     joe@perches.com, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 1, 2018 at 11:53 AM Adam Borowski <kilobyte@angband.pl> wrote:
>
> On Wed, Aug 01, 2018 at 11:36:23AM -0700, Nick Desaulniers wrote:
> > It seems that get_maintainer.pl will make recommendations based on
> > commit history to a file, but over time, people change emails that
> > they commit from, then get_maintainer.pl recommends the possibly now
> > invalid email address.
> >
> > I feel like we should have a look up table / file like MAINTAINERS
> > that tracks previous and new email addresses, which get_maintainer.pl
> > would parse, that way we have a record of movement between committer
> > email addresses allowing get_maintainer.pl to make more accurate
> > recommendations.  Thoughts?
>
> .mailmap

Neat, that's a start.  It has a top level comment about being used by
git-shortlog, looks like get_maintainer.pl parses it, and it's a
default on option.  Cool.  Ok, looks like I just need to add someone
to the .mailmap file.  Thanks!

-- 
Thanks,
~Nick Desaulniers
