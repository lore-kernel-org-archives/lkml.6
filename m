Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E759EC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 05:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9702221719
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 05:58:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9702221719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=buserror.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbeHHIQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 04:16:01 -0400
Received: from baldur.buserror.net ([165.227.176.147]:54914 "EHLO
        baldur.buserror.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbeHHIQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 04:16:01 -0400
Received: from [2601:449:8400:7293:12bf:48ff:fe84:c9a0]
        by baldur.buserror.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <oss@buserror.net>)
        id 1fnHRa-0007vR-Gb; Wed, 08 Aug 2018 00:55:39 -0500
Message-ID: <aeff83355ee5235cfd6107dba06a5f7957b45c92.camel@buserror.net>
From:   Scott Wood <oss@buserror.net>
To:     Bharat Bhushan <bharat.bhushan@nxp.com>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "paulus@samba.org" <paulus@samba.org>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "galak@kernel.crashing.org" <galak@kernel.crashing.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "robh@kernel.org" <robh@kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "tyreld@linux.vnet.ibm.com" <tyreld@linux.vnet.ibm.com>,
        "joe@perches.com" <joe@perches.com>
Date:   Wed, 08 Aug 2018 00:55:37 -0500
In-Reply-To: <AM5PR0401MB254592DC0E917FD292B323BA9A260@AM5PR0401MB2545.eurprd04.prod.outlook.com>
References: <1532684881-19310-1-git-send-email-Bharat.Bhushan@nxp.com>
         <1532684881-19310-6-git-send-email-Bharat.Bhushan@nxp.com>
         <ab2a113620123cb71364b6ae89328ae2fca49821.camel@buserror.net>
         <AM5PR0401MB254592DC0E917FD292B323BA9A260@AM5PR0401MB2545.eurprd04.prod.outlook.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2601:449:8400:7293:12bf:48ff:fe84:c9a0
X-SA-Exim-Rcpt-To: bharat.bhushan@nxp.com, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, galak@kernel.crashing.org, mark.rutland@arm.com, kstewart@linuxfoundation.org, gregkh@linuxfoundation.org, devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, robh@kernel.org, keescook@chromium.org, tyreld@linux.vnet.ibm.com, joe@perches.com
X-SA-Exim-Mail-From: oss@buserror.net
Subject: Re: [RFC 5/5] powerpc/fsl: Add supported-irq-ranges for P2020
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on baldur.buserror.net)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-08-08 at 03:44 +0000, Bharat Bhushan wrote:
> > -----Original Message-----
> > From: Scott Wood [mailto:oss@buserror.net]
> > Sent: Wednesday, August 8, 2018 2:44 AM
> > To: Bharat Bhushan <bharat.bhushan@nxp.com>;
> > benh@kernel.crashing.org; paulus@samba.org; mpe@ellerman.id.au;
> > galak@kernel.crashing.org; mark.rutland@arm.com;
> > kstewart@linuxfoundation.org; gregkh@linuxfoundation.org;
> > devicetree@vger.kernel.org; linuxppc-dev@lists.ozlabs.org; linux-
> > kernel@vger.kernel.org
> > Cc: robh@kernel.org; keescook@chromium.org; tyreld@linux.vnet.ibm.com;
> > joe@perches.com
> > Subject: Re: [RFC 5/5] powerpc/fsl: Add supported-irq-ranges for P2020
> > 
> > On Fri, 2018-07-27 at 15:18 +0530, Bharat Bhushan wrote:
> > > MPIC on NXP (Freescale) P2020 supports following irq
> > > ranges:
> > >   > 0 - 11      (External interrupt)
> > >   > 16 - 79     (Internal interrupt)
> > >   > 176 - 183   (Messaging interrupt)
> > >   > 224 - 231   (Shared message signaled interrupt)
> > 
> > Why don't you convert to the 4-cell interrupt specifiers that make dealing
> > with these ranges less error-prone?
> 
> Ok , will do if we agree to have this series as per comment on other patch.

If you're concerned with errors, this would be a good things to do regardless.
 Actually, it seems that p2020si-post.dtsi already uses 4-cell interrupts.

What is motivating this patchset?  Is there something wrong in the existing
dts files?


> 
> > 
> > > diff --git a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
> > > b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
> > > index 1006950..49ff348 100644
> > > --- a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
> > > +++ b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
> > > @@ -57,6 +57,11 @@ void __init mpc85xx_rdb_pic_init(void)
> > >  			MPIC_BIG_ENDIAN |
> > >  			MPIC_SINGLE_DEST_CPU,
> > >  			0, 256, " OpenPIC  ");
> > > +	} else if (of_machine_is_compatible("fsl,P2020RDB-PC")) {
> > > +		mpic = mpic_alloc(NULL, 0,
> > > +		  MPIC_BIG_ENDIAN |
> > > +		  MPIC_SINGLE_DEST_CPU,
> > > +		  0, 0, " OpenPIC  ");
> > >  	} else {
> > >  		mpic = mpic_alloc(NULL, 0,
> > >  		  MPIC_BIG_ENDIAN |
> > 
> > I don't think we want to grow a list of every single revision of every
> > board in
> > these platform files.
> 
> One other confusing observation I have is that "irq_count" from platform
> code is given precedence over "last-interrupt-source" in device-tree.
> Should not device-tree should have precedence otherwise there is no point
> using " last-interrupt-source" if platform code passes "irq_count" in
> mpic_alloc().

Maybe, though I don't think it matters much given that last-interrupt-source
was only added to avoid having to pass irq_count in platform code.

-Scott

