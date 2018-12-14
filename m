Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 116D9C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 18:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38B59206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 18:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544810755;
	bh=U0fQndua9hg4HL2mkaqGFyBrBZcRiC0Q5sT83Lt982U=;
	h=In-Reply-To:Subject:To:References:From:Cc:Date:List-ID:From;
	b=PXQQZXXDEJsI8d5J9wGEZHfOl2TDp5G7mP9dR/PrANealm6z4Ww8yoIeJW3hFSXfL
	 N8ExcZDusf7OQ20Sw4f3TPVgAkJiQ6zePyXU9aAar2sSQFHREEk+/5JDcXkR/mMS67
	 d26Cd//Foecj1k10bkMn7JZhfwkVLVyeGnRfYH7w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730377AbeLNSFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 13:05:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:55450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729619AbeLNSFw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 13:05:52 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA84B206DD;
        Fri, 14 Dec 2018 18:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544810752;
        bh=U0fQndua9hg4HL2mkaqGFyBrBZcRiC0Q5sT83Lt982U=;
        h=In-Reply-To:Subject:To:References:From:Cc:Date:From;
        b=cdRxzsnzrV84VXhEEIE+MI/KdCiDmh3HzaIhdzpzcS4YvpC/wBV6OuAuXCkLvCJDk
         A7OUI322galvl5qF8kNDXCYN+zlTqqtU/lwx5bg0jpgXH9LuVXsM5kqyezDpYpCjSm
         /IERjrUTG1wcfWaypoCH3jY+iU7Gp0LkvFKuznSE=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <cover.1544782279.git.viresh.kumar@linaro.org>
Subject: Re: [PATCH V4 0/7] PM / Domains: Allow performance state propagation
To:     Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>,
        Nishanth Menon <nm@ti.com>, Pavel Machek <pavel@ucw.cz>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, ulf.hansson@linaro.org
References: <cover.1544782279.git.viresh.kumar@linaro.org>
Message-ID: <154481075063.19322.10251619430084801598@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        rnayak@codeaurora.org, niklas.cassel@linaro.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 14 Dec 2018 10:05:50 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Viresh Kumar (2018-12-14 02:15:26)
> Hi,
>=20
> This series adds performance state propagation support in genpd core.
> The propagation happens from the sub-domains to their masters. More
> details can be found in the individual commit logs.
>=20
> This is tested on hikey960 by faking power domains in such a way that
> the CPU devices have two power domains and both of them have the same
> master domain. The CPU device, as well as its power domains have
> "required-opps" property set and the performance requirement from the
> CPU eventually configures all the domains (2 sub-domains and 1 master).
>=20
> Based on opp/linux-next branch (which is 4.20-rc1 +
> multiple-power-domain-support-in-opp-core + some OPP fixes).
>=20

For the series

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

