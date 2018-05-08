Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2680741-1525776980-2-4735441235086981255
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
    1525776979; b=krllD75Xr8VkRxckuudvnbLGPr9i1mGCpvMjlPtk3XLJrvlXbC
    nE5i9yX+K2GepXWEmd0PFK7huKG8duI6d7Y8ESJduoDS/HBf7JSYBi8oKsEAH+yR
    hxvpDFMRXhA1xh8d0Xq2vA5PYWZLWTgZ/SYFO1WGklIsJdVCziRy57sElqXLf51Q
    IcrqzhvHbWDO+GeII244uHhYo+U2TmzNq7pYz0OD23g73PfAsJrFw7RcunaXyJrT
    bQ/R06CPiPD3RxaQiOdkJgy7Hjlb/4zPTmG4YPo5x1R1XEWFcj5O/SCVcCzFbJyQ
    gVdW/DR0P7u+tF+W26a/hHJAS9uTrNfPOSAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525776979; bh=CDfZQzpo4zm3LMqzvIAAIuWohxyqeD
    /Qit83PyptY2k=; b=IcIqqQkLz0kqnDhp17WfqDNIa4ONaEPLaHd9sutz/gL1MB
    c/Cc8wtOgW+Na+yNJjFpRp7R5jwLDVOb8tsGWF/hRYmtAsyzMPXn6rGTZPUoG5LR
    Nbnm846YPtT0DiS79SgCIaPrEWij3YSOvowevY+IXuTtAXjMF3JWVbZyYKJ0rlhf
    FlzhIY+idMisexvSL7CDUfNLabqu/pG4N3WUPt0vH0BscLZ+EZMgSck565faZKrN
    eQ4UCiUi2AjVGqIFhfQWHZfesbQIx7lCo3lZydIMTq7Y/1O0zQttOY7wj7K0X2BI
    uWyKXgVaOmwLgqlu0flDFX02jJPfLf70Ko2tpnDg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfJZUmDBiFLHAUTmkIGW7SVyNMfJwV5vosi4iAKPX8sBgaFCLDOFywsJfCalNi00WeCa6mq5gmxhkJMOTYVPGzjx056IF2aC7+FEILe0IHobZtn2ViTOw
    XfImRlt5q8uX3o2cxwQqFrzev/mTZSDS9ky2DJDkB4knZzanBywOMUIEaLOOMhIBcBJnzIemlUPhYY3QHSoJhgxCgEY06VxAsVrou33iogdOLuJxmrwtbsa3
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=QX4gbG5DAAAA:8 a=cm27Pg_UAAAA:8 a=B-4895p5AAAA:8 a=QyXUC8HyAAAA:8
    a=yPCof4ZbAAAA:8 a=fDCBIwN0dBcAZRRtVgMA:9 a=CjuIK1q_8ugA:10
    a=AbAUZ8qAyYyZVLSsDulk:22 a=xmb-EsYY8bH0VWELuYED:22 a=CvvKU93EpHcLr5xCDv7z:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751270AbeEHK4S (ORCPT <rfc822;greg@kroah.com>);
        Tue, 8 May 2018 06:56:18 -0400
Received: from mga14.intel.com ([192.55.52.115]:26888 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750830AbeEHK4R (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 8 May 2018 06:56:17 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,378,1520924400";
   d="scan'208";a="226714712"
Date: Tue, 8 May 2018 13:56:14 +0300
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
Message-ID: <20180508105614.GC6132@linux.intel.com>
References: <20180502143830.3534-1-jarkko.sakkinen@linux.intel.com>
 <20180502143830.3534-2-jarkko.sakkinen@linux.intel.com>
 <20180505022713.GA29590@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180505022713.GA29590@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 04, 2018 at 07:27:13PM -0700, Greg KH wrote:
> On Wed, May 02, 2018 at 05:38:28PM +0300, Jarkko Sakkinen wrote:
> > From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > 
> > commit b5d0ebc99bf5d0801a5ecbe958caa3d68b8eaee8 upstream
> > 
> > The suspend/resume behavior of the TPM can be controlled by setting
> > "powered-while-suspended" in the DTS. This is useful for the cases
> > when hardware does not power-off the TPM.
> > 
> > Signed-off-by: Sonny Rao <sonnyrao@chromium.org>
> > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > Reviewed-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> > Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > Signed-off-by: James Morris <james.l.morris@oracle.com>
> > ---
> >  drivers/char/tpm/tpm-interface.c | 3 +++
> >  drivers/char/tpm/tpm.h           | 2 ++
> >  drivers/char/tpm/tpm_of.c        | 3 +++
> >  3 files changed, 8 insertions(+)
> > 
> > diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> > index 830d7e30e508..5463b649bdf1 100644
> > --- a/drivers/char/tpm/tpm-interface.c
> > +++ b/drivers/char/tpm/tpm-interface.c
> > @@ -969,6 +969,9 @@ int tpm_pm_suspend(struct device *dev)
> >  	if (chip == NULL)
> >  		return -ENODEV;
> >  
> > +	if (chip->flags & TPM_CHIP_FLAG_ALWAYS_POWERED)
> > +		return 0;
> > +
> >  	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
> >  		tpm2_shutdown(chip, TPM2_SU_STATE);
> >  		return 0;
> > diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> > index aa4299cf7e5a..41756a9e9ad8 100644
> > --- a/drivers/char/tpm/tpm.h
> > +++ b/drivers/char/tpm/tpm.h
> > @@ -143,6 +143,8 @@ enum tpm_chip_flags {
> >  	TPM_CHIP_FLAG_TPM2		= BIT(1),
> >  	TPM_CHIP_FLAG_IRQ		= BIT(2),
> >  	TPM_CHIP_FLAG_VIRTUAL		= BIT(3),
> > +	TPM_CHIP_FLAG_HAVE_TIMEOUTS	= BIT(4),
> > +	TPM_CHIP_FLAG_ALWAYS_POWERED	= BIT(5),
> >  };
> >  
> >  struct tpm_chip {
> > diff --git a/drivers/char/tpm/tpm_of.c b/drivers/char/tpm/tpm_of.c
> > index 570f30c5c5f4..669f4a046398 100644
> > --- a/drivers/char/tpm/tpm_of.c
> > +++ b/drivers/char/tpm/tpm_of.c
> > @@ -37,6 +37,9 @@ int read_log(struct tpm_bios_log *log)
> >  		return -ENODEV;
> >  	}
> >  
> > +	if (of_property_read_bool(np, "powered-while-suspended"))
> > +		chip->flags |= TPM_CHIP_FLAG_ALWAYS_POWERED;
> > +
> 
> This last line here blows up the build, there is no chip variable
> defined in this function :(
> 
> So I have to drop both of these patches, from both 4.4.y and 4.9.y
> queues right now.  Can you fix this up and resend them?
> 
> thanks,
> 
> greg k-h

Yes. Sorry. I'll do that.

/Jarkko
