Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC67C67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 21:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7119B20672
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 21:50:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TGkK6NvH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7119B20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbeLKVu2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 16:50:28 -0500
Received: from mail-pg1-f173.google.com ([209.85.215.173]:36840 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbeLKVu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 16:50:27 -0500
Received: by mail-pg1-f173.google.com with SMTP id n2so7266721pgm.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 13:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:message-id:to
         :subject:from:user-agent:references:cc:date;
        bh=LvALdq5ixfhfExX7iT7b3jHkcXIyzZRjeMrmXprDN7c=;
        b=TGkK6NvHvPCOZkEDDwn4ONv4ed7di9Pb8nqI2SI1jJLBPzbcifjLn8j9zVpbu6BY2a
         Xs+saaWJS5YUJUap1EEtTSsMq/x0iwYShbhsE1em3coQ6GgSroSnbJpMdve/s9MUinwS
         soLNV9rU/XSvEAEssful1I7wRRdhMctYkFCRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:message-id:to:subject:from:user-agent:references:cc
         :date;
        bh=LvALdq5ixfhfExX7iT7b3jHkcXIyzZRjeMrmXprDN7c=;
        b=Gc/bqRYNMePO5lDVyKlyomqwn+YLQSbE42GXjuScNv4fj3jbevkV96px/xW4NdELJ9
         tamqzdq2pzKVv006QsaFirTC/kOMvolFiPlhHxD6FDB8VvZsdZrVqTNUV/jgLzYzS2N0
         E5Ddo+YIac9UoB3N78o1sj4mSrmRWvI1rJfSJrIZrKvQdhXkd1mee94Si15xQfvPfkEn
         HF4CiY3WaEtt6ttnIJ0il1rlhkzktv7vHgAAGv5mUut1lcpZQaqEOaBiV6+ubHyVoITJ
         gTWV/aatrdSUAGmMCZEzuf2u+g4wcXGhnFwReGXm7xLei03r8Ai9r4HaKfwUVPuiCTmj
         DjtA==
X-Gm-Message-State: AA+aEWah1IcHPyRhgI8cJ7L9aW+7Zoa7DcxzsfR+SiZYGrl3G7S+Ouy4
        +U/GHtSeqnJqAJzrIC5d2Uilrw==
X-Google-Smtp-Source: AFSGD/VseJkQ2qO+DWL2/WCGUwDlv1gM2oqTvZbTeRan7hSXRw+H1Zix73X0LMQip73ffLFdQJdlOg==
X-Received: by 2002:a62:29c3:: with SMTP id p186mr18214870pfp.117.1544565026400;
        Tue, 11 Dec 2018 13:50:26 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id 69sm26831249pgg.86.2018.12.11.13.50.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 13:50:25 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <00d91f90-ccf1-3486-0d42-0c4105058e61@codeaurora.org>
Message-ID: <154456502486.17204.11345601448030201032@swboyd.mtv.corp.google.com>
To:     Rajendra Nayak <rnayak@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v6 10/10] soc: qcom: rpmhpd: Mark mx as a parent for cx
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.7
References: <20181211094938.25086-1-rnayak@codeaurora.org> <20181211094938.25086-11-rnayak@codeaurora.org> <CAPDyKFof-rkzmzibWOrAhDFysU=y+C8Bp0cK=_iht4=vmv-0vw@mail.gmail.com> <00d91f90-ccf1-3486-0d42-0c4105058e61@codeaurora.org>
Cc:     Andy Gross <andy.gross@linaro.org>, Rob Herring <robh@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        David Collins <collinsd@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 11 Dec 2018 13:50:24 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rajendra Nayak (2018-12-11 02:33:23)
>=20
>=20
> On 12/11/2018 3:52 PM, Ulf Hansson wrote:
> > On Tue, 11 Dec 2018 at 10:50, Rajendra Nayak <rnayak@codeaurora.org> wr=
ote:
> >>
> >> Specify the active + sleep and active-only MX power domains as
> >> the parents of the corresponding CX power domains. This will ensure th=
at
> >> performance state requests on CX automatically generate equivalent req=
uests
> >> on MX power domains.
> >>
> >> This is used to enforce a requirement that exists for various
> >> hardware blocks on SDM845 that MX performance state >=3D CX performance
> >> state for a given operating frequency.
> >=20
> > I assume that also means the MX power domain must not be power off as
> > long as the CX power domain is powered on?
>=20
> So with rpmh, there's really no separate on/off control, we just put
> it in the lowest perf state at off.

I think in theory the answer is MX can't be off if CX is on, but in
reality, MX and CX are never turned off, just set to something really
low and even then the constraint applies for MX >=3D CX. Is that right?

>=20
> >=20
> > Just to make sure there are no conflicting hierarchical constraints
> > between idle management and performance state management!?
> >=20

I'm not sure what idle states mean to the CX and MX domains. Would it be
some sort of idle state governor attached at genpd creation time that
would adjust the main SoC power rails when all devices attached are
idle? Maybe I don't understand how idle states are different from
performance states.

My understanding is that devices using these domains would almost always
expect their clk frequency and clk on/off state to decide what the
performance state is, unless they need to ignore clk state because they
aren't managing clks and bump up the voltage directly when the device is
active. Either way, devices are actively managing the voltage they need
these voltage domains to operate at by using the genpd performance
states APIs.

