Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-426994-1521123521-2-13022292115219459416
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521123520; b=dSiANrqW6eQahg4aEIvxBivRY4uXqyhQLlhJPW3jbkzknK0
    xmDLGjKwbgRkQaorqqVrUE2l+sjEpWdIspL6CNKpEO3+auxN2yK7ZDq91BhGiU/T
    WP4SLEzS8B/qpqRnDhf2pqOklmABc4yuGxlo3/BGxXU54XtP5RnQcUrc5h5Xm+6P
    oLcuABrSQK38/Po7aczuyqaoK22aeKhe4Qabs+vv7HKlNHoNXZ3OwdPjAJxNdpiX
    njPO6RUXbDeHvEoH1bvnRyqpFpASZSJ2CiR2zr7EjgsDdhsK6gwVBz/j2G09yJun
    UGD/WAC9ta+NIpoIvrrmboJ4JmN8rKEQpV1rqhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521123520; bh=mPWVwe5Bn2pfMZqzDXrxp3z++r
    Ezvzki8KpRgub6SCU=; b=Jy5cY8WmV+B5s46vdomrn1Jggc5yDMPaab96kUX04i
    nbf8KI6AC/AuwPjZBR+l2MCSoF40i3TA8KyGVa75ax7s6nc2R91HASQgEJK7CkOG
    KxVXL6LPM9aA1maL9GH5wKl4S0m5VirdbLN9K9gB4wDWHGaSVehQC27Y73KJZsRl
    jU1IgRMK+Rx3aYhOrNvJPsIKc6C4WUS/+Kb9ojx0ZH/bqSFTZv/yQ7IvGigK7dYQ
    8VVE9d5b6yFBJb8i7QQitB9nYq+iWwomtIDR04vMSdGSS+sG1826gNF/Y5DP70ZV
    +puI+XenmsAArSgkGvALNcexmDmSGvAMim2WL2S93kDw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=EXhRXPFP x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=EXhRXPFP x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752232AbeCOOR7 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Mar 2018 10:17:59 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49832 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751551AbeCOORx (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 15 Mar 2018 10:17:53 -0400
Date: Thu, 15 Mar 2018 07:17:49 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Hannes Reinecke <hare@suse.de>,
        David Howells <dhowells@redhat.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        IDE-ML <linux-ide@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-pwm@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-spi <linux-spi@vger.kernel.org>, linux-usb@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH 00/16] remove eight obsolete architectures
Message-ID: <20180315141749.GA27100@infradead.org>
References: <20180314143529.1456168-1-arnd@arndb.de>
 <2929.1521106970@warthog.procyon.org.uk>
 <6c9d075c-d7a8-72a5-9b2d-af1feaa06c6c@suse.de>
 <CAK8P3a01pfvsdM1mR8raU9dA7p4H-jRJz2Y8-+KEY76W_Mukpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a01pfvsdM1mR8raU9dA7p4H-jRJz2Y8-+KEY76W_Mukpg@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 15, 2018 at 11:42:25AM +0100, Arnd Bergmann wrote:
> Is anyone producing a chip that includes enough of the Privileged ISA spec
> to have things like system calls, but not the MMU parts?

Various SiFive SOCs seem to support M and U mode, but no S mode or
iommu.  That should be enough for nommu Linux running in M mode if
someone cares enough to actually port it.
