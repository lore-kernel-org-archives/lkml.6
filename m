Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D510C5CFC0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 21:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD20D20891
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 21:12:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD20D20891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933387AbeFPVMw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 17:12:52 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:49045 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933319AbeFPVMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 17:12:50 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fUIV5-00024X-GF; Sat, 16 Jun 2018 22:12:47 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fUIUz-00009I-7Y; Sat, 16 Jun 2018 22:12:41 +0100
Message-ID: <3a3f6556adee179a22895f23c000e4c33c4441f7.camel@decadent.org.uk>
Subject: Re: [PATCH 3.16 012/410] scsi: libsas: direct call probe and
 destruct
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Jason Yan <yanaijie@huawei.com>,
        John Garry <john.garry@huawei.com>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 16 Jun 2018 22:12:29 +0100
In-Reply-To: <5B19DC97.505@huawei.com>
References: <lsq.1528380321.279673399@decadent.org.uk>
         <a0338db1-e901-a2f4-8976-307ceeeadd57@huawei.com>
         <f0545b7ddaa198058c7af360ef12688c359b19f9.camel@decadent.org.uk>
         <5B19DC97.505@huawei.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-6ZqCaeeu7LgTUCbB0ekH"
X-Mailer: Evolution 3.28.2-1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-6ZqCaeeu7LgTUCbB0ekH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2018-06-08 at 09:32 +0800, Jason Yan wrote:
> On 2018/6/8 2:18, Ben Hutchings wrote:
> > On Thu, 2018-06-07 at 17:32 +0100, John Garry wrote:
> > > On 07/06/2018 15:05, Ben Hutchings wrote:
> > > > 3.16.57-rc1 review patch.  If anyone has any objections, please let=
 me know.
