Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14AD3C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 21:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD60621A5E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 21:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fgNPWepz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD60621A5E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbeHJXnr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 19:43:47 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:55366 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727263AbeHJXnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 19:43:47 -0400
Received: by mail-it0-f68.google.com with SMTP id d10-v6so4440775itj.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 14:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YDltJDBlVUyz2coNYErFDqxqvnP1Z/86dxgDtczQxI8=;
        b=fgNPWepzDbIOcZQT/PSa+kvDik7XPDEAwBSGwY9WgB9pcFRsNDDlohhGggMu42vcEe
         wdDz8tNj5A5/1NGqYYgyiZqkRZxxm0/jNyyI2XfA/xYHa+17XaxbPKrri8ReCWbUkK3A
         /3n0C/NFmiKB8LjWp1AF9EO5svQZ4AOdsBuII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YDltJDBlVUyz2coNYErFDqxqvnP1Z/86dxgDtczQxI8=;
        b=nd/U15iuc5y4H3S0R/K4yfWcBRMW560kiimv5qb/hHsUvRJeE+jCp/r/GmjMDeLSak
         yeO78MfIpLpKqyB1ZgDFxy1kj4MVbk8s0guFSNLbmUfXkK80swT1qql2Z4OFcaQxXVwH
         OG4yWceLpqa+szkdcLR3dm+XXx1L/wGy1/iHAZlSpg+xzL/WSls5kg99dEbrPoCNrjdm
         Rh4Rq9MSPqCXyjA+s52G2+eqg4kaWrGOYoAvA0urEjNwt2uLeQEX/fRPsHJhU0Y9F9G9
         Xj8s4hiJQGWLG/dHYG90Lwx92Ta32H+9dHLGVkF6X8IOXyycIumY0ehrU/hhPgbKKB5o
         k6FA==
X-Gm-Message-State: AOUpUlEpKDNk1MgawitFB3B4uylbq1laNDgWguAlDCnYbg0+4g0E8W2H
        k6WsZNWET5cpds3xP7zIQmT06vSUdJi+it3+q0szDg==
X-Google-Smtp-Source: AA+uWPz7mrlvDEFC7JaQieXeV35FK2VEw+pg+oIxDdG5D2eIGwnPnLv7YLx3DAZa+LNnOPV+gM45lyx/xKvdpobKz9E=
X-Received: by 2002:a02:2505:: with SMTP id g5-v6mr7270988jag.112.1533935534367;
 Fri, 10 Aug 2018 14:12:14 -0700 (PDT)
MIME-Version: 1.0
References: <20180808084622.26392-1-ipodovalov@gmail.com>
In-Reply-To: <20180808084622.26392-1-ipodovalov@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 10 Aug 2018 23:12:02 +0200
Message-ID: <CACRpkdZmpTnTOSQJU4fojjCUVgsJt8Zy4__MihX4OmubF9Fdrw@mail.gmail.com>
Subject: Re: [PATCH] gpio: it87: add support for IT8718F Super I/O.
To:     ipodovalov@gmail.com
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 8, 2018 at 10:46 AM Ivan Podovalov <ipodovalov@gmail.com> wrote:

> The DIO connector on the WAFER-945GSE is interfaced to GPIO ports
> on the ITE IT8718F Super I/O chipset. From the datasheet of ITE IT8718F,
> the GPIO interface is identical to IT8728, so just add it
> to the same case as the other chip.
>
> Signed-off-by: Ivan Podovalov <ipodovalov@gmail.com>

Patch applied.

Yours,
Linus Walleij
