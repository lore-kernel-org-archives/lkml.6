Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 408A5C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 17:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB2E52152B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 17:07:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dzDVc4JM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB2E52152B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732151AbeHBS7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 14:59:44 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36753 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbeHBS7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 14:59:43 -0400
Received: by mail-pf1-f196.google.com with SMTP id b11-v6so1683517pfo.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 10:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=njg91sCxGo4uI2gpBq8+EoG49VPQ7zK8HkZUyKYhA+s=;
        b=dzDVc4JMAew/RngrooRZGp1HiX1mJHld3ErfJ/pr6z+bDZyXWyk6xeJzlGYTGm51dU
         XpS9UfZPalMVH8DaBx3tipUGMRhe/wsSBKDnUHDP4Pc+glogegJ4KRN/sVzx47j+xqoT
         Az4qeuSuqs7AJTBqVoyW40/oo84vcGNcAwveO2bdx/yPdzdKXAau/nXEGXbW/iwxdedp
         uJkJCQLMBZ6manHpe9VFvYPa2hoCI4V6MoDxZT0XWjDr868MlVWMcyyr2zPeiqGXntHe
         G2AC6csR0TuCmS7iUMM0rR33sdR5c9+2N/c6bvrLZwfSKTO/wYiL9TF7tYid/2qPMVnQ
         AELQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=njg91sCxGo4uI2gpBq8+EoG49VPQ7zK8HkZUyKYhA+s=;
        b=SB3+QGt+SYD3j8mDrI0vvfF0h9SS2EYAlGn1tSs6FHyBSnIYPhz7nYaRP+CwOZNuHI
         XPlclWh72INKBjBVsmEcdju62eZqM+7kcskaYvkqBKwoyWyJ3iG0j3BTly+W05fBmSM4
         +x53MF+clI++0jgyC5O4TLxx+hyrLz7rJ4HqPs4NPDvbzFZ4LccJKwXYMgEnKcJuO93o
         JGMygWU0Mndg+qriftcgYhtIsWCYB9pKOF0ckwBF2JLnCprOdvd/pIPOfw67FkrK67/L
         zlw5xyhzNPxcbXLLBFq0TMZHI5KNBOVZHGmAN0tGSmjQtRdIYmGNb6L/FWEJzhHGslnU
         UO+w==
X-Gm-Message-State: AOUpUlENHz0tqB0WAT93FPKd4QxpsWC6AOPCNZGRvP7X1zR3XmLpmHkx
        7Y9iT8V3GgZp6aKcGf1MsodvutW9B2B7qgDsoRKLNQ==
X-Google-Smtp-Source: AAOMgpdzRcXvBWEzILmMpyJvZLISSeVBLXJ7Abqkt2VyNzFLe/X0i6uhPMc+J1Bb7oyOxhH2/6qxp1Iw8g4FffEKh30=
X-Received: by 2002:a63:d916:: with SMTP id r22-v6mr260268pgg.381.1533229662125;
 Thu, 02 Aug 2018 10:07:42 -0700 (PDT)
MIME-Version: 1.0
References: <20180801215759.103758-1-ndesaulniers@google.com> <20180801.184208.776886134692058469.davem@davemloft.net>
In-Reply-To: <20180801.184208.776886134692058469.davem@davemloft.net>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 2 Aug 2018 10:07:30 -0700
Message-ID: <CAKwvOd=oN_ajFa4phMdz_dzjMD2-knzzdh3rgHWHxGPhwAin-A@mail.gmail.com>
Subject: Re: [PATCH] inet/connection_sock: prefer _THIS_IP_ to current_text_addr
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 1, 2018 at 6:42 PM David Miller <davem@davemloft.net> wrote:
>
> From: Nick Desaulniers <ndesaulniers@google.com>
> Date: Wed,  1 Aug 2018 14:57:59 -0700
>
> > -                      sk, what, when, current_text_addr());
> > +                      sk, what, when, (void *)_THIS_IP_);
>
> Is a fugly macro in all caps really better than a function()?
>
> I'm really surprised that _THIS_IP_ is being chosen over
> current_text_addr(), seriously.

See: https://lkml.org/lkml/2018/8/1/1689

I'm happy to rename it on your suggestion, after we've consolidated them.

-- 
Thanks,
~Nick Desaulniers
