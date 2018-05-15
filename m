Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2582198-1526386774-2-6004744095730499589
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, RCVD_IN_DNSWL_HI -5, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526386774; b=IlGkw15WCZ/gHe63merf1EgDqBykYq9KTJruZpQzY7oeANiZUg
    jTPX//1hK6/2X2WNr2dmJF5DsqYwHIcsVQkrCoBt0e5+b2gsGakKYa1IIz3QOOiF
    BS465kIF9Bnfpzhfthqj9BWboVu3S7y7iBsjNGhTRGSuggZvWA5AiskzYKwzh5RP
    qxYVFqU8pKRlfWuxF8M4aOWktYtKiwo4qhkxEsQ9pBRa1ZX0O88ImZjLxoZyuMDe
    zqlacP8/nHwSNq6z+pGl1HPn64V+mVKhNTRFP2Z6/okVkjTbXcD6hbjGmsiwkuZ1
    oRHdqGU577qnNcd4Hb2kXacDvPIVDki7aNbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1526386774; bh=DtxwvaSN4XfTIUqqkY5lVtW09dZL2YHk1jA6oLcGn8
    M=; b=J/xdyL0nB4twjGx55y0ckiMzd0tweheOYNMm3nR5XUN/9qdjt83p5PZHsk
    QB9iqhISaNnxsdTznxcxisbKXSTlQGKlCRNCds6szQQnisAxpjr+O8GOmtZcjjQq
    F5fZPDBo9N4oTK0FVhSKo5ZXKKr8HmmhQ77nKBqB+pVFPP//SHVZMDLB01hCEkgu
    24cx2d/GJ/Dtd1fTwHuatXRmR7u0obb37RhR2RKFa2qwzprZCW9wP2+XeoKzL1tu
    Wl83QMtcYIC62U+ornr8P5eGkuykHp8k6eKBeMVTtcbJCRBXGtWYx+9l38rSpmG6
    Fyos3WwPnSO9nFM6/4P+jfNM35yA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=kernel.org header.i=@kernel.org header.b=sFXQt7lL x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=kernel.org header.i=@kernel.org header.b=sFXQt7lL x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKIpNx+X9f89tWr1ynIt1p4fwqle/21LE8P06V47CzmNqy8vZy9bpcg8Hmjtbjh0qZuLnUv57HO4syMuL6nnhmDH5mB3NsjGt8kem+EgAa2EJ6mSkqLt
    nX1KRS+Tz0moNrEGLiPOfnArfkGvp9opRSbltID66+ZcXYe4XQLQvBpZmIKymw8TJvayRl5/XHqYrFYfbnxLvS6E6Mj3ntKepMyUgtKevkM6hVYyUVyAKS/Z
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=hD80L64hAAAA:8 a=VwQbUJbxAAAA:8 a=QswX3IYWN56Kge89GXkA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753211AbeEOMTU (ORCPT <rfc822;greg@kroah.com>);
        Tue, 15 May 2018 08:19:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:46984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753187AbeEOMTS (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Tue, 15 May 2018 08:19:18 -0400
X-Google-Smtp-Source: AB8JxZr4OsqBbMb5BaIkydbLPe3IP7KrjaOk2GpHJTukdTnLAKHHTq1bKxiqGj5e8YZ5BVVoKMFeYT24g5KfwzbXak8=
MIME-Version: 1.0
In-Reply-To: <20180515121239.18192-3-a.hajda@samsung.com>
References: <CGME20180515121251eucas1p160dd3dcff49f0dad845ed6be98f33bbe@eucas1p1.samsung.com>
 <20180515121239.18192-1-a.hajda@samsung.com> <20180515121239.18192-3-a.hajda@samsung.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Tue, 15 May 2018 14:19:15 +0200
X-Gmail-Original-Message-ID: <CAJKOXPdxtek3yhr=LoHYwmqoLGPTZtpONR3iOseCi50ZiY=m_Q@mail.gmail.com>
Message-ID: <CAJKOXPdxtek3yhr=LoHYwmqoLGPTZtpONR3iOseCi50ZiY=m_Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] arm64: dts: exynos: add OF graph between USB-PHY
 and MUIC
To: Andrzej Hajda <a.hajda@samsung.com>
Cc: "open list:DESIGNWARE USB3 DRD IP DRIVER" <linux-usb@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Inki Dae <inki.dae@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org"
        <linux-samsung-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 15, 2018 at 2:12 PM, Andrzej Hajda <a.hajda@samsung.com> wrote:
> OF graph describes USB data lanes between USB-PHY and respective MUIC.
> Since graph is present and DWC driver can use it to get extcon, obsolete
> extcon property can be removed.
>
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> ---
>  .../dts/exynos/exynos5433-tm2-common.dtsi     | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)

As we discussed for v1 - since this was not split into two, I'll apply
it once first patch hits mainline.

Best regards,
Krzysztof
