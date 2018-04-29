Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-160651-1525045074-2-18233421796817271293
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525045074; b=X+u5Qez8AvG0cAKsDnPN6E011DTcNPO6uvq0/nvRHrQJS9xh/h
    x24T5RlmlM/OKRH+2AFrK/a0i7Dzzm4OJSfYKi5BU/JRAK7jeH7iyBZXUGrxAvON
    y3+1qMLF+E/yyXbccRR769Yj3SBNqEtcuyMq0B7WIvTPLxjm9m1aKoyt+fzQGxfE
    tZaunvWTuLFvoGb8JlMoaxH02FpErmbi3rPWTnZQ9wCgR0gIEbugiRFsNADHY8PA
    3BGFitYmf3nWZ9JjJyMclXyJSEz1zbybgjyh05KFXoaAI+nFcpbqc3cJV5lK83m+
    qK/n2htpuTCXIRYXLLeuYDcO2PHMiCZMp9Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525045074; bh=bZXimSPHN+yEGPYFkVVly7G31eUOns
    a6POepbVZ3esU=; b=CUP7lZWLYdQks+7Jnh+oV0mjiMenJNG/qBrmZCnFtcoJCg
    FCZZ/sL9vu4sp2r77h8YCLwKtHWQoFwXQ67leEo/PjYZYHs4k9Ka6dzh2qEXlVvE
    x1GK9BJJ7n2A0lYYSSiUVxF5LNAHTLrv+KisoiKEYbvS/P9deM+l7Z5kLDTSUxZa
    +MgAlp7Xo0fN7tPipkB9qwDXkzc6OuKUL4bvHz8YqDX2CxDFbzPJ0kMp0eiknhvk
    aItF9Z7rf6IUjoVVQatekgPGONJWR27LIA/E7CZCFU/qII27MELRr/rpAasXma0D
    5UlqOGO5knNb/z8uRJj6axaHVDT5fpsseH9LGH3w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKdWgMc/buHN/mkEvhxeVbE35B2R9pWCjCtUKpVpPfBhStWGuebZ8+e/bJAfoJDnUu3a+xKJjXU4tJjWlY5cwzvb3fnLcFgNvJHHFbPCw8rkTQ5jc+AG
    OMKhQ+87D/EMH39guc4IKOA/MtIqgSwEqRcUAt1CNk/6w5RW+AoGt+TiVtLaYl68AXc7H66k2gTyLsSXiY9WzbD+R2odL5cpfnhwb3uSfOQAw0QLHXT68rpM
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=z76SeAi5K9KEeLbK3GEA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754400AbeD2Xhr (ORCPT <rfc822;linux@kroah.com>);
        Sun, 29 Apr 2018 19:37:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:48510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754164AbeD2Xhr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 29 Apr 2018 19:37:47 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70141229FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
Date: Sun, 29 Apr 2018 16:37:37 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Ondrej Zary <linux@rainbow-software.org>
Cc: Pavel Machek <pavel@ucw.cz>, Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Moving unmaintained filesystems to staging
Message-ID: <20180429233737.GD16033@kroah.com>
References: <20180425154602.GA8546@bombadil.infradead.org>
 <20180426061108.GB4977@amd>
 <20180429120705.GA18149@kroah.com>
 <201804292207.26775.linux@rainbow-software.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201804292207.26775.linux@rainbow-software.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Apr 29, 2018 at 10:07:26PM +0200, Ondrej Zary wrote:
> On Sunday 29 April 2018 14:07:05 Greg KH wrote:
> > On Thu, Apr 26, 2018 at 08:11:08AM +0200, Pavel Machek wrote:
> > > On Wed 2018-04-25 08:46:02, Matthew Wilcox wrote:
> > > > Recently ncpfs got moved to staging.  Also recently, we had some fuzzer
> > > > developers report bugs in hfs, which they deem a security hole because
> > > > Ubuntu attempts to automount an inserted USB device as hfs.
> > >
> > > We promise "no-regressions" for code in main repository, no such
> > > promise for staging. We have quite a lot of code without maintainer.
> > >
> > > Moving code to staging means it will get broken -- staging was not
> > > designed for this. I believe moving anything there is bad idea.
> > >
> > > Staging is for ugly code, not for code that needs new maintainter.
> >
> > Staging is used for getting code _out_ of the kernel tree as well as
> > _in_.  We use it all the time to move code there, see if anyone shows up
> > in 6-8 months to say "I will fix this!", and if not, we delete it.
> >
> > Look at what just happened to IRDA in the 4.17-rc1 release as an example
> > of this.
> 
> Really a "great" example of deleting working code :( 

What do you mean?  The irda code was broken and not working at all.
There were loads of bug reports about it for years, with no developers
or maintainers willing to do the work on it to get it to actually work
again.

If someone does want to step up and do it, great!  It's a simple revert
of two git commits and they are back in business.

Dropping code from the tree is not like it is gone for forever.  If
someone wants to pick it up, it is trivial to do so.  Git is good :)

thanks,

greg k-h
