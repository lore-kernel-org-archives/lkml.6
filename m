Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C8DC4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 07:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4899220866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 07:57:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4899220866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbeILNAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 09:00:41 -0400
Received: from gate.crashing.org ([63.228.1.57]:34476 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726358AbeILNAl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 09:00:41 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w8C7uX1A028872;
        Wed, 12 Sep 2018 02:56:34 -0500
Message-ID: <c002018d3765280e135d673f7c731784a90a260d.camel@kernel.crashing.org>
Subject: Re: [PATCH v5 01/10] dt-bindings: fsi: Add P9 OCC device
 documentation
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Rob Herring <robh@kernel.org>,
        Eddie James <eajames@linux.vnet.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, jdelvare@suse.com,
        linux-doc@vger.kernel.org, openbmc@lists.ozlabs.org,
        gregkh@linuxfoundation.org, mark.rutland@arm.com,
        linux@roeck-us.net, joel@jms.id.au
Date:   Wed, 12 Sep 2018 09:56:33 +0200
In-Reply-To: <20180910181610.GA5907@bogus>
References: <1535664761-86018-1-git-send-email-eajames@linux.vnet.ibm.com>
         <1535664761-86018-2-git-send-email-eajames@linux.vnet.ibm.com>
         <20180910181610.GA5907@bogus>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-09-10 at 13:16 -0500, Rob Herring wrote:
> On Thu, Aug 30, 2018 at 04:32:32PM -0500, Eddie James wrote:
> > Document the bindings for the FSI-attached POWER9 On-Chip Controller.
> > 
> > Signed-off-by: Eddie James <eajames@linux.vnet.ibm.com>
> > ---
> >  Documentation/devicetree/bindings/fsi/ibm,p9-occ.txt | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/fsi/ibm,p9-occ.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/fsi/ibm,p9-occ.txt b/Documentation/devicetree/bindings/fsi/ibm,p9-occ.txt
> > new file mode 100644
> > index 0000000..46372f6
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/fsi/ibm,p9-occ.txt
> > @@ -0,0 +1,15 @@
> > +Device-tree bindings for FSI-attached POWER9 On-Chip Controller (OCC)
> > +---------------------------------------------------------------------
> > +
> > +This is the binding for the P9 On-Chip Controller accessed over FSI from a
> > +service processor. See fsi.txt for details on bindings for FSI slave and CFAM
> > +nodes.
> > +
> > +Required properties:
> > + - compatible = "ibm,p9-occ"
> > +
> > +Examples:
> > +
> > +    occ {
> 
> FSI slave devices are supposed to have an address according to the 
> binding doc.

This isn't the FSI device per-se actually. This is a node below the
"sbefifo" FSI device. The SBE fifo is the mechanism by which we
communicate with the OCC. The sbefifo doesn't really define a "bus",
it's mostly used from userspace directly via /dev/sbefifo* to perform
various tasks in the chip, but it happens to also provide the in-kernel 
transport for the OCC commands.

Cheers,
Ben.

> > +        compatible = "ibm,p9-occ";
> > +    };
> > -- 
> > 1.8.3.1
> > 

