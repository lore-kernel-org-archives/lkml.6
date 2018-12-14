Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36933C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 13:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A13B20656
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 13:51:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730044AbeLNNvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 08:51:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55672 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729519AbeLNNvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 08:51:25 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9CD2B3083394;
        Fri, 14 Dec 2018 13:51:24 +0000 (UTC)
Received: from gondolin (dhcp-192-187.str.redhat.com [10.33.192.187])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 547DE65F7D;
        Fri, 14 Dec 2018 13:51:17 +0000 (UTC)
Date:   Fri, 14 Dec 2018 14:50:58 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        miklos@szeredi.hu, sweil@redhat.com, swhiteho@redhat.com
Subject: Re: [PATCH 18/52] virtio-fs: Map cache using the values from the
 capabilities
Message-ID: <20181214145058.6071bdac.cohuck@redhat.com>
In-Reply-To: <20181214134434.GA3882@stefanha-x1.localdomain>
References: <20181210171318.16998-1-vgoyal@redhat.com>
        <20181210171318.16998-19-vgoyal@redhat.com>
        <de46a955-813b-355d-49f2-4d866603a8fa@redhat.com>
        <20181213091320.GA2313@work-vm>
        <d8c093db-9dda-1342-41c2-d08083cc150b@redhat.com>
        <20181213100058.GC2313@work-vm>
        <96d9ea85-ddf3-3331-77ce-124475b26da4@redhat.com>
        <20181213121548.GN2313@work-vm>
        <0f1b43f6-57e3-c6d2-7ffe-cf783e125a7b@redhat.com>
        <20181213133823.2272736b.cohuck@redhat.com>
        <20181214134434.GA3882@stefanha-x1.localdomain>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/m6Dqw4lRckVaVy6/rT.lwk9"; protocol="application/pgp-signature"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Fri, 14 Dec 2018 13:51:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/m6Dqw4lRckVaVy6/rT.lwk9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 14 Dec 2018 13:44:34 +0000
Stefan Hajnoczi <stefanha@redhat.com> wrote:

