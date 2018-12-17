Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 330ABC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01C542133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:56:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387441AbeLQO4q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 09:56:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58130 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726667AbeLQO4p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 09:56:45 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A467EC0495BF;
        Mon, 17 Dec 2018 14:56:44 +0000 (UTC)
Received: from localhost (ovpn-117-177.ams2.redhat.com [10.36.117.177])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1D099277A0;
        Mon, 17 Dec 2018 14:56:39 +0000 (UTC)
Date:   Mon, 17 Dec 2018 14:56:38 +0000
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Cornelia Huck <cohuck@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        miklos@szeredi.hu, sweil@redhat.com, swhiteho@redhat.com
Subject: Re: [PATCH 18/52] virtio-fs: Map cache using the values from the
 capabilities
Message-ID: <20181217145638.GH6785@stefanha-x1.localdomain>
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
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="poemUeGtc2GQvHuH"
Content-Disposition: inline
In-Reply-To: <cf910f77-203c-8efd-fed1-6b041b078d63@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Mon, 17 Dec 2018 14:56:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--poemUeGtc2GQvHuH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 17, 2018 at 11:53:46AM +0100, David Hildenbrand wrote:
> On 14.12.18 14:44, Stefan Hajnoczi wrote:
> > On Thu, Dec 13, 2018 at 01:38:23PM +0100, Cornelia Huck wrote:
> >> On Thu, 13 Dec 2018 13:24:31 +0100
> >> David Hildenbrand <david@redhat.com> wrote:
> >>
> >>> On 13.12.18 13:15, Dr. David Alan Gilbert wrote:
> >>>> * David Hildenbrand (david@redhat.com) wrote: =20
> >>>>> On 13.12.18 11:00, Dr. David Alan Gilbert wrote: =20
> >>>>>> * David Hildenbrand (david@redhat.com) wrote: =20
> >>>>>>> On 13.12.18 10:13, Dr. David Alan Gilbert wrote: =20
> >>>>>>>> * David Hildenbrand (david@redhat.com) wrote: =20
> >>>>>>>>> On 10.12.18 18:12, Vivek Goyal wrote: =20
> >>>>>>>>>> Instead of assuming we had the fixed bar for the cache, use the
> >>>>>>>>>> value from the capabilities.
> >>>>>>>>>>
> >>>>>>>>>> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> >>>>>>>>>> ---
> >>>>>>>>>>  fs/fuse/virtio_fs.c | 32 +++++++++++++++++---------------
> >>>>>>>>>>  1 file changed, 17 insertions(+), 15 deletions(-)
> >>>>>>>>>>
> >>>>>>>>>> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> >>>>>>>>>> index 60d496c16841..55bac1465536 100644
> >>>>>>>>>> --- a/fs/fuse/virtio_fs.c
> >>>>>>>>>> +++ b/fs/fuse/virtio_fs.c
> >>>>>>>>>> @@ -14,11 +14,6 @@
> >>>>>>>>>>  #include <uapi/linux/virtio_pci.h>
> >>>>>>>>>>  #include "fuse_i.h"
> >>>>>>>>>> =20
> >>>>>>>>>> -enum {
> >>>>>>>>>> -	/* PCI BAR number of the virtio-fs DAX window */
> >>>>>>>>>> -	VIRTIO_FS_WINDOW_BAR =3D 2,
> >>>>>>>>>> -};
> >>>>>>>>>> -
> >>>>>>>>>>  /* List of virtio-fs device instances and a lock for the list=
 */
> >>>>>>>>>>  static DEFINE_MUTEX(virtio_fs_mutex);
> >>>>>>>>>>  static LIST_HEAD(virtio_fs_instances);
> >>>>>>>>>> @@ -518,7 +513,7 @@ static int virtio_fs_setup_dax(struct virt=
io_device *vdev, struct virtio_fs *fs)
> >>>>>>>>>>  	struct dev_pagemap *pgmap;
> >>>>>>>>>>  	struct pci_dev *pci_dev;
> >>>>>>>>>>  	phys_addr_t phys_addr;
> >>>>>>>>>> -	size_t len;
> >>>>>>>>>> +	size_t bar_len;
> >>>>>>>>>>  	int ret;
> >>>>>>>>>>  	u8 have_cache, cache_bar;
> >>>>>>>>>>  	u64 cache_offset, cache_len;
> >>>>>>>>>> @@ -551,17 +546,13 @@ static int virtio_fs_setup_dax(struct vi=
rtio_device *vdev, struct virtio_fs *fs)
> >>>>>>>>>>          }
> >>>>>>>>>> =20
> >>>>>>>>>>  	/* TODO handle case where device doesn't expose BAR? */ =20
> >>>>>>>>>
> >>>>>>>>> For virtio-pmem we decided to not go via BARs as this would eff=
ectively
> >>>>>>>>> make it only usable for virtio-pci implementers. Instead, we ar=
e going
> >>>>>>>>> to export the applicable physical device region directly (e.g.
> >>>>>>>>> phys_start, phys_size in virtio config), so it is decoupled fro=
m PCI
> >>>>>>>>> details. Doing the same for virtio-fs would allow e.g. also vir=
tio-ccw
> >>>>>>>>> to make eventually use of this. =20
> >>>>>>>>
> >>>>>>>> That makes it a very odd looking PCI device;  I can see that with
> >>>>>>>> virtio-pmem it makes some sense, given that it's job is to expose
> >>>>>>>> arbitrary chunks of memory.
> >>>>>>>>
> >>>>>>>> Dave =20
> >>>>>>>
> >>>>>>> Well, the fact that your are
> >>>>>>>
> >>>>>>> - including <uapi/linux/virtio_pci.h>
> >>>>>>> - adding pci related code
> >>>>>>>
> >>>>>>> in/to fs/fuse/virtio_fs.c
> >>>>>>>
> >>>>>>> tells me that these properties might be better communicated on the
> >>>>>>> virtio layer, not on the PCI layer.
> >>>>>>>
> >>>>>>> Or do you really want to glue virtio-fs to virtio-pci for all ete=
rnity? =20
> >>>>>>
> >>>>>> No, these need cleaning up; and the split within the bar
> >>>>>> is probably going to change to be communicated via virtio layer
> >>>>>> rather than pci capabilities.  However, I don't want to make our P=
CI
> >>>>>> device look odd, just to make portability to non-PCI devices - so =
it's
> >>>>>> right to make the split appropriately, but still to use PCI bars
> >>>>>> for what they were designed for.
> >>>>>>
> >>>>>> Dave =20
> >>>>>
> >>>>> Let's discuss after the cleanup. In general I am not convinced this=
 is
