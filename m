Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B04C43334
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 18:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 517882083C
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 18:47:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 517882083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbeIAXAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 19:00:05 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47769 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbeIAXAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 19:00:05 -0400
Received: from mail-pf1-f197.google.com ([209.85.210.197])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <christian.brauner@canonical.com>)
        id 1fwAvN-00067Z-6b
        for linux-kernel@vger.kernel.org; Sat, 01 Sep 2018 18:47:09 +0000
Received: by mail-pf1-f197.google.com with SMTP id h65-v6so8676558pfk.18
        for <linux-kernel@vger.kernel.org>; Sat, 01 Sep 2018 11:47:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TCw+ZEGb5rS4v87+5/ObtXFRIlgApCYPCqx5E5gYts0=;
        b=bP8fSElIHnwCCnHiGxNkLJFKGDZCyELiNG07Bvgq9S4RKfpeChCvI+Vw/6sYfK9V5/
         7xI8U6s0KWlPrvNMfpChO2esYDoRDSka7cyv0aL0YcFB1jAqjp2k7BapeQVzmt938gBg
         BRpe/jxECcqHB6qT8BaUkZ1guwyyfQEzpq7ZxZtUMPtOuipGXwMv1LG2L2hkDv38/Aeo
         /e7OIjNbapkkSRQf91u9sGAfnJds44uDFo9SEKWnBe1beai6LxfPt+s+ZOpJWEkAPPxQ
         joJYo0DX6HiqpbwDbvTgiHPiyh2AnBYpDvpjFM2HbgDKpPY0mJq/2wkUsb3qcjAqM8NR
         tznA==
X-Gm-Message-State: APzg51CGgGGNmLiGCwjdbEwglH8KW67mqYcHRJ40qq6bX302xdsH1lcE
        ZXjmZyK6VNgaqKwwHbi5rzZ3U3hKsYoQSJUuy4YwIRb+qiESxstnGUbNJ9G+2kFrWni/BIlwHYW
        pnjFkEMdtOe6IRhP0JtJU6qV+WFz19SmWZD5M+ZKSxg==
X-Received: by 2002:a63:da04:: with SMTP id c4-v6mr19807177pgh.398.1535827627699;
        Sat, 01 Sep 2018 11:47:07 -0700 (PDT)
X-Google-Smtp-Source: ANB0VdbvlBBjXiMxTd3Nrbk+QjgEm2utK0uOEc1vvtaLp8/LSlakYIYxsrKhjSiJVKqwkxU/TY0+CA==
X-Received: by 2002:a63:da04:: with SMTP id c4-v6mr19807165pgh.398.1535827627458;
        Sat, 01 Sep 2018 11:47:07 -0700 (PDT)
Received: from gmail.com ([208.181.63.202])
        by smtp.gmail.com with ESMTPSA id s27-v6sm31830440pfk.133.2018.09.01.11.47.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 01 Sep 2018 11:47:06 -0700 (PDT)
From:   Christian Brauner <christian.brauner@canonical.com>
X-Google-Original-From: Christian Brauner <christian@brauner.io>
Date:   Sat, 1 Sep 2018 20:47:05 +0200
To:     David Miller <davem@davemloft.net>
Cc:     nicolas.dichtel@6wind.com, ktkhai@virtuozzo.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        gregkh@linuxfoundation.org, dsahern@gmail.com, fw@strlen.de,
        lucien.xin@gmail.com, jakub.kicinski@netronome.com,
        jbenc@redhat.com
Subject: Re: [PATCH net-next 0/5] rtnetlink: add IFA_IF_NETNSID for
 RTM_GETADDR
Message-ID: <20180901184704.lzynbw5zkyiqc6wb@gmail.com>
References: <81379a4f-7149-10ff-2453-886314d0b0c4@virtuozzo.com>
 <20180830144544.tpross4jd6awou4u@gmail.com>
 <ba6a1b18-959e-e307-45fa-e0da9d6f0b0f@6wind.com>
 <20180831.175847.339882322459287210.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="horpuuvvhbzxh57k"
Content-Disposition: inline
In-Reply-To: <20180831.175847.339882322459287210.davem@davemloft.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--horpuuvvhbzxh57k
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 31, 2018 at 05:58:47PM -0700, David Miller wrote:
> From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
> Date: Thu, 30 Aug 2018 17:49:12 +0200
>=20
> > Maybe I would choose a more generic name for the attribute,
> > something that can be used in other netlink families (xfrm,
> > netfilter, ...) also.  What about IFA_TARGET_NSID?
>=20
> Agreed, let's at least try to think ahead about potential future
> uses :)

Sorry for the late reply. Yup, sounds good to me.
But maybe IFA_TARGET_NETNSID to indicate that we're talking network
namespaces here? Seems to me that NSID might give the wrong impression.
I'll send v1 soon. I expect tomorrow or sometime next week.

Thanks!
Christian

--horpuuvvhbzxh57k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE7btrcuORLb1XUhEwjrBW1T7ssS0FAluK3qgACgkQjrBW1T7s
sS2IJxAAtzXn1X3sFo/GlCKHano7UTO6JzszJnkfPgKp0YwEW/+i2Wj18L5kuEaX
bZ8lXLMfOnTfwD9nSXNf10XQfQ2747lOxd8I8qFNcO5wiDm8cfOc2T1JkMLAQwRY
Jf/yqohRfUta1qAQDWIpvLlHd8j9y6ajMvEIj7BR8GpPxrABRThiqh2EVghBhEsg
lKDolbRqIa3ZaInNDdDGW4kVNxTePXYVyLeH5G9Pv/2MqPE/qEd6huw0rftH67Xh
XW7CO9ES5EuNnYD1tU7MK22zZuRSNeHQZbBzKh9LZkK8GC36X0T/2vYQihqvgYdi
bAcfndJ2DBi1tU76u+x0icUDtkZAiCNf9C0fjO+3y+vFenpoaylydeU5Dj62Rxb+
TBW5GZEKw+XGTt0NqJo03eCdlt3n9IZl6JBTOj7Re8Qz2bE2+vAW1gWz38KcxOpc
PPK2ncJiSIRm3o85IJdh7lLbPPQBivhRFnUUotxh9m/sKQL3It6leVRtTIBSlhGl
sa4K22ugF674MjUe0N35MTCFgK7Dh9Trge4rkCG80leQEfKnLuHN/mx4oz9oMvW8
8SY+0UMj0HnKwYj/u2aJuhoAnzWU3KEM27+psJ0HccBAVdzLsbzZSNZ006AcAI7u
azaYwaPryzM+05du4CptfST62LjY0YzPjXxL4mq/z41mmfKtUHg=
=xfT+
-----END PGP SIGNATURE-----

--horpuuvvhbzxh57k--
