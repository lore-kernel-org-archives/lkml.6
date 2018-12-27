Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 410B4C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 23:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EB8520811
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 23:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733217AbeL0XgZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 18:36:25 -0500
Received: from anholt.net ([50.246.234.109]:41652 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727907AbeL0XgY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 18:36:24 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 1F72310A2767;
        Thu, 27 Dec 2018 15:36:24 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id C-VJAvKEgT5Y; Thu, 27 Dec 2018 15:36:22 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id B403E10A0EA3;
        Thu, 27 Dec 2018 15:36:22 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 2A97B2FE36F3; Thu, 27 Dec 2018 15:36:22 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     David Airlie <airlied@linux.ie>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Eben Upton <eben@raspberrypi.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: Re: [PATCH] drm/vc4: Allow fb modifiers early enough to fill IN_FORMATS property
In-Reply-To: <20181224122551.9912-1-paul.kocialkowski@bootlin.com>
References: <20181224122551.9912-1-paul.kocialkowski@bootlin.com>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date:   Thu, 27 Dec 2018 15:36:20 -0800
Message-ID: <878t0amtjf.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

Paul Kocialkowski <paul.kocialkowski@bootlin.com> writes:

> The KMS mode_config elements are currently configured in vc4_kms_load,
> that is called after all components are binded (component_bind_all).
> However, the CRTC component (for the Pixel Valve) needs to access the
> allow_fb_modifiers element at bind time, when initializing its planes
> through drm_universal_plane_init.
>
> This helpers checks allow_fb_modifiers to decide whether to fill the
> IN_FORMATS property. Because allow_fb_modifiers is still set to false
> at this point, the property is never filled and userspace cannot
> retrieve the combination of supported formats and modifiers.
>
> Fix this by setting allow_fb_modifiers right after calling
> drm_mode_config_init (which initializes the structure), before binding
> the components of the driver.

This makes me wonder if the flag could be removed and replaced with "did
non-NULL modifiers get supplied to plane init?"  I think I've tripped
over this flag in other KMS hacking, too.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlwlYfQACgkQtdYpNtH8
nuiOBw//ectS22fws7UfJU6FIPjXTtTpBBSoCBHV39sR0d4X4/bXl0PGHPeD5PLw
GGMpImve5tSYOH4f1WBUaM+KcrVJcFdFo25qIkiLrjBIY520uqemZfb49Zc9b14B
Q9jV+vz7Vov8mPi/boaEZRGkFGsetRS757nxTIO/P5ZnmrKBZbiCketNRAJZKRfm
5xFdTKOlgHMtHn6SySyAzqSVO2ITuMdqr6AnKcD+Akj75z8Myz66kaXqy7eWXTUo
hzVjMuyqYTQsJsHQYd/Qc2s15w/9rOQPGCyz/vdWT7fd4arV+VBg+RHKgNNYufm1
/RD07yOkby+aTEUYdPfyE6NtoEYDMFG4Nf79JXkRA4QLvMkoX7+3Otuud8Hcx9zH
WcQBDFDBDtGvoZG2fMjAP8umAVTmsrHbLvgNZnAOoLWw01WQAEUsAKCObnaSgdkD
MaAHgugEC0ugiYxDRGPCQSRxdB9ha6VnQgwcz8KVMG8ahU3ZaWoOaRPc3wEx1rX5
Xc2EujotR7U8DY5RmJ6uWtL/+ESrrZGev8CxYnfs8uEBy+1bSBsXA3y3+uXNdXY+
ZCzXBKgQVxM81MJ8I5u5/GbcBuG3WY5GWxFf4qWcWJn8czUSGR0AOB0UiN7vQJbI
tPX65W31eX+FIfet85sntnzjr0L4HOwFJXbd2nOiOyjS0lffOs0=
=1fjQ
-----END PGP SIGNATURE-----
--=-=-=--
