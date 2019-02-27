Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A5DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 20:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2BBB20818
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 20:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PfNeTMDq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730307AbfB0Uf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 15:35:58 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41032 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727488AbfB0Uf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 15:35:57 -0500
Received: by mail-pg1-f195.google.com with SMTP id m1so8504812pgq.8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 12:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GNwThvtjzGpzi0d/OiEgtviNMmvlYQ4OUgMES2ZulRY=;
        b=PfNeTMDqAOGPJMr+73KPK2ePi0n90oWAeLegQjTvCoRQdh1lkmO/apbcThS5wK72v0
         KxJWWFmXUcJEMydS6amkjvWwwNoHh/1pTZDa5qk9CcmuLDWTjmk6hICl97x8L2Cuba4Q
         UU96qkk+T3wvnxGhOBJrg0VpJkj5VSSyX5F94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GNwThvtjzGpzi0d/OiEgtviNMmvlYQ4OUgMES2ZulRY=;
        b=KH7ffDH9m/4CVS9gxKyPbig3sSLFcndMeBOTvFabGVxVA9AKOufSj/JRHs3PCIpwkv
         ihgGFtgCg3D9jr36EVmvd0d2fGFBRlFtWWwOH+NJEAKODI3iE2jfK5WiKk4pRi4rl5RC
         6IKRoqiVifK8KIOxONxdycfuHwKfb9uYjUPXJqb68pMkYMvd4zqLQP8yHQyn5LInovhH
         vnMbPZXICgER8FO/X4Y/rwrlt09G66LHKk49jopXU1Vq+qFMG6kY30bayhHmPjFPeI8P
         vSs8zNhZbTnO53g6t5O65qjluHfJA6LIuCnmBOMoh8vSWApqDhwIyi50UI9czVapsq2E
         N05Q==
X-Gm-Message-State: AHQUAuYzPkZ2Kg5DoLpUXm/GIehipx+dPUh7T308NWZV36cT1GeiOtdY
        waLYbv6aP4YYi20L/02py2+Cxw==
X-Google-Smtp-Source: AHgI3IYjOI5P9YUp6paCrXzbnJMcUQqt4eH1NHHkkVAA+kvlvmnxeDNZPQ8mDOLiSNpMYw2V3A2oRA==
X-Received: by 2002:a63:8b42:: with SMTP id j63mr4678231pge.79.1551299756740;
        Wed, 27 Feb 2019 12:35:56 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id a24sm21495528pfn.85.2019.02.27.12.35.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Feb 2019 12:35:56 -0800 (PST)
Date:   Wed, 27 Feb 2019 12:35:55 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Hemantg <hemantg@codeaurora.org>
Subject: Re: [PATCH 0/2] Reduce delay after sending baudrate request for
 WCN3990
Message-ID: <20190227203555.GA192510@google.com>
References: <20190226200848.154216-1-mka@chromium.org>
 <45D9EB4B-C81A-4970-9ED1-3737A0AF771F@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <45D9EB4B-C81A-4970-9ED1-3737A0AF771F@holtmann.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcel,

On Wed, Feb 27, 2019 at 08:48:31AM +0100, Marcel Holtmann wrote:
> Hi Matthias,
> 
> > The current 300ms delay after a baudrate change is extremely long.
> > For WCM3990 it is sufficient to wait 10ms after the baudrate change
> > request has been sent over the wire.
> > 
> > Also use msleep() instead of a set_current_state() / schedule_timeout()
> > combo.
> > 
> > Matthias Kaehlcke (2):
> >  hci_qca: Use msleep() instead of open coding it
> >  hci_qca: Reduce delay after sending baudrate request for WCN3990
> > 
> > drivers/bluetooth/hci_qca.c | 30 +++++++++++++++++++++---------
> > 1 file changed, 21 insertions(+), 9 deletions(-)
> 
> patch 1/2 has been applied to bluetooth-next tree.

Thanks!

> The patch 2/2 fails to apply.

Right, the series "Bluetooth: hci_qca: Add delay after power-off
pulse" that was just applied touches the same code. I'll send a
rebased version soon.

Cheers

Matthias
