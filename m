Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4587AC6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 15:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C978020865
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 15:27:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sT/46Itl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C978020865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729104AbeJLXAU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 19:00:20 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37068 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728880AbeJLXAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 19:00:20 -0400
Received: by mail-wm1-f66.google.com with SMTP id 185-v6so13380101wmt.2;
        Fri, 12 Oct 2018 08:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TctTrNA5gQVxcdSHlAIwr2DvndF1/mTxRyvB8bkoYI4=;
        b=sT/46ItlQ2/xU+Jd55G0swEOJleTh7a+GjzcLT7P298hVZIA9f3/AF/gnx+U1ZDsHN
         qkxzF5GwciHE0HjwmbN8hS1Xs3QE1Wfpx6v5obBGsSiQBQl0DdF+gZpjMgbZJqS3OuzB
         YfHkGOdTRuMwO5QQ/A7iBiIwD1+aO0Md1iq9EFTMWTNnXI2fE/HHiA7YoZjarraKSkEN
         R/7YLmfkGOUyKJyy0OTdPv/8TJCpIYCUYX/xAuY9yZsP1GdcDHlLUHluDYyc9RVpIuc4
         RJ9qqS5+KLfleXdHW4TBR0e/C/JcFZ1CxxMQ2pgXJipwpn7LVRJEZRRfUoMH31dIgfn6
         rqdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TctTrNA5gQVxcdSHlAIwr2DvndF1/mTxRyvB8bkoYI4=;
        b=LGvCcbWu60NX5OTDfVft9dVS3MwY1+rmMN3Ts9f9Mi58lnMQqbvlOnxXggTeTfr/D8
         5qi7RiRRJsYwV+Xv1NJ1fVrhPPCXK+I3gOPcAaAk0yKbRs8biJGfiiyl0KLwoQZkLsTt
         /5PiEt/GWy0f3ybv4lKmf/A68hoIsgR98Z3MdG5KdkBGaU8Zm+mhu2qDP3y5xv1g55Jh
         WXwVY8AtD4wmyLprgf6iLc/CAXcLRNmiWgYfhX/2YfFoUT3WkNqMJHdbONHmXflzx+LC
         EI0SgLu+k5ovWOjMFsH7tedsiT3HuSXN3xeUHqmlhssZ/eETJgL1HvW7zQ+OcExhE680
         3CXw==
X-Gm-Message-State: ABuFfoi3BnTpYTflc+EzReY6kPGMF7CMKugoy/pOwmtNv5wa3muDLWmq
        RwWG0P5ttLm3K/mhDveUBXQ=
X-Google-Smtp-Source: ACcGV60wiRSTdscn7QtDqNAhSEtUw5292aGeQBxBX7DpeKs5sS+q7EE63Wsny0frZvRudpcM9OPKEA==
X-Received: by 2002:a1c:7614:: with SMTP id r20-v6mr5823069wmc.52.1539358039338;
        Fri, 12 Oct 2018 08:27:19 -0700 (PDT)
Received: from localhost ([51.15.41.238])
        by smtp.gmail.com with ESMTPSA id x185-v6sm1024275wmg.12.2018.10.12.08.27.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 08:27:18 -0700 (PDT)
Date:   Fri, 12 Oct 2018 16:27:17 +0100
From:   Stefan Hajnoczi <stefanha@gmail.com>
To:     Peng Hao <peng.hao2@zte.com.cn>
Cc:     pbonzini@redhat.com, rkrcmar@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhong.weidong@zte.com.cn,
        wanpeng.li@hotmail.com
Subject: Re: [PATCH V4 2/2]  kvm/x86 : add document for coalesced pio
Message-ID: <20181012152717.GL24267@stefanha-x1.localdomain>
References: <1535645841-111837-1-git-send-email-peng.hao2@zte.com.cn>
 <1535645841-111837-3-git-send-email-peng.hao2@zte.com.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Z1OTrj3C7qypP14j"