> On Thu, Dec 13, 2018 at 01:38:23PM +0100, Cornelia Huck wrote:
> > On Thu, 13 Dec 2018 13:24:31 +0100
> > David Hildenbrand <david@redhat.com> wrote:
> >  =20
> > > On 13.12.18 13:15, Dr. David Alan Gilbert wrote: =20
> > > > * David Hildenbrand (david@redhat.com) wrote:   =20
> > > >> On 13.12.18 11:00, Dr. David Alan Gilbert wrote:   =20
> > > >>> * David Hildenbrand (david@redhat.com) wrote:   =20
> > > >>>> On 13.12.18 10:13, Dr. David Alan Gilbert wrote:   =20
> > > >>>>> * David Hildenbrand (david@redhat.com) wrote:   =20
> > > >>>>>> On 10.12.18 18:12, Vivek Goyal wrote:   =20
> > > >>>>>>> Instead of assuming we had the fixed bar for the cache, use t=
he
> > > >>>>>>> value from the capabilities.
> > > >>>>>>>
> > > >>>>>>> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > > >>>>>>> ---
> > > >>>>>>>  fs/fuse/virtio_fs.c | 32 +++++++++++++++++---------------
> > > >>>>>>>  1 file changed, 17 insertions(+), 15 deletions(-)
> > > >>>>>>>
> > > >>>>>>> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> > > >>>>>>> index 60d496c16841..55bac1465536 100644
> > > >>>>>>> --- a/fs/fuse/virtio_fs.c
> > > >>>>>>> +++ b/fs/fuse/virtio_fs.c
> > > >>>>>>> @@ -14,11 +14,6 @@
> > > >>>>>>>  #include <uapi/linux/virtio_pci.h>
> > > >>>>>>>  #include "fuse_i.h"
> > > >>>>>>> =20
> > > >>>>>>> -enum {
> > > >>>>>>> -	/* PCI BAR number of the virtio-fs DAX window */
> > > >>>>>>> -	VIRTIO_FS_WINDOW_BAR =3D 2,
> > > >>>>>>> -};
> > > >>>>>>> -
> > > >>>>>>>  /* List of virtio-fs device instances and a lock for the lis=
t */
> > > >>>>>>>  static DEFINE_MUTEX(virtio_fs_mutex);
> > > >>>>>>>  static LIST_HEAD(virtio_fs_instances);
> > > >>>>>>> @@ -518,7 +513,7 @@ static int virtio_fs_setup_dax(struct vir=
tio_device *vdev, struct virtio_fs *fs)
> > > >>>>>>>  	struct dev_pagemap *pgmap;
> > > >>>>>>>  	struct pci_dev *pci_dev;
> > > >>>>>>>  	phys_addr_t phys_addr;
> > > >>>>>>> -	size_t len;
> > > >>>>>>> +	size_t bar_len;
> > > >>>>>>>  	int ret;
> > > >>>>>>>  	u8 have_cache, cache_bar;
> > > >>>>>>>  	u64 cache_offset, cache_len;
> > > >>>>>>> @@ -551,17 +546,13 @@ static int virtio_fs_setup_dax(struct v=
irtio_device *vdev, struct virtio_fs *fs)
> > > >>>>>>>          }
> > > >>>>>>> =20
> > > >>>>>>>  	/* TODO handle case where device doesn't expose BAR? */   =
=20
> > > >>>>>>
> > > >>>>>> For virtio-pmem we decided to not go via BARs as this would ef=
fectively
> > > >>>>>> make it only usable for virtio-pci implementers. Instead, we a=
re going
> > > >>>>>> to export the applicable physical device region directly (e.g.
> > > >>>>>> phys_start, phys_size in virtio config), so it is decoupled fr=
om PCI
> > > >>>>>> details. Doing the same for virtio-fs would allow e.g. also vi=
rtio-ccw
> > > >>>>>> to make eventually use of this.   =20
> > > >>>>>
> > > >>>>> That makes it a very odd looking PCI device;  I can see that wi=
th
> > > >>>>> virtio-pmem it makes some sense, given that it's job is to expo=
se
> > > >>>>> arbitrary chunks of memory.
> > > >>>>>
> > > >>>>> Dave   =20
> > > >>>>
> > > >>>> Well, the fact that your are
> > > >>>>
> > > >>>> - including <uapi/linux/virtio_pci.h>
> > > >>>> - adding pci related code
> > > >>>>
> > > >>>> in/to fs/fuse/virtio_fs.c
> > > >>>>
> > > >>>> tells me that these properties might be better communicated on t=
he
> > > >>>> virtio layer, not on the PCI layer.
> > > >>>>
> > > >>>> Or do you really want to glue virtio-fs to virtio-pci for all et=
ernity?   =20
> > > >>>
> > > >>> No, these need cleaning up; and the split within the bar
> > > >>> is probably going to change to be communicated via virtio layer
> > > >>> rather than pci capabilities.  However, I don't want to make our =
PCI
> > > >>> device look odd, just to make portability to non-PCI devices - so=
 it's
