Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-168518-1519571937-2-9067945046711149103
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519571936; b=XRMwSFw5NhwJkE8RHcCKuvd66UnA0i+buDzkfSkYaKTHFzJ
    P/L8mO7s2Evn3PUFfTJoZVis/hbyJTTuKTXKuhJyIy3K4QMeeOiiftuuddKF6wS5
    og94Pzgu2XSKWqB6Neuot6ei+q2g+EIO8zt/KOQGnqSEyMBCdKVNxHw5MT22Fair
    aiPfx5olcgJMV9WrFDYk4z+yAxdkWr3dLybsmTkQvA7aXg6R+A6VUpUcBZfJ+Fqq
    64nLfPd2ar8Uf8ttSO2krvUIpb/qTaI8jZmEZ68l8IVWLWLUp66DMh0LtyvScJwW
    9Bd1zHVAQ2umdYihQ4Rlj5BpYQyGtrEcEAijp4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519571936; bh=aLToWHdADgSu2CyrmU8kX41TG6
    uaDHKoVZ/4WZFfcR4=; b=cJMxDYV1a7eI1SKF03982Rlad+77ylbE983hxzn7FF
    5YsaZ4klWToQ/W92WqhpZB5f+08Gev9+q4OM/XG5GVDpcX+Td7Pi1Xz3BEtvJrFw
    tNo2nm21lo6dqxp4gpSVRDk4mlHYLiVI5zrAA6qFLQpSdhypOp5ngMGw3OEOZk+h
    HIkNsz83cLBRYM798T/K6PNA/qyIrUInZgmN7gUjGiO1munQsshvPpsm93Acybtv
    eLC/dt7KhXrfnIsKmjnLm+PQ4bEFGVKw35QGvhRVesspj3drDVbzPjBf+1YxxRKI
    pHsmR/7AIiFokRz/8y7DOw3bhE7OyIZuZ3+YsDQHtccA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=D6Vfw3BW x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=D6Vfw3BW x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751568AbeBYPS2 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 25 Feb 2018 10:18:28 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58166 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750987AbeBYPS0 (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Sun, 25 Feb 2018 10:18:26 -0500
Date: Sun, 25 Feb 2018 07:18:21 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: gregkh@linuxfoundation.org, oneukum@suse.com, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v3] usb: core: Add "quirks" parameter for usbcore
Message-ID: <20180225151821.GA20478@bombadil.infradead.org>
References: <20180225123833.31299-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180225123833.31299-1-kai.heng.feng@canonical.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Feb 25, 2018 at 08:38:33PM +0800, Kai-Heng Feng wrote:
> v2: Use in-kernel tolower() function.

... why are you using tolower at all?

You've got 13 quirks already; you may need to use upper case as well
before too long.

> +		quirk = vmalloc(sizeof(struct quirk_entry));

vmalloc?  For a struct that's 24 bytes?  You know that allocates an
entire 4k page, right?

