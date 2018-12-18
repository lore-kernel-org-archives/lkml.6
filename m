Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B27C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 17:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3611621873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 17:14:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbeLRROY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 12:14:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60374 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727321AbeLRROW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 12:14:22 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 877A5A04AE;
        Tue, 18 Dec 2018 17:14:21 +0000 (UTC)
Received: from gondolin (ovpn-116-115.ams2.redhat.com [10.36.116.115])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3776E105B200;
        Tue, 18 Dec 2018 17:14:13 +0000 (UTC)
Date:   Tue, 18 Dec 2018 18:13:58 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        miklos@szeredi.hu, sweil@redhat.com, swhiteho@redhat.com
Subject: Re: [PATCH 18/52] virtio-fs: Map cache using the values from the
 capabilities
Message-ID: <20181218181358.3bc2615a.cohuck@redhat.com>
In-Reply-To: <20181217145638.GH6785@stefanha-x1.localdomain>
References: <de46a955-813b-355d-49f2-4d866603a8fa@redhat.com>
        <20181213091320.GA2313@work-vm>
        <d8c093db-9dda-1342-41c2-d08083cc150b@redhat.com>
        <20181213100058.GC2313@work-vm>
        <96d9ea85-ddf3-3331-77ce-124475b26da4@redhat.com>
        <20181213121548.GN2313@work-vm>
        <0f1b43f6-57e3-c6d2-7ffe-cf783e125a7b@redhat.com>
        <20181213133823.2272736b.cohuck@redhat.com>
        <20181214134434.GA3882@stefanha-x1.localdomain>
        <cf910f77-203c-8efd-fed1-6b041b078d63@redhat.com>
        <20181217145638.GH6785@stefanha-x1.localdomain>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/9D+IRyZBh7miHo=qk+bbEef"; protocol="application/pgp-signature"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Tue, 18 Dec 2018 17:14:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/9D+IRyZBh7miHo=qk+bbEef
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 17 Dec 2018 14:56:38 +0000
Stefan Hajnoczi <stefanha@redhat.com> wrote:

> On Mon, Dec 17, 2018 at 11:53:46AM +0100, David Hildenbrand wrote:
> > On 14.12.18 14:44, Stefan Hajnoczi wrote: =20
> > > On Thu, Dec 13, 2018 at 01:38:23PM +0100, Cornelia Huck wrote: =20
> > >> On Thu, 13 Dec 2018 13:24:31 +0100
> > >> David Hildenbrand <david@redhat.com> wrote:

> > >>> As s390x does not have the concept of memory mapped io (RAM is RAM,
> > >>> nothing else), this is not architectured. vitio-ccw can therefore n=
ot
> > >>> define anything similar like that. However, in virtual environments=
 we
> > >>> can do whatever we want on top of the pure transport (e.g. on the v=
irtio
> > >>> layer).
> > >>>
> > >>> Conny can correct me if I am wrong. =20
> > >>
> > >> I don't think you're wrong, but I haven't read the code yet and I'm
> > >> therefore not aware of the purpose of this BAR.
> > >>
> > >> Generally, if there is a memory location shared between host and gue=
st,
> > >> we need a way to communicate its location, which will likely differ
> > >> between transports. For ccw, I could imagine a new channel command
> > >> dedicated to exchanging configuration information (similar to what
> > >> exists today to communicate the locations of virtqueues), but I'd
> > >> rather not go down this path.
> > >>
> > >> Without reading the code/design further, can we use one of the
> > >> following instead of a BAR:
> > >> - a virtqueue;
> > >> - something in config space?
> > >> That would be implementable by any virtio transport. =20
> > >=20
> > > The way I think about this is that we wish to extend the VIRTIO device
> > > model with the concept of shared memory.  virtio-fs, virtio-gpu, and
> > > virtio-vhost-user all have requirements for shared memory.
> > >=20
> > > This seems like a transport-level issue to me.  PCI supports
> > > memory-mapped I/O and that's the right place to do it.  If you try to
> > > put it into config space or the virtqueue, you'll end up with somethi=
ng
> > > that cannot be realized as a PCI device because it bypasses PCI bus
> > > address translation.
> > >=20
> > > If CCW needs a side-channel, that's fine.  But that side-channel is a
> > > CCW-specific mechanism and probably doesn't apply to all other
> > > transports.
> > >=20
> > > Stefan
> > >  =20
> >=20
> > I think the problem is more fundamental. There is no iommu. Whatever
> > shared region you want to indicate, you want it to be assigned a memory
> > region in guest physical memory. Like a DIMM/NVDIMM. And this should be
> > different to the concept of a BAR. Or am I missing something? =20
>=20
> If you implement a physical virtio PCI adapter then there is bus
> addressing and an IOMMU and VIRTIO has support for that.  I'm not sure I
> understand what you mean by "there is no iommu"?

For ccw, there is no iommu; channel-program translation is doing
similar things. (I hope that is what David meant :)

>=20
> > I am ok with using whatever other channel to transport such information.
> > But I believe this is different to a typical BAR. (I wish I knew more
> > about PCI internals ;) ).
> >=20
> > I would also like to know how shared memory works as of now for e.g.
> > virtio-gpu. =20
>=20
> virtio-gpu currently does not use shared memory, it needs it for future
> features.

OK, that all sounds like we need to define a generic, per transport,
device agnostic way to specify shared memory.

Where is that memory situated? Is it something in guest memory (like
virtqueues)? If it is something provided by the device, things will get
tricky for ccw (remember that there's no mmio on s390; pci on s390 uses
special instructions for that.)

--Sig_/9D+IRyZBh7miHo=qk+bbEef
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw9DWbcNiT/aowBjO3s9rk8bwL68FAlwZKtYACgkQ3s9rk8bw
L69vgRAAj9BVcoVfCIc4Aoyf/doQcUfdv2JytRFYbJFlHKvWWWoA6MePTWchtico
BNPjr1QC0dDHCBC3m9ubm/EX1jIclQlX/VUEy55/f7REMKus7tLJLvekxqLHjKFW
i8DdG2yfy1pyJchq76nbvpeYkO9NldX0JWOD4bcfxuuREjKGiLOVWP9jUt0HzNCd
OZr7br2w1YRh1t2Zr0K75aW8qnMSv0Rbh7e4aQJK6TDfEszP7Ne5/0YcmDZSKWbI
SzoCHiRGC8W8peZYBTtX18lvBHYtoNKr4uHDIXnKa2BC59KVZOYE7zJNplzE5FqE
CwoyxQKnDbEpeeUl2m+cmrKpMp8ATanzdd0ien6DaufgnOmOraCvXlk7LWNDrCjH
KxGMfbG6JLxQdECCXV67Rh6tR0NPWADzNJZ/mnBrUDdZ8iJ/C/lLiv5EAzX7Mn4D
uS+guDA07fPa6aZATP4QxjiKW7HzZ4SuNOAt+48TP9iqohzcUWws9rRWNd7HQ1ru
SSeffxLLsq9CCOjvdhyCSTo7T6QiexvZat6+LDHJi9rzNgXv/iqUBp7UY77gfVoO
BtKk8iwyaz3LvDM3GU8ECco1gmr7odzu08SvO4x1yuJ41pyu7QNvNNH/YEy15qxa
pn80JriRNy2oXSLN6MCmKmNffTSsbbdvnpMFRJapjm1bYk6I/jo=
=TIKw
-----END PGP SIGNATURE-----

--Sig_/9D+IRyZBh7miHo=qk+bbEef--
