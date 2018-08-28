Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5DD7C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9076220833
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRtvuYqV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9076220833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbeH1Sjc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 14:39:32 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42518 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727841AbeH1Sjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 14:39:32 -0400
Received: by mail-wr1-f65.google.com with SMTP id v17-v6so1846061wrr.9;
        Tue, 28 Aug 2018 07:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5w81+MBP6D/RxL1YeMAc+Drk+izWIG1pVhGppsdjGmc=;
        b=KRtvuYqVG4CYgM6G0bija3zDeI3YR4J0owqpytNPsT+q2DsbPREz+YtGaOu/IKdWcb
         BVRvKiiirJEd/ke/aTdoYWxghLthCGKHyTyBLHsgCmqAzWCxtrP9AA7o5uoweGGwuUWY
         FedAj6SPQhChRyuzma/oEN7Dtt+2yTTT5dfBgRFf3hSDLnxVWSfP4AFVf+ojnilVc0F0
         MWQEuGLLsaFrRZedH+CxAsofb8x81JR7YSRDScqEN6TaV1vbip7yDFWrN4Or6tOC7dNi
         c+v0V/xdUV69yXvUd37EaTpcy6nUbimIIGGYPgCrIqUEcFjMereYdA3IgKvrPZuO7XlI
         gO5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5w81+MBP6D/RxL1YeMAc+Drk+izWIG1pVhGppsdjGmc=;
        b=E37G2SdWKCZwZ5cg/4rxEr8VYbC+Ie5wtabHpsbvXB1uQ6ErKp53xi7bjhQBzA4Wzx
         U4s3T0VACW0OqsU/Y5938De1UlG3qiMXmh+T1GJtBoNwlb1rCEYJQEb2JEfYtQYPp9no
         4RIzU9sR2c0WWKGlNqnhDpQq41dZULKoQAxExGSoupSr4cnbx1fC+dlmWzjEp3vtKnvr
         VA76TInBeJX3Eu1HT/ZI+hNc17U7Y2m8lBN2J5nEZedXFM6uV91ny/qqWx9vaibkAi9e
         asGh46cO/4SS1d106g+ey6L0rhVC5FMfDYcosmX4LCNIRe6hh3vco2tC0EYFLPLlUFsW
         kdGQ==
X-Gm-Message-State: APzg51CUy7tKMPBPumlztMbsotHdRl8PvlIAEx8ufB2PrMEEy9ODteg/
        3vuAlAogjxpADhw81ZPb7WU=
X-Google-Smtp-Source: ANB0Vdb7Yv+9M3QzxdgszIXHN5zxjT/U1eL1zqksH53OyaNtgRUAW0FKSzPbaQXyyvr/0wETLk7ZVA==
X-Received: by 2002:adf:b583:: with SMTP id c3-v6mr1394503wre.79.1535467650664;
        Tue, 28 Aug 2018 07:47:30 -0700 (PDT)
Received: from Red ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id c10-v6sm2883885wrb.17.2018.08.28.07.47.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 07:47:29 -0700 (PDT)
Date:   Tue, 28 Aug 2018 16:47:27 +0200
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devel@driverdev.osuosl.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Randy Li <ayaka@soulik.info>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-sunxi@googlegroups.com
Subject: Re: [linux-sunxi] [PATCH v8 3/8] dt-bindings: media: Document
 bindings for the Cedrus VPU driver
Message-ID: <20180828144727.GB25644@Red>
References: <20180828073424.30247-1-paul.kocialkowski@bootlin.com>
 <20180828073424.30247-4-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180828073424.30247-4-paul.kocialkowski@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 09:34:19AM +0200, Paul Kocialkowski wrote:
> This adds a device-tree binding document that specifies the properties
> used by the Cedurs VPU driver, as well as examples.

typo Cedurs=>Cedrus

Regards
