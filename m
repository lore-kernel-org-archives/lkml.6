Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3255968-1522138089-2-8336313056187922171
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522138088; b=MbTetasEeQIGbIyMpwt6jkZhffrB1dYYhjldm5nn9TJav0R
    TjqA8L9vwrvKPo7DSaVsbHFcFY3zv8yrwMuYa5yY5twBMqlVDRrgEtpZj1KZxspF
    AhL5mvp0988M5ISbwgUDzsgOOFJmb9nv81BTjjnLe9xbuk/P8j8cJfdvxZRC4Mcf
    Ygy/m9FO9g5vDtLooJ2GzmtUx7nz/KdwFHrooQ6M/+k0Lb0LP5jVcq8d33sXpr/b
    nOyRMsbA0GaXqTSCMm8aNIVQTyaLHN6Yp/WjDVuMOVF0XqOWYYU512WprKpKXBpW
    9mm7iyeKlgPnm0cBaE+IHSVNxIPrRm0WT7Q27kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1522138088; bh=uUxW+3aKVS0k/dlyCI5ksB8lCh
    dLwaiew4b0xZkTO8o=; b=KQBERxbpWaB3lgOwnh03jx8p9M3a61BWXrT6FAbBc2
    /CKYRoV3cnECaLUZqzxeGtMYQV8lGue3N0zmXGi1dHNp3Aw1O+wR8yTxfQEpp05r
    uSc/chTM0llxILJtimp69+9FHy17/UTgwUvBzywxv35EUrP5c3ePhuOgziTDjH/t
    xUJPzf/ENuVs9fBJi4wDsYnqT8stFXmroov1skkf3gIKUDvuQxQdqZ97sxGr2GH1
    SunhysvShJTQgMM/SseToPHHuIMauZblIFI73TG5yT/u4MlOar4zn4EPD6ajFmHX
    btCioFVTn3iTjYvDKTt75WHJUgKlP4ZLikIY9ssRKofw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCOTTMyd39qjJYCH62VM84Z8QuKVedKtrUlLAJgJt8mL3qkEooo/uiHTGXC7OmtwGAmNiA0kYW0KUlGpyAjOwtIM8XXrJKGFpyMVhCEGPnunVIYGoYm3
    udO7mi7Gd9md9lIw3n973jQiMIBkoEq6luJCws1zho+to2e+mDRJrqM1CCHZUpGgpSsxpnK6Guv3Q1U/XziWRM5e/xsnxfTWuvj2G/2tDYCmi7z4qCt8cojp
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=QyXUC8HyAAAA:8 a=FOH2dFAWAAAA:8 a=lJaEE2mbCS2gwXI7cC8A:9 a=CjuIK1q_8ugA:10
    a=i3VuKzQdj-NEYjvDI-p3:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752159AbeC0IFy (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Mar 2018 04:05:54 -0400
Received: from mga18.intel.com ([134.134.136.126]:58657 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752082AbeC0IFO (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 27 Mar 2018 04:05:14 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,366,1517904000";
   d="scan'208";a="38432196"
Date: Tue, 27 Mar 2018 11:05:02 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Sahil Rihan <srihan@fb.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
        <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm: allow TCPA log area to be empty
Message-ID: <20180327080502.GA11855@linux.intel.com>
References: <20180310161637.7723-1-jarkko.sakkinen@linux.intel.com>
 <20180312150231.GA24717@ziepe.ca>
 <20180316125525.GB5035@linux.intel.com>
 <20180319021323.GD27186@ziepe.ca>
 <20180319212436.GD14364@linux.intel.com>
 <A799BB0A-C44B-41AB-9C38-4B974A50210D@fb.com>
 <edcff887ff133df486812bb5ecadcc101bc1d227.camel@linux.intel.com>
 <49C2A39F-C9ED-4620-82C9-C0919DA3F2CD@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49C2A39F-C9ED-4620-82C9-C0919DA3F2CD@fb.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 27, 2018 at 12:07:14AM +0000, Sahil Rihan wrote:
> > On 3/22/18, 7:20 AM, "Jarkko Sakkinen" <jarkko.sakkinen@linux.intel.com> wrote:
> >
> >   On Tue, 2018-03-20 at 22:29 +0000, Sahil Rihan wrote:
> >   > > On 3/19/18, 2:25 PM, "Jarkko Sakkinen" <jarkko.sakkinen@linux.intel.com>
> >   > > wrote:
> >   > >     
> >   > >    Sahil, would you care to try if this fixes the issue that you are
> >   > >    having or not?
> >   > 
> >   > Yes, we can test this out. Might take a day or two.
> >    
> >   Awesome, thank you. I'll add
> >    
> >   Reported-by: Sahil Rihan <srihan@fb.com>
> >    
> >   if that is OK for you?
> 
> Jarkko, 
> 
> We applied your patch to a 4.11 kernel (unfortunately not the latest upstream) and were able to confirm that the char device is now being created correctly. The sysfs enabled node is also present.
> 
> And yes, please add the "Reported-by" line.
> 
> Thanks,
> Sahil

And also

Tested-by: Sahil Rihan <srihan@fb.com>

?

/Jarkko
