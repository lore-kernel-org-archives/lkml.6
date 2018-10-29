Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABD25C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 19:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F12E2080A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 19:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SKwsonzb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F12E2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbeJ3EIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 00:08:12 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40119 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbeJ3EIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 00:08:12 -0400
Received: by mail-lj1-f195.google.com with SMTP id t22-v6so8956619lji.7
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 12:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VdudfrFv81BEoG4fQ9EzkXararEE3L7ra7YZgHHrWqc=;
        b=SKwsonzbRtgYR3Pb2gjYc0nXuX5G2N9ccuwCGAskh5qw1v7dX1qmBvYtIXumkL8KHH
         rppfT816dE1OgZ4v8PTDjmkGYRlYM9JFKLRFI+45jhnPHfOMTHGb8DiDGck+XBx6j+wY
         GzdwjDTL5E3WpSaUtjyQkP2PV7KSM7/MIswQm/dxRuiK5DL3UQe60ItB0G0WzjzuLvOA
         stzDl8h0lvyVCXUwiXhm4I3Rll0EgRVDN2bwvAzbBP52HXmq6ZvFOElCBFfqo7EmURKQ
         A3dFaVKda1gUgdhnBtv5hOjH5wIV+NFun5GN+Die8LTiZnoO0nberkiiF3UfGrKvnccb
         08vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VdudfrFv81BEoG4fQ9EzkXararEE3L7ra7YZgHHrWqc=;
        b=S8gGuHVp59xQ0GtnL57i5hwIDazIf/iCyAQdDMukHeNH4dCLTGUU9HEID4IWQ2UPil
         j7JfoFL8HWWa49V6hdIBOv+GLOLv4KlAP8qZE0oJ61eT4i8g54gZ0n8sFas7coVsAVqY
         Cz6TnKxcGPtJfy93hV0CxV0oy9fXYo/Y4hQrMyyW8woYZSn3Ru9YVXJZR+lhfYY09Bha
         Z/XwHRzrjvhS2n2wH43yPCZ9bVvLogn96+Sw0OFHxUMIXWkpepU1B1urBeCu59/j5esi
         ttKYuzfBihDqevUkTgMH53o+wcK7JQDjlXVKIkDUTB4z71iDUhApk//i95zzjYE8XcVr
         fg0g==
X-Gm-Message-State: AGRZ1gJXh+I/LqXqYDruLxr7zmW5Rn2O6B/CQ5kEL3rlI83FLoeQgb90
        jOOMJFQgq/bAcNxHbkSltYCb4uLAagji9ScVrhciBw==
X-Google-Smtp-Source: AJdET5f6JiXPG3l5riGhlwYQ6yYkkcnQOKKi5cMMHtUlIDwXsvcoXRL+MhcBZYD9ngPYZCCCtwsasRd3zUnLVFDEfJY=
X-Received: by 2002:a2e:6e08:: with SMTP id j8-v6mr11267818ljc.61.1540840689311;
 Mon, 29 Oct 2018 12:18:09 -0700 (PDT)
MIME-Version: 1.0
References: <20171108223020.24487-1-linux@rasmusvillemoes.dk>
 <20181026232409.16100-1-linux@rasmusvillemoes.dk> <20181026232409.16100-2-linux@rasmusvillemoes.dk>
 <CANiq72kEdD3hoHaxukkdzEJt+e_nptyO1GdgfUqWnSAog3k=JQ@mail.gmail.com> <1b3ba24e-0180-8472-199c-07aa56451e4a@rasmusvillemoes.dk>
In-Reply-To: <1b3ba24e-0180-8472-199c-07aa56451e4a@rasmusvillemoes.dk>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 29 Oct 2018 20:17:57 +0100
Message-ID: <CANiq72==2xOTxfGLWDEWqNOdCr-KXvzS0yOnzPEjzZJh+UsH8w@mail.gmail.com>
Subject: Re: [RFC PATCH 1/7] compiler_attributes.h: add __attribute__((format_arg))
 shorthand
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 11:20 AM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> No idea. I think I didn't really know what was meant by
> required/optional.

Yeah, no worries, "optional" here is intended to mean "we cannot
define it unconditionally (yet)". The word leads to confusion, I
agree. I will improve the wording of the comment in the top and/or
change the word after this lands.

Cheers,
Miguel
