Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03BA3C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBE24207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:48:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VTwH1ORi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729259AbfBENsz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 08:48:55 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39900 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbfBENsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 08:48:54 -0500
Received: by mail-ot1-f65.google.com with SMTP id n8so5713521otl.6;
        Tue, 05 Feb 2019 05:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GHvKWi9L2842L0cyfRSb5wn3PMhEaDm6j/wUQekR4yE=;
        b=VTwH1ORiTzjZdAYiRLyQt+Yh3fNZuZwWPRJWtqC/MW7hUf73g1BWYdgzcoZe5c9t1x
         wVlNZFUnpDtlRn0RVdc/cSfTkKoN5gQul7+BP9ZLXdb13r7JX2lA4z3KoXiwOie98I+w
         8OdDUaMXFJzvWO6xWq+PvMZIpyxPT/n7azm7dqnCWo0md9MMXqfWBZPkhjSP+9Er0fqq
         4JguXn1R//axurMYytEfO95LDjZ6pHLNuwgA4tzcTZWUB1X73YraDf7lKt+FTX47n6+f
         nk5W3kRldlimDGGWdBsjpn2C/eTI6H/KGwyUpmEXLvH33HL7qTADKYmzasqU47IjbeXw
         L68A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GHvKWi9L2842L0cyfRSb5wn3PMhEaDm6j/wUQekR4yE=;
        b=hyZmbrE/aODwI972cZsbcQ1B3Rbhu/Cri1ueg5OA6kwd1EMeSaaJbhw7cjMYqhQeMf
         4KFyByndZeXBuxy/CtfmXVbXcKHZRmYHmQxK+K7KD2F3Pt5HL+l7sHIWL6O8F23tyHx7
         PyGCcOmjqa1fTc+/mJUSiqH6JF9JBJFWJ0h3Fyox0uTDOYEEu+0nqJujbddPKrkg+USK
         lu4TTuk7AQgoqYcivCRyY+qkn99RQNZz9+9+tgrP64xlvAfephQUH0xhQjBMXIkKIYqv
         bR6bEHuW1QQ+OszvT/heyaFgXDES9dyzsogUd3BUiT1UFQuPHSXQp6Ko5HHafmIMLr0/
         LGaw==
X-Gm-Message-State: AHQUAubO776ET9uml74at9DJAVJ0j971Dcg/rSi9EzTbzE86NhRkUR8y
        adOe1mzgKVcgOMiMV0hVAK4kRD3hgQGpYCPuj68=
X-Google-Smtp-Source: AHgI3IbYcLnPSKCZe0bq0wJ+gQtuhwW6iiC7Ck5SrV9Z/2Wn7FCzX8hIYP/2fdcKNvkEokrxuijZc8ZPd575zEN38kw=
X-Received: by 2002:a9d:60d0:: with SMTP id b16mr2562943otk.109.1549374533932;
 Tue, 05 Feb 2019 05:48:53 -0800 (PST)
MIME-Version: 1.0
References: <1548946870-29037-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1548946870-29037-1-git-send-email-abel.vesa@nxp.com>
From:   Chris Spencer <spencercw@gmail.com>
Date:   Tue, 5 Feb 2019 13:48:42 +0000
Message-ID: <CAGUNXRSvtEG95XG+y3DDza4gXu6nyZcGUPiPwKRqp5PgGTu8ig@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mq: Add RTC support
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Baruch Siach <baruch@tkos.co.il>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abelvesa@linux.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Jan 2019 at 15:03, Abel Vesa <abel.vesa@nxp.com> wrote:
> Add RTC support for i.MX8MQ.
>
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>

Tested on my i.MX8MQ-EVK. The system time is now retained between
reboots, but not if the system is fully powered down. Judging by the
absence of coin battery on the board I'm guessing the SNVS is simply
not powered when the main supply is turned off, in which case this
isn't a problem.

Tested-by: Chris Spencer <christopher.spencer@sea.co.uk>
