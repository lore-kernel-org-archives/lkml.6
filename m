Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C1DEC07E85
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 00:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2336020831
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 00:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MUs73JM6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2336020831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbeLJAzy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 19:55:54 -0500
Received: from mail-lj1-f182.google.com ([209.85.208.182]:36962 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbeLJAzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 19:55:54 -0500
Received: by mail-lj1-f182.google.com with SMTP id e5-v6so8075331lja.4;
        Sun, 09 Dec 2018 16:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GxPvzXoUBDGR5+FlTmMxXrWm2Oum4ZzE0Vp7VbxmPN0=;
        b=MUs73JM6FZ9xuyE4sVR+zeD09W+Jv02jr9gFOdFmLRNDaqvWwDkBl3KMkg3LP7zCRz
         HlG8q+TtuZSfL9EATCS0S1CH3Rm+YAFcXjaHZY7ZR6jERzaRa4VtM9f1Jd6dAdNodUOX
         OQodikao2Kktr0PonIZa1Mg9zUnAvarfva2bAv6kSvtTvp33P5/Hf7ZKbRpFAFNEZa5Y
         pYfwWhmzRsXdXfHyW10HBwUangUbYch0uBA1CxBntFSFtXyhARr5m8H2jxQGUbhCOhK/
         XISeVGS4GJ5VVuRa4bbZahzuQDwdomFcWhgzcQvMqcjZfPJqZHZ8ozETJbuWoeLCGQ6r
         vDxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GxPvzXoUBDGR5+FlTmMxXrWm2Oum4ZzE0Vp7VbxmPN0=;
        b=CfAZVsVWmEX/9uFLAdqKQyybr5HgVK56k3lnCUd0aXCVnUPXKetZUv+aGjV31l7zfu
         lSsWkKghJLkTw2aRuHVR4rlJnoxoz7x0g3tuzXtpiJNDAnJkVuvGkvgFi6let4hpIx2I
         qatp/KGSOh9GQvXbL3rirpqeh8lV2FnxVEKl7u2G+jLcdUbwOoAJ3ikjI8osX0AABX6t
         ETRep3le4yzHSTfCW1dA4jOSkZ8IBHJoCw3eMbTAFKe90MFpEo3L1nMEgB0NRLZQiYl2
         iVVo7iQPJXu6e8oMPKByLdy8rHk51uBgl06Q80/vHZUe9AmCgwvh1JRNjeRe8DK3mHwJ
         iIOA==
X-Gm-Message-State: AA+aEWZaW6tuqj6qhp+uFgwjK8qdKwhpqoU1zS0P6L6c4BeyWaAYCfr+
        evNDRGFAx2VDn1jgc5e9AGI=
X-Google-Smtp-Source: AFSGD/WmbADgvdZpowlJYvynvnX6XRyVJNpiSoDcJUwTNxH9tLNhA4JN4ovKE+hwx+Wvney+fGUWIg==
X-Received: by 2002:a2e:908b:: with SMTP id l11-v6mr5919882ljg.150.1544403351816;
        Sun, 09 Dec 2018 16:55:51 -0800 (PST)
Received: from dimatab (ppp91-79-165-221.pppoe.mtu-net.ru. [91.79.165.221])
        by smtp.gmail.com with ESMTPSA id z7-v6sm1850043lji.42.2018.12.09.16.55.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Dec 2018 16:55:51 -0800 (PST)
Date:   Mon, 10 Dec 2018 03:58:36 +0300
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "pdeschrijver@nvidia.com" <pdeschrijver@nvidia.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "pgaikwad@nvidia.com" <pgaikwad@nvidia.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] clk: tegra20: Enable lock-status polling for
 PLLs
Message-ID: <20181210035836.602757d5@dimatab>
In-Reply-To: <2a011477-26cb-7e89-a468-54a84465f178@gmail.com>
References: <20180830184210.5369-1-digetx@gmail.com>
        <20180830184210.5369-2-digetx@gmail.com>
        <20180831092948.GP1636@tbergstrom-lnx.Nvidia.com>
        <1539773948.6233.23.camel@toradex.com>
        <2a011477-26cb-7e89-a468-54a84465f178@gmail.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D0=92 Wed, 17 Oct 2018 14:41:35 +0300
Dmitry Osipenko <digetx@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5=D1=82:

> On 10/17/18 1:59 PM, Marcel Ziswiler wrote:
> > On Fri, 2018-08-31 at 12:29 +0300, Peter De Schrijver wrote: =20
> >> On Thu, Aug 30, 2018 at 09:42:10PM +0300, Dmitry Osipenko wrote: =20
> >>> Currently all PLL's on Tegra20 use a hardcoded delay despite of
> >>> having
> >>> a lock-status bit. The lock-status polling was disabled ~7 years
> >>> ago
> >>> because PLLE was failing to lock and was a suspicion that other
> >>> PLLs
> >>> might be faulty too. Other PLLs are okay, hence enable the lock-
> >>> status
> >>> polling for them. This reduces delay of any operation that require
> >>> PLL
> >>> to lock.
> >>>
> >>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> >>> ---
> >>>
> >>> Changelog:
> >>>
> >>> v2:	Don't enable polling for PLLE as it known to not being
> >>> able to lock.
> >>> =20
> >>
> >> This isn't correct. The lock bit of PLLE can declare lock too
> >> early, but the
> >> PLL itself does lock. =20
> >=20
> > Is there an errata documenting this? As I could not really find any
> > mentioning of this anywhere at least up to the v11 from Dec 21,
> > 2010 I still have access to.
> >=20
> > BTW: It looks like also PLLA may not always lock properly with those
> > changes. Is there anything known about that as well? Here is what I
> > get on various Colibri T20 modules (while random other ones seem to
> > work fine): =20
> Could you please try to increase the timeout value?

Hello Marcel,

Do you have any update on the PLL-lock-failure problem?
