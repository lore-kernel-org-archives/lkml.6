Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49FD7C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 09:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7A3A20E20
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 09:20:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bT2764uV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7A3A20E20
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbeHTMfj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 08:35:39 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40985 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbeHTMfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 08:35:39 -0400
Received: by mail-lf1-f66.google.com with SMTP id v22-v6so10366964lfe.8;
        Mon, 20 Aug 2018 02:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-transfer-encoding;
        bh=n74IuMkDSDZTyVw8b/r+ENWCGBPVgPV4omw9MsI7euk=;
        b=bT2764uV2UvzuZXvwpc8treXl3fhp5wB20f5x3mZnPh98OjVIJqOpu47RUI5M0/xad
         6kxhgB19bSf+F0WgvvrNlb6O/GbXnZdHYx8eQtuRbDEsq0a63Pq2js7VGAHr0GPoNRIQ
         jjcV6zroJtJy21D8aJTHeVKRvmS5R81LZO7GxdxJCWw374uvaDPw7vuwLeV50sXM+EHu
         U82UEXvTDL1NXyiNPlronYrV3oGqGNPcnzeKlytarOPSYW+K6gjcSSOkMv/JP59rYv6Q
         spqt6D6+n6455GtxRQmUKQWaL83VmNXxsZ8NrRuPhH42AANnnxGGMaLPqc9m3/kXP6NH
         l+Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :user-agent:date:message-id:mime-version:content-transfer-encoding;
        bh=n74IuMkDSDZTyVw8b/r+ENWCGBPVgPV4omw9MsI7euk=;
        b=g47UWIxQ97OE6jokfhVOTtMhw2z/ZWi69JT0ozOGJTvhLi+sSx7VzXOddof+D6KAcO
         4bCLdZ3ezvdUp4lKWb4qrn+RruZlrECI3VeDglxDVwxupNHkALiUH3CQLCKbCoKteOde
         AKEdUeDBwqePbkGC8V+9p7+9ceV7HHhDk/OLTdRNgIxu8k4Kwgv6B9WKUJg+atqdvgTZ
         GH1IhQlyy28tzBSc+E1hAy3cjRbK6FfCDM03iULnFYekniibaGAw288jgK+TL3vKoCgl
         +aeTT24iOxyc8lJ41tZrsCBE5/oA1XjiPIWI6ZKbBs7pVoWyq8gDoGIFfjl9gS3Nl2Q+
         1Wow==
X-Gm-Message-State: AOUpUlHAA3dx/NjPZn4rSHOyzhXNZ0AkV3JmrTwaBmpWBRHEN7KVVmTR
        C9/2JWlYmwEdAp/SU9/BTEo6IeZS
X-Google-Smtp-Source: AA+uWPxBxl2VAzQMFMdrgsgf8+0byeXlvwdBTZxUkiV4IGisP+BxZ2c/D/x66FLA4TDeWM4yJKxRGQ==
X-Received: by 2002:a19:ded7:: with SMTP id i84-v6mr13080634lfl.146.1534756846762;
        Mon, 20 Aug 2018 02:20:46 -0700 (PDT)
Received: from localhost ([87.54.42.112])
        by smtp.gmail.com with ESMTPSA id f9-v6sm1520382ljf.9.2018.08.20.02.20.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Aug 2018 02:20:46 -0700 (PDT)
From:   Esben Haabendal <esben.haabendal@gmail.com>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     linux-i2c@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Phil Reid <preid@electromag.com.au>,
        Peter Rosin <peda@axentia.se>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] i2c: imx: Simplify stopped state tracking
In-Reply-To: <20180820091413.ranx7smh3f3swvvc@ninjato> (Wolfram Sang's message
        of "Mon, 20 Aug 2018 11:14:13 +0200")
References: <20180816084315.7857-1-esben.haabendal@gmail.com>
        <20180816084315.7857-3-esben.haabendal@gmail.com>
        <20180820091413.ranx7smh3f3swvvc@ninjato>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
Date:   Mon, 20 Aug 2018 11:20:44 +0200
Message-ID: <874lfpiec3.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wolfram Sang <wsa@the-dreams.de> writes:

> On Thu, Aug 16, 2018 at 10:43:13AM +0200, Esben Haabendal wrote:
>> From: Esben Haabendal <eha@deif.com>
>>=20
>> Always update the stopped state when busy status have been checked.
>> This is identical to what was done before, with the exception of error
>> handling.
>> Without this change, some errors cause the stopped state to be left in
>> incorrect state in i2c_imx_stop(), i2c_imx_dma_read(), i2c_imx_read() and
>> i2c_imx_xfer().
>>=20
>> Signed-off-by: Esben Haabendal <eha@deif.com>
>> Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
>
> Applied to for-next, thanks! I did not add stable because the cover
> latter said minor issue? Not really sure here, though...

I agree, it does not need to go into stable.

/Esben
