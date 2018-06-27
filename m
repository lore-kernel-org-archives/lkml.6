Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDBB7C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 714982442A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:11:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vq5vYL0i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 714982442A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754766AbeF0PLE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 11:11:04 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:46342 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754729AbeF0PLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 11:11:02 -0400
Received: by mail-pg0-f66.google.com with SMTP id q14-v6so1047735pgt.13
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 08:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ps99/b74vNZkD794VNJlyFFrypR0hmN42aPAe83cArE=;
        b=Vq5vYL0idIqmpNvjAC06rwUZnOxTC8Mx5BY/3N/pijnA0Ze3aq6Lnp2YACxA2mmd3m
         hnaU5txPeMTrf1StYxlsPS9sMY+HdpKrNaG4xdypYfO97QYjQkxMo0Ubs7MfwipNI6hR
         pka3lhMVLZ8cKpzi/Olb8rywBexw2tn/e5ylk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ps99/b74vNZkD794VNJlyFFrypR0hmN42aPAe83cArE=;
        b=LaF8kvk/LRR3vuMsvV5G2bXX7X177vowe2zQNzVCKIRcTVGr6ZzCZkevYyyrdvf6SY
         5Ci9RaHQRvyp94eXYmMg49TyZgbJypxfekxbxxtmakjxiYdnLsalfZibzAER8HMYxlxl
         nL9hOjWIja3y4c0jRCM8ksBwTd0lX24rx6YnKk1IVNxLefLJxs3fX2q5KbLe4CXZRJKJ
         bVYUu+5wt4pHR4Com1+w1ocjbDeUxAvXyT2iug4Vfukomt9lr29jXFdjUIsEx9GM7KJp
         bdp1/Zhduuw0NO8Yt/Li6yJZOV+VMmC1WHzrZkTD4YDd9UYCm6HFzI2L0/T/BBX+Y91X
         5+5g==
X-Gm-Message-State: APt69E2aY1L1rGWHIEmLz5Ah1ohAuON1ae9PLjYnpETwEgdxhIBVqLwc
        DrrJCyX5pmfzenHTBXuSgOs8
X-Google-Smtp-Source: AAOMgpdDRrt70R/HWkdHOSrj0xSqqMv94+w9k35ih4ZDMYZuTxiDfaUcedYHVBj9tQQsNY+WFbN0aQ==
X-Received: by 2002:aa7:8589:: with SMTP id w9-v6mr6281396pfn.119.1530112261497;
        Wed, 27 Jun 2018 08:11:01 -0700 (PDT)
Received: from mani ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id s14-v6sm6615118pfh.116.2018.06.27.08.10.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 08:11:00 -0700 (PDT)
Date:   Wed, 27 Jun 2018 20:40:52 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        robh+dt@kernel.org, liuwei@actions-semi.com,
        96boards@ucrobotics.com, devicetree@vger.kernel.org,
        amit.kucheria@linaro.org, hzhang@ucrobotics.com,
        bdong@ucrobotics.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, manivannanece23@gmail.com,
        Jeff Chen <jeff.chen@actions-semi.com>,
        "Thomas C. Liau" <thomas.liau@actions-semi.com>
Subject: Re: [PATCH 1/4] dt-bindings: power: Add Actions Semi S900 SPS
Message-ID: <20180627151052.GA24330@mani>
References: <20180411164036.8046-1-manivannan.sadhasivam@linaro.org>
 <20180411164036.8046-2-manivannan.sadhasivam@linaro.org>
 <a261bae6-d2fa-a550-7232-7647ce0ac0e2@suse.de>
 <20180626164117.GA5241@Mani-XPS-13-9360>
 <20180627145713.uao2gr5kknk2cypk@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180627145713.uao2gr5kknk2cypk@holly.lan>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 03:57:13PM +0100, Daniel Thompson wrote:
> On Tue, Jun 26, 2018 at 10:11:17PM +0530, Manivannan Sadhasivam wrote:
> > > > diff --git a/include/dt-bindings/power/owl-s900-powergate.h b/include/dt-bindings/power/owl-s900-powergate.h
> > > > new file mode 100644
> > > > index 000000000000..f1aaf761112b
> > > > --- /dev/null
> > > > +++ b/include/dt-bindings/power/owl-s900-powergate.h
> > > > @@ -0,0 +1,23 @@
> > > > +// SPDX-License-Identifier: GPL-2.0+
> > > 
> > > checkpatch.pl warns about this line due to not using /* ... */ syntax
> > > for headers. I could fix that up on my own, but it made me realize that
> > > you are licensing this file under GPL-2.0+ only, whereas the .dts[i] is
> > > supposed to be dual-licensed.
> > > 
> > > Can you please give your consent to make this
> > > 
> > > /* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
> > > 
> > 
> > You can change the license to GPL-2.0+ OR MIT.
> > 
> > > like my S500 and S700 bindings?
> > > 
> > > Question: Should it still be GPL-2.0+ or the new GPL-2.0-or-later?
> > >
> > 
> > I think GPL-2.0+ is fine.
> 
> So... when I saw this I did wonder why one would knowly choose to use a
> deprecated license identifier (https://spdx.org/licenses/ ).
> 
> However running `git diff v4.17..v4.18-rc1` through some filters does
> indicate that GPL-2.0+ is the more popular choice by 256 to 0! Doesn't
> mean you couldn't break the mould though ;-).
>

I did grep through the source and hit with same numbers ;-) But I was not
sure whether to break the mould or not, so chose the safest path :)

Since you already gave the green signal, I think we can move to new style
identifier.

Thanks,
Mani 
> 
> Daniel.
