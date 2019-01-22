Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B51C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 372CC217D6
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548182843;
	bh=B0qFCitpNOkldy2prRrLmaRakaVyE82MIc/M0eFZCzQ=;
	h=To:In-Reply-To:References:Subject:From:Cc:Date:List-ID:From;
	b=DByAwQRyb1uJkMJkShg0rbt+PRr2APfMZWBaRXeVwnYHrC5kPwLtBCGOalWtGXG1v
	 VriPzKQfwyxAB5N3gwi+vfRXMzCMmz+emBRV1owDwxwol/1hQ7ntM9CD/DgZTm0KV4
	 aFZMO9DoPyG0mctH+XGSl/Lv5NB7aY6dt4sGgTms=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbfAVSrV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 13:47:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:33716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726028AbfAVSrV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 13:47:21 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B35921019;
        Tue, 22 Jan 2019 18:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548182840;
        bh=B0qFCitpNOkldy2prRrLmaRakaVyE82MIc/M0eFZCzQ=;
        h=To:In-Reply-To:References:Subject:From:Cc:Date:From;
        b=FwQLCWkwXzubKhS4PZNrR9G+gxv+hmKTkZFPL9xxfnwn83x67JDOVbyRrTmZZTmI3
         tlZ5x5xomXdNDndus56H9qwDnbBaSZWmf/xvf9mKE+7bsWzMiTN1Ferur04x1hVAxJ
         9FldOyjbNgZfXWXCc+lUaCyLaoDYaggOsHOz2x7U=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
In-Reply-To: <e55df608-7058-63b9-b449-982d32e08759@linaro.org>
User-Agent: alot/0.8
References: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org> <1545039990-19984-9-git-send-email-jorge.ramirez-ortiz@linaro.org> <20190117063312.GE25498@builder> <9abbe59b-433c-4e30-1e4d-b5eed3afc695@linaro.org> <20190117100807.pmew5iqisdcc63eq@vireshk-i7> <e55df608-7058-63b9-b449-982d32e08759@linaro.org>
Subject: Re: [PATCH 08/13] clk: qcom: hfpll: CLK_IGNORE_UNUSED
From:   Stephen Boyd <sboyd@kernel.org>
Message-ID: <154818283956.20280.2895221927807522124@swboyd.mtv.corp.google.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>, robh+dt@kernel.org,
        mark.rutland@arm.com, andy.gross@linaro.org,
        david.brown@linaro.org, will.deacon@arm.com,
        mturquette@baylibre.com, jassisinghbrar@gmail.com,
        vkoul@kernel.org, niklas.cassel@linaro.org, sibis@codeaurora.org,
        georgi.djakov@linaro.org, arnd@arndb.de,
        horms+renesas@verge.net.au, heiko@sntech.de,
        enric.balletbo@collabora.com, jagan@amarulasolutions.com,
        olof@lixom.net, amit.kucheria@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Date:   Tue, 22 Jan 2019 10:47:19 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jorge Ramirez (2019-01-17 02:46:21)
> On 1/17/19 11:08, Viresh Kumar wrote:
> > On 17-01-19, 09:38, Jorge Ramirez wrote:
> >> COMMON_CLK_DISABLED_UNUSED relies on the enable_count reference counter
> >> to disable the clocks that were enabled by the firwmare and not by the
> >> drivers.
> >>
> >> the cpufreq driver does not enable the cpu clock.
> >>
> >> so when clk_change_rate is called, the enable_count counter is not
> >> incremented and therefore it just remains null since this was enabled =
by
> >> the firmware.
> >>
> >> I tried doing:
> >>
> >> diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt=
.c
> >> index e58bfcb..5a9f83e 100644
> >> --- a/drivers/cpufreq/cpufreq-dt.c
> >> +++ b/drivers/cpufreq/cpufreq-dt.c
> >> @@ -124,6 +124,10 @@ static int resources_available(void)
> >>                 return ret;
> >>         }
> >>
> >> + ret =3D clk_prepare_enable(cpu_clk);
> >> + if (ret)
> >> +         return ret;
> >> +
> >>         clk_put(cpu_clk);
> >>
> >>         name =3D find_supply_name(cpu_dev);
> >>
> >>
> >> and that removed the need for CLK_IGNORE_UNUSED. But I am not sure of
> >> the system wide consequences of that change to cpufreq.
> >=20
> > If the cpufreq driver enables it then it should disable it on exit as
> > well, right ? And in that case if you unload your driver's module, you
> > will hang the system as the clock will get disabled :)
>=20
> ah, of course, sorry was over-thinking this thing :)
>=20
> >=20
> > Every other platform must either be marking it with CLK_IGNORE_UNUSED
> > or they must be doing clk_enable from somewhere, maybe the CPU online
> > path, not sure though.
> >=20
>=20
> since this clock is enabled by the firmware, it seems to me that using
> CLK_IGNORE_UNUSED remains the best option.
>=20

What do you do about CPUs being offlined? Presumably when the CPU is
gone the system doesn't need to keep the clk enabled anymore.

