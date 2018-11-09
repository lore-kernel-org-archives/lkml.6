Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF16EC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 03:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A14C020817
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 03:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k6qciurj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A14C020817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbeKINbQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 08:31:16 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:38537 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727445AbeKINbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 08:31:16 -0500
Received: by mail-ua1-f67.google.com with SMTP id p9so178017uaa.5;
        Thu, 08 Nov 2018 19:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=kp69naeihrpUWteWnlPaZNQ668DpPHXuKMs/WaC8cFE=;
        b=k6qciurjrrzRmniG+fA9feSvbxb8G+yHUFQ+LbsoGmM/zUqYYH2I3umFe/54J4Ary2
         m0MS4aYxjQDfyqTWXVnhTADr6mWfiohntT+nI73tCs3ZEc5CEdJjizki8GV4SRTjpYYD
         ILRiX/V/lEsL5D+9CgMtRgmkdoSgQqlemCMLBqOF1ib0BQ05Ea7D5KjBFBhc6ajNLL6A
         i9Jigp2A2KV3Cef5yaQxm8O2YAT+hQTJxoeKOfmX9JW4Qt0BJTGn0VqwryMqHGPnfiUQ
         kIcfHaRaOy+I2uoml5XB5NcizBCwlqZTGd6WmCeJKEaj3oZKBQ+z9c83jt//stEFxAgx
         flhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=kp69naeihrpUWteWnlPaZNQ668DpPHXuKMs/WaC8cFE=;
        b=FiiOvFgpo03uqVvKP2UWZXS2cB4s1259p/Ba5/EexQcpwktmJ3vyWSQkfNZSH+AUG0
         oWp9Cy0tOCCuMja0Y/JZEsrruuP/Pjv5zJxdMWGyZ6OcWAdS+vmfqhN9CWNsxiMJ1B+F
         dEfRqQWvHVBdfDyLcdgd+6F+84ZmFwhZW4pBnX9Q7Sk/1Cd+C5q0za51ocEExDmgr9av
         H/PC5bLigDst5Mx513MXYmhyU2x26eE5TF9+zLkdxhZjLwdsam0Ir6xXC5OAbtI5BdqT
         +aYxclm63anWGM6LEkvBjO6YX3FtXyGYSsUaeAubO1QDDCo1l3q5RgcHCW0i46+g3axv
         lTtQ==
X-Gm-Message-State: AGRZ1gLlf7IQOC69R909WFhGRYWh4h2CLWuiHJLS6nU1gEx1Y0TpPrGW
        LwEJcjlSO0USw+YXX58VL/OZH1f5Vg==
X-Google-Smtp-Source: AJdET5fsnhh2UbYvo+5EvGWWiv+P2LGNmYMzsDRm9cbcYtQQdknEXEYu+PNxpaRbSCTwFq2BBxzBmA==
X-Received: by 2002:ab0:2746:: with SMTP id c6mr3324293uap.123.1541735553727;
        Thu, 08 Nov 2018 19:52:33 -0800 (PST)
Received: from 960.ws ([2601:902:c200:6512:a7fd:514d:7aab:c075])
        by smtp.gmail.com with ESMTPSA id n136sm1148543vka.20.2018.11.08.19.52.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 19:52:33 -0800 (PST)
Message-ID: <d3c913eb8854efbbf6b737cf94edc95179d58f59.camel@gmail.com>
Subject: Re: [PATCH v3 1/3] x86: add support for Huawei WMI hotkeys.
From:   ayman.bagabas@gmail.com
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kailang Yang <kailang@realtek.com>,
        Hui Wang <hui.wang@canonical.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
Date:   Thu, 08 Nov 2018 22:52:31 -0500
In-Reply-To: <CAHp75Vev_0ObO=KLHfON8JAco=a9MURycH9uk-a+h1JqrSSQFA@mail.gmail.com>
References: <20181108171701.4444-1-ayman.bagabas@gmail.com>
         <20181108171701.4444-2-ayman.bagabas@gmail.com>
         <CAHp75Vev_0ObO=KLHfON8JAco=a9MURycH9uk-a+h1JqrSSQFA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.1 (3.30.1-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-11-08 at 21:58 +0200, Andy Shevchenko wrote:
> On Thu, Nov 8, 2018 at 7:17 PM Ayman Bagabas <ayman.bagabas@gmail.com
> > wrote:
> > This driver adds support for missing hotkeys on some Huawei
> > laptops.
> > Currently, only Huawei Matebook X and Matebook X Pro is supported.
> > 
> 
> Thanks for an update, my comments below.
> 
> 
> > +config HUAWEI_LAPTOP
> > +       tristate "Huawei WMI hotkeys driver"
> > +       depends on ACPI
> 
> Do you need an ACPI dependency be explicit here?

Probably don't need it.

> 
> > +       depends on ACPI_WMI
> > +       depends on INPUT
> > +       select INPUT_SPARSEKMAP
> > +       help
> > +         This driver provides support for Huawei WMI hotkeys.
> > +         It enables the missing keys and adds support to the
> > micmute
> > +         LED found on some of these laptops.
> > +/*
> > + *  Huawei WMI hotkeys
> > + *
> > + *  Copyright (C) 2018       Ayman Bagabas <
> > ayman.bagabas@gmail.com>
> > + *
> > + *  This program is free software: you can redistribute it and/or
> > modify
> > + *  it under the terms of the GNU General Public License as
> > published by
> > + *  the Free Software Foundation, either version 2 of the License,
> > or
> > + *  (at your option) any later version.
> > + *
> > + *  This program is distributed in the hope that it will be
> > useful,
> > + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + *  GNU General Public License for more details.
> > + *
> > + *  You should have received a copy of the GNU General Public
> > License
> > + *  along with this program.  If not, see <
> > https://www.gnu.org/licenses/>;.
> > + *
> 
> Please, replace this boilerplate text with appropriate SPDX
> identifier.

Soryy about that. This alright?

// SPDX-License-Identifier: GPL-2.0
/*
 * Huawei WMI hotkeys
 *
 * Copyright (C) 2018		Ayman Bagabas <ayman.bagabas@gmail.com>
 */



