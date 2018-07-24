Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F7BC28CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 23:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 096FA20852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 23:25:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 096FA20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388465AbeGYAdw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 20:33:52 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:54236 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388408AbeGYAdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 20:33:52 -0400
Received: by mail-it0-f66.google.com with SMTP id 72-v6so6171125itw.3;
        Tue, 24 Jul 2018 16:25:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/YxfK2A7/G1UBExqVEo02hLS2Yn4pl5jP5dHqu0rkYQ=;
        b=CMOdEMsCsmcs5d43cyhyZZ3h9pMrULX++j2KzWqV+WP+Y6F0JpFZCjwnf5DKlUgv4P
         w4U1z8laOy3pcw8ORanTjnrWGEk7sa3d0pBohIuBwYOBn5nWlZ4BfTOY+EuyauXCrGKW
         JZgCCX1UBmJ5cUztT4xG7MWEsZKPYgQU8KhSUWZvQlW8txhvOXBGvfdZTuoIjWrI+rAw
         AD7g7ZQfxf8eQDZfEOCINBul2F5LikGvZal6FOaTkwjBcFMjuLPrneJ+J287LlXbO3sz
         qPSnAi8bMroTsLxF+u4NRuBxjMxQlN2HRriuewq4yc+w3elt+Pl2UUMTU3XGkUl0YBpL
         jdEA==
X-Gm-Message-State: AOUpUlErjwI++5eO6KhyocfZOjHabUCTMelzATx12XJAxsw6wGWvBjp5
        Z6VUigR/2cSIZ550kZUJPQ==
X-Google-Smtp-Source: AAOMgpez2Kz0lzqJd+8qM9+h0YBKONz9RDRADHOhRF2OD63+nsbqh1I9FlZ9I0eoXzBP3BhDTIsu5w==
X-Received: by 2002:a02:579a:: with SMTP id b26-v6mr17470264jad.107.1532474703136;
        Tue, 24 Jul 2018 16:25:03 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id q3-v6sm1579796itc.22.2018.07.24.16.25.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 16:25:02 -0700 (PDT)
Date:   Tue, 24 Jul 2018 17:25:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Denis OSTERLAND <denis.osterland@diehl.com>
Cc:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "m.grzeschik@pengutronix.de" <m.grzeschik@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH v5 5/5] rtc: isl1219: add device tree docu
Message-ID: <20180724232501.GA22127@rob-hp-laptop>
References: <20180724095437.6016-1-Denis.Osterland@diehl.com>
 <20180724095437.6016-6-Denis.Osterland@diehl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180724095437.6016-6-Denis.Osterland@diehl.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 11:31:22AM +0000, Denis OSTERLAND wrote:
> From: Denis Osterland <Denis.Osterland@diehl.com>
> 
> The devicetree documentation for the ISL1219 device tree
> binding is added with an short example. It is not a trivial
> device, because it supports two interrupt sources.
> 
> Signed-off-by: Denis Osterland <Denis.Osterland@diehl.com>
> ---
>  .../devicetree/bindings/rtc/isil,isl1219.txt  | 29 +++++++++++++++++++
>  1 file changed, 29 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/isil,isl1219.txt

Reviewed-by: Rob Herring <robh@kernel.org>
