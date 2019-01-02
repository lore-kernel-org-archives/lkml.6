Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB360C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 10:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B8052075B
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 10:25:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729347AbfABKZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 05:25:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38140 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728451AbfABKZB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 05:25:01 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A9F58D4E56;
        Wed,  2 Jan 2019 10:25:00 +0000 (UTC)
Received: from localhost (ovpn-116-137.ams2.redhat.com [10.36.116.137])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9F499608DC;
        Wed,  2 Jan 2019 10:24:56 +0000 (UTC)
Date:   Wed, 2 Jan 2019 10:24:55 +0000
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Cornelia Huck <cohuck@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        miklos@szeredi.hu, sweil@redhat.com, swhiteho@redhat.com
Subject: Re: [PATCH 18/52] virtio-fs: Map cache using the values from the
 capabilities
Message-ID: <20190102102455.GF24009@stefanha-x1.localdomain>
References: <20181213100058.GC2313@work-vm>
 <96d9ea85-ddf3-3331-77ce-124475b26da4@redhat.com>
 <20181213121548.GN2313@work-vm>
 <0f1b43f6-57e3-c6d2-7ffe-cf783e125a7b@redhat.com>
 <20181213133823.2272736b.cohuck@redhat.com>
 <20181214134434.GA3882@stefanha-x1.localdomain>
 <cf910f77-203c-8efd-fed1-6b041b078d63@redhat.com>
 <20181217145638.GH6785@stefanha-x1.localdomain>
 <20181218181358.3bc2615a.cohuck@redhat.com>
 <4a870d9c-8c46-7f2e-4947-a3913a824d14@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="xaMk4Io5JJdpkLEb"
Content-Disposition: inline
In-Reply-To: <4a870d9c-8c46-7f2e-4947-a3913a824d14@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 02 Jan 2019 10:25:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xaMk4Io5JJdpkLEb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 18, 2018 at 06:25:27PM +0100, David Hildenbrand wrote:
> On 18.12.18 18:13, Cornelia Huck wrote:
> > On Mon, 17 Dec 2018 14:56:38 +0000
> > Stefan Hajnoczi <stefanha@redhat.com> wrote:
> >=20
> >> On Mon, Dec 17, 2018 at 11:53:46AM +0100, David Hildenbrand wrote:
> >>> On 14.12.18 14:44, Stefan Hajnoczi wrote: =20
> >>>> On Thu, Dec 13, 2018 at 01:38:23PM +0100, Cornelia Huck wrote: =20
> >>>>> On Thu, 13 Dec 2018 13:24:31 +0100
> >>>>> David Hildenbrand <david@redhat.com> wrote:
> >=20
> >>>>>> As s390x does not have the concept of memory mapped io (RAM is RAM,
> >>>>>> nothing else), this is not architectured. vitio-ccw can therefore =
not
> >>>>>> define anything similar like that. However, in virtual environment=
s we
> >>>>>> can do whatever we want on top of the pure transport (e.g. on the =
virtio
> >>>>>> layer).
> >>>>>>
> >>>>>> Conny can correct me if I am wrong. =20
> >>>>>
> >>>>> I don't think you're wrong, but I haven't read the code yet and I'm
> >>>>> therefore not aware of the purpose of this BAR.
> >>>>>
> >>>>> Generally, if there is a memory location shared between host and gu=
est,
> >>>>> we need a way to communicate its location, which will likely differ
> >>>>> between transports. For ccw, I could imagine a new channel command
> >>>>> dedicated to exchanging configuration information (similar to what
> >>>>> exists today to communicate the locations of virtqueues), but I'd
> >>>>> rather not go down this path.
> >>>>>
> >>>>> Without reading the code/design further, can we use one of the
> >>>>> following instead of a BAR:
> >>>>> - a virtqueue;
> >>>>> - something in config space?
> >>>>> That would be implementable by any virtio transport. =20
> >>>>
> >>>> The way I think about this is that we wish to extend the VIRTIO devi=
ce
> >>>> model with the concept of shared memory.  virtio-fs, virtio-gpu, and
> >>>> virtio-vhost-user all have requirements for shared memory.
> >>>>
> >>>> This seems like a transport-level issue to me.  PCI supports
> >>>> memory-mapped I/O and that's the right place to do it.  If you try to
> >>>> put it into config space or the virtqueue, you'll end up with someth=
ing
> >>>> that cannot be realized as a PCI device because it bypasses PCI bus
> >>>> address translation.
> >>>>
> >>>> If CCW needs a side-channel, that's fine.  But that side-channel is a
> >>>> CCW-specific mechanism and probably doesn't apply to all other
> >>>> transports.
> >>>>
> >>>> Stefan
> >>>>  =20
> >>>
> >>> I think the problem is more fundamental. There is no iommu. Whatever
> >>> shared region you want to indicate, you want it to be assigned a memo=
ry
> >>> region in guest physical memory. Like a DIMM/NVDIMM. And this should =
be
> >>> different to the concept of a BAR. Or am I missing something? =20
> >>
> >> If you implement a physical virtio PCI adapter then there is bus
> >> addressing and an IOMMU and VIRTIO has support for that.  I'm not sure=
 I
