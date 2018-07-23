Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C5A2ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8F1F20852
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:23:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YtsFKhIZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8F1F20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388313AbeGWSZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 14:25:23 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39255 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388002AbeGWSZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 14:25:22 -0400
Received: by mail-pg1-f194.google.com with SMTP id g2-v6so847622pgs.6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 10:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Z6U6NzqQTICtvDwK/fn8bUHW2tW43DN5qIhaDGwWUpo=;
        b=YtsFKhIZ9abPLrvRx0xjrYzy7IIehHxeK83H2L0u+PZgximzcH/vNktqRienjf4Utr
         qDeJo1AldbzopBz1Y/SgaofXc7M6xtsb9I+QdObpggBzhKqeJxDe2pWMbtrVYsx7Nr2J
         gRITBWwt3x4mTlKKde+v0LPKBgGZUXNpzljtV9nCIUdN+ilVbVkMZh3sU9UoKGXNwn/u
         sappBjdhRQK/mRst0bh6qBzdXUrCuOJ4jgNZ/GDihyOA+Goi12f+436r8hSG55SjFuLe
         wigZ4oBhoNLIKcdvlJVzo1eOal7LeM0/QaAsnW5Aljdq2lYAjyYxXc0rex7tOyOLdrGR
         y65w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z6U6NzqQTICtvDwK/fn8bUHW2tW43DN5qIhaDGwWUpo=;
        b=tMg/X54XZ8aa4qvcGRwA3zXvQyWPUO5MZZ3OfTDkBCbBSJ+Q/UN8NEx91d2D41LEqU
         /jEvR5/GePDHx6Bbs4KR7DTKFhGZKE+3tVXv4YaZVAAzOz15npKUq4m4DZZv40iIhHE0
         hV8a9Yohk0pZPJhA4AnwjdyjdL+PX/n1Ek1GJfY+nz9Tpn54Vb/Arwwy8HADBNSzwPaq
         Okp2AuBmktykfalZAur7Jikt6FHfm0YhWgIhUkdF2MY5L4SMtOJ5n/ir4o5eNIASBOSr
         nc8QFAI9zHLEHqRz26SE2vC9w6OCtlBcwJWBg+BXcWyNPpWXdUW40VJzjZNtvVmpLtLS
         3oHQ==
X-Gm-Message-State: AOUpUlG634Zp1PmJ/TSEYuyoexhiit+dZcuABNkxUsMg089elvOLuni+
        /rMITDqvRByggajoPpmhDOA=
X-Google-Smtp-Source: AAOMgpfEeEIenJNdjbbi4SGEWDLBzcmLcOMHN9NrKjW95W5+pSDUSDrVLr4Z2GAldkmJuvtF3LSNwg==
X-Received: by 2002:a63:d011:: with SMTP id z17-v6mr12779464pgf.272.1532366588641;
        Mon, 23 Jul 2018 10:23:08 -0700 (PDT)
Received: from dtor-ws ([2620:0:1000:1511:8de6:27a8:ed13:2ef5])
        by smtp.gmail.com with ESMTPSA id z2-v6sm10684864pgv.12.2018.07.23.10.23.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jul 2018 10:23:07 -0700 (PDT)
Date:   Mon, 23 Jul 2018 10:23:05 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Anton Vasilyev <vasilyev@ispras.ru>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Holland <samuel@sholland.org>,
        Pan Bian <bianpan2016@163.com>, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: Re: [PATCH] firmware: vpd: Fix section enabled flag on
 vpd_section_destroy
Message-ID: <20180723172305.GD100814@dtor-ws>
References: <20180723164857.24460-1-vasilyev@ispras.ru>
 <20180723171336.GA15900@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180723171336.GA15900@roeck-us.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 10:13:36AM -0700, Guenter Roeck wrote:
> On Mon, Jul 23, 2018 at 07:48:57PM +0300, Anton Vasilyev wrote:
> > static struct ro_vpd and rw_vpd are initialized by vpd_sections_init()
> > in vpd_probe() based on header's ro and rw sizes.
> > In vpd_remove() vpd_section_destroy() performs deinitialization based
> > on enabled flag, which is set to true by vpd_sections_init().
> > This leads to call of vpd_section_destroy() on already destroyed section
> > for probe-release-probe-release sequence if first probe performs
> > ro_vpd initialization and second probe does not initialize it.
> > 
> 
> I am not sure if the situation described can be seen in the first place.
> The second probe would only not perform ro_vpd initialization if it fails
> prior to that, ie if it fails to allocate memory or if there is a
> consistency problem. In that case the remove function would not be called.
> 
> However, there is a problem in the code: A partially failed probe will
> leave the system in inconsistent state. Example: ro section initializes,
> rw section fails to initialize. The probe will fail, but the ro section
> will not be destroyed, its sysfs attributes still exist, and its memory
> is still mapped. It would make more sense to fix _that_ problem.
> Essentially, vpd_sections_init() should clean up after itself after it
> fails to initialize a section.
> 
> Note that I am not convinced that the "enabled" flag is needed in the first
> place. It is only relevant if vpd_section_destroy() is called, which only
> happens from the remove function. The remove function is only called if the
> probe function succeeded. In that case it is always set for both sections.

The problem will happen if coreboot memory changes between 2 probes so
that header.ro_size is not 0 on the first pass and is 0 on the second
pass. Not quite likely to ever happen in real life, but resetting a flag
is pretty cheap to not do it.

Thanks.

-- 
Dmitry
