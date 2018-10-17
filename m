Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PI_IMPORTANCE_HIGH,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F7B7ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 018B92150F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:02:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="XqDIySQk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 018B92150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbeJQU6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 16:58:00 -0400
Received: from mail-eopbgr720098.outbound.protection.outlook.com ([40.107.72.98]:14306
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727000AbeJQU57 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 16:57:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SXcFqi2DGlb+NoTXqSm+hFH43AuSlAJWNyzV2IY8apk=;
 b=XqDIySQkKzke0kWRyrD5hEHTiXIcseu9qni1qAbz/EoDMY6eoWv74A78oRKuAYuz07nZmwGLQSkxZ1lI5iZUFD9anO7M+YO3SS799sPgUKOxWWE956lJilSPQczHP2fuJleDNiSxZCvPJ9wBRqYug5AAVluv2+Tcw7WnI7dpA90=
Received: from DM5PR2101MB1013.namprd21.prod.outlook.com (52.132.133.35) by
 DM5PR2101MB1047.namprd21.prod.outlook.com (52.132.128.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.5; Wed, 17 Oct 2018 13:02:17 +0000
Received: from DM5PR2101MB1013.namprd21.prod.outlook.com
 ([fe80::8415:b182:814c:9124]) by DM5PR2101MB1013.namprd21.prod.outlook.com
 ([fe80::8415:b182:814c:9124%3]) with mapi id 15.20.1273.004; Wed, 17 Oct 2018
 13:02:17 +0000
From:   Haiyang Zhang <haiyangz@microsoft.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: RE: [PATCH 4.18 101/135] hv_netvsc: pair VF based on serial number
Thread-Topic: [PATCH 4.18 101/135] hv_netvsc: pair VF based on serial number
Thread-Index: AQHUZXPIE/St4iULVkCeltejmox0kaUiPMFwgADTXoCAAFVTAA==
Importance: high
X-Priority: 1
Date:   Wed, 17 Oct 2018 13:02:17 +0000
Message-ID: <DM5PR2101MB1013C986EEC151F096313D17CAFF0@DM5PR2101MB1013.namprd21.prod.outlook.com>
References: <20181016170515.447235311@linuxfoundation.org>
 <20181016170522.303317746@linuxfoundation.org>
 <DM5PR2101MB10138BCFD40D703FEE14EC35CAFE0@DM5PR2101MB1013.namprd21.prod.outlook.com>
 <20181017074629.GD25537@kroah.com>
In-Reply-To: <20181017074629.GD25537@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=haiyangz@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-10-17T13:02:15.5244767Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [96.61.92.94]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1047;6:CPZNFl2hGGsbybKdsUyhG8qxMsPfGKTwHbmfm0hAKsOEpY2WKmJDaj42/omce3TQUHZ5pYp9CQF/Y9xfGN+wfHPP6nTeVLsz+gwlh9JZWP6MPQZPzR+mLjDqXZTj9V9zQPjvkQuQqMhH+2LNPxtQ2/fpkbDPJ5CqBVyHLmzHntLYzrjbMTtd75jMZF4VLdVD3jJ6kg6JUz6vnqRle+DAmI+EJUydsjkwGwLXw0X96fv6oj1tHVDSQNfv447bwjfAvNKTG/KcCd4PncAQN0jbAZ0oaXDYj76+y5s632hN75CIGlzbQ3gN/Hlc6Z6ho/7fBJgU285C+qRrZsy/U+I1CfzHZ4wn6EndvUr89nWHeXkg8gVCnEub/zLfRCQVVGuLEPI4Npr4Y5NBSZaSl8ZK+tRHZkLV9QsAl9OOOqcnlf0LvEAY7r//l9Ichwq+SRlIA0JwZoe2XEG3mRC+KVbiww==;5:uhlA/LI5TehA0I+0qYznQzHzKqHfzUJVehpGrwSzQhMnF2xsp5CWPxDyCxcHtPLWGZJzESZJfgIX/S2hytZ5neKZDZIA8BCnAOtKoM+iDtlJxi1X5nPUopp5+yF4rhC/Dk6t8KlGZonSoIiacExl/8cYkoYx+bQrztAJ/LeBCQ0=;7:VUsH8xup+tbuGulSEL0OkOqEVk56BhaIvFLL0eseXK+xp7kiZIM5UUe5wM+RVVKjXHEDg5rmTk5p0XRX65DpHRL5zUeYsCf6kxHzipMv5zPyNMjTDOjPeNb/HwQeCZxgI9XrsZVuHszqo2SrDC1aVA==
x-ms-office365-filtering-correlation-id: cdc04b19-dea3-4111-c339-08d63430c420
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:DM5PR2101MB1047;
x-ms-traffictypediagnostic: DM5PR2101MB1047:
x-microsoft-antispam-prvs: <DM5PR2101MB10479F44A614D2B0D7762DA3CAFF0@DM5PR2101MB1047.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(219752817060721)(189930954265078)(84791874153150)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:DM5PR2101MB1047;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1047;
x-forefront-prvs: 08286A0BE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(136003)(396003)(346002)(376002)(189003)(199004)(40224003)(13464003)(86612001)(10090500001)(86362001)(575784001)(25786009)(106356001)(7736002)(6916009)(6436002)(2900100001)(229853002)(2906002)(33656002)(11346002)(6346003)(71190400001)(71200400001)(6506007)(93886005)(53546011)(10290500003)(66066001)(186003)(26005)(4326008)(68736007)(305945005)(102836004)(74316002)(97736004)(55016002)(478600001)(105586002)(14444005)(5250100002)(256004)(99286004)(3846002)(5660300001)(54906003)(966005)(8676002)(6246003)(6306002)(8990500004)(107886003)(6116002)(476003)(14454004)(486006)(316002)(8936002)(76176011)(81156014)(81166006)(53936002)(446003)(7696005)(81686011)(9686003)(22452003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1047;H:DM5PR2101MB1013.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=haiyangz@microsoft.com; 
x-microsoft-antispam-message-info: 9aQ6XpfCJANYAt0eniCeJKtxIe2donnjCDAdZJz+I5Y83ecHm0xtHWABLOLtTcPDpFgPrmIh89mfOa9W2AG2PYbQJvZ/W/d0+qFEgkM5G6IbiDKGRino0tMJG3wpvH7hp6LDAFOmf6tot+J+qXLol/hfyLu5vcKHMI1K4zAEJ0eRp954E//Gp2yoC15U7yllOJypq/A8tu3D3qzEYsLgo2eaB5j5fGTVxMaH7prjqZdbPJ+CWfySBY2+8twd9o6zqeVLFakr1JvJ/kvcN1MeN4Lsb6O2c5cz9NzIZMcJ58xfscxKplcZf7tQd4OjEJkeFyK0VZ+aQz3EjxlC4heAcbSFfgJ9r8TmSCUIVY99Um0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdc04b19-dea3-4111-c339-08d63430c420
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2018 13:02:17.1688
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1047
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Sent: Wednesday, October 17, 2018 3:46 AM
> To: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: linux-kernel@vger.kernel.org; stable@vger.kernel.org; Stephen Hemming=
er
> <sthemmin@microsoft.com>; David S. Miller <davem@davemloft.net>; Sasha
> Levin <Alexander.Levin@microsoft.com>
> Subject: Re: [PATCH 4.18 101/135] hv_netvsc: pair VF based on serial numb=
er
>=20
> On Tue, Oct 16, 2018 at 07:13:12PM +0000, Haiyang Zhang wrote:
> >
> >
> > > -----Original Message-----
> > > From: linux-kernel-owner@vger.kernel.org <linux-kernel-
> > > owner@vger.kernel.org> On Behalf Of Greg Kroah-Hartman
> > > Sent: Tuesday, October 16, 2018 1:06 PM
> > > To: linux-kernel@vger.kernel.org
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>;
> > > stable@vger.kernel.org; Stephen Hemminger <sthemmin@microsoft.com>;
> > > David S. Miller <davem@davemloft.net>; Sasha Levin
> > > <Alexander.Levin@microsoft.com>
> > > Subject: [PATCH 4.18 101/135] hv_netvsc: pair VF based on serial
> > > number
> > >
> > > 4.18-stable review patch.  If anyone has any objections, please let m=
e know.
> > >
> > > ------------------
> > >
> > > From: Stephen Hemminger <stephen@networkplumber.org>
> > >
> > > [ Upstream commit 00d7ddba1143623b31bc2c15d18216e2da031b14 ]
> > >
> > > Matching network device based on MAC address is problematic since a
> > > non VF network device can be creted with a duplicate MAC address
> > > causing confusion and problems.  The VMBus API does provide a serial
> > > number that is a better matching method.
> > >
> > > Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
> > > Signed-off-by: David S. Miller <davem@davemloft.net>
> > > Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > ---
> > >  drivers/net/hyperv/netvsc.c     |    3 ++
> > >  drivers/net/hyperv/netvsc_drv.c |   58 ++++++++++++++++++++++-------=
-----
> -----
> > > -
> > >  2 files changed, 36 insertions(+), 25 deletions(-)
> > >
> > > --- a/drivers/net/hyperv/netvsc.c
> > > +++ b/drivers/net/hyperv/netvsc.c
> > > @@ -1203,6 +1203,9 @@ static void netvsc_send_vf(struct net_de
> > >
> > >  	net_device_ctx->vf_alloc =3D nvmsg->msg.v4_msg.vf_assoc.allocated;
> > >  	net_device_ctx->vf_serial =3D nvmsg->msg.v4_msg.vf_assoc.serial;
> > > +	netdev_info(ndev, "VF slot %u %s\n",
> > > +		    net_device_ctx->vf_serial,
> > > +		    net_device_ctx->vf_alloc ? "added" : "removed");
> > >  }
> > >
> > >  static  void netvsc_receive_inband(struct net_device *ndev,
> > > --- a/drivers/net/hyperv/netvsc_drv.c
> > > +++ b/drivers/net/hyperv/netvsc_drv.c
> > > @@ -1794,20 +1794,6 @@ out_unlock:
> > >  	rtnl_unlock();
> > >  }
> > >
> > > -static struct net_device *get_netvsc_bymac(const u8 *mac) -{
> > > -	struct net_device_context *ndev_ctx;
> > > -
> > > -	list_for_each_entry(ndev_ctx, &netvsc_dev_list, list) {
> > > -		struct net_device *dev =3D hv_get_drvdata(ndev_ctx-
> > > >device_ctx);
> > > -
> > > -		if (ether_addr_equal(mac, dev->perm_addr))
> > > -			return dev;
> > > -	}
> > > -
> > > -	return NULL;
> > > -}
> > > -
> > >  static struct net_device *get_netvsc_byref(struct net_device *vf_net=
dev)  {
> > >  	struct net_device_context *net_device_ctx; @@ -1936,26 +1922,48
> @@
> > > static void netvsc_vf_setup(struct work_
> > >  	rtnl_unlock();
> > >  }
> > >
> > > +/* Find netvsc by VMBus serial number.
> > > + * The PCI hyperv controller records the serial number as the slot.
> > > + */
> > > +static struct net_device *get_netvsc_byslot(const struct net_device
> > > +*vf_netdev) {
> > > +	struct device *parent =3D vf_netdev->dev.parent;
> > > +	struct net_device_context *ndev_ctx;
> > > +	struct pci_dev *pdev;
> > > +
> > > +	if (!parent || !dev_is_pci(parent))
> > > +		return NULL; /* not a PCI device */
> > > +
> > > +	pdev =3D to_pci_dev(parent);
> > > +	if (!pdev->slot) {
> > > +		netdev_notice(vf_netdev, "no PCI slot information\n");
> > > +		return NULL;
> > > +	}
> > > +
> > > +	list_for_each_entry(ndev_ctx, &netvsc_dev_list, list) {
> > > +		if (!ndev_ctx->vf_alloc)
> > > +			continue;
> > > +
> > > +		if (ndev_ctx->vf_serial =3D=3D pdev->slot->number)
> > > +			return hv_get_drvdata(ndev_ctx->device_ctx);
> >
> > Greg,
> >
> > I had a fix to this patch. If not already, Could you include my followi=
ng fix
> together?
> > hv_netvsc: fix vf serial matching with pci slot info
> > https://na01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit.=
k
> > ernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fdavem%2Fnet-
> next.git%2F
> >
> commit%2F%3Fid%3D005479556197f80139771960dda0dfdcd2d2aad5&amp;da
> ta=3D02%
> >
> 7C01%7Chaiyangz%40microsoft.com%7C6ce194a47449435fe82a08d63404a94e
> %7C7
> >
> 2f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C636753591959679786&amp
> ;sdata
> >
> =3DReWYMZW%2FYtoFSbFSxny9VGw6V8v9J4sGanfJjbVd34A%3D&amp;reserved=3D
> 0
>=20
> I can not take a patch that is not "upstream" yet, sorry.
>=20
> Also, this really feels like a "new feature" to me.  Can someone explain =
what
> bug this is fixing?

Patch #A: hv_netvsc: pair VF based on serial number
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/=
?id=3D00d7ddba1143623b31bc2c15d18216e2da031b14

Patch #B: hv_netvsc: fix vf serial matching with pci slot info
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/=
?id=3D005479556197f80139771960dda0dfdcd2d2aad5

The patch #A is a feature that use VF serial number for matching. But #A ha=
s a bug causing mismatch.

Patch #B, upstream now (see the link to Linux-next), is a fix to #A.

So, if #A is ported to 4.18, we need to port #B together. Otherwise, not po=
rting both the #A and #B is also fine.

Thanks,
- Haiyang