Content-Disposition: inline
In-Reply-To: <1535645841-111837-3-git-send-email-peng.hao2@zte.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Z1OTrj3C7qypP14j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 31, 2018 at 12:17:21AM +0800, Peng Hao wrote:
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> ---
>  Documentation/virtual/kvm/00-INDEX          |  2 ++
>  Documentation/virtual/kvm/coalesced-pio.txt | 15 +++++++++++++++
>  2 files changed, 17 insertions(+)
>  create mode 100644 Documentation/virtual/kvm/coalesced-pio.txt
>=20
> diff --git a/Documentation/virtual/kvm/00-INDEX b/Documentation/virtual/k=
vm/00-INDEX
> index 3492458..4b7a37b 100644
> --- a/Documentation/virtual/kvm/00-INDEX
> +++ b/Documentation/virtual/kvm/00-INDEX
> @@ -9,6 +9,8 @@ arm
>  	- internal ABI between the kernel and HYP (for arm/arm64)
>  cpuid.txt
>  	- KVM-specific cpuid leaves (x86).
> +coalesced-pio.txt
> +	- KVM_CAP_COALESCED_PIO

Please document KVM_(UN)REGISTER_COALESCED_MMIO in api.txt instead of
creating a new file.  This is part of the ioctl API and it should be
documented there.

The first patch could document the existing
KVM_(UN)REGISTER_COALESCED_MMIO ioctls and then a second patch could add
PIO.

> diff --git a/Documentation/virtual/kvm/coalesced-pio.txt b/Documentation/=
virtual/kvm/coalesced-pio.txt
> new file mode 100644
> index 0000000..38dac11
> --- /dev/null
> +++ b/Documentation/virtual/kvm/coalesced-pio.txt
> @@ -0,0 +1,15 @@
> +Linux KVM Coalesced PIO:
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> +Coalesced pio is base on coalesced mmio. When the write access to a port

s/base/based/

> +of a device does a simple work (just like setting a register ID or addre=
ss
> +index), then we can use coalesced pio.

"Simple work" is vague and does not describe when or when not to use
coalesced I/O.

I think the point of coalesced I/O is:

  Coalesced I/O is a performance optimization that defers hardware
  register write emulation so that userspace exits are avoided.  It is
  typically used to reduce the overhead of emulating frequently accessed
  hardware registers.

(and then your next paragraph below explains how it works)

> +
> +Setting a port as coalesced pio, the write access to the port don't need=
 to
> +exit to userspace, and just record the value in shared coalesced ring in=
 kernel.

Minor tweaks to the wording and s/port/hardware register/ so this can be
used to document both PIO and MMIO:

  When a hardware register is configured for coalesced I/O, write accesses
  do not exit to userspace and their value is recorded in a shared
  coalesced ring in the kernel.

> +Then following access to another port of the same device which relys on =
the
> +first port's setting or a read access to the first port will set the pre=
vious
> +write value of the first port firstly in usersapce according to the shar=
ed
> +coalesced ring.

Similar tweaks:

  A read access to the hardware register or a write access to another
  hardware register on the same device which relies on the first hardware
  register's value will cause the shared coalesced ring to be processed by
  userspace before emulating the current access.

> +
> +Coalesced pio can be used for rtc 0x70 port, pci-host config port, virti=
o-pci
> +config port and so on.
> --=20
> 1.8.3.1
>=20

--Z1OTrj3C7qypP14j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbwL1VAAoJEJykq7OBq3PIQWkH/RIJnOv6lDT7zYuE4nOlnV9d
0d2NUxXajwLoJ8JSrqS/tULmdShdvt2YQr9s5UzddM6t6FB10zxrFFi74fXoxXpP
CGzMDTJ+P9oBUIWbWagsk/cohtNOTr9xFDrIM43vRejxG87yI3WvVy1VobqcfNa8
Rr4XH7/eSkL5jM9Yy+VvZxgxQwpr8CqgBnh0vqgmTkOTwObav0p0gfF+M5WyyQV5
jrOmz93igtnjyXrp68JitHwlEN7B+tXZ3njUttyqPNOWxlOJDrJFVfGWbPqU4yL+
yoKNXhsQQZjjvoGH8spxbM3NQopOZpWuh+GkR738XvranFAjZFO7R3WkS4iDq/M=
=Bx9E
-----END PGP SIGNATURE-----

--Z1OTrj3C7qypP14j--
