Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B19A7C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 07:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6627D20831
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 07:33:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="CDnIregJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6627D20831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbeKAQfp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 12:35:45 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:50289 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727734AbeKAQfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 12:35:45 -0400
Received: by mail-it1-f194.google.com with SMTP id k206-v6so904890ite.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 00:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M8qZtSKyqSrgOcND6X3h+vWFwqBbRfUll9/M/lL2Fcc=;
        b=CDnIregJaal1tPoFSX7fiDAtDJ5mwGb8zpQ0bfiQKuYp3NSxyU2HAoUlR+cawOQaT5
         VaMtah60DFwCU2hYjxtZZlgxHhxaNIIOuMoB5JjooWLpmtsnIxSmGrVTss9rztGnwGt9
         bZAHaR+QX03dYuX78KQZz3zeoJnRv3kQg6cFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M8qZtSKyqSrgOcND6X3h+vWFwqBbRfUll9/M/lL2Fcc=;
        b=sKilzGMAiuDlv0HB9GKy/RF0Dv2f2J2x1uoluxj+ry5avhOMlpOmXlLnJBzOsKhIXk
         HbYN82ZwwpmaMTgnvMoMdzGJPbIiSEO1RFan9h53gXJj1uR9tmEQaop3IXSjQ/QBNMwc
         CdcF9hKM/kAWTTrlO08tCIJs/yHxkB96Kwm/PjEDCk7cCUjRt4ryLpPHvwbuWXQZFG4k
         hStESpAOpkdYgLuKR18ZSOASciMzTO65zY0wxwgsAps4C65j2nzH/Z6kL9b1ZNI2WYQ/
         t0jGBKBDRMjc3s6NASsAY7m2jjspDNSQQJjWuQLimgG2kXr3jEDGRpsCKsaKaOVCuqqL
         mjMw==
X-Gm-Message-State: AGRZ1gJUsjfge/0DR5eoR/E5gsh13cxurSGFVsexW+PcL4Zl9cKCXMzA
        SZ6JK3m9RMUopFEaSnehjCxNGjbsvxq6//0bQc80SQ==
X-Google-Smtp-Source: AJdET5fz9qIE0AiMTuEKomFfDiEFDczuc8iO84HGXaIoChhzH+TeQ/Sw2mo3+V23sFjFXj4jWh+Rhi4Rl9VRwndBFlE=
X-Received: by 2002:a02:94d:: with SMTP id f74-v6mr5205993jad.85.1541057635859;
 Thu, 01 Nov 2018 00:33:55 -0700 (PDT)
MIME-Version: 1.0
References: <20181031183634.29640-1-jagan@amarulasolutions.com>
 <20181031183634.29640-5-jagan@amarulasolutions.com> <CAGb2v64fnpCh_rCy-9m8xgXmAZQGab1==f7cr332QfgueyuRNw@mail.gmail.com>
In-Reply-To: <CAGb2v64fnpCh_rCy-9m8xgXmAZQGab1==f7cr332QfgueyuRNw@mail.gmail.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Thu, 1 Nov 2018 13:03:43 +0530
Message-ID: <CAMty3ZAW5KndyJj81obK49MKczdbk4SoUncmiiE_OhH1g7qFUA@mail.gmail.com>
Subject: Re: [PATCH 5/7] arm64: allwinner: h6: Add RTC node
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi@googlegroups.com, Jagan Teki <jagan@openedev.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 1, 2018 at 8:25 AM Chen-Yu Tsai <wens@csie.org> wrote:
>
> On Thu, Nov 1, 2018 at 2:37 AM Jagan Teki <jagan@amarulasolutions.com> wrote:
> >
> > From: Jagan Teki <jagan@openedev.com>
> >
> > RTC controller is similar to A31, so use the same compatible
> > for H6 and update interrupt numbers as per manual.
>
> No. Unfortunately they are not that compatible. The A31 does not have
> the RTC clock output. So everyone got it wrong. :( Plus the clock rate
> of the internal RC oscillator varies between SoCs. I'm working on a
> series of patches to correct this. Stay tuned.

4 bit, EXT_LOSC_EN of LOSC_CTRL_REG (0x00) seem available in H6. I can
see external clock working with WIFI for A31 compatible.
