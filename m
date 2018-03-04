Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3975852-1520205616-2-4661764116682531302
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
    t=1520205615; b=Tfp5D7RQNWJNC69K8fgXYXQ6RHCw4IEbCCBaiTITZHjwUmv
    r0HCb9rZvvTk4N65wDUIFXUGdy5Z67dfASpQsVp10jq11iUsrE1TK5diM8rMEAmb
    eMQ9mYq1ltQ6srfHDKNvOZ7MYbWSyzUSuiSksaRGVlL5VaJAXSQ6dup4WRGEwNAH
    9Fzpv9Fg4ORv6lRLZZ6KV9fmZruCBDJM38g5kYmL8lI6ErbuJJVzyApkvsC3L9lu
    bRalGMVJwmFzJsN5dqIate/Fnr5ILCqEu5Jp23TPLeWLzw+ycOMmCT7e0BEka+l3
    R8MMS/5kOHZHFXnDuvHhQbwvRrqBQ8pZcgZChUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:mime-version:subject:from
    :in-reply-to:date:cc:content-transfer-encoding:message-id
    :references:to:sender:list-id; s=arctest; t=1520205615; bh=28ahy
    ERRPZCsqsKGwx4cbFbxX8QWAz6Qp41p+S5M3OQ=; b=DtDri34iBkmV6ELm4Fn9O
    qFG0QEF6/s1W69GBItDfaLkye74vDLJ2foibe+mNxed/NOp7W/A+yulcKjB/jMrG
    3FBGVjTGMB4p5ODzwR8qde67+AHpw7/Jq0CAfJLqMwAt3qgbXCqFrzFvTef0dqcB
    DC1Mv0On2ULa5L2DPqsWL6jc3PpKVJExdcy1ME35Sz4JUKMWqbxDB6UqcAJ4kVZw
    TyT0DhYyjZsKB6bhzCkj9Bbm59QP9qdOpbPU+EHWUKZulNJrbii8MLvaVoKTmIUQ
    tqWHQd6EJipz3XjnTFLBckemPogeNs5xmADyW/BKWwfRScD1II4SoegWIE+ekkZu
    A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=N/pjJkyX x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Uijo29SJ;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=N/pjJkyX x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Uijo29SJ;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932578AbeCDXUO (ORCPT <rfc822;greg@kroah.com>);
        Sun, 4 Mar 2018 18:20:14 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:42113 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932512AbeCDXUM (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 4 Mar 2018 18:20:12 -0500
X-Google-Smtp-Source: AG47ELvi9Muu8dl7J3y9OFfkgdS+vszqRi5ENsYZU7Bmy9hiAD59DB8KUWafKVeYDah9HaTaesNHJA==
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH AUTOSEL for 3.18 34/63] ARM: dts: rockchip: disable arm-global-timer for rk3188
From: Alexander Kochetkov <al.kochet@gmail.com>
In-Reply-To: <20180303223228.27323-34-alexander.levin@microsoft.com>
Date: Mon, 5 Mar 2018 02:20:09 +0300
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3545DF61-48DF-4C70-9E58-2D9D07BB64E5@gmail.com>
References: <20180303223228.27323-1-alexander.levin@microsoft.com> <20180303223228.27323-34-alexander.levin@microsoft.com>
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

> 4 =D0=BC=D0=B0=D1=80=D1=82=D0=B0 2018 =D0=B3., =D0=B2 1:33, Sasha =
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
> index ddaada788b45..72b0b4cb538f 100644
> --- a/arch/arm/boot/dts/rk3188.dtsi
> +++ b/arch/arm/boot/dts/rk3188.dtsi
> @@ -404,6 +404,7 @@
>=20
> &global_timer {
> 	interrupts =3D <GIC_PPI 11 0xf04>;
> +	status =3D "disabled";
> };
>=20
> &local_timer {
> --=20
> 2.14.1
