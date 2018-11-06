Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 356FDC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E591220685
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pPUGV68M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E591220685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388808AbeKGBGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 20:06:39 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39661 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387480AbeKGBGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 20:06:39 -0500
Received: by mail-wr1-f65.google.com with SMTP id r10-v6so14019662wrv.6;
        Tue, 06 Nov 2018 07:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+qft45vgMFY55relw+50eI6FbDH9aRsas5lW/Sb+q+M=;
        b=pPUGV68MAMDTfYXkdbUUJbnEQ6oY3k/1QTS4XlHzUbdRYN8DrhtbLIB0mPb8E/2k92
         gFUDUECBEYL8lxwYG2E00ZeY7P1oHoGNDv+FNujQCVDaPxnRFbmBYM933Bn9fx+jVPHL
         UfLWFQp/pw59CeWBNSVzLyH5mnxnyt1XuxWSavi1e31utIweY3vip9GnwyuEZMN/D+Wb
         /1EyhWFyfDBe/ibKljd4ECbzHCIaMoI5h5yPz5PLlgUOsZpM1Y+qfTo5gm7B/XSHP1LU
         t0sh4yzKGs0/oVqfI0VOmD713fMg8mzZ7zZY34eXVEEqZCF+vHEcnWtRIL3pByErbNRN
         TgPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+qft45vgMFY55relw+50eI6FbDH9aRsas5lW/Sb+q+M=;
        b=bPsCo9vNRIyQQZU2LEp8Z5r4ProBsal28KSvm1FW/DVNsUrIfY+eEm+nYCm31n06v2
         +PXBirr7at6QtEDR1sfPGJ+rLqzUDcU3GC1JU3OwukZrmeAMjrDov3qvvYkSBAriRQQR
         uJp4XI0MKQkYTP6SFZbs/P3DVqCsf5XhvRwiBkN758EkxiCqxYbsXU4uXK3GqpWYrgSp
         lywzfxSQXYsTJV4/rvzAQAnWu25RepAye4l0CwRr0eQf1hNqH6PadrM9WRRkWb0RyVUu
         jekXfvCwikn0hsHjXSnExZ/472q0tj0CtLVRRdz7BV6I4T12o6XoxaCAFsxj76y1q22t
         iszQ==
X-Gm-Message-State: AGRZ1gIh0dnz8nbjpsjBaGRpI4AghOYvHzQpBrINgKC5OH20a0YJMP4+
        Gd4cOrMaOZv7bVb8cGI2Vcc=
X-Google-Smtp-Source: AJdET5eJOC831kzqNF11sRbdT95Pe6Gq4Hw01a0uKZg5uTw6CiwYPVTKmjW7ZuOXVGxHCcmlnmNIPw==
X-Received: by 2002:adf:f309:: with SMTP id i9-v6mr23315734wro.288.1541518850837;
        Tue, 06 Nov 2018 07:40:50 -0800 (PST)
Received: from localhost ([51.15.41.238])
        by smtp.gmail.com with ESMTPSA id a125-v6sm2200308wmf.8.2018.11.06.07.40.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Nov 2018 07:40:49 -0800 (PST)
Date:   Tue, 6 Nov 2018 15:40:48 +0000
From:   Stefan Hajnoczi <stefanha@gmail.com>
To:     Vitaly Mayatskikh <v.mayatskih@gmail.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Kevin Wolf <kwolf@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, den@virtuozzo.com
Subject: Re: [PATCH 0/1] vhost: add vhost_blk driver
Message-ID: <20181106154048.GB31579@stefanha-x1.localdomain>
References: <20181102182123.29420-1-v.mayatskih@gmail.com>
 <20181102142446-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="CdrF4e02JqNVZeln"
