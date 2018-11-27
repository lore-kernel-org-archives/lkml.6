Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A867C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 18:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 624202082F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 18:04:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 624202082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732159AbeK1FCs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 00:02:48 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:37586 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732079AbeK1FCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 00:02:47 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id AA0E9809E9; Tue, 27 Nov 2018 19:04:00 +0100 (CET)
Date:   Tue, 27 Nov 2018 19:03:57 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     johan@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Subject: Re: [PATCH RFC 4/5] gnss: sirf: add a separate supply for a lna
Message-ID: <20181127180356.GA32751@localhost>
References: <20181118215801.12280-1-andreas@kemnade.info>
 <20181118215801.12280-5-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181118215801.12280-5-andreas@kemnade.info>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Devices might have a separate lna between antenna output of the gps
> chip and the antenna which might have a separate supply

Might have.

> @@ -340,6 +349,12 @@ static int sirf_probe(struct serdev_device *serdev)
>  		goto err_put_device;
>  	}
>  
> +	data->lna = devm_regulator_get(dev, "lna");
> +	if (IS_ERR(data->lna)) {
> +		ret = PTR_ERR(data->lna);
> +		goto err_put_device;
> +	}
> +

But it is not optional in the code. Probably should be?
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
