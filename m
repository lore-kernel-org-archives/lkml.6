Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-330712-1525866781-2-16436104663775815131
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525866780; b=Qz6sGtNDf0bXdg5/myCV/3xvtH0EGKuHIFk9DJQKqUtZabUq66
    PnAy3yct0BMs2SZuHHp0r8hE7g2Jt0Y6OLBNLDeSk/7CcUDgqthZNpMnfJ5IcsGW
    OgwxQsr3PH3CfEKXY1qLB6bFC/QedAJ2f01r43Oyt0CNem8h2XVyNUF9Zx2RJTHB
    oaHheKTMm3Ylv3oNLGKuwTrhSf0geCgBxAwVoJCmmkVXaGTa7wDZvC46HZ6v9bsO
    G+qml8QUbMoFHS52JmgaWv89GzUWzs4cS57QV65QfkCAak71xti/b5T6T6z/GCEe
    yjg68RDjQSroa//31pt5WitLsdh9EgAQlVWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525866780; bh=/jHL3ibFqDJrMRlUxo91rmIY3+qEMq
    VeEdcltrgy0N4=; b=kx9bmXxQAEoIs0WLitNUZ6slVVXQfE5aiCnZ8YKqMWKBXK
    TVTx+xy5CIAkQ9uq3YzwVUTYrlsGn46nxd0nF936ulcTSLkgPzBQ/M0F8byoaiec
    dxgCC/i6wp1dvaqtix4XbDj5whGO54261L9h2t9ZFVbv6L0Jr4cbx2x5Tb6zCwJq
    y+NpT36XYfuGOqAbYrPHF8QN/hPh+2oJGm4XT4OUPR3jjb+bFo+crTg/QAz+SEGM
    moeIEbjpv+TFncNOYVYghJUpnXYAmipH8ah0SoTra7XXidPH/ffKiBNEEoc6vyH9
    xScDXh0keTzdqkK4QWdsICHRptLofLKl5BRF+sLQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux.intel.com header.result=pass
    header_org.domain=intel.com header_org.result=pass
    header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux.intel.com header.result=pass
      header_org.domain=intel.com header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJDzpG0pYPYsagg8i7xNYuKeCVsoaAJZWA+OG5PZ+u6VaIOUMNEYH3a7EyjWzcdrL21v7fOMY5/Y9Etn8gZWAYL/6hgXMmxPyQad9pet/ANK94RFHX5U
    9hj2WseTuCAq2AC2w8Baw7rZ1X7m7lniDWXhgO+f/D2ACrascWNo2xNKCAsbxCllGximqGBBWVLeRDVkTxfxn2KEQVAh838mL4jaQBgIpBLmEU8wCZBbfeW7
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=QX4gbG5DAAAA:8 a=cm27Pg_UAAAA:8 a=B-4895p5AAAA:8 a=QyXUC8HyAAAA:8
    a=yPCof4ZbAAAA:8 a=ZPjuJL22Sifp8wjlZXcA:9 a=CjuIK1q_8ugA:10
    a=AbAUZ8qAyYyZVLSsDulk:22 a=xmb-EsYY8bH0VWELuYED:22 a=CvvKU93EpHcLr5xCDv7z:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934614AbeEILww (ORCPT <rfc822;greg@kroah.com>);
        Wed, 9 May 2018 07:52:52 -0400
