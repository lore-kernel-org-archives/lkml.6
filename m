Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3970520-1520205613-2-6435477966416715370
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520205612; b=EDYK+jNbdIRwDP83GxgyrExHdy0GKsChoggmzUNAzAW1Ess
    DYXLBblF0MKtaHLyyYlMxNdK8Ad1BE4QEhoaBXBE5u/Vs1T106u/kOQ/WzMFveZ5
    vP1IOzdX+W5TKADq3Ds697NA++zX48fvR+MF+n/kh7KQvO3+ivDjsjQVKLHYzyOL
    12wfp7QyymyW08A9Kx1IHKoR21T6nsBibywvHS1HJws2sKvjk3rMnBzNUzfTrKyG
    sMWzDPFpoTFkcDO0Ui72QdNvTkXPxcIULGESk71ZEt/sODkqXZn8olmy/dB3d+0E
    cX2N8lb1n/CYPA1SCNICfOG0wsRmJpQNMBhO1ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:mime-version:subject:from
    :in-reply-to:date:cc:content-transfer-encoding:message-id
    :references:to:sender:list-id; s=arctest; t=1520205612; bh=6XYiY
    ONej+y8N3OU1NztXqBDYn0lhjiZaWVYn2t6ufI=; b=SdmTuQdSFQGKkDN3cZ7v0
    Tcmm50kD7DnEckoqxTFc6ZfNXEKs7tcP8eGeRzYDFOxWZpQzDfcXqV/SFhGXUnr6
    8u/oFR5BlaaqqCPThJBNQawLSgbOBo2i7ibjPK5SFaiSOGue/tshZwDXZu6xxqqh
    hrDfUqO+oLn9wMBhtCpiq2b0OcJLPS+frhqq6HEvTZPl5blK4i3E3AZz1gFAHwQo
    c9Wb/a8ivvNsFJUkGIYLLRQr0OvcFbpXPdCqKMtSq2+kwU5B88KANbKmckfQfUSD
    cCjQ3fFgDIEXWIERuT0BoQVvQ1vmCeWJL2MJ20ciufnIEBKPJQC8halzTXCBqDkr
    w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=L8dx+laB x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=rMefgDuz;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=L8dx+laB x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=rMefgDuz;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932565AbeCDXUC (ORCPT <rfc822;greg@kroah.com>);
        Sun, 4 Mar 2018 18:20:02 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:46810 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932512AbeCDXT7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 4 Mar 2018 18:19:59 -0500
X-Google-Smtp-Source: AG47ELtL8SoRvGPBLxcsUL/ifvfsVWeSiZljEJV0+Ss21pIzPTHjeU4GWaxpkUXcgE8eaF4tKjcWcQ==
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH AUTOSEL for 4.4 062/115] ARM: dts: rockchip: disable arm-global-timer for rk3188
From: Alexander Kochetkov <al.kochet@gmail.com>
In-Reply-To: <20180303223010.27106-62-alexander.levin@microsoft.com>
Date: Mon, 5 Mar 2018 02:19:56 +0300
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <208E5E7C-3737-44B0-ACEB-5C3F20516EB0@gmail.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com> <20180303223010.27106-62-alexander.levin@microsoft.com>
To: Sasha Levin <Alexander.Levin@microsoft.com>
X-Mailer: Apple Mail (2.3124)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello, Sasha!

Following 2 patches must be applied together with the patch:
5e0a39d0f727b35c8b7ef56ba0724c8ceb006297 =
clocksource/drivers/rockchip_timer: Implement clocksource timer
627988a66aee3c845aa2f1f874a3ddba8adb89d9 ARM: dts: rockchip: Add timer =
entries to rk3188 SoC

Alexander.

> 4 =D0=BC=D0=B0=D1=80=D1=82=D0=B0 2018 =D0=B3., =D0=B2 1:31, Sasha =
Levin <Alexander.Levin@microsoft.com> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=
=D0=BB(=D0=B0):
>=20
> From: Alexander Kochetkov <al.kochet@gmail.com>
>=20
> [ Upstream commit 500d0aa918a2ea6bb918fee8adcf27dc2912bcd1 ]
>=20
> The clocksource and the sched_clock provided by the arm_global_timer
> are quite unstable because their rates depend on the cpu frequency.
>=20
> On the other side, the arm_global_timer has a higher rating than the
> rockchip_timer, it will be selected by default by the time framework
> while we want to use the stable rockchip clocksource.
>=20
> Let's disable the arm_global_timer in order to have the rockchip
> clocksource selected by default.
>=20
> Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> ---
> arch/arm/boot/dts/rk3188.dtsi | 1 +
> 1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/arm/boot/dts/rk3188.dtsi =
b/arch/arm/boot/dts/rk3188.dtsi
> index 6399942f1840..0e5142b6e914 100644
> --- a/arch/arm/boot/dts/rk3188.dtsi
> +++ b/arch/arm/boot/dts/rk3188.dtsi
> @@ -513,6 +513,7 @@
>=20
> &global_timer {
> 	interrupts =3D <GIC_PPI 11 0xf04>;
> +	status =3D "disabled";
> };
>=20
> &local_timer {
> --=20
> 2.14.1
