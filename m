Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9718EC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 15:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 590AC2251B
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 15:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rmc4CR0W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 590AC2251B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387718AbeKNBNV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 20:13:21 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39604 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730765AbeKNBNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 20:13:21 -0500
Received: by mail-pg1-f194.google.com with SMTP id r9-v6so5831453pgv.6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 07:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7mH2/bzyp4LzcAQRJ/7CWnTLaxqqyARWcWlUAmvw2/s=;
        b=rmc4CR0WKpdyhgsp4Ff5Ad9gLiiCLc6xtzN4e7D/Ag9UVrwfXoFYXk02WOHRlEIhKO
         evYeql3KQZYHZf1HiwHpUYQ/IrjDU7sX/Wq1Hb3bx4Eu87l3F2XS/5HckIaGmfWVXs3F
         RAxwRqgTZR0KzW/sMyL8P3s3wes8+LILXX8c1SR3HrQ6lq9NfivxeQAuGTf4k781V5O/
         Z+l2ei4yzMd3rnOptQIFabuHxTNaU8/hIR80Kuy0703p/qjhee2/4CBGunRdtmm2YFk2
         Il+VJ+qRUfVL6ZEvp5DPZDxhrPbF/IIQenoQEFmgDRTt39kNupU8mC5CUX+yAHOe5OOO
         OBfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7mH2/bzyp4LzcAQRJ/7CWnTLaxqqyARWcWlUAmvw2/s=;
        b=RXWEQHZCYJJr6lR/B9Bd49m/mBR8Tfv/XCuwbHb2hTQcAAs9/GrgD3SgjzqN0sXdoW
         dN5RaBj4bpLoRzQAbi9+Z1stskMRKRiFsGl+qaXhBtJiqVwWLW/T5f+V8cZTVXY03G0O
         vDuokaXMbxliLf3yiZ928TiNaJL9MQcGA6M0Fo/NgQ4VzW3Odp3eTi8YXgt26U50mmqX
         yltos6lI/OYlLklgZjl+IEE+0XvdEW20BzUN0p/fqo9m8rpOMz3vFUCbw42Qm+T2noqu
         aEOgjFIT1mTHG6JSwWexhRxiYo9SUrl46eE7geQMYVasbQU0/fg2TR9lCW4hTKn4rmbI
         4GGQ==
X-Gm-Message-State: AGRZ1gK0aiV2lrpdMtWbGG3H4GY7tBW84/0OsYuriIWW5oqOiad84zzG
        pPNG8PfFwR21w3kIX3ZzIkf/ppTk
X-Google-Smtp-Source: AJdET5dsj2PrcE5ReBi/9RymYeK8UY/Up9llYZMioNG0sSBRKRra7xPNuZkfyZf9yGUpAlbIIA+pxw==
X-Received: by 2002:a63:f201:: with SMTP id v1mr4796034pgh.232.1542122086776;
        Tue, 13 Nov 2018 07:14:46 -0800 (PST)
Received: from localhost (c-24-4-232-171.hsd1.ca.comcast.net. [24.4.232.171])
        by smtp.gmail.com with ESMTPSA id i13-v6sm18153994pgs.51.2018.11.13.07.14.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Nov 2018 07:14:46 -0800 (PST)
Date:   Tue, 13 Nov 2018 07:14:44 -0800
From:   Richard Cochran <richardcochran@gmail.com>
To:     Tom Burkart <tom@aussec.com>
Cc:     Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 2/4] pps: descriptor-based gpio, capture-clear addition
Message-ID: <20181113151444.cszd2zdwoast3545@localhost>
References: <20181113034007.3878-1-tom@aussec.com>
 <20181113034007.3878-2-tom@aussec.com>
 <20181113034007.3878-3-tom@aussec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181113034007.3878-3-tom@aussec.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 02:40:05PM +1100, Tom Burkart wrote:
> The change from integer based GPIO API to the descriptor based API
> breaks backward compatibility for the devicetree.  This is due to
> the descriptor based API appending "-gpio" or "-gpios" (see
> Documentation/gpio/base.txt.)

Device tree is a user space facing ABI, and so you must continue to
support the legacy binding as well.

Thanks,
Richard
