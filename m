Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3755284-1520575569-2-16315356319421848479
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='cc',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520575569; b=W2+XQK04nJe+5rQtfvHniMcmK+9yqJy7aCqhX499XIJ8jK2
    IHYPvpdf+s5Y9XbdAiERZiDvHOZ8704zCQfWofvyjhr9bbXiKtcBIjAnZPKDb8wO
    nV6JlI5dWoxwOAyzv97/vhgFw5He7SiOoVpGJZfN9kWr6Yu5Wzk54FE4JNnlu3Bk
    eqL4KmKb3NCB/PbYz8pKERrVegG4GxmW0PmY8M4ivEFBWle7qjNva6KS9NCDfn4D
    VWvYyw0XGfFZK7nOKWLqwH13C8iLYXUnIuWRq+YS7yq5YXq2oL7uflUgcZPs8PbS
    Iwb/oO/eJptsTVIE6xCAqAPpNiHusKqRWlkRU4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520575569; bh=+v3Ej0nnOwwH87aEeuHa0Cbe4l
    SDtEqxfFnxyJLpL9w=; b=Z8FDMjMbSkQ+zkKSU1Ccj4KRZcRxagll1+fVJYsWzO
    kwzq0J+1gbpfWp2r+Im6vD/cn8UbLl0lVbL1iJZ6xDBoegQoiToRiUdK/ZXJ3C8A
    VaraNt68LHyl735z6f9GA43TxVjWBQ1gGf4SxwMYdAA1b5XIrR+gxmHeVMN8vIYd
    Aqpq61Dg/+mygw7d0cSGtKtyBw7Yx2oAV+sREsQ37cH4jhIjVC0/PDzZfNpx0g0D
    E7ZO8XHDuld2nZozZkhQFThU1DzgSGpmObKJF0yCTgN1lFzzD/V9wnapiR0h7hnI
    nReKR3yhWkLgzEe5bWstfckZvnFhVspn4Az6AChGDFEQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=JEBpB4Bi x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=tobin.cc header.i=@tobin.cc header.b=bOc5yfpc x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tobin.cc;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-85 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=tobin.cc header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=JEBpB4Bi x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=tobin.cc header.i=@tobin.cc header.b=bOc5yfpc x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tobin.cc;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-85 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=tobin.cc header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751030AbeCIGFl (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Mar 2018 01:05:41 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:59959 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750914AbeCIGFk (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 9 Mar 2018 01:05:40 -0500
X-ME-Sender: <xms:NCSiWvsKHhZUbW-Dn6itErp7ujhKnPwKYJYBLUcM_JUzB6WQbDp7Cg>
Date: Fri, 9 Mar 2018 17:05:37 +1100
From: "Tobin C. Harding" <me@tobin.cc>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Tycho Andersen <tycho@tycho.ws>,
        Kees Cook <keescook@chromium.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 3/4] usb: Remove stack VLA usage
Message-ID: <20180309060537.GC16734@eros>
References: <1520574935-7457-1-git-send-email-me@tobin.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520574935-7457-1-git-send-email-me@tobin.cc>
X-Mailer: Mutt 1.5.24 (2015-08-30)
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 09, 2018 at 04:55:35PM +1100, Tobin C. Harding wrote:
> Signed-off-by: Tobin C. Harding <me@tobin.cc>
> ---

Please drop this.  To much on github not writing proper commit logs :(

v2 to come.

thanks,
Tobin.
