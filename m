Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC94CC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 19:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73C1320842
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 19:54:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y5wDxUb+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbfAMTyO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 14:54:14 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35078 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbfAMTyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 14:54:13 -0500
Received: by mail-lf1-f68.google.com with SMTP id e26so14175019lfc.2;
        Sun, 13 Jan 2019 11:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kl1n9kZMLL/pR3MDgjhXjOfYdfrbv9pfFnnpNgvzosQ=;
        b=Y5wDxUb+hnFON5VKKhFQpIFWP/qOHXfkKEEFqZh4/9CWFz7ZODcXt3+V5BgQ2K8Tvb
         XLOHhd3+4rcnVxURGg8kb8UwSuol9iTal1rpzjtsDtPrLCPi1cMe5B8jPDaTtZtp3jvU
         RL0zT7W4r4s6e50dEoDUUqnTMJufsiTbCKM3joo5yxlw71O+Pok0ZXmOq7/DHnsMWb9M
         ZG0g8JTM7Ruau1t2XwKMoqe5mtGICPnzjp60IUFmpP+/rCGSeClcoXDfaRWrOrTXDcIS
         L21+p/KEC63zrip3EvLsKG6QOAOwk3R0BWtSMQgLctNv4aHEvnAE1znrTI8SOj/5Ap7k
         N9HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kl1n9kZMLL/pR3MDgjhXjOfYdfrbv9pfFnnpNgvzosQ=;
        b=Jg6E0dXqxoSf3XHu6aCNRNHSn1gNvjsL+ks5I+vlL+Ur4sgysJXBJNQjBOtHsPVxK5
         /P/4FcJeor8z26CmBXd1y4GhRyRJlSexXaZi8gl/nlf8NB6kFBzY1ArtkEA4W2bIx+03
         1nDm26GX0ZbbWcH2tAGP26bGmGi0blzneqREQ9HGwHWIpj20IWRy/Yz2JDzwEWRtzqKX
         M7wzh+c36y2HFImCfEPa6X8f6SAAoOdwnqPg/koLzDr34SCk7VSQfmUtoXxrKsoqk0M4
         p3pXfw9RI+LxQ/TBF1UIBOqZ6g6h2drbMm/7F83PT78/inuJEaAVR27Adq1OnYY5Wm2b
         kYQw==
X-Gm-Message-State: AJcUukd7KHzZ/HiQ5eiYf0laWFZusqRb40oSGAjHjTvf68naU+ibkDCl
        aGDttNjj97U+IJalZqfI9Pg=
X-Google-Smtp-Source: ALg8bN6AvzUBiExKCOkspyMUff6jH4rSRk/E5vby/ZYRsetyxU6aI4TSTmlQGZeyunMdHarDkd1fCA==
X-Received: by 2002:a19:40cc:: with SMTP id n195mr11721242lfa.40.1547409250359;
        Sun, 13 Jan 2019 11:54:10 -0800 (PST)
Received: from acerlaptop.localnet ([2a02:a315:5445:5300:607a:1b80:a32f:5413])
        by smtp.gmail.com with ESMTPSA id 18-v6sm2212778ljg.83.2019.01.13.11.54.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 13 Jan 2019 11:54:09 -0800 (PST)
