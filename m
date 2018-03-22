Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2701711-1521723197-2-2184824643651790987
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521723197; b=DIRArbwNpTOEs4KDgnGDRAZd2+PYLJhKXsPOUIB97LLG+P4
    8gW1+g2Yv1IJLU71csQDJI+kkVUy+Sj6lAuAPGZYYgEebkmpLcqIEnDJxxZbkD9h
    tqnMU/wInkTFg4qYzaDITBd1W2U78imwk5hjks53fcIGFZ+l7t7EEnSxVpCQZCAA
    AXTtyT/tE1CXRiZgbYSZ4tHwZmdQJuOhhq9mBdskOB+gdXP0kcDA98sJViZaB4Jz
    y6g9V0Z2k1W5ddvQ5z/eigcvTirqeVaiyWSrzhTE1M6cO5VGl+zrAHUpWzo9MMB8
    qCRsUTwh5wuWGHrvEssH93i9L3TrR95T7fmQrmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521723197; bh=zLoqiRlBN/E1NvxVFa48rcJqlD
    YeCdpW4Pg0iFhVhH4=; b=LfFjvst4BZFjgsdjgw74ZroGempvrsmMsnep70Sq2K
    l8V1Pi3mSRJkKO7YCbt/ADcJCVDQPTxItl2GR/AouBNDI3TgdkbVY7971+/Burgv
    fny8D+oy5EvSnhQ1617vHurCyu9/zP1wcFztRytGR7S+4aQcy88cNhKtwj+oN3Uu
    NIt0xiACERX6h8ZbFnUfpTu/7B828k3Co2WU3vtruzItzLQKK84Wkek0yxbm4KGF
    FHP4se7JHENJCRXEPJmEGpBPKonGZJgqPRINFcDRhkiqs1vdESrJlmPIisnlMy5U
    t24x28MI5R25+mDoJNGn7hXqEk6XuBeXT0dHfEy/9kDw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754720AbeCVMxD (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Mar 2018 08:53:03 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45526 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754484AbeCVMxD (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 22 Mar 2018 08:53:03 -0400
Date: Thu, 22 Mar 2018 13:53:00 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Roger Quadros <rogerq@ti.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [usb-next, v3 PATCH] usb: xhci: skip phys initialization of
 shared hcd
Message-ID: <20180322125300.GA22130@kroah.com>
References: <643701fef843f91931e3a68779afe053c63c96f6.1521707846.git.chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <643701fef843f91931e3a68779afe053c63c96f6.1521707846.git.chunfeng.yun@mediatek.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 22, 2018 at 08:12:50PM +0800, Chunfeng Yun wrote:
> The phys has already been initialized when add primary hcd,
> including usb2 phys and usb3 phys also if exist, so needn't
> re-parse "phys" property again.

Wait, why does the subject say "xhci", when this is in USB core code?

I'll go edit that by hand...
