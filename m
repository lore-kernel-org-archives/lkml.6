Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15019C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D895420857
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:29:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AD25cT2s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbfA2K3R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 05:29:17 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35328 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727072AbfA2K3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 05:29:16 -0500
Received: by mail-ed1-f65.google.com with SMTP id x30so15581739edx.2;
        Tue, 29 Jan 2019 02:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6Fa3Zo12iaIFsHb8qliPtTCYK3OxXEKI06KR5QB5UZs=;
        b=AD25cT2s3mmV58tZ1Eiy+oib0SSv84oLSd3ZoQbWOPRek1hiAhHaXLQf0tZFUiGPeb
         2CVL32rLH7Mcq4vrfLkC1eueoaTtPvqW5CIFo+mKHIh1MZp0w/EUJM2z/tLNwou1mYHa
         9Tw4hSNtQ653Syq5c+hcNU/nOpQsN4KI+lT/74pkoM77iOAfRepjDqn6GUEqVD9c9TrP
         g7fkr8u3kKLC6V6yhupo6MElzzHZcRyymZZtOlDoxPgDR2eVAQ8veMVlt1iAXWMWo3Jv
         UhNQkks8q9uwaCuHXzA0ehi1hpVQ2GbEt/O66bppFyY397hQKLgAZEeYs6g9Q6BQTz3G
         t24w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6Fa3Zo12iaIFsHb8qliPtTCYK3OxXEKI06KR5QB5UZs=;
        b=bR+buJ/gV8ms4gURGn9RRQ3Kqcm/h59GC7EGEwpmsjiFh7TcC5N+iVwj+psIt7zY3f
         WMX1+LLQ3AVDwfWugY91+bo18x6isX8n81bJ/hahwR3FPRexg0H/37RSDwi7jW4eK6gZ
         54lR0FUp5tMxbBeHZQF4gsaDO9rs18S+JbzN2Zag7V0AUXNfAfLKn2xPI5+7tGvbU2KC
         +hGckoh1bF/5eNj/NyMp2fKxMmzP7QWxdsNTtyyh0hAEtXMh71ddueJ9T2DrpH10YSIF
         b8+nZU0I9Q9Fq6JMDOXL8Y3xpUwWTeXPXKqpGtd3kdHrBOh8XyRNyvz8deIYmhhzzHuA
         RIMw==
X-Gm-Message-State: AJcUuke3ZIIt/Z6vAsrXAEIW8FmhXtNqPHeNFjnfT339uK64PL+/Fwsp
        7cSlVdI/pt8t9eiSXGnfSiI=
X-Google-Smtp-Source: ALg8bN7Q6dNTsaEI9Aq7CX7GTTfJ5oc/GRusg1jlsxkHxUpW9w6PHooq7Ep/V7b24Tc7X7yBCULPfA==
X-Received: by 2002:a50:ba5c:: with SMTP id 28mr24517848eds.91.1548757754726;
        Tue, 29 Jan 2019 02:29:14 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id 97sm14504171edq.45.2019.01.29.02.29.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Jan 2019 02:29:13 -0800 (PST)
Date:   Tue, 29 Jan 2019 11:29:12 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     Joseph Lo <josephl@nvidia.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V2 2/6] clocksource: tegra: add Tegra210 timer driver
Message-ID: <20190129102912.GC28850@ulmo>
References: <20190128091815.7040-1-josephl@nvidia.com>
 <20190128091815.7040-3-josephl@nvidia.com>
 <20190128150908.GB31317@ulmo>
 <20190129084155.GX7714@pdeschrijver-desktop.Nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="i7F3eY7HS/tUJxUd"
Content-Disposition: inline
In-Reply-To: <20190129084155.GX7714@pdeschrijver-desktop.Nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--i7F3eY7HS/tUJxUd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 29, 2019 at 10:41:55AM +0200, Peter De Schrijver wrote:
> On Mon, Jan 28, 2019 at 04:09:08PM +0100, Thierry Reding wrote:
>=20
> ...
>=20
> >=20
> > Up to here this is a duplicate of timer-tegra20.c. And a lot of
> > tegra210_timer_init() is the same as tegra20_timer_init() as well. Can't
> > we unify the two drivers instead?
> >=20
> > The power cycle restrictions of the architected timer, do they not apply
> > to chips earlier than Tegra210 either? So don't we need all of these
> > additional features on the timer-tegra20.c driver as well? If so that
>=20
> No. Chips prior to Tegra114 do not have an arch timer and the arch timer
> does work correctly on Cortex-A15 so Tegra114 and Tegra124 can use it.
> It's broken on Cortex-A57 though, so we can't use it as a wakeup source
> on Tegra210.

If chips prior to Tegra114 don't have an architected timer, then we
can't remove the timer-tegra20 driver, because we still need it on
Tegra20 and Tegra30, right?

Thierry

--i7F3eY7HS/tUJxUd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxQKvMACgkQ3SOs138+
s6ESkxAAmPafbK79nW+LhXKQ7nIGVNRT3TZ2CgSuShtFP7bYxtDA2MmTMQu4/VfD
G6v4td8renRj+3RaGbmukoVGeHlp7ILdkUb3+RLf5rJVXe46rvGuoSXwj3t92wNC
UXxLUQNrqpR7C13sCufdjbAoy4xurzf1arsKJLjfmPF0EW5Wfcs8D8+fMkd1ZrHf
NTWeeOQLi+hhvNU2RQSF7OH8pkXpTICbLCdQ3hvSrTJaQ6dcJnLkG6h5I0uYCpr4
MHt9WButS8LHlxEcpXH/THOoFQ0Hk7+yLG+XIEKWwRBojXTN3b5eA39y4U0zqWkZ
P8YyHYP+0fSeUurbP/8MLxKOQHRY8Ost2ONs4KgyenTPF7NkWNq+jHmNAzfkZ8Ta
2D2cSi79xOXb7eSZ1g09o+z3hTzmqqBP5Mj1Y9XjQQaNDmjb9eM08EQJz176awTq
fggDH3rR/BSQ13D93F6ghDFP0yFDbFl8q3NIN6IC9c2jS/GB/xqVS2/dMImW3DL7
gDkIEnI7K2EC3fiUtKK+SGDQLK0c7+QlkZ+fzD86cULLiatvm8TsFwJFW5rxQqKs
ZgIi5FnD/CXugk3QsqFnaZeQvpb4U8l8TLIg4ZAYUGEwiH/KDCU3BEoSGwmro7Zf
5BSPZwp505/YvejxBl7LWrw27SLA0pDbsJNmArubNjrTv4dZKj4=
=tJel
-----END PGP SIGNATURE-----

--i7F3eY7HS/tUJxUd--
