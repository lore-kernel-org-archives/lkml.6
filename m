Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3711274-1525636331-2-9723950280593137700
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525636331; b=KQugN3gV/k16hBUCd8Qu3mzaVODnnoe72yvhWC48VJfSBVOsG6
    2VCDQgKr5E7/vMxblJ664jTLvIf09yjfayWTf/uIAKzlh9blfVtFvimzM2yzvl/J
    zIjB4V5diVpPFpHE2AgkPBiYQ36l894fh4hbLepDSuFaZNjqtLY4iQn2/gPv87m3
    4e5b9kMoMZeGdldF7brWkJ+0dzFrSDAt7R32iEpfRUIo0b94pbXORSIMYBBeQlUh
    MQKIqA/OtJWzZnde/P5FGBXh1E3rJp0qQzSu46uh7spK+egxnCfGUz2vs5iuckQi
    dXe9NBcEzq3hGwOvIaGA9P4Zw8hv5RoejqUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525636331; bh=xSXw9rXzF/BLq+WJaPpUJ8U3SnSCPT
    R44CVwKe6+P1U=; b=jOViQ1iZuMWwiyDiSB6lheB+LG37ArBSAczOWt7RzauZVE
    a+lq9bTBKPb4BJGUTtml/7uRcD+BOAQk7KfdnYKnZztEVw0Npubn0mca/Q7I74Mr
    k2jutq4KGadqvlq53N9+J8QeXu02Mj64BHdPUz6OSeV3g+ZJUsvQzcoux6Vhq97K
    GEcj85OmEpcyWrBJpKS0LwkGULUaYOtMOPc/3G9PbSe+kELDOusMj4omyR9YLW1C
    j6u7UsgyOVTKwi+oHZ0Z048nv/X9F4cmY7wV02IEKb80upfdpyPoVhym1Gly1OcV
    /YSHMKob4/e6mIMJSIMOmFJ6ZJF9iEi3asCiA91Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJKeQxZ+aaGGH+LL1OPqlc3jp6xMK1n+g7LuSOXbTgJzFDzdcww9iufIsSWTjCzow7rJ/BSprS3E4an0ipZW3UjLeo+sA+sJMpO7KjPCRVvdyo/IvCR3
    j68HUZvGvQUw4SpsoNCkpPInXRkUMG+ONg8PqCQ8fvy6oivhLP9N0vFyv1PfiRDQIEoe9hyd6oOCVApkqsFqc6rGoF3gxicLBa9n7pzeZ67lu4URDURgWPog
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=CjiYaNSMAAAA:8 a=uV0C5a01vGbZ7rSHxHYA:9 a=CjuIK1q_8ugA:10
    a=jFRs6jQBfVEfJ4qOU6Pr:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751847AbeEFTwG (ORCPT <rfc822;greg@kroah.com>);
        Sun, 6 May 2018 15:52:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60966 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751840AbeEFTwG (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 6 May 2018 15:52:06 -0400
Date: Sun, 6 May 2018 22:52:03 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Amit Shah <amit@amitshah.net>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        virtualization@lists.linux-foundation.org, stable@vger.kernel.org,
        Tiwei Bie <tiwei.bie@intel.com>,
        Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 0/6] virtio-console: spec compliance fixes
Message-ID: <20180506225142-mutt-send-email-mst@kernel.org>
References: <1524248223-393618-1-git-send-email-mst@redhat.com>
 <20180424214104-mutt-send-email-mst@kernel.org>
 <20180503034529.GA16676@grmbl.mre>
 <20180503222702-mutt-send-email-mst@kernel.org>
 <20180506182430.GB19628@grmbl.mre>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180506182430.GB19628@grmbl.mre>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, May 06, 2018 at 08:24:30PM +0200, Amit Shah wrote:
> On (Thu) 03 May 2018 [22:28:32], Michael S. Tsirkin wrote:
> > On Thu, May 03, 2018 at 05:45:29AM +0200, Amit Shah wrote:
> > > (apologies if you received a dup)
> > > 
> > > On (Tue) 24 Apr 2018 [21:41:29], Michael S. Tsirkin wrote:
> > > > On Fri, Apr 20, 2018 at 09:17:59PM +0300, Michael S. Tsirkin wrote:
> > > > > Turns out virtio console tries to take a buffer out of an active vq.
> > > > > Works by sheer luck, and is explicitly forbidden by spec.  And while
> > > > > going over it I saw that error handling is also broken -
> > > > > failure is easy to trigger if I force allocations to fail.
> > > > > 
> > > > > Lightly tested.
> > > > 
> > > > Amit - any feedback before I push these patches?
> > > 
> > > The changes look good spec-wise.
> > > 
> > > There are a bunch of tests in avocado-vt that test virtio-console
> > > functionality.  Can you give those a try before pushing?
> > > 
> > > 		Amit
> > 
> > I pushed before I did that test, will try to find the time later.  BTW
> > do you still want to be on the maintainers list?
> 
> Yes, I want to be on the maintainers list; but won't mind
> co-maintainers.  The recent changes seem to be spec-related, and I'd
> expect you to have a good handle on that anyway.
> 
> 		Amit

If you can do extra testing that would be appreciated though.

> -- 
> http://amitshah.net/
