Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2970238-1522265049-2-13161101246141778200
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522265049; b=jf4YXSVcocE+K45QyrXOwN2Vly9nBJKCY+HjVwW9cmgm0Ar
    eov5rIVr9rPapggNTdYyv86iDQJv/3FBpTxba3rXxcIoB6A89DdY0YEi4YvCn5PT
    mWhEfVV3cpWLnHTPYoSGKIBmdjjTCKmklMYyVNt3yFR9KrPM6tDjxPEGqAYHTHTY
    Vb8to9gMJYiq1CereoqrL0A8i+1b7REqLK9NtafDXFmzfNLz1D3gpATnTthYok7O
    NRJZ3j+pvSX7pMdr/ftA94qJ4ZnFokHqHOwb6fb7FCXXukG1Q7/sExID8NxARMkp
    eIEdqg6FO6zUSTSO2QbWH9sWXfunbZaw0/ydcFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1522265049; bh=zKVNPGEPgwRRRJE0woTngjXzWI
    +55gl8gYNbPLrCB8Y=; b=Nk/zf/cOWY3l97SYP0E7aKx6Qawvlv+Tu9JpaidqCD
    enIpn86wSFVZ/xeqru79MEFfg25JyrlPFM+VYD3LMtGK0hXoe8I6OfR5RXrUmpuv
    RB3XU/afipZBzLHF6bdP5dtZB5+sICqGu+9ILHTGaDUs0s+YAyJbOIlHQGcmrpPw
    o5aqfeS00OrdzEM907EoI5YsRL8lClnWip5ssAOHyZT5Mo3DRPW07SR5iaiG1rm/
    kpkWK1TG16ex2f0RD0dR78KR3hsQ0KhEcpD2WGrpliLyJuo9mJTxPIKarRpKOrF2
    fF7jCBxIGycYMBVRGUCXaLX47dQjM4DiECi3DcFJjtFg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHJyCiW6/Zlw/p/z6oS1C3Y1KFDoBEyy0jhb+/pLYsbrIOg0StG0Cfdu778T1/i5pciynMsYrw65JRRv4fGfDRAfqXn3wjSHv8NYEN3qTiR+xwlbLSDK
    8W0NgHTAInGIlLwe0DoNf7m6PjFGwB9uETQNufnO1LLJmtYQsL9HblzFT8IX1xL56eEuwyPlDNGzY//J86M20aL9L5odSPNuSJSKsq6Pgd7TnIljQrTvPWux
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=ONKqiAgnDjwA:10
    a=v2DPQv5-lfwA:10 a=7_swigKaUICrRDDr_P8A:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752479AbeC1TYI (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 15:24:08 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46566 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752447AbeC1TYH (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Mar 2018 15:24:07 -0400
Date: Wed, 28 Mar 2018 21:24:03 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org, Anders Roxell <anders.roxell@linaro.org>
Subject: Re: [PATCH 4.9 00/67] 4.9.91-stable review
Message-ID: <20180328192403.GB1404@kroah.com>
References: <20180327162726.702411083@linuxfoundation.org>
 <20180328013501.vdeqlxn525m4cex6@xps>
 <20180328082145.GB14201@kroah.com>
 <20180328155035.i2grmx6imfha6pdw@xps>
 <20180328162104.GC9211@kroah.com>
 <20180328182828.ffbl6r3gifyvmzio@xps>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180328182828.ffbl6r3gifyvmzio@xps>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 28, 2018 at 01:28:28PM -0500, Dan Rue wrote:
> On Wed, Mar 28, 2018 at 06:21:04PM +0200, Greg Kroah-Hartman wrote:
> > On Wed, Mar 28, 2018 at 10:50:35AM -0500, Dan Rue wrote:
> > > On Wed, Mar 28, 2018 at 10:21:45AM +0200, Greg Kroah-Hartman wrote:
> > > > On Tue, Mar 27, 2018 at 08:35:01PM -0500, Dan Rue wrote:
> > > > > qemu_x86_64
> > > > > * boot - pass: 21
> > > > > * kselftest - skip: 28, pass: 52
> > > > 
> > > > Do you have a list of what you are skipping anywhere?  There was some
> > > > x86 changes that I had to backport that I was worried about getting
> > > > right here, are you running the x86 kselftests?
> > > 
> > > Yes we run the x86 selftests. Here's the full list of what ran and what was
> > > skipped. Remember (I know you know, but for anyone else observing), we
> > > run kselftest from 4.15.
> > 
> > That's good, as kselftest from 4.9 was a bit broken for x86, which is
> > why I backported a bunch of patches for it for this release :)
> 
> I've noticed these backports. Should we expect to see selftests
> supported in LTS kernels going forward? What is the current policy on
> taking selftest backports?

I applied patches that prevented the x86 patches from even being built
on a modern system (i.e. my laptop).  I didn't add any new
functionality, I just wanted to verify that there were no regressions,
which is hard to do when the tests do not build.

As for what to run, yes, use the latest possible seems like the best
solution so far.

thanks,

greg k-h
