Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4104473-1522973135-2-2662026867715463699
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522973129; b=i9f+XkVkZT5KigOl9Pz0CU3JaZ9ZXf+0iG5ZYKvTSjnaqV6cG1
    hmBHuGU70KRA0PUtyUzZIwqEtz6rUxUh9VOEDp8QSCNGmBNLNd0oBdj/9WoeaJqO
    95bNSj7Q+MhPXsq47+EBVBoey0gMPkiAqWVbRWA8qsn0VIKxemEcLxLtfeNijd6Z
    DStVtjrKvRjGgW5TQXaudiROKwJBYHV2Dzo9rHL4RoBLT5nDNELjABIgNlOuMH2a
    Rr8+41KPm2Px4AsegPUYSO8tpAsM6gf8f/+mrMMg1Ed92D/iYbCXLtHjc8woGsK4
    nTa071cMPO4Rn22wO1g86h4g9sKLxpGm9vOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1522973129; bh=FKg2yfgIwyJ2j+NTZqgkv+XAh6aOO7
    ySdUU9Yu8s+KY=; b=FWNShkK7dsk5wvmcsRRXTm9KieDiryJbhDPfN7hV683mih
    b8DnPNhJ76NDm1Clx90XEVd2+FdxFSxlx5Xy5d0+IMWrLnY8R1AgNYh5eA7wzr0o
    OXVvCYs8kNvmS85+BQqnqCX3eqhr9zBI5SMmlVlFpGvscvXT2y4AZ+nEHk+rPDFs
    ZbEpcScwpH73qloF4Xz49NwyoVwiG2N4YSPiPkYN3pAz/Xi2lBqhOzvgzthTWzdu
    qD/fOMnHQHtea4CQR+GcV0drCVkTtb51TLfBFCorluP9ZxTLrp9z/XMoyGqfEvCX
    TEe91kC8TfKUUP7ppM/rEtemR1ce6WjM1WSOCwoQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=zeniv.linux.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=zeniv.linux.org.uk header.mx.error=NOERROR header.result=warn header_org.domain=linux.org.uk header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=zeniv.linux.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=zeniv.linux.org.uk header.mx.error=NOERROR header.result=warn header_org.domain=linux.org.uk header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfK2Sloi+g+37Poi6oFo1/yPVlhpaZL1vmAlAh6t11idAnl1Sz+G3aB1OYfexoYOuXdt0o7+PmAUEWCs/xSZMJIhhFpz50mKnvwI5MHhKIOCcW6HiVJQh
    sNrz/8FriBJt96C90WYrPb5PutNRG04iGfs3UFdbO/Bm36NhBqxB6FwzIDIhIBztPMBfcslFUk77yQRpAh98x2c7YBz5lUhABq7IwzqMj5tMK9AUdPNPmVXp
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=ag1SF4gXAAAA:8 a=VwQbUJbxAAAA:8 a=GHf74y9ojWS1WvwfnDgA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=Yupwre4RP9_Eg_Bd0iYG:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751278AbeDFAFP (ORCPT <rfc822;greg@kroah.com>);
        Thu, 5 Apr 2018 20:05:15 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:44202 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751259AbeDFAFP (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 5 Apr 2018 20:05:15 -0400
Date: Fri, 6 Apr 2018 01:04:43 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Christoph Hellwig <hch@infradead.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Kees Cook <keescook@chromium.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-usb@vger.kernel.org
Subject: Re: [GIT PULL] USB/PHY driver patches for 4.17-rc1
Message-ID: <20180406000442.GQ30522@ZenIV.linux.org.uk>
References: <20180404103121.GA7420@kroah.com>
 <CAGXu5jKHivZfs_1KfCMM2i1Z4Q5Vs2k7CX8P2twtuVQ_tWmT7A@mail.gmail.com>
 <2d80686d-529d-0238-b91c-3fb88bcf37d5@metafoo.de>
 <20180405073111.GA15981@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180405073111.GA15981@infradead.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 05, 2018 at 12:31:11AM -0700, Christoph Hellwig wrote:
> On Thu, Apr 05, 2018 at 09:19:28AM +0200, Lars-Peter Clausen wrote:
> > On 04/05/2018 08:31 AM, Kees Cook wrote:
> > > On Wed, Apr 4, 2018 at 3:31 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
> > >> Lars-Peter Clausen (2):
> > >>       usb: gadget: ffs: Execute copy_to_user() with USER_DS set
> > > 
> > > https://git.kernel.org/linus/4058ebf33cb0be88ca516f968eda24ab7b6b93e4
> > > 
> > > Isn't there a better way to do this without the set_fs() usage? We've
> > > been try to eliminate it in the kernel. I thought there was a safer
> > > way to use iters now?
> > 
> > The problem is use_mm(). It needs to be accompanied with set_fs(DS_USER) to
> > work reliably. This has simply been missing for this particular instance of
> > use_mm().
> 
> To me it seems like use_mm() should do set_fs(USER_DS) and unuse_mm()
> should do set_fs(KERNEL_DS) to get drivers outo of this mess.  I'll see
> if I can come up with patches for the next merge window.

Yes on the former, not quite on the latter (we need to go back to the state
before use_mm()).  Said that, drm users of use_mm() look rather fishy and
might be worth a good look...
