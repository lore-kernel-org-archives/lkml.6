Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-507227-1525252743-2-17516793651474903641
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525252742; b=KAcOeZXXZbs5bmt+xsM7rWuCwvoFbLf5m2UKKfUUae9owP6D+N
    39P7nV0dtNhWG88mrcJ8TQ5qgt9ct3/3Yut2H4ArnpnZY9WX9vOSHObr1AD/YxlL
    BKf8MKnpHeF0iG+p0NcELSWjYRRjT1F9MxCLZ+jDZ+E5mfHW77x7VR8CfwL19Mv+
    W5HxbfX8aZz/eql8aIRnvxSpEABHGBKwhooh5tirZ+bmfeI3J3CEZnCtDNfOVzi3
    yzGUFvjLd1EB1Rvlf46CXC8liTMhE2EQ2Un3dyZrKPOSz+t44y9lXymPfUQgBQQk
    XPD4od6jFMp/21WTiR8vrqlhTKfehBrq3hXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525252742; bh=TRPDf1wB/fCBKQQdgBK1CX3sK7J4+M
    L/tz5+XS4sKfQ=; b=HU65tXbv04mH22R8nhkalOAp94cjmsyiaDsTtGm7oILqBb
    3E9sKPmlb4J6BfH9+PrDui7vpcIxOJt1BUMzS7ki0f1smsBR/E1Mg9PQBPRO/U19
    7swyWI+GQryQbxvkAZUkSvLvyDctrZUMt1z0fQfuN4W6hbzkdR2djyS0V9+iYG8M
    Bfj0tiUOGsnRuL7T+nN16DwxvoZM0Y2ENVeE/ndT45X9gg9zcyZ34gKHCyyqy+Ak
    30TKkaiCgxZ5gTs9ceQQDMaLD+tbb705R1hiDlKEF4ceXxn8G+B1V/X7+dQQX+Fv
    wsXUvqsOEbx9ODSszgQk/dXESsRte5U1VOiNEM9A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=tcoyG8oW x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=gcqVLkhM;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=tcoyG8oW x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=gcqVLkhM;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJcMQqwd9eiQUEQCU2Z9fDMs0MeMG0f0JJxzzt1/16OtkcnUP9Vto6bV0rZDrFge5t3pDp0dr5YSQ59K0++YhPSXXFlMWkMR4Q+1eHysVUT19STwwtFt
    ywJL3dqukbztURye0GaGpC8yFx8bYKSAa+M6K0yOvzgQCKbr1xYHsE4tlCzy27Tkqlqy4iIVteka8Eift/+1zbJ592SrzuffiRhR0F+h2Bd5zms24OPl+Z3A
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=NufY4J3AAAAA:8 a=7CQSdrXTAAAA:8 a=gu6fZOg2AAAA:8 a=VwQbUJbxAAAA:8
    a=j2H2_Y7vzagRUbi5lnUA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10 a=-FEs8UIgK8oA:10
    a=NWVoK91CQyQA:10 a=TPcZfFuj8SYsoCJAFAiX:22 a=a-qgeE7W1pNrGK8U0ZQC:22
    a=2RSlZUUhi9gRBrsHwhhZ:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751109AbeEBJS6 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 2 May 2018 05:18:58 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:39628 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751100AbeEBJS4 (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 2 May 2018 05:18:56 -0400
X-Google-Smtp-Source: AB8JxZqE0V8RYbGSiDXwsisVhdCKcn+GanCZEnasc7xGs+JfXcKLnFmTps70pyBCr0IqcgEWapJMFQ==
Date: Wed, 2 May 2018 11:18:51 +0200
From: Domenico Andreoli <domenico.andreoli@linux.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Mathias Nyman <mathias.nyman@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Bockholdt Arne <a.bockholdt@precitec-optronik.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Regression due to "Workaround for uPD72020x USB3 chips"
Message-ID: <20180502091851.vr64q7atvd2tovpy@localhost>
References: <20180502080631.sriwquzcky6t24c2@localhost>
 <CAKv+Gu_rgLs2CP4Lpx=CwgmCsEm01sbn9vPzZ4z4JqVaFBtC+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu_rgLs2CP4Lpx=CwgmCsEm01sbn9vPzZ4z4JqVaFBtC+g@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 02, 2018 at 10:22:05AM +0200, Ard Biesheuvel wrote:
> On 2 May 2018 at 10:06, Domenico Andreoli <domenico.andreoli@linux.com> wrote:
> > Dear all,
> >
> >   my home machine stopped to boot starting from kernel version 4.12.7.
> >
> > The last message I read is about resetting some USB3 bus. It's 100%
> > reproducible also with any recent kernel up to 4.17.0-rc3.
> >
> > I bisected down to the following commit:
> >
> > commit 0e1f0eaed6c20db41ff61e024b361ee3ec9d686c (tag: my_broken_xhci)
> > Author: Marc Zyngier <marc.zyngier@arm.com>
> > Date:   Tue Aug 1 20:11:08 2017 -0500
> >
> >     xhci: Reset Renesas uPD72020x USB controller for 32-bit DMA issue
> >
> 
> Hello Domenico,

Sir..

> 
> Long time no see :-)

Instead I see you pretty much everywhere :P

> 
> Please refer to the following thread
> 
> https://marc.info/?l=linux-usb&m=151872295419486
> 
> for some discussion on this topic, and a possible workaround.

Interesting, thanks for the pointer!

I'm happy to learn I've this nice piece of HW in my machine. It might
have at least some other issue while trying to hibernate (there is a
fair chance for it to abort the process because of some "business").

I tried the usb/uPD720202-reset branch from Marc (with some massaging
due to quirks now being >32) and my system boots again. I think it's
more because of the PCI reset is removed, I am not affected by the
original issue it was meant to fix.

> 
> Regards,
> Ard.

thanks,
Dom

-- 
3B10 0CA1 8674 ACBA B4FE  FCD2 CE5B CF17 9960 DE13
