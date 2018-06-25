Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43E0C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 20:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 831C8260F9
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 20:41:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 831C8260F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965061AbeFYUlY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 16:41:24 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:42002 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751949AbeFYUlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 16:41:22 -0400
Received: by mail-yb0-f196.google.com with SMTP id i3-v6so2548903ybl.9;
        Mon, 25 Jun 2018 13:41:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HY1EPTyJKM10QpFVYVZN2tT7pF/d7ZvukkSWjhrI3lo=;
        b=iGHKE3vxDjU+f406n9+IJrjM13Xj99PJ5Lt1lQTbq3TGbbvdR6NHrII/NNNnZQduSc
         AUkEe6DwRlIyFmt0GzNTny44Fp0i8IKt1y+pCoUxYF3P0y5ETtuIxBh25irebgu09Plc
         cQIEsBq8wBwBOG3Amf7AD3lS7i3nVULYN1/6iicmV8d84paijwi1r5wJmv9ZQM9yr49E
         kee7yj8nMgOFbrxDWwWs/oorwCy0PP9p7rDCGeqL0a3xVTa4j6Xgq6p1izupiSqEhURS
         I26kTdZ1H6eyFYAyxoNMH96rdhHugG90kyRlqjhkduOgM02Fp+LZL8dCGU7w/lIHPJt+
         W4/Q==
X-Gm-Message-State: APt69E0MT0Gk1H81xiPYo5N5qscvJvCGkl4Ta9wqmm7IDCbC0x/pIC8E
        RcLFXz05cw8d68xyFW6pQA==
X-Google-Smtp-Source: ADUXVKINOEZbBc1YdABGRfu+oe/HYYifCRqxqtg6JcwyPzz0EpKb97SD1Vd3YMX/rZth1wjrdYGCuQ==
X-Received: by 2002:a25:afce:: with SMTP id d14-v6mr6650812ybj.343.1529959281612;
        Mon, 25 Jun 2018 13:41:21 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id v7-v6sm5310627ywv.91.2018.06.25.13.41.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 13:41:20 -0700 (PDT)
Date:   Mon, 25 Jun 2018 14:41:19 -0600
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
Subject: Re: [PATCH v2 1/1] drm/panel: Add support for Olimex LCD-OLinuXino
 panel
Message-ID: <20180625204119.GA10101@rob-hp-laptop>
References: <1529909093-17021-1-git-send-email-stefan@olimex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529909093-17021-1-git-send-email-stefan@olimex.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 09:44:35AM +0300, Stefan Mavrodiev wrote:
> This patch adds Olimex Ltd. LCD-OLinuXino bridge panel driver. The
> panel is used with different LCDs (currently from 480x272 to 1280x800).
> Small EEPROM chip is used for identification, which holds some
> factory data and timing requirements.
> 
> Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>
> ---
> Changes for v2:
>     - Changed lcd_olinuxino_funcs to static const
> 
>  .../display/panel/olimex,lcd-olinuxino.txt         |  42 +++

If there are further changes, please split to a separate patch. 
Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>

>  MAINTAINERS                                        |   6 +
>  drivers/gpu/drm/panel/Kconfig                      |  10 +
>  drivers/gpu/drm/panel/Makefile                     |   1 +
>  drivers/gpu/drm/panel/panel-olimex-lcd-olinuxino.c | 360 +++++++++++++++++++++
>  5 files changed, 419 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/olimex,lcd-olinuxino.txt
>  create mode 100644 drivers/gpu/drm/panel/panel-olimex-lcd-olinuxino.c