Received: from mga05.intel.com ([192.55.52.43]:10095 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934581AbeEILwu (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 9 May 2018 07:52:50 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,381,1520924400";
   d="scan'208";a="53692465"
Date: Wed, 9 May 2018 14:52:43 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Sonny Rao <sonnyrao@chromium.org>,
        James Morris <james.l.morris@oracle.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Marcel Selhorst <tpmdd@selhorst.net>,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        "moderated list:TPM DEVICE DRIVER"
        <tpmdd-devel@lists.sourceforge.net>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] tpm: do not suspend/resume if power stays on
Message-ID: <20180509115243.GA4062@linux.intel.com>
References: <20180502143830.3534-1-jarkko.sakkinen@linux.intel.com>
 <20180502143830.3534-2-jarkko.sakkinen@linux.intel.com>
 <20180505022713.GA29590@kroah.com>
 <20180508105614.GC6132@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180508105614.GC6132@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 08, 2018 at 01:56:14PM +0300, Jarkko Sakkinen wrote:
> On Fri, May 04, 2018 at 07:27:13PM -0700, Greg KH wrote:
> > On Wed, May 02, 2018 at 05:38:28PM +0300, Jarkko Sakkinen wrote:
> > > From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > > 
> > > commit b5d0ebc99bf5d0801a5ecbe958caa3d68b8eaee8 upstream
> > > 
> > > The suspend/resume behavior of the TPM can be controlled by setting
> > > "powered-while-suspended" in the DTS. This is useful for the cases
> > > when hardware does not power-off the TPM.
> > > 
> > > Signed-off-by: Sonny Rao <sonnyrao@chromium.org>
> > > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > > Reviewed-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> > > Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > > Signed-off-by: James Morris <james.l.morris@oracle.com>
> > > ---
> > >  drivers/char/tpm/tpm-interface.c | 3 +++
> > >  drivers/char/tpm/tpm.h           | 2 ++
> > >  drivers/char/tpm/tpm_of.c        | 3 +++
> > >  3 files changed, 8 insertions(+)
> > > 
> > > diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> > > index 830d7e30e508..5463b649bdf1 100644
> > > --- a/drivers/char/tpm/tpm-interface.c
> > > +++ b/drivers/char/tpm/tpm-interface.c
> > > @@ -969,6 +969,9 @@ int tpm_pm_suspend(struct device *dev)
> > >  	if (chip == NULL)
> > >  		return -ENODEV;
> > >  
> > > +	if (chip->flags & TPM_CHIP_FLAG_ALWAYS_POWERED)
> > > +		return 0;
> > > +
> > >  	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
> > >  		tpm2_shutdown(chip, TPM2_SU_STATE);
> > >  		return 0;
> > > diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> > > index aa4299cf7e5a..41756a9e9ad8 100644
> > > --- a/drivers/char/tpm/tpm.h
> > > +++ b/drivers/char/tpm/tpm.h
> > > @@ -143,6 +143,8 @@ enum tpm_chip_flags {
> > >  	TPM_CHIP_FLAG_TPM2		= BIT(1),
> > >  	TPM_CHIP_FLAG_IRQ		= BIT(2),
> > >  	TPM_CHIP_FLAG_VIRTUAL		= BIT(3),
> > > +	TPM_CHIP_FLAG_HAVE_TIMEOUTS	= BIT(4),
> > > +	TPM_CHIP_FLAG_ALWAYS_POWERED	= BIT(5),
> > >  };
> > >  
> > >  struct tpm_chip {
> > > diff --git a/drivers/char/tpm/tpm_of.c b/drivers/char/tpm/tpm_of.c
> > > index 570f30c5c5f4..669f4a046398 100644
> > > --- a/drivers/char/tpm/tpm_of.c
> > > +++ b/drivers/char/tpm/tpm_of.c
> > > @@ -37,6 +37,9 @@ int read_log(struct tpm_bios_log *log)
> > >  		return -ENODEV;
> > >  	}
> > >  
> > > +	if (of_property_read_bool(np, "powered-while-suspended"))
> > > +		chip->flags |= TPM_CHIP_FLAG_ALWAYS_POWERED;
> > > +
> > 
> > This last line here blows up the build, there is no chip variable
> > defined in this function :(
> > 
> > So I have to drop both of these patches, from both 4.4.y and 4.9.y
> > queues right now.  Can you fix this up and resend them?
> > 
> > thanks,
> > 
> > greg k-h
> 
> Yes. Sorry. I'll do that.
> 
> /Jarkko

... obviously should have compiled PPC kernel :-/

/Jarkko
