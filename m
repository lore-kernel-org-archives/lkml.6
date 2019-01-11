Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48FF8C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 08:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18A1A20874
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 08:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547195618;
	bh=ilLtGkj2iHcA72skp8sL+/oebdvbxBzki0Mfg4V7sQI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=tP1FwODKl1Fw4bCmLL4Luj2bUOdS8iIhOAFUGYr2xmF5R0rTD9nHqr8vcQk+igpfw
	 5gzbXfBHxsEb1iOZV995TppQ14/qv0jsqc6Y7b6F7ailIINabzpb6ZO/1/O7l/tEDA
	 axaiJMJJTdjNUfSHcs3htnfKqZ/3N8H+Lqe/8FGw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730730AbfAKIdh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 03:33:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:56564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728175AbfAKIdg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 03:33:36 -0500
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9078921783;
        Fri, 11 Jan 2019 08:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547195615;
        bh=ilLtGkj2iHcA72skp8sL+/oebdvbxBzki0Mfg4V7sQI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uqwXG5kjsroGEKIcDR9jxWvYGd8iPm1WmET5Rlvdm1Q247rEud05hSOnjWw6emuLT
         /7VMMTFr8HIIqWzaR9h+5UDe8v9D+YsGguGjYCTZe/PYTeKnQYNclb8JjWjF+9T2+n
         tIH3mXsEYUOtrwdEJSkDEm/5Lx+/O203GQII4NCM=
Received: by mail-lj1-f181.google.com with SMTP id s5-v6so12148760ljd.12;
        Fri, 11 Jan 2019 00:33:35 -0800 (PST)
X-Gm-Message-State: AJcUukevE+LmjwUuIIQzG12c/ErM2me5nHYFmAQ/WRNIOE5gydk1lHBQ
        PrRY0NZQ7PQJ55a38BDEsYzQ3fRhI9b+B1UtPpA=
X-Google-Smtp-Source: ALg8bN61FeAJnmMyFF4fv6DchkQp0LOEUzuDw1AZ0u8t2tz4kJ1AmTMiy0J6L/wz+LKsFWNXzNR9Yv5Daj/s3Mp7VpU=
X-Received: by 2002:a2e:551:: with SMTP id 78-v6mr7473508ljf.82.1547195613753;
 Fri, 11 Jan 2019 00:33:33 -0800 (PST)
MIME-Version: 1.0
References: <20190108165601.25708-1-pawel.mikolaj.chmiel@gmail.com> <20190108165601.25708-2-pawel.mikolaj.chmiel@gmail.com>
In-Reply-To: <20190108165601.25708-2-pawel.mikolaj.chmiel@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 11 Jan 2019 09:33:22 +0100
X-Gmail-Original-Message-ID: <CAJKOXPd6NpAoSKuBHCzV2U3Z_cOT9ctf=0nYbYhzRj9opJd9EA@mail.gmail.com>
Message-ID: <CAJKOXPd6NpAoSKuBHCzV2U3Z_cOT9ctf=0nYbYhzRj9opJd9EA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] ARM: dts: s5pv210: aries: Add reserved memory for mfc
To:     =?UTF-8?Q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Cc:     kgene@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, xc-racer2@live.ca,
        linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jan 2019 at 17:56, Pawe=C5=82 Chmiel
<pawel.mikolaj.chmiel@gmail.com> wrote:
>
> THis commit adds memory reservation required by MFC to run.
> On S5PV210 both regions needs to be on separate memory banks.
> Size of both regions is taken from stock sources.
>
> Signed-off-by: Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
> Changes from v1:
>    - Fixed name of nodes to be more generic
> ---

Thanks, applied.

Best regards,
Krzysztof
