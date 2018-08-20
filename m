Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 095F5C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 16:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B33B621581
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 16:01:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OMkDNRBe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B33B621581
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbeHTTRQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 15:17:16 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:43520 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbeHTTRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 15:17:15 -0400
Received: by mail-oi0-f68.google.com with SMTP id b15-v6so26648305oib.10;
        Mon, 20 Aug 2018 09:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6DsXgaboVG5BVc2k8E6WbvT0ITYydRw3zWMWEo9acL4=;
        b=OMkDNRBeKMDmEafMhtJJjjKKTpP3uMLvYGr2jQpbt+WN+2wnSQmD820YG+QqQjMmX4
         u0GGwQu9Q7q5eli9LFxLrnXig+mEqnWmuxtclplvzvR7+IC0ckO+K1n40E3F54NGOu3A
         86Vo7zP1lc4FGCwluiW0HZvP3X21+k5jt+HLDMUn7aJLIp0J/CNuElrKECi9sbuR2928
         uTe3i+CW2k1bTWaH3kYHZM2Hc2lyXVA9RfTMMdft863jQUuXleeVgC6adDxTSlcBj8I4
         yGZ82VDN+/eQShHdt1jhpQAm0RiOsEwtBQwV5pW1ZJJhOAnCU/x5i4fw6sJ8RATsHzvc
         Qt5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6DsXgaboVG5BVc2k8E6WbvT0ITYydRw3zWMWEo9acL4=;
        b=iuvYTVum6CScLCnfyeqAP1VDsseHpzfWxuJvReiUxIPybcw8lUrtce9ajuOSpuiabI
         uAVpCB1Qc/1pl8P0Nac/cqI8otLUglBYfTJca7piVEr1sxZ7ncU0HC5/iZuE9RLng5PF
         aIjn8tX75bIEpQLDibtgR0MU0zDq7HMOvXyJ2XUAqrcai8Rev5vNg5EgFpmhat+71vz6
         EgXkXHWbWJ6vvRQ776hfYBo4esgMg9eiCtYFC/HM8p1gyEJ7g2eazpAzaBIjGpS21Uco
         7bI7ftB4Bs10A/4UObB11ctlwU64PwCtqFlDzJzg3P6Upgps/DRLNmfNs9dt8S8UlH4p
         vZ8g==
X-Gm-Message-State: AOUpUlFnPhJmnzBCiEtxYMoNyAD1cVdOIlYk3tdU7s0AihR0HdFRBCu/
        6+qC+nWh7CMq1dPA9oB/K6BNrs3y7R9+bEVGm8q13mXq
X-Google-Smtp-Source: AA+uWPzh02wWaTgM+ItFDevXWv9rEe5Fo7OSPYLk5jrU/EO5jzUeZf7VZCboNHdygnjlDO4e8UcmZGoLgvs91SXyDVQ=
X-Received: by 2002:aca:bdc4:: with SMTP id n187-v6mr13521244oif.3.1534780862659;
 Mon, 20 Aug 2018 09:01:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:284e:0:0:0:0:0 with HTTP; Mon, 20 Aug 2018 09:01:02
 -0700 (PDT)
In-Reply-To: <20180814204758.3049-1-tuomas@tuxera.com>
References: <20180814204758.3049-1-tuomas@tuxera.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 20 Aug 2018 13:01:02 -0300
Message-ID: <CAOMZO5A2U5vZkfCE7xaMfrTQCogBojBDAWUe3XDCr7-JipD2Wg@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx6: Add stdout-path to Wandboard
To:     Tuomas Tynkkynen <tuomas@tuxera.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tuomas,

On Tue, Aug 14, 2018 at 5:47 PM, Tuomas Tynkkynen <tuomas@tuxera.com> wrote:
> Setting a stdout-path in the .dtb is convenient because then the user
> gets a serial console on the RS-232 connector without any extra effort
> of figuring out the relevant 'console=' boot parameter.
>
> Signed-off-by: Tuomas Tynkkynen <tuomas@tuxera.com>

Patch looks good.

Only a minor nit on the Subject line: I would do it like this to make
it consistent:

ARM: dts: imx6qdl-wandboard: Add stdout-path

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
