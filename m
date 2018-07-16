Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F35ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 21:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB05E208EC
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 21:59:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB05E208EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730621AbeGPW2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 18:28:40 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:44616 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728758AbeGPW2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 18:28:39 -0400
Received: by mail-oi0-f66.google.com with SMTP id s198-v6so77759261oih.11;
        Mon, 16 Jul 2018 14:59:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oU/oiYyCbZnjeYwr14HD6ydz17fIzIngQF4N1A2lJMg=;
        b=VDkfVunffL4pEE5rky9rgKCszbi1oAP41V3DPAh9NPMGo7dfx4AnlPCPl9fh8ysJwU
         S3XLh9zsNg377IqRSzG2zUTFwBDhbKI5qTXPdpEglO4J6ZorHzzbe7zHPFCe6VHRrI3v
         i/h0kbl7SSReFh+VZgl3eXODr1+n8RscC0CZkEkth0hM3i5euvlnoI8WfTAdrXWWzgbm
         SuJq/ktwiJyOb+tCFSKhq0siALSa2A1kAisBpw0TTbmPemRE1EQfM+h8EKure5Wf9bET
         2h5b2ZpiVwbuKluf5i/NNUc+v9Sn7jCBZGfHybZW6ASQospsm0TmcFnoxgEGU6ic8hJq
         ToZQ==
X-Gm-Message-State: AOUpUlGLiDFTWXs/VDlt9X7TuHPIDEp38oPmlHxivgsyyk0QmaG0z6KK
        pbrfM9R0OQt9BiakioxA/w==
X-Google-Smtp-Source: AAOMgpdMccCKdfXTs5LsUZ3dg+kyqy0M4NSoqR8Q3NHYoyfcIoG6DX/ctY1iIYHXoHoO5O+2EPu1Mw==
X-Received: by 2002:aca:5cd4:: with SMTP id q203-v6mr1244246oib.217.1531778356677;
        Mon, 16 Jul 2018 14:59:16 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id p132-v6sm10707704oia.31.2018.07.16.14.59.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 14:59:15 -0700 (PDT)
Date:   Mon, 16 Jul 2018 15:59:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        devicetree@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manjunath M B <Manjunath.MB@synopsys.com>,
        Prabu Thangamuthu <Prabu.T@synopsys.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/2] dt: bindings: Add bindings for SDHCI Synopsys DWC
 MSHC
Message-ID: <20180716215913.GA4269@rob-hp-laptop>
References: <20180706151930.78b3024b@xhacker.debian>
 <20180706152047.0b0a4944@xhacker.debian>
 <20180711161206.GA1558@rob-hp-laptop>
 <20180712100611.5887a195@xhacker.debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180712100611.5887a195@xhacker.debian>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 10:06:11AM +0800, Jisheng Zhang wrote:
> Hi Rob,
> 
> On Wed, 11 Jul 2018 10:12:06 -0600 Rob Herring wrote:
> 
> > On Fri, Jul 06, 2018 at 03:20:47PM +0800, Jisheng Zhang wrote:
> > > Synopsys SDHCI compatible DesignWare Cores Mobile Storage Host
> > > Controller can support eMMC/SD/SDIO. Add the bindings.
> > > 
> > > Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> > > ---
> > >  .../bindings/mmc/sdhci-of-dwcmshc.txt         | 20 +++++++++++++++++++
> > >  1 file changed, 20 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-of-dwcmshc.txt
> > > 
> > > diff --git a/Documentation/devicetree/bindings/mmc/sdhci-of-dwcmshc.txt b/Documentation/devicetree/bindings/mmc/sdhci-of-dwcmshc.txt
> > > new file mode 100644
> > > index 000000000000..ee4253b33be2
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/mmc/sdhci-of-dwcmshc.txt
> > > @@ -0,0 +1,20 @@
> > > +* Synopsys DesignWare Cores Mobile Storage Host Controller
> > > +
> > > +Required properties:
> > > +- compatible: should be one of the following:
> > > +    "snps,dwcmshc-sdhci"  
> > 
> > Needs to note that there must also be an SoC specific compatible.
> 
> Currently, there's no SoC specific code in this driver, so the binding could
> be extended to SoC compatible if necessary. What do you think?

Doesn't matter what's in the driver, it can use this compatible.

But experience has shown that a compatible for a licensed IP is never 
sufficient. There are versions of the blocks, configuration options, and 
integration differences.

I'm not asking you to add any SoC specific compatible now unless you 
are working on a particular SoC, but just state one is needed. 

Rob