> > > >>> right to make the split appropriately, but still to use PCI bars
> > > >>> for what they were designed for.
> > > >>>
> > > >>> Dave   =20
> > > >>
> > > >> Let's discuss after the cleanup. In general I am not convinced thi=
s is
> > > >> the right thing to do. Using virtio-pci for anything else than pure
> > > >> transport smells like bad design to me (well, I am no virtio expert
> > > >> after all ;) ). No matter what PCI bars were designed for. If we c=
an't
> > > >> get the same running with e.g. virtio-ccw or virtio-whatever, it is
> > > >> broken by design (or an addon that is tightly glued to virtio-pci,=
 if
> > > >> that is the general idea).   =20
> > > >=20
> > > > I'm sure we can find alternatives for virtio-*, so I wouldn't expect
> > > > it to be glued to virtio-pci.
> > > >=20
> > > > Dave   =20
> > >=20
> > > As s390x does not have the concept of memory mapped io (RAM is RAM,
> > > nothing else), this is not architectured. vitio-ccw can therefore not
> > > define anything similar like that. However, in virtual environments we
> > > can do whatever we want on top of the pure transport (e.g. on the vir=
tio
> > > layer).
> > >=20
> > > Conny can correct me if I am wrong. =20
> >=20
> > I don't think you're wrong, but I haven't read the code yet and I'm
> > therefore not aware of the purpose of this BAR.
> >=20
> > Generally, if there is a memory location shared between host and guest,
> > we need a way to communicate its location, which will likely differ
> > between transports. For ccw, I could imagine a new channel command
> > dedicated to exchanging configuration information (similar to what
> > exists today to communicate the locations of virtqueues), but I'd
> > rather not go down this path.
> >=20
> > Without reading the code/design further, can we use one of the
> > following instead of a BAR:
> > - a virtqueue;
> > - something in config space?
> > That would be implementable by any virtio transport. =20
>=20
> The way I think about this is that we wish to extend the VIRTIO device
> model with the concept of shared memory.  virtio-fs, virtio-gpu, and
> virtio-vhost-user all have requirements for shared memory.
>=20
> This seems like a transport-level issue to me.  PCI supports
> memory-mapped I/O and that's the right place to do it.  If you try to
> put it into config space or the virtqueue, you'll end up with something
> that cannot be realized as a PCI device because it bypasses PCI bus
> address translation.
>=20
> If CCW needs a side-channel, that's fine.  But that side-channel is a
> CCW-specific mechanism and probably doesn't apply to all other
> transports.

But virtio-gpu works with ccw right now (I haven't checked what it
uses); can virtio-fs use an equivalent method?

If there's a more generic case to be made for extending virtio devices
with a way to handle shared memory, a ccw for that would be fine. I
just want to avoid adding new ccws for everything as the namespace is
not infinite.

--Sig_/m6Dqw4lRckVaVy6/rT.lwk9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw9DWbcNiT/aowBjO3s9rk8bwL68FAlwTtUMACgkQ3s9rk8bw
L69MKw//elBSh06J/yYuPCu7INiQtkk4URM9Xhe156pAa0V+Q5XHc2XrbyLe4ObM
6cPDbgMNTF0FouClj+wU3QtwjGfUlzhyTvrDgQBULIp3f5ghauzLDAIDdOh7aq/c
SDhITHVQmeFoJL2sr9oj99MrYSVPsbb1n3UeyWrwIu0fy1fYLGyxL7OtjyP6ICaX
DK9vGgo9Da4G/dn+EWjjNtcgyysawkmouW3lUEJDpPavdyuySEXRyr+lNYPM7EDp
1JxXS0jPznkoTko4SHDY8kNX6fWBp/sDAEiPwiMmXlNxbgPY2pyG7+SRu8ZelSQR
qXvKau5AMctC072f/xxHPPHdKG7x5vXA6tLvrfOv8aQA7ycWYBnLx7smD67Yjiok
wEEL4tGroUbBFD+d1N7+b4/hczRGshhzNPliVuzDw+Z5Gms9RG0ISu7/DM6I1oXD
5E126XvvEQ1rjOHLm3R1jcBWN/7hxW1duTaVdsWgbLoI4NVurpR6i2a117BM66Vi
w0PKKfuYAgC5qnVbRnQAbeu2LhkXqza5CzSVHeB+EHxthrVNVWtinfKcDMuzgJyf
HirJoOVYQ1+O1qsd0cIADtsCUkkT0zBLGxxpbkl+Xn836iYxLvjpQIF7iwUZHB+2
OAUGELDBGllyQ1EjHOoue6Zk7nePZWO5bYdvnrf6RS28YNI5V/o=
=IvqF
-----END PGP SIGNATURE-----

--Sig_/m6Dqw4lRckVaVy6/rT.lwk9--
