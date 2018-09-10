Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3650EC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 19:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D21B72088F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 19:44:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D21B72088F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbeIKAkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 20:40:05 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:45021 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728063AbeIKAkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 20:40:05 -0400
Received: by mail-oi0-f67.google.com with SMTP id l82-v6so42543787oih.11;
        Mon, 10 Sep 2018 12:44:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=biGu9cM777i63e9RO0Pmlvsg19rmNkiJpeVt41vfFpo=;
        b=eqsCSZdncB4LfL1c1D6eI6mpRueWJwURfK3kQbEaxFX7FKTF/shM+czrSURle7Tnv+
         X3z8BSpqyhmvSHGKuvvLScFYkvr2HzvOkZhSf93azj7lUU941QdqmgFn0xROnnK8OKTT
         WrylVRCGP087gMuBSqCagurkG/ajIzXjO7XDr9RnRscpdyBIjvtNU+wm7ioPd2y19/IR
         t6DXTYwwls7JeA+7uLIQ83JG3i+bKl4mOX+WBfKHoEPw4HkcC5z+nZDii6bhO/3Lf1M4
         yNoldymOm2z0YxVzfqM0gi1nxLNZEyS98hP9zTXcNR89183YihD8BsYSskiIF7Soh3eJ
         yrlw==
X-Gm-Message-State: APzg51CRTwvlv+B9MiN2Mg9sSyTQ6BI9M0OQtFbAhjOT1A2y4vxViVUd
        IqzgC7pcnGTswLU3uTQE4Q==
X-Google-Smtp-Source: ANB0VdZv2/T9PHLixosbAKKuVRkWiy+5WdeZFhb70e7osZuvcBmvfVxvaMxS6Y3Q6fTpbXNcvCARgg==
X-Received: by 2002:aca:e184:: with SMTP id y126-v6mr22378492oig.313.1536608666117;
        Mon, 10 Sep 2018 12:44:26 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s145-v6sm33505845oih.16.2018.09.10.12.44.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 12:44:25 -0700 (PDT)
Date:   Mon, 10 Sep 2018 14:44:24 -0500
From:   Rob Herring <robh@kernel.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Philipp Rossak <embed3d@gmail.com>, lee.jones@linaro.org,
        mark.rutland@arm.com, wens@csie.org, linux@armlinux.org.uk,
        jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, eugen.hristev@microchip.com,
        rdunlap@infradead.org, vilhelm.gray@gmail.com,
        clabbe.montjoie@gmail.com, quentin.schulz@bootlin.com,
        geert+renesas@glider.be, lukas@wunner.de, icenowy@aosc.io,
        arnd@arndb.de, broonie@kernel.org, arnaud.pouliquen@st.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v3 14/30] dt-bindings: update the Allwinner GPADC device
 tree binding for H3 & A83T
Message-ID: <20180910194424.GA21461@bogus>
References: <20180830154518.29507-1-embed3d@gmail.com>
 <20180830154518.29507-15-embed3d@gmail.com>
 <20180831084854.q2uh63pw5vprqlzt@flea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180831084854.q2uh63pw5vprqlzt@flea>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 10:48:54AM +0200, Maxime Ripard wrote:
> On Thu, Aug 30, 2018 at 05:45:02PM +0200, Philipp Rossak wrote:
> > Allwinner H3 features a thermal sensor like the one in A33, but has its
> > register re-arranged, the clock divider moved to CCU (originally the
> > clock divider is in ADC) and added a pair of bus clock and reset.
> > 
> > Allwinner A83T features a thermal sensor similar to the H3, the ths clock,
> > the bus clock and the reset was removed from the CCU. The THS in A83T
> > has a clock that is directly connected and runs with 24 MHz.
> > 
> > Update the binding document to cover H3 and A83T.
> > 
> > Signed-off-by: Philipp Rossak <embed3d@gmail.com>
> 
> You probably want to have a look at:
> https://www.spinics.net/lists/arm-kernel/msg670167.html

Well, which is it? An ADC or thermal sensor?

Rob