Content-Disposition: inline
In-Reply-To: <20181102142446-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CdrF4e02JqNVZeln
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 02, 2018 at 02:26:00PM -0400, Michael S. Tsirkin wrote:
> On Fri, Nov 02, 2018 at 06:21:22PM +0000, Vitaly Mayatskikh wrote:
> > vhost_blk is a host-side kernel mode accelerator for virtio-blk. The
> > driver allows VM to reach a near bare-metal disk performance. See IOPS
> > numbers below (fio --rw=3Drandread --bs=3D4k).
> >=20
> > This implementation uses kiocb interface. It is slightly slower than
> > going directly through bio, but is simpler and also works with disk
> > images placed on a file system.
> >=20
> > # fio num-jobs
> > # A: bare metal over block
> > # B: bare metal over file
> > # C: virtio-blk over block
> > # D: virtio-blk over file
> > # E: vhost-blk bio over block
> > # F: vhost-blk kiocb over block
> > # G: vhost-blk kiocb over file
> > #
> > #  A     B     C    D    E     F     G
> >=20
> > 1  171k  151k  148k 151k 195k  187k  175k
> > 2  328k  302k  249k 241k 349k  334k  296k
> > 3  479k  437k  179k 174k 501k  464k  404k
> > 4  622k  568k  143k 183k 620k  580k  492k
> > 5  755k  697k  136k 128k 737k  693k  579k
> > 6  887k  808k  131k 120k 830k  782k  640k
> > 7  1004k 926k  126k 131k 926k  863k  693k
> > 8  1099k 1015k 117k 115k 1001k 931k  712k
> > 9  1194k 1119k 115k 111k 1055k 991k  711k
> > 10 1278k 1207k 109k 114k 1130k 1046k 695k
> > 11 1345k 1280k 110k 108k 1119k 1091k 663k
> > 12 1411k 1356k 104k 106k 1201k 1142k 629k
> > 13 1466k 1423k 106k 106k 1260k 1170k 607k
> > 14 1517k 1486k 103k 106k 1296k 1179k 589k
> > 15 1552k 1543k 102k 102k 1322k 1191k 571k
> > 16 1480k 1506k 101k 102k 1346k 1202k 566k
> >=20
> > Vitaly Mayatskikh (1):
> >   Add vhost_blk driver
>=20
>=20
> Thanks!
> Before merging this, I'd like to get some acks from userspace that it's
> actually going to be used - e.g. QEMU block maintainers.

I have CCed Kevin, who is the overall QEMU block layer maintainer.

Also CCing Denis since I think someone was working on a QEMU userspace
multiqueue virtio-blk device for maximum performance.

Previously vhost_blk.ko implementations were basically the same thing as
the QEMU x-data-plane=3Don (dedicated thread using Linux AIO), except they
were using a kernel thread and maybe submitted bios.

The performance differences weren't convincing enough that it seemed
worthwhile maintaining another code path which loses live migration, I/O
throttling, image file formats, etc (all the things that QEMU's block
layer supports).

Two changes since then:

1. x-data-plane=3Don has been replaced with a full trip down QEMU's block
layer (-object iothread,id=3Diothread0 -device
virtio-blk-pci,iothread=3Diothread0,...).  It's slower and not truly
multiqueue (yet!).

So from this perspective vhost_blk.ko might be more attractive again, at
least until further QEMU block layer work eliminates the multiqueue and
performance overheads.

2. SPDK has become available for users who want the best I/O performance
and are willing to sacrifice CPU cores for polling.

If you want better performance and don't care about QEMU block layer
features, could you use SPDK?  People who are the target market for
vhost_blk.ko would probably be willing to use SPDK and it already
exists...

=46rom the QEMU userspace perspective, I think the best way to integrate
vhost_blk.ko is to transparently switch to it when possible.  If the
user enables QEMU block layer features that are incompatible with
vhost_blk.ko, then it should fall back to the QEMU block layer
transparently.

I'm not keen on yet another code path with it's own set of limitations
and having to educate users about how to make the choice.  But if it can
be integrated transparently as an "accelerator", then it could be
valuable.

Stefan

--CdrF4e02JqNVZeln
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJb4bYAAAoJEJykq7OBq3PIE4kH/364LD6soxAHsmgryCsOkfUV
pfJcVPMKdozURNuGEOx3Qm97tF0Ic3ex7kROww+d/P2rJk3d8y9GRvX8FUu4PbwT
fayJe4/uK34y2OAPFRiVGnC1TsiHoJ0yn1W4FFYXzykYRv3Nx2X9Pdj51N56OK0I
Mj4acUDOFcmJqXxqYIN0ixUC4ouhbo7qEZqV7Bfsakoah6f4zZQc7SlAQh5ls3I7
XOD8Ayh7ogQOtZvbrxz5LCPrOk1D+O7GcUU60xgwz5jwW19nFiSSZwUb4f7W5LVM
qzMGW8rD9tPUXA/A2laa8j8IDqrkLHkSHJ2kovGrdUH+cKTuWL8jDUAUQZKSNME=
=AaME
-----END PGP SIGNATURE-----

--CdrF4e02JqNVZeln--
