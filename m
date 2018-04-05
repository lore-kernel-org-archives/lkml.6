Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2086647-1522913508-2-9847141288586290735
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522913507; b=FkfwHzB2a5+qDx3s7vn7G0TfSbxLW910HFw+z2h4oXlZwrJanL
    umaI7iC573CCzP5QFt9c0M0obXy12t1GlbUjlOqBWmg2qP1rgnox25jsOXCW+g7H
    0O5Hyl/Whi3yBNZUYLyY6wMwimSf/Cx5v2fvy0WBZoAXzrxnwWFRdsGBD+SqumBG
    Pvp2kjWuwh0Fyh1z4mIeuwZKq/DFS8M2yu59KfFo7MFth+nHm8bWMLBe2A8+f4ip
    WKn3N8lzxJbn6uXxv5aNyVAYeV1QmVS90YmUzDkeRZAAYl7KqTTXmPBs6F+AsuYq
    5tN+PGK0qh1IoPiBVi8aHZrRQ0c8kgWNn5wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1522913507; bh=Qlck0dqX4Dt3+gFFnQYB1rTBYPOKjM
    czWi/xZet93rk=; b=HdDmyI80jH+nbj16IBm9iYGuE9QrwbvY+LbrAfzqtAAa0S
    mcJIDThMka6caFfv/U3bZEIcZmd7TpAaJ9WACmT6QyOBtwkpU0IuIW+4huEgFH/l
    DtBXUCm99XwoTp4Do8QhgcoczL2MHU5Zi5lBVekqUYhEONx5r56san8iO+CaE5LJ
    IpXi+af6IXbYSuwWKEGUnSxS6gshcoIOpUR7CMtTxwCY2KBXgiOiu82HpNvHfxGD
    eWNbK0M3+PSs7uISnZNDlXyhm/UpwSoSiknWn27qENh7dqryFrmi+KX/iR0kSHe8
    8q1qrlLP19hZlLKwh5Mrt/g1G96wU6j1AYLrGzQg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=gmOnlhmt x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=gmOnlhmt x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJoyJkeHKr9+laeK6b38NPvRp+cV9vi8RJ54vAAbcxXm3skHEOSBqR5UWcxaESaDwzn10nEo1sokX0bC9a9HO5FBuM6IeI5rcMDXUN//1uy1AbMzM58x
    gBvvMQk0kgjUC0gexrI2+bvegODxU4RfsFDtRUIQQMTf9i0kwEeaPy6qKzClAf3xuh4ApBZiqAJg/bJow95dOtbVTtNjk3/f+iTIps7FEdjJochoDVqTO2Oi
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=ag1SF4gXAAAA:8 a=VwQbUJbxAAAA:8 a=DBxWj8EVcjs-k_Q67I8A:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=Yupwre4RP9_Eg_Bd0iYG:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751195AbeDEHbn (ORCPT <rfc822;greg@kroah.com>);
        Thu, 5 Apr 2018 03:31:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60966 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751097AbeDEHbm (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 5 Apr 2018 03:31:42 -0400
Date: Thu, 5 Apr 2018 00:31:11 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Kees Cook <keescook@chromium.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-usb@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [GIT PULL] USB/PHY driver patches for 4.17-rc1
Message-ID: <20180405073111.GA15981@infradead.org>
References: <20180404103121.GA7420@kroah.com>
 <CAGXu5jKHivZfs_1KfCMM2i1Z4Q5Vs2k7CX8P2twtuVQ_tWmT7A@mail.gmail.com>
 <2d80686d-529d-0238-b91c-3fb88bcf37d5@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d80686d-529d-0238-b91c-3fb88bcf37d5@metafoo.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 05, 2018 at 09:19:28AM +0200, Lars-Peter Clausen wrote:
> On 04/05/2018 08:31 AM, Kees Cook wrote:
> > On Wed, Apr 4, 2018 at 3:31 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
> >> Lars-Peter Clausen (2):
> >>       usb: gadget: ffs: Execute copy_to_user() with USER_DS set
> > 
> > https://git.kernel.org/linus/4058ebf33cb0be88ca516f968eda24ab7b6b93e4
> > 
> > Isn't there a better way to do this without the set_fs() usage? We've
> > been try to eliminate it in the kernel. I thought there was a safer
> > way to use iters now?
> 
> The problem is use_mm(). It needs to be accompanied with set_fs(DS_USER) to
> work reliably. This has simply been missing for this particular instance of
> use_mm().

To me it seems like use_mm() should do set_fs(USER_DS) and unuse_mm()
should do set_fs(KERNEL_DS) to get drivers outo of this mess.  I'll see
if I can come up with patches for the next merge window.
