Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1572618-1518700773-2-17560713916919733042
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, T_TVD_MIME_EPI 0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518700772; b=TURnE7iBIzddq/wAfOupwkTBKAgYhZwu2LGXet2ZkGGCfPB
    tvh8Ql1W3s1BvHlCWWOZ7lozk5WYpassnE7Z1r89j/JmyDZNOFn6rzTQEHetOyT9
    RdKqOnuSRG7NpI/4MTzp8x2oiZrfio4LVGg09w3biqZ1eMm46g2FGY8aGXG63hu3
    pGDAwdcIU+7Jfxddavi0RKQX/oMeH8hNKkinudcw2pYwx9+tK5zfcd6bO2iOmWwS
    1weBnPhRKugi5mqTtbhvE4QehXc0Pto/CXf2S2/tvbUU2vQV+wbblG+yZjIvA606
    7hSgcMOVdcGzm05e5stUtLGzROUAkfKoETJxTHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:in-reply-to:references
    :date:message-id:mime-version:content-type:sender:list-id; s=
    arctest; t=1518700772; bh=wNBX0sG7ebnEG2Zzd0tF6I3Wod1WgQL01i6l01
    bmowo=; b=QWpsaseuRbtuGM2G+ZUSHCHl+lss1Q6NJbmkFOQ9DxVrD5ZVDc+FtO
    4vmXe2x1DR4kMbB9lRDdsroUf7hIBU6Mqq3SsEqcwOBEYJ3Wqb7lt3cib7+0XxU+
    LHNcm587yr2QAw3WvgirNlI+0KdCWj/SbX7g4etIoRhAjvcYZVzTxEShfnhyk4Yg
    RAOYwpNTI97jHrx8DotdKGYlSPFX2i7cun1wLKx22m3akF0aR/ofsiJUwfHWiUlY
    F3ATenkdl67vaL8RVUSeUQeuO3nbP5kmNAHD8ojtBMaGSxT4ozW8+qtrxdSG/shj
    /Ai2Cmq7yL9+vc1Aah9GNHXtZYvWolVQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    smime=temperror;
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    smime=temperror;
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031533AbeBONTT (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 08:19:19 -0500
Received: from mga09.intel.com ([134.134.136.24]:51916 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031011AbeBONTR (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Thu, 15 Feb 2018 08:19:17 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,517,1511856000";
   d="asc'?scan'208";a="175464087"
From: Felipe Balbi <balbi@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Richard Weinberger <richard@nod.at>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        iommu@lists.linux-foundation.org, linux-usb@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH/RFC 3/6] usb: gadget: Add NO_DMA dummies for DMA mapping API
In-Reply-To: <1517912092-15470-4-git-send-email-geert@linux-m68k.org>
References: <1517912092-15470-1-git-send-email-geert@linux-m68k.org> <1517912092-15470-4-git-send-email-geert@linux-m68k.org>
Date: Thu, 15 Feb 2018 15:18:42 +0200
Message-ID: <87lgfu8k7h.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Geert Uytterhoeven <geert@linux-m68k.org> writes:
> Add dummies for usb_gadget_{,un}map_request{,_by_dev}(), to allow
> compile-testing if NO_DMA=3Dy.
>
> This prevents the following from showing up later:
>
>     ERROR: "usb_gadget_unmap_request_by_dev" [drivers/usb/renesas_usbhs/r=
enesas_usbhs.ko] undefined!
>     ERROR: "usb_gadget_map_request_by_dev" [drivers/usb/renesas_usbhs/ren=
esas_usbhs.ko] undefined!
>     ERROR: "usb_gadget_map_request" [drivers/usb/mtu3/mtu3.ko] undefined!
>     ERROR: "usb_gadget_unmap_request" [drivers/usb/mtu3/mtu3.ko] undefine=
d!
>     ERROR: "usb_gadget_map_request" [drivers/usb/gadget/udc/renesas_usb3.=
ko] undefined!
>     ERROR: "usb_gadget_unmap_request" [drivers/usb/gadget/udc/renesas_usb=
3.ko] undefined!
>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Should I take this or is it going with the rest of the series? If you
wanna take it through Trivial or something like that:

Acked-by: Felipe Balbi <felipe.balbi@linux.intel.com>

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlqFiLIACgkQzL64meEa
mQbEnBAApRr5RxkJmFnvARTFLuDHKzPVd1pP5TvKUo1bjA83t6xKOt1befuxFq7i
W1jIyPgKCwd60s/fh66xmUFs8VlP9uT9zF2pGNyMREhZ3YAhoMZ7T80S07hGCPp7
fzNOuK1m9AOmWRfdmi2ZaKFGl8zfD7oKIgbgeG7f+Jx+phuhOwMqblNcHZWhglBI
Qm5I8/ol5ALXiLZjfvDMEkVRZeAX9Gyk0g5WcNbZRmcBdXaNFcuRQslyng+pQj+E
lOuCH7EFvV1enHPRccI6pTwqU9IFxnBFpJcLdTElgmPtH3wsLIqQR8p0LMQwvffS
HW66W64uv2+Xx8J8OeATrvmrrnL2lgAedSZ8T1BOrra+H+eB3/QKsUSHC7xQYASo
UPvst7C7AYZrdYOcrH//SKCSfwig0giJFtQrHZXS6RC34vgQJNoXfQifrpqA1NIG
Ll/nGSJG4egDs2wBOBIZ6AWd0dUzlJhE3y65FBxn8DhFsvq7mKyOwgGYWVw3VQwq
mCkfryrAfF+tRwsgl/+/cSSbdNJKqPVg8O+w8CwXqvujhetKhqBMUW/tg47dwfMC
puwmGoEkaaBUDqrU69A88xMtIXo6m+/iwkwo/E6I7J7I2S7AHtrdMxA54YjuHCwt
oGFEXiubsMpWrSnwv6wokrbMse2thFcM5T89g7RGXxk0BcCwmls=
=U0pW
-----END PGP SIGNATURE-----
--=-=-=--
