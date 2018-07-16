Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C84ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 15:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3FC820852
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 15:08:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3FC820852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729881AbeGPPga (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 11:36:30 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:44988 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727342AbeGPPg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 11:36:29 -0400
Received: by mail-oi0-f67.google.com with SMTP id s198-v6so75415128oih.11;
        Mon, 16 Jul 2018 08:08:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NF3cd+LsqnY4FZ75lnd/qC4JwDh3GKYUPWZD79BWrwE=;
        b=AAQM0Ds3R2h8MAQslfZzmYm7dqhHXjGK5ORi7PAfugWjTO/s7Ztj6IPZ2dRWi0k/Pw
         1YxtMBrwQVeF70tYfYX8rWDCOQ60hMOgqw9acfPwyGJq5FlQcizyEXliHN50Qn9S5d2V
         XbPC3tuUf3sbz6cs/ZBwcDfa6x4GE3SYYPn4WYFSQdbKtUImy9O9bVoWcfLW/gTNVuc6
         88tN8IwhoWrDZEgDxLyU7gta0ooKHHv7o1+OUDNNbSKGzi+jb5+Uex6/EEug3q7QH6nV
         5zz8YxZiSQe025ihXra/CpsDg6qahQjh5Az44NKwD53sr2aummG19MwgA8xT9n1DC2Dr
         lpEQ==
X-Gm-Message-State: AOUpUlHhz2mc25utAq75tSmvKWtcwGpf8lCdHuOYwBKvJOBEF+V+AUYY
        FWsfMxA0mBJKrn02XTmd/g==
X-Google-Smtp-Source: AAOMgpcYoHsyl6DDOR4s1eHMMmvRW0FbuUA0ylpACPD0AvvTzJMmQ8t77wcltggQNAMTp7zveHM9mA==
X-Received: by 2002:aca:f0d4:: with SMTP id o203-v6mr19190845oih.21.1531753718811;
        Mon, 16 Jul 2018 08:08:38 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id a14-v6sm36329589oih.54.2018.07.16.08.08.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 08:08:37 -0700 (PDT)
Date:   Mon, 16 Jul 2018 09:08:36 -0600
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
Message-ID: <20180716150836.GA16895@rob-hp-laptop>
References: <1531383729-13932-1-git-send-email-stefan@olimex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531383729-13932-1-git-send-email-stefan@olimex.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 11:21:53AM +0300, Stefan Mavrodiev wrote:
> This patch adds Olimex Ltd. LCD-OLinuXino bridge panel driver. The
> panel is used with different LCDs (currently from 480x272 to 1280x800).
> Small EEPROM chip is used for identification, which holds some
> factory data and timing requirements.
> 
> Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>
> ---
> Changes for v3:
>   - Change module license from "GPL v2" to "GPL"
>   - Make use of backlight_enable()/backlight_disable() helpers
>   - Rework backlight device request
>   - Remove drm_panel_detach()
>   - Use module_i2c_driver() for initialization
>   - Make the first mode preferred
>   - If num_modes value is invalid, overwrite it with 4, which is the maximum
>   - Some variable types optimizations
> 
> Changes for v2:
>   - Changed lcd_olinuxino_funcs to static const
> 
>  .../display/panel/olimex,lcd-olinuxino.txt         |  42 +++

Reviewed-by: Rob Herring <robh@kernel.org>

>  MAINTAINERS                                        |   6 +
>  drivers/gpu/drm/panel/Kconfig                      |  10 +
>  drivers/gpu/drm/panel/Makefile                     |   1 +
>  drivers/gpu/drm/panel/panel-olimex-lcd-olinuxino.c | 331 +++++++++++++++++++++
>  5 files changed, 390 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/olimex,lcd-olinuxino.txt
>  create mode 100644 drivers/gpu/drm/panel/panel-olimex-lcd-olinuxino.c
