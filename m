Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2043643-1521572175-2-15818678356923543355
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521572175; b=Q8rpX4w4XeqQ7T2FiiXI2XC7ZhWI8dFfoXZWsDch3Nx0DJa
    6XLsy/O6ps8juyHtQvc8i3ywkb3cPg6Ek7AyKCVbZEv0GSJw1og4BR9uRaDWZZSu
    mCqftamZJddStGa/v15BFZmrGcH9xBQu8wOK4Ycfh+SMk1inLHYGgbWLFJZp3muO
    6mrT5t7dee6u6h5sHuoOEpXtB1TtGwaY4EzTqBZsbtiGawCX/hvp9nxyGCxGcFNT
    Cp3hfqHBZY1dHBb/SOHVkCKXyMy55CiLdMPbWR4JN6+DQAKR5bp05r9Mjdj49Hoq
    Ubztod8r6CJoa3YMUnZyucwMKTUMZML7Qz/bzag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521572175; bh=f01FRQhhcWMqZqFyYc6gkNsP6N
    sKRCkToQDESsFhZvc=; b=ZMJX+YUFPQDugeW4AINOu6axDKY5csMp1H3jZAQR0C
    3GUSTtpv1nUxsDbyAlWjimcL3JmMmpDjEPpHRg/l5jiyha8UKFeXjrhNDYc8aABr
    y8ZzuvqLgTRP7IlCTFNkUQbLM2i6uivoYUyiduqCJUVFmkryDS8bJ7SNH7APEVnf
    BpShbb1Fd8TYC0jS1YCODvY7AKVNBIeVGwly+31JKvI/U9pnZ9lCev5StX737UOF
    zFel7vWJvPXc9/ib8ZL2+S9yGaEuQf5rw3rhAp48/X0OIKDpe6ZPnjcdCRECgggo
    5Wt6seXj5DxmkNIzJJs8K3IgNdRcg86B3Gst4anrnKag==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=mioCCCAv x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=mioCCCAv x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751423AbeCTS4B (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Mar 2018 14:56:01 -0400
Received: from fllnx210.ext.ti.com ([198.47.19.17]:24378 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751310AbeCTS4A (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 20 Mar 2018 14:56:00 -0400
Date: Tue, 20 Mar 2018 13:55:55 -0500
From: Bin Liu <b-liu@ti.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
CC: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/1] usb: musb: gadget: misplaced out of bounds check
Message-ID: <20180320185555.GY14921@uda0271908>
Mail-Followup-To: Bin Liu <b-liu@ti.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180320184248.11962-1-xypron.glpk@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180320184248.11962-1-xypron.glpk@gmx.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On Tue, Mar 20, 2018 at 07:42:48PM +0100, Heinrich Schuchardt wrote:
> musb->endpoints[] has array size MUSB_C_NUM_EPS.
> We must check array bounds before accessing the array and not afterwards.
> 
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
> v3
> 	Remove superfluous braces.
> v2
> 	Only the 4 low bits of epnum are relevant for indexing.
> ---
>  drivers/usb/musb/musb_gadget_ep0.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)


Applied. Thanks.

Regards,
-Bin.