> > > >=20
> > > > ------------------
> > > >=20
> > >=20
> > > Hi Ben,
> > >=20
> > > I noticed that you are looking to backport this patch to 3.16
> > >=20
> > > I am wondering why you are taking this libsas patch (and a couple oth=
er
> > > libsas patches) in isolation, when these patches were part of a serie=
s
> > > to fix libsas hotplug issues? I'm not sure if cherry-picking certain
> > > patches is ok.
> > >=20
> > > Maybe Jason (cc'ed) can comment further.
> >=20
> > This one apparently fixed a security issue (CVE-2017-18232), though I'm
> > certainly not convinced it's a particularly serious one.
> >=20
> > But please send objections to the list, not just privately.
> >=20
>=20
> Hi Ben,
>=20
> This patch is in the series below. I recommend to backport them=20
> together. If you really want to do this, I'm happy to help you to=20
> backport them.
>=20
> 1689c9367bfa scsi: libsas: notify event PORTE_BROADCAST_RCVD in=20
> sas_enable_revalidation()
> 0558f33c06bb scsi: libsas: direct call probe and destruct
> 517e5153d242 scsi: libsas: use flush_workqueue to process disco events=
=20
> synchronously
> 93bdbd06b164 scsi: libsas: Use new workqueue to run sas event and disco=
=20
> event
> 8eea9dd84e45 scsi: libsas: make the event threshold configurable
> f12486e06ae8 scsi: libsas: shut down the PHY if events reached the thresh=
old
> 1c393b970e0f scsi: libsas: Use dynamic alloced work to avoid sas event lo=
st

Thank you.  I'll drop this single patch for now.

I'll leave it you and the other libsas developers to decide if it is
sensible to backport this series to 3.16 (and other stable branches).

Ben.

> > Ben.
> >=20
> > > Thanks,
> > > John
> > >=20
> > > > From: Jason Yan <yanaijie@huawei.com>
> > > >=20
> > > > commit 0558f33c06bb910e2879e355192227a8e8f0219d upstream.
> > > >=20
> > > > In commit 87c8331fcf72 ("[SCSI] libsas: prevent domain rediscovery
> > > > competing with ata error handling") introduced disco mutex to preve=
nt
> > > > rediscovery competing with ata error handling and put the whole
> > > > revalidation in the mutex. But the rphy add/remove needs to wait fo=
r the
> > > > error handling which also grabs the disco mutex. This may leads to =
dead
> > > > lock.So the probe and destruct event were introduce to do the rphy
> > > > add/remove asynchronously and out of the lock.
> > > >=20
> > > > The asynchronously processed workers makes the whole discovery proc=
ess
> > > > not atomic, the other events may interrupt the process. For example=
,
> > > > if a loss of signal event inserted before the probe event, the
> > > > sas_deform_port() is called and the port will be deleted.
> > > >=20
> > > > And sas_port_delete() may run before the destruct event, but the
> > > > port-x:x is the top parent of end device or expander. This leads to
> > > > a kernel WARNING such as:
> > > >=20
> > > > [   82.042979] sysfs group 'power' not found for kobject 'phy-1:0:2=
2'
> > > > [   82.042983] ------------[ cut here ]------------
> > > > [   82.042986] WARNING: CPU: 54 PID: 1714 at fs/sysfs/group.c:237
> > > > sysfs_remove_group+0x94/0xa0
> > > > [   82.043059] Call trace:
> > > > [   82.043082] [<ffff0000082e7624>] sysfs_remove_group+0x94/0xa0
> > > > [   82.043085] [<ffff00000864e320>] dpm_sysfs_remove+0x60/0x70
> > > > [   82.043086] [<ffff00000863ee10>] device_del+0x138/0x308
> > > > [   82.043089] [<ffff00000869a2d0>] sas_phy_delete+0x38/0x60
> > > > [   82.043091] [<ffff00000869a86c>] do_sas_phy_delete+0x6c/0x80
> > > > [   82.043093] [<ffff00000863dc20>] device_for_each_child+0x58/0xa0
> > > > [   82.043095] [<ffff000008696f80>] sas_remove_children+0x40/0x50
> > > > [   82.043100] [<ffff00000869d1bc>] sas_destruct_devices+0x64/0xa0
> > > > [   82.043102] [<ffff0000080e93bc>] process_one_work+0x1fc/0x4b0
> > > > [   82.043104] [<ffff0000080e96c0>] worker_thread+0x50/0x490
> > > > [   82.043105] [<ffff0000080f0364>] kthread+0xfc/0x128
> > > > [   82.043107] [<ffff0000080836c0>] ret_from_fork+0x10/0x50
> > > >=20
> > > > Make probe and destruct a direct call in the disco and revalidate f=
unction,
> > > > but put them outside the lock. The whole discovery or revalidate wo=
n't
> > > > be interrupted by other events. And the DISCE_PROBE and DISCE_DESTR=
UCT
> > > > event are deleted as a result of the direct call.
> > > >=20
> > > > Introduce a new list to destruct the sas_port and put the port dele=
te after
> > > > the destruct. This makes sure the right order of destroying the sys=
fs
> > > > kobject and fix the warning above.
> > > >=20
> > > > In sas_ex_revalidate_domain() have a loop to find all broadcasted
> > > > device, and sometimes we have a chance to find the same expander tw=
ice.
> > > > Because the sas_port will be deleted at the end of the whole revali=
date
> > > > process, sas_port with the same name cannot be added before this.
> > > > Otherwise the sysfs will complain of creating duplicate filename. S=
ince
> > > > the LLDD will send broadcast for every device change, we can only
> > > > process one expander's revalidation.
> > > >=20
> > > > [mkp: kbuild test robot warning]
> > > >=20
> > > > Signed-off-by: Jason Yan <yanaijie@huawei.com>
> > > > CC: John Garry <john.garry@huawei.com>
> > > > CC: Johannes Thumshirn <jthumshirn@suse.de>
> > > > CC: Ewan Milne <emilne@redhat.com>
> > > > CC: Christoph Hellwig <hch@lst.de>
> > > > CC: Tomas Henzl <thenzl@redhat.com>
> > > > CC: Dan Williams <dan.j.williams@intel.com>
> > > > Reviewed-by: Hannes Reinecke <hare@suse.com>
> > > > Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
> > > > [bwh: Backported to 4.9: adjust context]
> > > > Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> > > > ---
> > > >   drivers/scsi/libsas/sas_ata.c      |  1 -
> > > >   drivers/scsi/libsas/sas_discover.c | 32 +++++++++++++++++--------=
-----
> > > >   drivers/scsi/libsas/sas_expander.c |  8 +++-----
> > > >   drivers/scsi/libsas/sas_internal.h |  1 +
> > > >   drivers/scsi/libsas/sas_port.c     |  3 +++
> > > >   include/scsi/libsas.h              |  3 +--
> > > >   include/scsi/scsi_transport_sas.h  |  1 +
> > > >   7 files changed, 27 insertions(+), 22 deletions(-)
> > > >=20
> > > > --- a/drivers/scsi/libsas/sas_ata.c
> > > > +++ b/drivers/scsi/libsas/sas_ata.c
> > > > @@ -782,7 +782,6 @@ int sas_discover_sata(struct domain_devi
> > > >   	if (res)
> > > >   		return res;
> > > >=20
> > > > -	sas_discover_event(dev->port, DISCE_PROBE);
> > > >   	return 0;
> > > >   }
> > > >=20
> > > > --- a/drivers/scsi/libsas/sas_discover.c
> > > > +++ b/drivers/scsi/libsas/sas_discover.c
> > > > @@ -212,13 +212,9 @@ void sas_notify_lldd_dev_gone(struct dom
> > > >   	}
> > > >   }
> > > >=20
> > > > -static void sas_probe_devices(struct work_struct *work)
> > > > +static void sas_probe_devices(struct asd_sas_port *port)
> > > >   {
> > > >   	struct domain_device *dev, *n;
> > > > -	struct sas_discovery_event *ev =3D to_sas_discovery_event(work);
> > > > -	struct asd_sas_port *port =3D ev->port;
> > > > -
> > > > -	clear_bit(DISCE_PROBE, &port->disc.pending);
> > > >=20
> > > >   	/* devices must be domain members before link recovery and probe=
 */
> > > >   	list_for_each_entry(dev, &port->disco_list, disco_list_node) {
> > > > @@ -294,7 +290,6 @@ int sas_discover_end_dev(struct domain_d
> > > >   	res =3D sas_notify_lldd_dev_found(dev);
> > > >   	if (res)
> > > >   		return res;
> > > > -	sas_discover_event(dev->port, DISCE_PROBE);
> > > >=20
> > > >   	return 0;
> > > >   }
> > > > @@ -353,13 +348,9 @@ static void sas_unregister_common_dev(st
> > > >   	sas_put_device(dev);
> > > >   }
> > > >=20
> > > > -static void sas_destruct_devices(struct work_struct *work)
> > > > +void sas_destruct_devices(struct asd_sas_port *port)
> > > >   {
> > > >   	struct domain_device *dev, *n;
> > > > -	struct sas_discovery_event *ev =3D to_sas_discovery_event(work);
> > > > -	struct asd_sas_port *port =3D ev->port;
> > > > -
> > > > -	clear_bit(DISCE_DESTRUCT, &port->disc.pending);
> > > >=20
> > > >   	list_for_each_entry_safe(dev, n, &port->destroy_list, disco_list=
_node) {
> > > >   		list_del_init(&dev->disco_list_node);
> > > > @@ -370,6 +361,16 @@ static void sas_destruct_devices(struct
> > > >   	}
> > > >   }
> > > >=20
> > > > +static void sas_destruct_ports(struct asd_sas_port *port)
> > > > +{
> > > > +	struct sas_port *sas_port, *p;
> > > > +
> > > > +	list_for_each_entry_safe(sas_port, p, &port->sas_port_del_list, d=
el_list) {
> > > > +		list_del_init(&sas_port->del_list);
> > > > +		sas_port_delete(sas_port);
> > > > +	}
> > > > +}
> > > > +
> > > >   void sas_unregister_dev(struct asd_sas_port *port, struct domain_=
device *dev)
> > > >   {
> > > >   	if (!test_bit(SAS_DEV_DESTROY, &dev->state) &&
> > > > @@ -384,7 +385,6 @@ void sas_unregister_dev(struct asd_sas_p
> > > >   	if (!test_and_set_bit(SAS_DEV_DESTROY, &dev->state)) {
> > > >   		sas_rphy_unlink(dev->rphy);
> > > >   		list_move_tail(&dev->disco_list_node, &port->destroy_list);
> > > > -		sas_discover_event(dev->port, DISCE_DESTRUCT);
> > > >   	}
> > > >   }
> > > >=20
> > > > @@ -490,6 +490,8 @@ static void sas_discover_domain(struct w
> > > >   		port->port_dev =3D NULL;
> > > >   	}
> > > >=20
> > > > +	sas_probe_devices(port);
> > > > +
> > > >   	SAS_DPRINTK("DONE DISCOVERY on port %d, pid:%d, result:%d\n", po=
rt->id,
> > > >   		    task_pid_nr(current), error);
> > > >   }
> > > > @@ -523,6 +525,10 @@ static void sas_revalidate_domain(struct
> > > >   		    port->id, task_pid_nr(current), res);
> > > >    out:
> > > >   	mutex_unlock(&ha->disco_mutex);
> > > > +
> > > > +	sas_destruct_devices(port);
> > > > +	sas_destruct_ports(port);
> > > > +	sas_probe_devices(port);
> > > >   }
> > > >=20
> > > >   /* ---------- Events ---------- */
> > > > @@ -578,10 +584,8 @@ void sas_init_disc(struct sas_discovery
> > > >   	static const work_func_t sas_event_fns[DISC_NUM_EVENTS] =3D {
> > > >   		[DISCE_DISCOVER_DOMAIN] =3D sas_discover_domain,
> > > >   		[DISCE_REVALIDATE_DOMAIN] =3D sas_revalidate_domain,
> > > > -		[DISCE_PROBE] =3D sas_probe_devices,
> > > >   		[DISCE_SUSPEND] =3D sas_suspend_devices,
> > > >   		[DISCE_RESUME] =3D sas_resume_devices,
> > > > -		[DISCE_DESTRUCT] =3D sas_destruct_devices,
> > > >   	};
> > > >=20
> > > >   	disc->pending =3D 0;
> > > > --- a/drivers/scsi/libsas/sas_expander.c
> > > > +++ b/drivers/scsi/libsas/sas_expander.c
> > > > @@ -1903,7 +1903,8 @@ static void sas_unregister_devs_sas_addr
> > > >   		sas_port_delete_phy(phy->port, phy->phy);
> > > >   		sas_device_set_phy(found, phy->port);
> > > >   		if (phy->port->num_phys =3D=3D 0)
> > > > -			sas_port_delete(phy->port);
> > > > +			list_add_tail(&phy->port->del_list,
> > > > +				&parent->port->sas_port_del_list);
> > > >   		phy->port =3D NULL;
> > > >   	}
> > > >   }
> > > > @@ -2111,7 +2112,7 @@ int sas_ex_revalidate_domain(struct doma
> > > >   	struct domain_device *dev =3D NULL;
> > > >=20
> > > >   	res =3D sas_find_bcast_dev(port_dev, &dev);
> > > > -	while (res =3D=3D 0 && dev) {
> > > > +	if (res =3D=3D 0 && dev) {
> > > >   		struct expander_device *ex =3D &dev->ex_dev;
> > > >   		int i =3D 0, phy_id;
> > > >=20
> > > > @@ -2123,9 +2124,6 @@ int sas_ex_revalidate_domain(struct doma
> > > >   			res =3D sas_rediscover(dev, phy_id);
> > > >   			i =3D phy_id + 1;
> > > >   		} while (i < ex->num_phys);
> > > > -
> > > > -		dev =3D NULL;
> > > > -		res =3D sas_find_bcast_dev(port_dev, &dev);
> > > >   	}
> > > >   	return res;
> > > >   }
> > > > --- a/drivers/scsi/libsas/sas_internal.h
> > > > +++ b/drivers/scsi/libsas/sas_internal.h
> > > > @@ -100,6 +100,7 @@ int sas_try_ata_reset(struct asd_sas_phy
> > > >   void sas_hae_reset(struct work_struct *work);
> > > >=20
> > > >   void sas_free_device(struct kref *kref);
> > > > +void sas_destruct_devices(struct asd_sas_port *port);
> > > >=20
> > > >   #ifdef CONFIG_SCSI_SAS_HOST_SMP
> > > >   extern int sas_smp_host_handler(struct Scsi_Host *shost, struct r=
equest *req,
> > > > --- a/drivers/scsi/libsas/sas_port.c
> > > > +++ b/drivers/scsi/libsas/sas_port.c
> > > > @@ -66,6 +66,7 @@ static void sas_resume_port(struct asd_s
> > > >   		rc =3D sas_notify_lldd_dev_found(dev);
> > > >   		if (rc) {
> > > >   			sas_unregister_dev(port, dev);
> > > > +			sas_destruct_devices(port);
> > > >   			continue;
> > > >   		}
> > > >=20
> > > > @@ -219,6 +220,7 @@ void sas_deform_port(struct asd_sas_phy
> > > >=20
> > > >   	if (port->num_phys =3D=3D 1) {
> > > >   		sas_unregister_domain_devices(port, gone);
> > > > +		sas_destruct_devices(port);
> > > >   		sas_port_delete(port->port);
> > > >   		port->port =3D NULL;
> > > >   	} else {
> > > > @@ -323,6 +325,7 @@ static void sas_init_port(struct asd_sas
> > > >   	INIT_LIST_HEAD(&port->dev_list);
> > > >   	INIT_LIST_HEAD(&port->disco_list);
> > > >   	INIT_LIST_HEAD(&port->destroy_list);
> > > > +	INIT_LIST_HEAD(&port->sas_port_del_list);
> > > >   	spin_lock_init(&port->phy_list_lock);
> > > >   	INIT_LIST_HEAD(&port->phy_list);
> > > >   	port->ha =3D sas_ha;
> > > > --- a/include/scsi/libsas.h
> > > > +++ b/include/scsi/libsas.h
> > > > @@ -87,10 +87,8 @@ enum discover_event {
> > > >   	DISCE_DISCOVER_DOMAIN   =3D 0U,
> > > >   	DISCE_REVALIDATE_DOMAIN,
> > > >   	DISCE_PORT_GONE,
> > > > -	DISCE_PROBE,
> > > >   	DISCE_SUSPEND,
> > > >   	DISCE_RESUME,
> > > > -	DISCE_DESTRUCT,
> > > >   	DISC_NUM_EVENTS,
> > > >   };
> > > >=20
> > > > @@ -274,6 +272,7 @@ struct asd_sas_port {
> > > >   	struct list_head dev_list;
> > > >   	struct list_head disco_list;
> > > >   	struct list_head destroy_list;
> > > > +	struct list_head sas_port_del_list;
> > > >   	enum   sas_linkrate linkrate;
> > > >=20
> > > >   	struct sas_work work;
> > > > --- a/include/scsi/scsi_transport_sas.h
> > > > +++ b/include/scsi/scsi_transport_sas.h
> > > > @@ -145,6 +145,7 @@ struct sas_port {
> > > >=20
> > > >   	struct mutex		phy_list_mutex;
> > > >   	struct list_head	phy_list;
> > > > +	struct list_head	del_list; /* libsas only */
> > > >   };
> > > >=20
> > > >   #define dev_to_sas_port(d) \
> > > >=20
> > > >=20
> > > > .
> > > >=20
> > >=20
> > >=20
>=20
>=20
--=20
Ben Hutchings
The generation of random numbers is too important to be left to chance.
                                                       - Robert Coveyou


--=-6ZqCaeeu7LgTUCbB0ekH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlslfT0ACgkQ57/I7JWG
EQmfLBAAhp7d6uKFeGZ2nqHacd+mEAf8e0zWDvdRlAmiy+/qdr1TC1IW59sRYDfS
P8aPsjsY5Yvo6oprJYjgFkrfFShUTdw3OSm9Sfb95PxRzUEZVIbevszr0/gOtFq4
NJT48XNJBvqcWk5mMpdm+lQDIvRLDpBXGdSmOYR3osgQyk6vUMY7X0JjsG976QBR
tQpU/ham0nYsX8EzJhOvJ8ukhT8N5RiAglRGYCaCySJZIVmFcgzDFcg+tSKFNnw6
Kl2L+cPkb2cshTR46T/hQbjU4CzWxByT+oxi1x9o8752UfEWRIMqPW6rI/64quFg
ywcmWQCyH+rjbJYQeyT10kouO0D10UmuYnBXVibmEakUSoiXnlxOqRMr013VBH4Q
x3V7/HQTqgua9bpeumwwzfGJGM2fV5thKBDurQKhYdAlq7eSxT9783Wx2GYDuabi
64x/pzDG99Nz75Y4Xm3PsNPI/s5hxq7FQgBC55RLb3iflkJSWjzStL9zKHRDT1fa
rlZ0J74Xip5Tl1L6ntwJYcmroPYeOgpsfXBdS7FBlCTf6p6zQK/8KLZWQEL5Ih3M
w0iQSAKxzMcDtgk+cstJktIR339oR9NwfO4GLuyZZrG3cP35wCbPsxaxdvJUz3Ht
ve9kuOeKXYb/7ZA9U98d7GvYmBtgimsjljDA36SwasLUjN/k4SY=
=AVeW
-----END PGP SIGNATURE-----

--=-6ZqCaeeu7LgTUCbB0ekH--
