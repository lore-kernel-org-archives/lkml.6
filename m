Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-111126-1520852658-2-11701753746333406347
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520852658; b=lCsXb6pOLIHcnDhVCWKTFYPpLO8W4bfjgTW3Q589/rsbqa/
    pqsPBiJwhW/LB4oFW58WyX2S+h9hQFKfXdt1VG9iFdgVXRzoN5fScuO+UaIigNEi
    Y9lEKMLv4Fw9Lk239z9rma0bXMnOSPI1jjG25/ikCCBYVKIXJO8/Shcp87mui+pa
    WtGdC85l+6ZZ9T5weEXF9KiWwNQy20n2SUIapz2pAhgzofeHnK+ayw2lJnjhsO6u
    3d6SeOUi2fgACIcxqUllQ4IQD/IGvY+mggabELyihf/E3DEa7wMG87F6/ngwd213
    p9owcMND++FQdNAnMl7qOS1Gbt8noLNOg5awy4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520852658; bh=b0zwpj35kI2xPwABvSa4BQEsr4lBqdE9Si4Hjo3xx9c=; b=M
    l8iyBUmAdCerimzBp4Y/9vscewPRbseI/NNqGQr8yonB/QfZIb0wv2VSSH05wICC
    wLko3Q1qY7U5+bJf+hKriEe3cIto0vl+0/Ut4OZylOXdLLfD8SeAM5em3RDQdptM
    Y0jTArNM0INgGJWwKlqDC4dZmp49usiKMWvbISK2iR/VKR0TLW4FpKjR6fXXmrPT
    tbm+ymhXT33NoKjFN34cBQndWzUEgDHy6B26TmRlAIBpIMi/P14WM61xU1g7cCAH
    g0jVPDVdnrE5/rW/1l8ehOhRo+qg4NgSqn81reessB23u2v3pgHUknpQ0ACfCu0p
    nIRuqkEG3ALynmk9mww9g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=rPe08KLc x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=sCI0simP;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=rPe08KLc x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=sCI0simP;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751284AbeCLLEC (ORCPT <rfc822;greg@kroah.com>);
        Mon, 12 Mar 2018 07:04:02 -0400
Received: from mail-wr0-f176.google.com ([209.85.128.176]:38017 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750752AbeCLLEA (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Mar 2018 07:04:00 -0400
X-Google-Smtp-Source: AG47ELsLrCH4TuPnDFWgnySyKa/OXTkD5StAySGIJejm0B0TRK7qn/kMyfnNxXIZkOHpxHLp5wGRbQ==
Subject: Re: [PATCH v1 06/19] arm: dts: mt7623: fix USB initialization fails
 on bananapi-r2
To: sean.wang@mediatek.com, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <cover.1519378871.git.sean.wang@mediatek.com>
 <bcb9dbeb1389e71f4eaba0c2def1c991703e10c4.1519378872.git.sean.wang@mediatek.com>
From: Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <81aab78c-a921-3d80-1636-fc4b797b4517@gmail.com>
Date: Mon, 12 Mar 2018 12:03:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <bcb9dbeb1389e71f4eaba0c2def1c991703e10c4.1519378872.git.sean.wang@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 02/23/2018 11:16 AM, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Fix that USB initialization fails as below runtime log is present during
> booting on bananapi-r2 board by adding missing regulators the USB device
> requires. Current regulators USB device uses are being updated with the
> correct ones to reflect real configurations which are all from fixed
> regulators rather than MT6323 one's output.
> 
> [    6.473958] xhci-mtk 1a1c0000.usb: fail to get vbus
> [    6.479313] xhci-mtk 1a240000.usb: fail to get vbus
> 
> Cc: stable@vger.kernel.org
> Fixes: f4ff257cd160 ("arm: dts: mt7623: add support for Bananapi R2 (BPI-R2) board")
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
> 

Pushed to v4.16-next/dts32
