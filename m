Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70471ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 18:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31C1720854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 18:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mSwePgeQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31C1720854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388187AbeGWTmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 15:42:02 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36955 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387982AbeGWTmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 15:42:02 -0400
Received: by mail-pg1-f194.google.com with SMTP id n7-v6so991784pgq.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 11:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=03YB4mgAcHqi5NsutqHB2E5ECI+CGD2sMgBRDPTSf3Q=;
        b=mSwePgeQ1ZCXNt526GE6efkmIizktdEc6TI2poSmRcukCny/WnJU0ZHgi0UKruGkej
         BdCQET8k9kKb7Ci0dYZi1icDbfmzyZ3ten3SKD5S/5H8d5rFxaBtw5+WisXWOz/mfx9p
         M1hc0U3rw5P7hFIijC3G2yqyk/nnHaEc9CS3iJqHVxeR8SdpuY6o5TXibVqEjceBdC2t
         VsrOsCUr5oiZLZcNRmwxzuQaP/lEYq4EFcXwmL5lVUu/bqW1/VvGZ4WBj34x9RHzIj5u
         Cb92Y4ONWX6GttrcONqEur+ecKA4xt4R8SZ7I+OK0vHfH57k/XMfA4KCPqSquWpEzsC7
         7KFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=03YB4mgAcHqi5NsutqHB2E5ECI+CGD2sMgBRDPTSf3Q=;
        b=CB6YUPFpSNBcQ7Y34ROBuHiZ1/PdwEbNTNmOGlhsLQLBx2DcVdYJGLqzlsAB/6GSZu
         +17fAu89LrMxgSRddLLw+cw1NamK466rBUNHSnAypSlGAfEqwLNuCbEESOiUujGWdZrp
         t9DuZ6B6zmbn8lp92yBaNh538veyNszDuCR/A50H3W2+DAHENe/XJ78NTCQzZgAtjKqb
         xj59LmZywcf4iNj4y7XnKFVWYY5sC1E/PJfutCmGYNwUAx93iISQYigaPY0L0ZcZ8FMY
         dgPYKifbcMIuBa9xj7uSwoiYidA2pfDkOPBsxej7Qn9bJIsnsL17ySlQ/5Ig3QdfpcbB
         JPSw==
X-Gm-Message-State: AOUpUlGS2QujXEWxVbBgKe78P6wnwas5sfK/BtEAUo8YM6JEc13nmzxR
        Calo/FLCBdeXFTP/jfg9zb8=
X-Google-Smtp-Source: AAOMgpeUnMPX18wg+2wSWwg93yAXLjPsTUF5A83gCCncTqswLvSipnwLy7akqMSa3W2ye9eCtfh9Qg==
X-Received: by 2002:a62:571b:: with SMTP id l27-v6mr14451353pfb.29.1532371170598;
        Mon, 23 Jul 2018 11:39:30 -0700 (PDT)
Received: from dtor-ws ([2620:0:1000:1511:8de6:27a8:ed13:2ef5])
        by smtp.gmail.com with ESMTPSA id b67-v6sm15144088pfd.74.2018.07.23.11.39.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jul 2018 11:39:29 -0700 (PDT)
Date:   Mon, 23 Jul 2018 11:39:27 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Anton Vasilyev <vasilyev@ispras.ru>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Holland <samuel@sholland.org>,
        Pan Bian <bianpan2016@163.com>, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: Re: [PATCH] firmware: vpd: Fix section enabled flag on
 vpd_section_destroy
Message-ID: <20180723183927.GH100814@dtor-ws>
References: <20180723164857.24460-1-vasilyev@ispras.ru>
 <20180723171336.GA15900@roeck-us.net>
 <20180723172305.GD100814@dtor-ws>
 <20180723182710.GB2964@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180723182710.GB2964@roeck-us.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 11:27:10AM -0700, Guenter Roeck wrote:
> On Mon, Jul 23, 2018 at 10:23:05AM -0700, Dmitry Torokhov wrote:
> > On Mon, Jul 23, 2018 at 10:13:36AM -0700, Guenter Roeck wrote:
> > > On Mon, Jul 23, 2018 at 07:48:57PM +0300, Anton Vasilyev wrote:
> > > > static struct ro_vpd and rw_vpd are initialized by vpd_sections_init()
> > > > in vpd_probe() based on header's ro and rw sizes.
> > > > In vpd_remove() vpd_section_destroy() performs deinitialization based
> > > > on enabled flag, which is set to true by vpd_sections_init().
> > > > This leads to call of vpd_section_destroy() on already destroyed section
> > > > for probe-release-probe-release sequence if first probe performs
> > > > ro_vpd initialization and second probe does not initialize it.
> > > > 
> > > 
> > > I am not sure if the situation described can be seen in the first place.
> > > The second probe would only not perform ro_vpd initialization if it fails
> > > prior to that, ie if it fails to allocate memory or if there is a
> > > consistency problem. In that case the remove function would not be called.
> > > 
> > > However, there is a problem in the code: A partially failed probe will
> > > leave the system in inconsistent state. Example: ro section initializes,
> > > rw section fails to initialize. The probe will fail, but the ro section
> > > will not be destroyed, its sysfs attributes still exist, and its memory
> > > is still mapped. It would make more sense to fix _that_ problem.
> > > Essentially, vpd_sections_init() should clean up after itself after it
> > > fails to initialize a section.
> > > 
> > > Note that I am not convinced that the "enabled" flag is needed in the first
> > > place. It is only relevant if vpd_section_destroy() is called, which only
> > > happens from the remove function. The remove function is only called if the
> > > probe function succeeded. In that case it is always set for both sections.
> > 
> > The problem will happen if coreboot memory changes between 2 probes so
> > that header.ro_size is not 0 on the first pass and is 0 on the second
> > pass. Not quite likely to ever happen in real life, but resetting a flag
> > is pretty cheap to not do it.
> > 
> 
> If that can happen between probes, meaning it is not guaranteed to be
> constant during the lifetime of the system, doesn't that mean it can
> happen anytime ?

I think we can assume that the data is stable while coreboot device is
registered, but I can imagine one can theoretically have a debug
coreboot data provider that can supply different coreboot parameters
across load/unload. I.e. we have coreboot_table-acpi.c and
coreboot_table-of.c, we might create coreboot_table-test.c to feed
arbitrary data to the subsystem.

Thanks.

-- 
Dmitry
