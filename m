Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C15C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 15:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCC922083A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 15:40:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCC922083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754186AbeFTPkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 11:40:14 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:33567 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751337AbeFTPkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 11:40:12 -0400
Received: by mail-yw0-f196.google.com with SMTP id u124-v6so6452ywg.0;
        Wed, 20 Jun 2018 08:40:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3m2BzdhPP/rUceUdI1BObl4RaAjkhjUSZZXY8PfpfrM=;
        b=og8W/q02IZUwSdAZ86yGzYyXrCdBlQyl3ErKV0Hc/xBL9aqQuGYYqrmzWUHio1Uljz
         /Iw6jCS2AUPKoXB/4esnWlTW8UNZrrGddmYKsnDQjpjT+ne3ZxdOtA9KyGbA+RH11OsF
         PTwroVK+uqD8xMF2f8WqIDPnRabG3FSeiHm/GaK/yBMP358XTHRAHp2thSaOY5M7qtp1
         NctYArmiduICreBB+LVmc0ATwEJCdb8bwb0gsK7MYrMBDuViEPa/P90lcZ5rhvZ0aqlk
         KY6oHB/Qks7lgBWKOS9HBaE0njAa3eAm+/bsD2xzKcsQ0+lgWly7YuDpBoyWgrvDEMf9
         pI+A==
X-Gm-Message-State: APt69E0gwtzyIUAsZBcoOZWmpEhC7wJfH9t2jEKtNk9rh35Cy6x2O9Pd
        QIrU9DMs69IWISIUaUKwig==
X-Google-Smtp-Source: ADUXVKL/AvBHiSvZm2KTTbrr9HIvvalxyw5L9KRCrgM15vFlYLZ+M4N/b8t/mFL+lQfGKbU4u059Ag==
X-Received: by 2002:a0d:c543:: with SMTP id h64-v6mr10407503ywd.464.1529509211703;
        Wed, 20 Jun 2018 08:40:11 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id m206-v6sm938900ywb.97.2018.06.20.08.40.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 08:40:10 -0700 (PDT)
Date:   Wed, 20 Jun 2018 09:40:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Marco Franchi <marco.franchi@nxp.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tom Saeger <tom.saeger@oracle.com>,
        Smitha T Murthy <smitha.t@samsung.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "David S . Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>,
        Jacob Chen <jacob-chen@iotwrt.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Todor Tomov <todor.tomov@linaro.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-sunxi@googlegroups.com,
        Hugues Fruchet <hugues.fruchet@st.com>,
        Randy Li <ayaka@soulik.info>
Subject: Re: [PATCH v4 15/19] dt-bindings: media: Document bindings for the
 Sunxi-Cedrus VPU driver
Message-ID: <20180620154009.GA26099@rob-hp-laptop>
References: <20180618145843.14631-1-paul.kocialkowski@bootlin.com>
 <20180618145843.14631-16-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180618145843.14631-16-paul.kocialkowski@bootlin.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 04:58:39PM +0200, Paul Kocialkowski wrote:
> This adds a device-tree binding document that specifies the properties
> used by the Sunxi-Cedurs VPU driver, as well as examples.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> 
>  create mode 100644 Documentation/devicetree/bindings/media/sunxi-cedrus.txt

You are missing a '---' line so this is going to end up in the commit 
msg.

Please add acked/reviewed bys when posting new versions.

Rob
