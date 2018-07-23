Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 862DDECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 18:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4139520671
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 18:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LH0DuA27"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4139520671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388176AbeGWT3l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 15:29:41 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:39680 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387873AbeGWT3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 15:29:41 -0400
Received: by mail-oi0-f66.google.com with SMTP id d189-v6so2885792oib.6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 11:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QAD8VkzUnoxt0oaFEdR8oTU9ignL1cZncWX5BkYRV8k=;
        b=LH0DuA27lHrEVHa27rly4RpH4+a844Hq3GScrlHfLdYKIEVptBKVEo8hUYJyjb477s
         InR3oiOA8tBhm/LpuOboFgtb8obc0TXSlCEXd9LJwxVCnPFUKlFZXm2PcU6jlHLx9Jsg
         N8jjWJ0UzKDJA80c5/S1a3Suu2YIdJDDfjE8rTZz43dQymazWRSVH0YSiHSekBTYfL0h
         XB4OiIYQzY9bHLzYP+JQEDbvzvh2NFtBy5rYewGNcNZiRQEPyyEkIfeMFSoS7mKpelxL
         osQMtqKiPyf9B3FL2nhQ3SQtPqwlAC6N2VdmQK+RVA7cpe/NZONrnOUJT95lko1umA+V
         1IRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=QAD8VkzUnoxt0oaFEdR8oTU9ignL1cZncWX5BkYRV8k=;
        b=SfQR9WB/zfOvIWaqV/GQ1uxPW0yvJYFTFN0noK+YPWhcBnZpfOX/JD7YWU5yfPgRBT
         j82aDXbDzRs7Lly3Pmo1mdsZYnNo1QQ3SHM5OleVU0Q37RRsMQaINtxPBMgiDYVNIe3w
         EhW8qrzoONZ4M4Ie+HG/d1mRsNAmwdfZTBxVPGJzL8uJUXTQMUAWsdpuw77o2sIYlYvY
         6OQfFjCLv2rLhew0M5PQNQnGph4VXvuiF8oW5z6kIP1sthlnQHRX7IAxtYOuLGFy9bJ3
         hM2SKb7yttGlSP+AnN/b5WSW5g2I613KTx5fwLFj+KquJUOHo0JtOK9dkW9wKSi1XtD9
         OqgQ==
X-Gm-Message-State: AOUpUlFla9WIKG7pC7We/owfJKea9wBq/sqj1vRG4e/jf4HRgV2ipwPZ
        b1bi14yrnaVJMW5TDhLpuNA=
X-Google-Smtp-Source: AAOMgpcUAhwNKGRIi0rioPslJUfHJTZG6j1HosHd/5XeCKeCN6gVU9MBSQHPD9NtuIJtApUU+yhuIA==
X-Received: by 2002:aca:4c8e:: with SMTP id z136-v6mr10331085oia.170.1532370432402;
        Mon, 23 Jul 2018 11:27:12 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id v202-v6sm8691370oie.47.2018.07.23.11.27.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 11:27:11 -0700 (PDT)
Date:   Mon, 23 Jul 2018 11:27:10 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Anton Vasilyev <vasilyev@ispras.ru>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Holland <samuel@sholland.org>,
        Pan Bian <bianpan2016@163.com>, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: Re: [PATCH] firmware: vpd: Fix section enabled flag on
 vpd_section_destroy
Message-ID: <20180723182710.GB2964@roeck-us.net>
References: <20180723164857.24460-1-vasilyev@ispras.ru>
 <20180723171336.GA15900@roeck-us.net>
 <20180723172305.GD100814@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180723172305.GD100814@dtor-ws>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 10:23:05AM -0700, Dmitry Torokhov wrote:
> On Mon, Jul 23, 2018 at 10:13:36AM -0700, Guenter Roeck wrote:
> > On Mon, Jul 23, 2018 at 07:48:57PM +0300, Anton Vasilyev wrote:
> > > static struct ro_vpd and rw_vpd are initialized by vpd_sections_init()
> > > in vpd_probe() based on header's ro and rw sizes.
> > > In vpd_remove() vpd_section_destroy() performs deinitialization based
> > > on enabled flag, which is set to true by vpd_sections_init().
> > > This leads to call of vpd_section_destroy() on already destroyed section
> > > for probe-release-probe-release sequence if first probe performs
> > > ro_vpd initialization and second probe does not initialize it.
> > > 
> > 
> > I am not sure if the situation described can be seen in the first place.
> > The second probe would only not perform ro_vpd initialization if it fails
> > prior to that, ie if it fails to allocate memory or if there is a
> > consistency problem. In that case the remove function would not be called.
> > 
> > However, there is a problem in the code: A partially failed probe will
> > leave the system in inconsistent state. Example: ro section initializes,
> > rw section fails to initialize. The probe will fail, but the ro section
> > will not be destroyed, its sysfs attributes still exist, and its memory
> > is still mapped. It would make more sense to fix _that_ problem.
> > Essentially, vpd_sections_init() should clean up after itself after it
> > fails to initialize a section.
> > 
> > Note that I am not convinced that the "enabled" flag is needed in the first
> > place. It is only relevant if vpd_section_destroy() is called, which only
> > happens from the remove function. The remove function is only called if the
> > probe function succeeded. In that case it is always set for both sections.
> 
> The problem will happen if coreboot memory changes between 2 probes so
> that header.ro_size is not 0 on the first pass and is 0 on the second
> pass. Not quite likely to ever happen in real life, but resetting a flag
> is pretty cheap to not do it.
> 

If that can happen between probes, meaning it is not guaranteed to be
constant during the lifetime of the system, doesn't that mean it can
happen anytime ?

Guenter
