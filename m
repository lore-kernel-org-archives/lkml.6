Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC99C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93C0420879
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JrYn9iiC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93C0420879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbeLEQrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 11:47:45 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37403 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727242AbeLEQrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 11:47:45 -0500
Received: by mail-lj1-f194.google.com with SMTP id e5-v6so18980752lja.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 08:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q7xFKutB7G6oXRPDuD0iaVaxgXXZ1TUJLZ08Ntx5z50=;
        b=JrYn9iiCgaedA41Zv1Jg8OMExvG8qLX3PQh8I8KIEoIgL1YFNW8cTB4mMSTrRcl1qk
         8lrOuhNosJO5z8G2bhdeDw60jwLqclQhudN6iIOEYbSnymYJuYGSuVfkSX4fskkIaEWF
         7rfJvtrNSwaEwu5Xysh7OTVNBe6BvBbtkwjryEOqk48BCw9Y2eggFvsJw/EG96MdFlzP
         VtQTJ+jMt/SxgqdtFLIWKvfcUGAJnQYElfKEONxuyOFXPVk2BP+rnZxUPUqOKpt9uHdw
         0tDSeU7JG9kLW37FTWYyq1rVo0PKK7Hun/vBVZsSvLiZvXgTyrM1G5QHVo+pjQyO5L2C
         6vbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q7xFKutB7G6oXRPDuD0iaVaxgXXZ1TUJLZ08Ntx5z50=;
        b=o0Boy6DHu+ZH7RqQWaG2eCIFKxd54p6rC4hIOPhnd2wskCY6AOVms9LAOk6h/uh3xU
         gLy2M+jUXSyiQhoYPV3GTvZty7zUD7PhHETV4fbcTFFgh7g9oIsq7+Nse65vl5fAfsD4
         YzI1T7F1qOaKxnDjyBfoOMLxC5wuoJGxm9TV2i1cWsRSKnm7ZsWs20uOgKUM+0pZ734e
         TNA/QFGit0v7/QzyQ2oVJa0ngc8ogLV6L6MeUfn4Y3LqKC2p2cjGYMhbOEmnc+SVWFEl
         XLvkDLMt7MxJDiNSL9fp6kVw1M0xxzT03gsFDaWy7dh45YJvAdZW3GXdFucWtPEfk2NV
         LK2g==
X-Gm-Message-State: AA+aEWahlaslVwgvzq2FnWabLsnkjKiZIgpnw0+FtbdraSoUGvPNFkSk
        6+y8F4BUGBZA8Qem0wJMNWkXPmEivMYQMbtUHhA=
X-Google-Smtp-Source: AFSGD/WgAY77vwN/BXLEobmQYNRuuM9l6hatwd2r5/H7ONDMOqVdBc+YUxJYCIROBNWUFqRyH2YFRje5T9o9/lDy94Q=
X-Received: by 2002:a2e:58b:: with SMTP id 133-v6mr17287046ljf.127.1544028462926;
 Wed, 05 Dec 2018 08:47:42 -0800 (PST)
MIME-Version: 1.0
References: <20181205135247.7964-1-mans@mansr.com>
In-Reply-To: <20181205135247.7964-1-mans@mansr.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 5 Dec 2018 17:47:31 +0100
Message-ID: <CANiq72=Xg--8vG0+JLsPykOUfXpo89R2H-pBLuMROnQjMui7qA@mail.gmail.com>
Subject: Re: [PATCH] auxdisplay: charlcd: fix x/y command parsing
To:     mans@mansr.com
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Robert Abel <rabel@robertabel.eu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Willy Tarreau <w@1wt.eu>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mans,

[CC'ing a few people involved previously on this]

On Wed, Dec 5, 2018 at 2:53 PM Mans Rullgard <mans@mansr.com> wrote:
>
> Commit b34050fadb86 ("auxdisplay: charlcd: Fix and clean up handling of
> x/y commands") fixed some problems by rewriting the parsing code,
> but also broke things further by removing the check for a complete
> command before attempting to parse it.  As a result, parsing is
> terminated at the first x or y character.

Why is it necessary to check for ";" to be exactly at the end? Or, in
other words, what requires it?

If the syntax supported by parse_xy() is wrong for some reason, we
should fix that (instead of adding a check before calling it).

Thanks for taking a look at this!

Cheers,
Miguel