From:   =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     kgene@kernel.org, viresh.kumar@linaro.org, rjw@rjwysocki.net,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] cpufreq: s5pv210: Defer probe if getting regulators fail
Date:   Sun, 13 Jan 2019 20:54:08 +0100
Message-ID: <2003903.RuZpVZK7nJ@acerlaptop>
In-Reply-To: <20190113131624.GA2672@kozik-lap>
References: <20190111194244.2439-1-pawel.mikolaj.chmiel@gmail.com> <20190113131624.GA2672@kozik-lap>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On niedziela, 13 stycznia 2019 14:16:24 CET Krzysztof Kozlowski wrote:
> On Fri, Jan 11, 2019 at 08:42:44PM +0100, Pawe=C5=82 Chmiel wrote:
> > There is possibility, that when probing driver, regulators are not yet
> > initialized. In this case we should return EPROBE_DEFER and wait till
> > they're initialized, since they're required currently for cpufreq driver
> > to work. Also move regulator initialization code at beginning of probe,
> > so we can defer as fast as posibble.
> >=20
> > Signed-off-by: Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.com>
> > ---
> > Changes from v2:
> >   - Handle all error paths in probe
> >=20
> > Changes from v1:
> >   - Fix compilation error
> >   - Reorganize code so it's smaller
> > ---
> >  drivers/cpufreq/s5pv210-cpufreq.c | 68 ++++++++++++++++++++++---------
> >  1 file changed, 49 insertions(+), 19 deletions(-)
> >=20
> > diff --git a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv21=
0-cpufreq.c
> > index f51697f1e0b3..627b132e3e61 100644
> > --- a/drivers/cpufreq/s5pv210-cpufreq.c
> > +++ b/drivers/cpufreq/s5pv210-cpufreq.c
> > @@ -584,7 +584,7 @@ static struct notifier_block s5pv210_cpufreq_reboot=
_notifier =3D {
> >  static int s5pv210_cpufreq_probe(struct platform_device *pdev)
> >  {
> >  	struct device_node *np;
> > -	int id;
> > +	int id, result =3D 0;
> > =20
> >  	/*
> >  	 * HACK: This is a temporary workaround to get access to clock
> > @@ -594,18 +594,40 @@ static int s5pv210_cpufreq_probe(struct platform_=
device *pdev)
> >  	 * this whole driver as soon as S5PV210 gets migrated to use
> >  	 * cpufreq-dt driver.
> >  	 */
> > +	arm_regulator =3D regulator_get(NULL, "vddarm");
> > +	if (IS_ERR(arm_regulator)) {
> > +		if (PTR_ERR(arm_regulator) =3D=3D -EPROBE_DEFER)
> > +			pr_debug("vddarm regulator not ready, defer\n");
> > +		else
> > +			pr_err("failed to get regulator vddarm\n");
> > +		result =3D PTR_ERR(arm_regulator);
> > +		goto err_arm_regulator;
>=20
> Just return here.
=46ixed.
>=20
> > +	}
> > +
> > +	int_regulator =3D regulator_get(NULL, "vddint");
> > +	if (IS_ERR(int_regulator)) {
> > +		if (PTR_ERR(int_regulator) =3D=3D -EPROBE_DEFER)
> > +			pr_debug("vddint regulator not ready, defer\n");
> > +		else
> > +			pr_err("failed to get regulator vddint\n");
> > +		result =3D PTR_ERR(int_regulator);
> > +		goto err_int_regulator;
> > +	}
> > +
> >  	np =3D of_find_compatible_node(NULL, NULL, "samsung,s5pv210-clock");
> >  	if (!np) {
> >  		pr_err("%s: failed to find clock controller DT node\n",
> >  			__func__);
> > -		return -ENODEV;
> > +		result =3D -ENODEV;
> > +		goto err_clock;
> >  	}
> > =20
> >  	clk_base =3D of_iomap(np, 0);
> >  	of_node_put(np);
> >  	if (!clk_base) {
> >  		pr_err("%s: failed to map clock registers\n", __func__);
> > -		return -EFAULT;
> > +		result =3D -EFAULT;
> > +		goto err_clock;
> >  	}
> > =20
> >  	for_each_compatible_node(np, NULL, "samsung,s5pv210-dmc") {
> > @@ -614,7 +636,8 @@ static int s5pv210_cpufreq_probe(struct platform_de=
vice *pdev)
> >  			pr_err("%s: failed to get alias of dmc node '%pOFn'\n",
> >  				__func__, np);
> >  			of_node_put(np);
> > -			return id;
> > +			result =3D id;
> > +			goto err_clk_base;
> >  		}
> > =20
> >  		dmc_base[id] =3D of_iomap(np, 0);
> > @@ -622,33 +645,40 @@ static int s5pv210_cpufreq_probe(struct platform_=
device *pdev)
> >  			pr_err("%s: failed to map dmc%d registers\n",
> >  				__func__, id);
> >  			of_node_put(np);
> > -			return -EFAULT;
> > +			result =3D -EFAULT;
> > +			goto err_dmc;
> >  		}
> >  	}
> > =20
> >  	for (id =3D 0; id < ARRAY_SIZE(dmc_base); ++id) {
> >  		if (!dmc_base[id]) {
> >  			pr_err("%s: failed to find dmc%d node\n", __func__, id);
> > -			return -ENODEV;
> > +			result =3D -ENODEV;
> > +			goto err_dmc;
> >  		}
> >  	}
> > =20
> > -	arm_regulator =3D regulator_get(NULL, "vddarm");
> > -	if (IS_ERR(arm_regulator)) {
> > -		pr_err("failed to get regulator vddarm\n");
> > -		return PTR_ERR(arm_regulator);
> > -	}
> > -
> > -	int_regulator =3D regulator_get(NULL, "vddint");
> > -	if (IS_ERR(int_regulator)) {
> > -		pr_err("failed to get regulator vddint\n");
> > -		regulator_put(arm_regulator);
> > -		return PTR_ERR(int_regulator);
> > -	}
> > -
> >  	register_reboot_notifier(&s5pv210_cpufreq_reboot_notifier);
> > =20
> >  	return cpufreq_register_driver(&s5pv210_driver);
> > +
> > +err_dmc:
> > +	for (id =3D 0; id < ARRAY_SIZE(dmc_base); ++id)
> > +		if (dmc_base[id])
> > +			iounmap(dmc_base[id]);
>=20
> You will iounmap the same pointer twice, if first device bind failed
> while following this error path and someone tries to bind second time
> (again with error leading to this error path). You zero the pointer
> either at beginning of probe or after iounmapping.
Good catch, also fixed in v4.
Thanks
>=20
> Best regards,
> Krzysztof
>=20
>=20
> > +
> > +err_clk_base:
> > +	iounmap(clk_base);
> > +
> > +err_clock:
> > +	regulator_put(int_regulator);
> > +
> > +err_int_regulator:
> > +	regulator_put(arm_regulator);
> > +
> > +err_arm_regulator:
> > +
> > +	return result;
> >  }
> > =20
> >  static struct platform_driver s5pv210_cpufreq_platdrv =3D {
>=20




