Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA137C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 05:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E4E021721
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 05:55:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E4E021721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=buserror.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbeHHINQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 04:13:16 -0400
Received: from baldur.buserror.net ([165.227.176.147]:54876 "EHLO
        baldur.buserror.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbeHHINP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 04:13:15 -0400
Received: from [2601:449:8400:7293:12bf:48ff:fe84:c9a0]
        by baldur.buserror.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <oss@buserror.net>)
        id 1fnHMl-0007ub-Od; Wed, 08 Aug 2018 00:50:41 -0500
Message-ID: <7526e100693e4db9bb3adf576254b2161086dfe8.camel@buserror.net>
From:   Scott Wood <oss@buserror.net>
To:     Bharat Bhushan <bharat.bhushan@nxp.com>,
        Rob Herring <robh@kernel.org>
Cc:     "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "paulus@samba.org" <paulus@samba.org>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "galak@kernel.crashing.org" <galak@kernel.crashing.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "tyreld@linux.vnet.ibm.com" <tyreld@linux.vnet.ibm.com>,
        "joe@perches.com" <joe@perches.com>
Date:   Wed, 08 Aug 2018 00:50:38 -0500
In-Reply-To: <AM5PR0401MB2545AF363F5DD258205177FC9A260@AM5PR0401MB2545.eurprd04.prod.outlook.com>
References: <1532684881-19310-1-git-send-email-Bharat.Bhushan@nxp.com>
         <1532684881-19310-4-git-send-email-Bharat.Bhushan@nxp.com>
         <20180807180938.GA13623@rob-hp-laptop>
         <a20f27b15161164c829f771d2b085639f6709374.camel@buserror.net>
         <AM5PR0401MB2545AF363F5DD258205177FC9A260@AM5PR0401MB2545.eurprd04.prod.outlook.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2601:449:8400:7293:12bf:48ff:fe84:c9a0
X-SA-Exim-Rcpt-To: bharat.bhushan@nxp.com, robh@kernel.org, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, galak@kernel.crashing.org, mark.rutland@arm.com, kstewart@linuxfoundation.org, gregkh@linuxfoundation.org, devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, keescook@chromium.org, tyreld@linux.vnet.ibm.com, joe@perches.com
X-SA-Exim-Mail-From: oss@buserror.net
Subject: Re: [RFC 3/5] powerpc/mpic: Add support for non-contiguous irq
 ranges
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on baldur.buserror.net)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-08-08 at 03:37 +0000, Bharat Bhushan wrote:
> > -----Original Message-----
> > From: Scott Wood [mailto:oss@buserror.net]
> > Sent: Wednesday, August 8, 2018 2:34 AM
> > To: Rob Herring <robh@kernel.org>; Bharat Bhushan
> > <bharat.bhushan@nxp.com>
> > Cc: benh@kernel.crashing.org; paulus@samba.org; mpe@ellerman.id.au;
> > galak@kernel.crashing.org; mark.rutland@arm.com;
> > kstewart@linuxfoundation.org; gregkh@linuxfoundation.org;
> > devicetree@vger.kernel.org; linuxppc-dev@lists.ozlabs.org; linux-
> > kernel@vger.kernel.org; keescook@chromium.org;
> > tyreld@linux.vnet.ibm.com; joe@perches.com
> > Subject: Re: [RFC 3/5] powerpc/mpic: Add support for non-contiguous irq
> > ranges
> > 
> > On Tue, 2018-08-07 at 12:09 -0600, Rob Herring wrote:
> > > On Fri, Jul 27, 2018 at 03:17:59PM +0530, Bharat Bhushan wrote:
> > > > Freescale MPIC h/w may not support all interrupt sources reported by
> > > > hardware, "last-interrupt-source" or platform. On these platforms a
> > > > misconfigured device tree that assigns one of the reserved
> > > > interrupts leaves a non-functioning system without warning.
> > > 
> > > There are lots of ways to misconfigure DTs. I don't think this is
> > > special and needs a property.
> > 
> > Yeah, the system will be just as non-functioning if you specify a valid-
> > but-
> > wrong-for-the-device interrupt number.
> 
> Some is one additional benefits of this changes, MPIC have reserved regions
> for un-supported interrupts and read/writes to these reserved regions seams
> have no effect.
> MPIC driver reads/writes to the reserved regions during init/uninit and
> save/restore state.
> 
> Let me know if it make sense to have these changes for mentioned reasons.

The driver has been doing this forever with no ill effect.  What is the
motivation for this change?

-Scott