> >> understand what you mean by "there is no iommu"?
> >=20
> > For ccw, there is no iommu; channel-program translation is doing
> > similar things. (I hope that is what David meant :)
> >=20
> >>
> >>> I am ok with using whatever other channel to transport such informati=
on.
> >>> But I believe this is different to a typical BAR. (I wish I knew more
> >>> about PCI internals ;) ).
> >>>
> >>> I would also like to know how shared memory works as of now for e.g.
> >>> virtio-gpu. =20
> >>
> >> virtio-gpu currently does not use shared memory, it needs it for future
> >> features.
> >=20
> > OK, that all sounds like we need to define a generic, per transport,
> > device agnostic way to specify shared memory.
> >=20
> > Where is that memory situated? Is it something in guest memory (like
> > virtqueues)? If it is something provided by the device, things will get
> > tricky for ccw (remember that there's no mmio on s390; pci on s390 uses
> > special instructions for that.)
> >=20
>=20
> I am just very very confused right now. What I am struggling with right
> now (Stefan, hope you can clarify it for me):
>=20
> We need some place where this shared memory is located in the guest
> physical memory. On x86 - if I am not wrong - this BAR is placed into
> the reserved memory area between 3 and 4 GB.

Right, the shared memory is provided by the device and does not live in
guest RAM.

> There is no such thing on
> s390x. Because we don't have IO via memory (yet). All we have is one or
> two KVM memory slots filled with all memory.
>=20
> So what we will need on s390x is on the QEMU side such a reserved memory
> region where devices like virtio-fs can reserve a region for shared memor=
y.
>=20
> So it is something like a dimm/nvdimm except that it is smaller and not
> visible to the user directly (via memory backends).

I see.  That makes sense.

Stefan

--xaMk4Io5JJdpkLEb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcLJF3AAoJEJykq7OBq3PII0EH/1WLYdqfHmm+0kFPXDkJu7rW
E9pynkVz0uG9knT9oZ/pFDsBfSHEAlNW9pAv7z2CV0ZzwBOVqUoSyquosKVKs80o
hMoAvT728XV0CcEqYx6tWmeoMYTb/Cy6Su0Crz/zzZMXRc6LIq7eZZ5Nq6OJ0wCv
UPXhE+tuLDPpHR9bw1xAwY8IL6+P5VasQegth0uwVcRSIB87OpkEKyXuyzwTHCu2
kIKuo9SJA8EZfIhERk3p6idS5oKCxPM55wVuEfKtpyvB39p1scdxMHoeblXjDpSh
w8BKJ9ThO5asEsDIpkmPxiCeuGdTqotuODGog955KfwXmJ/TpFEV42drcf7RChg=
=eR0M
-----END PGP SIGNATURE-----

--xaMk4Io5JJdpkLEb--