> >>>>> the right thing to do. Using virtio-pci for anything else than pure
> >>>>> transport smells like bad design to me (well, I am no virtio expert
> >>>>> after all ;) ). No matter what PCI bars were designed for. If we ca=
n't
> >>>>> get the same running with e.g. virtio-ccw or virtio-whatever, it is
> >>>>> broken by design (or an addon that is tightly glued to virtio-pci, =
if
> >>>>> that is the general idea). =20
> >>>>
> >>>> I'm sure we can find alternatives for virtio-*, so I wouldn't expect
> >>>> it to be glued to virtio-pci.
> >>>>
> >>>> Dave =20
> >>>
> >>> As s390x does not have the concept of memory mapped io (RAM is RAM,
> >>> nothing else), this is not architectured. vitio-ccw can therefore not
> >>> define anything similar like that. However, in virtual environments we
> >>> can do whatever we want on top of the pure transport (e.g. on the vir=
tio
> >>> layer).
> >>>
> >>> Conny can correct me if I am wrong.
> >>
> >> I don't think you're wrong, but I haven't read the code yet and I'm
> >> therefore not aware of the purpose of this BAR.
> >>
> >> Generally, if there is a memory location shared between host and guest,
> >> we need a way to communicate its location, which will likely differ
> >> between transports. For ccw, I could imagine a new channel command
> >> dedicated to exchanging configuration information (similar to what
> >> exists today to communicate the locations of virtqueues), but I'd
> >> rather not go down this path.
> >>
> >> Without reading the code/design further, can we use one of the
> >> following instead of a BAR:
> >> - a virtqueue;
> >> - something in config space?
> >> That would be implementable by any virtio transport.
> >=20
> > The way I think about this is that we wish to extend the VIRTIO device
> > model with the concept of shared memory.  virtio-fs, virtio-gpu, and
> > virtio-vhost-user all have requirements for shared memory.
> >=20
> > This seems like a transport-level issue to me.  PCI supports
> > memory-mapped I/O and that's the right place to do it.  If you try to
> > put it into config space or the virtqueue, you'll end up with something
> > that cannot be realized as a PCI device because it bypasses PCI bus
> > address translation.
> >=20
> > If CCW needs a side-channel, that's fine.  But that side-channel is a
> > CCW-specific mechanism and probably doesn't apply to all other
> > transports.
> >=20
> > Stefan
> >=20
>=20
> I think the problem is more fundamental. There is no iommu. Whatever
> shared region you want to indicate, you want it to be assigned a memory
> region in guest physical memory. Like a DIMM/NVDIMM. And this should be
> different to the concept of a BAR. Or am I missing something?

If you implement a physical virtio PCI adapter then there is bus
addressing and an IOMMU and VIRTIO has support for that.  I'm not sure I
understand what you mean by "there is no iommu"?

> I am ok with using whatever other channel to transport such information.
> But I believe this is different to a typical BAR. (I wish I knew more
> about PCI internals ;) ).
>=20
> I would also like to know how shared memory works as of now for e.g.
> virtio-gpu.

virtio-gpu currently does not use shared memory, it needs it for future
features.

Stefan

--poemUeGtc2GQvHuH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcF7kmAAoJEJykq7OBq3PIqAcH/igaHFUds+VDUIa5XyiVQFwQ
an/7VkKHmCq9xHHGGIEyAPRP0BGygzmSf0MY4btq/v78tzNQNbk6F70wKQ9oWUG0
NfQpQkfXuzdKgy+4mP45LXXdtBHVDvwDQ4qn/Y/JvREF8i7PurIhZFB5AccalG1T
JUcHlx0p1SB7gPKjCboSfFxowlAWkAQN8aJohBdRcQY9GzQO7ikUwYUSUU5J/FJn
jnlzVX38/6N0aCO1APwm3OHnqOAeY4DvTglynawkTtb8mFXCixOWGfa38O4cX+hb
QKJgCbUPaxQS8XEtE+Az82pUWzwLYfBvXNmGHrhadKG5eW4/GtU1QM/WCPK6nno=
=RT5G
-----END PGP SIGNATURE-----

--poemUeGtc2GQvHuH--
