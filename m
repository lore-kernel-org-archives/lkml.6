Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2132656-1518717744-2-7780279248913141009
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518717744; b=rh97cyXfQCxxzw38Mtm6A2/ryBiFj1jVM4F66oiY1TIX0/M
    rxy9dhVHTeCHwm/29byilt41WOs+IqQViHYACsc5vnVbrTJTMR0VKrK5QK/hIH07
    jZSgSpxSoPo4uoJOJoTkErto/YyGRnWqV8LVBI2XGcu+pAiC06hI4bzDcDFdp6ru
    120N7q1mwlh/cPMUvPekjFkvgaT/UjVoYSYZnVC8OzCu7/9SBhM6ue0oE+0MwN/T
    sTnzuJK6Vqiri5E0CXQSRyoE1BXn/WHXhS3UMO7FUnRFZ/IlMTv2RUXnnrSJJRyP
    OqPMoIr2z0lBorIsdf0dpue2HrXVbVQ/migyxAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1518717744; bh=nAttDBut/78rLj75vHQyhmuOkK
    alDT/XZKpaHp5R6Tc=; b=AjlF2S8DDbNy2r0ldV3x4Qb0hkT/FqQDh1Kg0RLF+3
    s7TomjNQOaxPD2ttOCc5KzFpdx9nmOUmzs/tj03NQH/BhQ3ab2YsYRh7q4OVi/37
    2L42v18Myb4SuQy/IHTW8hq6EATxhLlJ6+inYlvaK4efPgwnnw3RjQyOev4WDSfN
    DFKDfIVin2I+RBza4Zf5ghWqGgIfYwweKh4bAkJIm5C/R1YGJEH/vTzRUnmLETcx
    5ysoL4wzFxY/X62GpZV10CZszgSbwiGAKhFMmEcn6v+C7dsUCgqH+RaxUIoIWrWm
    vN8t0iGGSE3/fwnra8w4OhQEbvnMw7xllbkppEuHgmFQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1166008AbeBOSCJ (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 13:02:09 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:55296 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1165818AbeBOSCG (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 15 Feb 2018 13:02:06 -0500
Date: Thu, 15 Feb 2018 19:02:05 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jack <jackstocker.93@gmail.com>
Cc: Felipe Balbi <felipe.balbi@linux.intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        Dmitry Fleytman <dmitry@daynix.com>,
        Devin Heitmueller <dheitmueller@kernellabs.com>,
        Sandeep Singh <sandeep.singh@amd.com>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] Add delay-init quirk for Corsair K70 RGB keyboards
Message-ID: <20180215180205.GA15170@kroah.com>
References: <AE53BCA5-F49A-41ED-B6F4-1B5FF8B4391F@canonical.com>
 <1517763059-9334-1-git-send-email-jackstocker.93@gmail.com>
 <20180215173500.GA11409@kroah.com>
 <5ffac152-c7e8-357f-9fee-c255d7947ecc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ffac152-c7e8-357f-9fee-c255d7947ecc@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 15, 2018 at 05:59:34PM +0000, Jack wrote:
> On 15/02/18 17:35, Greg Kroah-Hartman wrote:
> > On Sun, Feb 04, 2018 at 04:50:58PM +0000, JackStocker wrote:
> > > Following on from this patch: https://lkml.org/lkml/2017/11/3/516,
> > > Corsair K70 RGB keyboards also require the DELAY_INIT quirk to
> > > start correctly at boot.
> > > 
> > > Device ids found here:
> > > usb 3-3: New USB device found, idVendor=1b1c, idProduct=1b13
> > > usb 3-3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> > > usb 3-3: Product: Corsair K70 RGB Gaming Keyboard
> > > 
> > > Signed-off-by: JackStocker <jackstocker.93@gmail.com>
> > I need a "real" name here please.
> > 
> > thanks,
> > 
> > greg k-h
> As in 'Jack Stocker' is that correct?

If that is how you sign legal documents, yes :)

thanks,

greg k-h
