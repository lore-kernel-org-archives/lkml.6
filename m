Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3088149-1520301082-2-36833499770371956
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES da, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520301082; b=mlYD2POJYvrYVN0Gwi/mxw+t44zD5S0e9tuY93TEd/9suup
    MSNYmkHk5i5C/2qdA62UuFb9DqjG+RuRSRzFl2O3fTRFNwCTex5LavTXcdFd6bQB
    SbQd7s9Hn6rt1FUVd7fcZ3v1vabs8K9STCYVMM+ltVi0IfpLWO3AdqOpHz+48pDU
    voz0FUZjM88F4tUh9obGqxQbyzR7vvi/9tHe8NXRFv3uCQ2+AJ5QiVSRcml+k1Mb
    /U4zfYvy82qnofAVkzojrt/GejRLzg+9gT4QtrN8CQ8T1bbXTtmbIzq+I4Bswq8v
    zDXWpFCR1UXXC0lrgK4NPPvnsLXU7YcvcMmobPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520301082; bh=WmKbayt/M9WErJZC+JpY3U7yeU
    77pqKZMUmN+pH4TiE=; b=pwC2nhKSBUE/tS3cLQH1/ECsk1FeseP0GGgu7ZVqBq
    vZFH835N3VnsOJ+AJWAF6ybe5KE/yg2ShUj1noiECd7J4FmHxKOhxUVx9wJ51H2o
    dcQHIRUwnCQnGi/yuLksTq6hzrcD47E5EB8bpERNcSkdb0iGXtBGVj45SISWPmxG
    TiKzt8XOGxTSwq+vZvYecXZHXJ0w2ri+BJJxZxTGzpy4f/gn2l1gIlOY/1StCBrS
    d8+miCMg31jLJraM0LnbvSUjbgv3tMdhvZi1wXzj9ZcIt2UmV9l2pag58EgSFXA9
    X2rItVT9E49oSwcCY5mOrcmEXBp/eiUuA25UJH1n6few==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=0 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=fboszOCv;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=0 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=fboszOCv;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932388AbeCFBvH (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Mar 2018 20:51:07 -0500
Received: from mail-oi0-f66.google.com ([209.85.218.66]:35212 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932353AbeCFBvE (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 5 Mar 2018 20:51:04 -0500
X-Google-Smtp-Source: AG47ELt2+UdYNTeelJNB35u6658UzZpHeOcf9rAiL8bqUDfmcwpwZd+MxJMjzuL4YsUZfrKcl/1m/A==
Date: Mon, 5 Mar 2018 19:51:02 -0600
From: Rob Herring <robh@kernel.org>
To: sean.wang@mediatek.com
Cc: sboyd@codeaurora.org, mturquette@baylibre.com,
        matthias.bgg@gmail.com, mark.rutland@arm.com,
        p.zabel@pengutronix.de, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: clock: mediatek: add binding for
 fixed-factor clock axisel_d4
Message-ID: <20180306015102.alzc5a7sxmtbphzz@rob-hp-laptop>
References: <cd26a3bdc9f29e237089395fbba93e28549ddf25.1519874655.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd26a3bdc9f29e237089395fbba93e28549ddf25.1519874655.git.sean.wang@mediatek.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 01, 2018 at 11:27:50AM +0800, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Just add binding for a fixed-factor clock axisel_d4, which would be
> referenced by PWM devices on MT7623 or MT2701 SoC.
> 
> Cc: stable@vger.kernel.org
> Fixes: 1de9b21633d6 ("clk: mediatek: Add dt-bindings for MT2701 clocks")
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: devicetree@vger.kernel.org
> ---
>  include/dt-bindings/clock/mt2701-clk.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
