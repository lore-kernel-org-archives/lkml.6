Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-226545-1522306853-2-17726083566064221408
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522306853; b=j/BQ8V1AQKjql1shdTIQQsXnBdvZelQJnU3xMgop4SR6EtO
    DX88VJy82jVTDFNdh3NfoFmTiUHLtYFKoLtAncCxrSbL1l8MjAudV2kyPB/TwCJ8
    n3lJ6+zvOsKfc2aYhe4fzT9LU4HCl9RrBCogc5r3SNV6SnVv1Wv9GJbX8OqLxZTg
    0XpG0hCLjcU9BnVDU4pSZ9UhhVewV8RnXUxKD6JLbIE6oy7q6BkXHvKq9kejg2CZ
    aT15rZOT/iOYAVPMHo+d1DHIc3MS3UMyC1+k+IPW7XxsGjbbWs2gP2+Tg2hu6zEz
    kzPb0oQazzjjqCTtxWVShUicX4F2uRcR47TIo5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=arctest; t=1522306853; bh=Ycufbb2
    ntgdp9aSFaBWJGr7KEboYafptqq+7L3Z2+rE=; b=jzX4nZXWOM5n+bq5ytCfMgT
    wTS0Z5kjEwcWK6ObaAbZ/BWVhFmPd6AgUA6S4mXBnTIdIdMKKBuTxHqDMwrr6poB
    bTCqunwZS4pTh/tlhxK7+JSOBShR4DuSQn00/uUht8bd2xyVQ2IFCHU6+G2o/WMu
    miQ6YEaXZq9zbZqTjS2+nGNcc2M1cuiG5hhKYYg/CUUi5kbgqzN4mLLHEvTmEiIr
    iFZcTOzAKd4SSROnTA4UShH7v+So64aBqlK/HrHS0MrOxcZ5cFNFXsIOoIiv9J2i
    M0UQQp59AQm7ZbmNyPtrKu4i6m3XyistRd+9fI6zJ13UBRS8kX8sDPXHjYZ9UWg=
    =
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfDoq/kZ1v+rqM9TJmcYhE8l0Plr7uIqlPuM0IQTQ0zJB9L0T/GYYWtP+g1RxgRq+sObTTj3BsZCutxlbW8PJyqXucnCQQ/17Igfi41N686A8YjDMQ+bB
    2IzkUthXEKbutoWXwZyHFPY7a6pkTvLWg1VqJ4dK3GYg0H2c2vbHML1/KT0zNp2ks9LzxJmpwZ+T9uOytv89ZB7dYoigll9u393j5BqKrErdf6zku1YS2kPR
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10
    a=C1mhSScwG4DlU8B7tAUA:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751183AbeC2HAv (ORCPT <rfc822;greg@kroah.com>);
        Thu, 29 Mar 2018 03:00:51 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40292 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751256AbeC2HAu (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 29 Mar 2018 03:00:50 -0400
Date: Thu, 29 Mar 2018 09:00:45 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Inki Dae <inki.dae@samsung.com>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        stable@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Brian Warner <brian.warner@samsung.com>
Subject: Re: [PATCH for v3.18 00/18] Backport CVE-2017-13166 fixes to Kernel
 3.18
Message-ID: <20180329070045.GA8759@kroah.com>
References: <CGME20180328181304epcas4p2593efec8fcccbf6bf30ed30d9b5f0093@epcas4p2.samsung.com>
 <cover.1522260310.git.mchehab@s-opensource.com>
 <5ABC23A0.20907@samsung.com>
 <20180329042558.GA9003@kroah.com>
 <5ABC8A3A.5030602@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5ABC8A3A.5030602@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 29, 2018 at 03:39:54PM +0900, Inki Dae wrote:
> 2018년 03월 29일 13:25에 Greg KH 이(가) 쓴 글:
> > On Thu, Mar 29, 2018 at 08:22:08AM +0900, Inki Dae wrote:
> >> Really thanks for doing this. :) There would be many users who use
> >> Linux-3.18 for their products yet.
> > 
> > For new products?  They really should not be.  The kernel is officially
> 
> Really no. Old products would still be using Linux-3.18 kernel without
> kernel upgrade. For new product, most of SoC vendors will use
> Linux-4.x including us.
> Actually, we are preparing for kernel upgrade for some devices even
> some old devices (to Linux-4.14-LTS) and almost done.

That is great to hear.

> > What is keeping you on 3.18.y and not allowing you to move to a newer
> > kernel version?
> 
> We also want to move to latest kernel version. However, there is a case that we cannot upgrade the kernel.
> In case that SoC vendor never share firmwares and relevant data
> sheets, we cannot upgrade the kernel. However, we have to resolve the
> security issues for users of this device.

It sounds like you need to be getting those security updates from those
SoC vendors, as they are the ones you are paying for support for that
kernel version that they are forcing you to stay on.

good luck!

greg k-h
