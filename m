Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E24C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 08:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30263218F0
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 08:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SPySeJaB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388337AbeLUItM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 03:49:12 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38031 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731899AbeLUItL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 03:49:11 -0500
Received: by mail-pf1-f194.google.com with SMTP id q1so2285895pfi.5;
        Fri, 21 Dec 2018 00:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tgk0uUFE4UXZNx+cS+QFpSpxba+8upMcbAG8VA+mkRg=;
        b=SPySeJaBON/77x+9ZjatJKbEzNqEdumQBRyoDHAAwwlRc9UD+KkorUhnc5L9aSZF9Y
         t0OuK2UAUmcJT9WK+eqUx1ds2NJBUrJ0HnrQEf9+bGlIgnF7GYJ1BCuO/Z3eT3tK28Ib
         esgsjv+hapk54IcUdnKbgiaxj35RAsiLzA6QgpNjfcLLtPH+VUHeGtqx7j8M0N+7Eitf
         jQDgfQ1kHYk25hQRwUWHfGvEDMYrYSJfT2Vc5h2XnIUFAXD6BhE5gER+wGPQtkqXWiKl
         hDefwA5OrYPxN4lTRP5A9xR9MrZh/tgwN4fD2Bqp1MEq/RtydGYghJlgUlJsw8eGdBBv
         4Clw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tgk0uUFE4UXZNx+cS+QFpSpxba+8upMcbAG8VA+mkRg=;
        b=EIZT7rqJHe2tRg6GyU50Zl6wE1QqXWP/TfiQGYVtgTK5xEGJOF3FnRZOJureDM4JX7
         U5dpK7ukR/vyFUuuleNcpFu0gsRCUem5f//sCm4iXAC/QwSmvlsBzt2xGsVhJIGJZDdl
         gx/9GyagR8jZemk+9clrCkDHW3Q2goms34TROUTHPZ/ElwWJ9qcvbxb7cIbKVse+khQ8
         pyRRaZ6GicKEwQaRcb6f3YFpnrl/VfxDG1Fa1SeZSDZS+bJNOH5r9mgL+yFcq8A23xAw
         4L2fevPd7u8xI7pY57+QqY5kCdyaUvl5CI3/qLgPJ1RIWxS3EqHoWZ0vGypXXp8easqZ
         7uzw==
X-Gm-Message-State: AJcUukfQFIhU8qiw3nY3Nin0xPXMOKJ/Uo40thsPi84+/JS1sfSmbzcQ
        M6T1WafN0dCjsjm1Vm0Fz5E=
X-Google-Smtp-Source: ALg8bN6DA+KvTjjtWoonqKANwZSI75zFXxQfAWNW+Lt7H7trqdHYfKDm3UP3AELJeUWvpxGydufO4w==
X-Received: by 2002:a63:2744:: with SMTP id n65mr1523110pgn.65.1545382149609;
        Fri, 21 Dec 2018 00:49:09 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id p77sm49865641pfi.85.2018.12.21.00.49.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Dec 2018 00:49:08 -0800 (PST)
Date:   Fri, 21 Dec 2018 00:49:06 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Eric Anholt <eric@anholt.net>,
        Henrik Rydberg <rydberg@bitmath.org>,
        linux-rpi-kernel@lists.infradead.org, stefan.wahren@i2se.com,
        agraf@suse.de, afaerber@suse.com,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Mark Jonas <mark.jonas@de.bosch.com>,
        Masanari Iida <standby24x7@gmail.com>,
        Heiko Schocher <hs@denx.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Zhu Yi <yi.zhu5@cn.bosch.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH v2 2/2] input: add official Raspberry Pi's touchscreen
 driver
Message-ID: <20181221084906.GJ211587@dtor-ws>
References: <20181211112408.9524-1-nsaenzjulienne@suse.de>
 <20181211112408.9524-3-nsaenzjulienne@suse.de>
 <87r2ecdovo.fsf@anholt.net>
 <2c433e120c2cf375b7d431f79ce6bfbace803c7e.camel@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c433e120c2cf375b7d431f79ce6bfbace803c7e.camel@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 08:12:23PM +0100, Nicolas Saenz Julienne wrote:
> On Thu, 2018-12-20 at 10:39 -0800, Eric Anholt wrote:
> > Nicolas Saenz Julienne <nsaenzjulienne@suse.de> writes:
> > 
> > > Add's support to Raspberry Pi's 7" Touch device. Instead of using a
> > > conventional bus all information is copied into a memory mapped
> > > area by
> > > RPi's firmware.
> > > 
> > > Based on the driver found in RPi's kernel repository.
> > > 
> > > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > 
> > While I wish we could just have a native driver instead, it does make
> > sense to have this driver upstream given the constraints.
> > 
> > Acked-by: Eric Anholt <eric@anholt.net>
> 
> Thanks Eric.
> 
> FYI I did manage to access the touchscreen after altering the native
> driver (edt-ft5x06). That said, as commented in the cover letter, it's
> not good enough as it breaks the camera. I plan on posting the patch
> and an overlay. I'm just waiting to see how these first patches are
> received.

Applied, thank you.

-- 
Dmitry
