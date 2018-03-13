Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2930626-1520938237-2-7893158553633657318
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520938236; b=E91MI0V2BZ0sDo5HgCYcjPp+KJwDvqO4g3hx1Bth7NVj+45
    +LX4u/+jfWn0dxBnJgdpYXlfTK7Nfti+LznFyxpTxjHM1VFi5nY7thYhX7n0t2F1
    DQ+B9N+Hd2v13U44plAMVFXfOEiHjIdm3eEUM8aYQ9srCPYhzqhdtMY5GQITCPXm
    BSCZc2Rb8z/OPsju6b19JKlXjTL0wvDBHY/5NrTwFC3olqt/p2kVPh8SDWukEuLP
    lSVapmjJdZPcrrEyg1qDvBvk4V2GEavET+/tlhdMBWBpifNr0zVF+N04btqLyBy7
    VLY1SQl518uFr5VFlGycbeJVOhzuEtrzuXSVkGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=arctest; t=1520938236; bh=L4KSQWe
    NfwRl4uU2VQVZFul2weCQ92vT+bR9E+uWC/E=; b=DlRt6nJYzOXCSRL6STIBWjz
    p9Dz3R4hTBCf0CW5yyXhwXpo8IpUdCBQq/3R0oqFNhLYjeMzt1feEDGnWcUzMbGQ
    fjFwgG3m+C42jfCzM2Cs1TGN2TFsN0E8zj3yDtqTl/FKUAXuNk0F1OzoLPdq7p2S
    KI6A0RYof7PRzCBeDLOAgt9PtR+nBqDGVhDbVE42EGJduZIvZFzdHZ5sv0w3M9ne
    rU3w2cUAi0E1wvlzdW3BRgWLgJ8UGOCYqxbyFJm1RHYBJYZr/poj3zfn49kii8MS
    j2ef83KrW1fQtFo5+1SlXgUg0WhUAlII/w50hDaQPPeRPpfOKM7HZ5InIvn8Tpw=
    =
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932791AbeCMKuN (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Mar 2018 06:50:13 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39108 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932577AbeCMKuM (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 13 Mar 2018 06:50:12 -0400
Date: Tue, 13 Mar 2018 11:50:13 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: Re: [PATCH 4.4 130/193] [media] tc358743: fix register i2c_rd/wr
 functions
Message-ID: <20180313105013.GC32263@kroah.com>
References: <20180223170325.997716448@linuxfoundation.org>
 <20180223170346.213655459@linuxfoundation.org>
 <1520306253.2786.121.camel@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1520306253.2786.121.camel@codethink.co.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 06, 2018 at 03:17:33AM +0000, Ben Hutchings wrote:
> On Fri, 2018-02-23 at 19:26 +0100, Greg Kroah-Hartman wrote:
> > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > commit 3538aa6ecfb2dd727a40f9ebbbf25a0c2afe6226 upstream.
> [...]
> 
> This introduces a regression in i2c_wr8_and_or(), fixed upstream by:
> 
> commit f2c61f98e0b5f8b53b8fb860e5dcdd661bde7d0b
> Author: Philipp Zabel <p.zabel@pengutronix.de>
> Date:   Thu May 4 12:20:17 2017 -0300
> 
>     [media] tc358743: fix register i2c_rd/wr function fix

Now queued up, thanks.

greg k-h
