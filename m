Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3EB7C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 11:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A33820868
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 11:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qxSRSl+w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A33820868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbeJLTT6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 15:19:58 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:47053 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbeJLTT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 15:19:58 -0400
Received: by mail-wr1-f68.google.com with SMTP id n11-v6so13019051wru.13;
        Fri, 12 Oct 2018 04:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DBhIKX0Co8MrWBtqcLwJBv8UaQ45Pc2j6GUQwu2qKeo=;
        b=qxSRSl+w72uSOakrxLpJxdGBmianI3mzljT4e19diq7oiXnsmPrfF+RHQ6/+6n297n
         gKl5ISkWoEBO7RddCdcfum1xQyzDjmGWZsALAEh8bwmRHXWRvXrwwnE8x7ugmlLovvD8
         bTrgkp6c8VlsWlRLyQ35GtgOiZrGyAn9/Bn2KNsG3b+gEszPw2Z5N0w+rLotjNHNaVIw
         PU8tcT7mKgri2Sv7ykNDWKT/IbYAPcx+toT+38eXTdYT3Aft1ksn8z1XlTDyPshE8lBT
         sVuUsW1SEAgU0uVLCTUWz6aaTvboMsLFpU/58+BxzxGG9LUd0yQaLqLZcYvgONiYV0sY
         4hWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DBhIKX0Co8MrWBtqcLwJBv8UaQ45Pc2j6GUQwu2qKeo=;
        b=iNC1NJYh9gNhJ+xsA7ggRccvTnSl/xo2oxnFnVUQPStwXO4f+tldwhbFOk+0MBdoYQ
         lJN+S+8MwLYPLs0L0Yvv7e36JB2vlmQoIzn57uzZV5tVgcB++aHS2VdOeab/06WkRgqs
         xuT7Dpb/P4HXVB/mGTcoQk2+0Y7rYxLLEWGS92QhLtrKKvdDD/rXPPe7lIcxIj41FR+p
         5YaJ8LSxBocQXkqRAgqeUSfmXSASbTM2X5PMJ+IbL+xhEtigDgyB4YAok6jHf+pv+hg6
         3gK63NRQYuFinWRexQhNRpBd5kt0y7gaAZm9FnZ8GYGzsWka/Zu8pwEpDoTed5OvlDW3
         JIfw==
X-Gm-Message-State: ABuFfoj+11/dic81Us6RmPx0u6zOwB8uaWQsC9XqDaQyYC89lYyrDgir
        yYJ4ZhhEx2dz9hxdQfqULAY=
X-Google-Smtp-Source: ACcGV605AFO5S7ZYlJaKoI2PckyBgM4p3SnjwW3uxtICzm61FBgnoh9jrMBe9r2f4FqoHnzNGLHYsQ==
X-Received: by 2002:adf:f6c4:: with SMTP id y4-v6mr5400556wrp.79.1539344871471;
        Fri, 12 Oct 2018 04:47:51 -0700 (PDT)
Received: from localhost (p2E5BEEEA.dip0.t-ipconnect.de. [46.91.238.234])
        by smtp.gmail.com with ESMTPSA id i7-v6sm1006444wrb.30.2018.10.12.04.47.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 04:47:50 -0700 (PDT)
Date:   Fri, 12 Oct 2018 13:47:49 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Brian Masney <masneyb@onstation.org>
Cc:     linux-pwm@vger.kernel.org, andy.gross@linaro.org,
        david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jonathan@marek.ca, ctatlor97@gmail.com
Subject: Re: [PATCH v2 0/3] treewide: add vibrator support for various MSM
 SOCs
Message-ID: <20181012114749.GC31561@ulmo>
References: <20180926235112.25710-1-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wxDdMuZNg1r63Hyj"
Content-Disposition: inline
In-Reply-To: <20180926235112.25710-1-masneyb@onstation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wxDdMuZNg1r63Hyj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 26, 2018 at 07:51:09PM -0400, Brian Masney wrote:
> This patch set adds support for the vibrator found on various Qualcomm
> MSM SOCs. This is based on work from:
>=20
> Jonathan Marek from qcom,pwm-vibrator.c in the PostmarketOS repo:
> https://gitlab.com/postmarketOS/linux-postmarketos/commit/7647fb36cb1cbd0=
60f8b52087a68ab93583292b5
>=20
> Jongrak Kwon and Devin Kim from msm_pwm_vibrator.c in the downstream
> Android 3.4.0 sources:
> https://android.googlesource.com/kernel/msm/+/android-msm-lenok-3.10-loll=
ipop-wear-release/drivers/misc/msm_pwm_vibrator.c
>=20
> Driver was tested on a LG Nexus 5 (hammerhead) phone using rumble-test:
> https://git.collabora.com/cgit/user/sre/rumble-test.git/plain/rumble-test=
=2Ec

Looking at all of this it seems like this would be more appropriately
implemented as a force-feedback input device directly. The only reason
you seem to be making this a PWM driver is so that it can be used in
conjunction with pwm-vibrator. The device itself doesn't seem to be a
generic PWM in the way that the PWM framework expects it.

Thierry

--wxDdMuZNg1r63Hyj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvAieUACgkQ3SOs138+
s6Edag//XmsTS/HXwJuq0xpBLVXaiqwnPyZAd64I2AhPdhysIBxVktH/+Bj8+Rt4
XnRe3nksdvLciKBE2k88d4ZSVr2V3tyOHStXpQ9PS/7PhT7dzSfgXrlx4TtAiw86
lCttOns77DoI6aDMEHWaLHl5nfof0OUasE37zxC8TsJlDmZZF2YevVlkNIqZNaV/
htDNlMXOuldwpc6eqjRdQFgPF4jHpQBavFuUFy0rCxTzzwOoFxowWamA32BEUNT2
pNB6SrKjiZkhboGXNCOcWqTDfzPxUJayBWTMFswU73+HzVphpbSVylei7SS7qdcd
Uy7fM96A83eOQpwY1DKJUXoO8CA41ZRmtv5Ltu5WPwU6FeqzpnfFy/VWI2kIjhKP
5x/6Mtumh6AIRkIwUDPfiLhalGDvfkuV8MbduXyZrZptmLF4svWUgSxkhC6SClsx
rdwzj5PhVh9yLjhWHQYH95+dfaKOuw5/5CbON3VOl69msNCcaTP9asyL/MRDzGWe
G8RekvDWHgfqW07Ichp3BPK6tYpbmAgE5fn5zOGCU9kkz+6Soe43ajhJWK1tXuPZ
OGZEDdsOr60b+EKZg8Yi0+BYBbIjDEPBO47EC9SOs7shsLN6CreIJefm9o4FHyEY
IkLiNPsbeGCifxgl4Zk6835MabDBHaiQ6cu+javUoFzCqIRGVWU=
=yKT2
-----END PGP SIGNATURE-----

--wxDdMuZNg1r63Hyj--
