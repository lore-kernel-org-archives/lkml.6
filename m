Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD500C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 21:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58D7121525
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 21:48:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58D7121525
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753421AbeGCVss (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 17:48:48 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:34113 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753159AbeGCVsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 17:48:46 -0400
Received: by mail-yb0-f195.google.com with SMTP id e9-v6so1310985ybq.1;
        Tue, 03 Jul 2018 14:48:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8SZ/GXO1o9RW2jG4ckwjzTymgePhJLA68sSvAvIYM44=;
        b=ry+zmrr1aecMhg78R6dFHEATl6K4YH55+JmrqEg4NaNpVWwpV/xmekEx82GcG4E8Oz
         gnspcB9INzFXHHJD28MjYJQw3VfnMinBGYqYhCnOvxqqmmiCpH6plwhsetN80/Ea4GY/
         15LZ0dXp9XJF1ab2lncQ/lKzvEs7lyBkCAvfXaq1rPiJJVYW9HgOYp9PhnKz5c0VlLHT
         N5f0i0TTsEod6E4KZxcTzBZgY0LPHcHRpCFvRliBevkG4qlDz+LhOeYHszQ5kWvHApzJ
         IJ8XCFHSGceUcHuz1LA4weWyvNG3CAY/87Aqj+CupJ/xkbJHES2UTG2wLfNSOH73Zi8N
         FE+g==
X-Gm-Message-State: APt69E1Sw0X4Rdkmxa9W5wT7XJT49KJChrB9cA+AL57zmAyfhZFPSYDG
        SSrqZ4Yrq0D5bLP6qFEvCQ==
X-Google-Smtp-Source: AAOMgpcIaB7440RL1Ba4ZtHKLxJxi8NvAZIw/IDw5H9ZKdVsdtgUSmlf4LRYaryNmzlQeN+U0Pr4ZA==
X-Received: by 2002:a5b:811:: with SMTP id x17-v6mr15523339ybp.86.1530654525909;
        Tue, 03 Jul 2018 14:48:45 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id d6-v6sm751773ywj.2.2018.07.03.14.48.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 14:48:45 -0700 (PDT)
Date:   Tue, 3 Jul 2018 15:48:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Andreas Klinger <ak@it-klinger.de>, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, mark.rutland@arm.com,
        mchehab@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        linus.walleij@linaro.org, rdunlap@infradead.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] iio: hx711: add data-ready-delay-ns property in DT
Message-ID: <20180703214843.GA484@rob-hp-laptop>
References: <20180625151802.GA6369@arbeit>
 <20180630183232.540ce031@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180630183232.540ce031@archlinux>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 30, 2018 at 06:32:32PM +0100, Jonathan Cameron wrote:
> On Mon, 25 Jun 2018 17:18:02 +0200
> Andreas Klinger <ak@it-klinger.de> wrote:
> 
> > add data-ready-delay-ns property for hx711 ADC
> > this is the delay after rising PD_SCK until DOUT is read and assumed to be
> > ready
> > 
> > Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> 
> Hmm. It's not particularly generic... I think this should have
> have vendor prefix until we have some visibility of whether it
> is a common thing we want to standardise around or not.

Agreed. Doesn't look like any interface I've seen before.

Since it's bit-banging, seems to me it would be better to specify the 
frequency for PD_SCK and sample DOUT just before or after setting PD_SCK 
low. 

Rob

> I'll also be waiting for a devicetree ack on this one as it's a
> tiny bit unusual.
> 
> Thanks,
> 
> Jonathan
