Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-752709-1520354999-2-4974625124852096578
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520354998; b=J07P7ERC/dU/n+71Z0WVA4X47o6fieX1Rw4/wd2nyXGRHcC
    wQAWlXIHfEipfX8HPqa6y0ID2N8a/Y4wwop1xFQsGAwmyVnWw/r3qaN/pQon4VbM
    TkuELyMyaQ35//ttR9XvtLPNTPPKXx97Tg1qID2op8zh1YivOiQ0oFFzkZsM0I34
    nRkAj/R+VTd7e5eO38TR9Bgw/JMRHR4sKpoUfDrLRg8igeAYIBKdH8MZ5uoWHRc/
    q4JyULw1b245Kp76jxhm90JaHs19YDdOXf690G7+JjVx4y/hAA2ncQCATy7ESPTj
    0pFol+/7U3UIkAMO98ULu3plNAzxkpB4sdIZW/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520354998; bh=hGSHv/GGipDl1T6pH4ilEV5L4i
    rEpLnH7++sVlA9zM8=; b=tLCzNwQVus+gY68dwuAo2OjhlP4sIvS0Wul4+HfS5g
    7ALSE7me3/AaF/W7IppFKuhaTlEA001LqLZLc3IBYCF7qn2akQ3PfjIdBwLXkpli
    VsJnZCYSlX0FANH5eF7GteZBtYD3lbJBZDd0uaovfJ1Y0Gt9v0yi4rwH3ljNL4nj
    VxEN30bTbThyINg4qm0ql5e3uZaWy9TgFDJvYvXslWNBP4PSQ1qrTKBb19Vs0Fbw
    33GDkUSmeYWWRDcKZqxnsvca7vRibD3bAYf6Oz92JulUM8K3fhzqYKCFJgCfz+KO
    kg0bKo2FPyALw0s7ftcDJpHkBAzSs2UyZ+42MGYO86uQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=iSD5BEa9;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=iSD5BEa9;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753894AbeCFQtp (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Mar 2018 11:49:45 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40673 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752055AbeCFQto (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 6 Mar 2018 11:49:44 -0500
X-Google-Smtp-Source: AG47ELsAC5tWU4tEAdTZYQwkSIWZge4dmDnCSZrmlZ0liJlQSSB1pNjrQ/W2v3MHkPWD+0BR+RCeVQ==
Date: Tue, 6 Mar 2018 17:49:39 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Andrzej Hajda <a.hajda@samsung.com>
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        dri-devel@lists.freedesktop.org, Inki Dae <inki.dae@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Archit Taneja <architt@codeaurora.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v5 4/6] arm64: dts: exynos: add OF graph between MHL and
 USB connector
Message-ID: <20180306164939.jqpfawa6u2c2xb5e@kozik-lap>
References: <20180227071134.28063-1-a.hajda@samsung.com>
 <CGME20180227071140eucas1p15a8b8443c6d52c5fab79cc82c37dce09@eucas1p1.samsung.com>
 <20180227071134.28063-5-a.hajda@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180227071134.28063-5-a.hajda@samsung.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 27, 2018 at 08:11:32AM +0100, Andrzej Hajda wrote:
> OF graph describes MHL data lanes between MHL and respective USB
> connector.
> 
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> ---
> v5: removed extra parenthesis (kbuild test robot)
> v4: added missing reg property in connector's port node (Krzysztof)
> ---
>  .../boot/dts/exynos/exynos5433-tm2-common.dtsi     | 31 +++++++++++++++++++---
>  1 file changed, 28 insertions(+), 3 deletions(-)
> 

Thanks, applied.

Best regards,
Krzysztof

