Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2484954-1519766783-2-4010409144431439262
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519766783; b=DUlNRfC7EcONUNdzmLYKI+6Vl6xWqKRiZai1ESKx2NgBSzS
    QLo+lO1anaaUYac+ATqqiHWn1DRjN1YmsyuIS3g1FyOLirvRxCpdYQqlsFM4XsmU
    pDOFLMjTfEnLRaKNRtFzO/8R8+PHAG/TXmMhjf9p4mB6CZckR2RHuYcX7baAZCMB
    f5FK537N+408DOWwWdTr3ryeAl4lhBztnjqor4xyOH4itW7HasehUFP13IzxLAHl
    Mq/ut7AolnIXVf/aqYOKg/yL20LyhTAT9vG1SPEKrXzZKC/ATZd+zaF2RWylGgNE
    1bw0fP7VZQpwTlP0laBTLdCODOTbgX9rzNToaVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1519766783; bh=Dga5RAfjyoptSPIqeWkA/AKatM9DQyR+jZkhAx
    gzles=; b=ScmS2wQm7JlVHPxNFVjAC4noFy4PZ+Lfe3CkkqiUXPWLuPzKiO5rdz
    FEUpmOlyjOR6HrFslSxCJQuuzmQZ+TCQeHkI3XuIVQPUeWljLPE8y4/KD9UBTegV
    Q1B2meFqAEyBDt9D0vkI+QHHwr1DJEKhxUTgh3eGNgIRoKLAXKuDso7RmBgpmxdb
    BNIRIfu/s2sRip1+7A3GNFiDyM2hGNDNCvN/yOWrXAGQMEF8px59lhi3L9l1b/p7
    Ce7fXqG18k/hte4vNmHlcQ/8jzQlYjIopw7ZOb8Ou3xnvT5kyouVEbo+6VUe9ZgC
    NRxOchmvH1rAgqmFYelX9bOzvBjLJEKA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751791AbeB0VY6 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 16:24:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:40876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751568AbeB0VY4 (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Tue, 27 Feb 2018 16:24:56 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D6DD21795
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh+dt@kernel.org
X-Google-Smtp-Source: AG47ELtOYzCm3R+J5igkc40cMPdrfLktZSVQq3jmS5JLE3jIU+QMgfSDce3Odh0wKUCzLVgObSOuFG+tKQwky3xkj2I=
MIME-Version: 1.0
In-Reply-To: <20180221085541.14556-5-a.hajda@samsung.com>
References: <CGME20180221085607eucas1p1a08c82fac832049d79705b4222422fa9@eucas1p1.samsung.com>
 <20180221085541.14556-1-a.hajda@samsung.com> <20180221085541.14556-5-a.hajda@samsung.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Tue, 27 Feb 2018 15:24:34 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKGVwvqu36D57WbB7bPMt2tOZmvq+ukFuNHbhgiWYuw-w@mail.gmail.com>
Message-ID: <CAL_JsqKGVwvqu36D57WbB7bPMt2tOZmvq+ukFuNHbhgiWYuw-w@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] arm64: dts: exynos: add OF graph between MHL and
 USB connector
To: Andrzej Hajda <a.hajda@samsung.com>
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Inki Dae <inki.dae@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Archit Taneja <architt@codeaurora.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc@vger.kernel.org,
        Linux USB List <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 21, 2018 at 2:55 AM, Andrzej Hajda <a.hajda@samsung.com> wrote:
> OF graph describes MHL data lanes between MHL and respective USB
> connector.
>
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> ---
> v4:
> - added missing reg property in connector's port node (Krzysztof)
> ---
>  .../boot/dts/exynos/exynos5433-tm2-common.dtsi     | 32 ++++++++++++++++++++--
>  1 file changed, 29 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
> index f604f6b1a9c2..2ed506df94d0 100644
> --- a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
> +++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
> @@ -817,9 +817,22 @@
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

These ports are mutually exclusive, right? If so, it should be 1 port
with 2 endpoints. Ports should represent independent data flows.
Something muxed or replicated (1 to many connection) should be be
endpoints.

Rob
