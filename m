Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B29EDC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 22:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E53A2084F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 22:03:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E53A2084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388155AbeKFHZO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 02:25:14 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33533 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387441AbeKFHZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 02:25:14 -0500
Received: by mail-ot1-f68.google.com with SMTP id q1so9602137otk.0;
        Mon, 05 Nov 2018 14:03:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=W5jYvTO3HGNDVrTqUtFhpYyIdeUPYSvIAUgFmRyERN4=;
        b=S0pRHgvlhH5nTRgeGkC5ZPay6fNrA7wGyJ6WXfdMx1j6TflTJypwD9e7AlmDLqEN1Z
         YXYe3iqAVDM2BYOZZHV0ju+gZbcXmNVg9ot0WNRMfsDa2UvxXrZlbVrloMg4TiLO5oQ+
         OCgQAEzuFSOqhXfnZbXzPFOiBX+kEBNQ2xUOd667hnfkkMSla7tOl9Tq/0P1TQ6mMB0d
         qoZTdeY3Md/Dbe+Qa1fs/K4RE2egnqwNQjA15/eNEB81QZYt+BvT8qf01pXpHaCq+Tu3
         4BP9CUAR8iYN+YyqhkP+4/9Uf9BMqH2qYL10emJajT3QMui+QcoTwy5c5hT4BXlfJymy
         ZFNw==
X-Gm-Message-State: AGRZ1gKcRyXV7vvA7dPuro9qxFO4kx0dT9Kl+xRvmxds4rlwIAAk/nou
        JSJ68hJEOrqiGNfroWFmKA==
X-Google-Smtp-Source: AJdET5fn4xMVFU2tVsKohaOAedKOjGw6RWvtlXE+uFxfP2MrdCfNK6KTsYookAsdrS40cxDicNjowA==
X-Received: by 2002:a9d:4333:: with SMTP id s48mr13929794ote.347.1541455404388;
        Mon, 05 Nov 2018 14:03:24 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u12sm14221973otf.61.2018.11.05.14.03.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 14:03:23 -0800 (PST)
Date:   Mon, 5 Nov 2018 16:03:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stefan Mavrodiev <stefan@olimex.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/1] drm/panel: Add support for Olimex LCD-OLinuXino
 panel
Message-ID: <20181105220322.GA10583@bogus>
References: <1531383729-13932-1-git-send-email-stefan@olimex.com>
 <20180716150836.GA16895@rob-hp-laptop>
 <e677488e-34e0-512c-db13-15ccf78c5ea0@olimex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e677488e-34e0-512c-db13-15ccf78c5ea0@olimex.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 01, 2018 at 04:34:42PM +0200, Stefan Mavrodiev wrote:
> On 7/16/18 6:08 PM, Rob Herring wrote:
> > On Thu, Jul 12, 2018 at 11:21:53AM +0300, Stefan Mavrodiev wrote:
> > > This patch adds Olimex Ltd. LCD-OLinuXino bridge panel driver. The
> > > panel is used with different LCDs (currently from 480x272 to 1280x800).
> > > Small EEPROM chip is used for identification, which holds some
> > > factory data and timing requirements.
> > > 
> > > Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>
> > > ---
> > > Changes for v3:
> > >    - Change module license from "GPL v2" to "GPL"
> > >    - Make use of backlight_enable()/backlight_disable() helpers
> > >    - Rework backlight device request
> > >    - Remove drm_panel_detach()
> > >    - Use module_i2c_driver() for initialization
> > >    - Make the first mode preferred
> > >    - If num_modes value is invalid, overwrite it with 4, which is the maximum
> > >    - Some variable types optimizations
> > > 
> > > Changes for v2:
> > >    - Changed lcd_olinuxino_funcs to static const
> > > 
> > >   .../display/panel/olimex,lcd-olinuxino.txt         |  42 +++
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > 
> > >   MAINTAINERS                                        |   6 +
> > >   drivers/gpu/drm/panel/Kconfig                      |  10 +
> > >   drivers/gpu/drm/panel/Makefile                     |   1 +
> > >   drivers/gpu/drm/panel/panel-olimex-lcd-olinuxino.c | 331 +++++++++++++++++++++
> > >   5 files changed, 390 insertions(+)
> > >   create mode 100644 Documentation/devicetree/bindings/display/panel/olimex,lcd-olinuxino.txt
> > >   create mode 100644 drivers/gpu/drm/panel/panel-olimex-lcd-olinuxino.c
> 
> I would like to ask if there will be any progress on this patch?

Thierry needs to pick this one up. At this point you need to re-send. No 
one is going to look at patches 4 months old.

Rob
