Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 488D0C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 01:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C1A621733
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 01:03:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C1A621733
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728375AbeI1HYk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 03:24:40 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:39947 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726083AbeI1HYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 03:24:40 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07573073|-1;CH=blue;FP=0|0|0|0|0|-1|-1|-1;HT=e01e01542;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=17;RT=17;SR=0;TI=SMTPD_---.CwkvfuL_1538096593;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.CwkvfuL_1538096593)
          by smtp.aliyun-inc.com(10.147.41.138);
          Fri, 28 Sep 2018 09:03:13 +0800
Date:   Fri, 28 Sep 2018 09:03:13 +0800
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
Subject: Re: [PATCH V5 18/30] dt-bindings: csky CPU Bindings
Message-ID: <20180928010312.GA4179@guoren-Inspiron-7460>
References: <cover.1537789736.git.ren_guo@c-sky.com>
 <62098e7d0a7fbdd09f44d7e23333dad258a01bd2.1537789737.git.ren_guo@c-sky.com>
 <20180927164317.GA8427@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180927164317.GA8427@bogus>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 11:43:17AM -0500, Rob Herring wrote:
> On Tue, Sep 25, 2018 at 07:39:21AM +0800, Guo Ren wrote:
> > This patch adds the documentation to describe that how to add cpu nodes in
> > dts for SMP.
> > 
> > Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> > ---
> >  Documentation/devicetree/bindings/csky/cpus.txt | 70 +++++++++++++++++++++++++
> >  1 file changed, 70 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/csky/cpus.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/csky/cpus.txt b/Documentation/devicetree/bindings/csky/cpus.txt
> > new file mode 100644
> > index 0000000..ee3901d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/csky/cpus.txt
> > @@ -0,0 +1,70 @@
> > +==================
> > +C-SKY CPU Bindings
> > +==================
> > +
> > +The device tree allows to describe the layout of CPUs in a system through
> > +the "cpus" node, which in turn contains a number of subnodes (ie "cpu")
> > +defining properties for every cpu.
> > +
> > +Only SMP system need to care about the cpus node and single processor
> > +needn't define cpus node at all.
> 
> We've generally found this is not true. Even for single core, you can 
> have power domains, clocks for DVFS, etc.
Ok, I'll remove it.

> 
> > +
> > +=====================================
> > +cpus and cpu node bindings definition
> > +=====================================
> > +
> > +- cpus node
> > +
> > +        Description: Container of cpu nodes
> > +
> > +        The node name must be "cpus".
> > +
> > +        A cpus node must define the following properties:
> > +
> > +        - #address-cells
> > +                Usage: required
> > +                Value type: <u32>
> > +                Definition: must be set to 1
> > +        - #size-cells
> > +                Usage: required
> > +                Value type: <u32>
> > +                Definition: must be set to 0
> > +
> > +- cpu node
> > +
> > +        Description: Describes one of SMP cores
> > +
> > +        PROPERTIES
> > +
> 
> You need a compatible property for cpu nodes.
Our cpu is defined in defconfig, not in dts. I could put a comatible
property in here, but it's no use in code.
> 
> > +        - device_type
> > +                Usage: required
> > +                Value type: <string>
> > +                Definition: must be "cpu"
> > +        - reg
> > +                Usage: required
> > +                Value type: <u32>
> > +                Definition: CPU index
> > +        - status:
> 
> You don't need to document status here.
ok, remove the status description.

Best Regards
 Guo Ren
