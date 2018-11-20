Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD7DC520D3
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 22:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2552121479
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 22:50:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2552121479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbeKUJWG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 04:22:06 -0500
Received: from mga01.intel.com ([192.55.52.88]:19855 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbeKUJWG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 04:22:06 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2018 14:50:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,258,1539673200"; 
   d="scan'208";a="101861107"
Received: from drhumphr-mobl.ger.corp.intel.com (HELO localhost) ([10.249.254.165])
  by orsmga003.jf.intel.com with ESMTP; 20 Nov 2018 14:50:24 -0800
Date:   Wed, 21 Nov 2018 00:50:22 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     "Winkler, Tomas" <tomas.winkler@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        "Struk, Tadeusz" <tadeusz.struk@intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Peter Huewe <peterhuewe@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Microchip (AT91) SoC support" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v9 05/17] tpm: declare struct tpm_header
Message-ID: <20181120225022.GD8391@linux.intel.com>
References: <20181118124753.18613-1-jarkko.sakkinen@linux.intel.com>
 <20181118124753.18613-6-jarkko.sakkinen@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9DA235BB@hasmsx108.ger.corp.intel.com>
 <20181120130805.GD8813@linux.intel.com>
 <20181120160111.GA22023@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120160111.GA22023@ziepe.ca>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 09:01:11AM -0700, Jason Gunthorpe wrote:
> On Tue, Nov 20, 2018 at 03:08:05PM +0200, Jarkko Sakkinen wrote:
> > On Mon, Nov 19, 2018 at 09:33:31PM +0000, Winkler, Tomas wrote:
> > > 
> > > > 
> > > > Decleare struct tpm_header that replaces struct tpm_input_header and
> > > Typo 
> > 
> > Thanks, will fix for the next version.
> > 
> > > > struct tpm_output_header.
> > > > 
> > > > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > > > Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> > > >  drivers/char/tpm/tpm-interface.c  |  9 ++++-----
> > > >  drivers/char/tpm/tpm.h            | 27 ++++++++++++---------------
> > > >  drivers/char/tpm/tpm2-cmd.c       |  4 ++--
> > > >  drivers/char/tpm/tpm2-space.c     |  6 +++---
> > > >  drivers/char/tpm/tpm_i2c_atmel.c  |  5 ++---
> > > > drivers/char/tpm/tpm_vtpm_proxy.c |  8 ++++----
> > > >  drivers/char/tpm/xen-tpmfront.c   |  2 +-
> > > >  7 files changed, 28 insertions(+), 33 deletions(-)
> > > > 
> > > > diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-
> > > > interface.c
> > > > index 7ac6ada8428c..cb0d44c158ae 100644
> > > > +++ b/drivers/char/tpm/tpm-interface.c
> > > > @@ -67,7 +67,7 @@ static int tpm_validate_command(struct tpm_chip
> > > > *chip,
> > > >  				 const u8 *cmd,
> > > >  				 size_t len)
> > > >  {
> > > > -	const struct tpm_input_header *header = (const void *)cmd;
> > > > +	const struct tpm_header *header = (const void *)cmd;
> > > 
> > > 
> > > Sometimes it is casted (void *), sometimes (struct tpm_header *)
> > > Better to use one convention 
> > 
> > I would prefer (const void *) because it is shorter form, and no
> > need to duplicate the type name two times, that way also more
> > readable. Anyway, agreed that we do have inconsistency with these.
> 
> It is better to pass in 'const void *cmd' than to explicitly cast like
> this.
> 
> I generally discourage casts to voids to save typing, just creates
> confusion what is going on. Better to try to avoid casts by
> constructing the code properly.

Definitely. Will change in the next version.

/Jarkko
