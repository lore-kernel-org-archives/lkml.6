Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B4EC46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 03:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 404C2223E3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 03:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="orrqnML0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 404C2223E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbeHJGSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 02:18:06 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45919 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725744AbeHJGSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 02:18:05 -0400
Received: by mail-pg1-f196.google.com with SMTP id f1-v6so3724503pgq.12;
        Thu, 09 Aug 2018 20:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8LNJXGfoz4aW+jcxIouOJzBaHGcjDN+cixQ36T9HpTI=;
        b=orrqnML07VpIpSe77Ro0qQ9mS4FUn9UkxNTHhsEwsRqAQQ8xsP9mcY6ai7c8q20zmY
         phfguOJur+jVJGBQhbqaeUG5XQv2eLPU4vfMDRN+9ckfC3xeqXfAQ/yisGORzo+lQBYA
         i/inhMnLPSI/ZRtSOdyqSk0SYTPbFHsGxLoo6xCbpkTExoxxp8yDjqXhQhTvNgyyV4Oh
         jn9nBzQE+VrU8NckSNSvSmpdKWTqBITzrcwbNS56j5NR6sXIwQ1ju1akbVuik1pSJQht
         LK4OYc9+5fWLMgRMcwPkq/NVBkB6NOBHPyw9is6nFADJGdToVWTRQzNUvaKY6CWKm5Ik
         uC8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8LNJXGfoz4aW+jcxIouOJzBaHGcjDN+cixQ36T9HpTI=;
        b=AeUWAieR2oir6nXbMHnC713L6iCuvFqKEChbS1Mv6xj2gREio6z9adrcACFfIWO3mk
         R8MQepJ3LYS7ujmz+vae2swDsfN3j+dIIaEL508Eu12ygjkqfVGcvE9CfC8lqdCL6L+/
         f/s0lXZKtr2p90BReA/wZIRWf6YbcgFkjuD9rPQZqtM4kge9F1c73Lp/iiGSgi1LIITT
         kLBRxhJUQHNRSHueuy3Q5Bp5RRgkBmvuQcI3CoDgbF3VKGe0gyDWjM0QyEE/lMXZNhZi
         VxLOnCGH9ucvY81TrC0Oe3FRxhF85BissDAdY/gB75zXfqRGnTkTuQQuPvdlkikm8823
         UonQ==
X-Gm-Message-State: AOUpUlG5S2mexXbfaHUs1LLVm/5Vc5D0eV1qPJlnUModMi9bpRSBVhsk
        2yLvoCQuEJjPHhVO6lAwmxA=
X-Google-Smtp-Source: AA+uWPyKHLKWuG1YMGmDWA+HotjuurZcTNlci+kNKHT9jfzUDPCTyK8lcUX7VI8DIY7lrgQqaGbiwQ==
X-Received: by 2002:a63:2906:: with SMTP id p6-v6mr4797460pgp.204.1533873006868;
        Thu, 09 Aug 2018 20:50:06 -0700 (PDT)
Received: from gmail.com (cpe-98-150-136-16.hawaii.res.rr.com. [98.150.136.16])
        by smtp.gmail.com with ESMTPSA id v22-v6sm21033213pfi.60.2018.08.09.20.50.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 20:50:05 -0700 (PDT)
Date:   Thu, 9 Aug 2018 17:50:03 -1000
From:   Joey Pabalinas <joeypabalinas@gmail.com>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Joey Pabalinas <joeypabalinas@gmail.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Daniel Martin <consume.noise@gmail.com>
Subject: Re: [PATCH 2/4] HID: multitouch: don't check
 HID_GROUP_MULTITOUCH_WIN_8 for serial protocol
Message-ID: <20180810035003.hga4n72rl5e2c4hg@gmail.com>
References: <cover.1530402641.git.joeypabalinas@gmail.com>
 <0aaacf083be5b68a830f9e174f9abee3b00c5a51.1530402641.git.joeypabalinas@gmail.com>
 <CAO-hwJJpAfvvP+s9Cqmi8v7pHsEw3tKTrySQaEg8TUzPTFcQfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7stbl6j5qdp3x27t"
Content-Disposition: inline
In-Reply-To: <CAO-hwJJpAfvvP+s9Cqmi8v7pHsEw3tKTrySQaEg8TUzPTFcQfA@mail.gmail.com>
User-Agent: NeoMutt/20180716-169-191348
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7stbl6j5qdp3x27t
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 03, 2018 at 10:16:01AM +0200, Benjamin Tissoires wrote:
> There is a tiny difference between the HID group (this device looks
> like it is used as a Win 8 device) and the device class (this is
> effectively a Win8 device)
>=20
> It makes sense to remove this check for Win8 devices, but I don't
> think it should be done for all devices.
>=20
> All in all, it won't change much.

Hm, that sounds sane. I'll do a bit more research on this and see if
restricting it to just Win8 devices is simple enough to be worthwhile.

--=20
Cheers,
Joey Pabalinas

--7stbl6j5qdp3x27t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEKlZXrihdNOcUPZTNruvLfWhyVBkFAlttC2oACgkQruvLfWhy
VBkbEBAAqsuBA3i2LN1qeeT8ZvjBOfJVUG+MK/wEOkRrtHas3VVc2LoYQM4MGKY2
/gcFjQQWqRJ4VCQ/YrahVMSV83xmVOTMVmmPQXsstJCZPPjUWNa2TFNF7iiafToa
n6UBzT6un5Y6Bqy2HTXN9v1rzoHGb0nw8f2LfW63hnWY1x5LWrb4AmrFVa+XfzLa
+sqM4x/NBnM7nZ12LEaygoiI7xlCxrFdeeFi3XpI7LZAN3CRFGHqJY7K3CfMle1X
k7YCS1wCigEK6Ep68pVKjY6F5xrIB18kYOBZfoH3ykzG01XZq3iFwRQwl4qrNOAE
7kgozmF76kT96e8i7T7aE/Xpf4KC+d2wmtLbx+yNKrptEWKRZKubTpLv5EtHpbhA
Ij5ODdpO3/Gr4efN/EDh+UgxMR3qbMQnC0Dg93BvUbMW+4I9JXJX/ADPQzvSbout
EfU2H/11UMkW/h0OihBhhHc463tHD075ugGyc46zhTet6LjG4DEWMKXG9bOS9sov
/nqJ8laNdvyY1Thk6zJnlDMfLbPIDSjZed/sJQ8Oi44gAJKUxtFiPQsSbh2C84eb
SL14d04vIgA30+Edj6P6PgjTVRaacwv5kyh82s1VogS5B1MXC/Q3yLD4+k8P/acQ
tDyUls1Y0PCUmRKpcJEDWUZgfAI0IiGVgHgv6CN3sRPFFT6HM7Q=
=TYpt
-----END PGP SIGNATURE-----

--7stbl6j5qdp3x27t--
