Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F2C1C46460
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 02:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B396C223B8
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 02:54:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d32i4pw6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B396C223B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727373AbeHJFWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 01:22:18 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33527 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725198AbeHJFWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 01:22:17 -0400
Received: by mail-pg1-f194.google.com with SMTP id r5-v6so3691863pgv.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 19:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=qD4SDO/YMkOc4QtOLgUTnpiconjARpAHdS6vibgQxWU=;
        b=d32i4pw6FfZ2VbpaTYvdoqgiHkBcpg6gVMgB8unB3FtUwIo70ENXyPmkX59eX2bIat
         2KW1UUOlElF9ALDLrrBPctak10wwR0SN9qTozAiFwo7ynO67Nb7j5m1hBijQxbfX+zCa
         kiO3/uwwrn/RnyVP+bP0d/2l6j2OPg5D16dag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=qD4SDO/YMkOc4QtOLgUTnpiconjARpAHdS6vibgQxWU=;
        b=VjEINq6Kkq64xweOpxByd+macsOPLBnt0RXHFCV6chRRuT4aX96SvhKMMUUTTtTASq
         BFaNVOWFG4esMubFHx7hTwyltCkUa9cu4G8x06dh0b/FxrYDHJPnRvV2tKD1WlkPJW9E
         dvZDLWyTkGyBWAQx2ZuctGIZCeDJ1JUYsnoQTmOf+1SFHMN/y2wG8MGSfXml7GXONjXy
         X/0vb1jklhTp2usB6uR3S7Peiy7p7nJsSodRti3P7l6FSBsloAIWeu0PIQ2/y45UvaRY
         4T373znWnhlEoen3fZEoyosrvM64w8d8as/zOjBnOhIBdMU/1WnvQiaYgUsK5WaprWEJ
         J8rQ==
X-Gm-Message-State: AOUpUlEUBBz2NFNDdDAteN1oULQhkrs3SOZmFBqqopyJyNQ5uPAMAfQw
        ZAPb9ZdYMhlhUUv9dagwlQI59Q==
X-Google-Smtp-Source: AA+uWPxUvcIUIMA5bc53uSKK2WhtFiO5mSyWIedOZVKSek7INeDqmrji6lzxgL2m869pAtdLPpYUXA==
X-Received: by 2002:a65:5284:: with SMTP id y4-v6mr4294224pgp.283.1533869669509;
        Thu, 09 Aug 2018 19:54:29 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:7e28:b9f3:6afc:5326])
        by smtp.gmail.com with ESMTPSA id t30-v6sm13635673pgm.81.2018.08.09.19.54.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 19:54:28 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Julius Werner <jwerner@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <CAODwPW8+QSittJdNLWpWKU=JNJa5bssMHQ4ER4CfnUAWaL1JGA@mail.gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Wei-Ning Huang <wnhuang@chromium.org>,
        Brian Norris <briannorris@chromium.org>, samuel@sholland.org
References: <20180809171722.144325-1-swboyd@chromium.org>
 <20180809171722.144325-8-swboyd@chromium.org>
 <CAODwPW8eg2WOh9-Raeb8Q65E-5D7RDheDU8e+H68FHGa0MS37A@mail.gmail.com>
 <153385579866.220756.16086660810932774163@swboyd.mtv.corp.google.com>
 <CAODwPW84FYK3k5=n4gQ4EPJExhQ59LCEi31ZYi2Bq2y9FH_E_A@mail.gmail.com>
 <CAODwPW8+QSittJdNLWpWKU=JNJa5bssMHQ4ER4CfnUAWaL1JGA@mail.gmail.com>
Message-ID: <153386966793.37448.12640092735399834661@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v3 7/7] firmware: coreboot: Request table region for exclusive
 access
Date:   Thu, 09 Aug 2018 19:54:27 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

What's with the top posting? ;-)

Quoting Julius Werner (2018-08-09 16:44:43)
> Actually, looking at what IO_STRICT_DEVMEM really does, would it
> really prevent userspace accesses to these areas? Because it seems
> that it only prevents accesses to areas marked as IORESOURCE_BUSY, and
> while I can't fully follow how the kernel assigns that, comments
> suggest that this is only set when "Driver has marked this resource
> busy".

Requesting the memory region as is done in this patch marks it as busy.

> =

> So after you make the change to the other patch where we immediately
> unmap the coreboot table again at the end of the probe() function,
> shouldn't it become available to userspace again even with
> IO_STRICT_DEVMEM set?

Yes, if we unmap the region immediately after devices are populated then
this whole point is moot with the assumption that this code isn't
running at the same time as the cbmem utility. I've done this already
and it is working on arm. I still need to build/boot/test on an x86
platform which I should be able to do tomorrow.

