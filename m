Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F392ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 10:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32A4B21526
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 10:09:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PO5T1C/m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32A4B21526
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbeJQSEA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 14:04:00 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35255 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726861AbeJQSEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 14:04:00 -0400
Received: by mail-wm1-f66.google.com with SMTP id e187-v6so1535036wmf.0;
        Wed, 17 Oct 2018 03:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zwglm7Jvrf/ZocPgC3l5PixmTAkqTYCTYJYwRt0I0QY=;
        b=PO5T1C/mUY0t/sD3+wGtMr0H7OK22zhqe9NlEIOFJ4k6RAp/d28DYNDKmced1Na4NJ
         1WAqyAlKQhb4Eu9EzAFoH1uBXYXp3MukrvZ7wvbtuqRlVu5BnaVdob3sy8ybJRaSJu1g
         xtF/T2CdDV34N2fUHz+OQtAoKWdcFwQmejF34jfZpdAvVpFJ1R7uWKRcr08APtVkxx0U
         Nn4Fox7xWFR5FNB/VjEKn/+Zod8XN28NE8EBSLMCZAvqo8aBYg23Ho670R2NXFtOzN0b
         +2B6Q1XuQSmotDlE0i20y9NkLpGZFPtolGWjisFqDixYiqllNfI1aGmsWMOeaI6vBlL6
         Ousg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zwglm7Jvrf/ZocPgC3l5PixmTAkqTYCTYJYwRt0I0QY=;
        b=gQhdKUhly7TJwWuhmqECPxDnSnRk0cUhm5dUz416qZ1/QOl0RCW2Ixk+7qLRr2xBsd
         uvJTDOZtUsrQZwuiAHq6QBTa4OdSxHJSzZ2Bp+pGQDUs95s3XqAv8WiHwXE2o9xr6T0Z
         zjtERCQsmbiEev59hmPzaeZlk8DFBTXGiYIbC7vzEa8CwAGN60e6sViVFCUbCt6jJAHd
         g3whDMHU5T8HXIupou6yL3pY1h8SVHeWnCFYUEti8Cv+0G5h+/v58BZ2TVS7OmbG5Pdn
         I7kbtAk+QptGLuanRG1VOrAczZeiQWud7IdpKBVM7/t3L84nUjP0SBoHN+mvW3i9Fli8
         Fmbw==
X-Gm-Message-State: ABuFfoh/aR59AWGhAXTqHW3W6D7Ou/rqlmanIXXiJgrOcCaFKM4uvKbm
        4hUEKZinSy5YTiVqNycAE7w=
X-Google-Smtp-Source: ACcGV63VJGZOPY9T7+m69w4z7Tq8Q8y45NSp48xT6zTdYff5lTsCEs1qijMkCbwNloTqoB1j5tN5Eg==
X-Received: by 2002:a1c:c012:: with SMTP id q18-v6mr2067337wmf.150.1539770939638;
        Wed, 17 Oct 2018 03:08:59 -0700 (PDT)
Received: from localhost ([51.15.41.238])
        by smtp.gmail.com with ESMTPSA id o130-v6sm1561370wmd.11.2018.10.17.03.08.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 03:08:58 -0700 (PDT)
Date:   Wed, 17 Oct 2018 11:08:57 +0100
From:   Stefan Hajnoczi <stefanha@gmail.com>
To:     Peng Hao <peng.hao2@zte.com.cn>
Cc:     pbonzini@redhat.com, rkrcmar@redhat.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH V5 0/3] introduce coalesced pio support
Message-ID: <20181017100857.GN22755@stefanha-x1.localdomain>
References: <1539472197-111085-1-git-send-email-peng.hao2@zte.com.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="4Y142/9l9nQlBiaj"
Content-Disposition: inline
In-Reply-To: <1539472197-111085-1-git-send-email-peng.hao2@zte.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4Y142/9l9nQlBiaj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 14, 2018 at 07:09:54AM +0800, Peng Hao wrote:
> Coalesced pio is based on coalesced mmio and can be used for some port
> like rtc port, pci-host config port and so on.
>=20
> Specially in case of rtc as coalesced pio, some versions of windows guest
> access rtc frequently because of rtc as system tick. guest access rtc like
> this: write register index to 0x70, then write or read data from 0x71.
> writing 0x70 port is just as index and do nothing else. So we can use
> coalesced pio to handle this scene to reduce VM-EXIT time.
>=20
> When starting and closing a virtual machine, it will access pci-host conf=
ig
> port frequently. So setting these port as coalesced pio can reduce startu=
p=20
> and shutdown time.=20
>=20
> without my patch, get the vm-exit time of accessing rtc 0x70 and piix 0xc=
f8
> using perf tools: (guest OS : windows 7 64bit)
> IO Port Access  Samples Samples%  Time%  Min Time  Max Time  Avg time
> 0x70:POUT        86     30.99%    74.59%   9us      29us    10.75us (+- 3=
=2E41%)
> 0xcf8:POUT     1119     2.60%     2.12%   2.79us    56.83us 3.41us (+- 2.=
23%)
>=20
> with my patch
> IO Port Access  Samples Samples%  Time%   Min Time  Max Time   Avg time
> 0x70:POUT       106    32.02%    29.47%    0us      10us     1.57us (+- 7=
=2E38%)
> 0xcf8:POUT      1065    1.67%     0.28%   0.41us    65.44us   0.66us (+- =
10.55%)
>=20
>=20
> Peng Hao (3):
>   kvm/x86 : add coalesced pio support
>   kvm/x86 : add document for coalesced mmio
>   kvm/x86 : add document for coalesced pio
>=20
>  Documentation/virtual/kvm/api.txt             | 28 +++++++++++++++++++++=
++++++
>  include/uapi/linux/kvm.h                      | 11 +++++++++--
>  virt/kvm/coalesced_mmio.c                     | 12 +++++++++---
>  virt/kvm/kvm_main.c                           |  2 ++
>  4 files changed, 48 insertions(+), 5 deletions(-)

Nice, thanks for documenting the API!

--4Y142/9l9nQlBiaj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbxwo5AAoJEJykq7OBq3PIH10IAMaApryCx6v0aQ0WbgvmZb/8
gO0uSxCKj9L/O4QEAk4C5cv5mmN8qiTnXl21UTPlVeBTUXN2CyNjJc+rEM9r/0k3
YGM281yxB8uNQuGHh1psGFieWRLCvbA/eJSJEHKr3l8JGA/6UwcaWvdtkVMkD4Ps
J8Q8IuiyXIRZBUh8+QlcoHg4J8C1ouopNzl+HzeMSfK6nrbAu6f/9x+DB2ePlqQK
w1SXq3jlzyHTIHmestFpAxZV/I+Tu/nMkvFhRisqzIqJe3v1r+p94YGU0qY2bWP0
kM++MqVM3ujgMvQ6M1gdVLmJ5QW9vI4JNYKMfYB31MESCArOVOk6fd/JpoduelY=
=xifU
-----END PGP SIGNATURE-----

--4Y142/9l9nQlBiaj--
