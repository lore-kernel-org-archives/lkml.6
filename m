Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93671C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 00:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D54620882
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 00:46:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="QsBqi82V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D54620882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725986AbeLGAqC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 19:46:02 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:44171 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbeLGAqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 19:46:02 -0500
Received: by mail-yb1-f194.google.com with SMTP id j145so1631597ybg.11
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 16:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=3nYnynqdM6fFp9CLNu4v+AtKiJm1e4BaJApiy2a/58A=;
        b=QsBqi82V0/wM9T6LsCnwwrlY2/LTXGiCvxNzqJY0oSXNxXWzYh3EOYDj5L/hJ/L6vK
         Hdx8DFv6s5FzpM0q/zjjBR6jOjXU5fAbnizZAkSZ5SLVFzwvDpVugIIhwhDQRFO5zIwy
         tm4GCBLgDaSKvlSkxduIpmVJxvjDrTnDUy76LI0nujM8pEaqGksa1pGa+uh3Hh4ghdKH
         3MG5du2AXj7wboCMSGSJmvdRVXK7oMrE1c7GF4Wb8iz2I6uApIwkbc8I0N3IX5QYctLh
         yZ7QjBionWJcifArY5hvDMByP+2QQvPrEEgw6c77Nkp3vJp7mrbDh6+JyUQZZ6xj7Li8
         ltjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=3nYnynqdM6fFp9CLNu4v+AtKiJm1e4BaJApiy2a/58A=;
        b=IEo9E0//RHQ/koh++96BCU+TlwynifVAnfDO6WGeIhIkcGkkO65cts1J4Ppk5/vUkD
         wKLwqGp4gN7n4wxOAcAWAHT2MppBseRp7mQ5I0Vf9NpInNkMxHCXBR0srCTHYm1pOwhZ
         6dIRRD21b3YK9j81XqW70jW/LNer3FbZi8WMemvc181QL7tA2xO/IFHIYFEhi7QyxQdw
         antLM0YJ9yXgwTPW38ZqIyRae+7NCoT7X6hjsdZqYwN8FT8un9ETGMllQlZ22hYI+Y87
         RZzvwsp3Um/yJni1DryARBejCWCyQNWXS0SQV0etLWTjgZMgwMg4XSl0XfYJXoZ+oKtz
         Nsgw==
X-Gm-Message-State: AA+aEWbNtB008LGHUFCtufOLczJq3nViaP20Dds9M7mWeTPUa1eO/u8K
        3HmhbBjbV+MDhkjalinpLzJoVg==
X-Google-Smtp-Source: AFSGD/Vsm9/8kdM8pQW4zxN2L8z6duU71OVqBqIft/2rT4ZpQBG+r0ad8Ek1R5UY1DM4Jy3qks4YiQ==
X-Received: by 2002:a25:7208:: with SMTP id n8-v6mr170525ybc.144.1544143561084;
        Thu, 06 Dec 2018 16:46:01 -0800 (PST)
Received: from localhost ([208.115.86.73])
        by smtp.gmail.com with ESMTPSA id x4sm1828238ywj.80.2018.12.06.16.46.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 16:46:00 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-Google-Original-From: Paul Walmsley <paulw@sifive.com>
Date:   Thu, 6 Dec 2018 16:45:58 -0800 (PST)
To:     Rob Herring <robh@kernel.org>
cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        devicetree@vger.kernel.org, Palmer Dabbelt <palmer@sifive.com>,
        Megan Wachs <megan@sifive.com>,
        Wesley Terpstra <wesley@sifive.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        paul@pwsan.com
Subject: Re: [PATCH] dt-bindings: sifive: describe sifive-blocks versioning
In-Reply-To: <20181207000104.GA10814@bogus>
Message-ID: <alpine.DEB.2.21.9999.1812061645070.29609@viisi.sifive.com>
References: <alpine.DEB.2.21.9999.1811211704520.16271@viisi.sifive.com> <20181207000104.GA10814@bogus>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 6 Dec 2018, Rob Herring wrote:

> On Wed, Nov 21, 2018 at 05:06:56PM -0800, Paul Walmsley wrote:
> > 
> > For IP blocks that are generated from the public, open-source
> > sifive-blocks repository, describe the version numbering policy
> > that its maintainers intend to use, upon request from Rob
> > Herring <robh@kernel.org>.
> > 
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Palmer Dabbelt <palmer@sifive.com>
> > Cc: Megan Wachs <megan@sifive.com>
> > Cc: Wesley Terpstra <wesley@sifive.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: devicetree@vger.kernel.org
> > Cc: linux-riscv@lists.infradead.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> > Signed-off-by: Paul Walmsley <paul@pwsan.com>
> > ---
> > 
> > Hi Rob, please let me know if this document works with your
> > requirements, or if some changes are needed.  - Paul
> 
> Looks pretty good to me.
> 
> >  .../sifive/sifive-blocks-ip-versioning.txt    | 38 +++++++++++++++++++
> >  1 file changed, 38 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/sifive/sifive-blocks-ip-versioning.txt
> 
> Use the path that was suggested.

Could you remind me which one that is?

> > +
> > +An example is "sifive,uart0" from:
> > +
> > +https://github.com/sifive/sifive-blocks/blob/master/src/main/scala/devices/uart/UART.scala#L43
> 
> That's nice, but will be out of date as soon as someone adds or removes 
> a line above it. Can you point to a tagged version?

Will do

- Paul
