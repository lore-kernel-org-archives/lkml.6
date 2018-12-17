Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5DEFC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B25420874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545072486;
	bh=4wdQJIeRBldxOvVZbdMFSE8oFjBPshEgUnTAYnu8hSE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1pBqzzqWaKnD4knru+fXyIyit0L1YLuVsz+yadADBKIewF+F/sBpQFGQSblkTOCcz
	 fhWXEKedmCRu4La/shtarwz6L0QshoVhDgBU7kkdPYS/2hjOoTMWiA9ZccPH930b9/
	 JXeQeTjCajF3+uLFFXA/wY/OzD022oEqXNuKQzjw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389196AbeLQSsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 13:48:05 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45685 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbeLQSsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 13:48:05 -0500
Received: by mail-wr1-f68.google.com with SMTP id t6so13203534wrr.12
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 10:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=n2cC8Nq9eAri5YjBZ4emSGU52KnmqGpS1CtezMIx04w=;
        b=mFmmKbV6YhYRY2j1Dn7oGxsAuSRbf8vMiZJbqr3Vc3jeF4nffojI2JHqRmD8n6PGfM
         No95kMtGanTdtO8s71lW5SWWKEDwVj0saiAD1x5QZozYnDRZukHg6nmfYi725EgnzTZ3
         Z58rGzRpBDExs4evt4UVvPYUFdcmJyShQkIHKrtrnrt4hLV/36MJeNOwl/cnoAvuEUS6
         neLbPOEprAHeAgBfLsjQELuKzKh2d4lfUGjPRkccn88iCWNLOw8VeWz+kU6srRIWB5O6
         FFsbZy4E/m7sXKJIN1B48S8DBTx/w0aACYXGxr7buI3KZ1bc9Ppmv1njnOpRdkFixKq9
         Weig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=n2cC8Nq9eAri5YjBZ4emSGU52KnmqGpS1CtezMIx04w=;
        b=ih/WgvkzjIW/VXXGLmDT9bAxvw75dvJchuAufvQtLNp0pCextdvwa/pmF2E0z8cnB+
         v2l2S/dol6j1bYuIDuJndNvilJePZHXgTThi9PsVZA12wabK3N506K8/ATyzs8pHzNe4
         6uotNdm3AQEW8BylvwiXuu97VW3Ne9iNKkrir1vwL+WFp8x4SEWwK8LzXa6/wFopxqQ1
         iMR7MMDOSGHIiChfZcFCWAKEw7gRKKYlc8XRxQM3P4NjkcdqPSkcspya1xfmKqdUN45K
         U8X8qGRwqiNW30nO5NOQZoFgdMfcohaZnKGM14/Sqa7BEXwZZRxqvcrWa6Q/n1Nr3EKu
         mw3w==
X-Gm-Message-State: AA+aEWYVEiKNpJr8hftnZF5QoaBMNpyi+Bh2IXkWVry7AQIMU/jBo1Yn
        rq08gQHJkwVIAKQ/dpbI8HU=
X-Google-Smtp-Source: AFSGD/V40Z1IwJPRCOLonh3nD9NlCf2P31ZsdhA3C1D2K4JTD1p8YkD0yP+eXJzKR1uA5SEf+uUwVA==
X-Received: by 2002:adf:ed92:: with SMTP id c18mr11979554wro.194.1545072482991;
        Mon, 17 Dec 2018 10:48:02 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id q185sm63712wmg.14.2018.12.17.10.48.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 10:48:02 -0800 (PST)
Date:   Mon, 17 Dec 2018 19:48:00 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Chao Fan <fanc.fnst@cn.fujitsu.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, bp@alien8.de, mingo@redhat.com, hpa@zytor.com,
        keescook@chromium.org, bhe@redhat.com, msys.mizuma@gmail.com,
        indou.takao@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com
Subject: Re: [PATCH v14 1/5] x86/boot: Introduce get_acpi_rsdp() to parse
 RSDP in cmdline from KEXEC
Message-ID: <20181217184800.GA60403@gmail.com>
References: <20181214093013.13370-1-fanc.fnst@cn.fujitsu.com>
 <20181214093013.13370-2-fanc.fnst@cn.fujitsu.com>
 <20181217172510.GA90818@gmail.com>
 <alpine.DEB.2.21.1812171930280.1660@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1812171930280.1660@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> On Mon, 17 Dec 2018, Ingo Molnar wrote:
> > * Chao Fan <fanc.fnst@cn.fujitsu.com> wrote:
> > > +		val[len] = '\0';
> > > +		return (acpi_physical_address)simple_strtoull(val, &e, 16);
> > 
> > 'return' is not a function - no need for the parenthesis.
> 
> It's a typecast which better has parenthesis....

Yeah, see my followup to the other reply where I withdraw the objection 
and point out the ugliness of the various typecasts.

Thanks,

	Ingo
