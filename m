Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9028C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 02:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64DA3205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 02:02:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64DA3205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbeIFGfi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 02:35:38 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:58214 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725850AbeIFGfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 02:35:37 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07909418|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03305;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=12;RT=12;SR=0;TI=SMTPD_---.Cn46dsY_1536199350;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.Cn46dsY_1536199350)
          by smtp.aliyun-inc.com(10.147.41.199);
          Thu, 06 Sep 2018 10:02:31 +0800
Date:   Thu, 6 Sep 2018 10:02:29 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     Rob Herring <rob.herring@linaro.org>
Cc:     linux-arch@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Arnd Bergmann <arnd@arndb.de>, c-sky_gcc_upstream@c-sky.com,
        gnu-csky@mentor.com, thomas.petazzoni@bootlin.com,
        wbx@uclibc-ng.org, Greentime Hu <green.hu@gmail.com>
Subject: Re: [PATCH V3 19/26] dt-bindings: timer: gx6605s SOC timer
Message-ID: <20180906020229.GB29405@guoren-Inspiron-7460>
References: <cover.1536138304.git.ren_guo@c-sky.com>
 <768ac390f9eee8acb4dc9ca85a489a1d2fd00628.1536138304.git.ren_guo@c-sky.com>
 <CABGGiszuo3gpjmutYzOpQUmGaNjq88_5pDj2TjXveX9x2+Rsig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABGGiszuo3gpjmutYzOpQUmGaNjq88_5pDj2TjXveX9x2+Rsig@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 07:47:29PM -0500, Rob Herring wrote:
> On Wed, Sep 5, 2018 at 7:09 AM Guo Ren <ren_guo@c-sky.com> wrote:
> >
> > Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> > ---
> >  .../bindings/timer/csky,gx6605s-timer.txt          | 46 ++++++++++++++++++++++
> >  1 file changed, 46 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/timer/csky,gx6605s-timer.txt
> >
> > diff --git a/Documentation/devicetree/bindings/timer/csky,gx6605s-timer.txt b/Documentation/devicetree/bindings/timer/csky,gx6605s-timer.txt
> > new file mode 100644
> > index 0000000..1136d9e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/timer/csky,gx6605s-timer.txt
> > @@ -0,0 +1,46 @@
> > +=================
> > +gx6605s SOC Timer
> > +=================
> > +
> > +The timer is used in gx6605s soc as system timer and the driver
> > +contain clk event and clk source.
> > +
> > +==============================
> > +timer node bindings definition
> > +==============================
> > +
> > +        Description: Describes gx6605s SOC timer
> > +
> > +        PROPERTIES
> > +
> > +        - compatible
> > +                Usage: required
> > +                Value type: <string>
> > +                Definition: must be "csky,gx6605s"
> 
> -timer?
Yes, thx. must be "csky,gx6605s-timer"
> 
> > +       - reg
> > +               Usage: required
> > +               Value type: <u32 u32>
> > +               Definition: <phyaddr size> in soc from cpu view
> > +       - clocks
> > +               Usage: required
> > +               Value type: <node>
> 
> phandle + clock specifier cells
Sorry, I don't got it. Do you mean:
                    Value type: <phandle + clock specifier cells>
?
> 
> > +               Definition: must be input clk node
> > +        - interrupt
> > +                Usage: required
> > +                Value type: <u32>
> > +                Definition: must be timer irq num defined by soc
> > +        - interrupt-parent:
> 
> This is implied. Don't need to document it here.
Ok, remove interrupt-parent
> 
> > +                Usage: required
> > +               Value type: <node>
> > +                Definition: must be interrupt controller node
> > +
> > +Examples:
> > +---------
> > +
> > +       timer:timer {
> 
> Needs a unit-address.
Ok, change to "timer0: timer@0x0020a000"
> 
> > +               compatible = "csky,gx6605s-timer";
> > +               reg = <0x0020a000 0x400>;
> > +               clocks = <&dummy_apb_clk>;
> > +               interrupts = <10>;
> > +               interrupt-parent = <&intc>;
> > +       };
> > --
> > 2.7.4
> >
