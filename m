Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B7D5C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC50221A74
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:58:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d8SBxSRE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC50221A74
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753062AbeGDQ6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 12:58:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44334 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752568AbeGDQ6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 12:58:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2vY8i/yS9BOsqjBsCiMvKxaEhxrEC4hQXKhOtoZqM9w=; b=d8SBxSREJ2Q6xxNjwYMaaC4J3
        31q9P7sVlwOEKdJotG2LIq54Ab8YllZupirN4MDYUIAPr41uFS5y1ery2epYOY1X2l7lyivTe+8D0
        vQgN8M4uKEwY1qOrQ/p4JecDBb7LE5DNGrN/HZjwNKV/y2XzKfduzH44DTABHR6yfUGE7aBIKv4Xm
        6DJzg/UEVEJNr62d9RExb9lmvnHCdi049c5WJRV4TXseWYA8JOwlYGVNzvSLQHxhbM2x6bYdAvYLt
        rxz2kaW2S9PU6qNb8pQ0w/j0+FZ1WPgrlq0WuQRN7/cpm82HdhLC2+BhvJVZl9v0Q8eT7vrW8iqO5
        UE0/zrqQg==;
Received: from 179.176.112.175.dynamic.adsl.gvt.net.br ([179.176.112.175] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fal6X-00080M-JI; Wed, 04 Jul 2018 16:58:09 +0000
Date:   Wed, 4 Jul 2018 13:58:06 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Cc:     linux-media@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] media: dvb-frontends: add Socionext SC1501A ISDB-S/T
 demodulator driver
Message-ID: <20180704135657.3fd607cb@coco.lan>
In-Reply-To: <20180621031748.21703-1-suzuki.katsuhiro@socionext.com>
References: <20180621031748.21703-1-suzuki.katsuhiro@socionext.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Katsuhiro-san,

Em Thu, 21 Jun 2018 12:17:48 +0900
Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com> escreveu:

> This patch adds a frontend driver for the Socionext SC1501A series
> and Socionext MN88443x ISDB-S/T demodulators.

Sorry for taking so long to review it. We're missing a sub-maintainer
for DVB, with would otherwise speed up reviews of DVB patches.
> 
> The maximum and minimum frequency of Socionext SC1501A comes from
> ISDB-S and ISDB-T so frequency range is the following:
>   - ISDB-S (BS/CS110 IF frequency in kHz, Local freq 10.678GHz)
>     - Min: BS-1: 1032000 => 1032.23MHz
>     - Max: ND24: 2701000 => 2070.25MHz
>   - ISDB-T (in Hz)
>     - Min: ch13: 470000000 => 470.357857MHz
>     - Max: ch62: 770000000 => 769.927857MHz

There is actually an error on that part of the driver. Right now,
the DVB core expects Satellite frequencies (DVB-S, ISDB-S, ...)
in kHz. For all other delivery systems, it is in Hz.

It is this way due to historic reasons. While it won't be hard to
change the core, that would require to touch all Satellite drivers.

As there are very few frontend drivers that accept both Satellite
and Terrestrial standards, what we do, instead, is to setup
two frontends. See, for example, drivers/media/dvb-frontends/helene.c.

...
> +static const struct dvb_frontend_ops sc1501a_ops = {
> +	.delsys = { SYS_ISDBS, SYS_ISDBT },
> +	.info = {
> +		.name          = "Socionext SC1501A",
> +		.frequency_min = 1032000,
> +		.frequency_max = 770000000,
> +		.caps = FE_CAN_INVERSION_AUTO | FE_CAN_FEC_AUTO |
> +			FE_CAN_QAM_AUTO | FE_CAN_TRANSMISSION_MODE_AUTO |
> +			FE_CAN_GUARD_INTERVAL_AUTO | FE_CAN_HIERARCHY_AUTO,
> +	},
> +
> +	.sleep                   = sc1501a_sleep,
> +	.set_frontend            = sc1501a_set_frontend,
> +	.get_tune_settings       = sc1501a_get_tune_settings,
> +	.read_status             = sc1501a_read_status,
> +};

In other words, you'll need to declare two structs here, one for ISDB-T
and another one for ISDB-S.

Yeah, I know that this sucks. If you are in the mood of touching the
DVB core, I'm willing to consider a patch that would fix this, provided
that it won't break backward compatibility with other drivers (or would
convert the other satellite drivers to use the new way).

Thanks,
Mauro
