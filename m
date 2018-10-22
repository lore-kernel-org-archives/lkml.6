Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86898C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 19:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 692A220651
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 19:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3/rLwsf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 692A220651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=darnok.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbeJWDxA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 23:53:00 -0400
Received: from mail-yb1-f172.google.com ([209.85.219.172]:46661 "EHLO
        mail-yb1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728383AbeJWDxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 23:53:00 -0400
Received: by mail-yb1-f172.google.com with SMTP id o8-v6so16662422ybk.13
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 12:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=xwqwbFIc57OxqueNKZ4+hU+X5+/n6mO0Ob8fO/JYM9s=;
        b=M3/rLwsfJkmc8M9gwhSbrtg+V0QbQvWKQXgiMRbUVWkaIWzcB0uBWVcxtUyZVMc7Kj
         JSpmAV/ubt2On02ioalbWaWmXb8eiLt56YwTcorR0f4QWIWmn07IyLPfzAMFIvfedisP
         S+OKnzthWwBMRYZuAOb+nQN7z2HcCf00XEkqoT4SIVcglbrCuOpiw/FlkxRL8WSsQXAT
         AvlauOcxy+4BZzJqX5PELta/BAZo+yMckTEUg9Zv0VooymlyS0Q6gJtBIzausSSl2wSo
         6xBdvgY1f3SdmJhXEBcBCOTKVuANGVOQ9CHM3ORvTXWVqR5t2atLbrf1CuVCir5vh6cy
         pqJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=xwqwbFIc57OxqueNKZ4+hU+X5+/n6mO0Ob8fO/JYM9s=;
        b=dMLMsDfZFq/sIQBrF03HlYLgwLyGN5MGOtFTDxCMHFRa+WnTPMvMNkdaAP8zbacsAI
         +JleF0CiX8l7AbaTRsJQxcYrjzVUhULlVdObjjUALHPqrmYTsXMSdow3vMGmDazBa3cd
         dgeAlBwnAY58yYt9oVRhaMW1g5YNXgG3D5KXa2kjCp4qgSY8q0Lr1P9AcKtOMeHMxe4W
         FN4xiD0DNmiOHbAtpynYOmdnhATezWQ5I/rL7ZcIz7SfwCwiwLejb60cQYDK8OoI0XjQ
         2fP4dbu6PPIMx+wEdDKU+h+MGpmsxFd0i+QfuQZAWGQoHJxIXLwA5DREF57ZFYiFoNCF
         LSaA==
X-Gm-Message-State: AGRZ1gILQW2FSXvAMGUDHtWPee6oCBKzAuaotAGOTB9BmS/uz4heyTBD
        V93W9v8ftRFb6MRP/VPN0R0yja1VF6I=
X-Google-Smtp-Source: AJdET5eBlO0jDXC47Fg/NZLN5hPgmhibHjI4yL0Ku/yEaNnZCAaCv23ipSE0BM8nX1wQhDQvHg/OZw==
X-Received: by 2002:a25:4017:: with SMTP id n23-v6mr7993222yba.244.1540236790003;
        Mon, 22 Oct 2018 12:33:10 -0700 (PDT)
Received: from dhcp-10-175-29-12.vpn.oracle.com (209-6-36-129.s6527.c3-0.smr-cbr2.sbo-smr.ma.cable.rcncustomer.com. [209.6.36.129])
        by smtp.gmail.com with ESMTPSA id 131-v6sm578062ywv.78.2018.10.22.12.33.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Oct 2018 12:33:08 -0700 (PDT)
Date:   Mon, 22 Oct 2018 15:33:06 -0400
From:   Konrad Rzeszutek Wilk <konrad@darnok.org>
To:     xen-devel@lists.xen.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org
Cc:     joe.jin@oracle.com
Subject: [GIT PULL] (xen-swiotlb) stable/for-linus-4.20
Message-ID: <20181022193304.GC20677@dhcp-10-175-29-12.vpn.oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="aVD9QWMuhilNxW9f"
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aVD9QWMuhilNxW9f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please git pull the following branch:

 git://git.kernel.org/pub/scm/linux/kernel/git/konrad/swiotlb.git stable/for-linus-4.20

which has one tiny fix for the Xen SWIOTLB mechanism that occasionally happened with
devices that didn't allocate size in power of two but rather some odd
sizes. We neglected to make the memory coherent leading to all kinds of fun crashes.

Thank you!

 drivers/xen/swiotlb-xen.c | 6 ++++++
 1 file changed, 6 insertions(+)

Joe Jin (1):
      xen-swiotlb: use actually allocated size on check physical continuous


--aVD9QWMuhilNxW9f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbziXwAAoJEFKlDoTx2wm/3h0P/08jrW+pGUKUgQcj2iatRAQN
ch6VpHK1zY8xbsDYojvT2o9QOhOCS8ucoyDp3JeVtG8A/7G1Qw9KrBkF9cyahYDX
vNp4C9+BL2gAWxmvr/4K8PMdxe3JEA9lI4PvNlqPVzS1pMj/dildzMj11RWR4eFM
QGdGC/EVoqA9mQKAifEH/RYM28UchTzjVoxk9gPydm7ecaPM6dpC1a9g/RvrvtiN
ewcnO0esqScBoD0+RlU7Rt0iE2VgDMeLpx2gO8wF64qjUPIy88Y2tG8a0cLxjFjV
EIVPaDR/mgKcJgAxs4f09KPiVrcuYcNXyQEtUpv/G0I9kps+irwJJhdkuwNmYohb
Jb9JyG4Bb4NtoB8wWZs/fV+EAS0Oht/ogo62edU5/lMQHoL7JTdz2+9yO09E4tCF
ezuOUAkFrNVkUAHd1Z1Slw6CCNvIzsQXPMaTfSBzb/mfPHWu13xT39wSO0swdUWk
wogXX0Uy97b/EEUFlQRyy0vYPMZIB1OwGdTZGY22X1mCbZpsh+Eban0rTWmCAZqi
UHLK5Ba7KlxJaERpA3wfR6TLtdItByZY+OKjeBf/PK4xA49H1rzSCYXt9ApQyoQ0
Cioja2GaXyTjRPy33cRfqkGrh1qUE2RGNSVXkrzVnUJm4mWgZr95aJ2G6oeX6XZZ
owofkeKq2rWu8tazFvRD
=DCw6
-----END PGP SIGNATURE-----

--aVD9QWMuhilNxW9f--
