Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E64BC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 07:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD36D2083B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 07:27:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TpSI9mj+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbfBDH1A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 02:27:00 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:52549 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbfBDH07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 02:26:59 -0500
Received: by mail-it1-f196.google.com with SMTP id d11so18923697itf.2;
        Sun, 03 Feb 2019 23:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=h+O1CotubhA54vuEL29OkxVUunVNlxut8Sy5sPIthHM=;
        b=TpSI9mj+NFU+//P25GdVauB2h2QgxvnTdlEHf9zST7aNi92/n3atvLLJ30ZHb83zgK
         kp+EjGJfQuEue9MwxdMfp/vp4cFcUyc6UHo0wM6DbOg0/x/vTxWdcbtUJPteYmOvHgoJ
         8Du6AlV9y/1g9e8xmyYOv7tPDOWlRKc0eHFbnhpOv+HVj96C+8TLvETKazCnoIPilCWm
         NjwAgBwa7B7JWsZ26vqc2uc6hzsCRzUzVOX9BebwWXpWoIgh+KoZpTuG3pwEzig2rcwR
         kodrU76HIsPy2582RqgKTOkR7BSiwoOYo0GKtDnaFEyniVyqO6BmAvRJRsIq2Sr+eZks
         Gakg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=h+O1CotubhA54vuEL29OkxVUunVNlxut8Sy5sPIthHM=;
        b=ay+lDEVNucStO0v8sqB4fgIfj+1Bbq0XZbPBMWFPTrlrQ1S3AyCcXnWivFpMwVbpIa
         +buOjIpSrx9oaHAx3rnzTi14rEmAXBFqz92bHeZ+ArxWmuUqzgx0we2JxFew21hZ0Vd4
         9k3h5M4ebUDueDR2grq+gXCk93PvmciNN2d/N+D3pZNyw+kKi3yN6Rs3Fk+TnGh4OrR+
         Id9kVFSiIHZCDBNv6a/FHevBs7r3ZJKRlFRY7X0GNEkR1iSDSe+Fz6hW2k92hB7Mo8Xo
         7gscC+nPFvYuQQ5kbFdcUQQ0uyQENVJH8BNTi+H29EXiEtzFFIHXtJdmhJbaZol3zPNd
         t40Q==
X-Gm-Message-State: AHQUAuaLUAWZwicJiciPS8use/alKY8Nt/wBahhuTahbmgDh+HBUNyah
        oQZSafI58OeKdRVxX0is/NehT/OsMmNdnf0cerC71x7w+I4=
X-Google-Smtp-Source: AHgI3IZSbIfNA3sYwkjFrskqmICIccSLMcrwrH+vWEOYCl3UctLcT7PxJ5Aq77aemQR3DYiFIlXDQ8pP85StLsAJ0O4=
X-Received: by 2002:a24:7b90:: with SMTP id q138mr7605736itc.37.1549265218784;
 Sun, 03 Feb 2019 23:26:58 -0800 (PST)
MIME-Version: 1.0
References: <20190204063501.1348-1-tiny.windzz@gmail.com> <20190204063615.yr4fbz3b7ovbm7a2@vireshk-i7>
 <CAEExFWvcWAmzKtnCdnVNJz1kh1QQ-Y8-LRpH36YacQerFpOS9A@mail.gmail.com> <20190204071809.versc7prqit3vzgc@vireshk-i7>
In-Reply-To: <20190204071809.versc7prqit3vzgc@vireshk-i7>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Mon, 4 Feb 2019 15:26:36 +0800
Message-ID: <CAEExFWtzRJX6-_A2mgKpRuvSws7SNZPMAbcuPu-maP3Jh=xnyg@mail.gmail.com>
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

On Mon, Feb 4, 2019 at 3:18 PM Viresh Kumar <viresh.kumar@linaro.org> wrote=
:
>
> On 04-02-19, 15:00, Frank Lee wrote:
> > On Mon, Feb 4, 2019 at 2:36 PM Viresh Kumar <viresh.kumar@linaro.org> w=
rote:
> > >
> > > On 04-02-19, 01:35, Yangtao Li wrote:
> > > > of_cpu_device_node_get() will increase the refcount of device_node,
> > > > it is necessary to call of_node_put() at the end to release the
> > > > refcount.
> > > >
> > > > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > > > ---
> > > >  drivers/cpufreq/tegra124-cpufreq.c | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > >
> > > > diff --git a/drivers/cpufreq/tegra124-cpufreq.c b/drivers/cpufreq/t=
egra124-cpufreq.c
> > > > index 43530254201a..140a9266b64a 100644
> > > > --- a/drivers/cpufreq/tegra124-cpufreq.c
> > > > +++ b/drivers/cpufreq/tegra124-cpufreq.c
> > > > @@ -118,6 +118,8 @@ static int tegra124_cpufreq_probe(struct platfo=
rm_device *pdev)
> > > >               goto out_put_pllx_clk;
> > > >       }
> > > >
> > > > +     of_node_put(np);
> > > > +
> > > >       ret =3D tegra124_cpu_switch_to_dfll(priv);
> > > >       if (ret)
> > > >               goto out_put_pllp_clk;
> > >
> > > Fixes and stable tags ?
> > Hi viresh,
> >
> > Like this=EF=BC=9F
> >
> > Fixes: 9eb15dbbfa1a2 ("cpufreq: Add cpufreq driver for Tegra124")
> > Cc: stable@vger.kernel.org
>
> This needs to be something like:
>
> Cc: 4.5+ stable@vger.kernel.org #4.5+
>
> Also I don't think your patch is entirely correct as we will end up
> doing of_node_put() twice in error path.
Thanks for your reminder, I will modify it immediately.

MBR,
Yangtao
>
> --
> viresh
