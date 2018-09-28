Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 451D3C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 01:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC04021733
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 01:07:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC04021733
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbeI1H2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 03:28:42 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:56355 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726060AbeI1H2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 03:28:41 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1181642|-1;CH=blue;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03294;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=17;RT=17;SR=0;TI=SMTPD_---.CwkpIo._1538096843;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.CwkpIo._1538096843)
          by smtp.aliyun-inc.com(10.147.41.178);
          Fri, 28 Sep 2018 09:07:24 +0800
Date:   Fri, 28 Sep 2018 09:07:23 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     Rob Herring <robh@kernel.org>
Cc:     akpm@linux-foundation.org, arnd@arndb.de,
        daniel.lezcano@linaro.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, jason@lakedaemon.net,
        marc.zyngier@arm.com, mark.rutland@arm.com,
        mchehab+samsung@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, devicetree@vger.kernel.org,
        green.hu@gmail.com, palmer@sifive.com
Subject: Re: [PATCH V5 23/30] dt-bindings: interrupt-controller: C-SKY SMP
 intc
Message-ID: <20180928010721.GB4179@guoren-Inspiron-7460>
References: <cover.1537789736.git.ren_guo@c-sky.com>
 <57888913907d6c22b23425ed9d4e5a79be5b2eff.1537789737.git.ren_guo@c-sky.com>
 <20180927165044.GA30320@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180927165044.GA30320@bogus>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 11:50:44AM -0500, Rob Herring wrote:
> On Tue, Sep 25, 2018 at 07:39:26AM +0800, Guo Ren wrote:
> >  - Dt-bindings doc about C-SKY Multi-processors interrupt controller.
> > 
> > Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> > ---
> >  .../bindings/interrupt-controller/csky,mpintc.txt  | 40 ++++++++++++++++++++++
> >  1 file changed, 40 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt b/Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt
> > new file mode 100644
> > index 0000000..9cdad74
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt
> > @@ -0,0 +1,40 @@
> > +===========================================
> > +C-SKY Multi-processors Interrupt Controller
> > +===========================================
> > +
> > +C-SKY Multi-processors Interrupt Controller is designed for ck807/ck810/ck860
> > +SMP soc, and it also could be used in non-SMP system.
> > +
> > +Interrupt number definition:
> > +
> > +  0-15  : software irq, and we use 15 as our IPI_IRQ.
> > + 16-31  : private  irq, and we use 16 as the co-processor timer.
> > + 31-1024: common irq for soc ip.
> > +
> > +=============================
> > +intc node bindings definition
> > +=============================
> > +
> > +	Description: Describes SMP interrupt controller
> > +
> > +	PROPERTIES
> > +
> > +	- compatible
> > +		Usage: required
> > +		Value type: <string>
> > +		Definition: must be "csky,mpintc"
> 
> Only 1 version?
Currently, one version. Only one csky,mpintc.

> 
> This is fine for a fallback, but you should have an SoC specific 
> compatible too in case there are any SoC specific errata/quirks.
No SoC specific in fact currently. If necessary we could add it in future.

> 
> > +	- interrupt-cells
> 
> Should be: #interrupt-cells
Yes, I'll fix it.
