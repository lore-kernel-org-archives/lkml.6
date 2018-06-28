Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A9D5C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 14:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D63AC273AD
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 14:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SwjgIbmV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D63AC273AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966507AbeF1OLA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 10:11:00 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:51072 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966313AbeF1OK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 10:10:57 -0400
Received: by mail-it0-f67.google.com with SMTP id u4-v6so12969187itg.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 07:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZG2ijEldkyXQ6xGqj/ylaidWDnMoQou4dmOWsopOLR4=;
        b=SwjgIbmVGWIPQFav97Zats+vhkSKAa0mogOn1YK5HEjeg4LfA5VM9sEMz3wVxMd7AP
         2I4+AiLXMEuTWWbCPlKfkfeeEf3dqXPsCXxCM069xiXT14r+ERvv3fdhhXE8auifekAJ
         +to7XKBSn40Zp9b8+TdIaytd2s/C9JHdBdAuM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZG2ijEldkyXQ6xGqj/ylaidWDnMoQou4dmOWsopOLR4=;
        b=GPT/FAIJcqt5mdBn59Z6NyHcuiRvKzhQcBeCRWRefxLJ2fe5QjyCLgbwIGuflXWHqt
         V/HjFFmKUkb3hztIIQicnYMlbCLGYcjLzf3JbMwxsK4FgXHJV2ysHSE2pKg9HLaY2RVC
         Xha3InDFpYkdm4IynfN+RSeY3a1TI8nFIOVNfR6VgNWO4jVtIc6Ax7Kw8hh4ssbBI+t/
         h1USsqoAyWIw9dxbySsetSmNeqFOaoCxODvXMTGdkTSRCSNzYx0VBHcnB6mHojh/6QQY
         6oEeEsYulXoLl6EIQfBPmQCqJb3ehmx7VgItRTFgF/a8jQZSDp3b9fE0w/AYO7Zblmg4
         +nNQ==
X-Gm-Message-State: APt69E1VkEitxBunifPo3eRj6IMVC7oeDRYSR1ic9ew8k0Ns1d9M5qVi
        beWrGU2Yy7qdts4Ejo+yCPp5DqKSsRxTrzKu3DTWNQ==
X-Google-Smtp-Source: AAOMgpfPVqwafnL0oyPkncT1Yp7BNeSnK3G57IQLDqbfJQQc+M0ZILFpGEvOlD2PopykJ61d88Cvh+gNIInM+Wp4sK4=
X-Received: by 2002:a24:8989:: with SMTP id s131-v6mr8447692itd.70.1530195056896;
 Thu, 28 Jun 2018 07:10:56 -0700 (PDT)
MIME-Version: 1.0
References: <1528974029-29617-1-git-send-email-michel.pollet@bp.renesas.com>
 <CACRpkdbX0R+ipasLfZi80yf2OBU0TuDT-0KoUJBvrQz3Zj6eFQ@mail.gmail.com> <CAMuHMdVL-00gb7ZfgNGr8-VawFUpg+iY5mpPF6UZPfjFqM1_jg@mail.gmail.com>
In-Reply-To: <CAMuHMdVL-00gb7ZfgNGr8-VawFUpg+iY5mpPF6UZPfjFqM1_jg@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 28 Jun 2018 16:10:45 +0200
Message-ID: <CACRpkdag1snZfeCC1y5TJdgVzAXbv+nDJrA-3R=49haTM8Kxpw@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] Renesas R9A06G032 PINCTRL Driver
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Michel Pollet <michel.pollet@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Michel Pollet <buserror+upstream@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Magnus Damm <damm+renesas@opensource.se>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 10:57 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Mon, Jun 18, 2018 at 10:46 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> > On Thu, Jun 14, 2018 at 1:00 PM, Michel Pollet
> > <michel.pollet@bp.renesas.com> wrote:

> > Is it totally different from the other "great old ones" in the SuperH-PFC
> > series or is there some other reason why it was done like this?
>
> Yes it is, cfr. drivers/pinctrl/pinctrl-rza1.c, which lives outside sh-pfc, too.

OK I see.

I take it that it is also totally different from the rza1 HW?

It's fine like this, if there are many of them we might want
to create something like a renesas/ subfolder at some point
and stash them in there.

> Of course I can take it through my sh-pfc tree, once the rough edges have been
> removed.

That's best I think, it always works smooth.

Yours,
Linus Walleij
