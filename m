Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F330C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 07:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AE2720811
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 07:00:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HnRPoTGo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbfBDHAh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 02:00:37 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:53240 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbfBDHAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 02:00:36 -0500
Received: by mail-it1-f196.google.com with SMTP id d11so18811108itf.2;
        Sun, 03 Feb 2019 23:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xqqXQ1J5N+w2j3/DzgAhLl3CSEJh7W0fBIrjYxgwk0k=;
        b=HnRPoTGo4xCOOzf7tiPI9sYPvPCVaRJmeAqUst8dXpK/fVbJAAXC2nBU2V4v+94JYC
         MvyTjhYjTHpCdA0IvOh22OG3ckMmIabDP+YIkG8i6iKCsDKMx5smnSNIMyvuIYTS+idx
         c/SdXiLg0/mh/8q9SP/rauSjx4aYBDOl8179PHXNxy8OA0MUInTRofXHiLWckEIf9/q8
         muUfO85/xdoQ4EWSkmjNuFmDsz/7pbi4PkGWfh+N5A3uSqh2zNpBJ1eNy6EvN1TPIXTr
         FetYpLWu9aHxr26GKZ6iq8bcnaLsTEg2zxWNzcnmET54GpnGFZeV/CQY4gdeVBCN38hz
         3y1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xqqXQ1J5N+w2j3/DzgAhLl3CSEJh7W0fBIrjYxgwk0k=;
        b=N2ARKzALX3c5vsD1vYc59VA8kNCTXHDol/CKYUWSyC6li1ku8+ezs4xbmF0PJCrNhp
         OgEHcsYsdGJ5IAOebTafT2H5rmd9B53gv5QbEoQNOb+VFdQFsBW60ccz6rPTszFm5liM
         ebwM7XBvKycTqu+s0pcIbIqaozTN2E5w0KLP7oBwf2KyE70od2A5llfgIHoCpOyigE0Z
         Ze0k2eecQuwmK8yNIdtj7RisB9rkvcFnC+eTh+Be0Li/qGRNXNXFRyi7ISLBslC/FhKg
         EnA51Xddq7qWf3sCi69lLGB/XshTuPlRNhyiuD8UKLsyazpJzJ6746fpBFmrmlBeCkDO
         RqGA==
X-Gm-Message-State: AHQUAuZFCR6sh5eqRXZgtXiuiFZfO7s2F6H05vSXyWY9hVm94ocBiDSH
        TDHYTsI9K+9RfBMQZ4B2ZhZqGAT4k1Ktx7Cvxtc=
X-Google-Smtp-Source: ALg8bN5whRikDPrK240vpeQw/BpWyIzNvy3GtfpYylwnt+NbFfhlNW/8uS6IRT2hzTVVDxfFyC0aWdloNR8RH+PvAF0=
X-Received: by 2002:a6b:9355:: with SMTP id v82mr30891746iod.40.1549263635927;
 Sun, 03 Feb 2019 23:00:35 -0800 (PST)
MIME-Version: 1.0
References: <20190204063501.1348-1-tiny.windzz@gmail.com> <20190204063615.yr4fbz3b7ovbm7a2@vireshk-i7>
In-Reply-To: <20190204063615.yr4fbz3b7ovbm7a2@vireshk-i7>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Mon, 4 Feb 2019 15:00:13 +0800
Message-ID: <CAEExFWvcWAmzKtnCdnVNJz1kh1QQ-Y8-LRpH36YacQerFpOS9A@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: tegra124: add missing of_node_put()
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     rjw@rjwysocki.net, Thierry Reding <thierry.reding@gmail.com>,
        jonathanh@nvidia.com, Linux PM <linux-pm@vger.kernel.org>,
        linux-tegra@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 4, 2019 at 2:36 PM Viresh Kumar <viresh.kumar@linaro.org> wrote=
:
>
> On 04-02-19, 01:35, Yangtao Li wrote:
> > of_cpu_device_node_get() will increase the refcount of device_node,
> > it is necessary to call of_node_put() at the end to release the
> > refcount.
> >
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > ---
> >  drivers/cpufreq/tegra124-cpufreq.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/cpufreq/tegra124-cpufreq.c b/drivers/cpufreq/tegra=
124-cpufreq.c
> > index 43530254201a..140a9266b64a 100644
> > --- a/drivers/cpufreq/tegra124-cpufreq.c
> > +++ b/drivers/cpufreq/tegra124-cpufreq.c
> > @@ -118,6 +118,8 @@ static int tegra124_cpufreq_probe(struct platform_d=
evice *pdev)
> >               goto out_put_pllx_clk;
> >       }
> >
> > +     of_node_put(np);
> > +
> >       ret =3D tegra124_cpu_switch_to_dfll(priv);
> >       if (ret)
> >               goto out_put_pllp_clk;
>
> Fixes and stable tags ?
Hi viresh,

Like this=EF=BC=9F

Fixes: 9eb15dbbfa1a2 ("cpufreq: Add cpufreq driver for Tegra124")
Cc: stable@vger.kernel.org

MBR,
Yangtao
>
> --
> viresh
