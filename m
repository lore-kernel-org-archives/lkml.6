Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02ED7C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 21:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC7312082E
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 21:45:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ossystems-com-br.20150623.gappssmtp.com header.i=@ossystems-com-br.20150623.gappssmtp.com header.b="Ld2uDqjN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC7312082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ossystems.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbeKZIhc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 03:37:32 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42347 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbeKZIhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 03:37:31 -0500
Received: by mail-ot1-f68.google.com with SMTP id v23so9431556otk.9
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 13:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ossystems-com-br.20150623.gappssmtp.com; s=20150623;
        h=from:mime-version:references:in-reply-to:date:message-id:subject:to
         :cc;
        bh=ej5mFASv08lfE5fjlj5txVq02+/3jgEyMXF5gVS0gUI=;
        b=Ld2uDqjNA57fCucEGjWUeMbmF+QnqIWs2pvRSb3Ao9y9oRTWe+pqCYWdr7hbTh3PmI
         r4FTN710Pq2bML/BtKEtsLWNDkDLhKbd2n3SiQlIHvKvFBeE7/UJKWc3WE8aTSqWlZle
         5LajBh+ZzFe8PYsmyXVyKHmWfEqtyiIfDq06tgcF9cDN1qUwm6ieCSaRAPHUSa91foWs
         OwcQ9LYFTSW7w4mR95G0e9T0yfct8u5ftzMUqU052iuWdbEWfyiAqZZjnYackCKofLwC
         eAJUJdbaPW+dfWEYRqqubwDzywSmOj9oNJoZ0TpLXbdENt9FgO5fZndneewqgx12s9pb
         PJuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:mime-version:references:in-reply-to:date
         :message-id:subject:to:cc;
        bh=ej5mFASv08lfE5fjlj5txVq02+/3jgEyMXF5gVS0gUI=;
        b=JwHf+LTgRmOmKRmWqZHBp6jtftySUsGKAE171Cf6T86smPjv2WpZr9bHCZYjLQAtfo
         41hmh0qAmh7/Q+CMa4ziFOCbGuEwDtsBpHAe3pYDYq2qPE7LxIZPymv7iuNOfvMmSvjy
         S8H2aLP8NTHkaxOgS5jyAmk787t/UkqeQCOusIB9McxlXW0RNOjWmAIDI7E9+EvhPW+W
         yznWEZ+nfTFw+Zv6FIOX1LtCUPKzSE19IUUTPijBEnlEJXDLcL3MYgBHEitam0F7MnuV
         V2zq+BoY1GTVJIOzbNcbodgmzX/odTVNK9cB/GFjY7Xh7u7IpJ1jubb0OXwsAEjBX5fM
         swNg==
X-Gm-Message-State: AA+aEWaPgydOW9U7hRKhpyU8bFhdKPzKBb0SAwCqrbYS8DgbAhNMufCH
        vf09GKWSxGxfRSs8yJDu0qNVcXfNoKEoMA==
X-Google-Smtp-Source: AFSGD/V2xDemJRj09LfxpIfpNylFgjcNgJgT8d/SUxYl8De94lLVPBvAMkuv3MG51Bzgftlwzbynpw==
X-Received: by 2002:a9d:177:: with SMTP id 110mr10638207otu.26.1543182327354;
        Sun, 25 Nov 2018 13:45:27 -0800 (PST)
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com. [209.85.167.177])
        by smtp.gmail.com with ESMTPSA id q25sm21181703otg.70.2018.11.25.13.45.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Nov 2018 13:45:27 -0800 (PST)
From:   Otavio Salvador <otavio.salvador@ossystems.com.br>
X-Google-Original-From: Otavio Salvador <otavio@ossystems.com.br>
Received: by mail-oi1-f177.google.com with SMTP id w13so14057834oiw.9
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 13:45:26 -0800 (PST)
X-Received: by 2002:aca:32c6:: with SMTP id y189-v6mr12572937oiy.153.1543182325229;
 Sun, 25 Nov 2018 13:45:25 -0800 (PST)
MIME-Version: 1.0
References: <20181125212159.11590-1-otavio@ossystems.com.br> <CAK8P3a2FXsz4-fBvUuQ6J5ERDkK6QsBoKvLLsDsczZqCOrq3Kw@mail.gmail.com>
In-Reply-To: <CAK8P3a2FXsz4-fBvUuQ6J5ERDkK6QsBoKvLLsDsczZqCOrq3Kw@mail.gmail.com>
Date:   Sun, 25 Nov 2018 19:45:12 -0200
X-Gmail-Original-Message-ID: <CAP9ODKqDySwsJ+3hJFXYfm8NyhsVGDwyRi+3sUUJiP304SU07g@mail.gmail.com>
Message-ID: <CAP9ODKqDySwsJ+3hJFXYfm8NyhsVGDwyRi+3sUUJiP304SU07g@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] ARM: imx_v6_v7_defconfig: Remove explicit
 ARM_UNWIND disable
To:     arnd@arndb.de
Cc:     Otavio Salvador <otavio@ossystems.com.br>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 25, 2018 at 7:35 PM Arnd Bergmann <arnd@arndb.de> wrote:
> On Sun, Nov 25, 2018 at 10:24 PM Otavio Salvador
> <otavio@ossystems.com.br> wrote:
> >
> > CONFIG_ARM_UNWIND is removed when running 'savedefconfig', but
> > selected by the Kconfig logic.  This is done in preparation to making
> > further changes to this defconfig cleaner.
> >
>
> Does this mean we no longer get the unwinder, or there is some other
> config (which?) that unconditionally selects it?

It is selected. Before changing the defconfig I did a savedefconfig to
avoid unrelated changes to be included on the subsequent patches and
then I found it was now selected.

-- 
Otavio Salvador                             O.S. Systems
http://www.ossystems.com.br        http://code.ossystems.com.br
Mobile: +55 (53) 9 9981-7854          Mobile: +1 (347) 903-9750
