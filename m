Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1803940-1525319137-2-641734680884687108
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='net', MailFrom='org', XOriginatingCountry='NL'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525319137; b=aBIZARBJiAJ6kzoXwPykitWYykaBVnfmztklf1m0yhRxHTpU53
    oQxr+R0hdgtQJ9SZK5/RDeHSkA4hO/a9rALgxgOOvCZAcJQFM4j0YghXIfEWuawn
    oGOsHJWmEl6I+3p6q4DXIK+sTrktfAz2mYamE940t2GH2qtwU5+4xn42KSylwNxn
    RBChUn2UV1H0snbixzkfDr0yh/GlC2jecFJ2/cOeLC/1fCZyx7K2SnzhJnSeoAXj
    Sa/1yj9RNoyYCrjounbs7hFdwI6VGnKZhc+0Tk2bTVzXm/sL7diAqBjEqFJDF1iD
    H/xozhcK7OQgIIL477xD61DZsPpcWGzYearA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525319137; bh=RtR0jtyFGB7vFWY6WRZrdG5+jyOlLv
    Vmu88spWhyLJo=; b=B0C5433/Q+ti5nYzyKqyODTycJ68qHXP+jOKVRS5aGkke9
    /vqM9NuSADo8i9r1l8HOmLIDQ+cIooMre8mgMECd1+r5DZg4rpZTMuVuvKUI4/DZ
    ZvZCrJYRnMFaIgAD3yjms16AVJEH+fU5oYT+aEbrG7qPAZmeUXfoQy5XGG0VMOuu
    xmWoH4lRHvcClgemvPqH5SjvYNZ2fzqbtrGj4ASvWgSD+08orNFtYd8APcQVqmgX
    FNLThQjB9PvKJkEVu75KqQsIuLgk0WUj6oaR+atXXGjduldmLnfvoZCcsmb8PZQM
    aTKUcvJofZkPI2VJZG9eonTKmQOGB4Ks35zDGvRw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=amitshah.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=amitshah.net header.result=pass
    header_is_org_domain=yes;
    x-vs=phishing score=200 state=101
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=amitshah.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=amitshah.net header.result=pass
      header_is_org_domain=yes;
    x-vs=phishing score=200 state=101
X-ME-VSCategory: phishing
X-CM-Envelope: MS4wfG9xg+kZGLz07Bpmo8LN20WxAv5arqCFsP89624v5wgSf9uLnbNywsL0DvWXnskkTMMSjaRJSN44IJctK3Kr/Bgda4pN6rJHTLMzXzv1Cme6m90yOjQR
    7kcw2mCWiDlaHErFQ+IXLViAl70isiwJHtB+ICwqdgyENasfIcm+pFin6ta+hM750KyHn59heBxft3I4fdffdizIL4wIulyiQj41de3gEG9eeHCO4YcHHnKj
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=V6VQXooYLJ8A:10 a=kj9zAlcOel0A:10
    a=VUJBJC2UJ8kA:10 a=CjiYaNSMAAAA:8 a=mE0hfxVlPFv2PRaW74QA:9 a=CjuIK1q_8ugA:10
    a=jFRs6jQBfVEfJ4qOU6Pr:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752006AbeECDpe (ORCPT <rfc822;greg@kroah.com>);
        Wed, 2 May 2018 23:45:34 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:47737 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751993AbeECDpd (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 2 May 2018 23:45:33 -0400
X-Originating-IP: 212.92.123.35
Date: Thu, 3 May 2018 05:45:29 +0200
From: Amit Shah <amit@amitshah.net>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Amit Shah <amit@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        virtualization@lists.linux-foundation.org, stable@vger.kernel.org,
        Tiwei Bie <tiwei.bie@intel.com>,
        Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 0/6] virtio-console: spec compliance fixes
Message-ID: <20180503034529.GA16676@grmbl.mre>
References: <1524248223-393618-1-git-send-email-mst@redhat.com>
 <20180424214104-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180424214104-mutt-send-email-mst@kernel.org>
X-Remote-Spam-Level: 
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

(apologies if you received a dup)

On (Tue) 24 Apr 2018 [21:41:29], Michael S. Tsirkin wrote:
> On Fri, Apr 20, 2018 at 09:17:59PM +0300, Michael S. Tsirkin wrote:
> > Turns out virtio console tries to take a buffer out of an active vq.
> > Works by sheer luck, and is explicitly forbidden by spec.  And while
> > going over it I saw that error handling is also broken -
> > failure is easy to trigger if I force allocations to fail.
> > 
> > Lightly tested.
> 
> Amit - any feedback before I push these patches?

The changes look good spec-wise.

There are a bunch of tests in avocado-vt that test virtio-console
functionality.  Can you give those a try before pushing?

		Amit
-- 
http://amitshah.net/
