Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E90C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 02:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C608C20652
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 02:23:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C608C20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbeIFG44 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 02:56:56 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:33600 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725885AbeIFG44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 02:56:56 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.191543|-1;CH=blue;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03271;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=12;RT=12;SR=0;TI=SMTPD_---.Cn4qGIY_1536200602;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.Cn4qGIY_1536200602)
          by smtp.aliyun-inc.com(10.147.44.129);
          Thu, 06 Sep 2018 10:23:22 +0800
Date:   Thu, 6 Sep 2018 10:23:22 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-arch@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Arnd Bergmann <arnd@arndb.de>, c-sky_gcc_upstream@c-sky.com,
        gnu-csky@mentor.com, thomas.petazzoni@bootlin.com,
        wbx@uclibc-ng.org, Greentime Hu <green.hu@gmail.com>
Subject: Re: [PATCH V3 22/26] dt-bindings: interrupt-controller: C-SKY SMP
 intc
Message-ID: <20180906022322.GA30251@guoren-Inspiron-7460>
References: <cover.1536138304.git.ren_guo@c-sky.com>
 <a82f72fd77a6c06d23e6d08acc9df2a816d6235d.1536138304.git.ren_guo@c-sky.com>
 <CABGGiszOxskc_V1E8A4i34OWSUdOSVX-QSRrgG+NjTbashND_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABGGiszOxskc_V1E8A4i34OWSUdOSVX-QSRrgG+NjTbashND_g@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 07:45:12PM -0500, Rob Herring wrote:
> On Wed, Sep 5, 2018 at 7:09 AM Guo Ren <ren_guo@c-sky.com> wrote:
> >
> > Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> > ---
> >  .../bindings/interrupt-controller/csky,mpintc.txt  | 40 ++++++++++++++++++++++
> >  1 file changed, 40 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt
> >
> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt b/Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt
> > new file mode 100644
> > index 0000000..49d1658
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt
> > @@ -0,0 +1,40 @@
> > +===========================================
> > +C-SKY Multi-processors Interrupt Controller
> > +===========================================
> > +
> > +C-SKY Multi-processors Interrupt Controller is designed for ck807/ck810/ck860
> > +SMP soc, and it also could be used in non-SMP system.
> 
> How is it accessed? No mmio registers?
Mmio reg base is got from cpu-coprocessor register and I'll detail
it here in next version patch.

csky_mpintc_init(struct device_node *node, struct device_node *parent)
{
	...
	INTCG_base = ioremap(mfcr("cr<31, 14>"), INTC_SIZE);

