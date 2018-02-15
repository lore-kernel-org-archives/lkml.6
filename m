Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1463790-1518696910-5-4863159076527413694
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518696909; b=fvI+2Ig7ky2ev2mLtIdmg256llsrmoM7iERm/ku92BkCZ+F
    L9NVAtOOtlA7AvEnOq4xL5mBIHaU8tbS8PpROXg2Nt1q2E+cnTnRC7Xf2nk8kBUA
    khpIOfO+RhqE1eKLnPDTPKiAfHZ77gEFB9canB+b+qKF/KWyidboiW4kmlIj869Y
    Ls/gT4KqUDZW6yUg/ExAF//it71nS4eLmp+Lic0X3WGg+mXI+oAPGT29V3GhnbTe
    iBOMOr/Dl7cAJ4H4wu6BlhkzmhEs+uTPthV1sn0VnvYSGdBHVMdkxvKlPZxzdd+l
    oUW5esEPf2jfrCGC+zs9+dh9QcpwnqEugdz627A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1518696909; bh=ywCf1elOqkxFbfMFpksCRyjCwEvUoOZ2R/Sqwl
    HXbc4=; b=HbUP+Qh9l7bN4DGL6tDi+LfS0aR2ZD1Yj9cy4q+r+d+g6kM/s/sNtJ
    8ZYNCuQeKNkSRjasQu9JnX1tIR67zzGcUqwhxyMTLRRhg96pNj0OYvbGLrfkF2oy
    WXYNJxTK4st53KLp7VcDP5b9oYTdm05w1cQZSseDAB9dVEdJIfT4Ze+m+OcQw4qJ
    7WIlIs85n407wtLQmThZcAfmS5iPeCKRgBSHYCTWWPo0bKN1INKuGV3u/ZyR3yYG
    L2342wqg+y/2QnLlbsksn7xbj3AzXBRThbkX7+MLdcBn0OcDdMt8sUDp4IB0Phw4
    fMzy9EXrlNksayX41Di5UMPuilNJOb1g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968074AbeBOMO6 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 07:14:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:44532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S968029AbeBOMOz (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Thu, 15 Feb 2018 07:14:55 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1746621723
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=krzk@kernel.org
X-Google-Smtp-Source: AH8x227YNb9AxzRBjo1cwTcdDcI0FfAFlQPN1fxZXtLr23W+cmWRUNa1DVes693OPPm4DVwiycgFRRmgV1EV4h4cRKk=
MIME-Version: 1.0
In-Reply-To: <20180215103920.32017-5-a.hajda@samsung.com>
References: <CGME20180215103927eucas1p24785b56277ed6c9fa2fd70058096b944@eucas1p2.samsung.com>
 <20180215103920.32017-1-a.hajda@samsung.com> <20180215103920.32017-5-a.hajda@samsung.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Thu, 15 Feb 2018 13:14:52 +0100
X-Gmail-Original-Message-ID: <CAJKOXPdg81LPOFmxtJmL7hMXGgB2USAOhCz2yjU9obX1jWjEWw@mail.gmail.com>
Message-ID: <CAJKOXPdg81LPOFmxtJmL7hMXGgB2USAOhCz2yjU9obX1jWjEWw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 4/6] arm64: dts: exynos: add OF graph between MHL
 and USB connector
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 15, 2018 at 11:39 AM, Andrzej Hajda <a.hajda@samsung.com> wrote:
> OF graph describes MHL data lanes between MHL and respective USB
> connector.
>
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> ---
>  .../boot/dts/exynos/exynos5433-tm2-common.dtsi     | 31 +++++++++++++++++++---
>  1 file changed, 28 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
> index 7e49fadee412..ef758f7337e9 100644
> --- a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
> +++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
> @@ -779,9 +779,22 @@
>                 clocks = <&pmu_system_controller 0>;
>                 clock-names = "xtal";
>
> -               port {
> -                       mhl_to_hdmi: endpoint {
> -                               remote-endpoint = <&hdmi_to_mhl>;
> +               ports {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +
> +                       port@0 {
> +                               reg = <0>;
> +                               mhl_to_hdmi: endpoint {
> +                                       remote-endpoint = <&hdmi_to_mhl>;
> +                               };
> +                       };
> +
> +                       port@1 {
> +                               reg = <1>;
> +                               mhl_to_musb_con: endpoint {
> +                                       remote-endpoint = <&musb_con_to_mhl>;
> +                               };
>                         };
>                 };
>         };
> @@ -804,6 +817,18 @@
>                                              "usb-b-connector";
>                                 label = "micro-USB";
>                                 type = "micro";
> +
> +                               ports {
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
> +
> +                                       port@3 {

I think you might need here "reg = <3>". Doesn't it produce a warning now?

BR,
Krzysztof

> +                                               musb_con_to_mhl: endpoint {
> +                                                       remote-endpoint = <&mhl_to_musb_con>;
> +                                               };
> +                                       };
> +                               };
> +                       };
>                         };
>                 };
>
> --
> 2.16.1
>
