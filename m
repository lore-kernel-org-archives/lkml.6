Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3975852-1520205615-2-12339216218451838313
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
    t=1520205614; b=XP6LqaybW6CDudpiWcG/ILajAHFqJOaIsSCejHgZGOh2Uof
    DoY5dSiDyNC6hEZFvtywbmTaHEKUoujJsHqPK1BbEJbSbCoXZ7Y524KUErfKUcmj
    oo6bUzE/ngr0cNjHv4R1kVEYEZNWTegVVJG8AHCJ84S7B7vGKbtkqqQbrQFiuKDk
    3HcmRmUBaTsi4wqvFF3KDzbnFA6Oly57ErQW4SqMBM1w1KLqvhl7NR4QE6hAgP7N
    0BcwESpqi4H8WwlNGWx7OouTJg4yeYOg6GaEOD+BrRqmIF5QIe6MmjYoEzfj5Tph
    Vc+pr6TeotOlYYt31xPhPxYHJSdfOPTInks9F6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:mime-version:subject:from
    :in-reply-to:date:cc:content-transfer-encoding:message-id
    :references:to:sender:list-id; s=arctest; t=1520205614; bh=76K5x
    DQ6ouyYJJsGze/LxrJq+0hW929lbEQ+DIqI4KU=; b=YzwHMjNj3yMpufQhyDZ+l
    eUvgtIpK18bO1RvAXl8sgjRJmtgOEfBgXiYA+dOtUCf0PJPRYNLGjmgIm5KUvRSN
    GH0RmDfJVISLQQ59rp/J0xZwWIgUZhnwgWvKX/WVeCuFN704rdACmepY3qTgs0oi
    PGvvyCkaAWNIxNR8nyR8JSoYI4vyGDJb+jUM63tfK2fyTl3Hz/oizqGKu1dNv/zq
    8GJqn3WYOi3EMvWCwSeanOCIlx8i1yvad70r+NvKfw27eWWPltaH2awDn6QuDKIm
    uwiVxSrSzU9NNFrd29li6s8K4y+yPZt4JKlJyP3yM8dPkCYCjuOrL6nr38OMF8ym
    Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=r6ONfPQ8 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=VN4zw2B9;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=r6ONfPQ8 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=VN4zw2B9;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932537AbeCDXTs (ORCPT <rfc822;greg@kroah.com>);
        Sun, 4 Mar 2018 18:19:48 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:46793 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932536AbeCDXTq (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 4 Mar 2018 18:19:46 -0500
X-Google-Smtp-Source: AG47ELvTQkqrPKir6m0JMZoJks7REu0R4yy5uAHvXZUpxPY9L8YKkNBAzGolqu5bp2nFFJhY80b6kQ==
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH AUTOSEL for 4.9 124/219] ARM: dts: rockchip: disable arm-global-timer for rk3188
From: Alexander Kochetkov <al.kochet@gmail.com>
In-Reply-To: <20180303222716.26640-124-alexander.levin@microsoft.com>
Date: Mon, 5 Mar 2018 02:19:42 +0300
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D6AE445D-6A73-4AFE-8642-6F5ADF14D084@gmail.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com> <20180303222716.26640-124-alexander.levin@microsoft.com>
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


> 4 =D0=BC=D0=B0=D1=80=D1=82=D0=B0 2018 =D0=B3., =D0=B2 1:29, Sasha =
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
> index 31f81b265cef..73a200914f0b 100644
> --- a/arch/arm/boot/dts/rk3188.dtsi
> +++ b/arch/arm/boot/dts/rk3188.dtsi
> @@ -530,6 +530,7 @@
>=20
> &global_timer {
> 	interrupts =3D <GIC_PPI 11 0xf04>;
> +	status =3D "disabled";
> };
>=20
> &local_timer {
> --=20
> 2.14.1
