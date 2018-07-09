Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 069DAC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF7292087F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:20:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gK51t1gZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF7292087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932482AbeGIJUW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 05:20:22 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39208 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754077AbeGIJUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 05:20:19 -0400
Received: by mail-lj1-f195.google.com with SMTP id t7-v6so13543736ljj.6;
        Mon, 09 Jul 2018 02:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=FvgoinTNFsBCuZcGevw26tNJMVBlXqaXCCdgLC1oJwg=;
        b=gK51t1gZIJrlJe5GsoBtVzoz15ckwrQ6h8JwcoavZYQdR01qPDTVDQiG9H1qJUTX/s
         yfqN3UXsnSW2TUdUU6uLv01/0mfx8EcDFxRN2OXhaXWGhfryjAb/+jVwdWUxOnJ3RYCT
         nAaVPccORRiYCK5EXzPv0oNUJ0D09i3+zosVXBXGa1b6yZ5yfkJWiU+j8bv6yV1zOryM
         eSEq2Vn2qj+KMRke/DDr1tkkSaccDeQp0QMaAf0TSZtTiCZAjZUIyJCDwU4K4YiZT6hy
         VtM1UxGhkq6EgSu4lOk/rM/6NSD1rDM59rI6H+0pdfcrjGHQXpVRa28HlsYY0LR0xGG3
         LkvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=FvgoinTNFsBCuZcGevw26tNJMVBlXqaXCCdgLC1oJwg=;
        b=G2IILus23+t9u+TrnqkcBpqzdU+2lDqDGb/1kszJ4NzKNi/cs6S1GuGdfdavQ07hxw
         4u0uYGRJ/GvI4Jh4lP6l68BF3c4s7FZDUBYY6aw4N7EIf7JM7IahENohMwvVUBj3YtZf
         QEuBu9HWL9GFeQdQf9B73a2f+0kaoZQwlhNMYcNVl5ojK19IidmVOwrWwfSjvVyvM5ud
         CqT5WNMMVsRz453zfjS9UpkkDPMdjwlDEou/h8MhN3Q7MOR9C5JuwDDXE2HX049wQFly
         LHG0/lfNsjpk7Qmjd+JxAgyK8aLPxCXqCNr9u6evMxuRuxdqv4uYYBv4Tn5+KKPNEGHE
         5hPw==
X-Gm-Message-State: APt69E0hjG2hQVGkgSC/1EqfLwTI4Qsoqfchj2jigZIn26w5D2mfaqMp
        AhFxszniJAlH25y/uNHodlE=
X-Google-Smtp-Source: AAOMgpd8CDGm5VsG69QmYPrmhERnsU7x/xKPmuccl63IwFzSQG5rv1nklBZVblxxt5oSLGGblYSK/A==
X-Received: by 2002:a2e:9bc9:: with SMTP id w9-v6mr11500432ljj.33.1531128018231;
        Mon, 09 Jul 2018 02:20:18 -0700 (PDT)
Received: from localhost (87-57-30-174-static.dk.customer.tdc.net. [87.57.30.174])
        by smtp.gmail.com with ESMTPSA id f2-v6sm3957235lfb.11.2018.07.09.02.20.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 02:20:17 -0700 (PDT)
From:   Esben Haabendal <esben.haabendal@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-i2c@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Phil Reid <preid@electromag.com.au>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Clemens Gruber <clemens.gruber@pqgruber.com>,
        Michail Georgios Etairidis <m.etairidis@beck-ipc.com>,
        linux-kernel@vger.kernel.org, Yuan Yao <yao.yuan@freescale.com>,
        linux-imx@nxp.com
Subject: Re: [PATCH 1/4] i2c: imx: Fix reinit_completion() use
References: <20180523095623.3347-1-esben.haabendal@gmail.com>
        <20180523095623.3347-2-esben.haabendal@gmail.com>
        <20180704070342.pgnjjffk34nkloob@pengutronix.de>
Date:   Mon, 09 Jul 2018 11:20:16 +0200
In-Reply-To: <20180704070342.pgnjjffk34nkloob@pengutronix.de> ("Uwe
        =?utf-8?Q?Kleine-K=C3=B6nig=22's?= message of "Wed, 4 Jul 2018 09:03:42
 +0200")
Message-ID: <87y3ekahpr.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> writes:

> Cc +=3D Yuan Yao who authored DMA support and the NXP team.
>
> On Wed, May 23, 2018 at 11:56:20AM +0200, Esben Haabendal wrote:
>> From: Esben Haabendal <eha@deif.com>
>>=20
>> Make sure to call reinit_completion() before dma is started to avoid race
>> condition where reinit_compleition() is called after complete() and befo=
re
>
> s/compleition/completion/

Will fix in v2.

>
>> wait_for_completion_timeout().
>
> Is this a theoretical problem, or did it trigger on your side?

I thought I did trigger it, but haven't been able to reproduce.
So it might or might not be theoretical based on my experiences, but it
does look like something that can (and thus should) trigger sometimes.

/Esben
