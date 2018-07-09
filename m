Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C80AC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5394020857
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:22:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFnmUN/W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5394020857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932634AbeGIJWg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 05:22:36 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:44907 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932241AbeGIJWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 05:22:34 -0400
Received: by mail-lf0-f67.google.com with SMTP id g6-v6so3942595lfb.11;
        Mon, 09 Jul 2018 02:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=IZDErLcIa56acnGokT+vwYyZ2fZu/MwZIhcghR9qyjw=;
        b=PFnmUN/WxKpW4e4KIniSwkb/Ei3n1mbFECrcEPXqaWSTAbrjwf9PD+SYTSC5XJ1aN6
         dt5LJehmZpYJSBraB30meJp+He6mvQCJvdShnUnREhf/kayEETUQxpEsKCXCxQc163hI
         4AJqGsRGx7hc7xYnIM36AsJbLDRZvjkWS/IOQIibCMDnDyjV7fUJEQGn6ujRylDVKtEq
         nhoYvgg/PaeKNnzT2bI13PBm5lMQwsVIElboHgThyRrHL1E5lCV6lq/PB3Uy4KLTpcGW
         Mx4UJFsM2gMZCGZGWJczdurVxpvRYd+5rRHwfnMtqoFOzR24pEI0z3EVpAwW9mBy8QAN
         ws6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=IZDErLcIa56acnGokT+vwYyZ2fZu/MwZIhcghR9qyjw=;
        b=cw05vcnWhJlnzN0AwsN0tLQw73Wh0+/wERHoxMLUbG+bDgLM48QBUZKbA59ps95BXe
         ntluCzeC0rQRTSITqkP1MgmeFhAhzD0FsgbnzygkZp6Z5FfpjrG8SSWKqZLjCCGhSvJe
         yzMNcb3zpQncX8vC1KRq1lvwr7rVpt56kste5l0L9eaDzkX0IErvrx7+ytaRR2MvGlL1
         3itkOgmYS/MywONx9EERb8AJZ0KKxIatt8gjYdkMBuGVXojL49jA4VWZBeCQpmFk0+Sy
         xD1R4CbhSMAh3yBeOJ9qRpo2Xjn1koGQiRVuaTXjE5+44+BpNOBty9UTbELMht+goY74
         h/mA==
X-Gm-Message-State: APt69E34QXYldrTQF2/t0vvodOwr4nn1Dy9LJ0wdr79Q0sS8eST7yEg4
        CoNpjStAl9oAv7o2+H31PTZGX9WX
X-Google-Smtp-Source: AAOMgpegB/54M0GA7HbdlTSwErmhNwQI1WdD42MGVCyZigvejjwqCQTopKFfqWd6WLGeoStPtrSzuA==
X-Received: by 2002:a19:d313:: with SMTP id k19-v6mr13190873lfg.29.1531128153351;
        Mon, 09 Jul 2018 02:22:33 -0700 (PDT)
Received: from localhost (87-57-30-174-static.dk.customer.tdc.net. [87.57.30.174])
        by smtp.gmail.com with ESMTPSA id q65-v6sm1447807lfb.80.2018.07.09.02.22.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 02:22:32 -0700 (PDT)
From:   Esben Haabendal <esben.haabendal@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-i2c@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Phil Reid <preid@electromag.com.au>,
        Linus Walleij <linus.walleij@linaro.org>,
        Clemens Gruber <clemens.gruber@pqgruber.com>,
        Wei Jinhua <wei.jinhua1@zte.com.cn>,
        Michail Georgios Etairidis <m.etairidis@beck-ipc.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] i2c: imx: Fix race condition in dma read
References: <20180523095623.3347-1-esben.haabendal@gmail.com>
        <20180523095623.3347-3-esben.haabendal@gmail.com>
        <20180705063229.sr6jplg63ybyzxta@pengutronix.de>
Date:   Mon, 09 Jul 2018 11:22:31 +0200
In-Reply-To: <20180705063229.sr6jplg63ybyzxta@pengutronix.de> ("Uwe
        =?utf-8?Q?Kleine-K=C3=B6nig=22's?= message of "Thu, 5 Jul 2018 08:32:29
 +0200")
Message-ID: <87tvp8ahm0.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> writes:

> On Wed, May 23, 2018 at 11:56:21AM +0200, Esben Haabendal wrote:
>> From: Esben Haabendal <eha@deif.com>
>>=20
>> This fixes a race condition, where the DMAEN bit ends up being set after
>> I2C slave has transmitted a byte following the dummy read.  When that
>> happens, an interrupt is generated instead, and no DMA request is genera=
ted
>> to kickstart the DMA read, and a timeout happens after DMA_TIMEOUT (1 se=
c).
>>=20
>> Fixed by setting the DMAEN bit before the dummy read.
>
> Does this fix the problem or just narrow the race window?

It should fix the problem.

/Esben
