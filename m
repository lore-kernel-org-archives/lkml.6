Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-426418-1522856039-3-9883647130220345902
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522856039; b=qBmnotgWfmW92Bkl3LSlbT9WR7EVLKa4imKyZPnKZFr/ydowj2
    H2cHUFfXkF5e6uQPoti5vYqT8xObeiDCuj1dUJQHlyYg/rJdRT5epIaS0e8+dzaQ
    GY/3yTFBPBk4BC/behTxgKOD8Byk5fPzPAvREAv7BAE4qtpeccvRs4ecpYouOQgJ
    Re713FF6ba4nGZ9hRXWhsq2JNajxZgEsAqjjsWGFhOj+bj6GJlkCBpnmGHRhH+Cb
    vmwU8AblCMPRGCpju9RrtgbLxGO5JQ9b+a6DexRiOTOzNDX75Jbs2XJ5ZqdVXbn4
    gRaXFzVEt6NISA3ixQOdB0Y18UlCADZWR8bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1522856039; bh=Wug41hFt2aU6/jmM7e/jIwR7puq9bA
    EuHSbmJwwpoYA=; b=huLCXwv/QwPyxypUq64x3/K4qrV26PunEOp0/53EkhuA4H
    SPMHgWnpUfUQ4JvO6839LzKzAGyxUe63hfapjlT8XA5fxxVdpJEfozIvfNDrwTtF
    h+FE8UrdHY5Zo6CywyK/YT1/+0MIT5siFXnrjGTcFtpeP4LfJJ16jONrnOzy0sra
    XZEUSr4H2W9C7md2D5plAY4Qw8uRfTZGnJcrOiCDaKsWmcgG5COv0WT90Nj7ADEt
    gEk44KCQq+SECoumQ/FULXSXAdGwoZmxfW86GCnBCeBjx2zzzHm59QaKt5sNYwm6
    mjY6aMPJ+3Ivd8kThcumhflkmKbLV9t5OL2dPuZg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfFip0V/HKU9T9+NlEFlHW15U0+JqwcJHLjFUvwHUVCGcuLtK0r3p//kKCogYW7Kp3Y9cwEiZ2yB8RQuFusrWUKPMNRdh6RiXP84ZlPbu8pIHKJDHl6VE
    a79+y7IEZ6EFrTAIMoLPvlX2ZMuB0TXirL8n6j2BEKlO6CvljgeyMuGoGwHBsclMhdknU32UJ5ljKuAOAAODI7y+QDIN00f0U0+4YdQxJw6iyXr24rrir9Ro
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=DJvKJEgu1VSDQVoFdIcA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752397AbeDDPd0 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 4 Apr 2018 11:33:26 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44060 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751772AbeDDPdX (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Apr 2018 11:33:23 -0400
Date: Wed, 4 Apr 2018 17:33:08 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc: Linux Media Mailing List <linux-media@vger.kernel.org>,
        stable@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Inki Dae <inki.dae@samsung.com>,
        Brian Warner <brian.warner@samsung.com>
Subject: Re: [PATCH for v3.18 00/18] Backport CVE-2017-13166 fixes to Kernel
 3.18
Message-ID: <20180404153308.GA20086@kroah.com>
References: <cover.1522260310.git.mchehab@s-opensource.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1522260310.git.mchehab@s-opensource.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 28, 2018 at 03:12:19PM -0300, Mauro Carvalho Chehab wrote:
> Hi Greg,
> 
> Those are the backports meant to solve CVE-2017-13166 on Kernel 3.18.
> 
> It contains two v4l2-ctrls fixes that are required to avoid crashes
> at the test application.
> 
> I wrote two patches myself for Kernel 3.18 in order to solve some
> issues specific for Kernel 3.18 with aren't needed upstream.
> one is actually a one-line change backport. The other one makes
> sure that both 32-bits and 64-bits version of some ioctl calls
> will return the same value for a reserved field.
> 
> I noticed an extra bug while testing it, but the bug also hits upstream,
> and should be backported all the way down all stable/LTS versions.
> So, I'll send it the usual way, after merging upsream.

I've queued these all up now, thanks.

greg k-h
