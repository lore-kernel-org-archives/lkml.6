Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06288C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 20:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3AD620657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 20:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547582812;
	bh=F/x3LgJKbGiqxFAZRNvd52MbCvvmyWCnwil0/9dX/wA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XwhrexGvdciGzk+VQLv0Czd3Hv+Sw9HLLyTzil2wHsoF+0Qa33/+y8iddlSXSsbiM
	 6rtSfLGpU+OY3E6pef8oHU47vExc0IDZ8JhenxzqQS48YVYH2OYw3sZdRwUOeAE3k+
	 aNHoqBWhus8TbjIkmwLWWYOlG/PD4B1SQW3T55iM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389720AbfAOUGu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 15:06:50 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45812 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389705AbfAOUGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 15:06:46 -0500
Received: by mail-oi1-f193.google.com with SMTP id y1so3121921oie.12;
        Tue, 15 Jan 2019 12:06:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IfApsPbT5mrQM1m35yD2qsrsKzQOZSOC5ozeIJ1xNWM=;
        b=UEC3Jp8+s2x5TkcKCZGfyEMY5Nq7YFFxYgVa6lSjmIh1mwx9rH6jvmqz9xKOBqpFIS
         SJk2BeybOfw0lxWC1/Qitx0BpWHYdTdPV+zEPz2+pRgWB/V17EpCnjhI7sS5lAwxL/ON
         bPcq9qqJ+DDtlbPH/MVW4L6vYhbX0y6oqqNBZtpagKMspSqEPD+uVp4SLwPzSa2LUw1B
         Sn38RfJW9MjtUEi+LF2xzbAJq3MIoW1h006z3coh7INZckQcYRqP8ZPfyZgnK56NQDxi
         4TC8rAF8VuyBZ9gfxuJiecRXe04EEmQsE6Fgt6O21IYkVadUgG9RXtitGW+c0xlEEAfE
         7s6w==
X-Gm-Message-State: AJcUukc9wuJdvkLz01a7hBeqq2xpeAuRHOn7+fNLoBvFMHJPKuIMLkzd
        Ta7KYmHVgDufI2TpqEneh0IP3fA=
X-Google-Smtp-Source: ALg8bN5UqvlW2PHV5V9znrImPN2NpcPtYP8AGAzjc/qlLZ9gazgyU1J0C5dbkN1oSzgBALmBN8MhWw==
X-Received: by 2002:a05:6808:296:: with SMTP id z22mr215574oic.67.1547582806039;
        Tue, 15 Jan 2019 12:06:46 -0800 (PST)
Received: from localhost ([70.231.7.113])
        by smtp.gmail.com with ESMTPSA id l6sm1741242otk.51.2019.01.15.12.06.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 12:06:45 -0800 (PST)
Date:   Tue, 15 Jan 2019 14:06:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Peter Rosin <peda@axentia.se>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peter Rosin <peda@axentia.se>, David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 1/5] dt-bindings: display: bridge: fork out
 ti,ds90c185  from lvds-transmitter
Message-ID: <20190115200644.GA19608@bogus>
References: <20190111151843.11114-1-peda@axentia.se>
 <20190111151843.11114-2-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190111151843.11114-2-peda@axentia.se>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jan 2019 15:18:55 +0000, Peter Rosin wrote:
> DS90C185 has a shutdown pin which does not fit in the lvds-transmitter
> binding, which is meant to be generic.
> 
> The sister chip DS90C187 is similar to DS90C185, describe it here as well.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  .../bindings/display/bridge/lvds-transmitter.txt   | 10 ++--
>  .../bindings/display/bridge/ti,ds90c185.txt        | 55 ++++++++++++++++++++++
>  2 files changed, 59 insertions(+), 6 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/ti,ds90c185.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
