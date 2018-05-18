Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-371457-1526678973-5-5677881268331323866
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES daen, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526678973; b=IHayVw5UOpdPWRkH9Q8Ka4TBI/ggqrp9+uZHdem38l3WYDe96P
    z6AtdDIbSnXhblMwUgSZRmDmpiubE+tzCvJiBltDVp2m0L/74R0sNYGIqsA34Q6m
    Aqw2p6CjODQ86WFWurjc1HYQv+dgfgc31y8Yh+zthNXjCWmowKG8Ubkk+xQDJtES
    +yNLEeOGqgEvqOF3+fMUj+xCRTwCcokl3OxOK1SMotQIXe09QC32nYMNlMIgKW4f
    XDoIx6AO+K6ECkbNFEktlGQFVj6nZmVx8imbveZguRXs1dNrgSGqOVmN1ivA7u3y
    aCc1VWm2jNSPrGBUACBGvF6Zr2ycpr65ZEpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526678973; bh=Lmtt4rThvLWA4NApS624TXlQKPcNen
    LJ/vTiMHmwtiA=; b=Y2z6RyN9wbiofMGvbnXH68M6pDPBS6XCscucfYD0BFoyfv
    M6FlFUVGYTMLtsY9aZXy3wbrr7Fy8UVwF9yFSZaO81MT91EIrF2b0g3gr+WwZS49
    Xe3vbQupbXmWtRoe/AJqE/Yy2v4VKRfjI5xMF3FQTH3f4A7scJ33p1WmBwAsogZ2
    U/xiZAdloaBa/SyxfsmukFG4v+qoyYWg/a8HFfs1rcsUh91h5gd1Nc95o+l1CkMa
    IkQwp7A6+AFo7p0anm835PZX8yQAQL5HSJ82Lhd2iGqNCgSZ3iEnSIg1BQXKpB5o
    DqZhwioDa4UXqQMKJqg167g6PDSF5LELc0IwajAg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=sRHmcEMi;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=sRHmcEMi;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfExbDdIZ8hSLomWcCmqSzl4rxlHySUeNm4IDRTKbcJ7m2cxYP1NchU3RvZwOj4rZ4y6mczNmDEVMWL0EZ7dUU4zeZGmhhiZbUggQMIoWsT934Bvn1oCc
    XqvmfYq0t7iF0QazzZldxx1VGEzcSr/9hH7H5c9KkpIWkEJDLqk7ng6efWCyx1FGzPnehseFAKb6Xki64sU3vu7h9kEmqOuJEaRt1+Ugr1egKRgLoKbEtFpt
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=mpaa-ttXAAAA:8 a=VwQbUJbxAAAA:8 a=hIHQbp0jXra33GgA6JoA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=6heAxKwa5pAsJatQ0mat:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752112AbeERV33 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 18 May 2018 17:29:29 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:41405 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751569AbeERV31 (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 18 May 2018 17:29:27 -0400
X-Google-Smtp-Source: AB8JxZq3pk7gsFzlyibroT/iZRbyzSDllKpfJOQlz+7aR8A+Ca0+qOmzey3xKdaQkDT9aII7zhODCw==
Date: Fri, 18 May 2018 16:29:25 -0500
From: Rob Herring <robh@kernel.org>
To: Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Ryder Lee <ryder.lee@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-usb@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: add MediaTek XS-PHY binding
Message-ID: <20180518212925.GA25632@rob-hp-laptop>
References: <1525932629-10603-1-git-send-email-chunfeng.yun@mediatek.com>
 <1525932629-10603-2-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525932629-10603-2-git-send-email-chunfeng.yun@mediatek.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 10, 2018 at 02:10:28PM +0800, Chunfeng Yun wrote:
> Add a DT binding documentation of XS-PHY for MediaTek SoCs
> with USB3.1 GEN2 controller
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>  .../devicetree/bindings/phy/phy-mtk-xsphy.txt      |  110 ++++++++++++++++++++
>  1 file changed, 110 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-mtk-xsphy.txt

Reviewed-by: Rob Herring <robh@kernel.org>
