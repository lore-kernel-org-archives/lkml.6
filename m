Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3592446-1522152014-2-16523339652959277336
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522152013; b=Nclm7iPpgC/IJzRC2bRZ2Jw9xrq4VjvzG+T3RFxybO64kAP
    uPso0oRK4gzIuPQ8RIdX56U4gTEuVBml8HqH28x+AeVkJ1gUo313y4Z+6OvT6pwU
    G+HpnpwkEQJVg50kQ5gERD7GBmAtHwvhIohB+X6w3+D+x+nfdhcuIDKTbO8qxMo+
    srs4Nb1EmycLtgPE0Ja+LpYyjMAfQdaYbZNdYsq+XykQJ3QzjAQpomKJAxCUAPnx
    Z0yQhWENHJ/Ofq1/kXoEFBVW2bU5msPUCilldBflSf0oc6cTRwQW2rMbIIJTsMsJ
    HZx9aAOGcvIZl1hTe3XMMPtp9e6hY/zjyNMiNeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1522152013; bh=5zJFktkh9rEkVieT+s/CO11N/P
    ZmPGvq9zE2OeS9T0A=; b=D+IsqZVwu0yiB6JeVkePMI8qHPEy5eIcMY30v9RYhM
    FAYL2yP95KzCSK2xzLMQj+axmJ1sJQ9WpYD+XIot+4jKKgrrD9KPMA8IskC34nii
    WaxqRat8KMFNIOX1RDa0sIS2EYp6q7hq21Dth0cyf6FwhLYb2L0xBeTYg73WmpNH
    jat1EBd5kjuoq/YjSfmuh9nMlyWeSJ4t6xjpDYUE7fygkBsB4PgD94jYetYAONyP
    AM7zwYLXn62xNeReT21AfW5v3YcdqF152rbPtP7V+cXIT0AlafxF7pmwSHuo0fuI
    REzdmN+hgltVHOn0Mwe3KAxWH+0jQUWhnLR0dmtrv+6w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJpqzp2sbhEsZXdzJzmaW2imu3ingOZrifqRr/xKWZe4TtZyltm6wXr5k4VwVH6mUFC1tnAh7sUBS9TumyvOrdcjPRW4EM858hb+hG+mY/CbZ1XjFUZf
    L1Hz5izkd5fVk/ekvB9dKAejMXf4v/C4ekXmkn1WxkGYixX9kOxNU1afo8TY2YJ8EULpXuEbAhMChN/P5uNCMy0NeccqxiTO7DYLuDjxvenjTaFZFDKLdPkL
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=yhP3hfDoFvw4WTobnRwA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751964AbeC0MAK (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Mar 2018 08:00:10 -0400
Received: from mga06.intel.com ([134.134.136.31]:15056 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751187AbeC0MAK (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 27 Mar 2018 08:00:10 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,367,1517904000";
   d="scan'208";a="215253902"
Date: Tue, 27 Mar 2018 17:34:23 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: Maxime Jayat <maxime.jayat@mobile-devices.fr>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] dmaengine: at_xdmac: fix rare residue corruption
Message-ID: <20180327120422.GJ15443@localhost>
References: <20180222113955.4043-1-maxime.jayat@mobile-devices.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180222113955.4043-1-maxime.jayat@mobile-devices.fr>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 22, 2018 at 12:39:55PM +0100, Maxime Jayat wrote:
> Despite the efforts made to correctly read the NDA and CUBC registers,
> the order in which the registers are read could sometimes lead to an
> inconsistent state.
> 
> Re-using the timeline from the comments, this following timing of
> registers reads could lead to reading NDA with value "@desc2" and
> CUBC with value "MAX desc1":
> 
>  INITD --------                    ------------
>               |____________________|
>        _______________________  _______________
>  NDA       @desc2             \/   @desc3
>        _______________________/\_______________
>        __________  ___________  _______________
>  CUBC       0    \/ MAX desc1 \/  MAX desc2
>        __________/\___________/\_______________
>         |  |          |  |
> Events:(1)(2)        (3)(4)
> 
> (1) check_nda = @desc2
> (2) initd = 1
> (3) cur_ubc = MAX desc1
> (4) cur_nda = @desc2
> 
> This is allowed by the condition ((check_nda == cur_nda) && initd),
> despite cur_ubc and cur_nda being in the precise state we don't want.
> 
> This error leads to incorrect residue computation.
> 
> Fix it by inversing the order in which CUBC and INITD are read. This
> makes sure that NDA and CUBC are always read together either _before_
> INITD goes to 0 or _after_ it is back at 1.
> The case where NDA is read before INITD is at 0 and CUBC is read after
> INITD is back at 1 will be rejected by check_nda and cur_nda being
> different.

Applied, thanks

-- 
~Vinod
