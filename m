Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C2B0C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 15:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54B0B208DB
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 15:09:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54B0B208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbeHQSNk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 14:13:40 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:40714 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727333AbeHQSNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 14:13:40 -0400
Received: by mail-io0-f196.google.com with SMTP id l14-v6so7156860iob.7;
        Fri, 17 Aug 2018 08:09:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xaDHgRbvMtur8Kb4ESNt8Heux765rSR2dKpxLzuA5oA=;
        b=e6MvfiRkq5+Td7KEN0lnjDxgGVZQYJNNromqR9Nh3nhfWENgcNxpgGZ3FFfxZvhFTS
         7KhOwJ7sweQbsErnoqDK2lU2dUNOAAv4H+UuB4z3iEoOpFaT2gT5r3pN3B/5hv2RG5Cw
         j/n0XK9mkTAJrnrV09oIAieWSx1trHRYh2mIlAcmIFzLvj6b0iaeNii+Xndw5GD8YVoQ
         A80wTO+Wg5lGXhZzCgDPwwyK/t3OmF0qC4I3lrjRRooL54iZ2+Esqz+pqnbyGoVE8pn/
         /Fn1FfxOczuxLz/SkDoI7TS2uP0l9FYIoTcXEfueYv2klamTmFkyuxNeMbmLamqy7ils
         nlnw==
X-Gm-Message-State: APzg51CdKeW3sk3ybu5l04cTKfJTGr9seEBo9Bj9HTH49FAjRC95jJUp
        bvSwgTOESwtWAuJckQEJhio9h9I=
X-Google-Smtp-Source: ANB0VdaIR6KG3LjdO41e+Dyxl6bQaz74eYYp3csFrpsyWA/C6UzM9ykLMhv17Y39EG0PLuC8d3fTLw==
X-Received: by 2002:a6b:ce19:: with SMTP id p25-v6mr2184851iob.243.1534518595416;
        Fri, 17 Aug 2018 08:09:55 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id m1-v6sm931941ioq.2.2018.08.17.08.09.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 Aug 2018 08:09:55 -0700 (PDT)
Date:   Fri, 17 Aug 2018 09:09:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        James Hogan <jhogan@kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microsemi.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v4 4/7] i2c: designware: document MSCC Ocelot bindings
Message-ID: <20180817150954.GB20845@rob-hp-laptop>
References: <20180816084521.16289-1-alexandre.belloni@bootlin.com>
 <20180816084521.16289-5-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180816084521.16289-5-alexandre.belloni@bootlin.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this email is from Rob's (experimental) review bot. I found a couple
of common problems with your patch. Please see below.

On Thu, 16 Aug 2018 10:45:18 +0200, Alexandre Belloni wrote:
> Document bindings for the Microsemi Ocelot integration of the Designware
> I2C controller.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

The preferred subject prefix is "dt-bindings: <binding dir>: ...".

> ---
>  Documentation/devicetree/bindings/i2c/i2c-designware.txt | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
