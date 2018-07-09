Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC44C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07A492084A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UAi1JvVo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07A492084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754508AbeGIIb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 04:31:59 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39580 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754427AbeGIIb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 04:31:56 -0400
Received: by mail-wm0-f65.google.com with SMTP id h20-v6so3878772wmb.4;
        Mon, 09 Jul 2018 01:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZJrxaWyN/9ygbgL3XOTNDQWu5e3vvV07l2mPl2ZFqQQ=;
        b=UAi1JvVo5tpyvWlWUhgjauxWG9Q09JBXD21cY6eJ6KPaUEybrAXX5JLqNKtmJj2QHn
         0EVFbYK8qpbNquvAc+qtt4paA4O8slXqeTLWdfvdVV+majDp6C1zI5M8Xu+10tRunLPL
         QKMdGAHu8/+xGl3fN22uHD3sh1RqTKKFfOn37YJyrhguSc6rG7+WTBFBuykKCKhFx3aY
         oKD6/vF/JpqI0jyjeWABZW/RCVDzf6LIiAIqBp0vgWp+jeHryDKIvvRTEiaxCtmz5+I+
         sLgBykj5GIa0ssB7s1VYku03NOqWU2/vYAnH/w5KwDden7Ew7kRWMl4BvP33oVLpz/CR
         fOVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZJrxaWyN/9ygbgL3XOTNDQWu5e3vvV07l2mPl2ZFqQQ=;
        b=W/Ya0VUr3grBNDKsVQLB6rHwwUQcym+AxPxZvuWjyupXOxTfL9AhPy2X8xs76hddyJ
         kanb9p4ulTirRCRxfEGt0OFmbWdsfHkx3g/1QbRg1/+PbIFe5tz2hzJOeViTTlcAf/7X
         5uvu7Do+ZnlkEEa57bfAx/L8Wx7Pzjr1xktpriqr0kM3CVR1flbehqedmBtpgHPi8WZH
         2zdDaJvkfYP8RsTWGOsZA3YAb2lKr23ZJpW2hU+vnwoHfvOQfi4Fj8pXQptV5GGBCYWO
         Z2mL3vVzaXUghVCUAuYN5Y2V3Vul4Jvisl9S+Ca8LM5YWiwKMl7CvxwJNQ161Hlo1CuM
         AIEA==
X-Gm-Message-State: APt69E1WNC1CFA5WNSVvymwV97Kk3TFnIl/2LuTIuMTldnhiFsp125af
        V/mOkXw4O04mDVPV71kicijqJA==
X-Google-Smtp-Source: AAOMgpfQ0hyPnln8WsAI815DURuUyezHZPlAtI1g3OO/5lCtWFSDPQolE6SQs+xQ9YIWZxo3qztqbw==
X-Received: by 2002:a1c:e3d5:: with SMTP id a204-v6mr11080352wmh.20.1531125114692;
        Mon, 09 Jul 2018 01:31:54 -0700 (PDT)
Received: from localhost (pD9E51B8F.dip0.t-ipconnect.de. [217.229.27.143])
        by smtp.gmail.com with ESMTPSA id 189-v6sm18222903wmd.17.2018.07.09.01.31.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 01:31:53 -0700 (PDT)
Date:   Mon, 9 Jul 2018 10:31:52 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpu: host1x: Check whether size of unpin isn't 0
Message-ID: <20180709083152.GA13963@ulmo>
References: <20180706180236.27896-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline
In-Reply-To: <20180706180236.27896-1-digetx@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 06, 2018 at 09:02:36PM +0300, Dmitry Osipenko wrote:
> Only gather pins are mapped by the Host1x driver, regular BO relocations
> are not. Check whether size of unpin isn't 0, otherwise IOVA allocation at
> 0x0 could be erroneously released.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/gpu/host1x/job.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied to drm/tegra/fixes, thanks.

Thierry

--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAltDHXUACgkQ3SOs138+
s6Fkeg//UWOj65He6hUyHtB7P5dlMypgb/rDk6WBs0tm3Lpgb3dAcmgfv3VHBAcv
iGizXZI+IiMJGTi3gACglJ8f5jvSsn+ff16XK9wkpw36b+uuv2p6zMq3GgkEJNsH
oYvVZfdWsZtejtOaU6OWJaPawIHPtZUgGWIZn/8FpO0fIpF5ckPd7bAvCqPOb/kr
tWWd7WODZQXen6mYjIqqfBqDq57k/9J/arppcBxq6UQoOgBuR38XQdyLvVKznXqw
kjOIoHkZJ7LMIWkYFr5iUiQR/qlHosTVzwjKrxU90NJfEOYcMXM5gIs7561wnfbI
XCtl5Jfb37fdJ1EyFjYYUTdY3kXv0ZYPhIvwF5lGDCJFr+GugE9l5BfLFwt8FiUH
aJ4pb3GsCOaxboiCF40M4QSi91B1eWj4AaMWtY4+hcNDwKGK0QRjS/PzyHkWOkbJ
0CoWnWiip+DQgIy1P4RNrrk18sfBrN4bhZ5qZ+zSmlSEHQ95qr0BEwqZmyiuD4I3
laevMjqeJqAMtK3IJ+FtC3yYJu/Qwf66VqXhvHLOwKnlxAXJdxjNteNOpVsak8iB
NisGWDU0I4g8fx6NTQn4EqZyumtwJ6I7W4IelTjef/fSEUoPjVhGO1mZa15rouKO
UdwR339JRl+g76on2XeRHtSXBO5Qp0hb96e8lIAo84buMZOV+5g=
=GsXO
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--
